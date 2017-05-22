DROP DATABASE IF EXISTS dbupdate;
CREATE DATABASE dbupdate;

USE dbupdate;

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	user_name VARCHAR(45) NOT NULL,
    password VARCHAR(45) NOT NULL,
    activation_date DATE,
    PRIMARY KEY(user_name)
);

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`(
	emp_id VARCHAR(45) NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (emp_id),
    CONSTRAINT FK_admin	
		FOREIGN KEY(emp_id) REFERENCES account(user_name)
);

DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`(
	emp_id VARCHAR(45) NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (emp_id),
    CONSTRAINT FK_manager
		FOREIGN KEY(emp_id) REFERENCES account(user_name)
);

DROP TABLE IF EXISTS `clerk`;
CREATE TABLE `clerk`(
	emp_id VARCHAR(45) NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (emp_id),
    CONSTRAINT FK_clerk	
		FOREIGN KEY(emp_id) REFERENCES account(user_name)
);

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`(
	dept_id INT NOT NULL AUTO_INCREMENT,
    dept_name VARCHAR(45) NOT NULL,
    PRIMARY KEY(dept_id)
);

DROP TABLE IF EXISTS `commissary`;
CREATE TABLE `commissary`(
	dept_id INT NOT NULL,
    com_addr VARCHAR(255) NOT NULL,
    PRIMARY KEY(dept_id),
    CONSTRAINT FK_comm
		FOREIGN KEY(dept_id) REFERENCES department(dept_id)
);

DROP TABLE IF EXISTS `branch`;
CREATE TABLE branch(
	dept_id INT NOT NULL,
    branch_addr VARCHAR(255) NOT NULL,
    PRIMARY KEY(dept_id),
    CONSTRAINT FK_branch
		FOREIGN KEY(dept_id) REFERENCES department(dept_id)
);

DROP TABLE IF EXISTS `dept_emp`;
CREATE TABLE dept_emp(
	dept_id INT NOT NULL,
    user_name VARCHAR(45) NOT NULL,
    PRIMARY KEY(dept_id, user_name),
    FOREIGN KEY(dept_id) REFERENCES department(dept_id),
    FOREIGN KEY(user_name) REFERENCES account(user_name)
);

DROP TABLE IF EXISTS `stock`;
CREATE TABLE stock(
	stock_id INT NOT NULL AUTO_INCREMENT,
    stock_name VARCHAR(45) NOT NULL,
    stock_unit VARCHAR(45) NOT NULL,
    floor_lvl DOUBLE NOT NULL,
    PRIMARY KEY(stock_id)
);

DROP TABLE IF EXISTS `dept_inventory`;
CREATE TABLE dept_inventory(
	dept_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity DOUBLE NOT NULL,
    PRIMARY KEY(dept_id, stock_id),
    FOREIGN KEY(dept_id) REFERENCES department(dept_id),
    FOREIGN KEY(stock_id) REFERENCES stock(stock_id)
);

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE supplier(
	supplier_id INT NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(45) NOT NULL,
    contact_person VARCHAR(45),
    contact_info VARCHAR(45) NOT NULL,
    PRIMARY KEY(supplier_id)
);

DROP TABLE IF EXISTS `sup_stk`;
CREATE TABLE sup_stk(
	supplier_id INT NOT NULL,
    stock_id INT NOT NULL,
    PRIMARY KEY(supplier_id, stock_id),
    FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY(stock_id) REFERENCES stock(stock_id)
);
