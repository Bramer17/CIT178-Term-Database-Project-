/* Chapter 9 lab assignment - Payton Bramer 

Task 1
Use Examples2;
SELECT LEN(Name) AS NameLength
FROM StringSample;

USE Examples2;
SELECT VendorName, VendorPhone
FROM Vendors
WHERE SUBSTRING(VendorPhone,2,3)=209
ORDER BY VendorName;

Task 2

USE Examples2;
Select *
FROM Vendors
WHERE VendorID=Ceiling(RAND( CHECKSUM( NEWID()))*123);

USE Examples2;
SELECT VendorID,ROUND(YTDPurchases,0) AS RoundedPurchases
FROM Vendors;

Task 3

USE Examples2;
SELECT VendorID, MONTH(LastTranDate) AS [Last Month Of transaction],Year(LastTranDate)AS [Last Year Of Transaction]
FROM Vendors;

SELECT GETDATE() AS [Time Of Query Creation];

Task 4

USE Examples2;
SELECT VendorID, VendorName,YTDPurchases,
CASE
WHEN YTDPurchases > 300 THEN 'Good' 
WHEN YTDPurchases < 300 THEN 'Bad'
ELSE 'We have yet to determine your stance'
END 
FROM Vendors;

USE Examples2;
SELECT InvestorID, FirstName, IIF(Investments>5000,'Good Investment','Not quite enough') As [Investor Status]
FROM Investors;

USE Examples2;
SELECT VendorID, VendorName, CHOOSE(MONTH(LastTranDate),'Winter','Winter', 'Spring','Spring','Spring','Summer','Summer','Summer','Autumn','Autumn','Autumn','Winter') 
AS [Last Transaction Date]
FROM Vendors
WHERE Year(LastTranDate)>2008
Order BY Year(LastTranDate);

Task 5
USE Examples2;
SELECT CASE 
		WHEN GROUPING(VendorZipCode)=1 THEN 'Zipcode total'
		ELSE VendorZipCode
		END AS VendorZipCode,
COUNT(*) AS QTYVendors
FROM Vendors
GROUP BY VendorZipCode WITH ROLLUP;

USE Examples2;
SELECT InvoiceID,ISNULL(InvoiceTotal,0.00) AS [Invoice Total]
FROM NullSample;*/












