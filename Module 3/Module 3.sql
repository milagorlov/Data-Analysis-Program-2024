USE University;
-- Find the number of universities that has a score that more than 40
SELECT
	count(DISTINCT ft.university_id) as n_university
FROM
	fact_table AS ft
WHERE
	SCORE >40;
-- Output the number of universities for each region. Output region and total number of universities
SELECT
	region,
	COUNT(DISTINCT ft.university_id) as n_univeristy
FROM
	fact_table AS ft
JOIN dim_location AS dl
	ON dl.location_id = ft.location_id
JOIN dim_university AS du
	ON du.university_id = ft.university_id
GROUP BY region;
-- Calculate student faculty ratio for Oxford university for 2020 year
SELECT
	student_faculty_ratio,
    year,
    university
FROM
	fact_table AS ft
JOIN dim_university as du
	on du.university_id = ft.university_id
WHERE
	year = 2020
AND
	university like '%Oxford%';
-- What is the average faculty count for Switzerland?
SELECT
	AVG (faculty_count)
FROM
	fact_table AS ft
JOIN dim_location AS dl
	ON dl.location_id = ft.location_id
WHERE
	country like '%Switzerland%'
;

-- Calculate how many private and how many public universities in US with research as "Very High". output as two columns
SELECT
    COUNT(type) as n_type,
    type
FROM
	dim_university as du
JOIN fact_table as ft
	on du.university_id = ft.university_id
JOIN dim_research as dr
	on dr.research_id = ft.research_id
JOIN dim_location as dl
	on dl.location_id = ft.location_id
WHERE
	research_output = 'Very High'
AND country = 'United States'
GROUP BY
	type;

USE Omada;
-- Calculate how many members for each client.
SELECT
	 client_name,
     COUNT(DISTINCT dm.member_id) as n_member_id
    FROM
	dim_member AS dm
JOIN dim_client AS cl
	ON cl.client_id = dm.client_id
GROUP BY client_name;
-- Calculate how many members didn't input any measures across all months.
SELECT
	member_id,
    COUNT(DISTINCT member_id) as n_member_id,
    program_month
    FROM
	Facts AS ft
WHERE
	weight_count = 0
AND
    login_count = 0
AND
	lesson_count = 0
AND
	meal_count = 0
AND
	discussion_count = 0
AND
	weight_loss_percentage = 0
GROUP BY program_month,member_id;
-- Calculate Average, lowest and highest weighin_count for client 'dunder_mifflin" across all months.
SELECT
	client_name,
    AVG(weight_count),
    MIN(weight_count),
    MAX(weight_count)
    FROM
	dim_client as c
JOIN
	dim_member as m
    on c.client_id = m.client_id
JOIN
	Facts AS ft
	ON m.member_id = ft.member_id
WHERE
	client_name like '%dunder_mifflin%'
AND weight_count > 0
GROUP BY client_name;
