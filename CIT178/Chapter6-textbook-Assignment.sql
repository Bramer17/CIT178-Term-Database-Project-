/* Task 1
USE AP;
SELECT Vendors.VendorID, VendorName, VendorState 
FROM Vendors LEFT JOIN Invoices ON Vendors.VendorID = Invoices.VendorID 
WHERE Invoices.VendorID IS NULL;

USE AP;
SELECT Vendors.VendorID, VendorName, VendorState 
FROM Vendors
WHERE VendorID NOT IN 
			(SELECT DISTINCT VendorID FROM Invoices);

USE Northwind;
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY ProductID;

USE Examples2;
SELECT SalesReps.RepID, RepFirstName, RepLastName, SalesTotals.SalesTotal, SalesTotals.SalesYear
FROM SalesReps JOIN SalesTotals ON SalesReps.RepID = SalesTotals.RepID
WHERE SalesTotals.SalesTotal > (SELECT AVG(SalesTotal)FROM SalesTotals); 

Task 2 

USE Northwind;
SELECT ProductName
FROM Products
WHERE ProductID = ALL(SELECT ProductID FROM [Order Details] WHERE Quantity = 0);

USE Northwind;
SELECT ProductName, ProductID
FROM Products
WHERE ProductID = some
    (SELECT ProductID FROM [Order Details] 
    WHERE Quantity>100);

Task 3

USE AP;
SELECT DISTINCT VendorName,(SELECT MAX(InvoiceDate) 
							FROM Invoices JOIN Vendors ON Invoices.VendorID = Vendors.VendorID 
							WHERE Invoices.VendorID = Vendors.VendorID) AS [Most Recent Invoice]
FROM Vendors
ORDER BY [Most Recent Invoice]DESC;

USE Northwind;
SELECT Orders.CustomerID,MAX([Order Details].UnitPrice) AS 'Highest Price',
MAX([Order Details].Quantity) AS 'Highest Quantity',
AVG([Order Details]. UnitPrice) AS 'Average Price',
AVG([Order Details]. Quantity) AS 'Average Quantity'
FROM Orders,[Order Details]
GROUP BY CustomerID;

USE Northwind;
SELECT ProductName, UnitsOrdered = (SELECT SUM([Order Details].Quantity) 
									FROM [Order Details] 
									WHERE [Order Details].ProductID = Products.ProductID)
FROM Products;

Task 4

USE Northwind;
SELECT SupplierID, CompanyName, Phone
FROM Suppliers
WHERE EXISTS 
        (SELECT ProductName FROM Products 
        WHERE SupplierId = Suppliers.supplierId AND UnitPrice < 20);

USE AP;
SELECT VendorID, InvoiceNumber, InvoiceTotal 
FROM Invoices AS Inv_Main
WHERE InvoiceTotal > (SELECT AVG(InvoiceTotal) 
					  FROM Invoices AS Inv_Sub
					  WHERE Inv_sub.VendorID=Inv_main.VendorID)
ORDER BY VendorID, InvoiceTotal;

Task 5

USE AP;
WITH Summary AS (
    SELECT VendorState, VendorName, InvoiceTotal
    FROM Invoices JOIN Vendors ON Invoices.VendorID = Vendors.VendorID 
)
SELECT Summary.VendorState, Summary.VendorName, Summary.InvoiceTotal
FROM Summary 
WHERE Summary.InvoiceTotal > 1000
ORDER BY Summary.VendorState;

USE Northwind;
WITH Emp_CTE AS (
	SELECT EmployeeID, LastName, Region, ReportsTo
	FROM Employees
	WHERE ReportsTo IS NULL 
	UNION ALL 
	SELECT e.EmployeeID, e.LastName, e.Region, e.ReportsTo
	FROM Employees e
	INNER JOIN Emp_CTE ecte ON ecte.EmployeeID=e.ReportsTo
)
SELECT Emp_CTE.ReportsTo, COUNT(Emp_CTE.ReportsTo) AS 'Number of Employees'
FROM Emp_CTE
GROUP BY Emp_CTE.ReportsTo;*/


