/*
==========================================================
stored procedure : load bronze layer (source-->bronze)
--------------------------------------------------
script purpose :
this stored procedursn loads data into the 'bronze' schema from external csv files.
it uses the bulk insert command to loads data from csv to bronze tables.
Parameters:
    None.
  _This stored proceduresdoesn't accept any parameters or return any values 
Usage examples :
   Exec bronze.load_bronze;
==========================================================
*/

CREATE PROCEDURE bronze.load_bronze AS
BEGIN

    DECLARE
        @start_time DATETIME,
        @end_time DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY

        SET @batch_start_time = GETDATE();

        PRINT '------------------------------';
        PRINT 'loading bronze layer';
        PRINT '------------------------------';

        SET @start_time = GETDATE();

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        BULK INSERT bronze.erb_cust_az12
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        BULK INSERT bronze.erb_loc_a101
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        BULK INSERT bronze.erb_px_cat_g1v2
        FROM 'C:\Users\M2h\OneDrive\Desktop\data warehouse\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>>>load duration:'
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';

        SET @batch_end_time = GETDATE();

        PRINT 'total load duration :'
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR)
            + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT '------------------------------';
        PRINT 'errors occured';
        PRINT 'error message ' + ERROR_MESSAGE();
        PRINT 'error message ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'error message ' + CAST(ERROR_STATE() AS NVARCHAR);

    END CATCH

END;
