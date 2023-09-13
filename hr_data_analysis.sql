
-- QUESTIONS --

-- 1. What is the gender split of employees in the company?

SELECT gender, COUNT(*) as count
FROM hr
WHERE age > 18 AND termdate = "0000-00--00"
GROUP BY gender;


-- 2. What is the race breakdown of current employees in the company?

SELECT race, count(*) as count
FROM hr
WHERE termdate = "0000-00--00"
GROUP BY race
ORDER BY count(*) DESC;


-- 3. How many employees work at headquarters versus remote locations?
select * from hr;

SELECT location, COUNT(*) as count
FROM hr
WHERE termdate = "0000-00--00"
GROUP BY location;

-- 4. What is the average length of employment for employees who have been terminated?
select * from hr;

SELECT 
ROUND(AVG(datediff(termdate, hire_date))/365,0) as average_empl_length
FROM hr
WHERE termdate <= curdate() AND termdate <> "0000-00--00";


-- 5. How does the gender distribution vary across departments?

SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age > 18 AND termdate = "0000-00--00"
GROUP BY department, gender
ORDER BY department;


-- 6. What is the distribution of job titles across the company?

SELECT distinct(jobtitle), COUNT(*) as count
FROM hr
WHERE age > 18 AND termdate = "0000-00--00"
GROUP BY jobtitle
ORDER BY  count DESC;

-- 7. Which department has the highest turnover rate?
-- number of employee who left divided by total number of employees x 100

SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> "0000-00-00" THEN 1 ELSE 0 END) as terminated_empl, 
    SUM(CASE WHEN termdate = "0000-00-00" THEN 1 ELSE 0 END) as active_empl,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;

-- 8.What is the distribution of employees across locations by state?

SELECT location_state, COUNT(*) as count
FROM hr
WHERE age > 18 AND termdate = "0000-00--00"
GROUP BY location_state
ORDER BY count DESC;

