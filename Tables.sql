CREATE TABLE AW_Territory(
	SalesTerritoryKey INT PRIMARY KEY,
	Region		VARCHAR(15),
	Country		VARCHAR(15),
	Continent	VARCHAR(15)
)
--select * from AW_Territory

CREATE TABLE AW_ProductCategory(
	ProductCategoryKey	INT PRIMARY KEY,
	CategoryName VARCHAR(15)
)

CREATE TABLE AW_ProductSubcategory(
	ProductSubcategoryKey INT PRIMARY KEY,	
	SubcategoryName	VARCHAR(20),
	ProductCategoryKey INT
	CONSTRAINT FK_ProductCategoryKey FOREIGN KEY (ProductCategoryKey) 
        REFERENCES AW_ProductCategory(ProductCategoryKey) 
)

CREATE TABLE AW_Product(
	ProductKey	INT PRIMARY KEY,
	ProductSubcategoryKey	INT,
	ProductSKU	VARCHAR(10),
	ProductName	VARCHAR(35),
	ModelName	VARCHAR(30),
	ProductDescription	VARCHAR(250),
	ProductColor VARCHAR(15),	
	ProductSize	VARCHAR(5),
	ProductStyle VARCHAR(5),
	ProductCost	MONEY,
	ProductPrice MONEY,
	CONSTRAINT FK_ProductSubcategoryKey FOREIGN KEY (ProductSubcategoryKey) 
        REFERENCES AW_ProductSubcategory(ProductSubcategoryKey) 
)

CREATE TABLE AW_Returns(
	ReturnDate	DATE,
	TerritoryKey INT,	
	ProductKey	INT,
	ReturnQuantity INT CHECK (ReturnQuantity > 0),
    UNIQUE (ReturnDate, TerritoryKey, ProductKey),
	CONSTRAINT FK_TerritoryKey FOREIGN KEY (TerritoryKey) 
        REFERENCES AW_Territory(SalesTerritoryKey) , -- Don't Need LookUP
	CONSTRAINT FK_ProductKey FOREIGN KEY (ProductKey) 
        REFERENCES AW_Product(ProductKey) -- Don't Need LookUP
)

CREATE TABLE AW_Customer(
	CustomerKey	INT PRIMARY KEY,
	Prefix		VARCHAR(5),
	FirstName	VARCHAR(20),
	LastName	VARCHAR(20),
	BirthDate	DATE,
	MaritalStatus CHAR(1) CHECK (MaritalStatus IN ('M', 'S')),
	Gender		VARCHAR(2),
	EmailAddress	VARCHAR(50),
	AnnualIncome	NUMERIC(10),
	TotalChildren	NUMERIC(2),
	EducationLevel	VARCHAR(20),
	Occupation		VARCHAR(20),
	HomeOwner CHAR(1) CHECK (HomeOwner IN ('N', 'Y'))
)

CREATE TABLE AW_SalesOrder(
	OrderDate	DATE,
	StockDate	DATE,
	OrderNumber	VARCHAR(10),
	ProductKey	INT,
	CustomerKey	INT,
	TerritoryKey INT,	
	OrderLineItem	NUMERIC(5),
	OrderQuantity	NUMERIC(5),
	UNIQUE (OrderNumber, ProductKey),
	CONSTRAINT FK_SOProductKey FOREIGN KEY (ProductKey) 
        REFERENCES AW_Product(ProductKey),
	CONSTRAINT FK_CustomerKey FOREIGN KEY (CustomerKey) 
        REFERENCES AW_Customer(CustomerKey),
	CONSTRAINT FK_SOTerritoryKey FOREIGN KEY (TerritoryKey) 
        REFERENCES AW_Territory(SalesTerritoryKey)
)


-- Disable all table constraints
ALTER TABLE AW_SalesOrder NOCHECK CONSTRAINT ALL
-- Enable all table constraints
ALTER TABLE AW_SalesOrder CHECK CONSTRAINT ALL
-- ----------
-- Disable single constraint
ALTER TABLE YourTableName NOCHECK CONSTRAINT YourConstraint
-- Enable single constraint
ALTER TABLE YourTableName CHECK CONSTRAINT YourConstraint


ALTER TABLE AW_SalesOrder DROP CONSTRAINT FK_CustomerKey;

ALTER TABLE AW_SalesOrder
ADD CONSTRAINT FK_CustomerKey
FOREIGN KEY (CustomerKey) REFERENCES [AW_Customer](CustomerKey);