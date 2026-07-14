/*
===========================================================
Stored Procedure : Load Bronze Layer (Source → Bronze)
===========================================================

Purpose:
- Load raw data from external CSV files into Bronze schema.
- Acts as the staging layer before Silver transformations.

Source: External CSV files
Target: Bronze schema tables
Parameters: None
Returns: None

Usage:
    EXECUTE bronze.load_bronze;

===========================================================
*/

IF OBJECT_ID('bronze.load_bronze','P') IS NOT NULL
    DROP PROCEDURE bronze.load_bronze;
GO

CREATE PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '--- Starting Bronze Layer Load ---';

        -----------------------------------------------------------------------
        -- Load CRM Customer Info
        -----------------------------------------------------------------------
        PRINT 'Loading bronze.crm_cust_info...';
        SET @start_time = GETDATE();

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\cust_info.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);

        SET @end_time = GETDATE();
        PRINT 'bronze.crm_cust_info Loaded. Duration: ' 
              + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 's';

        -----------------------------------------------------------------------
        -- Load CRM Product Info
        -----------------------------------------------------------------------
        PRINT 'Loading bronze.crm_prd_info...';
        SET @start_time = GETDATE();

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\prd_info.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);

        SET @end_time = GETDATE();
        PRINT 'bronze.crm_prd_info Loaded. Duration: ' 
              + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 's';

        -----------------------------------------------------------------------
        -- Load CRM Sales Details
        -----------------------------------------------------------------------
        PRINT 'Loading bronze.crm_sales_details...';
        SET @start_time = GETDATE();

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\sales_details.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);

        SET @end_time = GETDATE();
        PRINT 'bronze.crm_sales_details Loaded. Duration: ' 
              + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 's';

        -----------------------------------------------------------------------
        -- Load ERP Customer Info
        -----------------------------------------------------------------------
        PRINT 'Loading bronze.erb_cust_az12...';
        SET @start_time = GETDATE();

        BULK INSERT bronze.erb_cust_az12
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\CUST_AZ12.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);

        SET @end_time = GETDATE();
        PRINT 'bronze.erb_cust_az12 Loaded. Duration: ' 
              + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 's';

        -----------------------------------------------------------------------
        -- Load ERP Location Info
        -----------------------------------------------------------------------
        PRINT 'Loading bronze.erb_loc_a101...';
        SET @start_time = GETDATE();

        BULK INSERT bronze.erb_loc_a101
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\LOC_A101.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);

        SET @end_time = GETDATE();
        PRINT 'bronze.erb_loc_a101 Loaded. Duration: ' 
              + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 's';

        -----------------------------------------------------------------------
        -- Load ERP Product Categories
        -----------------------------------------------------------------------
        PRINT 'Loading bronze.erb_px_cat_g1v2...';
        SET @start_time = GETDATE();

        BULK INSERT bronze.erb_px_cat_g1v2
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\PX_CAT_G1V2.csv'
        WITH (FIRSTROW=2, FIELDTERMINATOR=',', TABLOCK);

        SET @end_time = GETDATE();
        PRINT 'bronze.erb_px_cat_g1v2 Loaded. Duration: ' 
              + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 's';

        -----------------------------------------------------------------------
        -- Total Execution Time
        -----------------------------------------------------------------------
        SET @batch_end_time = GETDATE();
        PRINT '--- Bronze Layer Load Completed ---';
        PRINT 'Total Duration: ' 
              + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 's';
    END TRY

    BEGIN CATCH
        PRINT '*** ERROR OCCURRED DURING BRONZE LOAD ***';
        PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
