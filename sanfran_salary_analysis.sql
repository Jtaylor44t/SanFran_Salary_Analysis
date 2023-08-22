-- Previewing the data
SELECT * FROM salaries;

-- Showing only the EmployeeName and JobTitle column.
SELECT
	EmployeeName,
    JobTitle
FROM
	salaries;


-- Showing the number of employees in the table.
SELECT 
	COUNT(*)
FROM
	salaries;
-- There are 148,045 employees in the table.


-- Showing the unique job titles.
SELECT
	COUNT(DISTINCT JobTitle)
FROM
	salaries;
-- There are 1,632 unique job titles in this data set. 


-- Showing the job title and overtime pay for all employees with overtime pay greater than 50k. 
SELECT
	JobTitle,
    OvertimePay
FROM
	salaries
WHERE
	OvertimePay > 50000;
-- It looks like the CAPTAIN III (POLICE DEPARTMENT) has the most OvertimePay. Followed by WIRE ROPE CABLE MAINTENANCE MANAGER and BATTALION CHIEF, (FIRE DEPARTMENT)


-- Showing the average base pay
SELECT 
	avg(BasePay) AS AvgBasePay
FROM
	salaries;
-- It appears that the average base pay in San Francisco is $66,325


-- Displaying the top 10 highest paid employees
SELECT 
	EmployeeName,
    TotalPay
FROM
	salaries
ORDER BY TotalPay DESC
LIMIT 10;
-- It appears NATHANIEL FORD, GARY JIMENEZ, and DAVID SHINN are some of the top paid employees in San Francisco. 


-- Showing the average of BasePay, OvertimePay, and OtherPay combined for each employee 
SELECT
	EmployeeName,
    (BasePay + OvertimePay + OtherPay)/3 AS avg_of_bp_op_otherpay
FROM
	salaries;
-- It looks like NATHANIEL FORD averages $189,198 with base, overtime, and other pay.


-- Showing all employees with manager titles. 
SELECT
	COUNT(EmployeeName),
    JobTitle
FROM 
	salaries
WHERE
	JobTitle LIKE '%Manager%';
-- There are 2,766 Manager job titles.


-- Showing all employees with non manager titles. 
SELECT
	COUNT(EmployeeName),
    JobTitle
FROM
	Salaries
WHERE JobTitle != 'Manager';
-- 84,346 employees have non manager job titles. 


-- Showing all employees with a total pay between 50-75k. 
SELECt COUNT(*)
FROM salaries
WHERE TotalPay BETWEEN 50000 AND 75000;
-- 17,792 employees make between 50,000 and 75,000
	

-- Showing all employees with a base pay less than 50k, or a total pay greater than 100k. 
SELECT COUNT(*)
FROM salaries
WHERE BasePay < 50000 OR TotalPay > 100000;
-- 55,855 employees either make below 50k or more than 100k. 


-- Show all employees with a total pay benefits value between 125-150k and a "Director" job title. 
SELECT *
FROM salaries
WHERE TotalPayBenefits BETWEEN 125000 AND 150000 AND JobTitle LIKE "%Director%";
-- There are 52 employees with Director in their title whose totalpaybenefits are between 125-150k


-- Show all employees ordered by their total pay benefits in descending order. 
SELECT *
FROM salaries
ORDER BY TotalPayBenefits DESC;
-- It looks like both Nathaniel Ford and Gary Jimenez have a total compensation including benefits of over half a million dollars a year. 


-- Show all job titles with an average base pay of at least 100k and order them by the average base pay in descending order. 
SELECT 
	JobTitle,
    avg(BasePay) AS avg_base_pay
FROM
	salaries
GROUP BY JobTitle
HAVING avg(BasePay) >= 100000
ORDER BY avg_base_pay DESC;
-- Some of the job titles with at least 100k base pay are Fire Department Chief, Chief of Police, Controller, Chief Investment Officer, and Administrator, DPH. 


-- Deleting the notes column because it's not needed. 
ALTER TABLE salaries
DROP COLUMN Notes;
SELECT * FROM salaries; --Checking the drop worked. 


-- Update the base pay of all employees with a Manager title with a 10% raise. 
UPDATE salaries
SET BasePay = BasePay * 1.1
WHERE JobTitle LIKE "%Manager%" 
SELECT * FROM salaries; -- Checking it worked


-- Update the base pay of all employees with a non Manager title with a 6% raise. 
UPDATE salaries
SET BasePay = BasePay * 1.05
WHERE JobTitle != "Manager" 
SELECT * FROM salaries; -- Checking it worked


-- Backing up the table before deleting the employees with no OvertimePay. 
CREATE TABLE salaries-copy.salary_table_copy
AS
SELECT * FROM salaries.salary_table;


-- Deleting all employees who have no OvertimePay. 
SELECT COUNT(*) 
FROM salaries
WHERE OvertimePay = 0;
-- 76,720 employees do not have any overtime pay


-- Deleting the employees who do not have OvertimePay
DELETE FROM salaries
WHERE OvertimePay = 0;
