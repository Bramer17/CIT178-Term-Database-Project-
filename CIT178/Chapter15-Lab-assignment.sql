/* Final Project Procedures Payton Bramer

--Retrieve and store data 
USE FakeBusiness;
GO
CREATE PROC spEmployees
AS
SELECT * FROM Employees
ORDER BY HireDate;
GO 
EXEC spEmployees;

-- Takes an input parameter
USE FakeBusiness;
GO
CREATE PROC spGetEmployees
		@EmployeeID int
AS 
BEGIN
		SELECT * FROM Employees
		WHERE EmployeeID = @EmployeeID;
END
GO 
EXEC spGetEmployees 1;

-- Takes one input and includes 1 output

USE FakeBusiness;
GO
CREATE PROC spEmployeesNames
	@EmployeeID int,
	@FirstName nvarchar(20) OUTPUT,
	@LastName nvarchar(30) OUTPUT
AS
SELECT @FirstName= FirstName, @LastName=LastName
FROM Employees
WHERE EmployeeID = @EmployeeID;
GO 
DECLARE @FirstName nvarchar(20);
DECLARE @LastName nvarchar(30);
EXEC spEmployeesNames 2, @FirstName OUTPUT, @LastName OUTPUT;
SELECT @FirstName AS 'First Name', @LastName AS 'Last Name';

--Store procedure that has return value
USE FakeBusiness;
GO 
CREATE PROC spProductCount
AS
DECLARE @ProductCount int;
SELECT @ProductCount = COUNT(*)
FROM Products
RETURN @ProductCount;
GO 
DECLARE @ProductCount int;
EXEC @ProductCount = spProductCount;
PRINT 'There are ' + CONVERT(varchar,@ProductCount) + ' Products in your database';
GO*/

 /* Final Project User Defined Functions 

 USE FakeBusiness;
 GO 
 CREATE FUNCTION fnGetProducts
		(@ProductName nvarchar(50) ='%')
		RETURNS int
BEGIN
	RETURN (SELECT PackageType FROM Products WHERE ProductName LIKE @ProductName);
END;
GO 
SELECT PackageType,ProductName, Price FROM Products
WHERE PackageType = dbo.fnGetProducts('Crate%'); */

/*USE FakeBusiness;
GO 
CREATE FUNCTION fnProducts 
		(@ProductName nvarchar(50) ='%')
		RETURNS table
RETURN
		(SELECT * FROM Products WHERE ProductName LIKE @ProductName);
GO 
SELECT * FROM dbo.fnProducts('%c%');*/

 /* Final Project Triggers 

 USE FakeBusiness;
 GO
 SELECT * INTO EmployeeArchive
 FROM Employees
 WHERE 1=0;

ALTER TABLE EmployeeArchive
ADD Activity varchar(50);
GO

CREATE TRIGGER EmployeeArchive_INSERT ON Employees
	AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @EmployeeID int
		DECLARE @FirstName nvarchar(30)
		DECLARE @LastName nvarchar(50)
		DECLARE @BirthDate nvarchar(25)
		DECLARE @HireDate nvarchar (25)
		DECLARE @Title nvarchar(30)
	
	SELECT @EmployeeID =INSERTED.EmployeeID, @FirstName =INSERTED.FirstName, @LastName =INSERTED.LastName,@BirthDate =INSERTED.BirthDate, @HireDate =INSERTED.HireDate, @Title =INSERTED.Title 
		FROM INSERTED 

	INSERT INTO EmployeeArchive VALUES (@EmployeeID,@FirstName,@LastName,@BirthDate,@HireDate,@Title, 'Inserted')
END 
GO

INSERT INTO Employees VALUES (6,'Doo', 'Scooby', '1/1/2001', '3-Apr','Sales');

SELECT * FROM EmployeeArchive;

CREATE TRIGGER EmployeeArchive_Delete ON Employees
	AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @EmployeeID int
		DECLARE @FirstName nvarchar(30)
		DECLARE @LastName nvarchar(50)
		DECLARE @BirthDate nvarchar(25)
		DECLARE @HireDate nvarchar (25)
		DECLARE @Title nvarchar(30)

	SELECT @EmployeeID =DELETED.EmployeeID, @FirstName =DELETED.FirstName, @LastName =DELETED.LastName,@BirthDate =DELETED.BirthDate, @HireDate =DELETED.HireDate, @Title =DELETED.Title 
		FROM DELETED 
	INSERT INTO EmployeeArchive VALUES (@EmployeeID,@FirstName,@LastName,@BirthDate,@HireDate,@Title, 'Deleted')
END 
GO

DELETE FROM Employees WHERE EmployeeID = 6;
GO

SELECT * FROM EmployeeArchive;

CREATE TRIGGER EmployeeArchive_Update ON Employees
	AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @EmployeeID int
		DECLARE @FirstName nvarchar(30)
		DECLARE @LastName nvarchar(50)
		DECLARE @BirthDate nvarchar(25)
		DECLARE @HireDate nvarchar (25)
		DECLARE @Title nvarchar(30)

	SELECT @EmployeeID =INSERTED.EmployeeID, @FirstName =INSERTED.FirstName, @LastName =INSERTED.LastName,@BirthDate =INSERTED.BirthDate, @HireDate =INSERTED.HireDate, @Title =INSERTED.Title 
		FROM INSERTED
	INSERT INTO EmployeeArchive VALUES (@EmployeeID,@FirstName,@LastName,@BirthDate,@HireDate,@Title, 'Updated')
END 
GO

INSERT INTO Employees VALUES (7,'Yuuki', 'Asuna', '8/30/2007', '8-May','Stocker');
GO
UPDATE Employees
SET FirstName = 'Kirito'
WHERE EmployeeID=7;
GO 

SELECT * FROM EmployeeArchive;*/