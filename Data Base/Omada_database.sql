create database Omada;
Use Omada;
Create table temp (
	client_id int, 
    client_name varchar(100),
    member_id int,
    program_month_num int,
    weighin_count int,
    login_count int,
    lesson_count int,
    meal_count int,
    discussion_count int,
    median_weight_loss_perc float
);
Select *
from temp;
create table dim_client (
	client_id int not null,
    client_name varchar(100),
    primary key(client_id)
    );
INSERT IGNORE INTO dim_client (client_id, client_name)
SELECT DISTINCT 
	client_id, 
    client_name
FROM temp;
SELECT *
FROM dim_client;
-- TRUNCATE dim_client
CREATE TABLE dim_member (
	member_id int not null,
    client_id int,
    primary key (member_id),
    FOREIGN KEY (client_id) REFERENCES dim_client (client_id) ON DELETE SET NULL
    );
INSERT IGNORE INTO dim_member (member_id, client_id)
SELECT DISTINCT 
	tmp.member_id,
    c.client_id
FROM temp as tmp
INNER JOIN dim_client as c ON tmp.client_id = c.client_id;

CREATE TABLE Facts (
	program_month int,
    weight_count int,
    login_count int,
    lesson_count int,
    meal_count int,
    discussion_count int,
    weight_loss_percentage float,
    member_id int,
    FOREIGN KEY (member_id) REFERENCES dim_member (member_id)ON DELETE SET NULL
    );
DROP TABLE Facts;

INSERT IGNORE INTO Facts (program_month, weight_count, login_count, lesson_count, meal_count, discussion_count, weight_loss_percentage, member_id)
SELECT DISTINCT 
	tmp.program_month_num,
    tmp.weighin_count,
    tmp.login_count,
    tmp.lesson_count,
    tmp.meal_count,
    tmp.discussion_count,
    tmp.median_weight_loss_perc,
    m.member_id
FROM temp as tmp
INNER JOIN dim_member as m ON tmp.member_id = m.member_id;
SELECT member_id
FROM Facts
WHERE lesson_count = 2
LIMIT 3;


    
