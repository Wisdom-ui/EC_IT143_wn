----EC_IT143_W5.2_My_Community_wn
-- Question 1: Top 5 most expensive products (Proxy for sales)  
-- Author: Mardison Carson 
SELECT TOP 5 
    ProductID, 
    ProductName, 
    Price 
FROM products 
ORDER BY Price DESC;  

----EC_IT143_W5.2_My_Community_wn
-- Question 2: Highest average price by category  
-- Author: Emmanuel Odoom  
SELECT 
    CategoryID, 
    AVG(Price) AS AvgPrice 
FROM products 
GROUP BY CategoryID 
ORDER BY AvgPrice DESC;  

----EC_IT143_W5.2_My_Community_wn
-- Question 3: Perishable vs. non-perishable products  
-- Author: Wisdom Nwosu  
SELECT 
    CASE 
        WHEN VitalityDays > 0 THEN 'Perishable' 
        ELSE 'Non-Perishable' 
    END AS ProductType, 
    COUNT(*) AS ProductCount 
FROM products 
GROUP BY CASE 
    WHEN VitalityDays > 0 THEN 'Perishable' 
    ELSE 'Non-Perishable' 
END;  

----EC_IT143_W5.2_My_Community_wn
-- Question 4: Durability distribution  
-- Author: Mardison Carson  
SELECT 
    Resistant AS Durability, 
    COUNT(*) AS ProductCount 
FROM products 
GROUP BY Resistant;
