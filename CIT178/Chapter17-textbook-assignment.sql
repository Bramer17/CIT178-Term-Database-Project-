/* Task 1

CREATE DATABASE Test;
GO
USE Test;
GO
SELECT * INTO Employees FROM Examples2.dbo.Employees;
SELECT * INTO Departments FROM Examples2.dbo.Departments;
SELECT * INTO Customers FROM Examples2.dbo.Customers;
SELECT * INTO SalesReps FROM Examples2.dbo.SalesReps;
SELECT * INTO SalesTotals FROM Examples2.dbo.SalesTotals;
SELECT * INTO Invoices FROM Examples2.dbo.Invoices;
SELECT * INTO PaidInvoices FROM Examples2.dbo.PaidInvoices;
SELECT * INTO Investors FROM Examples2.dbo.Investors;

CREATE LOGIN SierraAndrews WITH PASSWORD='XYZ12345', DEFAULT_DATABASE=Test;

CREATE LOGIN LucyLing WITH PASSWORD='XYZ12346', DEFAULT_DATABASE=Test;
CREATE LOGIN PeterSullivan WITH PASSWORD='XYZ12347', DEFAULT_DATABASE=Test;

BEGIN TRY
    BEGIN TRANSACTION
        ALTER LOGIN SierraAndrews WITH NAME=sierra;
        ALTER LOGIN LucyLing WITH NAME=ling;
        ALTER LOGIN PeterSullivan WITH NAME=peter;
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'There was an error altering logins';
    PRINT ERROR_MESSAGE();
END CATCH

DROP LOGIN sierra;

Task 2

CREATE SCHEMA Sales;
GO
CREATE SCHEMA Employees;
GO

USE Test;
GO
ALTER SCHEMA Sales TRANSFER dbo.SalesReps;
ALTER SCHEMA Sales TRANSFER dbo.SalesTotals;
ALTER SCHEMA Sales TRANSFER dbo.Customers;
ALTER SCHEMA Sales TRANSFER dbo.PaidInvoices;
ALTER SCHEMA Sales TRANSFER dbo.Invoices;

ALTER SCHEMA Employees TRANSFER dbo.Employees;
ALTER SCHEMA Employees TRANSFER dbo.Departments;
ALTER SCHEMA Employees TRANSFER dbo.Investors;

CREATE USER ling WITH DEFAULT_SCHEMA = Employees;
GO
CREATE USER peter WITH DEFAULT_SCHEMA = Sales;

GRANT SELECT,INSERT,UPDATE, DELETE ON Sales.Customers
TO Peter;

GRANT SELECT,INSERT,UPDATE, DELETE 
ON SCHEMA::Sales
TO Peter;

REVOKE UPDATE,DELETE
ON SCHEMA::Sales
TO Peter;

GRANT CREATE TABLE,CREATE VIEW, CREATE PROCEDURE, CREATE FUNCTION, CREATE SCHEMA 
TO ling;

CREATE LOGIN chris WITH PASSWORD='##LFJ23920', DEFAULT_DATABASE=Test;

ALTER SERVER ROLE securityadmin ADD MEMBER chris;

SELECT * FROM sys.server_principals;
SELECT * FROM sys.server_role_members;
SELECT * FROM sys.database_principals;*/
