-- Find average salary per department
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- Employee count by department and gender
SELECT department, gender, COUNT(*) 
FROM employees
GROUP BY department, gender
ORDER BY department;

-- Find employees who worked more than 5 years
SELECT emp_id, name, join_date, exit_date,
coalesce(exit_date,current_date)-join_date AS tenure
from employees
where coalesce(exit_date,current_date)-join_date > interval '5 years'

-- Ranking employees by salary (Window Function)
SELECT emp_id, name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees;


-- Top 5 highest paid employees
SELECT emp_id, name, department, salary
from employees
ORDER BY salary DESC 
LIMIT 5;

-- Monthly employee join count
SELECT DATE_TRUNC('month', join_date) AS month,
       COUNT(*) AS join_count,
       SUM(COUNT(*)) OVER (ORDER BY DATE_TRUNC('month', join_date)) AS cumulative_joins
FROM employees
GROUP BY 1
ORDER BY 1;

-- Calculate attrition rate
WITH total AS (
    SELECT COUNT(*) AS total_employees FROM employees
),
left_employees AS (
    SELECT COUNT(*) AS left_count FROM employees WHERE exit_date IS NOT NULL
)
SELECT left_count * 100.0 / total_employees AS attrition_rate
FROM total, left_employees;

-- Average performance score by location
SELECT location, AVG(performance_score)
FROM employees
GROUP BY location;

-- Find all employees who have below-average salary
SELECT emp_id, name, salary
FROM employees
where salary<(select avg(salary) from employees);


-- Compare salary growth by department

SELECT department, salary,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;



























