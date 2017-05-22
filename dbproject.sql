DROP DATABASE IF EXISTS dbproject;
CREATE DATABASE dbproject;

USE dbproject;

DROP TABLE IF EXISTS `employee`;
CREATE TABLE employee(
	employeeNum INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(45) NOT NULL,
    userName VARCHAR(45) NOT NULL,
    password VARCHAR(45) NOT NULL,
    userType VARCHAR(10) NOT NULL,
    branchCode INT NULL,
    commissaryCode INT NULL,
    PRIMARY KEY(employeeNum)
);

DROP TABLE IF EXISTS `branch`;
CREATE TABLE branch(
	branchID INT NOT NULL AUTO_INCREMENT,
    branchName VARCHAR(45) NOT NULL,
    PRIMARY KEY(branchID)
);

DROP TABLE IF EXISTS `commissary`;
CREATE TABLE commissary(
	commissaryID INT NOT NULL AUTO_INCREMENT,
    commissaryName VARCHAR(45) NOT NULL,
    PRIMARY KEY(commissaryID)
);

DROP TABLE IF EXISTS `stock`;
CREATE TABLE stock(
	stockID INT NOT NULL AUTO_INCREMENT,
    stockName VARCHAR(45) NOT NULL,
    stockUnit VARCHAR(45) NOT NULL,
    floorLevel DOUBLE NOT NULL,
    PRIMARY KEY(stockID)
);

DROP TABLE IF EXISTS `menu`;
CREATE TABLE menu(
	menuID INT NOT NULL AUTO_INCREMENT,
    menuName VARCHAR(45) NOT NULL,
    category VARCHAR(45) NOT NULL,
    menuPriceVat DOUBLE,
    menuPrice DOUBLE NOT NULL,
    menuCosting DOUBLE NOT NULL,
    PRIMARY KEY(menuID)
);

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE supplier(
	supplierID INT NOT NULL AUTO_INCREMENT,
    supplierName VARCHAR(45) NOT NULL,
    contactPerson VARCHAR(45),
    contactInfo VARCHAR(45) NOT NULL,
    PRIMARY KEY(supplierID)
);

ALTER TABLE employee
	ADD CONSTRAINT FK_branchCode
		FOREIGN KEY(branchCode) REFERENCES branch(branchID),
	ADD CONSTRAINT FK_commissaryCode
		FOREIGN KEY(commissaryCode) REFERENCES commissary(commissaryID);

DROP TABLE 	IF EXISTS `commissaryInventory`;
CREATE TABLE commissaryInventory(
	commissaryID INT NOT NULL,
    stockID INT NOT NULL,
    quantity DOUBLE NOT NULL,
    CONSTRAINT PK_comstock PRIMARY KEY(commissaryID, stockID),
    CONSTRAINT FK_comCode FOREIGN KEY(commissaryID)
		REFERENCES commissary(commissaryID),
    CONSTRAINT FK_stockCode FOREIGN KEY(stockID)
		REFERENCES stock(stockID)
);

DROP TABLE IF EXISTS `branchInventory`;
CREATE TABLE branchInventory(
	branchID INT NOT NULL,
    stockID INT NOT NULL,
    quantity DOUBLE NOT NULL,
    CONSTRAINT PK_brstock PRIMARY KEY(branchID, stockID),
    CONSTRAINT FK_brCode FOREIGN KEY(branchID)
		REFERENCES branch(branchID),
	CONSTRAINT FK_stckCode FOREIGN KEY(stockID)
		REFERENCES stock(stockID)
);

DROP TABLE IF EXISTS `endingInventory`;
CREATE TABLE endingInventory(
	commissaryID INT NOT NULL,
    stockID INT NOT NULL,
	year YEAR,
    date DATE,
    endingQuantity DOUBLE NOT NULL,
    CONSTRAINT PK_endReport PRIMARY KEY(commissaryID, stockID, year, date),
    CONSTRAINT FK_comID FOREIGN KEY(commissaryID)
		REFERENCES commissary(commissaryID),
	CONSTRAINT FK_itemCode FOREIGN KEY(stockID)
		REFERENCES stock(stockID)
);

DROP TABLE IF EXISTS `salesReport`;
CREATE TABLE salesReport(
	branchID INT NOT NULL,
    menuID INT NOT NULL,
    date DATE NOT NULL,
    transactions INT NOT NULL,
    CONSTRAINT PK_slreport PRIMARY KEY(branchID, menuID, date),
    CONSTRAINT FK_brID FOREIGN KEY(branchID)
		REFERENCES branch(branchID),
	CONSTRAINT FK_menuCode FOREIGN KEY(menuID)
		REFERENCES menu(menuID)
);

DROP TABLE IF EXISTS `supply`;
CREATE TABLE supply(
	supplierID INT NOT NULL,
    stockID INT NOT NULL,
    CONSTRAINT PK_spl PRIMARY KEY(supplierID, stockID),
    CONSTRAINT FK_supplierCode FOREIGN KEY(supplierID)
		REFERENCES supplier(supplierID),
	CONSTRAINT FK_splStock FOREIGN KEY (stockID)
		REFERENCES stock(stockID)
);

