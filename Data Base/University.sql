CREATE DATABASE University;
USE  University;
CREATE TABLE temp (
	university varchar(100),
    year int,
    rank_display varchar(20),
    score float,
    link varchar(200),
    country varchar(100),
    city varchar(100),
    region varchar(100),
    logo varchar(200),
    type varchar(200),
    research_output varchar(100),
    student_faculty_ratio int,
    international_students float,
    size varchar(100),
    faculty_count float
    );
  USE University;
  Select distinct research_output
  from temp;
  
SELECT
COUNT(*)
FROM temp;
CREATE TABLE dim_university (
	university_id int not null auto_increment,
    university varchar(500),
    link text,
    logo varchar(500),
    type varchar(200),
    size varchar(20),
    primary key (university_id)
    );
    INSERT IGNORE INTO dim_university(university,link,logo,type,size)
    SELECT DISTINCT
    tmp.university,
    tmp.link,
    tmp.logo,
    tmp.type,
    tmp.size
FROM temp tmp;
CREATE TABLE dim_research (
	research_id int not null auto_increment,
    research_output varchar(100),
    primary key (research_id)
    );
INSERT IGNORE INTO dim_research(research_output)
SELECT DISTINCT
    tmp.research_output
FROM temp tmp;
SELECT *
FROM dim_research;

CREATE TABLE dim_location(
	location_id int not null auto_increment,
    region varchar(100),
    country varchar(100),
    city varchar(100),
    primary key(location_id)
    );
INSERT IGNORE INTO dim_location(region,country,city)
SELECT DISTINCT
    tmp.region,
    tmp.country,
    tmp.city
FROM temp tmp;
CREATE TABLE fact_table(
	year int,
    rank_display varchar(100),
    score float,
    student_faculty_ratio int,
    international_students float,
    faculty_count float,
    university_id int,
    location_id int,
    research_id int,
    FOREIGN KEY (university_id) 
    REFERENCES dim_university (university_id) ON DELETE SET NULL,
    FOREIGN KEY (location_id)
    REFERENCES dim_location (location_id) ON DELETE SET NULL,
    FOREIGN KEY (research_id)
    REFERENCES dim_research (research_id) ON DELETE SET NULL
    );
INSERT IGNORE INTO fact_table(year,rank_display,score,student_faculty_ratio, international_students,faculty_count,university_id, location_id, research_id)
SELECT DISTINCT
	tmp.year,
    tmp.rank_display,
    tmp.score,
    tmp.student_faculty_ratio,
    tmp.international_students,
    tmp.faculty_count,
    du.university_id,
    dl.location_id, 
    dr.research_id
    FROM temp as tmp
    INNER JOIN dim_university as du ON tmp.university = du.university
    INNER JOIN dim_location as dl ON tmp.city = dl.city AND tmp.country = dl.country
    INNER JOIN dim_research as dr ON tmp.research_output = dr.research_output
    ;
    
SELECT
COUNT(*) 
FROM dim_university;



    
    

    
    
    

  
  
  
    
    
    
    