USE group_camp_query;

#Inserting into staff
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (17263, 'Adams', 'James', 'Counselor', '(254) 644-6473' , 'jaddams5@gmail.com', 'Jeremy Adams (254) 644-6179', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (14577, 'Allen', 'Jaci', 'Counselor', '(771) 653-2167' , 'kittyluver92.com', NULL, 'Peanuts', 'Vegetarian', 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (13562, 'Jones', 'Helen', 'Activity Coordinator', '(536) 453-6473' , 'jones.helen@gmail.com', 'Jaci Jones (536) 453-6479', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (13338, 'Gilly', 'Cynthia', 'Activity Coordinator', '(536) 222-6373' , 'cynthia.gilly@gmail.com', NULL , NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (12567, 'Flores', 'Zuri', 'Junior Counselor', '(212) 254-6473' , 'zz42@gmail.com', NULL, NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (14777, 'Xu', 'Marisol', 'Counselor', '(223) 256-7584' , 'kittykat66@gmail.com', 'Jeremy Fennel (912) 647-7334', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (13364, 'Brown', 'Jacob', 'Counselor', '(254) 644-9264' , 'jjb5@gmail.com', 'Allen Coyne (254) 622-6273', NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (90145, 'Patel', 'Alley', 'Counselor', '(814) 224-0293' , 'alleycat@gmail.com', 'Riya Patel (335) 645-7568', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (90146, 'Renick', 'Dylan', 'Junior Counselor', '(335) 222-0917' , 'doggylover@gmail.com', 'Terry Rennick (335) 657-6475' , NULL, NULL, 'Y');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (33456, 'Lennox', 'Owulatofu', 'Junior Counselor', '(254) 546-0192' , 'lennofu@gmail.com', 'Tanya Lennox (254) 546-7485', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11145, 'Addams', 'Tiara', 'Lead Chef', '(212) 543-9685' , 'tiaraaddams66@gmail.com', 'Diamond Addams (212) 647-6475', NULL, NULL, 'N');
INSERT INTO staff (staff_id, last_name, first_name, position_name, staff_phone_number, staff_email, staff_emergency_contact, staff_allergies, staff_dietary_restrictions, cpr_certification)
	VALUES (11535, 'Gacy', 'Diya', 'Lifeguard', '(212) 536-7568' , 'dg664@gmail.com', 'Nona Gacy (212) 533-7529', NULL, NULL, 'Y');
    
SELECT * FROM staff;

#Insert into Cabins
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Apple', 8);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Ash', 9);
INSERT INTO cabins (cabin_name, capacity)
	VALUES ('Birch', 10);

SELECT * FROM cabins;

#Insert into Camper Groups
INSERT INTO camper_groups (group_name)
	VALUES ('Red');
INSERT INTO camper_groups (group_name)
	VALUES ('Green');
INSERT INTO camper_groups (group_name)
	VALUES ('Blue');

SELECT * FROM camper_groups;

#Insert into Sessions
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-02', '2024-06-08', 'Elementary', 18, '2024-05-15', 'OPEN', 225.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-02', '2024-06-12', 'Middle School Extended', 16, '2024-05-15', 'OPEN', 430.00);
INSERT INTO sessions (start_date, end_date, theme, enrollment_capacity, registration_deadline, session_status, session_fee)
	VALUES ('2024-06-09', '2024-06-15', 'Performing Arts', 18, '2024-05-20', 'OPEN', 300.00);

SELECT * FROM sessions;
    
