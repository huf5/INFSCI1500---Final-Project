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
	activity_instructor INT,
    capacity INT, 
    CONSTRAINT fk_staff_staff_id_activites_activity_instructor FOREIGN KEY (activity_instructor) REFERENCES staff(staff_id)
) ENGINE INNODB;

-- Create cabins table
DROP TABLE IF EXISTS cabins;
CREATE TABLE cabins (
    cabin_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cabin_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    cab_group_id INT, 
    CONSTRAINT fk_camper_groups_group_id_cabins_cab_group_id FOREIGN KEY (cab_group_id) REFERENCES camper_groups(group_id)
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
    group_assignment INT NOT NULL, 
    CONSTRAINT fk_camper_groups_group_id_campers_group_assignment FOREIGN KEY (group_assignment) REFERENCES camper_groups (group_id)
) ENGINE INNODB;

-- Create camper_groups table
DROP TABLE IF EXISTS camper_groups;
CREATE TABLE camper_groups (
    group_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    group_name VARCHAR(50), 
    cg_cabin INT NOT NULL, 
    cg_staff INT NOT NULL, 
    CONSTRAINT fk_cabins_cabin_id_camper_groups_cg_cabin FOREIGN KEY (cg_cabin) REFERENCES cabins (cabin_id), 
    CONSTRAINT fk_staff_staff_id_camper_groups_cg_staff FOREIGN KEY (cg_staff) REFERENCES staff (staff_id)
) ENGINE INNODB;

-- Create guardians table
DROP TABLE IF EXISTS guardians;
CREATE TABLE guardians (
    guardian_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
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
    doctor_name VARCHAR(100),
    doctor_contact_number VARCHAR(20), 
    CONSTRAINT fk_campers_camper_id_health_records_camper_id FOREIGN KEY (camper_id) REFERENCES campers(camper_id)
) ENGINE INNODB;

-- Create sessions table
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
    session_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    theme VARCHAR(50) NOT NULL,
    enrollment_capacity INT NOT NULL,
    registration_deadline DATETIME NOT NULL,
    session_status VARCHAR(50) NOT NULL,
    session_fee INT NOT NULL
)ENGINE INNODB;

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
    weight DECIMAL(10,2),
    expiration_date DATE,
    category VARCHAR(50), 
    correction_date DATE
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
    trans_session INT NOT NULL, 
    CONSTRAINT fk_campers_camper_id_transactions_trans_camper FOREIGN KEY (trans_camper) REFERENCES campers (camper_id), 
    CONSTRAINT fk_sessions_session_id_transactions_trans_session FOREIGN KEY (trans_session) REFERENCES sessions (session_id)
) ENGINE INNODB;

-- Create transportation table
DROP TABLE IF EXISTS transportation;
CREATE TABLE transportation (
    transportation_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    route VARCHAR(50), 
    vehicle_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    wheelchair_accessible VARCHAR(10) NOT NULL,
    driver INT NOT NULL, 
    mileage DECIMAL(10,2),
    fuel_type VARCHAR(50),
    maintenance_status VARCHAR(50),
    CONSTRAINT fk_staff_staff_id_transportation_driver FOREIGN KEY (driver) REFERENCES staff(staff_id)
) ENGINE INNODB;

-- Create junction tables 
DROP TABLE IF EXISTS activity_equipment;
CREATE TABLE activity_equipment (
	e_activity_id INT, 
    item_id INT, 
    CONSTRAINT fk_activities_activity_id_activity_equipment_e_activity_id FOREIGN KEY (e_activity_id) REFERENCES activities(activity_id), 
    CONSTRAINT fk_supplies_item_id_activity_equipment_item_id FOREIGN KEY (item_id) REFERENCES supplies(item_id)
) ENGINE INNODB;

DROP TABLE IF EXISTS activity_session;
CREATE TABLE activity_session(
	s_activity_id INT, 
    session_id INT, 
    CONSTRAINT fk_activities_activity_id_activity_session_s_activity_id FOREIGN KEY (s_activity_id) REFERENCES activities(activity_id),
    CONSTRAINT fk_sessions_session_id_activity_session_session_id FOREIGN KEY (session_id) REFERENCES sessions (session_id)
)ENGINE INNODB;

DROP TABLE IF EXISTS guardian_children;
CREATE TABLE guardian_children(
	guardian_id INT, 
    camper_id INT,
    relationship_to_camper VARCHAR(50) NOT NULL,
    CONSTRAINT fk_guardians_guardian_id_guardian_children_guardian_id FOREIGN KEY (guardian_id) REFERENCES guardians (guardian_id),
    CONSTRAINT fk_campers_camper_id_guardian_children_camper_id FOREIGN KEY (camper_id) REFERENCES campers (camper_id)
)ENGINE INNODB;

