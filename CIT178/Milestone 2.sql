/*CREATE DATABASE FakeBusiness;

GO
USE FakeBusiness;
CREATE TABLE Employees(
	EmployeeID int NOT NULL,
	LastName varchar(30) NOT NULL,
	FirstName varchar(20) NOT NULL,
	BirthDate varchar (15),
	HireDate varchar (15),
	Title varchar (30),
	PRIMARY KEY(EmployeeID)
);
GO
CREATE TABLE Customers(
	CustomerID int NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	Address varchar(50),
	ZipCode varchar(10),
	PRIMARY KEY(CustomerID)
);
GO
CREATE TABLE Products(
	ProductID int NOT NULL,
	ProductName varchar(50) NOT NULL, 
	PackageType varchar(20) NOT NULL,
	Price money,
	PRIMARY KEY(ProductID)

);
GO 
CREATE TABLE Supplier(
	SupplierID int NOT NULL,
	CompanyName varchar(50) NOT NULL,
	ContactName varchar(30) NOT NULL,
	ProductID int NOT NULL,
	PRIMARY KEY(SupplierID)
);
GO
CREATE TABLE OrderItems(
	OrderItemID int NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	QuantitySold varchar(100) NOT NULL,
	PRIMARY KEY(OrderItemID)
);
GO 
CREATE TABLE Orders(
	OrderID int NOT NULL,
	CustomerID int NOT NULL, 
	EmployeeID int NOT NULL,
	OrdeDate varchar(15) NOT NULL,
	ShipDate varchar(15) NOT NULL,
	PRIMARY KEY(OrderID)
);

USE FakeBusiness;
GO;
ALTER TABLE Supplier WITH CHECK
ADD CONSTRAINT FK_ProductsID FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
ON UPDATE CASCADE
GO
ALTER TABLE OrderItems WITH CHECK 
ADD CONSTRAINT FK_ProductID FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
ON UPDATE CASCADE 
GO
ALTER TABLE OrderItems WITH CHECK
ADD CONSTRAINT FK_OrderID FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
ON UPDATE CASCADE
GO
ALTER TABLE Orders WITH CHECK 
ADD CONSTRAINT FK_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
ON UPDATE CASCADE
GO
ALTER TABLE Orders WITH CHECK 
ADD CONSTRAINT FK_EmployeeID FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
ON UPDATE CASCADE
GO 


CREATE INDEX idx_Product ON Supplier(ProductID);
GO
CREATE INDEX idx_Order ON OrderItems(OrderID);
GO
CREATE INDEX idx_Product ON OrderItems(ProductID);
GO
CREATE INDEX idx_Customer ON Orders(CustomerID);
GO
CREATE INDEX idx_Employee ON Orders(EmployeeID);



