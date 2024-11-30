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