DROP TABLE IF EXISTS staff_session;
CREATE TABLE staff_session(
	staff_id INT, 
    session_id INT, 
    CONSTRAINT fk_staff_staff_id_staff_session_staff_id FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    CONSTRAINT fk_sessions_session_id_staff_session_session_id FOREIGN KEY (session_id) REFERENCES sessions(session_id)
)ENGINE INNODB;


#Insert data into the activities table
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Nature Hike", "7-18", "Guided hike through nearby trails to explore local flora and fauna.", "09:00:00", "12:00:00", "Camp Query Forest", 17263, 20);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Campfire Smores", "5-18", "Gather around a campfire for storytelling and marshmallow roasting.", "8:00:00", "10:00:00", "Camp Query Town Hall", 14577, 200);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Arts and Crafts", "7-18", "Create personalized souvenirs using materials found in nature.", "09:00:00", "12:00:00", "Arts Center", 13562, 35);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Baseball", "7-18", "Play classic baseball team vs team", "02:00:00", "04:00:00", "Baseball Diamond", 13338, 22);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Volleyball", "7-18", "Play classic volleyball team vs team", "05:00:00", "07:00:00", "Bigelow Beach", 12567, 100);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Swimming and Water Sports", "5-18", "Enjoy swimming, water volleyball, or pillow jumping.", "12:00:00", "08:00:00", "Bigelow Lake", 14777, 20);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Photogrpahy Expidition", "5-18", "Capture the beauty of nature through photography sessions led by a professional.", "12:00:00", "03:00:00", "Camp Query Forest", 13364, 20);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor,capacity)
	VALUES ("Capture the Flag", "5-18", "Join team to fight for the flag.", "05:00:00", "07:00:00", "Camp Query Forest", 90145, 20);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Conoeing and Kayaking", "10-18", "Learn basic paddling techniques and navigate through calm waters.", "11:00:00", "06:00:00", "Bigelow Lake", 33456, 35);
INSERT INTO activities (activity_name, age_group, activity_desc, start_time, end_time, location, activity_instructor, capacity)
	VALUES ("Ropes Course", "7-18", "Use teamwork and survival skills to navigate a 100 foot high rope maze", "09:00:00", "12:00:00", "Camp Query Forest", 11256, 15);

# Insert data into activity_equipment
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (1, 12);
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (1, 4);
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (6, 1);
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (6, 2);
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (6, 3);
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (4, 10);
INSERT INTO activity_equipment(e_activity_id, item_id)
	VALUES (5, 7);

    
# INsert data into activity_session
INSERT into activity_session(s_activity_id, session_id)
	VALUES(1, 1);
INSERT into activity_session(s_activity_id, session_id)
	VALUES(1, 2);
INSERT into activity_session(s_activity_id, session_id)
	VALUES(1, 3);
INSERT into activity_session(s_activity_id, session_id)
	VALUES(1, 4);
INSERT into activity_session(s_activity_id, session_id)
	VALUES(1, 5);
INSERT into activity_session(s_activity_id, session_id)
	VALUES(2, 2);
