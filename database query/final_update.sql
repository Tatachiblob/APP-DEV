-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema db_appdev_updated
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_appdev_updated` ;

-- -----------------------------------------------------
-- Schema db_appdev_updated
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_appdev_updated` DEFAULT CHARACTER SET utf8 ;
USE `db_appdev_updated` ;

-- -----------------------------------------------------
-- Table `db_appdev_updated`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`stock` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`stock` (
  `stock_id` INT(11) NOT NULL AUTO_INCREMENT,
  `stock_name` VARCHAR(45) NOT NULL,
  `stock_unit` VARCHAR(45) NOT NULL,
  `floor_level` DOUBLE NOT NULL,
  `ceil_level` DOUBLE NOT NULL,
  PRIMARY KEY (`stock_id`),
  UNIQUE INDEX `stock_name_UNIQUE` (`stock_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`commissary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`commissary` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`commissary` (
  `com_id` INT(11) NOT NULL,
  `com_name` VARCHAR(45) NOT NULL,
  `com_addr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`com_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`branch` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`branch` (
  `br_id` INT(11) NOT NULL,
  `br_name` VARCHAR(45) NOT NULL,
  `br_addr` VARCHAR(45) NOT NULL,
  `com_id` INT(11) NOT NULL,
  PRIMARY KEY (`br_id`, `com_id`),
  INDEX `fk_branch_commissary1_idx` (`com_id` ASC),
  CONSTRAINT `fk_branch_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`br_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`br_inventory` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`br_inventory` (
  `br_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `current_qty` DOUBLE NULL,
  PRIMARY KEY (`br_id`, `stock_id`),
  INDEX `fk_br_inventory_stock2_idx` (`stock_id` ASC),
  CONSTRAINT `fk_br_inventory_branch2`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_updated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_br_inventory_stock2`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`user_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`user_types` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`user_types` (
  `type_id` INT(11) NOT NULL,
  `user_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`employee` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`employee` (
  `emp_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `user_type` INT(11) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `is_employed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `fk_employee_user_type_idx` (`user_type` ASC),
  CONSTRAINT `fk_employee_user_type`
    FOREIGN KEY (`user_type`)
    REFERENCES `db_appdev_updated`.`user_types` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`emp_br`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`emp_br` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`emp_br` (
  `br_id` INT(11) NOT NULL,
  `emp_id` INT(11) NOT NULL,
  `from_date` DATE NULL,
  `to_date` DATE NULL,
  PRIMARY KEY (`br_id`, `emp_id`),
  INDEX `fk_emp_br_employee1_idx` (`emp_id` ASC),
  CONSTRAINT `fk_emp_br_branch1`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_updated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_br_employee1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `db_appdev_updated`.`employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`emp_com`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`emp_com` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`emp_com` (
  `com_id` INT(11) NOT NULL,
  `emp_id` INT(11) NOT NULL,
  `from_date` DATE NULL,
  `to_date` DATE NULL,
  PRIMARY KEY (`com_id`, `emp_id`),
  INDEX `fk_emp_com_employee1_idx` (`emp_id` ASC),
  CONSTRAINT `fk_emp_com_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_com_employee1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `db_appdev_updated`.`employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`supplier` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`supplier` (
  `supplier_id` INT(11) NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(45) NOT NULL,
  `company_contact_info` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`sup_stk`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`sup_stk` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`sup_stk` (
  `supplier_id` INT(11) NOT NULL,
  `stock_id` INT(11) NOT NULL,
  PRIMARY KEY (`supplier_id`, `stock_id`),
  INDEX `fk_sup_stk_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_sup_stk_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `db_appdev_updated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sup_stk_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`supplier_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`supplier_contact` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`supplier_contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `contact_name` VARCHAR(45) NOT NULL,
  `contact_info` VARCHAR(45) NOT NULL,
  `is_contactable` TINYINT(1) NOT NULL,
  PRIMARY KEY (`contact_id`, `supplier_id`),
  INDEX `fk_supplier_contact_supplier1_idx` (`supplier_id` ASC),
  CONSTRAINT `fk_supplier_contact_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `db_appdev_updated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`requisition_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`requisition_order` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`requisition_order` (
  `req_id` INT NOT NULL AUTO_INCREMENT,
  `br_id` INT NOT NULL,
  `record_date` DATETIME NOT NULL,
  PRIMARY KEY (`req_id`, `br_id`),
  INDEX `fk_requisition_order_branch1_idx` (`br_id` ASC),
  CONSTRAINT `fk_requisition_order_branch1`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_updated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`requisitionDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`requisitionDetails` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`requisitionDetails` (
  `req_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `qty_requested` DOUBLE NOT NULL,
  PRIMARY KEY (`req_id`, `stock_id`),
  INDEX `fk_req_ref_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_req_ref_requisition_order1`
    FOREIGN KEY (`req_id`)
    REFERENCES `db_appdev_updated`.`requisition_order` (`req_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_req_ref_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`commissary_dr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`commissary_dr` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`commissary_dr` (
  `com_dr_id` INT NOT NULL AUTO_INCREMENT,
  `com_id` INT NOT NULL,
  `destination_br` INT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`com_dr_id`, `com_id`, `destination_br`),
  INDEX `fk_commissary_dr_commissary1_idx` (`com_id` ASC),
  INDEX `fk_commissary_dr_branch1_idx` (`destination_br` ASC),
  CONSTRAINT `fk_commissary_dr_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commissary_dr_branch1`
    FOREIGN KEY (`destination_br`)
    REFERENCES `db_appdev_updated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`com_drDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`com_drDetails` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`com_drDetails` (
  `com_dr_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `deliver_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`com_dr_id`, `stock_id`),
  INDEX `fk_com_dr_ref_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_com_dr_ref_commissary_dr1`
    FOREIGN KEY (`com_dr_id`)
    REFERENCES `db_appdev_updated`.`commissary_dr` (`com_dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_com_dr_ref_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`supplier_dr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`supplier_dr` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`supplier_dr` (
  `sup_dr_id` INT NOT NULL AUTO_INCREMENT,
  `sup_id` INT NOT NULL,
  `com_id` INT NOT NULL,
  `received_date` DATETIME NOT NULL,
  PRIMARY KEY (`sup_dr_id`, `sup_id`, `com_id`),
  INDEX `fk_supplier_dr_supplier1_idx` (`sup_id` ASC),
  INDEX `fk_supplier_dr_commissary1_idx` (`com_id` ASC),
  CONSTRAINT `fk_supplier_dr_supplier1`
    FOREIGN KEY (`sup_id`)
    REFERENCES `db_appdev_updated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_dr_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`sup_drDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`sup_drDetails` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`sup_drDetails` (
  `sup_dr_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `deliver_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`sup_dr_id`, `stock_id`),
  INDEX `fk_sup_dr_ref_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_sup_dr_ref_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sup_dr_ref_supplier_dr1`
    FOREIGN KEY (`sup_dr_id`)
    REFERENCES `db_appdev_updated`.`supplier_dr` (`sup_dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`com_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`com_inventory` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`com_inventory` (
  `com_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `current_qty` DOUBLE NULL,
  PRIMARY KEY (`com_id`, `stock_id`),
  INDEX `fk_com_inventroy_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_com_inventroy_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_com_inventroy_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`br_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`br_inventory` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`br_inventory` (
  `br_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `current_qty` DOUBLE NULL,
  PRIMARY KEY (`br_id`, `stock_id`),
  INDEX `fk_br_inventory_stock2_idx` (`stock_id` ASC),
  CONSTRAINT `fk_br_inventory_branch2`
    FOREIGN KEY (`br_id`)
    REFERENCES `db_appdev_updated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_br_inventory_stock2`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`com_monthly_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`com_monthly_inventory` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`com_monthly_inventory` (
  `com_inventory_id` INT NOT NULL AUTO_INCREMENT,
  `com_id` INT NOT NULL,
  `yearMonth` DATE NOT NULL,
  `time_stamp` DATETIME NULL,
  PRIMARY KEY (`com_inventory_id`, `com_id`, `yearMonth`),
  CONSTRAINT `fk_com_monthly_inventory_com_inventroy1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`com_inventory` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`br_delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`br_delivery` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`br_delivery` (
  `branch_dr_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  `received_date` DATETIME NOT NULL,
  PRIMARY KEY (`branch_dr_id`, `supplier_id`, `branch_id`),
  INDEX `fk_br_delivery_supplier1_idx` (`supplier_id` ASC),
  INDEX `fk_br_delivery_branch1_idx` (`branch_id` ASC),
  CONSTRAINT `fk_br_delivery_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `db_appdev_updated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_br_delivery_branch1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `db_appdev_updated`.`branch` (`br_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`br_deliveryDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`br_deliveryDetails` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`br_deliveryDetails` (
  `branch_dr_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `delivery_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`branch_dr_id`, `stock_id`),
  INDEX `fk_br_deliveryDetails_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_br_deliveryDetails_br_delivery1`
    FOREIGN KEY (`branch_dr_id`)
    REFERENCES `db_appdev_updated`.`br_delivery` (`branch_dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_br_deliveryDetails_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`purchase_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`purchase_order` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`purchase_order` (
  `po_id` INT NOT NULL AUTO_INCREMENT,
  `com_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`po_id`, `com_id`, `supplier_id`),
  INDEX `fk_purchase_order_commissary1_idx` (`com_id` ASC),
  INDEX `fk_purchase_order_supplier1_idx` (`supplier_id` ASC),
  CONSTRAINT `fk_purchase_order_commissary1`
    FOREIGN KEY (`com_id`)
    REFERENCES `db_appdev_updated`.`commissary` (`com_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_order_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `db_appdev_updated`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`po_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`po_details` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`po_details` (
  `po_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `request_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`po_id`, `stock_id`),
  INDEX `fk_po_details_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_po_details_purchase_order1`
    FOREIGN KEY (`po_id`)
    REFERENCES `db_appdev_updated`.`purchase_order` (`po_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_po_details_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_appdev_updated`.`monthly_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_appdev_updated`.`monthly_details` ;

CREATE TABLE IF NOT EXISTS `db_appdev_updated`.`monthly_details` (
  `com_inventory_id` INT NOT NULL,
  `stock_id` INT NOT NULL,
  `actual_qty` DOUBLE NOT NULL,
  `discrepancy_qty` DOUBLE NOT NULL,
  PRIMARY KEY (`com_inventory_id`, `stock_id`),
  INDEX `fk_monthly_details_stock1_idx` (`stock_id` ASC),
  CONSTRAINT `fk_monthly_details_com_monthly_inventory1`
    FOREIGN KEY (`com_inventory_id`)
    REFERENCES `db_appdev_updated`.`com_monthly_inventory` (`com_inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monthly_details_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `db_appdev_updated`.`stock` (`stock_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`stock`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (1, 'Pork Loin', 'KG', 10, 70);
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (2, 'Soba', 'KG', 5.5, 45.9);
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (3, 'Udon', 'KG', 40.3, 70.8);
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (4, 'Egg', 'PCS', 30, 100);
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (5, 'Carrot', 'KG', 20, 70);
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (6, 'Soy Sauce', 'L', 1, 10);
INSERT INTO `db_appdev_updated`.`stock` (`stock_id`, `stock_name`, `stock_unit`, `floor_level`, `ceil_level`) VALUES (7, 'Cooking Oil', 'L', 4, 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`commissary`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`commissary` (`com_id`, `com_name`, `com_addr`) VALUES (1000, 'TempCommissary', 'temp');
INSERT INTO `db_appdev_updated`.`commissary` (`com_id`, `com_name`, `com_addr`) VALUES (1001, 'Pasig Commissary', 'Pasig City');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`branch`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`branch` (`br_id`, `br_name`, `br_addr`, `com_id`) VALUES (1100, 'TempBranch', '1', 1000);
INSERT INTO `db_appdev_updated`.`branch` (`br_id`, `br_name`, `br_addr`, `com_id`) VALUES (1101, 'SM Megamall', 'Mandaluyong City', 1001);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`user_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`user_types` (`type_id`, `user_type`) VALUES (101, 'Admin');
INSERT INTO `db_appdev_updated`.`user_types` (`type_id`, `user_type`) VALUES (102, 'Branch Manager');
INSERT INTO `db_appdev_updated`.`user_types` (`type_id`, `user_type`) VALUES (103, 'Commissary Clerk');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (1, 'TempAdmin', PASSWORD('admin'), 'Admin', 'Temporary', 101, 1, 1);
INSERT INTO `db_appdev_updated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (2, 'yutainoue', PASSWORD('yutainoue'), 'Yuta', 'Inoue', 101, 1, 1);
INSERT INTO `db_appdev_updated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (3, 'andrewsantiago', PASSWORD('andrewsantiago'), 'Andrew', 'Santiago', 102, 1, 1);
INSERT INTO `db_appdev_updated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (4, 'xtianalderite', PASSWORD('xtianalderite'), 'Christian', 'Alderite', 103, 1, 1);
INSERT INTO `db_appdev_updated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (5, 'rosedelapaz', PASSWORD('rosedelapaz'), 'Rossete', 'Dela Paz', 103, 1, 1);
INSERT INTO `db_appdev_updated`.`employee` (`emp_id`, `user_name`, `password`, `first_name`, `last_name`, `user_type`, `is_active`, `is_employed`) VALUES (6, 'jinkazama', PASSWORD('jinkazama'), 'Jin', 'Kazama', 102, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`emp_br`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`emp_br` (`br_id`, `emp_id`, `from_date`, `to_date`) VALUES (1100, 3, '2017-01-01', NULL);
INSERT INTO `db_appdev_updated`.`emp_br` (`br_id`, `emp_id`, `from_date`, `to_date`) VALUES (1101, 6, '2017-01-01', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`emp_com`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`emp_com` (`com_id`, `emp_id`, `from_date`, `to_date`) VALUES (1000, 1, '2017-01-01', NULL);
INSERT INTO `db_appdev_updated`.`emp_com` (`com_id`, `emp_id`, `from_date`, `to_date`) VALUES (1001, 2, '2017-01-01', NULL);
INSERT INTO `db_appdev_updated`.`emp_com` (`com_id`, `emp_id`, `from_date`, `to_date`) VALUES (1000, 4, '2017-01-01', NULL);
INSERT INTO `db_appdev_updated`.`emp_com` (`com_id`, `emp_id`, `from_date`, `to_date`) VALUES (1001, 5, '2017-01-01', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`supplier`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`supplier` (`supplier_id`, `supplier_name`, `company_contact_info`, `active`) VALUES (1, 'ABC Corp', 'ABC@gamil.com', 1);
INSERT INTO `db_appdev_updated`.`supplier` (`supplier_id`, `supplier_name`, `company_contact_info`, `active`) VALUES (2, 'Paolo Cacapit', 'klsamdkmdsa', 1);
INSERT INTO `db_appdev_updated`.`supplier` (`supplier_id`, `supplier_name`, `company_contact_info`, `active`) VALUES (3, 'Yuta Delivery Corp', 'yuta_inoue@dlsu.edu.ph', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`sup_stk`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (1, 1);
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (2, 2);
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (3, 3);
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (3, 4);
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (1, 5);
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (2, 6);
INSERT INTO `db_appdev_updated`.`sup_stk` (`supplier_id`, `stock_id`) VALUES (1, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`supplier_contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`supplier_contact` (`contact_id`, `supplier_id`, `contact_name`, `contact_info`, `is_contactable`) VALUES (1, 1, 'Yuta Inoue', 'yutainoue@gmail.com', 1);
INSERT INTO `db_appdev_updated`.`supplier_contact` (`contact_id`, `supplier_id`, `contact_name`, `contact_info`, `is_contactable`) VALUES (2, 2, 'Xitan Alderite', 'asd@gmail.com', 1);
INSERT INTO `db_appdev_updated`.`supplier_contact` (`contact_id`, `supplier_id`, `contact_name`, `contact_info`, `is_contactable`) VALUES (3, 3, 'Yuta Inoue', '0917-825-4727', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`com_inventory`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 1, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 2, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 3, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 4, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 5, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 6, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1000, 7, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 1, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 2, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 3, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 4, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 5, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 6, 0);
INSERT INTO `db_appdev_updated`.`com_inventory` (`com_id`, `stock_id`, `current_qty`) VALUES (1001, 7, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_appdev_updated`.`br_inventory`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_appdev_updated`;
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 1, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 2, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 3, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 4, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 5, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 6, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1100, 7, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 1, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 2, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 3, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 4, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 5, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 6, 0);
INSERT INTO `db_appdev_updated`.`br_inventory` (`br_id`, `stock_id`, `current_qty`) VALUES (1101, 7, 0);

COMMIT;

USE `db_appdev_updated`;

DELIMITER $$

USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`stock_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`stock_AFTER_INSERT` AFTER INSERT ON `stock` FOR EACH ROW
BEGIN
INSERT INTO COM_INVENTORY
SELECT COM_ID, NEW.STOCK_ID, 0 FROM COMMISSARY ORDER BY 1;

INSERT INTO BR_INVENTORY
SELECT BR_ID, NEW.STOCK_ID, 0 FROM BRANCH ORDER BY 1;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`commissary_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`commissary_BEFORE_INSERT` BEFORE INSERT ON `commissary` FOR EACH ROW
BEGIN
	IF((SELECT MAX(COM_ID) FROM COMMISSARY) IS NULL) THEN
		SET NEW.COM_ID = 1000;
	ELSE
		SET NEW.COM_ID = (SELECT (MAX(COM_ID)+1) FROM COMMISSARY);
    END IF;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`commissary_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`commissary_AFTER_INSERT` AFTER INSERT ON `commissary` FOR EACH ROW
BEGIN
INSERT INTO COM_INVENTORY
SELECT NEW.COM_ID, STOCK_ID, 0 FROM STOCK ORDER BY 1;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`branch_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`branch_BEFORE_INSERT` BEFORE INSERT ON `branch` FOR EACH ROW
BEGIN
	IF((SELECT MAX(BR_ID) FROM BRANCH) IS NULL) THEN
		SET NEW.BR_ID = 1100;
	ELSE
		SET NEW.BR_ID = (SELECT (MAX(BR_ID)+1) FROM BRANCH);
    END IF;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`branch_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`branch_AFTER_INSERT` AFTER INSERT ON `branch` FOR EACH ROW
BEGIN
INSERT INTO BR_INVENTORY
SELECT NEW.BR_ID, STOCK_ID, 0 FROM STOCK ORDER BY 1;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`employee_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`employee_BEFORE_INSERT` BEFORE INSERT ON `employee` FOR EACH ROW
BEGIN
	DECLARE varUsername VARCHAR(45);
    SET varUsername = (SELECT USER_NAME FROM EMPLOYEE WHERE USER_NAME = NEW.USER_NAME);
    IF(varUsername IS NOT NULL) AND ((SELECT IS_EMPLOYED FROM EMPLOYEE WHERE USER_NAME = varUsername)) THEN
		SIGNAL SQLSTATE '49001' SET MESSAGE_TEXT = 'Username must be unique';
    END IF;
	SET NEW.PASSWORD = PASSWORD(NEW.PASSWORD);
    SET NEW.IS_ACTIVE = FALSE;
    SET NEW.IS_EMPLOYED = TRUE;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`supplier_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`supplier_BEFORE_INSERT` BEFORE INSERT ON `supplier` FOR EACH ROW
BEGIN
	SET NEW.ACTIVE = TRUE;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`supplier_contact_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`supplier_contact_BEFORE_INSERT` BEFORE INSERT ON `supplier_contact` FOR EACH ROW
BEGIN
	SET NEW.IS_CONTACTABLE = TRUE;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`requisition_order_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`requisition_order_BEFORE_INSERT` BEFORE INSERT ON `requisition_order` FOR EACH ROW
BEGIN
	SET NEW.RECORD_DATE = NOW();
	IF((SELECT DATE(MAX(RECORD_DATE)) FROM REQUISITION_ORDER WHERE BR_ID = NEW.BR_ID) = DATE(NEW.RECORD_DATE)) THEN
		SIGNAL SQLSTATE '49001' SET MESSAGE_TEXT = 'Cannot create multiple requisition order at the same day.';
    END IF;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`requisitionDetails_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`requisitionDetails_AFTER_INSERT` AFTER INSERT ON `requisitionDetails` FOR EACH ROW
BEGIN
	DECLARE brId INT;
    SET brId = (SELECT BR_ID FROM REQUISITION_ORDER WHERE REQ_ID = NEW.REQ_ID);
    
    UPDATE BR_INVENTORY SET CURRENT_QTY = NEW.QTY_REQUESTED WHERE BR_ID = brId AND STOCK_ID = NEW.STOCK_ID;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`commissary_dr_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`commissary_dr_BEFORE_INSERT` BEFORE INSERT ON `commissary_dr` FOR EACH ROW
BEGIN
SET NEW.CREATION_DATE = NOW();
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`com_drDetails_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`com_drDetails_BEFORE_INSERT` BEFORE INSERT ON `com_drDetails` FOR EACH ROW
BEGIN
DECLARE vCurrentQty DOUBLE;
SET vCurrentQty = (SELECT CURRENT_QTY FROM COM_INVENTORY WHERE STOCK_ID = NEW.STOCK_ID);
IF(NEW.DELIVER_QTY > vCurrentQty) THEN
	SIGNAL SQLSTATE '49001' SET MESSAGE_TEXT = 'Cannot Deliver Specified Quantity';
END IF;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`com_drDetails_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`com_drDetails_AFTER_INSERT` AFTER INSERT ON `com_drDetails` FOR EACH ROW
BEGIN
DECLARE vComID INT;
DECLARE vBrID INT;
SET vComID = (SELECT	COM_ID
			  FROM		COMMISSARY_DR CD
              JOIN		COM_DRDETAILS CDD ON CD.COM_DR_ID = CDD.COM_DR_ID
              WHERE		CD.COM_DR_ID = NEW.COM_DR_ID
              LIMIT		1);

SET vBrID = (SELECT		DESTINATION_BR
			 FROM		COMMISSARY_DR CD
             JOIN		COM_DRDETAILS CDD ON CD.COM_DR_ID = CDD.COM_DR_ID
             WHERE		CD.COM_DR_ID = NEW.COM_DR_ID
             LIMIT		1);

UPDATE COM_INVENTORY SET CURRENT_QTY = (CURRENT_QTY - NEW.DELIVER_QTY) WHERE COM_ID = vComID AND STOCK_ID = NEW.STOCK_ID;
UPDATE BR_INVENTORY SET CURRENT_QTY = (CURRENT_QTY + NEW.DELIVER_QTY) WHERE BR_ID = vBrID AND STOCK_ID = NEW.STOCK_ID;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`supplier_dr_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`supplier_dr_BEFORE_INSERT` BEFORE INSERT ON `supplier_dr` FOR EACH ROW
BEGIN
	SET NEW.RECEIVED_DATE = NOW();
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`sup_drDetails_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`sup_drDetails_AFTER_INSERT` AFTER INSERT ON `sup_drDetails` FOR EACH ROW
BEGIN
DECLARE vComId INT;
SET vComId = (SELECT		SD.COM_ID
				FROM		SUPPLIER_DR SD
				JOIN		SUP_DRDETAILS SDD ON SD.SUP_DR_ID = SDD.SUP_DR_ID
				WHERE		SD.SUP_DR_ID = NEW.SUP_DR_ID
				LIMIT		1);
UPDATE COM_INVENTORY SET CURRENT_QTY = (CURRENT_QTY + NEW.DELIVER_QTY) WHERE COM_ID = vComId AND STOCK_ID = NEW.STOCK_ID;
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`com_monthly_inventory_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`com_monthly_inventory_BEFORE_INSERT` BEFORE INSERT ON `com_monthly_inventory` FOR EACH ROW
BEGIN
SET NEW.YEARMONTH = NOW();
SET NEW.TIME_STAMP = NOW();
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`br_delivery_BEFORE_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`br_delivery_BEFORE_INSERT` BEFORE INSERT ON `br_delivery` FOR EACH ROW
BEGIN
SET NEW.RECEIVED_DATE = NOW();
END$$


USE `db_appdev_updated`$$
DROP TRIGGER IF EXISTS `db_appdev_updated`.`br_deliveryDetails_AFTER_INSERT` $$
USE `db_appdev_updated`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_appdev_updated`.`br_deliveryDetails_AFTER_INSERT` AFTER INSERT ON `br_deliveryDetails` FOR EACH ROW
BEGIN
DECLARE vBrID INT;
SET vBrID = (SELECT		BRANCH_ID
			 FROM		BR_DELIVERY BD
             JOIN		BR_DELIVERYDETAILS BDD ON BD.BRANCH_DR_ID = BDD.BRANCH_DR_ID
             WHERE		BD.BRANCH_DR_ID = NEW.BRANCH_DR_ID
             LIMIT		1);

UPDATE BR_INVENTORY SET CURRENT_QTY = (CURRENT_QTY + NEW.DELIVERY_QTY) WHERE BR_ID = vBrID AND STOCK_ID = NEW.STOCK_ID;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;