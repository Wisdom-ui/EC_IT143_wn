   ========================================================================
    EC_IT143_W3.4_WN
   ========================================================================
   Author         : Wisdom Nwosu
   Date           : 2026-04-07
   Database       : AdventureWorks
   Description    : SQL answers for 8 business questions from myself and
                    other students (Tony, Djeamin, Nsikak).
   Usage          : Run this script in SSMS against the AdventureWorks
                    database. All queries have been tested and verified.
-- ========================================================================
-- MY QUESTIONS (2 questions)
-- ========================================================================
-- Q1: Business User – Marginal Complexity
-- Author: Me
-- Question: What are the top five best-selling products by total order
--           quantity?
-- ------------------------------------------------------------------------

SELECT TOP 5
    p.ProductID,
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalOrderQuantity
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalOrderQuantity DESC;

-- ------------------------------------------------------------------------
-- Q2: Business User – Marginal Complexity
-- Author: Me
-- Question: How many employees currently work in each department?
-- ------------------------------------------------------------------------
SELECT
    d.Name AS DepartmentName,
    COUNT(edh.BusinessEntityID) AS CurrentEmployeeCount
FROM HumanResources.Department d
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
    ON d.DepartmentID = edh.DepartmentID
WHERE edh.EndDate IS NULL   -- Current employees only
GROUP BY d.Name
ORDER BY DepartmentName;

-- ========================================================================
-- TONY'S QUESTIONS (2 questions)
-- ========================================================================

-- ------------------------------------------------------------------------
-- Q3: Business User – Moderate Complexity
-- Author: Tony
-- Question: I am reviewing sales performance for road bikes in 2013. I need
--           a report showing monthly sales trends. Include product name,
--           order month, total quantity sold, list price, standard cost,
--           and calculated profit per product.
-- ------------------------------------------------------------------------
SELECT
    p.Name AS ProductName,
    YEAR(soh.OrderDate) AS OrderYear,
    MONTH(soh.OrderDate) AS OrderMonth,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    p.ListPrice,
    p.StandardCost,
    SUM((sod.UnitPrice - p.StandardCost) * sod.OrderQty) AS TotalProfit
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
INNER JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE YEAR(soh.OrderDate) = 2013
    AND p.ProductLine = 'R'   -- 'R' = Road bikes
GROUP BY p.Name, p.ListPrice, p.StandardCost,
         YEAR(soh.OrderDate), MONTH(soh.OrderDate)
ORDER BY OrderYear, OrderMonth, TotalProfit DESC;

-- ------------------------------------------------------------------------
-- Q4: Business User – Moderate Complexity
-- Author: Tony
-- Question: Our management team wants to evaluate employee sales
--           contributions. Can you generate a report showing each
--           salesperson's total sales revenue, number of orders handled,
--           and average revenue per order for the year 2012?
-- ------------------------------------------------------------------------
SELECT
    sp.BusinessEntityID,
    p.FirstName + ' ' + p.LastName AS SalespersonName,
    COUNT(DISTINCT soh.SalesOrderID) AS NumberOfOrders,
    SUM(soh.TotalDue) AS TotalSalesRevenue,
    AVG(soh.TotalDue) AS AvgRevenuePerOrder
FROM Sales.SalesPerson sp
INNER JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
WHERE YEAR(soh.OrderDate) = 2012
GROUP BY sp.BusinessEntityID, p.FirstName, p.LastName
ORDER BY TotalSalesRevenue DESC;

-- ========================================================================
-- DJEAMIN'S QUESTIONS (2 questions)
-- ========================================================================

-- ------------------------------------------------------------------------
-- Q5: Business User – Marginal Complexity
-- Author: Djeamin
-- Question: Show the first and last name of all employees.
-- ------------------------------------------------------------------------
SELECT
    FirstName,
    LastName
FROM Person.Person
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID FROM HumanResources.Employee
)
ORDER BY LastName, FirstName;

-- Alternative (more efficient):
-- SELECT p.FirstName, p.LastName
-- FROM Person.Person p
-- INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
-- ORDER BY p.LastName, p.FirstName;

-- ------------------------------------------------------------------------
-- Q6: Business User – Moderate Complexity
-- Author: Djeamin
-- Question: I need to know which customers have placed more than 5 orders.
--           Please show customer name and order count.
-- ------------------------------------------------------------------------
SELECT
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
INNER JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName
HAVING COUNT(soh.SalesOrderID) > 5
ORDER BY OrderCount DESC;

-- ========================================================================
-- NSIKAK'S QUESTIONS (2 questions)
-- ========================================================================

-- ------------------------------------------------------------------------
-- Q7: Business User – Marginal Complexity
-- Author: Nsikak
-- Question: I want to understand how products are performing. Which 5
--           products have the highest total sales? Include the product name
--           and total sales amount.
-- ------------------------------------------------------------------------
SELECT TOP 5
    p.Name AS ProductName,
    SUM(sod.LineTotal) AS TotalSalesAmount
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY TotalSalesAmount DESC;

-- ------------------------------------------------------------------------
-- Q8: Business User – Moderate Complexity
-- Author: Nsikak
-- Question: I want to know about customer activity. Which customers have
--           placed the most orders, and how many orders did each of them
--           make?
-- ------------------------------------------------------------------------
SELECT TOP 10
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM Sales.Customer c
INNER JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY NumberOfOrders DESC;
