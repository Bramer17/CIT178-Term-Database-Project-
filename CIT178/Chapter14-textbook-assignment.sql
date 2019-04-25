/*Chapter 14 textbook assignment Payton Bramer

Task 1 

USE AP;
DECLARE @BigVendors table (VendorID int, VendorName varchar(50));
INSERT @BigVendors SELECT VendorID, VendorName
FROM Vendors
WHERE VendorID IN(SELECT VendorID FROM Invoices WHERE InvoiceTotal > 5000);

select * FROM @BigVendors;

USE AP;
DECLARE @MaxInvoice money, @MinInvoice money;
DECLARE @InvoiceCount int, @VendorIDVar int;
SET @VendorIDVar =95;
SELECT @MinInvoice = MIN(InvoiceTotal), @MaxInvoice = MAX(InvoiceTotal), @InvoiceCount = COUNT(*)
FROM Invoices
WHERE VendorID =@VendorIDVar;
PRINT 'Number of Invoices:'+ CONVERT(varchar, @InvoiceCount) +'.';
PRINT 'Maximum invoice is $' + CONVERT(varchar, @MaxInvoice,1) + '.';
PRINT 'Minimum invoice is $' + CONVERT(varchar, @MinInvoice,1) + '.';

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal-PaymentTotal-CreditTotal AS 'Balance'
INTO ##UnpaidInvoice
FROM Invoices
WHERE InvoiceTotal-PaymentTotal-CreditTotal >0
ORDER BY Balance;

SELECT * FROM ##UnpaidInvoice;

CREATE TABLE #Employee(
	ID int PRIMARY KEY,
	FName varchar(50),
	LName varchar(50),
	SalaryType int);
INSERT #Employee VALUES (1,'Fred','Flinstone',1);
INSERT #Employee VALUES (2,'Barney','Rubble',2);
INSERT #Employee VALUES (3,'Wilma','Flinstone',3);
SELECT ID,FName,LName,CHOOSE(SalaryType, 'Hourly','Salary','Piecerate','Monthly','Biweekly','Yearly') FROM #Employee;

--Derived Tables
USE Northwind;
SELECT derivedTable.CustomerID,derivedTable.TotalSales
FROM (SELECT CustomerID, SUM(UnitPrice*Quantity) AS TotalSales
		FROM [Order Details] JOIN Orders ON [Order Details].OrderID = Orders.OrderID
		GROUP BY CustomerID) AS derivedTable;

--Temporary Tables
USE Northwind;
SELECT ##customers.CustomerID, ##customers.TotalSales
FROM (SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalSales
FROM [Order Details] JOIN Orders ON [Order Details].OrderID = Orders.OrderID 
GROUP BY CustomerID) AS ##customers;

--Views
USE Northwind;
GO
CREATE VIEW VM_Customer AS
(SELECT CustomerID, SUM([Order Details].UnitPrice * [Order Details].Quantity) AS TotalSales
FROM [Order Details] JOIN Orders ON [Order Details].OrderID = Orders.OrderID 
GROUP BY CustomerID);
GO
SELECT*FROM VM_Customer;

--Table variables 
USE Northwind;
DECLARE @customer TABLE (CustomerID nvarchar(5), TotalSales money);
INSERT @customer SELECT Orders.CustomerID, TotalSales = SUM([Order Details].UnitPrice * [Order Details].Quantity) 
FROM [Order Details] JOIN Orders ON [Order Details].OrderID = Orders.OrderID 
GROUP BY Orders.CustomerID;

SELECT * FROM @customer;

Task 2

IF OBJECT_ID('InvoiceCopy') IS NOT NULL 
    DROP TABLE InvoiceCopy;

IF OBJECT_ID('tempdb..##customers') IS NOT NULL 
    DROP TABLE ##customers;

USE AP;
IF OBJECT_ID('Products') IS NOT NULL
BEGIN
    PRINT 'Product exists in AP';
    SELECT Count(ProductID) AS 'AP Products' FROM Products;
END;
ELSE
    PRINT 'Product does not exist in AP';

USE Northwind;
IF OBJECT_ID('Products') IS NOT NULL
BEGIN
    PRINT 'Product exists in Northwind';
    SELECT Count(ProductID) AS 'Northwind Products' FROM Products;
END;
ELSE
    PRINT 'Product does not exist in Northwind';

--Declaring Number and Total Variables
DECLARE @Number INT = 1 ;
DECLARE @Total INT = 0 ;

-- Increasing the total variable using a loop and counter value
WHILE @Number < = 10
BEGIN
    SET @Total = @Total + @Number;
    SET @Number = @Number + 1 ;
END
PRINT @Total;

USE Northwind;
GO
--Declare Counter variable 
DECLARE @Counter INT=1;
--Declaring the cursor
DECLARE rowCursor CURSOR FOR 
	SELECT OrderID, ProductID, UnitPrice*Quantity AS 'Total Price'
	FROM [Order Details]
	WHERE UnitPrice*Quantity>100
	ORDER BY 'Total Price' DESC;
OPEN rowCursor;
FETCH NEXT FROM rowCursor;
WHILE @@FETCH_STATUS=0
	BEGIN 
		FETCH NEXT FROM rowCursor;
		SET @Counter =@Counter+1;
		IF @Counter>10
			BREAK;
		ELSE
			CONTINUE;
	END;
CLOSE rowCursor;
DEALLOCATE rowCursor;

SELECT * FROM MASTER.dbo.sysdatabases;

DECLARE @name VARCHAR(50);
DECLARE @path VARCHAR(256);
DECLARE @fileName VARCHAR(256);
DECLARE @fileDate VARCHAR(20);

SET @path = 'C:\temp\';

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112);

DECLARE db_cursor CURSOR FOR 
	SELECT name 
	FROM MASTER.dbo.sysdatabases
	WHERE name NOT IN ('master','model','msdb','tempdb');

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @name;

WHILE @@FETCH_STATUS=0
	BEGIN
		SET @fileName = @path + @name + '_' + @fileDate + '.BAK'
		BACKUP DATABASE @name TO DISK = @fileName

		FETCH NEXT FROM db_cursor INTO @name
	END;
CLOSE db_cursor;
DEALLOCATE db_cursor;

Task 3

USE AP;
BEGIN TRY
    SELECT 1/0;
END TRY
BEGIN CATCH
    PRINT 'You have generated an error'
    PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) + ': ' + ERROR_MESSAGE();
    PRINT 'The severity of the error is: ' + CONVERT(varchar,ERROR_SEVERITY(),10);
END CATCH;
SELECT * FROM Invoices;

USE AP;
BEGIN TRY
    IF OBJECT_ID('Produce') IS NOT NULL 
        SELECT TOP 10 * FROM Produce; 
    ELSE
        Print 'The Produce Table does NOT exist';
    IF OBJECT_ID('Products') IS NOT NULL
        SELECT TOP 10 * FROM Products ORDER BY ProductName;
    ELSE
        Print 'The Products Table does NOT exist';
    IF OBJECT_ID ('Invoices') IS NOT NULL
        SELECT TOP 10 * FROM Invoices ORDER BY InvoiceTotal;
    ELSE
        Print 'The Invoices Table does NOT exist';
    IF OBJECT_ID('Vendors') IS NOT NULL
        SELECT TOP 10 * FROM Vendors ORDER BY VendorName;
    ELSE
        Print 'The Vendors Table does NOT exist';
    IF OBJECT_ID('AccountsPayable') IS NOT NULL
        SELECT TOP 10 * FROM AccountsPayable ORDER BY AmoutDue;
    ELSE
        Print 'The AccountsPayable Table does NOT exist';
    IF OBJECT_ID('FixedAssets') IS NOT NULL
        SELECT TOP 10 * FROM FixedAssets ORDER BY ExpireDt;
    ELSE
        Print 'The FixedAsset Table does NOT exist';
END TRY
BEGIN CATCH
    PRINT 'You have generated an error';
    PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) + ': ' + ERROR_MESSAGE();
    PRINT 'The severity of the error is: ' + CONVERT(varchar,ERROR_SEVERITY(),10);
END CATCH;

USE AP;
BEGIN TRY 
    INSERT Invoices VALUES (799, 'ZXK-799', '2016-05-07', 299.95, 0, 0, 1, '2016-06-06', NULL);
    PRINT 'SUCCESS: Record was inserted.'; 
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.'; PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) + ': ' + ERROR_MESSAGE();
END CATCH;
BEGIN TRY 
    INSERT Invoices VALUES(122,'abc-123','2018-02-02',599.99,0,200,2,'2018-03-02',NULL);
    PRINT 'SUCCESS: Record was inserted.'; 
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.'; PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) + ': ' + ERROR_MESSAGE();
END CATCH;

USE AP;
--Remove old InvoiceCopy table if one exists
BEGIN TRY
    DROP TABLE #InvoiceCopy
END TRY
BEGIN CATCH
    PRINT ' The table does not exist'
END CATCH

SELECT * INTO #InvoiceCopy FROM Invoices
DECLARE InvCursor CURSOR FOR SELECT * FROM #InvoiceCopy
OPEN InvCursor;
FETCH NEXT FROM InvCursor
WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE #InvoiceCopy SET InvoiceTotal = InvoiceTotal + (InvoiceTotal * .06) 
        PRINT 'Total has been updated'
        FETCH NEXT FROM InvCursor
    END
CLOSE InvCursor
DEALLOCATE InvCursor;

Task 4

USE AP;
--Remove old InvoiceCopy table if one exists
BEGIN TRY
    DROP TABLE #InvoiceCopy
END TRY
BEGIN CATCH
    PRINT ' The table does not exist'
END CATCH

SELECT * INTO #InvoiceCopy FROM Invoices
DECLARE InvCursor CURSOR FOR SELECT * FROM #InvoiceCopy
OPEN InvCursor;
FETCH NEXT FROM InvCursor
WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE #InvoiceCopy SET InvoiceTotal = InvoiceTotal + (InvoiceTotal * .06) 
        PRINT 'Total has been updated'
        FETCH NEXT FROM InvCursor
        IF @@ROWCOUNT=0
            PRINT 'Warning: No rows were updated';
    END
CLOSE InvCursor
DEALLOCATE InvCursor;

USE AP; 
DECLARE @MyIdentity int, @MyRowCount int;

INSERT Vendors (VendorName, VendorAddress1, VendorCity, VendorState, VendorZipCode, VendorPhone, DefaultTermsID, DefaultAccountNo)
VALUES ('Peerless Binding', '1112 S Windsor St', 'Hallowell', 'ME', '04347', '(207) 555-1555', 4, 400);

SET @MyIdentity = @@IDENTITY; 
SET @MyRowCount = @@ROWCOUNT;
IF @MyRowCount = 1
    INSERT Invoices VALUES (@MyIdentity, 'BA-0199', '2016-05-01', 4598.23, 0, 0, 4, '2016-06-30', NULL);
ELSE
    PRINT 'The row was not inserted into Invoices';*/




