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