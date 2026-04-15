--EC_IT143_W5.2_My_Community_wn
-- Question 1 (Author: Emmanuel Odoom)
-- "List all cities with their zipcodes for reference"
SELECT 'Question 1: List all cities with zipcodes (Emmanuel Odoom)' AS QueryInfo;
SELECT CityID, CityName, Zipcode 
FROM cities 
ORDER BY CityName;

----EC_IT143_W5.2_My_Community_wn
-- Question 2 (Author: Ekpenyong Asuquo Mfon)
-- "How many total cities do we have in our database?"
SELECT 'Question 2: Count total cities (Ekpenyong Asuquo Mfon)' AS QueryInfo;
SELECT COUNT(*) AS TotalCities 
FROM cities;

----EC_IT143_W5.2_My_Community_wn
-- Question 3 (Author: Wisdom Nwosu)
-- "Which cities have zipcodes starting with '8'?"
SELECT 'Question 3: Cities with zipcodes starting with 8 (Wisdom Nwosu)' AS QueryInfo;
SELECT CityName, Zipcode 
FROM cities 
WHERE Zipcode LIKE '8%'  
ORDER BY Zipcode;

----EC_IT143_W5.2_My_Community_wn
-- Question 4 (Author: Pedro Barriga)
-- "Are there any duplicate zipcodes we should be aware of?"
SELECT 'Question 4: Check for duplicate zipcodes (Pedro Barriga)' AS QueryInfo;
SELECT Zipcode, COUNT(*) AS DuplicateCount 
FROM cities 
GROUP BY Zipcode 
HAVING COUNT(*) > 1;
