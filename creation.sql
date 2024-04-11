USE group_camp_query;

SET FOREIGN_KEY_CHECKS=0;

-- Create activities table
DROP TABLE IF EXISTS activities;
CREATE TABLE activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    age_group VARCHAR(50) NOT NULL,
    activity_desc TEXT,
    start_time TIME,
    end_time TIME,
    location VARCHAR(100),
	-- instructor INT,
    capacity INT,
    activity_equipment INT,
    activity_session INT
) ENGINE INNODB;

-- Create cabins table
DROP TABLE IF EXISTS cabins;
CREATE TABLE cabins (
    cabin_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cabin_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    cab_group_id INT
) ENGINE INNODB;

-- Create campers table
DROP TABLE IF EXISTS campers;
CREATE TABLE campers (
    camper_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1) NOT NULL,
    DOB DATETIME NOT NULL,
    home_address VARCHAR(100) NOT NULL,
    emergency_contact VARCHAR(15) NOT NULL,
    allergies VARCHAR(200) NOT NULL,
    special_needs VARCHAR(200) NOT NULL,
    dietary_restrictions VARCHAR(200) NOT NULL,
    guardian INT NOT NULL, 
    group_assignment INT NOT NULL
) ENGINE INNODB;

-- Create camper_groups table
DROP TABLE IF EXISTS camper_groups;
CREATE TABLE camper_groups (
    group_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    group_name VARCHAR(50), 
    cg_cabin INT NOT NULL, 
    cg_staff INT NOT NULL
) ENGINE INNODB;

-- Create guardians table
DROP TABLE IF EXISTS guardians;
CREATE TABLE guardians (
    guardian_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    camper INT, 
    relationship_to_camper VARCHAR(50) NOT NULL,
    home_address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL
) ENGINE INNODB;

-- Create health records table 
DROP TABLE IF EXISTS health_records;
CREATE TABLE health_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    camper_id INT NOT NULL,
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    blood_type VARCHAR(5),
    allergies TEXT,
    medications TEXT,
    medical_conditions TEXT,
    emergency_contact_name VARCHAR(100),
    emergency_contact_number VARCHAR(20),
    doctor_name VARCHAR(100),
    doctor_contact_number VARCHAR(20)
) ENGINE INNODB;

-- Create sessions table
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
    session_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    theme VARCHAR(50) NOT NULL,
    enrollment_capacity INT NOT NULL,
    registration_deadline DATE NOT NULL,
    session_status VARCHAR(50) NOT NULL,
    session_fee INT NOT NULL, 
    s_group INT
) ENGINE INNODB;

-- Create staff table
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
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
) ENGINE INNODB;

-- Create supplies table
DROP TABLE IF EXISTS supplies; 
CREATE TABLE supplies (
    item_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL, 
    quantity INT NOT NULL, 
    supplier VARCHAR(100) NOT NULL, 
    cost INT NOT NULL, 
    order_date DATETIME NOT NULL, 
    delivery_date DATETIME NOT NULL, 
    activity_id INT
) ENGINE INNODB;

-- Create transactions table
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    transaction_type VARCHAR(20),
    amount INT,
    transaction_date DATETIME,
    payment_type VARCHAR(20), 
    trans_camper INT NOT NULL, 
    trans_session INT NOT NULL
) ENGINE INNODB;

-- Create transportation table
DROP TABLE IF EXISTS transportation;
CREATE TABLE transportation (
    vehicle_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    route VARCHAR(50), 
    vehicle_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    wheelchair_accessible VARCHAR(10) NOT NULL,
    driver INT NOT NULL
) ENGINE INNODB;

SET FOREIGN_KEY_CHECKS=1;

-- Alter campers table to add guardian fk
ALTER TABLE campers
    ADD CONSTRAINT fk_guardian
    FOREIGN KEY (guardian)
    REFERENCES guardians (guardian_id);

-- Alter campers table to add group_assignment fk
ALTER TABLE campers
    ADD CONSTRAINT fk_group_assignment
    FOREIGN KEY (group_assignment)
    REFERENCES camper_groups (group_id);

