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

# 9 - Who are all the campers registered?
Select CONCAT(first_name, " ", last_name) as "Camper Name" FROM campers;

# 10 - What is the average cost of all the sessions offered?
SELECT AVG(session_fee) AS "Avaergae" FROM sessions;

# 11 - What session will each staff member be assigned to?
SELECT 
	CONCAT(first_name, " ", last_name) AS "Name",
    se.session_id AS "Session ID", 
    se.theme AS "Session Theme"
FROM staff s
JOIN staff_session ss ON s.staff_id = ss.staff_id
JOIN sessions se ON ss.session_id = se.session_id;
