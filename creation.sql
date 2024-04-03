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

DROP TABLE IF EXISTS campers;
CREATE TABLE campers(
	camper_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    DOB DATETIME NOT NULL,
    home_address VARCHAR(100) NOT NULL,
    emergency_contact VARCHAR(15) NOT NULL,
    allergies VARCHAR(200) NOT NULL,
    special_needs VARCHAR(200) NOT NULL,
    dietary_restrictions VARCHAR(200) NOT NULL
) ENGINE INNODB;

DROP TABLE IF EXISTS guardians;
CREATE TABLE guardians(
	guardian_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    relationship_to_camper VARCHAR(50) NOT NULL,
    home_address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL
)ENGINE INNODB;

DROP TABLE IF EXISTS cabins;
CREATE TABLE cabins(
	cabin_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cabin_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL
)ENGINE INNODB;

DROP TABLE IF EXISTS camper_groups;
CREATE TABLE camper_groups(
	group_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    group_name VARCHAR(50)
)ENGINE INNODB;

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions(
	session_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    theme VARCHAR(50) NOT NULL,
    enrollment_capacity INT NOT NULL,
    registration_deadline DATE NOT NULL,
    session_status VARCHAR(50) NOT NULL,
    session_fee INT NOT NULL    
)ENGINE INNODB;

SELECT * FROM staff;
SELECT * FROM transactions;

SELECT * FROM campers;
SELECT * FROM guardians;

SELECT * FROM cabins;
SELECT * FROM camper_groups;
SELECT * FROM sessions;