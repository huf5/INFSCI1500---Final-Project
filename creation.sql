USE group_camp_query;

-- Create tables
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

#Insert data into staff table
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (17263, 'Adams', 'James', 'Counselor', '(254) 644-6473' , 'jaddams5@gmail.com', 'Jeremy Adams (254) 644-6179', NULL, 'pescatarian', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (14577, 'Allen', 'Jaci', 'Counselor', '(771) 653-2167' , 'kittyluver92.com', NULL, 'Peanuts', 'Vegetarian', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (13562, 'Jones', 'Helen', 'Activity Coordinator', '(536) 453-6473' , 'jones.helen@gmail.com', 'Jaci Jones (536) 453-6479', NULL, 'Vegetarian', 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (13338, 'Gilly', 'Cynthia', 'Activity Coordinator', '(536) 222-6373' , 'cynthia.gilly@gmail.com', NULL , 'Tree Nuts' , 'Vegan', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (12567, 'Flores', 'Zuri', 'Junior Counselor', '(212) 254-6473' , 'zz42@gmail.com', NULL, 'Peanuts', NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (14777, 'Xu', 'Marisol', 'Counselor', '(223) 256-7584' , 'kittykat66@gmail.com', 'Jeremy Fennel (912) 647-7334', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (13364, 'Brown', 'Jacob', 'Counselor', '(254) 644-9264' , 'jjb5@gmail.com', 'Allen Coyne (254) 622-6273', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (90145, 'Patel', 'Alley', 'Counselor', '(814) 224-0293' , 'alleycat@gmail.com', 'Riya Patel (335) 645-7568', 'Wasp Venom' , NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (90146, 'Renick', 'Dylan', 'Junior Counselor', '(335) 222-0917' , 'doggylover@gmail.com', 'Terry Rennick (335) 657-6475' , NULL, 'Vegan', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (33456, 'Lennox', 'Owulatofu', 'Junior Counselor', '(254) 546-0192' , 'lennofu@gmail.com', 'Tanya Lennox (254) 546-7485', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11145, 'Addams', 'Tiara', 'Lead Chef', '(212) 543-9685' , 'tiaraaddams66@gmail.com', 'Diamond Addams (212) 647-6475', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11535, 'Gacy', 'Diya', 'Lifeguard', '(212) 536-7568' , 'dg664@gmail.com', 'Nona Gacy (212) 533-7529', 'Blueberries' , NULL, 'Y');

#Insert data into the Cabins table
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Apple', 8);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Ash', 9);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Birch', 10);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Fig', 15);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Willow', 15);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Oak', 12);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Maple', 10);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Magnolia', 15);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Sycamore', 15);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Almond', 15);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Ginko', 20);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Spruce', 10);
    
    
#Insert data into Camper Groups table
INSERT INTO camper_groups (group_name)
	VALUES ('Red');
INSERT INTO camper_groups (group_name)
	VALUES ('Green');
INSERT INTO camper_groups (group_name)
	VALUES ('Blue');
INSERT INTO camper_groups (group_name)
	VALUES ('Violet');
INSERT INTO camper_groups (group_name)
	VALUES ('Silver');
INSERT INTO camper_groups (group_name)
	VALUES ('Gold');
INSERT INTO camper_groups (group_name)
	VALUES ('Black');
INSERT INTO camper_groups (group_name)
	VALUES ('Pink');
INSERT INTO camper_groups (group_name)
	VALUES ('Purple');
INSERT INTO camper_groups (group_name)
	VALUES ('Brown');
INSERT INTO camper_groups (group_name)
	VALUES ('Rainbow');
INSERT INTO camper_groups (group_name)
	VALUES ('Orange');
INSERT INTO camper_groups (group_name)
	VALUES ('Indigo');
    
#Insert data into into the sessions table
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-02', '2024-06-08', 'Elementary', 75, '2024-05-15', 'OPEN', 225.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-02', '2024-06-12', 'Middle School Extended', 100, '2024-05-15', 'OPEN', 430.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-09', '2024-06-15', 'Performing Arts', 100, '2024-05-20', 'OPEN', 350.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-09', '2024-06-15', 'Fine Arts', 100, '2024-05-15', 'FULL', 225.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-20', '2024-06-25', 'Pre-K and Kinder', 75, '2024-05-15', 'OPEN', 150.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-07-01', '2024-07-30', 'High School Extended', 125, '2024-05-15', 'FULL', 1300.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-07-01', '2024-07-15', 'High School', 75, '2024-05-15', 'FULL', 700.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-08-01', '2024-08-15', 'Adult', 25, '2024-05-15', 'FULL', 500.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-08-01', '2024-08-15', 'Elementary', 75, '2024-05-15', 'OPEN', 475.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-12-27', '2025-01-07', 'Performing Arts', 50, '2024-10-15', 'REGISTRATION SOON', 575.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-12-27', '2025-01-07', 'Fine Arts', 50, '2024-10-15', 'REGISTRATION SOON', 575.00);
    
-- Show the tables
SELECT * FROM staff;
SELECT * FROM transactions;

SELECT * FROM campers;
SELECT * FROM guardians;

SELECT * FROM cabins;
SELECT * FROM camper_groups;
SELECT * FROM sessions;