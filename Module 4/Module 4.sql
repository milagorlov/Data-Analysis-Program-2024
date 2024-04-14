USE University;
-- Find all universities' names with a score from 95 to 97 in US and UK
SELECT
	DISTINCT university
FROM
	dim_university as du
JOIN
	fact_table as f
    on f.university_id = du.university_id
JOIN
	dim_location as dl
    on dl.location_id = f.location_id
WHERE
	score BETWEEN 95 AND 97
AND
	country IN('United States', 'United Kingdom')
;
-- Calculate the number of cities with research "Very High" and score lower than 98
SELECT
	COUNT(DISTINCT dl.city) as n_cities
FROM
	dim_location as dl
JOIN fact_table as f on dl.location_id = f.location_id
JOIN dim_research as dr on dr.research_id = f.research_id
WHERE research_output = 'Very High'
AND score < 98;
--  Output university names from US and UK with a score >95 and from China and India with a score > 80. The output only university names
SELECT
 university
FROM dim_university as du
JOIN
	fact_table as f
    on f.university_id = du.university_id
JOIN
	dim_location as dl
    on dl.location_id = f.location_id
WHERE
	score > 95
AND
	country IN('United States', 'United Kingdom')
UNION
SELECT
 university
FROM dim_university as du
JOIN
	fact_table as f
    on f.university_id = du.university_id
JOIN
	dim_location as dl
    on dl.location_id = f.location_id
WHERE
	score > 80
AND
	country IN ('India', 'China (Mainland)');
    
-- Find all customers and their corresponding orders. Output customer number, customer name, order number and status
USE classicmodels;
SELECT 
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
	customers AS c
Left JOIN orders AS o 
ON c.customerNumber = o.customerNumber
;
-- Find customers without any orders. Output customer number, customer name, order number and status
SELECT 
	c.customerNumber,
    customerName,
    orderNumber,
    status
FROM customers as c
LEFT JOIN orders AS o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber is null;


-- Find the order numbers and the total amount of each order. Output as order number, total_amount_of_each_order
SELECT
	orderNumber,
   sum(priceEach*quantityOrdered) as total_amount_of_each_order
FROM
	orderdetails
GROUP BY
	orderNumber
;
    
    





