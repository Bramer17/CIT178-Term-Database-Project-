/* Task 1

USE AP;
GO 
-- Updatable view
CREATE VIEW VI_view
AS
SELECT VendorName, InvoiceNumber, InvoiceDate,InvoiceTotal
FROM Vendors
JOIN Invoices On Vendors.VendorID = Invoices.VendorID;
GO
-- Limited View
CREATE VIEW VI_Limited_view
AS
SELECT VendorName, InvoiceNumber, InvoiceDate,InvoiceTotal
FROM Vendors
JOIN Invoices On Vendors.VendorID = Invoices.VendorID
WITH CHECK OPTION;
GO 

SELECT * FROM VI_Limited_view;
SELECT * FROM VI_view;

GO
CREATE VIEW OutstandingInvoices (Invoice#, Date, Total, Balance)
AS 
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,InvoiceTotal - PaymentTotal - CreditTotal 
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
GO
SELECT * FROM OutstandingInvoices;

USE AP;
GO 
CREATE VIEW Vendors_SW
AS
SELECT * FROM Vendors
WHERE VendorState IN ('CA','AZ','NV','NM');
GO
SELECT * FROM Vendors_SW;

Task 2

UPDATE VI_View
SET InvoiceDate=GETDATE()
WHERE VendorName='IBM';

USE AP;
GO
CREATE VIEW VendorPayment
AS 
SELECT VendorName, InvoiceNumber, InvoiceDate, PaymentDate, InvoiceTotal, CreditTotal, PaymentTotal
FROM Invoices
JOIN Vendors ON Invoices.VendorID=Vendors.VendorID
WHERE InvoiceTotal-PaymentTotal-CreditTotal>0;
GO 
SELECT * FROM VendorPayment;

USE AP;
GO
UPDATE VendorPayment
SET PaymentDate=GETDATE();
GO
UPDATE VendorPayment 
SET PaymentTotal = 19351.18, PaymentDate = '2016-04-02' 
WHERE VendorName = 'Malloy Lithographing Inc' AND InvoiceNumber = '0-2436';
GO
SELECT * FROM VendorPayment;

USE AP;
GO 
INSERT INTO Vendors_SW(VendorName,VendorCity,VendorState, VendorZipCode,DefaultTermsID,DefaultAccountNo)
VALUES('Kookies Kandies','San Jose','CA',95035,2,572);

USE AP;
SELECT * FROM Vendors_SW
WHERE VendorName='Internal Revenue Service';

DELETE FROM Vendors_SW
WHERE VendorName='Internal Revenue Service';

Task 3

USE AP;
GO
ALTER VIEW Vendors_SW 
AS 
SELECT * FROM Vendors
WHERE VendorState IN ('CA','AZ','NV','NM','UT','CO');

USE AP;
GO
DROP VIEW OutstandingInvoices;

Task 4

SELECT [name], create_date,modify_date FROM sys.views;

SELECT [name], create_date,modify_date, [type_desc] FROM sys.key_constraints;*/