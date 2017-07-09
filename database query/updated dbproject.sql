-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_appdev_udated
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_appdev_udated` ;

-- -----------------------------------------------------
-- Schema db_appdev_udated
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_appdev_udated` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema dbsalesdw
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dbsalesdw` ;

-- -----------------------------------------------------
-- Schema dbsalesdw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbsalesdw` DEFAULT CHARACTER SET utf8 ;
USE `db_appdev_udated` ;

-- -----------------------------------------------------
-- Table `db_appdev_udated`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`stock` (
  `stock_id` INT(11) NOT NULL AUTO_INCREMENT,
  `stock_name` VARCHAR(45) NOT NULL,
  `stock_unit` VARCHAR(45) NOT NULL,
  `floor_level` DOUBLE NOT NULL,
  `ceil_level` DOUBLE NOT NULL,
  PRIMARY KEY (`stock_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`commissary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`commissary` (
  `com_id` INT(11) NOT NULL,
  `com_name` VARCHAR(45) NOT NULL,
  `com_addr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`com_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`branch` (
  `br_id` INT(11) NOT NULL,
  `br_name` VARCHAR(45) NOT NULL,
  `br_addr` VARCHAR(45) NOT NULL,
  `com_id` INT(11) NOT NULL,
  PRIMARY KEY (`br_id`, `com_id`),
  INDEX `fk_branch_commissary1_idx` (`com_id` ASC),
  CONSTRAINT `fk_branch_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_udated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`br_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`br_inventory` (
  `br_id` INT(11) NOT NULL,
  `stock_id` INT(11) NOT NULL,
  `recorded_date` DATE NOT NULL,
  `qty` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`br_id`, `stock_id`, `recorded_date`),
  INDEX `fk_br_inventory_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_br_inventory_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_udated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_br_inventory_branch1`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_udated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`com_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`com_inventory` (
  `com_id` INT(11) NOT NULL,
  `stock_id` INT(11) NOT NULL,
  `recorded_date` DATE NOT NULL,
  `qty` DOUBLE NOT NULL,
  PRIMARY KEY (`com_id`, `stock_id`, `recorded_date`),
  INDEX `fk_com_inventory_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_com_inventory_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_udated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_com_inventory_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_udated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`user_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`user_types` (
  `type_id` INT(11) NOT NULL,
  `user_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`employee` (
  `emp_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `user_type` INT(11) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `is_employed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`emp_id`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC),
  INDEX `fk_employee_user_type_idx` (`user_type` ASC),
  CONSTRAINT `fk_employee_user_type`
    FOREIGN KEY (`user_type`)
    REFERENCES `db_appdev_udated`.`user_types` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`emp_br`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`emp_br` (
  `br_id` INT(11) NOT NULL,
  `emp_id` INT(11) NOT NULL,
  `from_date` DATE NULL,
  `to_date` DATE NULL,
  PRIMARY KEY (`br_id`, `emp_id`),
  INDEX `fk_emp_br_employee1_idx` (`emp_id` ASC),
  CONSTRAINT `fk_emp_br_branch1`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_udated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_br_employee1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `db_appdev_udated`.`employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`emp_com`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`emp_com` (
  `com_id` INT(11) NOT NULL,
  `emp_id` INT(11) NOT NULL,
  `from_date` DATE NULL,
  `to_date` DATE NULL,
  PRIMARY KEY (`com_id`, `emp_id`),
  INDEX `fk_emp_com_employee1_idx` (`emp_id` ASC),
  CONSTRAINT `fk_emp_com_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_udated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_com_employee1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `db_appdev_udated`.`employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`menu` (
  `menu_id` INT(11) NOT NULL,
  `menu_name` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`sales` (
  `sales_id` INT(11) NOT NULL,
  `br_id` INT(11) NOT NULL,
  `sales_month` DATE NOT NULL,
  PRIMARY KEY (`sales_id`, `br_id`),
  INDEX `fk_sales_branch1_idx` (`br_id` ASC),
  CONSTRAINT `fk_sales_branch1`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_udated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`sales_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`sales_menu` (
  `sales_id` INT(11) NOT NULL,
  `menu_id` INT(11) NOT NULL,
  `transact` INT(11) NOT NULL,
  `price_vat` DOUBLE NOT NULL,
  `price_each` DOUBLE NOT NULL,
  `costing` DOUBLE NOT NULL,
  PRIMARY KEY (`sales_id`, `menu_id`),
  INDEX `fk_sales_menu_menu1_idx` (`menu_id` ASC),
  CONSTRAINT `fk_sales_menu_sales1`
    FOREIGN KEY (`sales_id`)
    REFERENCES `db_appdev_udated`.`sales` (`sales_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_menu_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `db_appdev_udated`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`supplier` (
  `supplier_id` INT(11) NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `company_contact_info` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`sup_stk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`sup_stk` (
  `supplier_id` INT(11) NOT NULL,
  `stock_id` INT(11) NOT NULL,
  PRIMARY KEY (`supplier_id`, `stock_id`),
  INDEX `fk_sup_stk_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_sup_stk_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `db_appdev_udated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sup_stk_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_udated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`supplier_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`supplier_contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `contact_name` VARCHAR(45) NOT NULL,
  `contact_info` VARCHAR(45) NOT NULL,
  `is_contactable` TINYINT(1) NOT NULL,
  PRIMARY KEY (`contact_id`, `supplier_id`),
  INDEX `fk_supplier_contact_supplier1_idx` (`supplier_id` ASC),
  CONSTRAINT `fk_supplier_contact_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `db_appdev_udated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`requisition_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`requisition_order` (
  `req_id` INT NOT NULL AUTO_INCREMENT,
  `br_id` INT NOT NULL,
  `record_date` DATE NOT NULL,
  PRIMARY KEY (`req_id`, `br_id`),
  INDEX `fk_requisition_order_branch1_idx` (`br_id` ASC),
  CONSTRAINT `fk_requisition_order_branch1`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_udated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`req_ref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`req_ref` (
  `req_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `qty_requested` DOUBLE NOT NULL,
  PRIMARY KEY (`req_id`, `stock_id`),
  INDEX `fk_req_ref_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_req_ref_requisition_order1`
    FOREIGN KEY (`req_id`)
    REFERENCES `db_appdev_udated`.`requisition_order` (`req_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_req_ref_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_udated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`commissary_dr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`commissary_dr` (
  `com_dr_id` INT NOT NULL AUTO_INCREMENT,
  `com_id` INT NOT NULL,
  `destination_br` INT NOT NULL,
  `creation_date` DATE NOT NULL,
  PRIMARY KEY (`com_dr_id`, `com_id`, `destination_br`),
  INDEX `fk_commissary_dr_commissary1_idx` (`com_id` ASC),
  INDEX `fk_commissary_dr_branch1_idx` (`destination_br` ASC),
  CONSTRAINT `fk_commissary_dr_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_udated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commissary_dr_branch1`
    FOREIGN KEY (`destination_br`)
    REFERENCES `db_appdev_udated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`com_dr_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`com_dr_details` (
  `com_dr_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `deliver_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`com_dr_id`, `stock_id`),
  INDEX `fk_com_dr_ref_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_com_dr_ref_commissary_dr1`
    FOREIGN KEY (`com_dr_id`)
    REFERENCES `db_appdev_udated`.`commissary_dr` (`com_dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_com_dr_ref_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_udated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`supplier_dr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`supplier_dr` (
  `sup_dr_id` INT NOT NULL,
  `sup_id` INT NOT NULL,
  `com_id` INT NOT NULL,
  `received_date` DATE NOT NULL,
  PRIMARY KEY (`sup_dr_id`, `sup_id`, `com_id`),
  INDEX `fk_supplier_dr_supplier1_idx` (`sup_id` ASC),
  INDEX `fk_supplier_dr_commissary1_idx` (`com_id` ASC),
  CONSTRAINT `fk_supplier_dr_supplier1`
    FOREIGN KEY (`sup_id`)
    REFERENCES `db_appdev_udated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_dr_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_udated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_udated`.`sup_dr_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_appdev_udated`.`sup_dr_details` (
  `sup_dr_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `deliver_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`sup_dr_id`, `stock_id`),
  INDEX `fk_sup_dr_ref_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_sup_dr_ref_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_udated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sup_dr_ref_supplier_dr1`
    FOREIGN KEY (`sup_dr_id`)
    REFERENCES `db_appdev_udated`.`supplier_dr` (`sup_dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `dbsalesdw` ;

-- -----------------------------------------------------
-- Table `dbsalesdw`.`dim_month`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsalesdw`.`dim_month` (
  `monthID` INT(11) NOT NULL,
  `month` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`monthID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsalesdw`.`dim_productline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsalesdw`.`dim_productline` (
  `productlineID` INT(11) NOT NULL,
  `productline` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`productlineID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsalesdw`.`dim_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsalesdw`.`dim_product` (
  `productID` INT(11) NOT NULL,
  `productCODE` VARCHAR(15) NULL DEFAULT NULL,
  `productNAME` VARCHAR(70) NULL DEFAULT NULL,
  `productlineID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`productID`),
  INDEX `fk_DIM_PRODUCT_DIM_PRODUCTLINE_idx` (`productlineID` ASC),
  CONSTRAINT `fk_DIM_PRODUCT_DIM_PRODUCTLINE`
    FOREIGN KEY (`productlineID`)
    REFERENCES `dbsalesdw`.`dim_productline` (`productlineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsalesdw`.`dim_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsalesdw`.`dim_year` (
  `yearID` INT(11) NOT NULL,
  PRIMARY KEY (`yearID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbsalesdw`.`facttable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbsalesdw`.`facttable` (
  `productID` INT(11) NOT NULL,
  `monthID` INT(11) NOT NULL,
  `yearID` INT(11) NOT NULL,
  `saleAtMSRP` DOUBLE NULL DEFAULT NULL,
  `actualSale` DOUBLE NULL DEFAULT NULL,
  `noOfOrders` INT(11) NULL DEFAULT NULL,
  `totalTax` DOUBLE NULL DEFAULT NULL,
  `totalcostofbuying` DOUBLE NULL DEFAULT NULL,
  `totalincome` DOUBLE NULL DEFAULT NULL,
  `totaldiscount` DOUBLE NULL DEFAULT NULL,
  `totalmarkup` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`productID`, `monthID`, `yearID`),
  INDEX `fk_FACTTABLE_DIM_MONTH1_idx` (`monthID` ASC),
  INDEX `fk_FACTTABLE_DIM_YEAR1_idx` (`yearID` ASC),
  CONSTRAINT `fk_FACTTABLE_DIM_MONTH1`
    FOREIGN KEY (`monthID`)
    REFERENCES `dbsalesdw`.`dim_month` (`monthID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTTABLE_DIM_PRODUCT1`
    FOREIGN KEY (`productID`)
    REFERENCES `dbsalesdw`.`dim_product` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTTABLE_DIM_YEAR1`
    FOREIGN KEY (`yearID`)
    REFERENCES `dbsalesdw`.`dim_year` (`yearID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `db_appdev_udated`.`commissary`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_udated`;
INSERT INTO `db_appdev_udated`.`commissary` (`com_id`, `com_name`, `com_addr`) VALUES (1000, 'TempCommissart', 'temp');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_udated`.`branch`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_udated`;
INSERT INTO `db_appdev_udated`.`branch` (`br_id`, `br_name`, `br_addr`, `com_id`) VALUES (1100, 'TempBranch', '1', 1000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_udated`.`user_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_udated`;
INSERT INTO `db_appdev_udated`.`user_types` (`type_id`, `user_type`) VALUES (101, 'Admin');
INSERT INTO `db_appdev_udated`.`user_types` (`type_id`, `user_type`) VALUES (102, 'Branch Manager');
INSERT INTO `db_appdev_udated`.`user_types` (`type_id`, `user_type`) VALUES (103, 'Commissary Clerk');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_udated`.`employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_udated`;
INSERT INTO `db_appdev_udated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (1, 'TempAdmin', PASSWORD('admin'), 'Yuta', 'Inoue', 101, 1, 1);

COMMIT;

USE `db_appdev_udated`;

DELIMITER $$
USE `db_appdev_udated`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `db_appdev_udated`.`commissary_BEFORE_INSERT`
BEFORE INSERT ON `db_appdev_udated`.`commissary`
FOR EACH ROW
BEGIN
	SET NEW.COM_ID = (SELECT (MAX(COM_ID)+1) FROM COMMISSARY);
END$$

USE `db_appdev_udated`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `db_appdev_udated`.`branch_BEFORE_INSERT`
BEFORE INSERT ON `db_appdev_udated`.`branch`
FOR EACH ROW
BEGIN
	SET NEW.BR_ID = (SELECT (MAX(BR_ID)+1) FROM COMMISSARY);
END$$

USE `db_appdev_udated`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `db_appdev_udated`.`employee_BEFORE_INSERT`
BEFORE INSERT ON `db_appdev_udated`.`employee`
FOR EACH ROW
BEGIN
	SET NEW.PASSWORD = PASSWORD(NEW.PASSWORD);
    SET NEW.IS_ACTIVE = FALSE;
    SET NEW.IS_EMPLOYED = TRUE;
END$$

USE `db_appdev_udated`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `db_appdev_udated`.`employee_BEFORE_UPDATE`
BEFORE UPDATE ON `db_appdev_udated`.`employee`
FOR EACH ROW
BEGIN
	SET NEW.PASSWORD = PASSWORD(NEW.PASSWORD);
END$$

USE `db_appdev_udated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_udated`.`supplier_BEFORE_INSERT` BEFORE INSERT ON `supplier` FOR EACH ROW
BEGIN
	SET NEW.ACTIVE = TRUE;
END$$

USE `db_appdev_udated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_udated`.`supplier_contact_BEFORE_INSERT` BEFORE INSERT ON `supplier_contact` FOR EACH ROW
BEGIN
	SET NEW.IS_CONTACTABLE = TRUE;
END$$

USE `db_appdev_udated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_udated`.`requisition_order_BEFORE_INSERT` BEFORE INSERT ON `requisition_order` FOR EACH ROW
BEGIN
	SET NEW.RECORD_DATE = NOW();
	IF((SELECT MAX(RECORD_DATE) FROM REQUISITION_ORDER) = NEW.RECORD_DATE) THEN
		SIGNAL SQLSTATE '49001' SET MESSAGE_TEXT = 'Cannot create multiple requisition order at the same day.';
    END IF;
END$$


DELIMITER ;