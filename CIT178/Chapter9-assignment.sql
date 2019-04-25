/* Task 1
USE AP;
SELECT VendorName,VendorContactLName +','+ LEFT(VendorContactFName,1)+ ',' AS ContactName, RIGHT(RTRIM(VendorPhone),8) AS Phone
FROM Vendors
WHERE SUBSTRING(VendorPhone,2,3)=559
ORDER BY VendorName;

--BEFORE CHANGES
USE Examples2;
SELECT Name 
FROM StringSample;

--AFTER CHANGES
USE Examples2;
SELECT Name, LEFT(Name, CHARINDEX(' ',Name) - 1) AS First, RIGHT(Name, LEN(Name) - CHARINDEX(' ',Name) ) AS Last 
FROM StringSample;

Task 2

USE Examples2;
SELECT *
FROM Investors
WHERE InvestorID =CEILING(RAND( CHECKSUM( NEWID())) * 5);

USE Examples2;
SELECT LastName, SUM(ROUND(Investments,0)) AS Investments, SUM(ROUND(NetGain,0)) AS GAIN, SUM(ROUND(Investments+NetGain,0)) AS TotalInvestment
FROM Investors 
GROUP BY LastName WITH ROLLUP

Task 3
USE Examples2;
Select VendorID, InvoiceID, MONTH(InvoiceDueDate) AS [MONTH DUE], DAY(InvoiceDueDate) AS [DAY DUE]
FROM ActiveInvoices;

USE Examples2;
SELECT * FROM DateSample
WHERE MONTH(StartDate)=10 AND DAY(StartDate)=28 AND YEAR(StartDate)=2011;

Task 4

USE AP;
SELECT InvoiceNumber, TermsID, 
CASE TermsID
WHEN 1 THEN 'Net due 10 days' 
WHEN 2 THEN 'Net due 20 days' 
WHEN 3 THEN 'Net due 30 days' 
WHEN 4 THEN 'Net due 40 days' 
WHEN 5 THEN 'Net due 50 days'
END AS Terms 
FROM Invoices;

USE AP;
INSERT INTO Invoices VALUES(10,'10000','2019-01-01',5000,200,0,5,'2019-04-01','2019-05-01');
INSERT INTO Invoices VALUES(20,'11000','2019-02-01',8000,200,0,5,'2019-03-01','2019-03-01');
INSERT INTO Invoices VALUES(30,'12000','2019-03-01',2000,200,0,5,'2019-03-01','2019-03-01');
INSERT INTO Invoices VALUES(40,'13000','2019-01-01',5000,200,0,5,'2019-04-01','2019-05-01');

USE AP;
SELECT InvoiceNumber, InvoiceTotal, InvoiceDate, InvoiceDueDate, 
CASE
WHEN DATEDIFF(day, InvoiceDueDate, GETDATE()) > 30 THEN 'Over 30 days past due'
WHEN DATEDIFF(day, InvoiceDueDate, GETDATE()) > 0 THEN '1 to 30 days past due'
ELSE 'Current' 
END AS Status
FROM Invoices 
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

USE Examples2;
SELECT VendorID, IIF(CreditTotal>500,'Premier','Normal') AS CustomerType
FROM ActiveInvoices;

USE Examples2;
SELECT VendorID, YTDPurchases,LastYTDPurchases,
IIF(LastYTDPurchases>YTDPurchases,'Red Flag',' ') AS [Need to Contact],
LEFT (VendorContactFName,1)+ '. ' + VendorContactLName AS Contact, 
LTRIM(RTRIM(VendorPhone))AS Phone
FROM Vendors
ORDER BY 'Need to Contact' DESC;

USE AP;
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, 
CHOOSE (TermsID, '10 days','20 days', '30 days', '60 days', '90 days') AS NetDue
FROM Invoices
WHERE InvoiceTotal- PaymentTotal - CreditTotal > 0;

USE Examples2;
SELECT EmployeeID,
CHOOSE (RIGHT(ProjectNo,1),'Marketing Call System', 'AP System', 'Warehouse Tracking','Salesrep Earnings','NA') AS ProjectName
FROM Projects;

USE Examples2
SELECT * FROM Wages;

Use Examples2;
SELECT emp_id,CAST( COALESCE(hourly_wage*40,salary,commission*num_sales)AS decimal(10,2))AS TotalSalary 
FROM wages
ORDER BY TotalSalary;

USE Examples2;
SELECT emp_id,CAST(ISNULL(hourly_wage,0.00) AS decimal(10,2)) AS Hourly, CAST(ISNULL(commission,0.00)AS decimal(10,2)) AS Commission,CAST(ISNULL(salary,0.00)AS decimal(10,2)) AS Salary
FROM Wages;

USE AP;
SELECT CASE 
		WHEN GROUPING(VendorState)=1 THEN 'State Total'
		ELSE VendorState
		END AS VendorState,
COUNT(*) AS QTYVendors
FROM Vendors
GROUP BY VendorState WITH ROLLUP;*/




