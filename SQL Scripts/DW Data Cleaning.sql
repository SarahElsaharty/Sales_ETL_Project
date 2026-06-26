CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID NVARCHAR(50),
    CustomerName NVARCHAR(100),
    Segment NVARCHAR(50)
);

CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID NVARCHAR(50),
    ProductName NVARCHAR(200),
    Category NVARCHAR(100),
    SubCategory NVARCHAR(100)
);

CREATE TABLE DimLocation (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    Country NVARCHAR(100),
    City NVARCHAR(100),
    State NVARCHAR(100),
    Region NVARCHAR(100)
);


CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName NVARCHAR(20)
);

CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    
    CustomerKey INT,
    ProductKey INT,
    LocationKey INT,
    DateKey INT,

    SalesAmount DECIMAL(18,2),
    Profit DECIMAL(18,2),
    Quantity INT,

    FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    FOREIGN KEY (LocationKey) REFERENCES DimLocation(LocationKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);

