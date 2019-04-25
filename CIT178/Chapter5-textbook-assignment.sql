/* Task 1 
USE AP;
SELECT MIN(InvoiceTotal - PaymentTotal-CreditTotal) AS MinimumDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal-CreditTotal >0;

USE ProductOrders;
SELECT MIN(UnitPrice) AS 'Minimum Unit Price'
FROM Items;

Task 2 

USE AP;
SELECT MIN(InvoiceTotal - PaymentTotal-CreditTotal) AS MinimumDue,
 MAX(InvoiceTotal - PaymentTotal-CreditTotal) AS MaximumDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal-CreditTotal >0;

USE Examples2;
SELECT MAX(SalesTotal) AS 'Highest Sales', MIN(SalesTotal) AS 'Lowest Sales'
FROM SalesTotals;

Task 3

USE Examples2;
SELECT COUNT(CUSTID) AS 'Illinois Customers'
FROM Customers
WHERE CustState = 'IL';

USE AP;
SELECT MIN(VendorName) AS FirstVendor, MAX(VendorName) AS LastVendor,
COUNT(VendorName) AS NumberofVendors
FROM Vendors;

USE Examples2;
SELECT COUNT(*) AS 'All Customers'
FROM Customers;

USE Examples2;
SELECT COUNT(InvestorID) AS [Number of Investors],MAX(NetGain) AS [ Max Net Gain],MIN(NetGain) AS [Min Net Gain]
FROM Investors;

Task 4

USE Examples2;
SELECT COUNT(InvestorID) AS [Number of Investors],MAX(NetGain) AS [ Max Net Gain],MIN(NetGain) AS [Min Net Gain],
AVG(NetGain) AS [Average Gain]
FROM Investors;

Task 5

USE AP;
SELECT SUM(InvoiceTotal) AS 'Total Invoices'
FROM Invoices 
WHERE InvoiceDate > '2016-03-01';

USE AP;
SELECT COUNT(DISTINCT VendorID) AS '#Vendors', COUNT(VendorID) AS '#Invoices',AVG(InvoiceTotal) AS 'Invoice Average',SUM(InvoiceTotal) AS 'Invoice Total'
FROM Invoices
WHERE InvoiceDate> '2015-09-01';
 
 Task 6

 USE AP;
 SELECT VendorID, AVG(InvoiceTotal) AS [Invoice Average]
 FROM Invoices
 GROUP BY VendorID 
 ORDER BY AVG(InvoiceTotal) DESC;

 USE AP;
 SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty, AVG(InvoiceTotal) AS InvoiceAvg
 FROM Invoices 
 JOIN Vendors ON Invoices.VendorID=Vendors.VendorID
 GROUP BY VendorState, VendorCity
 HAVING AVG(InvoiceTotal)>50
 ORDER BY VendorState, VendorCity;

 USE Examples2;
 SELECT SalesTotals.RepID, MAX(SalesTotal) AS 'High Sales', MIN(SalesTotal) AS 'Low Sales'
 FROM SalesTotals JOIN SalesReps ON SalesReps.RepID= SalesTotals.RepID
 GROUP BY SalesTotals.RepID
 HAVING MAX(SalesTotal)>500000 AND MIN(SalesTotal)>100000;

Task 7
 USE AP;
 SELECT VendorState,VendorName, COUNT(*) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceTotal
 FROM Invoices 
 JOIN Vendors ON Invoices.VendorID=Vendors.VendorID
 GROUP BY VendorState,VendorName WITH ROLLUP; 

 USE AP;
 SELECT VendorState,VendorCity,  COUNT(*) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceTotal
 FROM Invoices 
 JOIN Vendors ON Invoices.VendorID=Vendors.VendorID
 GROUP BY VendorState,VendorCity WITH CUBE; 

 USE AP;
 SELECT VendorState,VendorCity, COUNT(*) AS QtyVendors
 FROM Vendors
 --GROUP BY VendorState,VendorCity WITH ROLLUP
 --GROUP BY VendorState,VendorCity WITH CUBE
 GROUP BY GROUPING SETS(VendorState,(VendorState, VendorCity))
 ORDER BY VendorState DESC, VendorCity DESC;

 USE AP;
 SELECT VendorID,VendorState,
 COUNT(VendorID) OVER (Partition BY VendorState ORDER BY VendorState,VendorID) AS 'Total Vendors per State'
 FROM Vendors;

 USE AP;
 SELECT VendorID, VendorState,
 COUNT(VendorID) OVER (ORDER BY VendorState, VendorID) AS 'Total Vendors per State'
 FROM Vendors;*/