INSERT into activity_session(s_activity_id, session_id)
	VALUES(3, 1);


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
	VALUES (11145, 'Addams', 'Tiara', 'Chef', '(212) 543-9685' , 'tiaraaddams66@gmail.com', 'Diamond Addams (212) 647-6475', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11535, 'Gacy', 'Diya', 'Counselor ', '(212) 536-7568' , 'dg664@gmail.com', 'Nona Gacy (212) 533-7529', 'Blueberries' , 'Halal', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11256, 'Gacy', 'Maya', 'Counselor', '(212) 536-7580' , 'mg647@gmail.com', 'Nona Gacy (212) 533-7529', 'Peanuts' , 'Halal' , 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (22345, 'Smith', 'Emily', 'Camper Coordinator', '(412) 555-5555', 'emilysmith@example.com', 'John Smith (412) 555-5556', NULL, 'Vegetarian', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (64736, 'Johnson', 'David', 'Counselor', '(412) 555-5557', 'davidjohnson@example.com', 'Jane Johnson (412) 555-5558', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (01926, 'Williams', 'Jessica', 'Counselor', '(412) 555-5559', 'jessicawilliams@example.com', 'Jack Williams (412) 555-5560', NULL, 'Gluten-Free', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (84753, 'Brown', 'Michael', 'Chef', '(212) 555-5561', 'michaelbrown@example.com', 'Michelle Brown (212) 555-5562', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (00925, 'Jones', 'Jennifer', 'Junior Lifeguard', '(412) 555-5563', 'jenniferjones@example.com', 'Jason Jones (412) 555-5564', NULL, 'Kosher', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11134, 'Miller', 'Daniel', 'Counselor', '(812) 555-5565', 'danmiller@example.com', 'Diane Miller (512) 555-5566', NULL, 'Vegan', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (21101, 'Davis', 'Ashley', 'Camp Director', '(758) 555-5567', 'ashleydavis@example.com', 'Adam Davis (755) 555-5568', 'Shellfish', NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (23312, 'Garcia', 'Christopher', 'Junior Counselor', '(162) 555-5569', 'chrisgarcia@example.com', 'Christina Garcia (536) 555-5570', 'Eggs', NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (19453, 'Rodriguez', 'Megan', 'Kitchen Manager', '(143) 555-5571', 'meganrodriguez@example.com', 'Miguel Rodriguez (758) 555-5572', 'Milk', 'Halal', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (19463, 'Martinez', 'Joseph', 'Janitor', '(756) 555-5573', 'josephmartinez@example.com', 'Julia Martinez (756) 555-5574', 'Soy', 'Kosher', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (10994, 'Hernandez', 'Samantha', 'Janitor', '(645) 555-5575', 'samanthahernandez@example.com', 'Samuel Hernandez (645) 555-5576', NULL, 'Pescatarian', 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (19884, 'Lopez', 'Matthew', 'Janitor', '(354) 555-5577', 'matthewlopez@example.com', 'Maria Lopez (354) 555-5578', 'Pollen', 'Vegan', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (17264, 'Gonzalez', 'Amanda', 'Janitor', '(647) 555-5579', 'amandagonzalez@example.com', 'Alex Gonzalez (647) 555-5580', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (10006, 'Wilson', 'Andrew', 'Maintenance', '(098) 555-5581', 'andrewwilson@example.com', 'Anna Wilson (098) 555-5582', 'Peanuts', NULL, 'Y');

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


#Insert into campers
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Johnson', 'Rita', 'F', '2008-05-15', '123 Maple Street, Pleasantville, USA', '1827463758', 'None', 'None', 'None', 1);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Smith', 'James', 'M', '2007-09-20', '456 Elm Avenue, Springtown, USA', '1986264783', 'Peanuts', 'None', 'None', 9);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Brown', 'Tyler', 'F', '2009-03-10', '789 Oak Drive, Lakeside, USA', '2123456109', 'None', 'None', 'None', 10);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Williams', 'Jamie', 'M', '2007-07-02', '101 Pine Lane, Meadowbrook, USA', '7463889946', 'None', 'None', 'None', 7);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Davis', 'Poet', 'M', '2009-12-18', '234 Cedar Court, Riverside, USA', '0927364885', 'None', 'None', 'None', 2);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Martinez', 'Wrook', 'M', '2008-08-30', '67 Birch Road, Hillside, USA', '6473829003', 'None', 'None', 'None', 10);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Taylor', 'AJ', 'M', '2007-06-25', '12890 Willow Way, Brookside, USA', '8594728375', 'None', 'None', 'Vegan', 1);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Rodriguez', 'Jackson', 'M', '2010-01-05', '2 Ash Street, Sunnyside, USA', '6471927483', 'None', 'None', 'None', 2);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Anderson', 'Logan', 'F', '2009-04-12', '1295 Sycamore Place, Forest Hills, USA', '1928463726', 'None', 'None', 'None', 3);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Jones', 'Peyton', 'F', '2008-10-08', '5784 Magnolia Terrace, Mountain View, USA', '1746372893', 'None', 'None', 'None', 8);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Jones', 'Davis', 'M', '2008-10-08', '5784 Magnolia Terrace, Mountain View, USA', '1746372893', 'None', 'None', 'Vegan', 1);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Williams', 'Emma', 'F', '2009-08-25', '789 Pine Street, Brookfield, USA', '8091234567', 'None', 'None', 'Gluten Free', 1);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Martin', 'Ethan', 'M', '2008-07-15', '56775 Elm Avenue, Springdale, USA', '3948571620', 'None', 'None', 'None', 1);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Garcia', 'Miles', 'M', '2009-04-30', '8900 Cedar Lane, Lakeside, USA', '5768901234', 'None', 'None', 'None', 1);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Rodriguez', 'Noah', 'M', '2012-09-20', '1203 Maple Street, Pleasantville, USA', '1827463758', 'None', 'None', 'None', 2);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Clark', 'Ava', 'F', '2009-03-10', '456B Elm Avenue, Springtown, USA', '1986264783', 'None', 'None', 'Lactose Intolerant/No Dairy', 2);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Harris', 'Elijah', 'M', '2006-07-02', '78911 Oak Drive, Lakeside, USA', '2123456109', 'None', 'None', 'None', 2);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Brown', 'Sophia', 'F', '2006-08-15', '101C Pine Lane, Meadowbrook, USA', '7463889946', 'None', 'None', 'None', 3);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Martinez', 'Lucas', 'M', '2008-12-18', '23402 Cedar Court, Riverside, USA', '0927364885', 'None', 'None', 'None', 3);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Taylor', 'Olivia', 'F', '2007-06-25', '67285 Birch Road, Hillside, USA', '6473829003', 'None', 'None', 'No Dairy', 3);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Davis', 'William', 'M', '2009-01-05', '12890 Willow Way, Brookside, USA', '8594728375', 'Pollen', 'None', 'None', 4);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Jones', 'Payton', 'M', '2008-04-12', '2936 Ash Street, Sunnyside, USA', '6471927483', 'Bees/Wasp Venom', 'None', 'None', 4);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Wilson', 'Jackson', 'M', '2010-04-08', '12957 Sycamore Place, Forest Hills, USA', '1928463726', 'None', 'None', 'None', 4);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Anderson', 'Charlie', 'M', '2009-05-03', '57444 Magpie Lane, Mountain View, USA', '1746372893', 'None', 'None', 'None', 5);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Brown', 'Benjamin', 'M', '2010-10-08', '456037 Pine Avenue, Lakeside, USA', '1746372893', 'None', 'None', 'None', 5);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('White', 'Amelia', 'F', '2010-10-08', '57849 Magnolia Terrace, Mountain View, USA', '1746372893', 'None', 'None', 'None', 5);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Thomas', 'Jacob', 'M', '2012-11-30', '78900 Oak Lane, Hilltop, USA', '2468013579', 'None', 'None', 'None', 6);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Jackson', 'Evelyn', 'F', '2013-02-10', '101000 Cedar Avenue, Oakwood, USA', '7080912345', 'None', 'None', 'None', 6);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Lee', 'Daniella', 'F', '2008-08-20', '56701 Birch Drive, Maplewood, USA', '1234567890', 'None', 'None', 'None', 6);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Taylor', 'Aria', 'F', '2013-04-10', '89001 Cedar Lane, Springdale, USA', '3948571620', 'Tree Nuts', 'None', 'None', 7);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Harris', 'Alexander', 'M', '2008-08-20', '1283 Oak Avenue, Riverside, USA', '2850374912', 'None', 'None', 'None', 7);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Brown', 'Grace', 'F', '2009-10-02', '45116 Cedar Lane, Springdale, USA', '3948571620', 'Onions', 'None', 'None', 7);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Martinez', 'Ethan', 'M', '2008-12-05', '19789 Pine Street, Brookfield, USA', '8091234567', 'None', 'None', 'None', 8);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Jones', 'Abigail', 'F', '2009-07-20', '13567 Elm Avenue, Springdale, USA', '3948571620', 'None', 'None', 'None', 8);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Wilson', 'Jamie', 'F', '2008-08-30', '89330 Cedar Lane, Lakeside, USA', '5768901234', 'None', 'None', 'None', 8);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Brown', 'Charlotte', 'F', '2006-09-15', '10331 Pine Lane, Meadowbrook, USA', '7463889946', 'None', 'None', 'None', 9);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Martinez', 'Benjamin', 'M', '2007-11-18', '83234 Cedar Court, Riverside, USA', '0927364885', 'Mushroom', 'None', 'None', 9);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Taylor', 'Sophia', 'F', '2007-06-25', '65767 Birch Road, Hillside, USA', '6473829003', 'None', 'None', 'None', 9);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Rodriguez', 'Darlene', 'F', '2011-08-05', '10012 Maple Street, Pleasantville, USA', '1827463758', 'None', 'None', 'None', 10);
INSERT INTO campers (last_name, first_name, gender, DOB, home_address, emergency_contact, allergies, special_needs, dietary_restrictions, group_assignment)
	VALUES ('Harris', 'Ethan', 'M', '2007-07-02', '30789 Oak Drive, Lakeside, USA', '2123456109', 'None', 'None', 'None', 10);




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


