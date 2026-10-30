IF OBJECT_ID('silver.inventory_clean', 'U') IS NOT NULL
    DROP TABLE silver.inventory_clean;

CREATE TABLE silver.inventory_clean (
    snapshot_date date,
    sku nvarchar(10),
    qty_received int,
    received_imputed int,
    qty_sold int,
    qty_on_hand int,
    qty_backordered int,
    reorder_point int,
    stockout_flag int,
    inventory_value decimal(10, 2)
);

IF OBJECT_ID('silver.sales_targets_clean', 'U') IS NOT NULL
    DROP TABLE silver.sales_targets_clean;

CREATE TABLE silver.sales_targets_clean (
    month_start date,
    store_name nvarchar(500),
    target_revenue decimal(10, 2)
);