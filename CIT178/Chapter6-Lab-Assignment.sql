/* Chapter 6 lab assignment - Payton Bramer

Task 1
USE TestCorp;
SELECT  [Order].CustomerId, Customer.LastName +''+ Customer.FirstName AS Customer, [Order].Id, [Order].OrderDate, MAX([Order].TotalAmount) AS 'Largest Total Amount'
FROM [Order] JOIN Customer ON [Order].CustomerId = Customer.Id
GROUP BY  [Order].OrderDate,CustomerId, [Order].Id,  Customer.LastName +''+ Customer.FirstName 
ORDER BY 'Largest Total Amount' DESC;
*/


/*USE TestCorp;
SELECT DISTINCT Country,City,
COUNT(City) OVER (Partition By City ORDER BY Country, City) AS [Customers Per City] 
FROM Customer
ORDER BY [Customers Per City] DESC;

USE TestCorp;
SELECT Customer.City, Customer.Country, Customer.Id, LastName, Supplier.Id, Supplier.CompanyName
From Customer Join Supplier on Customer.City=Supplier.City
Order BY Customer.City, Customer.Country, Customer.Id, LastName, Supplier.Id, Supplier.CompanyName desc;

Task #2 
 USE TestCorp;
 ALTER TABLE Product
 ADD onOrder int NULL;

use TestCorp;
UPDATE Product
SET onOrder = '100'
WHERE Product.Id='10';

use TestCorp;
UPDATE Product
SET onOrder = '200'
WHERE Product.Id='20';

use TestCorp;
UPDATE Product
SET onOrder = '300'
WHERE Product.Id='30';

use TestCorp;
UPDATE Product
SET onOrder = '400'
WHERE Product.Id='40';

USE TestCorp;
SELECT * 
FROM Product
Where onORDER >=100;

SELECT *
INTO ForeignCustomer
FROM Customer
WHERE Country<>'USA';

ALTER TABLE ForeignCustomer
ADD CONSTRAINT PK_ID PRIMARY KEY(id);

USE TestCorp;
ALTER TABLE ForeignCustomer
ADD CHECK (Country<>'USA');

Task #3

USE TestCorp; 
SELECT OrderNumber, OrderDate, ProductName, Count(UnitPrice.Quantity) AS 'Price'
FROM OrderItem
JOIN Product ON OrderItem.ProductId = Product.Id
JOIN Order ON OrderItem.OrderId = Order.Id
WHERE 'Price'> (SELECT AVG('Price') FROM OrderItem);

USE TestCorp;
SELECT FirstName, LastName, COUNT(Id) AS 'OrderCount'
FROM Customer
Join Order ON Customer.Id = Order.CustomerId;*/




/*USE TestCorp;
SELECT ProductName, Quantity
FROM Product Join OrderItem ON Product.Id = OrderItem.ProductId
WHERE ProductID = all (SELECT ProductID FROM Product WHERE Quantity > 100);


Task 4
USE TestCorp;
With ProductCTE AS
( SELECT ProductName, UnitPrice
FROM Product 
Where IsDiscontinued <> 1)
SELECT *
FROM ProductCTE
ORDER BY ProductName, UnitPrice;

USE TestCorp;
WITH CustomerCTE AS 
(SELECT LastName, FirstName,City,Country,Phone
FROM Customer
WHERE City ='London' OR City='Madrid' Or City='Paris')
SELECT * 
FROM CustomerCTE;*/
 