DROP TABLE IF EXISTS `purchaseOrder`;
CREATE TABLE purchaseOrder(
    poNum INT NOT NULL,
    supplierID INT NOT NULL,
    purchaseDate DATE NOT NULL,
    commissaryID INT NOT NULL,
    stockID INT NOT NULL,
    purchaseQuantity DOUBLE NOT NULL,
    priceperUnit DOUBLE NOT NULL,
    CONSTRAINT PK_po PRIMARY KEY(poNum, supplierID, commissaryID, stockID, purchaseDate),
    CONSTRAINT FK_poSupplier FOREIGN KEY(supplierID)
		REFERENCES supplier(supplierID),
	CONSTRAINT FK_poCommissary FOREIGN KEY(commissaryID)
		REFERENCES commissary(commissaryID),
	CONSTRAINT FK_poStock FOREIGN KEY(stockID)
		REFERENCES stock(stockID)
);

DROP TABLE IF EXISTS `deliveryReceipt`;
CREATE TABLE deliveryReceipt(
    drID INT NOT NULL,
    commissaryID INT NOT NULL,
    branchID INT NOT NULL,
    deliveryDate DATE NOT NULL,
    stockID INT NOT NULL,
    deliveryQuantity DOUBLE NOT NULL,
    CONSTRAINT PK_dr PRIMARY KEY(drID, commissaryID, branchID, stockID, deliveryDate),
    CONSTRAINT FK_drcomID FOREIGN KEY(commissaryID)
		REFERENCES commissary(commissaryID),
	CONSTRAINT FK_drbrID FOREIGN KEY(branchID)
		REFERENCES branch(branchID),
	CONSTRAINT FK_drstockID FOREIGN KEY(stockID)
		REFERENCES stock(stockID)
);

INSERT INTO branch VALUES
	(0, 'SM Megamall'),(0, 'SM San Lazaro'),(0, 'SM South Mall'),
    (0, 'SM Dasmarinas'),(0, 'Asia Development Bank'),(0, 'SM North Edsa'),
    (0, 'Makati Ayala Mall');

INSERT INTO commissary VALUES
	(0, 'Pasig Commissary'),(0, 'Makati Commissary');

INSERT INTO employee VALUES
	(0, 'Diane', 'Murphy', 'dmurphy', 'diane', 'manager', 1, null),(0, 'Mary', 'Patterson', 'mpatterson', 'mary', 'manager', 2, null),(0, 'William', 'Patterson', 'wpatterson', 'william', 'clerk', null, 1),
    (0, 'Gerard', 'Bondur', 'gbondur', 'gerard', 'manager', 3, null),(0, 'Anthony', 'Bow', 'abow', 'anthony', 'clerk', null, 2),(0, 'Leslie', 'Jennings', 'ljennings', 'leslie', 'manager', 4, null),
    (0, 'Steve', 'Jobs', 'sjobs', 'steve', 'manager', 5, null),(0, 'Foon Yue', 'Tseng', 'ftseng', 'foon_yue', 'clerk', null, 1),(0, 'Jeff', 'Firrelli', 'jfirrelli', 'jeff', 'manager', 6, null),
    (0, 'Yuta', 'Inoue', 'yinoue', 'yuta', 'admin', 1, 1);

INSERT INTO stock VALUES
	(0, 'Prawn', 'Pcs', 230),(0, 'Kani', 'Kg', 50),(0, 'Inari', 'Pack', 100),
    (0, 'Ebiko', 'Kg', 70),(0, 'Japanes Flour', 'Kg', 100),(0, 'Bread Crumbs', 'Kg', 100),
    (0, 'Nori', 'Sheet', 500),(0, 'Ra-yu', 'Ltr', 10.3),(0, 'Japanese Vineger', 'Ltr', 11),
    (0, 'Japanese Mayonise', 'Kg', 40),(0, 'Bonito Flakes', 'Kg', 10),(0, 'Tonkatsu Sause', 'Ltr', 70),
    (0, 'Soy Sause', 'Ltr', 40),(0, 'Togarashi', 'Kg', 40),(0, 'Curry Powder', 'Kg', 50),
    (0, 'Miso', 'Kg', 40),(0, 'Mirin', 'Ltr', 110),(0, 'Hondashi', 'Ltr', 201),
    (0, 'Red Ginger', 'Kg', 130),(0, 'Wasabi', 'Kg', 50),(0, 'Sesami Seed', 'Kg', 50),
    (0, 'Kinako', 'Kg', 50),(0, 'Denorado', 'Kg', 50),(0, 'Employee Rice', 'Kg', 100),
    (0, 'Brown Sugar', 'Kg', 400),(0, 'White Sugar', 'Kg', 400),(0, 'Salt', 'Kg', 60),
    (0, 'Black Peper', 'Kg', 6),(0, 'Local Mayonise', 'Kg', 60),(0, 'Sesami Oil', 'Ltr', 40),
    (0, 'Bento Box', 'Pcs', 300),(0, 'Donburi Bowl', 'Pcs', 400),(0, 'Paper Box' ,'Pcs', 400),
    (0, 'Soup Cup', 'Pcs', 400),(0, 'Tempura Bowl Cup', 'Pcs', 400),(0, 'Paper Bag S', 'Pcs', 400),
    (0, 'Paper Bag L', 'Pcs', 400),(0, 'Trash Bag', 'Pcs', 20),(0, 'Paper Towl', 'Pack',20),
    (0, 'Chop Stick', 'Pc', 20),(0, 'Table Napkin', 'Pack', 20),(0, 'Straw', 'Kg', 20),
    (0, 'Clean Cap', 'Pc', 20),(0, 'Glove', 'Pc', 500),(0, 'Plastic Spoon', 'Pcs', 500),
    (0, 'Plastic Fork', 'Pcs', 500);

