INSERT INTO DimCustomer
(
    CustomerID,
    CustomerName,
    Segment
)
SELECT DISTINCT
    [Customer ID],
    [Customer Name],
    Segment
FROM Sales_Staging.dbo.Stg_Superstore;

select top 20* from DimCustomer

INSERT INTO DimProduct
(
    ProductID,
    ProductName,
    Category,
    SubCategory
)
SELECT DISTINCT
    [Product ID],
    [Product Name],
    Category,
    [Sub-Category]
FROM Sales_Staging.dbo.Stg_Superstore;

insert into DimLocation(country,
city,
state,
Region)
select DISTINCT 
Country,
City,
state,
region
from Sales_Staging.dbo.Stg_Superstore;


SELECT TOP 20 *
FROM DimLocation;

INSERT INTO DimDate
(
    DateKey,
    FullDate,
    Year,
    Quarter,
    Month,
    MonthName
)
SELECT DISTINCT
    CAST(CONVERT(VARCHAR,[Order Date],112) AS INT) AS DateKey,
    CAST([Order Date] AS DATE),
    YEAR([Order Date]),
    DATEPART(QUARTER,[Order Date]),
    MONTH([Order Date]),
    DATENAME(MONTH,[Order Date])
FROM Sales_Staging.dbo.Stg_Superstore;

select top 20* from DimDate

INSERT INTO FactSales
(
    CustomerKey,
    ProductKey,
    LocationKey,
    DateKey,
    SalesAmount,
    Profit,
    Quantity
)
SELECT
    dc.CustomerKey,
    dp.ProductKey,
    dl.LocationKey,
    dd.DateKey,

    st.Sales,
    st.Profit,
    st.Quantity

FROM Sales_Staging.dbo.Stg_Superstore st

INNER JOIN DimCustomer dc
    ON st.[Customer ID] = dc.CustomerID

INNER JOIN DimProduct dp
    ON st.[Product ID] = dp.ProductID

INNER JOIN DimLocation dl
    ON st.City = dl.City
    AND st.State = dl.State

INNER JOIN DimDate dd
    ON CAST(CONVERT(VARCHAR,st.[Order Date],112) AS INT) = dd.DateKey;


SELECT TOP 20 *
FROM FactSales;

