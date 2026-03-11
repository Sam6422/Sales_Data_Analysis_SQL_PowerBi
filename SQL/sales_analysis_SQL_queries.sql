SELECT * FROM SuperStoreUS ssu LIMIT 10; -- seeing first 10 rows

PRAGMA table_info(ssu); -- to see the schema of the table

SELECT COUNT(*) FROM SuperStoreUS ssu; -- counting number of rows

SELECT DISTINCT Region FROM SuperStoreUS ssu; -- seeing the list of Regions

SELECT MIN("Order Date"), MAX("Order Date") FROM SuperStoreUS ssu; -- minimum, maximum date

SELECT COUNT(*) FROM (SELECT DISTINCT "Customer Name" FROM SuperStoreUS ssu); -- finding count of customers using Subquery
SELECT COUNT(DISTINCT "Customer Name") FROM SuperStoreUS ssu ; -- finding count of customers directly (without Subquery)


SELECT "Region", COUNT(DISTINCT "Customer Name") FROM SuperStoreUS ssu GROUP BY "Region"; -- Customers per Region


## total sales per Region, but only for Orders where Profit is positive
SELECT "Region", SUM("Sales") as Total_Sales FROM SuperStoreUS ssu WHERE "Profit">0 GROUP BY "Region";


## Top 5 customers by total sales
SELECT "Customer ID", SUM("Sales") as Total_sales FROM SuperStoreUS ssu GROUP BY "Customer ID" ORDER BY Total_Sales DESC LIMIT 5;


-- Find top 3 customers in each region by sales. (using Windows function-- RANK())
SELECT * FROM (
    SELECT "Region","Customer Name",SUM("Sales") AS total_sales,
        RANK() OVER (
            PARTITION BY "Region"
            ORDER BY SUM("Sales") DESC
        ) AS rank
    FROM SuperStoreUS ssu 
    GROUP BY "Region", "Customer Name"
)
WHERE rank <= 3;


-- creating View in SQL (logic stored for later use)
CREATE VIEW see_table AS SELECT * FROM SuperStoreUS WHERE SuperStoreUS.Sales > 0;


--SELECT * FROM SuperStoreUS ssu JOIN SuperStoreUS ssu2 ON ssu."Order Date" = ssu2."Ship Date"  WHERE ssu."Order Date" = ssu2."Ship Date";