#Insert into guardians
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Johnson", "Emily",  "123 Maple Street, Pleasantville, USA", "1827463758", "ejohn12@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Smith", "Alexander", "456 Elm Avenue, Springtown, USA", "1986264783", "stardude92@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Brown", "Jessica", "789 Oak Drive, Lakeside, USA", "2123456109", "swfity77@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Williams", "Matthew", "101 Pine Lane, Meadowbrook, USA", "7463889946", "matt.williams92@yahoo.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Davis", "John", "234 Cedar Court, Riverside, USA", "0927364885", "jd.adams@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Martinez", "Travis", "67 Birch Road, Hillside, USA", "6473829003", "travdawg@hotmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Taylor", "Sammy", "12890 Willow Way, Brookside, USA", "8594728375", "samantha.taylor99@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Rodriguez", "Joseph", "2 Ash Street, Sunnyside, USA", "6471927483", "hotrod@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Anderson", "Grace", "1295 Sycamore Place, Forest Hills, USA", "1928463726", "grace.anderson66@gmail.com");
INSERT INTO guardians (last_name, first_name, home_address, phone_number, email)
	VALUES ("Jones", "Isabella", "5784 Magnolia Terrace, Mountain View, USA", "1746372893", "jlicious3@gmail.com");


#Insert into guardian_children
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (1, 1, "Mother");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (2, 2, "Brother");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (3, 3, "Aunt");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (4, 4, "Father");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (5, 5, "Guardian");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (6, 6, "Father");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (7, 7, "Sister");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (8, 8, "Father");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (9, 9, "Mother");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (10, 10, "Mother");
INSERT INTO guardian_children (guardian_id, camper_id, relationship_to_camper)
	VALUES (10, 11, "Mother");

   
