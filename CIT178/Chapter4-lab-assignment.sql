/* Chapter 4 lab assignment Payton Bramer*/

/*Task #1
USE AP;
SELECT v.VendorName, v.VendorCity, inv.PaymentTotal
FROM Vendors AS v
JOIN Invoices AS inv ON inv.InvoiceID = v.VendorID
WHERE inv.PaymentTotal>50
ORDER BY inv.PaymentTotal DESC;

TASK #2
USE Northwind;
SELECT e.EmployeeID, e.City, e.PostalCode, o.ShipCountry,o.OrderDate
FROM Employees AS e 
LEFT JOIN Orders AS o ON e.EmployeeID = o.EmployeeID
WHERE City='London' AND ShipCountry='Switzerland'
ORDER BY e.EmployeeID DESC;

TASK#3
USE Northwind;
SELECT p.ProductName,p.Discontinued,s.CompanyName,s.Country,p.ReorderLevel
FROM Products AS p
RIGHT JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE s.Country='USA' OR s.Country='CANADA'
ORDER BY p.ReorderLevel;

TASK #4
USE WideWorldImporters;
SELECT so.Quantity,so.UnitPrice, o.OrderDate, o.ExpectedDeliveryDate,
(so.Quantity * so.UnitPrice) AS 'Final Price'
FROM sales.OrderLines AS so
FULL Join sales.OrderLines AS S ON S.OrderLineID = so.OrderLineID
FULL JOIN Sales.Orders AS o ON so.OrderID = s.OrderID
Where so.UnitPrice>100 And so.Quantity>70
ORDER BY 'Final Price' DESC;


TASK#5
USE WideWorldImporters;
SELECT Quantity, UnitPrice, Sales.Orders.OrderDate,Sales.Orders.ExpectedDeliveryDate
FROM sales.OrderLines
Join Sales.Orders On Sales.Orders.OrderID = Sales.OrderLines.OrderID
Where UnitPrice>13
UNION
SELECT Quantity, UnitPrice, Sales.Orders.OrderDate,Sales.Orders.ExpectedDeliveryDate
FROM sales.OrderLines
Join Sales.Orders On Sales.Orders.OrderID = Sales.OrderLines.OrderID
Where UnitPrice>20
Order By UnitPrice;

TASK #6
USE WideWorldImporters;
SELECT Quantity, UnitPrice, Sales.Orders.OrderDate,Sales.Orders.ExpectedDeliveryDate
FROM sales.OrderLines
Join Sales.Orders On Sales.Orders.OrderID = Sales.OrderLines.OrderID
Where UnitPrice Like '%13%'
EXCEPT
SELECT Quantity, UnitPrice, Sales.Orders.OrderDate,Sales.Orders.ExpectedDeliveryDate
FROM sales.OrderLines
Join Sales.Orders On Sales.Orders.OrderID = Sales.OrderLines.OrderID
Where UnitPrice Like '%20%'
Order By UnitPrice;*/ 








