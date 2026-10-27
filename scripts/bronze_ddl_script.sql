IF OBJECT_ID('bronze.inventory_feed_raw', 'U') IS NOT NULL
    DROP TABLE bronze.inventory_feed_raw;

CREATE TABLE bronze.inventory_feed_raw (
    snapshot_date NVARCHAR(MAX),
    sku NVARCHAR(MAX),
    qty_received NVARCHAR(MAX),
    qty_sold NVARCHAR(MAX),
    qty_on_hand NVARCHAR(MAX),
    qty_backordered NVARCHAR(MAX),
    reorder_point NVARCHAR(MAX),
    stockout NVARCHAR(MAX),
    inventory_value NVARCHAR(MAX)
);

IF OBJECT_ID('bronze.marketing_spend_raw', 'U') IS NOT NULL
    DROP TABLE bronze.marketing_spend_raw;

CREATE TABLE bronze.marketing_spend_raw (
    month_start NVARCHAR(MAX),
    channel NVARCHAR(MAX),
    spend NVARCHAR(MAX),
    impressions NVARCHAR(MAX),
    clicks NVARCHAR(MAX)
);

IF OBJECT_ID('bronze.sales_export_full_raw', 'U') IS NOT NULL
    DROP TABLE bronze.sales_export_full_raw;

CREATE TABLE bronze.sales_export_full_raw (
    order_id NVARCHAR(MAX),
    order_datetime NVARCHAR(MAX),
    ship_date NVARCHAR(MAX),
    order_status NVARCHAR(MAX),
    channel NVARCHAR(MAX),
    payment_method NVARCHAR(MAX),
    shipping_cost NVARCHAR(MAX),
    customer_id NVARCHAR(MAX),
    customer_first_name NVARCHAR(MAX),
    customer_last_name NVARCHAR(MAX),
    email NVARCHAR(MAX),
    segment NVARCHAR(MAX),
    customer_province NVARCHAR(MAX),
    customer_city NVARCHAR(MAX),
    acquisition_channel NVARCHAR(MAX),
    signup_date NVARCHAR(MAX),
    loyalty_member NVARCHAR(MAX),
    preferred_store_id NVARCHAR(MAX),
    store_id NVARCHAR(MAX),
    store_name NVARCHAR(MAX),
    store_type NVARCHAR(MAX),
    store_province NVARCHAR(MAX),
    store_city NVARCHAR(MAX),
    store_opeh_date NVARCHAR(MAX),
    store_size_sqft NVARCHAR(MAX),
    employee_id NVARCHAR(MAX),
    employee_name NVARCHAR(MAX),
    employee_role NVARCHAR(MAX),
    employee_hire_date NVARCHAR(MAX),
    employee_termination_date NVARCHAR(MAX),
    promotion_id NVARCHAR(MAX),
    promotion_name NVARCHAR(MAX),
    promo_start_date NVARCHAR(MAX),
    promo_end_date NVARCHAR(MAX),
    promo_discount_pct NVARCHAR(MAX),
    promo_category_scope NVARCHAR(MAX),
    promo_type NVARCHAR(MAX),
    order_item_id NVARCHAR(MAX),
    product_id NVARCHAR(MAX),
    product_name NVARCHAR(MAX),
    category NVARCHAR(MAX),
    subcategory NVARCHAR(MAX),
    brand NVARCHAR(MAX),
    supplier_id NVARCHAR(MAX),
    supplier_name NVARCHAR(MAX),
    supplier_country NVARCHAR(MAX),
    supplier_lead_time_days NVARCHAR(MAX),
    product_list_price NVARCHAR(MAX),
    product_standard_cost NVARCHAR(MAX),
    product_launch_date NVARCHAR(MAX),
    product_discounted_date NVARCHAR(MAX),
    quantity NVARCHAR(MAX),
    unit_price NVARCHAR(MAX),
    discount_pct NVARCHAR(MAX),
    line_total NVARCHAR(MAX),
    unit_cost NVARCHAR(MAX),
    return_id NVARCHAR(MAX),
    return_date NVARCHAR(MAX),
    return_quantity NVARCHAR(MAX),
    return_reason NVARCHAR(MAX),
    refund_amount NVARCHAR(MAX)
);

IF OBJECT_ID('bronze.sales_targets_raw', 'U') IS NOT NULL
    DROP TABLE bronze.sales_targets_raw;

CREATE TABLE bronze.sales_targets_raw (
    month NVARCHAR(MAX),
    store_name NVARCHAR(MAX),
    target_revenue NVARCHAR(MAX)
);