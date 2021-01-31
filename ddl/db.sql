-- Create schema
CREATE SCHEMA saga;

-- Create database user mapped to IAM role
CREATE USER 'pod_user'@'%' IDENTIFIED WITH AWSAuthenticationPlugin as 'RDS';
GRANT SELECT, INSERT, UPDATE, DELETE ON saga.* TO 'pod_user'@'%' ;

-- Orders table
CREATE TABLE `saga`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT ,
  `order_sku_id` INT NOT NULL,
  `order_qty` INT NOT NULL,
  `order_price` DECIMAL(10,2) NOT NULL,
  `order_timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE);

-- Inventory table
CREATE TABLE `saga`.`inventory` (
  `sku_id` INT NOT NULL AUTO_INCREMENT ,
  `sku_qty` INT NOT NULL,
  `inventory_timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`sku_id`),
  UNIQUE INDEX `sku_id_UNIQUE` (`sku_id` ASC) VISIBLE);

-- Payments table
CREATE TABLE `saga`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT ,
  `payment_amount` DECIMAL(10,2) NOT NULL,
  `payment_status` VARCHAR(45) NOT NULL,
  `payment_timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) VISIBLE);

-- Shipping table
CREATE TABLE `saga`.`shipping` (
  `shipping_id` INT NOT NULL AUTO_INCREMENT,
  `shipping_date` DATETIME NOT NULL,
  PRIMARY KEY (`shipping_id`),
  UNIQUE INDEX `shipping_id_UNIQUE` (`shipping_id` ASC) VISIBLE); 

-- Audit history
CREATE TABLE `saga`.`order_trail` (
 `trail_id` INT NOT NULL AUTO_INCREMENT,
 `order_id` INT NOT NULL,
 `saga_us` VARCHAR(45) NULL,
 `saga_us_status` VARCHAR(45) NULL,
 `saga_us_msg` VARCHAR(256) NULL,
 `trail_timestamp` DATETIME NULL,
 PRIMARY KEY (`trail_id`),
 UNIQUE INDEX `trail_id_UNIQUE` (`trail_id` ASC) VISIBLE); 

-- INSERT inventory rows

INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (1,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (2,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (3,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (4,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (5,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (6,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (7,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (8,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES  (9,100,CURRENT_TIMESTAMP);
INSERT INTO `saga`.`inventory` (`sku_id`, `sku_qty`, `inventory_timestamp`) VALUES (10,100,CURRENT_TIMESTAMP);
