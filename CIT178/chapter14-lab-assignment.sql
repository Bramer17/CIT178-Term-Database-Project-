/* Chapter 14 lab assignment - Payton Bramer 

Task 1

USE Examples2;
DECLARE @MaxSalesDifference money
DECLARE @MaxReturnDifference money

SET @MaxSalesDifference =(SELECT MAX(YTDPurchases-LastYTDPurchases) FROM Vendors);
SET @MaxReturnDifference =(SELECT MAX(YTDReturns-LastYTDReturns) FROM Vendors);

PRINT 'Max Sales Difference is $' + CONVERT(varchar,@MaxSalesDifference,1) + '.';
PRINT 'Max Return Difference is $' + CONVERT(varchar,@MaxReturnDifference,1) + '.';

USE Examples2;
DECLARE @BigSales table (RepID int, RepFirstName varchar(50));
INSERT @BigSales SELECT RepID, RepFirstName FROM SalesReps
WHERE RepID in(SELECT RepID FROM SalesTotals WHERE SalesTotal > 500000);
SELECT * FROM @BigSales;

Task 2

--Local Temporary Table 
SELECT TOP 1 VendorID, AVG(YTDPurchases) AS AvgPurchases
INTO #TopPurchases
FROM Vendors
GROUP BY VendorID
Order BY AvgPurchases DESC;

SELECT * FROM #TopPurchases;

--Local Global Table 

SELECT AccountNo, LastTranDate, YTDPurchases-YTDReturns AS 'Profit'
INTO ##YTDProfit
FROM Vendors
WHERE YTDPurchases-YTDReturns >0
ORDER BY Profit;

SELECT * FROM ##YTDProfit;

Task 3

USE Examples2;
IF OBJECT_ID('VendorPhone') IS NOT NULL
BEGIN
    PRINT 'Vendor Phone exists in Example 2';
    SELECT VendorPhone AS 'Example 2 phone' FROM Vendors;
END;
ELSE
    PRINT 'Product does not exist in examples 2';

USE Examples2;
IF OBJECT_ID('Vendors') IS NOT NULL
BEGIN
    PRINT 'Vendors exists in Example 2';
    SELECT Count(VendorID) AS 'Examples 2 Vendors' FROM Vendors;
END;
ELSE
    PRINT 'Vendor does not exist in Example 2';

USE Examples2;
IF OBJECT_ID('Investors') IS NOT NULL
BEGIN
    PRINT 'Investors exists in Examples 2';
    SELECT Count(InvestorID) AS 'Examples 2 Investors' FROM Investors;
END;
ELSE
    PRINT 'Investors does not exist in Examples 2';

USE pubs;
IF OBJECT_ID('dbo.sales') IS NOT NULL
BEGIN
    PRINT 'Sales exists in pubs';
    SELECT Count(stor_id) AS 'pubs sales' FROM dbo.sales;
END;
ELSE
    PRINT 'Sales does not exist in pubs';

Task 4

SELECT * INTO #SampleCopy FROM [Sample]
DECLARE Sample_Cursor CURSOR FOR SELECT * FROM #SampleCopy
OPEN Sample_Cursor;
FETCH NEXT FROM Sample_Cursor
WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE #SampleCopy SET Color ='Purple'
        PRINT 'Total has been updated'
        FETCH NEXT FROM Sample_Cursor
	END
CLOSE Sample_Cursor
DEALLOCATE Sample_Cursor;

SELECT * INTO #SampleCopy FROM [Sample]
DECLARE Sample_Cursor CURSOR FOR SELECT * FROM #SampleCopy
OPEN Sample_Cursor;
FETCH NEXT FROM Sample_Cursor
WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE #SampleCopy SET Color ='Purple'
        PRINT 'Total has been updated'
        FETCH NEXT FROM Sample_Cursor
		IF @@ROWCOUNT=0
            PRINT 'Warning: No rows were updated';
    END
CLOSE Sample_Cursor
DEALLOCATE Sample_Cursor;

Task 5

USE Examples2;
BEGIN TRY 
    INSERT Sample VALUES (5,'Blue');
    PRINT 'SUCCESS: Record was inserted.'; 
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.'; PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) + ': ' + ERROR_MESSAGE();
END CATCH;
BEGIN TRY 
    INSERT Sample VALUES(6,'Green');
    PRINT 'SUCCESS: Record was inserted.'; 
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.'; PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) + ': ' + ERROR_MESSAGE();
END CATCH;
SELECT * INTO #Sample FROM [Sample]
Begin
IF @@ROWCOUNT=0
            PRINT 'Warning: No rows were updated';
end;
SELECT* FROM #Sample;*/