INSERT INTO menu VALUES
	(0, 'Ebi Soba H Set', 'SOBA', 183.93, 206.0, 55.8),(0, 'Ebi Soba C Set', 'SOBA', 183.93, 206.0, 52.82),(0, 'Ebi Soba H', 'SOBA', 123.21, 138.0, 31.5),
    (0, 'Ebi Soba C', 'SOBA', 123.21, 138.0, 28.52),(0, 'Kara Soba H Set', 'SOBA', 178.57, 200.0, 58.74),(0, 'Kara Soba C Set', 'SOBA', 178.57, 200.0, 55.76),
    (0, 'Kara Age Soba H', 'SOBA', 117.86, 132.0, 34.44),(0, 'Kara Age Soba C', 'SOBA', 117.86, 132.0, 31.46),(0, 'Kaki Soba H Set', 'SOBA', 169.64, 190.0, 52.82),
    (0, 'Kaki Soba C Set', 'SOBA', 169.64, 190.0, 49.82),(0, 'Kaki Age Soba H', 'SOBA', 108.93, 122.0, 28.52),(0, 'Kaki Age Soba C', 'SOBA', 108.93, 122.0, 25.54),
    (0, 'Kake Soba Set', 'SOBA', 148.21, 166.0, 44.73),(0, 'Kake Soba', 'SOBA', 87.5, 98.0, 20.43),(0, 'Zaru Soba Set', 'SOBA', 148.21, 166.0, 41.76),
    (0, 'Zaru Soba', 'SOBA', 87.5, 98.0, 17.46),(0, 'Niku Soba Set', 'SOBA', 185.71, 208.0, 65.86),(0, 'Niku Soba', 'SOBA', 125.0, 140.0, 41.56),
    (0, 'Curry Soba Set', 'SOBA', 183.93, 206.0, 67.34),(0, 'Curry Soba', 'SOBA', 123.21, 138.0, 43.04),(0, 'Zaru Soba Set-2', 'SOBA', 196.43, 220.0, 44.62),
    (0, 'Zaru Soba-2', 'SOBA', 135.71, 152.0, 20.32),
    (0, 'Teriyaki Teishoku', 'TEISHOKU', 150.89, 169.0, 59.55),(0, 'Mix Tempura Teishoku', 'TEISHOKU', 124.11, 139.0, 46.98), (0, 'Katsu Teishoku', 'TEISHOKU', 131.25, 147.0, 54.33),
    (0, 'Karaage Teishoku', 'TEISHOKU', 124.11, 139.0, 46.11), (0, 'Ebi Tempura Teishoku', 'TEISHOKU', 159.82, 179.0, 51.47), (0, 'Komoro Teishoku', 'TEISHOKU', 131.25, 147.0, 52.7);

INSERT INTO supplier VALUES
	(0, 'Asian Developers', 'Inoue Kiku', 'inouekiku_doggo@gmail.com'),(0, 'Core Asia', 'John Edel Tamani', '0991 123 345'),(0, 'De La Salle University', 'Ms. Jane Arcilia', 'jane.arcilia@dlsu.edu.ph'),
    (0, 'Kands Corporation', 'Ogawa Seisuke', '0917 895 0136'),(0, 'MC Asia', 'Inoue Yuta', '0999 999 999');

INSERT INTO branchinventory VALUES
	(1, 1, 45),(1, 2, 31),(1, 3, 32),(1, 4, 32),(1, 5, 41),(1, 6, 9),
    (1, 7, 23),(1, 8, 32),(1, 9, 12),(1, 10, 43),(1, 11, 40),(1, 12, 5),
    (1, 13, 44),(1, 14, 86),(1, 15, 54),(1, 16, 65),(1, 17, 2),(1, 18, 23),
    (1, 19, 21),(1, 20, 55),(1, 21, 67),(1, 22, 199),(1, 23, 19),(1, 24, 478),
    (1, 25, 32),(1, 26, 65),(1, 27, 78),(1, 28, 5),(1, 29, 17),(1, 30, 88),
    (1, 31, 65),(1, 32, 34),(1, 33, 98),(1, 34, 9),(1, 35, 16),(1, 36, 32),
    (1, 37, 67),(1, 38, 109),(1, 39, 87),(1, 40, 92),(1, 41, 19),(1, 42, 34),
    (1, 43, 23),(1, 44, 12),(1, 45, 23),(1, 46, 12);