-- Alter transactions to add fk
ALTER TABLE transactions 
    ADD CONSTRAINT fk_trans_camper
    FOREIGN KEY (trans_camper)
    REFERENCES campers (camper_id);

ALTER TABLE transactions
    ADD CONSTRAINT fk_trans_session
    FOREIGN KEY (trans_session)
    REFERENCES sessions (session_id);

-- Alter cabins table to add fk
ALTER TABLE cabins 
    ADD CONSTRAINT fk_c_groups
    FOREIGN KEY (cab_group_id)
    REFERENCES camper_groups(group_id); 

-- Alter camper_groups to add fk
ALTER TABLE camper_groups 
    ADD CONSTRAINT fk_cg_cabin
    FOREIGN KEY (cg_cabin)
    REFERENCES cabins (cabin_id);

ALTER TABLE camper_groups 
    ADD CONSTRAINT fk_cg_staff
    FOREIGN KEY (cg_staff)
    REFERENCES staff (staff_id);

-- Alter sessions to add fk
ALTER TABLE sessions
    ADD CONSTRAINT fk_session_gid
    FOREIGN KEY (s_group)
    REFERENCES camper_groups (group_id);

-- Alter transportation to add fk
ALTER TABLE transportation
    ADD CONSTRAINT fk_driver
    FOREIGN KEY (driver)
    REFERENCES staff(staff_id);

-- Alter activities to add fk
ALTER TABLE activities
    ADD CONSTRAINT fk_activity_equipment
    FOREIGN KEY (activity_equipment)
    REFERENCES supplies(item_id);

ALTER TABLE activities
    ADD CONSTRAINT fk_activity_session
    FOREIGN KEY (activity_session)
    REFERENCES sessions(session_id);

    
/* ALTER TABLE activities
    ADD CONSTRAINT fk_instructor
    FOREIGN KEY (activity_instructor)
    REFERENCES staff(staff_id); */ 
    
-- Alter health records table
ALTER TABLE health_records
	ADD CONSTRAINT fk_hr_camper_id
    FOREIGN KEY (camper_id)
    REFERENCES campers(camper_id);

-- Alter table supplies
ALTER TABLE supplies
	ADD CONSTRAINT fk_actvity
    FOREIGN KEY (activity_id)
    REFERENCES activities(activity_id);
    
-- Alter guardians table
ALTER TABLE guardians
	ADD CONSTRAINT fk_camper
    FOREIGN KEY (camper)
    REFERENCES campers(camper_id);

