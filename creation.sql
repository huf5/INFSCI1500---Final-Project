USE group_camp_query;

DROP TABLE IF EXISTS testing; 
CREATE TABLE testing(
	testing1 INT PRIMARY KEY NOT NULL, 
    testing2 VARCHAR(200) NOT NULL,
    testing3 DATETIME NOT NULL
)ENGINE INNODB;


SELECT * FROM testing;