INSERT INTO commissaryinventory VALUES
	(1, 1, 1),(1, 2, 521),(1, 3, 432),(1, 4, 21),(1, 5, 344),(1, 6, 31),
    (1, 7, 2),(1, 8, 32),(1, 9, 86),(1, 10, 43),(1, 11, 865),(1, 12, 456),
    (1, 13, 3),(1, 14, 12),(1, 15, 21),(1, 16, 12),(1, 17, 23),(1, 18, 87),
    (1, 19, 4),(1, 20, 55),(1, 21, 23),(1, 22, 45),(1, 23, 425),(1, 24, 443),
    (1, 25, 6),(1, 26, 66),(1, 27, 553),(1, 28, 23),(1, 29, 23),(1, 30, 12),
    (1, 31, 132),(1, 32, 23),(1, 33, 21),(1, 34, 21),(1, 35, 75),(1, 36, 57),
    (1, 37, 123),(1, 38, 123),(1, 39, 32),(1, 40, 236),(1, 41, 33),(1, 42, 32),
    (1, 43, 64),(1, 44, 98),(1, 45, 132),(1, 46, 80);

INSERT INTO supply VALUES
	(5, 1),(5, 2),(5, 3),(5, 4),(5, 5),(5, 6),
    (5, 7),(5, 8),(5, 9),(5, 10),(1, 11),(1, 12),
    (1, 13),(1, 14),(1, 15),(1, 16),(1, 17),(1, 18),
    (1, 19),(1, 20),(2, 21),(2, 22),(2, 23),(2, 24),
    (2, 25),(2, 26),(2, 27),(2, 28),(2, 29),(2, 30),
    (3, 31),(3, 32),(3, 33),(3, 34),(3, 35),(3, 36),
    (3, 37),(3, 38),(3, 39),(3, 40),(4, 41),(4, 42),
    (4, 43),(4, 45);


