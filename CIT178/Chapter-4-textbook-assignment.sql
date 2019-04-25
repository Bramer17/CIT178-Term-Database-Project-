/* Task # 1
USE AP;
SELECT InvoiceNumber, VendorName
FROM Vendors
JOIN Invoices ON Vendors.VendorID = Invoices.VendorID; 

Task #2 
USE AP;
SELECT i.InvoiceNumber, v.VendorName
FROM Vendors AS v
JOIN Invoices AS i ON v.VendorID = i.VendorID;

USE AP;
SELECT i.InvoiceNumber, li.InvoiceLineItemAmount,li.InvoiceLineItemDescription,i.InvoiceDate
FROM Invoices AS i 
Join InvoiceLineItems AS li
ON i.InvoiceID = li. InvoiceID
WHERE li.AccountNo = 540
ORDER BY i.InvoiceDate;

Task #3
USE AP;
SELECT v.vendorName, i.InvoiceNumber, i.InvoiceTotal
FROM Vendors AS v
Left JOIN Invoices AS i 
ON v.VendorID = i.VendorID 
ORDER BY v.VendorName;

USE Examples2;
SELECT d.DeptName, d.DeptNo, e.LastName
FROM Departments AS d 
LEFT JOIN Employees AS e
ON d.DeptNo = e.DeptNo;

Task #4
USE Examples2;
SELECT d.DeptName, d.DeptNo, e.LastName
FROM Departments AS d 
Right JOIN Employees AS e
ON d.DeptNo = e.DeptNo;

Task #5
USE Examples2;
SELECT d.DeptName, d.DeptNo, e.LastName
FROM Departments AS d 
FULL JOIN Employees AS e
ON d.DeptNo = e.DeptNo;

USE Examples2;
SELECT d.DeptName, d.DeptNo, e.LastName
FROM Departments AS d 
INNER JOIN Employees AS e
ON d.DeptNo = e.DeptNo;

Task #6
SELECT DISTINCT v1.VendorName, v1.VendorCity, v1.VendorState
FROM Vendors AS v1 
join Vendors As v2
ON (v1.VendorCity = v2.VendorCity) AND (v1.VendorState = v2.VendorState) AND (v1.VendorID= v2.VendorID)
ORDER BY v1.VendorState, v1.VendorCity;

SELECT DISTINCT v1.VendorName, v1.VendorCity, v1.VendorState
FROM Vendors AS v1
ORDER BY v1.VendorState, v1.VendorCity;

Task #7
USE Examples2;
SELECT 'Active' AS Source, InvoiceNumber, InvoiceTotal
FROM ActiveInvoices
WHERE InvoiceDate > '02/01/2016'
UNION
SELECT 'Paid' AS Source, InvoiceNumber, InvoiceTotal
FROM PaidInvoices
WHERE InvoiceDate > '02/01/2016'
ORDER BY InvoiceTotal DESC;

Task #8 
USE Northwind;
SELECT CITY FROM Customers
INTERSECT
SELECT CITY FROM Suppliers
ORDER BY CITY;

USE Examples2;
SELECT CustomerFirst, CustomerLast FROM Customers
INTERSECT
SELECT FirstName, LastName FROM Employees;

USE Examples2;
SELECT CustomerFirst, CustomerLast FROM Customers
EXCEPT
SELECT FirstName, LastName FROM Employees;

Task #9

USE Examples2;
SELECT LastName, ProjectNo, DeptName
FROM Employees
LEFT JOIN Projects ON Employees.EmployeeID = Projects.EmployeeID
JOIN Departments ON Departments.DeptNo = Employees.DeptNo;

Task #10

USE Examples2;
SELECT Departments.DeptNo, DeptName, EmployeeID, LastName 
FROM Departments
CROSS JOIN Employees
ORDER BY Departments.DeptNo;*/
























