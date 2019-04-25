/*Task 1
USE AP;
SELECT * INTO InvoiceCopy
FROM Invoices;

USE AP;
DROP TABLE InvoiceCopy;

SELECT InvoiceID, InvoiceNumber, InvoiceTotal INTO InvoiceCopy
FROM Invoices;

SELECT * FROM InvoiceCopy;

ALTER TABLE InvoiceCopy
ADD CONSTRAINT PK_ID PRIMARY KEY(InvoiceID);

Task 2 

SELECT InvoiceID, InvoiceDate,PaymentTotal,CreditTotal,InvoiceTotal INTO PaidInvoice
FROM Invoices
WHERE InvoiceTotal-PaymentTotal-CreditTotal=0;

SELECT * FROM PaidInvoice;

Task 3 

DROP DATABASE testDB;

CREATE DATABASE testDB;
USE testDB;
SELECT * INTO customers
FROM Northwind.dbo.Customers
WHERE 1=0;

ALTER TABLE customers
ADD CONSTRAINT PK_ID PRIMARY KEY(CustomerID);

TASK 4
INSERT INTO customers VALUES('abc123','ABC Warehouse','Frank Furter', 'General Manager', '100Ventura Blvd', 'Traverse City', 'MI','49696','USA','(231)-999-1234','NULL');
INSERT INTO customers(CustomerID,CompanyName)VALUES('xyz10','Berthas Bakery');
INSERT INTO customers VALUES 
('az99','Pappa Johns','Jenny Jones','General Manager','5 Airport Drive', 'Traverse City', 'MI','49696','USA','(231)-777-1234','NULL'),
('bb2','Costco','Erin Rodriguez','Manager','110 Airport Drive', 'Traverse City', 'MI','49696','USA','(231)-999-9999','NULL'),
('cbc44','TJ Maxx','Amy Juarez','General Manager','102 Ventura Blvd', 'Traverse City', 'MI','49696','USA','(231)-515-1234','NULL');

Task 5

INSERT INTO customers
SELECT * FROM Northwind.dbo.customers
WHERE Northwind.dbo.customers.Country='USA';

SELECT * FROM customers;

Task 6

USE testDB;
UPDATE customers
SET ContactName='Jill',ContactTitle='Owner', Address='123 Main Street',City='Traverse City',Region='MI',PostalCode='49696',Country='USA',Phone='(231)222-3333'
WHERE customerID='xyz10';

SELECT * FROM customers; 

ALTER TABLE customers
DROP COLUMN Fax;
ALTER TABLE customers
ADD email varchar(30) NULL;

USE testDB;

UPDATE customers
SET email='frainkie@abcwarehouse.com'
WHERE CustomerID='abc12';

UPDATE customers 
SET email='JYorres@stopnshop.net'
WHERE CustomerID='LETSS';

UPDATE customers
SET email='management@whiteclovermarkets.com'
WHERE CustomerID='WHITC';

UPDATE customers
SET email='bertha@berthasbakery.net'
WHERE CustomerID='xyz10';

UPDATE customers
SET email='bite@rattlesnakecanyon.com'
WHERE CustomerID='RATTC';

DELETE customers
WHERE Region='WY';

Task 7

SELECT * INTO ForeignCustomers
FROM Northwind.dbo.Customers AS NWC
WHERE NWC.Country<>'USA';

SELECT * FROM customers;
MERGE INTO customers AS C
USING ForeignCustomers AS FC ON C.CustomerID = FC.CustomerID
WHEN MATCHED THEN 
UPDATE SET 
C.CompanyName=FC.CompanyName,
C.ContactName=FC.ContactName,
C.ContactTitle=FC.ContactTitle,
C.Address=FC.Address,
C.City=FC.City,
C.Region=FC.Region, 
C.PostalCode=FC.PostalCode,
C.Country=FC.Country,
C.Phone=FC.Phone
WHEN NOT MATCHED THEN 
INSERT(CustomerID,CompanyName,ContactTitle,Address,City,Region,PostalCode,Country,Phone)
VALUES (FC.CustomerID,FC.CompanyName,FC.ContactTitle,FC.Address,FC.City,FC.Region,FC.PostalCode,FC.Country,FC.Phone);

SELECT * FROM customers;*/