INSERT INTO salesReport VALUES
	(1, 1, '2016-1-31', 113),(1, 2, '2016-1-31', 17),(1, 3, '2016-1-31', 389),(1, 4, '2016-1-31', 32),(1, 5, '2016-1-31', 53),(1, 6, '2016-1-31', 15),(1, 7, '2016-1-31', 168),(1, 8, '2016-1-31', 24),(1, 9, '2016-1-31', 86),(1, 10, '2016-1-31', 12),(1, 11, '2016-1-31', 218),(1, 12, '2016-1-31', 22),(1, 13, '2016-1-31', 15),(1, 14, '2016-1-31', 27),(1, 15, '2016-1-31', 50),(1, 16, '2016-1-31', 98),(1, 17, '2016-1-31', 59),(1, 18, '2016-1-31', 171),(1, 19, '2016-1-31', 7),(1, 20, '2016-1-31', 12),(1, 21, '2016-1-31', 12),(1, 22, '2016-1-31', 34),(1, 23, '2016-1-31', 528),(1, 24, '2016-1-31', 2303),(1, 25, '2016-1-31', 893),(1, 26, '2016-1-31', 356),(1, 27, '2016-1-31', 415),(1, 28, '2016-1-31', 301),
    (1, 1, '2016-2-29', 113),(1, 2, '2016-2-29', 17),(1, 3, '2016-2-29', 389),(1, 4, '2016-2-29', 32),(1, 5, '2016-2-29', 53),(1, 6, '2016-2-29', 15),(1, 7, '2016-2-29', 168),(1, 8, '2016-2-29', 24),(1, 9, '2016-2-29', 86),(1, 10, '2016-2-29', 12),(1, 11, '2016-2-29', 218),(1, 12, '2016-2-29', 22),(1, 13, '2016-2-29', 15),(1, 14, '2016-2-29', 27),(1, 15, '2016-2-29', 50),(1, 16, '2016-2-29', 98),(1, 17, '2016-2-29', 59),(1, 18, '2016-2-29', 171),(1, 19, '2016-2-29', 7),(1, 20, '2016-2-29', 12),(1, 21, '2016-2-29', 12),(1, 22, '2016-2-29', 34),(1, 23, '2016-2-29', 528),(1, 24, '2016-2-29', 2303),(1, 25, '2016-2-29', 893),(1, 26, '2016-2-29', 356),(1, 27, '2016-2-29', 415),(1, 28, '2016-2-29', 301),
    (1, 1, '2016-3-31', 113),(1, 2, '2016-3-31', 17),(1, 3, '2016-3-31', 389),(1, 4, '2016-3-31', 32),(1, 5, '2016-3-31', 53),(1, 6, '2016-3-31', 15),(1, 7, '2016-3-31', 168),(1, 8, '2016-3-31', 24),(1, 9, '2016-3-31', 86),(1, 10, '2016-3-31', 12),(1, 11, '2016-3-31', 218),(1, 12, '2016-3-31', 22),(1, 13, '2016-3-31', 15),(1, 14, '2016-3-31', 27),(1, 15, '2016-3-31', 50),(1, 16, '2016-3-31', 98),(1, 17, '2016-3-31', 59),(1, 18, '2016-3-31', 171),(1, 19, '2016-3-31', 7),(1, 20, '2016-3-31', 12),(1, 21, '2016-3-31', 12),(1, 22, '2016-3-31', 34),(1, 23, '2016-3-31', 528),(1, 24, '2016-3-31', 2303),(1, 25, '2016-3-31', 893),(1, 26, '2016-3-31', 356),(1, 27, '2016-3-31', 415),(1, 28, '2016-3-31', 301),
    (1, 1, '2016-4-30', 113),(1, 2, '2016-4-30', 17),(1, 3, '2016-4-30', 389),(1, 4, '2016-4-30', 32),(1, 5, '2016-4-30', 53),(1, 6, '2016-4-30', 15),(1, 7, '2016-4-30', 168),(1, 8, '2016-4-30', 24),(1, 9, '2016-4-30', 86),(1, 10, '2016-4-30', 12),(1, 11, '2016-4-30', 218),(1, 12, '2016-4-30', 22),(1, 13, '2016-4-30', 15),(1, 14, '2016-4-30', 27),(1, 15, '2016-4-30', 50),(1, 16, '2016-4-30', 98),(1, 17, '2016-4-30', 59),(1, 18, '2016-4-30', 171),(1, 19, '2016-4-30', 7),(1, 20, '2016-4-30', 12),(1, 21, '2016-4-30', 12),(1, 22, '2016-4-30', 34),(1, 23, '2016-4-30', 528),(1, 24, '2016-4-30', 2303),(1, 25, '2016-4-30', 893),(1, 26, '2016-4-30', 356),(1, 27, '2016-4-30', 415),(1, 28, '2016-4-30', 301),
    (1, 1, '2016-5-31', 113),(1, 2, '2016-5-31', 17),(1, 3, '2016-5-31', 389),(1, 4, '2016-5-31', 32),(1, 5, '2016-5-31', 53),(1, 6, '2016-5-31', 15),(1, 7, '2016-5-31', 168),(1, 8, '2016-5-31', 24),(1, 9, '2016-5-31', 86),(1, 10, '2016-5-31', 12),(1, 11, '2016-5-31', 218),(1, 12, '2016-5-31', 22),(1, 13, '2016-5-31', 15),(1, 14, '2016-5-31', 27),(1, 15, '2016-5-31', 50),(1, 16, '2016-5-31', 98),(1, 17, '2016-5-31', 59),(1, 18, '2016-5-31', 171),(1, 19, '2016-5-31', 7),(1, 20, '2016-5-31', 12),(1, 21, '2016-5-31', 12),(1, 22, '2016-5-31', 34),(1, 23, '2016-5-31', 528),(1, 24, '2016-5-31', 2303),(1, 25, '2016-5-31', 893),(1, 26, '2016-5-31', 356),(1, 27, '2016-5-31', 415),(1, 28, '2016-5-31', 301),
    (1, 1, '2016-6-30', 113),(1, 2, '2016-6-30', 17),(1, 3, '2016-6-30', 389),(1, 4, '2016-6-30', 32),(1, 5, '2016-6-30', 53),(1, 6, '2016-6-30', 15),(1, 7, '2016-6-30', 168),(1, 8, '2016-6-30', 24),(1, 9, '2016-6-30', 86),(1, 10, '2016-6-30', 12),(1, 11, '2016-6-30', 218),(1, 12, '2016-6-30', 22),(1, 13, '2016-6-30', 15),(1, 14, '2016-6-30', 27),(1, 15, '2016-6-30', 50),(1, 16, '2016-6-30', 98),(1, 17, '2016-6-30', 59),(1, 18, '2016-6-30', 171),(1, 19, '2016-6-30', 7),(1, 20, '2016-6-30', 12),(1, 21, '2016-6-30', 12),(1, 22, '2016-6-30', 34),(1, 23, '2016-6-30', 528),(1, 24, '2016-6-30', 2303),(1, 25, '2016-6-30', 893),(1, 26, '2016-6-30', 356),(1, 27, '2016-6-30', 415),(1, 28, '2016-6-30', 301),
    (1, 1, '2016-7-31', 113),(1, 2, '2016-7-31', 17),(1, 3, '2016-7-31', 389),(1, 4, '2016-7-31', 32),(1, 5, '2016-7-31', 53),(1, 6, '2016-7-31', 15),(1, 7, '2016-7-31', 168),(1, 8, '2016-7-31', 24),(1, 9, '2016-7-31', 86),(1, 10, '2016-7-31', 12),(1, 11, '2016-7-31', 218),(1, 12, '2016-7-31', 22),(1, 13, '2016-7-31', 15),(1, 14, '2016-7-31', 27),(1, 15, '2016-7-31', 50),(1, 16, '2016-7-31', 98),(1, 17, '2016-7-31', 59),(1, 18, '2016-7-31', 171),(1, 19, '2016-7-31', 7),(1, 20, '2016-7-31', 12),(1, 21, '2016-7-31', 12),(1, 22, '2016-7-31', 34),(1, 23, '2016-7-31', 528),(1, 24, '2016-7-31', 2303),(1, 25, '2016-7-31', 893),(1, 26, '2016-7-31', 356),(1, 27, '2016-7-31', 415),(1, 28, '2016-7-31', 301),
    (1, 1, '2016-8-31', 113),(1, 2, '2016-8-31', 17),(1, 3, '2016-8-31', 389),(1, 4, '2016-8-31', 32),(1, 5, '2016-8-31', 53),(1, 6, '2016-8-31', 15),(1, 7, '2016-8-31', 168),(1, 8, '2016-8-31', 24),(1, 9, '2016-8-31', 86),(1, 10, '2016-8-31', 12),(1, 11, '2016-8-31', 218),(1, 12, '2016-8-31', 22),(1, 13, '2016-8-31', 15),(1, 14, '2016-8-31', 27),(1, 15, '2016-8-31', 50),(1, 16, '2016-8-31', 98),(1, 17, '2016-8-31', 59),(1, 18, '2016-8-31', 171),(1, 19, '2016-8-31', 7),(1, 20, '2016-8-31', 12),(1, 21, '2016-8-31', 12),(1, 22, '2016-8-31', 34),(1, 23, '2016-8-31', 528),(1, 24, '2016-8-31', 2303),(1, 25, '2016-8-31', 893),(1, 26, '2016-8-31', 356),(1, 27, '2016-8-31', 415),(1, 28, '2016-8-31', 301),
    (1, 1, '2016-9-30', 113),(1, 2, '2016-9-30', 17),(1, 3, '2016-9-30', 389),(1, 4, '2016-9-30', 32),(1, 5, '2016-9-30', 53),(1, 6, '2016-9-30', 15),(1, 7, '2016-9-30', 168),(1, 8, '2016-9-30', 24),(1, 9, '2016-9-30', 86),(1, 10, '2016-9-30', 12),(1, 11, '2016-9-30', 218),(1, 12, '2016-9-30', 22),(1, 13, '2016-9-30', 15),(1, 14, '2016-9-30', 27),(1, 15, '2016-9-30', 50),(1, 16, '2016-9-30', 98),(1, 17, '2016-9-30', 59),(1, 18, '2016-9-30', 171),(1, 19, '2016-9-30', 7),(1, 20, '2016-9-30', 12),(1, 21, '2016-9-30', 12),(1, 22, '2016-9-30', 34),(1, 23, '2016-9-30', 528),(1, 24, '2016-9-30', 2303),(1, 25, '2016-9-30', 893),(1, 26, '2016-9-30', 356),(1, 27, '2016-9-30', 415),(1, 28, '2016-9-30', 301),
    (1, 1, '2016-10-31', 113),(1, 2, '2016-10-31', 17),(1, 3, '2016-10-31', 389),(1, 4, '2016-10-31', 32),(1, 5, '2016-10-31', 53),(1, 6, '2016-10-31', 15),(1, 7, '2016-10-31', 168),(1, 8, '2016-10-31', 24),(1, 9, '2016-10-31', 86),(1, 10, '2016-10-31', 12),(1, 11, '2016-10-31', 218),(1, 12, '2016-10-31', 22),(1, 13, '2016-10-31', 15),(1, 14, '2016-10-31', 27),(1, 15, '2016-10-31', 50),(1, 16, '2016-10-31', 98),(1, 17, '2016-10-31', 59),(1, 18, '2016-10-31', 171),(1, 19, '2016-10-31', 7),(1, 20, '2016-10-31', 12),(1, 21, '2016-10-31', 12),(1, 22, '2016-10-31', 34),(1, 23, '2016-10-31', 528),(1, 24, '2016-10-31', 2303),(1, 25, '2016-10-31', 893),(1, 26, '2016-10-31', 356),(1, 27, '2016-10-31', 415),(1, 28, '2016-10-31', 301),
    (1, 1, '2016-11-30', 113),(1, 2, '2016-11-30', 17),(1, 3, '2016-11-30', 389),(1, 4, '2016-11-30', 32),(1, 5, '2016-11-30', 53),(1, 6, '2016-11-30', 15),(1, 7, '2016-11-30', 168),(1, 8, '2016-11-30', 24),(1, 9, '2016-11-30', 86),(1, 10, '2016-11-30', 12),(1, 11, '2016-11-30', 218),(1, 12, '2016-11-30', 22),(1, 13, '2016-11-30', 15),(1, 14, '2016-11-30', 27),(1, 15, '2016-11-30', 50),(1, 16, '2016-11-30', 98),(1, 17, '2016-11-30', 59),(1, 18, '2016-11-30', 171),(1, 19, '2016-11-30', 7),(1, 20, '2016-11-30', 12),(1, 21, '2016-11-30', 12),(1, 22, '2016-11-30', 34),(1, 23, '2016-11-30', 528),(1, 24, '2016-11-30', 2303),(1, 25, '2016-11-30', 893),(1, 26, '2016-11-30', 356),(1, 27, '2016-11-30', 415),(1, 28, '2016-11-30', 301),
    (1, 1, '2016-12-31', 113),(1, 2, '2016-12-31', 17),(1, 3, '2016-12-31', 389),(1, 4, '2016-12-31', 32),(1, 5, '2016-12-31', 53),(1, 6, '2016-12-31', 15),(1, 7, '2016-12-31', 168),(1, 8, '2016-12-31', 24),(1, 9, '2016-12-31', 86),(1, 10, '2016-12-31', 12),(1, 11, '2016-12-31', 218),(1, 12, '2016-12-31', 22),(1, 13, '2016-12-31', 15),(1, 14, '2016-12-31', 27),(1, 15, '2016-12-31', 50),(1, 16, '2016-12-31', 98),(1, 17, '2016-12-31', 59),(1, 18, '2016-12-31', 171),(1, 19, '2016-12-31', 7),(1, 20, '2016-12-31', 12),(1, 21, '2016-12-31', 12),(1, 22, '2016-12-31', 34),(1, 23, '2016-12-31', 528),(1, 24, '2016-12-31', 2303),(1, 25, '2016-12-31', 893),(1, 26, '2016-12-31', 356),(1, 27, '2016-12-31', 415),(1, 28, '2016-12-31', 301);


