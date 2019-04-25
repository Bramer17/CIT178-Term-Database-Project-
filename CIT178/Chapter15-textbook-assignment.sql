/* Task 1 

USE AP;
GO
CREATE PROC spInvoiceReport
AS 
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal-CreditTotal-PaymentTotal AS InvoiceAmtDue 
FROM Invoices JOIN Vendors
ON Invoices.VendorID = Vendors.VendorID 
WHERE InvoiceTotal-CreditTotal-PaymentTotal > 0 
ORDER BY VendorName;

GO
spInvoiceReport;
EXEC spInvoiceReport;

USE AP;
GO
ALTER PROC spInvoiceReport
WITH ENCRYPTION
AS
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal-CreditTotal-PaymentTotal AS InvoiceAmtDue 
FROM Invoices JOIN Vendors
ON Invoices.VendorID = Vendors.VendorID 
WHERE InvoiceTotal-CreditTotal-PaymentTotal > 0 
ORDER BY VendorName;

USE Northwind;
GO
CREATE PROC spFindCustomer
	@Company nvarchar(40)='%'
AS
BEGIN
	SELECT ContactName,Phone
	FROM Customers
	WHERE CompanyName LIKE @Company;
END 
GO
EXEC spFindCustomer 'Eastern%';
USE AP;
GO
CREATE PROC spVendorState
	@state varchar(20) = NULL 
AS 
BEGIN 
	IF @state IS NULL 
		SELECT * FROM Vendors;
	ELSE 
		SELECT * FROM Vendors
		WHERE VendorState = @state;
END
GO 
EXEC spVendorState;
EXEC spVendorState 'CA';

USE AP;
GO
CREATE PROC spVendorInvoices
	@DateVar smalldatetime = NULL, 
	@VendorVar varchar(40) = '%'
AS 
IF @DateVar IS NULL 
	SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;
DECLARE @InvCount int;
SELECT @InvCount = COUNT(InvoiceID)
FROM Invoices
JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND (VendorName LIKE @VendorVar);
RETURN @InvCount;
GO

DECLARE @InvCount int;
EXEC @InvCount = spVendorInvoices '2010-02-01', 'P%';
SELECT @InvCount AS 'Number of Invoices';
GO
DECLARE @InvCount int; 
EXEC @InvCount = spVendorInvoices '','A%'; 
PRINT 'Invoice count: ' + CONVERT(varchar, @InvCount);
GO

USE AP;
GO 
--Delete the procedure
IF OBJECT_ID('spVendorInvoices')IS NOT NULL 
	DROP PROC spVendorInvoices;
GO 

--Create the procedure
CREATE PROC spVendorInvoices
	@DateVar smalldatetime = NULL, 
	@VendorVar varchar(40) = '%',
	@VendorName varchar(40) OUTPUT 
AS 
IF @DateVar IS NULL 
	SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;
DECLARE @InvCount int;
SELECT @InvCount = COUNT(InvoiceID), @VendorName = VendorName 
FROM Invoices
JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND (VendorName LIKE @VendorVar)
GROUP BY VendorName;
RETURN @InvCount;
GO

--Run the procedure
DECLARE @VendorName varchar(40);
DECLARE @InvCount int;
EXEC @InvCount = spVendorInvoices '', 'A%', @VendorName OUTPUT 
SELECT @VendorName AS 'Vendor',@InvCount AS 'Number of Invoices'

USE AP;
GO 
--Delete the procedure
IF OBJECT_ID('spVendorInvoices')IS NOT NULL 
	DROP PROC spVendorInvoices;
GO 

--Create the procedure
CREATE PROC spVendorInvoices
	@DateVar smalldatetime = NULL, 
	@VendorVar varchar(40) = '%',
	@VendorName varchar(40) OUTPUT, 
	@VendorInvoiceDate smalldatetime OUTPUT 
AS 
BEGIN TRY
	IF @DateVar IS NULL 
		SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;
	DECLARE @InvCount int;
	SELECT @InvCount = COUNT(InvoiceID), @VendorName = VendorName, @VendorInvoiceDate = @DateVar
	FROM Invoices
	JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
	WHERE (InvoiceDate >= @DateVar) AND (VendorName LIKE @VendorVar)
	GROUP BY VendorName, InvoiceDate;
	RETURN @InvCount;
END TRY
BEGIN CATCH 
	PRINT 'An error occured.';
	PRINT 'Message: ' + CONVERT(varchar,ERROR_MESSAGE());
END CATCH
GO

--Run the procedure
DECLARE @VendorName varchar(40);
DECLARE @InvCount int;
DECLARE @VendorInvoiceDate smalldatetime;
EXEC @InvCount = spVendorInvoices '2010-01-01', 'M%', @VendorName OUTPUT, @VendorInvoiceDate OUTPUT 
SELECT @VendorName AS 'Vendor',@InvCount AS 'Number of Invoices', @VendorInvoiceDate AS 'Minimum Invoice Date';

USE Northwind;
GO
EXEC sp_helptext [Ten Most Expensive Products];
GO
EXEC sp_HelpText spFindCustomer;
GO

Task 2

USE AP;
GO
CREATE FUNCTION fnVendorID
    (@VendorName varchar(50))
    RETURNS int
BEGIN
    RETURN (SELECT VendorID FROM Vendors WHERE VendorName = @VendorName);
END;

SELECT InvoiceDate,InvoiceTotal
FROM Invoices
WHERE VendorID = dbo.fnVendorID('United Parcel Service');

USE Northwind;
GO 
CREATE FUNCTION fnProducts
	(@ProductID int)
	RETURNS table
RETURN 
	(SELECT * FROM Products WHERE @ProductID = Products.ProductID);

SELECT * FROM dbo.fnProducts(10);
SELECT * FROM dbo.fnProducts(20);
SELECT * FROM dbo.fnProducts(30);

Task 3

USE Northwind;
SELECT CustomerID,CompanyName,Country INTO TestCustomers
FROM Customers;

CREATE TABLE CustomerLogs(
    CustomerId nchar(5),
    status varchar(30)
);

CREATE TRIGGER TestCustomers_INSERT ON TestCustomers
    AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CustomerID nchar(5)
    SELECT @CustomerID =INSERTED.CustomerId
    FROM INSERTED

    INSERT INTO CustomerLogs
    VALUES(@CustomerId, 'Inserted')
END

INSERT INTO TestCustomers(CustomerID,CompanyName,Country) VALUES ('ABCWA','ABC Warehouse','USA');
INSERT INTO TestCustomers(CustomerID,CompanyName,Country) VALUES ('RAALO','Rainbows and Lollipops','USA');

SELECT * FROM CustomerLogs;

CREATE TRIGGER TestCustomers_DELETE ON TestCustomers
    AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CustomerID nchar(5)
    SELECT @CustomerID =DELETED.CustomerId
    FROM DELETED

    INSERT INTO CustomerLogs
    VALUES(@CustomerId, 'Deleted')
END

DELETE FROM TestCustomers WHERE CustomerID='AROUT';
DELETE FROM TestCustomers WHERE CustomerID='LAZYK';

SELECT * FROM CustomerLogs;

CREATE TRIGGER TestCustomers_UPDATE ON TestCustomers
    AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CustomerID nchar(5)
	DECLARE @Action varchar(50)

	SELECT @CustomerID = INSERTED.CustomerID
	FROM INSERTED 

	IF UPDATE(CustomerID)
		SET @Action = 'Updated ID'

	IF UPDATE(CompanyName)
		SET @Action = 'Updated Company'

	IF UPDATE(Country)
		SET @Action = 'Updated Country'

	INSERT INTO CustomerLogs
	VALUES (@CustomerID, @Action)
END

UPDATE TestCustomers SET CustomerID='RAINB' WHERE CustomerID = 'RAALO';
UPDATE TestCustomers SET CompanyName='Taste the Rainbow' WHERE CustomerID = 'RAINB';
UPDATE TestCustomers SET Country = 'England' WHERE CustomerID='ABCWA';

SELECT * FROM CustomerLogs;

CREATE TRIGGER TestCustomers_INSERT_UPDATE ON TestCustomers
AFTER INSERT,UPDATE
AS
UPDATE TestCustomers SET CustomerID = UPPER(CustomerID) 
WHERE CustomerID IN (SELECT CustomerID FROM INSERTED);

UPDATE TestCustomers SET CustomerID='Folk' WHERE CustomerID = 'FRANS';
UPDATE TestCustomers SET CustomerID='Shopp' WHERE CustomerID = 'LETSS';
INSERT INTO TestCustomers(CustomerID,CompanyName,Country) VALUES ('gamer','Gaming Emporium','USA');
GO
SELECT * FROM CustomerLogs;
SELECT * FROM TestCustomers;*/
