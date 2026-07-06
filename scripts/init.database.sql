/*
====================================================================
Create Database and Schemas
====================================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after
    checking whether it already exists.

    If the database exists, it will be dropped and recreated.
    The script also creates the required schemas within the database:
    'bronze', 'silver', and 'gold'.

WARNING:
    Running this script will permanently delete the existing
    'DataWarehouse' database if it already exists.

    Make sure you have a valid backup before executing this script
    in a production environment.
====================================================================
*/

use master
  go
---drop and recreate the 'data warehouse' database
if Exists ( select 1 from sys.databases  where name ="Data WareHouse"
Begin
  Alter database Data WareHouse set single_user with rollback immediate;
  Drop database Data aWareHouse;
    End;

  -- Create DB "Data Warehouse"
Create database Data WareHouse;
use Data WareHouse; 
go
--Create Schemas
create schema bronze ;
go
create schema silver ;
  go
create schema gold;
go
