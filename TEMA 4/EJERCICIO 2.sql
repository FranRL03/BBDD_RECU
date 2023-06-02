SELECT first_name, last_name
FROM employees e 
	JOIN departments d USING (department_id)
WHERE department_name IN ('IT', 'Finance')
	AND hire_date::TEXT ILIKE '%-04%'
		OR hire_date::TEXT ILIKE '%-06%';
	
SELECT e2.first_name, e2.last_name 
FROM employees e
	LEFT JOIN employees e2 ON (e2.manager_id = e.employee_id)
	JOIN departments d ON (d.department_id = e2.department_id)
WHERE d.department_name ILIKE 'Administration';

SELECT country_name 
FROM countries c 
	JOIN locations l USING (country_id)
	JOIN departments d USING (location_id)
WHERE department_name ILIKE 'Public relations';

SELECT first_name, last_name, region_name
FROM employees e 
	JOIN departments d USING (department_id)
	JOIN locations l USING (location_id)
	JOIN countries c USING (country_id)
	JOIN regions r USING (region_id)
WHERE hire_date::TEXT ILIKE '%'
	AND region_name ILIKE 'americas';
	
SELECT d.first_name, d.last_name, e.first_name, e.last_name, country_name
FROM dependents d 
	JOIN employees e USING (employee_id)
	JOIN departments de USING (department_id)
	JOIN locations l USING (location_id)
	JOIN countries c USING (country_id)
	JOIN regions r USING (region_id)
WHERE region_name ILIKE 'americas'
ORDER BY country_name;
