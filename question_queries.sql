-- Use group_camp_query 
 USE group_camp_query; 
 
 -- Questions
# 1 - Who are the campers with an allergy? 
SELECT 
	CONCAT(first_name," ",last_name) as "Name",
	hr.allergies as "Allergy"
FROM campers c
JOIN health_records hr ON c.camper_id = hr.camper_id
WHERE hr.allergies IS NOT NULL;

# 2 What camper belongs to what guardian? 
SELECT CONCAT(c.first_name," ",c.last_name) as "Camper Name", 
	CONCAT(g.first_name," ",g.last_name) as "Guardian Name"
FROM campers c
INNER JOIN guardian_children AS gc ON c.camper_id = gc.camper_id
INNER JOIN guardians AS g ON gc.guardian_id = g.guardian_id;

# 3 What camper has had their session paid for in full? 

# 4 - How many campers are assigned to each camp session

# 6 - What are the sessions least expensive to most expensive?
SELECT 
	session_id as "ID",
    start_date as "Start Date",
    end_date as "End Date",
    theme as "Theme", 
    session_fee as "Cost"
FROM sessions
ORDER BY session_fee ASC;

# 7 What are the first 5 transactions?
	SELECT *
FROM transactions
ORDER BY transaction_date
LIMIT 5;

# 8 What supplies go to swimming and water sports and baseball? 

# 9 - Who are all the campers registered?
Select CONCAT(first_name, " ", last_name) as "Camper Name" FROM campers;

# 10 - What is the average cost of all the sessions offered?
SELECT AVG(session_fee) AS "Average" FROM sessions;

# 11 - What session will each staff member be assigned to?
SELECT 
	CONCAT(first_name, " ", last_name) AS "Name",
    se.session_id AS "Session ID", 
    se.theme AS "Session Theme"
FROM staff s
JOIN staff_session ss ON s.staff_id = ss.staff_id
JOIN sessions se ON ss.session_id = se.session_id;