#Insert data into into the sessions table
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-02', '2024-06-08', 'Elementary', 75, '2024-05-15 11:59:00', 'OPEN', 225.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-02', '2024-06-12', 'Middle School Extended', 100, '2024-05-15 11:59:00', 'OPEN', 430.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-09', '2024-06-15', 'Performing Arts', 100, '2024-05-20 11:59:00', 'OPEN', 350.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-09', '2024-06-15', 'Fine Arts', 100, '2024-05-15 11:59:00', 'FULL', 225.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-20', '2024-06-25', 'Pre-K and Kinder', 75, '2024-05-15 11:59:00', 'OPEN', 150.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-07-01', '2024-07-30', 'High School Extended', 125, '2024-05-15 11:59:00', 'FULL', 1300.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-07-01', '2024-07-15', 'High School', 75, '2024-05-15 11:59:00', 'FULL', 700.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-08-01', '2024-08-15', 'Adult', 25, '2024-05-15 11:59:00', 'FULL', 500.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-08-01', '2024-08-15', 'Elementary', 75, '2024-05-15 11:59:00', 'OPEN', 475.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-12-27', '2025-01-07', 'Performing Arts', 50, '2024-10-15 11:59:00', 'REGISTRATION SOON', 575.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-12-27', '2025-01-07', 'Fine Arts', 50, '2024-10-15 11:59:00', 'REGISTRATION SOON', 575.00);

-- Transportation
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Pine Grove", "SUV", 6, "N", 14777, 35000.00, "Gasoline", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Pine Grove", "Bus", 30, "Y", 12567, 70000.00, "Diesel", "Needs Service");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Sleepy Rocks", "SUV", 6, "N", 13562, 45000.00, "Gasoline", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Sleepy Rocks", "SUV", 6, "N", 14777, 48000.00, "Gasoline", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Portland Center", "Bus", 30, "Y", 33456, 60000.00, "Diesel", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Ruffaloville", "SUV", 6, "N", 11145, 30000.00, "Gasoline", "Needs Service");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Sailing", "Truck", 6, "N", 17263, 55000.00, "Diesel", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Sailing", "SUV", 6, "N", 13338, 40000.00, "Gasoline", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Sailing", "Truck", 6, "N", 11535, 48000.00, "Diesel", "Good");
INSERT INTO transportation (route, vehicle_type, capacity, wheelchair_accessible, driver, mileage, fuel_type, maintenance_status)
	VALUES ("Piney Forest", "SUV", 6, "N", 13338, 32000.00, "Gasoline", "Good");


-- Insert into supplies table
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Kayak", 17, "Brooklyn Kayak Company", 299.99, "2022-04-22", "2022-05-30", NULL, 30.5, NULL, "Water Sports");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Canoe", 5, "Brooklyn Kayak Company", 799.99, "2022-04-22", "2022-06-05", NULL, 45.8, NULL, "Water Sports");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Water Pillow", 1, "Inflatable-Zone", 1199.00, "2023-04-01", "2023-05-02", NULL, NULL, NULL, "Camping");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Tent", 10, "Dick's Sporting Goods", 299.99, "2023-02-16", "2020-05-10", NULL, NULL, NULL, "Camping");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Bicycle", 25, "Dick's Sporting Goods", 199.00, "2022-05-27", "2017-06-13", NULL, NULL, NULL, "Cycling");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Soccer Ball", 17, "Dick's Sporting Goods", 19.47, "2022-04-02", "2024-04-13", NULL, NULL, NULL, "Sports");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Volleyball Net", 3, "Dick's Sporting Goods", 145.00, "2022-03-01", "2020-03-13", NULL, NULL, NULL, "Sports");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Lifeguard Tower", 2, "American Lifeguard Products", 7250.00, "2022-04-10", "2019-02-19", NULL, NULL, NULL, "Beach Equipment");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Archer Kit", 20, "Dick's Sporting Goods", 195.00, "2022-04-12", "2010-09-22", NULL, NULL, NULL, "Sports");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Baseball Kit", 20, "Dick's Sporting Goods", 35.89, "2022-04-13", "2011-08-09", NULL, NULL, NULL, "Sports");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Storage Shed", 1, "Home Depot", 5175.99, "2010-09-22", "2010-10-03", NULL, NULL, NULL, "Storage");
INSERT INTO supplies (item_name, quantity, supplier, cost, order_date, delivery_date, correction_date, weight, expiration_date, category)
	VALUES("Backpacks", 30, "Dick's Sporting Goods", 35.99, "2024-04-01", "2010-04-13", NULL, NULL, NULL, "Outdoor Gear");


