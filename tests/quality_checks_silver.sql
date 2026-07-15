/*
===========================================================
Quality Checks
===========================================================

Script Purpose:
This script performs various quality checks for data consistency, accuracy,
and standardization across the 'silver' schemas. It includes checks for:
- Null or duplicate primary keys.
- Unwanted spaces in string fields.
- Data standardization and consistency.
- Invalid date ranges and orders.
- Data consistency between related fields.

Usage Notes:
- Run these checks after data loading Silver Layer.
- Investigate and resolve any discrepancies found during the checks.
*/


/*
===========================================================
Checking 'bronze.crm_cust_info'
===========================================================
*/
--check nulls or duplicates in pk
select cst_id,
count(*)
from bronze.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null

-- check unwnetd spaces
select cst_key
from bronze.crm_cust_info
where cst_key != ltrim(rtrim(cst_key))

---data standarization
select
    distinct cst_material as cst_marital_status
from bronze.crm_cust_info


/*
===========================================================
Checking 'silver.crm_prd_info'
===========================================================
*/
--check nulls or duplicates in pk
select prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is null

-- check unwnated spaces
select prd_nm
from silver.crm_prd_info
where prd_nm != ltrim(rtrim(prd_nm))

--data standarization
select
    distinct prd_line
from silver.crm_prd_info

--check for invalid date orders
select
    *
from silver.crm_prd_info
where prd_end_dt < prd_start_dt


/*
===========================================================
Checking 'silver.crm_sales_details'
===========================================================
*/
-- check for invalid date
select
nullif(sls_order_dt,0) as sls_order_dt
from bronze.crm_sales_details
where sls_order_dt<>0
or len(sls_order_dt)!=8
or sls_order_dt>20500101
or sls_order_dt<19000101

-- check for invalid date orders
select *
from silver.crm_sales_details
where sls_order_dt<=sls_ship_dt or sls_order_dt>sls_due_dt

-- data consistency : between sales , quantity and price
-- sales = quantity * price
select distinct
    sls_sales,
    sls_quantity,
    sls_price
from silver.crm_sales_details
where sls_sales != sls_price*sls_quantity
or sls_sales is null or sls_quantity is null or sls_price is null
order by sls_sales, sls_quantity, sls_price

select * from silver.crm_sales_details


/*
===========================================================
Checking 'bronze.erb_cust_az12'
===========================================================
*/
--identify out-of-range date
select
bdate
from bronze.erb_cust_az12
where bdate > getdate() or bdate<'1926-01-01'

---data consistency & standardization
select distinct
case when upper(ltrim(rtrim(gen))) in ('M','Male') then 'Male'
     when upper(ltrim(rtrim(gen))) in ('Female','F') then 'Female'
     else 'unknown'
end as gender
from bronze.erb_cust_az12

select * from silver.erb_cust_az12
select * from bronze.erb_cust_az12


/*
===========================================================
Checking 'bronze.erb_loc_a101'
===========================================================
*/
--- handle invalid values
select
replace (cid,'-','') as cid,
cntry
from bronze.erb_loc_a101
where replace (cid,'-','') not in (select cst_key from silver.crm_cust_info)

--- data standarization
select distinct
cntry
from silver.erb_loc_a101
order by cntry

select * from silver.erb_loc_a101
select * from bronze.erb_loc_a101