#Insert data into the activities table
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Nature Hike", "7-18", "Guided hike through nearby trails to explore local flora and fauna.", "09:00:00", "12:00:00", "Camp Query Forest", 20, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Campfire Smores", "5-18", "Gather around a campfire for storytelling and marshmallow roasting.", "8:00:00", "10:00:00", "Camp Query Town Hall", 200, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Arts and Crafts", "7-18", "Create personalized souvenirs using materials found in nature.", "09:00:00", "12:00:00", "Arts Center", 35, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Baseball", "7-18", "Play classic baseball team vs team", "02:00:00", "04:00:00", "Baseball Diamond", 22, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Volleyball", "7-18", "Play classic volleyball team vs team", "05:00:00", "07:00:00", "Bigelow Beach", 100, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Swimming and Water Sports", "5-18", "Enjoy swimming, water volleyball, or pillow jumping.", "12:00:00", "08:00:00", "Bigelow Lake", 20, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Photogrpahy Expidition", "5-18", "Capture the beauty of nature through photography sessions led by a professional.", "12:00:00", "03:00:00", "Camp Query Forest", 20, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Capture the Flag", "5-18", "Join team to fight for the flag.", "05:00:00", "07:00:00", "Camp Query Forest", 20, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Conoeing and Kayaking", "10-18", "Learn basic paddling techniques and navigate through calm waters.", "11:00:00", "06:00:00", "Bigelow Lake", 35, NULL, NULL);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, /* activity_instructor */ capacity, activity_equipment, activity_session)
	VALUES ("Ropes Course", "7-18", "Use teamwork and survival skills to navigate a 100 foot high rope maze", "09:00:00", "12:00:00", "Camp Query Forest", 15, NULL, NULL);

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
	VALUES (13364, 'Brown', 'Jacob', 'Counselor', '(254) 644-9264' , 'jjb5@gmail.com', 'Allen Coyne (254) 622-6273', NULL, 'Kosher', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (90145, 'Patel', 'Alley', 'Counselor', '(814) 224-0293' , 'alleycat@gmail.com', 'Riya Patel (335) 645-7568', 'Wasp Venom' , NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (90146, 'Renick', 'Dylan', 'Junior Counselor', '(335) 222-0917' , 'doggylover@gmail.com', 'Terry Rennick (335) 657-6475' , NULL, 'Vegan', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (33456, 'Lennox', 'Owulatofu', 'Junior Counselor', '(254) 546-0192' , 'lennofu@gmail.com', 'Tanya Lennox (254) 546-7485', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11145, 'Addams', 'Tiara', 'Lead Chef', '(212) 543-9685' , 'tiaraaddams66@gmail.com', 'Diamond Addams (212) 647-6475', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11535, 'Gacy', 'Diya', 'Lifeguard', '(212) 536-7568' , 'dg664@gmail.com', 'Nona Gacy (212) 533-7529', 'Blueberries' , 'Halal', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11256, 'Gacy', 'Maya', 'Counselor', '(212) 536-7580' , 'mg647@gmail.com', 'Nona Gacy (212) 533-7529', 'Peanuts' , 'Halal' , 'Y');

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
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Red', 1, 17263);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Green', 2, 14577);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Blue', 3, 13562);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Violet', 4, 13338);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Silver', 5, 12567);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Gold', 6, 14777);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Black', 7, 13364);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Pink', 8, 90145);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Purple', 9, 90146);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Brown', 10, 33456);

    
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
    
#Insert data into transportation table
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Pine Grove", "SUV", 6, "N", 14777);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Pine Grove", "Bus", 30, "Y", 12567);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Sleepy Rocks", "SUV", 6, "N", 13562);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Sleepy Rocks", "SUV", 6, "N", 14777);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Portland Center", "Bus", 30, "Y", 33456);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Ruffaloville", "SUV", 6, "N", 11145);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Sailing", "Truck", 6, "N", 17263);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Sailing", "SUV", 6, "N", 13338);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Sailing", "Truck", 6, "N", 11535);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver)
	VALUES ("Piney Forest", "SUV", 6, "N", 13338);

-- Insert infromation into the supplies table
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Kayak", 17, "Brooklyn Kayak Company", 299.99, "2022-04-22", "2022-05-30");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Canoe", 5, "Brooklyn Kayak Company", 799.99, "2022-04-22", "2022-06-05");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Water Pillow", 1, "Inflatable-Zone", 1199.00, "2023-04-01", "2023-05-02");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Tent", 10, "Dick's Sporting Goods", 299.99, "2023-02-16", "2020-05-10");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Bicycle", 25, "Dick's Sporting Goods", 199.00, "2022-05-27", "2017-06-13");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Soccer Ball", 17, "Dick's Sporting Goods", 19.47, "2022-04-02", "2024-04-13");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Volleyball Net", 3, "Dick's Sporting Goods", 145.00, "2022-03-01", "2020-03-13");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Lifeguard Tower", 2, "American Lifeguard Products", 7250.00, "2022-04-10", "2019-02-19");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Archer  Kit", 20, "Dick's Sporting Goods", 195.00, "2022-04-12", "2010-09-22");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Baseball Kit", 20, "Dick's Sporting Goods", 35.89, "2022-04-13", "2011-08-09");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date)
	VALUES("Storage Shed", 1, "Home Depot", 5175.99, "2010-09-22", "2010-10-03");


-- Show the tables
SELECT * FROM activities;
SELECT * FROM cabins;
SELECT * FROM campers;
SELECT * FROM camper_groups;
SELECT * FROM guardians;
SELECT * FROM health_records;
SELECT * FROM sessions;
SELECT * FROM supplies;
SELECT * FROM staff;
SELECT * FROM transactions;
SELECT * FROM transportation;