# Insert into health record
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(1, 4.11, 82.5, "A-", "Bee/Wasp Venom", NULL, "Asthma", "Cheryll Warner", 1756472837);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(2, 5.0, 92.0, "A-", NULL, "Prozac", NULL, "Dr. Tommy Maddox", 1435967250);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(3, 5.3, 74.0, "B+", NULL , "Adderall", NULL, "Dr. Bill Moore", 6473895617); 
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(4, 4.9, 75.4, "O-", NULL , NULL, NULL, "Dr. Stephen Lancaster", 8887564710);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(5, 4.11, 80.45, "AB-", "Peanuts", NULL, "Gastrparesis", "Maya Sayler", 5264738465);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(6, 4.11, 100.6, "AB-", "Dairy", NULL, NULL, "Dr. Cheryll Lang", 6574911164);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(7, 4.2, 72.5, "AB-", NULL, "Adderall", NULL , "Dr. Berkley May", 9887564002);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(8, 4.10, 86.2, "A+", "Gluten", "Adderall", NULL, "Dr. Sol Clementine", 7564739002);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(9, 5.4, 110.6, "B-", "Bee/Wasp Venom", NULL, NULL, "Dr. Blake Atwood", 8695847152);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES(10, 5.1, 89.5, "A+", NULL , "Strattera", "Ehlers Danlos", "Dr. Jenn Werner", 546372978);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (11, 4.9, 73.2, 'B-', NULL, NULL, 'Eczema', 'Dr. Mia Adams', 2348765432);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (12, 4.8, 68.7, 'A+', 'Shellfish', NULL, 'Asthma', 'Dr. Benjamin Scott', 3457654321);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (13, 4.7, 72.3, 'AB+', 'Pollen', 'Allegra', NULL, 'Dr. Madison Clark', 4566543210);	
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (14, 4.9, 70.1, 'O+', 'Dairy', NULL, 'Asthma', 'Dr. Ethan Roberts', 5675432109);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (15, 5.0, 75.8, 'B-', 'Peanuts', 'Claritin', NULL, 'Dr. Zoe Johnson', 6784321098);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (16, 4.8, 69.5, 'A+', NULL, 'Flonase', 'Diabetes', 'Dr. Leo Wright', 7893210987);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (17, 4.7, 67.9, 'AB+', 'Shellfish', 'Benadryl', 'Asthma', 'Dr. Layla Mitchell', 8902109876);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (18, 5.1, 76.4, 'O-', NULL, 'Zyrtec', 'Epilepsy', 'Dr. Ryder Perez', 9010987654);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (19, 4.9, 72.2, 'B+', 'Pollen', NULL, 'ADHD', 'Dr. Hannah Lewis', 1234567890);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (20, 4.8, 70.5, 'A-', NULL, NULL, 'Asthma', 'Dr. Mason Hall', 2345678901);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (21, 5.0, 74.6, 'AB-', NULL, NULL, 'Diabetes', 'Dr. Avery Phillips', 3456789012);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (22, 4.7, 68.9, 'O+', NULL, NULL, NULL, 'Dr. Peyton Turner', 4567890123);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (23, 4.8, 72.1, 'B-', 'Dairy', 'Ventolin', 'Asthma', 'Dr. Skylar Hughes', 5678901234);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (24, 5.1, 78.3, 'A+', NULL, NULL, 'ADHD', 'Dr. Riley Foster', 6789012345);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (25, 4.8, 69.7, 'AB+', 'Pollen', 'Claritin', 'Asthma', 'Dr. Morgan Coleman', 7890123456);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (26, 4.9, 71.3, 'O-', NULL, 'Zyrtec', 'Eczema', 'Dr. Jordan Diaz', 8901234567);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (27, 4.8, 68.5, 'A+', NULL, NULL, NULL, 'Dr. Riley Perry', 9012345678);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (28, 5.0, 76.9, 'B-', 'Peanuts', NULL, NULL, 'Dr. Taylor Ward', 1239876543);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (29, 4.7, 70.2, 'A-', 'Shellfish', NULL, 'Asthma', 'Dr. Reese Murphy', 2348765432);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (30, 4.8, 73.1, 'O+', 'Dairy', NULL, NULL, 'Dr. Rowan Ellis', 3457654321);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (31, 4.9, 70.8, 'A+', 'Pollen', NULL, NULL, 'Dr. Finley Barker', 4566543210);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (32, 4.8, 69.2, 'AB+', 'Shellfish', NULL, 'Diabetes', 'Dr. Avery Hayes', 5675432109);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (33, 4.9, 71.7, 'O-', NULL, NULL, 'Asthma', 'Dr. Morgan Simpson', 6784321098);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (34, 5.0, 76.3, 'B+', 'Pollen', NULL, 'ADHD', 'Dr. Hayden Armstrong', 7893210987);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (35, 4.8, 72.4, 'A-', NULL, NULL, 'Asthma', 'Dr. Sydney Fitzgerald', 8902109876);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (36, 5.0, 75.2, 'AB-', NULL, 'Flonase', 'Diabetes', 'Dr. Cameron Willis', 9010987654);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (37, 4.9, 71.1, 'O+', 'Peanuts', NULL, NULL, 'Dr. Kendall Price', 1234567890);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (38, 4.8, 69.9, 'B-', 'Dairy',NULL , NULL, 'Dr. Jordan Peterson', 2345678901);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (39, 4.9, 72.6, 'A+', NULL, NULL, NULL, 'Dr. Cameron Bell', 3456789012);
INSERT INTO health_records (camper_id, height, weight, blood_type, allergies, medications, medical_conditions, doctor_name, doctor_contact_number)
	VALUES (40, 4.8, 70.3, 'AB+', 'Shellfish', NULL, NULL, 'Dr. Kendall Howard', 4567890123);