INSERT INTO purchaseOrder VALUES
	(010117, 1, '2017-01-01', 1, 11, 10, 40),(010117, 1, '2017-01-01', 1, 12, 20, 60),(010117, 1, '2017-01-01', 1, 13, 14, 40),(010117, 1, '2017-01-01', 1, 14, 12, 60),(010117, 1, '2017-01-01', 1, 15, 8, 10),(010117, 1, '2017-01-01', 1, 16, 77, 55),
    (010217, 1, '2017-01-02', 1, 11, 10, 40),(010217, 1, '2017-01-02', 1, 12, 55, 40),(010217, 1, '2017-01-02', 1, 13, 10, 23),(010217, 1, '2017-01-02', 1, 14, 10, 20),(010217, 1, '2017-01-02', 2, 21, 10, 43),
    (010317, 2, '2017-01-03', 2, 21, 3, 12),(010317, 2, '2017-01-03', 2, 22, 3, 45),(010317, 2, '2017-01-03', 2, 23, 44, 10),(010317, 2, '2017-01-03', 2, 24, 50, 100),(010317, 2, '2017-01-03', 2, 25, 21, 60),(010317, 2, '2017-01-03', 2, 26, 31, 99);


INSERT INTO deliveryReceipt VALUES
	(010117, 1, 1, '2017-01-01', 1, 10), (010117, 1, 1, '2017-01-01', 2, 10), (010117, 1, 1, '2017-01-01', 3, 10), (010117, 1, 1, '2017-01-01', 4, 10), (010117, 1, 1, '2017-01-01', 5, 10), (010117, 1, 1, '2017-01-01', 6, 10), (010117, 1, 1, '2017-01-01', 7, 10), (010117, 1, 1, '2017-01-01', 8, 10);

