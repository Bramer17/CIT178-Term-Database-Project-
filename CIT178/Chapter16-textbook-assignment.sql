/* Task 1
USE AP;
GO
DECLARE @InvoiceID int; 
    BEGIN TRY
        BEGIN TRAN;
            INSERT Invoices VALUES (34,'ZXA-080','2016-04-30',14092.59,0,0,3,'2016-05-30',NULL);
            SET @InvoiceID = @@IDENTITY; 
            INSERT InvoiceLineItems VALUES (@InvoiceID,1,160,4447.23,'HW upgrade'); 
            INSERT InvoiceLineItems VALUES (@InvoiceID,2,167,9645.36,'OS upgrade'); 
        COMMIT TRAN;
    END TRY 
BEGIN CATCH
    ROLLBACK TRAN;
END CATCH;
GO
SELECT * FROM Invoices WHERE VendorID=34;
SELECT * FROM InvoiceLineItems WHERE InvoiceID = 132;

BEGIN TRAN;
    DELETE Invoices WHERE VendorID = 34;
    IF @@ROWCOUNT > 1 
        BEGIN
            ROLLBACK TRAN;
            PRINT 'More invoices than expected. Deletions rolled back.'; 
        END;
    ELSE 
        BEGIN
            COMMIT TRAN;
            PRINT 'Deletions committed to the database.'; 
        END;

USE AP;
GO
IF OBJECT_ID('tempdb..#VendorCopy') IS NOT NULL 
    DROP TABLE tempdb.. #VendorCopy;

SELECT VendorID, VendorName INTO #VendorCopy 
FROM Vendors WHERE VendorID < 5;

BEGIN TRAN;
    DELETE #VendorCopy WHERE VendorID = 1;
    SAVE TRAN Vendor1;
            DELETE #VendorCopy WHERE VendorID = 2;
            SAVE TRAN Vendor2;
                DELETE #VendorCopy WHERE VendorID = 3;
                SELECT * FROM #VendorCopy;  -- this will only show 1 vendor

            ROLLBACK TRAN Vendor2;
            SELECT * FROM #VendorCopy;  -- this will show 2 vendors
    ROLLBACK TRAN Vendor1;
    SELECT * FROM #VendorCopy; -- this will show 3 vendors
COMMIT TRAN;
SELECT * FROM #VendorCopy;

USE Northwind;
SELECT * INTO ForeignCustomers FROM Customers WHERE Country <> 'USA';

SELECT * FROM ForeignCustomers;

USE Northwind;
GO
BEGIN TRY
    BEGIN TRAN
        DELETE ForeignCustomers WHERE CustomerID='RANCH';
        DELETE ForeignCustomers WHERE CustomerID='FRANK';
        SAVE TRAN VendorBatch1
   COMMIT TRAN
   PRINT 'Batch 1 deletions were committed';
END TRY
BEGIN CATCH
    ROLLBACK TRAN VendorBatch1
    PRINT ' Deletion error in batch1, transaction was rolled back';
END CATCH
GO
BEGIN TRY
    BEGIN TRAN
        DELETE ForeignCustomers WHERE CustomerID='ISLAT';
        DELETE ForeignCustomers WHERE CustomerID='WILMK';
        SAVE TRAN VendorBatch2
    COMMIT TRAN
    PRINT ' Batch 2 deletions were committed';
END TRY
BEGIN CATCH
    ROLLBACK TRAN VendorBatch2
    PRINT ' Deletion error in batch2, transaction was rolled back';
END CATCH
GO

USE Northwind;
GO
BEGIN TRY
    BEGIN TRAN;
        DELETE ForeignCustomers WHERE City='London';
        IF @@ROWCOUNT>1
            BEGIN
                ROLLBACK TRAN;
                PRINT 'More than 1 customer was deleted. Deletions were rolled back';
            END
        ELSE
            BEGIN
                COMMIT TRAN;
                PRINT 'Deletion was committed to the database';
            END
END TRY 
BEGIN CATCH
    ROLLBACK TRAN;
    PRINT 'An error has occurred and the transactions have been rolled back';
END CATCH;

SELECT * FROM ForeignCustomers WHERE City='London';*/




