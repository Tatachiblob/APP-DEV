DROP DATABASE IF EXISTS DB_APPDEV;
CREATE DATABASE DB_APPDEV;

USE DB_APPDEV;

DROP TABLE IF EXISTS `USER_TYPE`;

DROP TABLE IF EXISTS `ACCOUNT`;
CREATE TABLE `ACCOUNT`(
	USER_NAME VARCHAR(45) NOT NULL,
    PASSWORD VARCHAR(45) NOT NULL,
    ACTIVE_DATE DATE,
    PRIMARY KEY(USER_NAME)
);

DROP TABLE IF EXISTS `EMPLOYEE`;
CREATE TABLE `EMPLOYEE`(
	EMP_ID INT NOT NULL AUTO_INCREMENT,
    USER_NAME VARCHAR(45) NOT NULL, 
    NAME VARCHAR(45) NOT NULL,
    USER_TYPE VARCHAR(45) NOT NULL,
    PRIMARY KEY(EMP_ID),
    FOREIGN KEY(USER_NAME) REFERENCES ACCOUNT(USER_NAME)
);

DROP TABLE IF EXISTS `DEPARTMENT`;
CREATE TABLE `DEPARTMENT`(
	DEPT_ID INT NOT NULL AUTO_INCREMENT,
    DEPT_NAME VARCHAR(45) NOT NULL,
    DEPT_ADDR TEXT NOT NULL,
    PRIMARY KEY(DEPT_ID)
);	

DROP TABLE IF EXISTS `DEPT_EMP`;
CREATE TABLE `DEPT_EMP`(
	DEPT_ID INT NOT NULL,
    EMP_ID INT NOT NULL,
    PRIMARY KEY(DEPT_ID, EMP_ID),
    FOREIGN KEY(DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID),
    FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID)
);

DROP TABLE IF EXISTS `STOCK`;
CREATE TABLE `STOCK`(
	STOCK_ID INT NOT NULL AUTO_INCREMENT,
    STOCK_NAME VARCHAR(45) NOT NULL,
    STOCK_UNIT VARCHAR(45) NOT NULL,
    FLOOR_LVL DOUBLE NOT NULL,
    PRIMARY KEY(STOCK_ID)
);

DROP TABLE IF EXISTS `DEPT_INVENTORY`;
CREATE TABLE `DEPT_INVENTORY`(
	DEPT_ID INT NOT NULL,
    STOCK_ID INT NOT NULL,
    QTY DOUBLE NOT NULL,
    PRIMARY KEY(DEPT_ID, STOCK_ID),
    FOREIGN KEY(DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID),
    FOREIGN KEY(STOCK_ID) REFERENCES STOCK(STOCK_ID)
);

DROP TABLE IF EXISTS `SUPPLIER`;
CREATE TABLE `SUPPLIER`(
	SUPPLIER_ID INT NOT NULL AUTO_INCREMENT,
    SUPPLIER_NAME VARCHAR(45) NOT NULL,
    CONTACT_PERSON VARCHAR(45),
    CONTACT_INFO VARCHAR(45) NOT NULL,
    PRIMARY KEY(SUPPLIER_ID)
);

DROP TABLE IF EXISTS `SUP_STK`;
CREATE TABLE `SUP_STK`(
	SUPPLIER_ID INT NOT NULL,
    STOCK_ID INT NOT NULL,
    PRIMARY KEY(SUPPLIER_ID, STOCK_ID),
    FOREIGN KEY(SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID),
    FOREIGN KEY(STOCK_ID) REFERENCES STOCK(STOCK_ID)
);

DROP TABLE IF EXISTS `MENU`;
CREATE TABLE `MENU`(
	MENU_ID INT NOT NULL AUTO_INCREMENT,
    MENU_NAME VARCHAR(45) NOT NULL,
    CATEGORY VARCHAR(45) NOT NULL,
    PRICE_VAT DOUBLE,
    PRICE DOUBLE NOT NULL,
    COSTING DOUBLE NOT NULL,
    PRIMARY KEY(MENU_ID)
);

DROP TABLE IF EXISTS `ENDING`;
CREATE TABLE `ENDING`(
	DEPT_ID INT NOT NULL,
    STOCK_ID INT NOT NULL,
    ENDING_DATE DATE,
    END_QTY DOUBLE NOT NULL,
    PRIMARY KEY(DEPT_ID, STOCK_ID, ENDING_DATE),
    FOREIGN KEY(DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID),
	FOREIGN KEY(STOCK_ID) REFERENCES STOCK(STOCK_ID)
);