-- Viewing the Delivery Receipt for a specified Month, Year and commissary.
DROP PROCEDURE IF EXISTS `view_DR`
DELIMITER $$
CREATE PROCEDURE `view_DR`(targetDay DATE, comID INT)
BEGIN

	SELECT dr.drID, dr.deliveryDate, com.commissaryName, br.branchName, stk.stockName, stk.stockUnit, dr.deliveryQuantity FROM deliveryReceipt AS dr
		JOIN commissary AS com ON dr.commissaryID = com.commissaryID
		JOIN branch AS br ON dr.branchID = br.branchID
		JOIN stock AS stk ON dr.stockID = stk.stockID
		WHERE YEAR(dr.deliveryDate) = YEAR(targetDay) AND MONTH(dr.deliveryDate) = MONTH(targetDay) AND com.commissaryID = comID;

END$$
DELIMITER ;

-- Viewing the Purchase Order for a specified Month, Year and commissary
DROP PROCEDURE IF EXISTS `view_PO`
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `view_PO`(targetDay DATE, comID INT)
BEGIN

	SELECT po.purchaseDate, po.poNum, spl.supplierName, com.commissaryName, stk.stockName, stk.stockUnit, po.purchaseQuantity, po.priceperUnit, (po.purchaseQuantity * po.priceperUnit) AS 'Purchasing' FROM purchaseOrder AS po
		JOIN commissary AS com ON po.commissaryID = com.commissaryID
		JOIN supplier AS spl ON po.supplierID = spl.supplierID
		JOIN stock AS stk ON stk.stockID = po.stockID
        WHERE YEAR(po.purchaseDate) = YEAR(targetDay) AND MONTH(purchaseDate) = MONTH(targetDay) AND com.commissaryID = comID;

