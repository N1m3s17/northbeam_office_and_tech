CREATE OR ALTER PROCEDURE silver.load_silver_inventory_clean
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        PRINT '===========================================================================';
        PRINT 'Loading data into silver.inventory_clean table...';
        PRINT '===========================================================================';

        TRUNCATE TABLE silver.inventory_clean;      -- semicolon matters: WITH must start a new statement

        WITH typed AS (
            SELECT
                COALESCE(TRY_CONVERT(date, TRIM(snapshot_date), 23),
                         TRY_CONVERT(date, TRIM(snapshot_date), 101),
                         TRY_CONVERT(date, TRIM(snapshot_date), 106)) AS snapshot_date,
                UPPER(TRIM(sku)) AS sku,
                TRY_CAST(NULLIF(REPLACE(TRIM(qty_received),    ',', ''), '') AS INT) AS qty_received,
                TRY_CAST(NULLIF(REPLACE(TRIM(qty_sold),        ',', ''), '') AS INT) AS qty_sold,
                TRY_CAST(NULLIF(REPLACE(TRIM(qty_on_hand),     ',', ''), '') AS INT) AS qty_on_hand,
                TRY_CAST(NULLIF(REPLACE(TRIM(qty_backordered), ',', ''), '') AS INT) AS qty_backordered,
                TRY_CAST(NULLIF(REPLACE(TRIM(reorder_point),   ',', ''), '') AS INT) AS reorder_point,
                CASE WHEN UPPER(TRIM(stockout)) IN ('Y','YES','1','TRUE')  THEN CAST(1 AS BIT)
                     WHEN UPPER(TRIM(stockout)) IN ('N','NO','0','FALSE')  THEN CAST(0 AS BIT)
                END AS stockout_flag,
                TRY_CAST(NULLIF(REPLACE(REPLACE(REPLACE(TRIM(inventory_value), ',', ''), '$', ''), 'CAD', ''), '') AS DECIMAL(10,2)) AS inventory_value
            FROM bronze.inventory_feed_raw
        ),
        deduped AS (
            SELECT snapshot_date, sku, qty_received, qty_sold, qty_backordered,
                   CASE WHEN qty_on_hand < 0 THEN NULL ELSE qty_on_hand END AS qty_on_hand,
                   reorder_point, stockout_flag, inventory_value
            FROM (
                SELECT *, ROW_NUMBER() OVER (
                           PARTITION BY sku, snapshot_date
                           ORDER BY CASE WHEN qty_received IS NULL THEN 1 ELSE 0 END) AS rn
                FROM typed
            ) t
            WHERE rn = 1
        ),
        calc AS (
            SELECT *,
                CASE WHEN qty_on_hand IS NOT NULL
                      AND qty_sold IS NOT NULL
                      AND qty_backordered = 0
                      AND LAG(qty_on_hand) OVER w IS NOT NULL
                      AND DATEDIFF(month, LAG(snapshot_date) OVER w, snapshot_date) = 1
                     THEN qty_on_hand + qty_sold - LAG(qty_on_hand) OVER w
                END AS candidate
            FROM deduped
            WINDOW w AS (PARTITION BY sku ORDER BY snapshot_date)
        )
        INSERT INTO silver.inventory_clean (
            snapshot_date, sku, qty_received, received_imputed, qty_sold,
            qty_on_hand, qty_backordered, reorder_point, stockout_flag, inventory_value
        )
        SELECT
            snapshot_date,
            sku,
            COALESCE(qty_received, CASE WHEN candidate >= 0 THEN candidate END),
            CASE WHEN qty_received IS NULL AND candidate >= 0 THEN 1 ELSE 0 END,
            qty_sold,
            qty_on_hand,
            qty_backordered,
            reorder_point,
            stockout_flag,
            inventory_value
        FROM calc;

        PRINT 'Rows loaded: ' + CAST(@@ROWCOUNT AS VARCHAR(10));   -- must come right after the INSERT
        PRINT 'Data loaded into silver.inventory_clean table.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while loading data into silver.inventory_clean table.';
        PRINT 'Error Number: '  + CAST(ERROR_NUMBER() AS VARCHAR(10));
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;