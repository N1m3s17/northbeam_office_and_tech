CREATE OR ALTER PROCEDURE bronze.load_bronze AS
    BEGIN
        BEGIN TRY
            PRINT '===========================================================================';
            PRINT 'Loading data into bronze.inventory_feed_raw table...';
            PRINT '===========================================================================';                   
            TRUNCATE TABLE bronze.inventory_feed_raw;
            BULK INSERT bronze.inventory_feed_raw
            FROM 'C:\Users\Semin\Desktop\Projects\Northbeam Office & Tech\data\inventory_feed_raw.csv'
            WITH (
                FORMAT = 'CSV',
                FIRSTROW = 2,
                FIELDTERMINATOR = ',', -- Uses Tabs instead of Commas
                ROWTERMINATOR = '\n',
                TABLOCK
            );  
            PRINT 'Data loaded into bronze.inventory_feed_raw table.';
            
            PRINT '===========================================================================';
            PRINT 'Loading data into bronze.marketing_spend_raw table...';
            PRINT '===========================================================================';                   
            TRUNCATE TABLE bronze.marketing_spend_raw;
            BULK INSERT bronze.marketing_spend_raw
            FROM 'C:\Users\Semin\Desktop\Projects\Northbeam Office & Tech\data\marketing_spend_raw.csv'
            WITH (
                FORMAT = 'CSV',
                FIRSTROW = 2,
                FIELDTERMINATOR = ',', -- Uses Tabs instead of Commas
                ROWTERMINATOR = '\n',
                TABLOCK
            );  
            PRINT 'Data loaded into bronze.marketing_spend_raw table.';


            PRINT '===========================================================================';
            PRINT 'Loading data into bronze.sales_export_full_raw table...';
            PRINT '===========================================================================';                   
            TRUNCATE TABLE bronze.sales_export_full_raw;
            BULK INSERT bronze.sales_export_full_raw
            FROM 'C:\Users\Semin\Desktop\Projects\Northbeam Office & Tech\data\sales_export_full_raw.csv'
            WITH (
                FORMAT = 'CSV',
                FIRSTROW = 2,
                FIELDTERMINATOR = ',', -- Uses Tabs instead of Commas
                ROWTERMINATOR = '\n',
                TABLOCK
            );  
            PRINT 'Data loaded into bronze.sales_export_full_raw table.';


            PRINT '===========================================================================';
            PRINT 'Loading data into bronze.sales_targets_raw table...';
            PRINT '===========================================================================';                   
            TRUNCATE TABLE bronze.sales_targets_raw;
            BULK INSERT bronze.sales_targets_raw
            FROM 'C:\Users\Semin\Desktop\Projects\Northbeam Office & Tech\data\sales_targets_raw.csv'
            WITH (
                FORMAT = 'CSV',
                FIRSTROW = 2,
                FIELDTERMINATOR = ',', -- Uses Tabs instead of Commas
                ROWTERMINATOR = '\n',
                TABLOCK
            );  
            PRINT 'Data loaded into bronze.sales_targets_raw table.';

        END TRY
        BEGIN CATCH
            PRINT 'Error occurred while loading data into bronze_superstore table.';
            PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
            PRINT 'Error Message: ' + ERROR_MESSAGE(); 
            THROW;
        END CATCH
    END;