#Insert into staff_session
INSERT INTO staff_session (staff_id, session_id)
	VALUES (17263, 6), (17263, 3), (17263, 10), (17263, 1), (17263, 7), (17263, 11);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (14577, 9), (14577, 4), (14577, 2), (14577, 8), (14577, 5), (14577, 1);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (13562, 3), (13562, 8), (13562, 4), (13562, 11), (13562, 9), (13562, 6);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (13338, 10), (13338, 6), (13338, 5), (13338, 2), (13338, 8), (13338, 7);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (12567, 4), (12567, 1), (12567, 7), (12567, 10), (12567, 9), (12567, 11);
INSERT INTO staff_session (staff_id, session_id)
	VALUES(14777, 1), (14777, 5), (14777, 9), (14777, 6), (14777, 3), (14777, 8);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (13364, 2), (13364, 10), (13364, 8), (13364, 4), (13364, 11), (13364, 5);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (11535, 6), (11535, 8), (11535, 2), (11535, 7), (11535, 10), (11535, 4);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (11256, 3), (11256, 7), (11256, 1), (11256, 9), (11256, 11), (11256, 6);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (22345, 10), (22345, 7), (22345, 6), (22345, 5), (22345, 3), (22345, 2);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (64736, 3), (64736, 9), (64736, 5), (64736, 7), (64736, 2), (64736, 4);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (01926, 4), (01926, 5), (01926, 10), (01926, 7), (01926, 8), (01926, 3);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (84753, 1), (84753, 6), (84753, 4), (84753, 8), (84753, 11), (84753, 10);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (11145, 5), (11145, 1), (11145, 4), (11145, 9), (11145, 2), (11145, 10);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (33456, 1), (33456, 9), (33456, 7), (33456, 11), (33456, 3), (33456, 5);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (90146, 7), (90146, 2), (90146, 10), (90146, 8), (90146, 11), (90146, 1);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (90145, 11), (90145, 3), (90145, 6), (90145, 1), (90145, 10), (90145, 5);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (10994, 8), (10994, 11), (10994, 3), (10994, 5), (10994, 7), (10994, 1);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (19463, 10), (19463, 1), (19463, 9), (19463, 6), (19463, 3), (19463, 5);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (19453, 6), (19453, 4), (19453, 9), (19453, 2), (19453, 11), (19453, 7);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (23312, 11), (23312, 10), (23312, 1), (23312, 6), (23312, 3), (23312, 7);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (21101, 9), (21101, 5), (21101, 6), (21101, 10), (21101, 8), (21101, 7);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (11134, 6), (11134, 8), (11134, 4), (11134, 10), (11134, 3), (11134, 1);
