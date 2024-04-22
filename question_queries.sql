-- Use group_camp_query 
 USE group_camp_query; 


# 1 - Who are the campers with an allergy? 
	-- Inner join
SELECT 
	CONCAT(first_name," ",last_name) as "Name",
	hr.allergies as "Allergy"
FROM campers c
JOIN health_records hr ON c.camper_id = hr.camper_id
WHERE hr.allergies IS NOT NULL;

# 2 - What activities have yet to have a staffer assigned
	-- Left Join
SELECT a.activity_name aS "Activity"
FROM activities a
LEFT JOIN staff_activity sa ON a.activity_id = sa.sa_activity_id
WHERE sa.sa_activity_id IS NULL;

# 3 What camper has had their session paid for in full? 
SELECT 
	CONCAT(c.first_name, " ", c.last_name) AS "Camper Name"
FROM campers c
JOIN transactions t ON c.camper_id = t.trans_camper
WHERE transaction_type = "Tuition";

# 4 - How many campers are assigned to each camp session
	-- Aggregate and GROUP BY 
SELECT 
	ss.session_id AS "Session",
    COUNT(c.camper_id) AS "Total Campers"
FROM sessions ss
JOIN campers c ON ss.session_id = c.c_session
GROUP BY session_id;

# 5 - Who are the campers registered for high school extended session
	-- Subquery
SELECT 
	CONCAT(c.first_name, " ",c.last_name) AS "Name"
FROM campers c
WHERE c_session IN (	
	SELECT session_id FROM sessions 
	WHERE theme = 'High School Extended');

# 6 - What are the sessions least expensive to most expensive?
	-- Order by
SELECT 
	session_id as "ID",
    start_date as "Start Date",
    end_date as "End Date",
    theme as "Theme", 
    session_fee as "Cost"
FROM sessions
ORDER BY session_fee ASC;

# 7 What are the first 5 transactions and for who?
	-- Limit
SELECT 	
	t.transaction_id AS "Transaction ID",
	CONCAT(c.first_name, " ", c.last_name) AS "Camper Name",
    CONCAT(g.first_name, " ", g.last_name) AS "Guardian Name"
FROM transactions t
JOIN campers c ON t.trans_camper = c.camper_id
JOIN guardian_children gc ON c.camper_id = gc.camper_id
JOIN guardians g ON gc.guardian_id = g.guardian_id
ORDER BY transaction_date
LIMIT 5;

# 8 What supplies go to swimming and water sports? 
SELECT s.item_name AS "Supply Name"
FROM supplies s
JOIN activity_equipment ae ON s.item_id = ae.item_id
JOIN activities a ON ae.e_activity_id = a.activity_id
WHERE activity_name = "Swimming and Water Sports";

# 9 - Which activities have more than 2 staffers
	-- Aggregate and HAVING
SELECT a.activity_name, COUNT(sa.sa_staff_id) AS staff_count
FROM staff_activity sa
JOIN activities a ON sa.sa_activity_id = a.activity_id
GROUP BY sa.sa_activity_id
HAVING staff_count > 2;

# 10 - What is the average cost of all the sessions offered?
	-- Select and Aggregate
SELECT AVG(session_fee) AS "Average" FROM sessions;

	




