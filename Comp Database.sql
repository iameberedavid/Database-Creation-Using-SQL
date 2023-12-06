-- CREATE A DATABASE SCHEMA USING THE PROVIDED DATA

-- Create employee table
CREATE TABLE employee(
    emp_id INT PRIMARY KEY, -- map emp_id as primary key
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT, --super_id and branch_id are foreign keys but will be mapped later as employee table and branch table are yet to be created
    branch_id INT
);

-- Create branch table
CREATE TABLE branch(
    branch_id INT,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    PRIMARY KEY(branch_id), -- Another way to map a primary key
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-- Map super_id as foreign key
ALTER TABLE employee
ADD FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

-- Map branch_id as foreign key
ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

-- Create client table
CREATE TABLE client(
    client_id INT,
    client_name VARCHAR(40),
    branch_id INT,
    PRIMARY KEY(client_id), -- map client_id as primary key
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL -- Map branch_id as foreign key
);

-- Create works_with table
CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id), -- Map emp_id and client_id as primary keys. To also map them as foreign keys CASCADE will be used
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE, -- Map emp_id and client_id as foreign keys using CASDCADE
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- Create branch_supplier table
CREATE TABLE branch_supplier(
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY (branch_id, supplier_name), -- Map branch_id and supplier_name as primary keys
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- Map branch_id as foreign key using CASCADE
);

-- INSERT VALUES INTO THE TABLES

-- Insert values to the first row on employee table
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
-- branch_id is set to NULL as the value that should be filled there has not been inserted into the branch table

-- Insert values to the first row on branch table in order to update the branch_id value as a foreign key in employee table
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Update the inserted branch_id value in employee table
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

-- Insert the remaining rows on employee table that have the provided branch_id
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Insert values to the first row on employee table with the next branch_id
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

-- Insert values to the next branch_id on branch table in order to update the branch_id value as a foreign key in employee table
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

-- Update the inserted branch_id value in employee table
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

-- Insert the remaining rows on employee table that have the provided branch_id
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Stanley', 'Hudson', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Michael', 'Scott', '1958-02-19', 'M', 69000, 102, 2);

-- Insert values to the first row on employee table with the next branch_id
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

-- Insert values to the next branch_id on branch table in order to update the branch_id value as a foreign key in employee table
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

-- Update the inserted branch_id value in employee table
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

-- Insert the remaining rows on employee table that have the provided branch_id
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Insert values to the client table
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daily Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Insert values to the works_with table
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Insert values to the branch_supplier table
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J. T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- Run the select statements below individually to view each table
SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;