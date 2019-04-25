/* Final Project Views Payton Bramer 

USE FakeBusiness;
GO

--Updatable view--
CREATE VIEW ProductInfo
AS 
SELECT ProductID, ProductName,PackageType, Price
FROM Products;
GO 

SELECT * FROM ProductInfo;

--Updating---
UPDATE ProductInfo
SET Price=10
WHERE ProductID=2003;

SELECT * FROM ProductInfo;

--Create new view--
CREATE VIEW OrderInfo
AS 
SELECT OrderItemID, OrdeDate, ShipDate, QuantitySold
FROM Orders join OrderItems on Orders.OrderID = OrderItems.OrderID;

SELECT * FROM OrderInfo;

--Create view---
CREATE VIEW SupplierProducts
AS 
SELECT SupplierID, CompanyName, ContactName, ProductName, Price
FROM Products Join Supplier ON Products.ProductID=Supplier.ProductID;

SELECT * FROM SupplierProducts;

--Create View--
CREATE VIEW CustomerInfo
AS 
SELECT CustomerID, FirstName, LastName
FROM Customers;

SELECT * FROM CustomerInfo;*/





