USE group_camp_query;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff(
	staff_id INT PRIMARY KEY NOT NULL,
    last_name VARCHAR(50) NOT NULL, 
    first_name VARCHAR(50) NOT NULL,
    position_name VARCHAR(100) NOT NULL,
    staff_phone_number VARCHAR(50), 
    staff_email VARCHAR(100) NOT NULL,
    staff_emergency_contact VARCHAR(500),
    staff_allergies VARCHAR(100),
    staff_dietary_restrictions VARCHAR(100),
    cpr_certification VARCHAR(1)
)ENGINE INNODB;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    transaction_type VARCHAR(20),
    amount INT,
    transaction_date DATETIME,
	payment_type VARCHAR(20)
)ENGINE INNODB;

SELECT * FROM staff;
SELECT * FROM transactions;