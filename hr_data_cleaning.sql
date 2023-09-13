
-- DATA CLEANING --

USE hrdb;

SELECT * FROM hr;



-- text type to varchar

ALTER TABLE hr
MODIFY COLUMN id VARCHAR(20) NULL;

DESCRIBE hr;


-- updating birthdate column to constant date format

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
END;

ALTER TABLE hr
CHANGE COLUMN birthdate dob DATE;


-- updating hire_date column to constant date format

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


-- converting  termdate column to constant date format, also dealing with blank values

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;


-- calculating age column based on dob

ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR,dob,CURDATE());

SELECT DOB,AGE FROM HR;



-- inspecting if there are any incorrect hidden values 

SELECT 
	MIN(age) as the_youngest,
    MAX(age) as the_oldest
FROM hr;

SELECT count(*)
FROM hr
WHERE age < 18;

SELECT COUNT(*)
FROM hr
WHERE age > 100;
