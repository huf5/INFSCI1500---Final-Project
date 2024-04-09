USE group_camp_query;

-- Create staff table
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

-- Create transactions table
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    transaction_type VARCHAR(20),
    amount INT,
    transaction_date DATETIME,
	payment_type VARCHAR(20), 
    trans_camper INT NOT NULL, 
    trans_session INT NOT NULL, 
    CONSTRAINT fk_trans_camper
    FOREIGN KEY (trans_camper)
    REFERENCES campers (camper_id), 
    CONSTRAINT fk_trans_session
    FOREIGN KEY (trans_session)
    REFERENCES sessions (session_id)
)ENGINE INNODB;

-- Alter transactions to includes foreign keys and drop if created
-- ALTER TABLE transactions DROP FOREIGN KEY fk_trans_camper;
-- ALTER TABLE transactions DROP FOREIGN KEY fk_trans_session;
    


-- Create campers table
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
    dietary_restrictions VARCHAR(200) NOT NULL,
    guardian INT NOT NULL, 
    group_assignment INT NOT NULL
) ENGINE INNODB;

-- ALTER campers table to add guardian fk and drop if exists
ALTER TABLE campers
	ADD CONSTRAINT fk_guardian
    FOREIGN KEY (guardian)
    REFERENCES guardians (guardian_id);
  
ALTER TABLE campers
	ADD CONSTRAINT fk_group_assignment
    FOREIGN KEY (group_assignment)
    REFERENCES camper_groups (group_id);
    
ALTER TABLE campers DROP FOREIGN KEY fk_group_assignment;
ALTER TABLE campers DROP FOREIGN KEY fk_guardian;

    
    

-- Create guradians table
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

-- Create cabins table
DROP TABLE IF EXISTS cabins;
CREATE TABLE cabins(
	cabin_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cabin_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    group_id INT
)ENGINE INNODB;

-- ALTER cabins table to add fk and drop if made already. 
ALTER TABLE cabins 
	ADD CONSTRAINT fk_groups
    FOREIGN KEY (group_id)
    REFERENCES camper_groups(group_id); 

ALTER TABLE cabins DROP FOREIGN KEY fk_groups;

-- Create camper_groups table adn alter table to add fk and drop the fk
DROP TABLE IF EXISTS camper_groups;
CREATE TABLE camper_groups(
	group_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    group_name VARCHAR(50), 
    cg_cabin INT NOT NULL, 
    cg_staff INT NOT NULL
)ENGINE INNODB;

ALTER TABLE camper_groups 
	ADD CONSTRAINT fk_cg_cabin
    FOREIGN KEY (cg_cabin)
    REFERENCES cabins (cabin_id);

ALTER TABLE camper_groups 
	ADD CONSTRAINT fk_cg_staff
    FOREIGN KEY (cg_staff)
    REFERENCES staff (staff_id);
    
ALTER TABLE camper_groups DROP FOREIGN KEY fk_cg_cabin;
ALTER TABLE camper_groups DROP FOREIGN KEY fk_cg_staff;


-- create sessions table and add fk
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions(
	session_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    theme VARCHAR(50) NOT NULL,
    enrollment_capacity INT NOT NULL,
    registration_deadline DATE NOT NULL,
    session_status VARCHAR(50) NOT NULL,
    session_fee INT NOT NULL, 
    s_group INT,
    CONSTRAINT fk_session_gid
    FOREIGN KEY (s_group)
    REFERENCES camper_groups (group_id)
)ENGINE INNODB;

ALTER TABLE sessions DROP FOREIGN KEY fk_session_gid;

-- create transportation table
DROP TABLE IF EXISTS transportation;
CREATE TABLE transportation(
	vehicle_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    route VARCHAR(50), 
    vehicle_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    wheelchair_accesssible VARCHAR(1) NOT NULL,
    driver INT NOT NULL
    -- FOREIGN KEY (driver) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE INNODB;


-- ALTER transportation table to add fk and drop if made already. 
ALTER TABLE transportation
	ADD CONSTRAINT fk_driver
	FOREIGN KEY (driver)
	REFERENCES staff(staff_id);
    
ALTER TABLE transportation DROP FOREIGN KEY fk_driver;


-- Create supplies table and add fk and drop it
DROP TABLE IF EXISTS supplies; 
CREATE TABLE supplies(
	item_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL, 
    quantity INT NOT NULL, 
    supplier VARCHAR(100) NOT NULL, 
    cost INT NOT NULL, 
    order_date DATETIME NOT NULL, 
    delivery_date DATETIME NOT NULL
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
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Rainbow', 11, 11145);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Orange', 12, 11535);
INSERT INTO camper_groups (group_name, cg_cabin, cg_staff)
	VALUES ('Indigo', 13, 11256);
    
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
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Pine Grove", "SUV", 6, "N", 14777);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Pine Grove", "Bus", 30, "Y", 12567);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Sleepy Rocks", "SUV", 6, "N", 13562);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Sleepy Rocks", "SUV", 6, "N", 14777);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Portland Center", "Bus", 30, "Y", 33456);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Ruffaloville", "SUV", 6, "N", 11145);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Sailing", "Truck", 6, "N", 17263);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Sailing", "SUV", 6, "N", 13338);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
	VALUES ("Sailing", "Truck", 6, "N", 11535);
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accesssible, driver)
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
SELECT * FROM staff;
SELECT * FROM transactions;

SELECT * FROM campers;
SELECT * FROM guardians;

SELECT * FROM cabins;
SELECT * FROM camper_groups;
SELECT * FROM sessions;

SELECT * FROM transportation;

SELECT * FROM supplies;