-- Create schemas

-- Create tables
CREATE TABLE IF NOT EXISTS departments
(
    dept_no VARCHAR(20) NOT NULL UNIQUE,
    dept_name VARCHAR(30) NOT NULL,
    PRIMARY KEY(dept_no)
);

CREATE TABLE IF NOT EXISTS dept_emp
(
    emp_dept_no VARCHAR(30) NOT NULL,
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(20) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY(emp_dept_no)
);

CREATE TABLE IF NOT EXISTS dept_manager
(
    emp_dept_no VARCHAR(30) NOT NULL,
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(20) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY(emp_dept_no)
);

CREATE TABLE IF NOT EXISTS employees
(
    emp_no INTEGER NOT NULL UNIQUE,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    gender VARCHAR(2) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY(emp_no)
);

CREATE TABLE IF NOT EXISTS salaries
(
    salary_emp_no INTEGER NOT NULL,
    salary INTEGER NOT NULL,
    emp_no INTEGER NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY(salary_emp_no)
);

CREATE TABLE IF NOT EXISTS titles
(
    title_emp_no INTEGER NOT NULL,
    title_no INTEGER NOT NULL,
    title VARCHAR(50) NOT NULL,
    emp_no INTEGER NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY(title_emp_no)
);

-- Create FKs
ALTER TABLE dept_emp
    ADD    FOREIGN KEY (emp_no)
    REFERENCES employees(emp_no)
    MATCH SIMPLE
;
    
ALTER TABLE dept_manager
    ADD    FOREIGN KEY (emp_no)
    REFERENCES employees(emp_no)
    MATCH SIMPLE
;
    
ALTER TABLE dept_manager
    ADD    FOREIGN KEY (dept_no)
    REFERENCES departments(dept_no)
    MATCH SIMPLE
;
    
ALTER TABLE titles
    ADD    FOREIGN KEY (emp_no)
    REFERENCES employees(emp_no)
    MATCH SIMPLE
;
    
ALTER TABLE salaries
    ADD    FOREIGN KEY (emp_no)
    REFERENCES employees(emp_no)
    MATCH SIMPLE
;
 
 ALTER TABLE dept_emp
    ADD    FOREIGN KEY (dept_no)
    REFERENCES departments(dept_no)
    MATCH SIMPLE
;

-- Create Indexes

--Load CSVs

--1. 
SELECT employees.employee_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.employee_no=salaries.employee_no;

--2. SELECT *
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. 
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, dept_manager.from_date, dept_manager.to_date, employees.first_name, employees.last_name 
FROM departments
JOIN dept_manager ON dept_manager.dept_no=departments.dept_no
JOIN employees ON employees.emp_no=dept_manager.emp_no;

--4. 
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
JOIN departments ON dept_emp.dept_no=departments.dept_no;

--5
SELECT *
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM departments
JOIN dept_emp ON dept_emp.dept_no=departments.dept_no
JOIN employees ON employees.emp_no=dept_emp.emp_no
WHERE departments.dept_name = 'Sales';

--7
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM departments
JOIN dept_emp ON dept_emp.dept_no=departments.dept_no
JOIN employees ON employees.emp_no=dept_emp.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8
SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;