INSERT INTO staff_session (staff_id, session_id)
	VALUES (00925, 2), (00925, 5), (00925, 3), (00925, 8), (00925, 7), (00925, 9);
    
#insert into transactions table
INSERT INTO transactions (transaction_id,transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (64537, "Deposit", 150.00, "2024-02-13 11:35:56", "Credit", 1, 2);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (69213, "Deposit", 190.67, "2024-02-24 15:12:34", "Credit", 14, 6);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (80541, "Deposit", 123.45, "2024-03-01 09:45:21", "Credit", 29, 9);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (50736, "Deposit", 87.32, "2024-02-18 14:27:55", "Credit", 11, 3);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (92083, "Deposit", 220.15, "2024-03-10 11:20:48", "Credit", 36, 10);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (41897, "Deposit", 167.89, "2024-02-21 08:53:17", "Credit", 8, 5);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (62384, "Deposit", 96.74, "2024-02-27 17:38:09", "Credit", 21, 8);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (31509, "Deposit", 175.28, "2024-02-20 10:05:42", "Credit", 4, 4);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (72960, "Deposit", 134.56, "2024-03-03 13:47:29", "Credit", 16, 1);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (15820, "Deposit", 201.92, "2024-02-15 12:30:00", "Credit", 1, 7);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (43925, "Deposit", 112.84, "2024-02-29 14:16:23", "Credit", 5, 2);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (28934, "Deposit", 185.39, "2024-02-23 16:59:08", "Credit", 10, 11);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (81752, "Deposit", 140.23, "2024-03-04 09:10:54", "Credit", 23, 6);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (56271, "Deposit", 197.61, "2024-02-25 11:26:36", "Credit", 12, 9);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (96237, "Deposit", 103.47, "2024-03-12 08:15:12", "Credit", 31, 3);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (37915, "Deposit", 209.75, "2024-02-19 14:45:03", "Credit", 7, 10);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (67148, "Deposit", 125.89, "2024-02-28 13:04:17", "Credit", 19, 5);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (20457, "Deposit", 178.32, "2024-02-16 10:27:58", "Credit", 2, 1);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (59382, "Deposit", 130.67, "2024-02-26 09:36:44", "Credit", 13, 8);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (84126, "Deposit", 194.45, "2024-03-06 14:58:31", "Credit", 26, 3);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (72369, "Deposit", 98.32, "2024-03-02 11:35:26", "Credit", 15, 7);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (35782, "Deposit", 203.15, "2024-02-17 12:48:37", "Credit", 6, 4);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (98423, "Deposit", 118.49, "2024-03-14 10:20:09", "Credit", 33, 11);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (63214, "Deposit", 192.87, "2024-02-29 09:03:50", "Credit", 20, 9);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (89571, "Deposit", 115.78, "2024-03-07 15:12:34", "Credit", 28, 6);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (54123, "Deposit", 200.63, "2024-02-20 08:59:21", "Credit", 9, 1);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (78294, "Deposit", 106.94, "2024-03-01 10:26:17", "Credit", 24, 8);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (41325, "Deposit", 215.28, "2024-02-22 14:07:42", "Credit", 7, 5);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (67284, "Deposit", 129.56, "2024-03-03 11:34:29", "Credit", 18, 2);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (24938, "Deposit", 197.92, "2024-02-15 09:45:00", "Credit", 3, 10);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (96472, "Deposit", 108.84, "2024-02-28 11:36:23", "Credit", 32, 4);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (53147, "Deposit", 191.39, "2024-02-23 08:58:08", "Credit", 11, 7);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (81273, "Deposit", 120.23, "2024-03-05 12:10:54", "Credit", 25, 4);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (68319, "Deposit", 187.61, "2024-02-24 10:16:36", "Credit", 14, 11);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (92468, "Deposit", 101.47, "2024-03-13 07:15:12", "Credit", 30, 2);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (39758, "Deposit", 205.75, "2024-02-18 13:45:03", "Credit", 8, 9);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (74582, "Deposit", 119.89, "2024-02-27 12:04:17", "Credit", 22, 6);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (21347, "Deposit", 180.32, "2024-02-16 09:27:58", "Credit", 3, 3);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (60492, "Deposit", 135.67, "2024-02-25 08:36:44", "Credit", 15, 10);
INSERT INTO transactions (transaction_id, transaction_type, amount, transaction_date, payment_type, trans_camper, trans_session)
	VALUES (86421, "Deposit", 198.45, "2024-03-08 13:58:31", "Credit", 27, 5);

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

SELECT * FROM activity_equipment;
SELECT * FROM activity_session;
SELECT * FROM guardian_children;
SELECT * FROM staff_session;

