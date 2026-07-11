if object_id('bronze.crm_cust_info','u') is not null
begin
    truncate table bronze.crm_cust_info;
    drop table bronze.crm_cust_info;
end
create table bronze.crm_cust_info(
    cst_id              int,
    cst_key             nvarchar(50),
    cst_firstname       nvarchar(50),
    cst_lastname        nvarchar(50),
    cst_marital_status  nvarchar(50),
    cst_gndr            nvarchar(50),
    cst_create_date     date
   
);

if object_id('bronze.crm_prd_info','u') is not null
begin
    truncate table bronze.crm_prd_info;
    drop table bronze.crm_prd_info;
end
create table bronze.crm_prd_info(
    prd_id              int,
    prd_key             nvarchar(50),
    prd_nm              nvarchar(50),
    prd_cost            int,
    prd_line            nvarchar(50),
    prd_start_dt        datetime,
    prd_end_dt          datetime
    )
);

if object_id('bronze.crm_sales_details','u') is not null
begin
    truncate table bronze.crm_sales_details;
    drop table bronze.crm_sales_details;
end
create table bronze.crm_sales_details(
    sls_ord_nm          nvarchar(50),
    sls_prd_key         nvarchar(50),
    sls_cust_id         int,
    sls_order_dt        int,
    sls_ship_dt         int,
    sls_due_dt          int,
    sls_sales           int,
    sls_quantity        int,
    sls_price           int
    
);

if object_id('bronze.erb_cust_az12','u') is not null
begin
    truncate table bronze.erb_cust_az12;
    drop table bronze.erb_cust_az12;
end
create table bronze.erb_cust_az12(
    cid                 nvarchar,
    bdate               date,
    gen                 nvarchar(50)
);

if object_id('bronze.erb_loc_a101','u') is not null
begin
    truncate table bronze.erb_loc_a101;
    drop table bronze.erb_loc_a101;
end
create table bronze.erb_loc_a101(
    cid                 nvarchar(50),
    cntry               nvarchar(50)

);

if object_id('bronze.erb_px_cat_glv2','u') is not null
begin
    truncate table bronze.erb_px_cat_glv2;
    drop table bronze.erb_px_cat_glv2;
end
create table bronze.erb_px_cat_glv2(
    id                  nvarchar(50),
    cat                 nvarchar(50),
    subcat              nvarchar(50),
    maintenance         nvarchar(50)
    
);
