SELECT first_name, last_name, email
FROM employees e 
	JOIN departments d  USING (department_id)
	JOIN locations l USING (location_id)
	JOIN countries c USING (country_id)
WHERE country_name = 'United Kingdom';

SELECT department_name
FROM departments d 
	JOIN employees e USING (department_id)
WHERE hire_date::TEXT ILIKE '1993%';

SELECT region_name, salary
FROM regions r
	JOIN countries c USING (region_id)
	JOIN locations l USING (country_id)
	JOIN departments d USING (location_id)
	JOIN employees e USING (department_id)
WHERE salary < 10000
ORDER BY salary DESC;

SELECT e2.first_name, e2.last_name
FROM employees e 
	RIGHT JOIN employees e2 ON (e2.manager_id = e.employee_id)
WHERE e2.last_name ILIKE 'D%'
	OR e2.last_name ILIKE 'h%'
	OR e2.last_name ILIKE 's%';

SELECT count(relationship) AS "num_niños"
FROM dependents d 
	JOIN employees e USING (employee_id)
	JOIN departments d2 USING (department_id)
WHERE department_name IN ('Marketing', 'Administration', 'IT');
 



