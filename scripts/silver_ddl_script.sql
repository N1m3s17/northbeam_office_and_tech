IF OBJECT_ID('silver.inventory_clean', 'U') IS NOT NULL
    DROP TABLE silver.inventory_clean;

CREATE TABLE silver.inventory_clean (
    snapshot_date date,
    sku NVARCHAR(10),
    qty_received INT,
    received_imputed INT,
    qty_sold INT,
    qty_on_hand INT,
    qty_backordered INT,
    reorder_point INT,
    stockout_flag INT,
    inventory_value DECIMAL(10, 2)
);