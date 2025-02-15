USE HR;
DESCRIBE regions;
DESCRIBE countries;
DESCRIBE locations;
DESCRIBE departments;
DESCRIBE jobs;
DESCRIBE employees;
DESCRIBE job_history;








SELECT r.region_name, COUNT(c.country_id) AS country_count
FROM regions r
JOIN countries c ON r.region_id = c.region_id
GROUP BY r.region_name;

SELECT l.city, COUNT(e.employee_id) AS estimated_population
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
ORDER BY estimated_population DESC
LIMIT 10;

SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

SELECT c.country_name, SUM(o.sales_amount) AS total_sales
FROM orders o
INNER JOIN customers cu ON o.customer_id = cu.customer_id
INNER JOIN countries c ON cu.country_id = c.country_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
  AND o.order_date < CURDATE()
GROUP BY c.country_name;

SELECT p.product_name, COUNT(*) AS order_count
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY order_count DESC
LIMIT 10;

SELECT cu.customer_name, COUNT(*) AS order_count
FROM orders o
INNER JOIN customers cu ON o.customer_id = cu.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
  AND o.order_date < CURDATE()
GROUP BY cu.customer_name
ORDER BY order_count DESC
LIMIT 10;

SELECT e.first_name, e.last_name, SUM(o.sales_amount) AS total_sales
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id  -- Assuming employees table has an employee_id for sales
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
  AND o.order_date < CURDATE()
GROUP BY e.employee_id
ORDER BY total_sales DESC;

SELECT e.employee_id, e.first_name, e.last_name, COUNT(*) AS promotion_count
FROM job_history jh
INNER JOIN employees e ON jh.employee_id = e.employee_id
GROUP BY e.employee_id
HAVING COUNT(*) > 1;

SELECT e.employee_id, e.first_name, e.last_name, j.job_title, DATEDIFF(CURDATE(), MAX(jh.end_date)) AS tenure
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
INNER JOIN job_history jh ON e.employee_id = jh.employee_id
GROUP BY e.employee_id
HAVING tenure > 1825;
SELECT j.job_title, AVG(e.salary) AS average_salary
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;

SELECT e.employee_id, e.first_name, e.last_name, e.salary
FROM employees e
ORDER BY e.salary DESC
LIMIT 1;

SELECT j.job_title, (j.max_salary - j.min_salary) AS salary_range
FROM jobs j
ORDER BY salary_range DESC
LIMIT 1;






SELECT d.department_name, AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

SELECT e.first_name, e.last_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Sales'
ORDER BY e.salary DESC
LIMIT 5;

SELECT j.job_title, COUNT(*) AS employee_count
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

SELECT m.first_name AS manager_name, AVG(e.salary) AS average_salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
GROUP BY m.employee_id;

SELECT d.department_name, COUNT(*) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(*) > 10;