END$$
DELIMITER ;

-- Generate the ending inventory for the month.
DROP PROCEDURE IF EXISTS `create_ending`;
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `create_ending` (comID INT, mon DATE)
BEGIN

	INSERT INTO endingInventory(commissaryID, stockID, year, date, endingQuantity)
		SELECT c.commissaryID, s.stockID, YEAR(mon), mon, ci.quantity FROM commissary AS c
			JOIN commissaryInventory AS ci ON c.commissaryID = ci.commissaryID
            JOIN stock AS s ON ci.stockID = s.stockID
			WHERE c.commissaryID = comID;

END$$
DELIMITER ;



-- Update the commissary inventory stock quantity. 
DROP PROCEDURE IF EXISTS `update_cominventory`;
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `update_cominventory`(comID INT, stkID INT, q DOUBLE)
BEGIN
	
    UPDATE commissaryInventory
		SET quantity = q
        WHERE commissaryID = comID AND stockID = stkID;
    
END$$
DELIMITER ;




-- Update the branch inventory stock quantity. 
DROP PROCEDURE IF EXISTS `update_brninventory`;
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `update_brninventory`(brnID INT, stkID INT, q DOUBLE)
BEGIN
	
    UPDATE branchInventory
		SET quantity = q
        WHERE branchID = brnID AND stockID = stkID;
    
END$$
DELIMITER ;





-- Views the ending inventory the specified month and commissary
DROP PROCEDURE IF EXISTS `endingInventoryForm`;
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `endingInventoryForm`(comID INT, target DATE)
BEGIN
	
    SELECT ending.date AS 'Date', com.commissaryName AS 'Commissary Name', stk.stockName AS 'Stock Name', stk.stockUnit AS 'Stock Unit', stk.floorLevel AS 'Floor Level', ending.endingQuantity AS 'Monthly Ending Quantity',
		CASE
			WHEN ending.endingQuantity = 0 THEN 'Out of Stock'
			WHEN ending.endingQuantity <= stk.floorLevel THEN 'Low in Stock'
            WHEN ending.endingQuantity > stk.floorLevel THEN 'In Stock'
		END AS 'Status'
        FROM endingInventory AS ending
		JOIN commissary as com ON ending.commissaryID = com.commissaryID
        JOIN stock AS stk ON ending.stockID = stk.stockID
        WHERE ending.date = target AND ending.commissaryID = comID;
    
END$$
DELIMITER ;


-- Views the sales report of the branch with specified month
DROP PROCEDURE IF EXISTS `view_salesReport`;
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `view_salesReport`(brID INT, target DATE)
BEGIN

	SELECT m.menuName AS 'Menu Name', sr.transactions AS 'Transactions', m.menucosting AS 'Menu Costing', m.menuPrice AS 'Menu Price' FROM salesReport AS sr
		JOIN menu AS m ON m.menuID = sr.menuID
        JOIN branch AS br ON sr.branchID = br.branchID
        WHERE br.branchID = brID AND sr.date = target;
        
	SELECT m.menuName AS 'Menu Name', sr.transactions AS 'Transactions', FORMAT((m.menuCosting * sr.transactions), 2) AS Cost, FORMAT((m.menuPriceVat * sr.transactions), 2) AS Sales FROM salesreport AS sr
		JOIN menu AS m ON sr.menuID = m.menuID
		JOIN branch AS br ON sr.branchID = br.branchID
		WHERE sr.date = target AND br.branchID = brID;
	
    SELECT calc.category, FORMAT(SUM(calc.Cost), 2) AS 'Category Cost', FORMAT(SUM(calc.Sales), 2) AS 'Category Sales', CONCAT(FORMAT(((SUM(calc.Cost) / SUM(calc.Sales)) * 100), 1), '%') AS 'Cost of Sales'
		FROM(
			SELECT m.category AS category, sr.transactions, (m.menuCosting * sr.transactions) AS Cost, (m.menuPriceVat * sr.transactions) AS Sales FROM salesreport AS sr
				JOIN menu AS m ON sr.menuID = m.menuID
                JOIN branch AS br ON sr.branchID = br.branchID
				WHERE date = target AND br.branchID = brID
			) AS calc
		GROUP BY 1;

END$$
DELIMITER ;



-- Views the entire suppliers and the stocks they delivery to the company.
DROP PROCEDURE IF EXISTS `view_supplierManagement`;
DELIMITER $$
USE `dbproject`$$
CREATE PROCEDURE `view_supplierManagement`()
BEGIN

	SELECT spl.supplierID AS 'Supplier ID', spl.supplierName AS 'Supplier', s.stockID AS 'Stock ID', s.stockName AS 'Stock', s.stockUnit AS 'Stock Unit' FROM supply AS sp
		JOIN supplier AS spl ON sp.supplierID = spl.supplierID
		JOIN stock AS s ON sp.stockID = s.stockID;

END$$
DELIMITER ;