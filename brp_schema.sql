-- MySQL Script generated by MySQL Workbench
-- Thu Aug  1 16:37:29 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD_BRP
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BD_BRP` ;

-- -----------------------------------------------------
-- Schema BD_BRP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_BRP` DEFAULT CHARACTER SET utf8 ;
USE `BD_BRP` ;

-- -----------------------------------------------------
-- Table `BD_BRP`.`USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`USER` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`USER` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(13) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` CHAR(65) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`CLIENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`CLIENT` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`CLIENT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(13) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(255) NOT NULL,
  `tipo_doc` VARCHAR(10) NOT NULL,
  `doc_num` VARCHAR(15) NOT NULL,
  `company` VARCHAR(60) NULL,
  `folder_id` VARCHAR(60) NOT NULL,
  `USERS_id` INT NOT NULL,
  PRIMARY KEY (`id`, `USERS_id`),
  UNIQUE INDEX `idCLIENT_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) VISIBLE,
  INDEX `fk_CLIENT_USERS1_idx` (`USERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENT_USERS1`
    FOREIGN KEY (`USERS_id`)
    REFERENCES `BD_BRP`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`PROPERTY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`PROPERTY` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`PROPERTY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(13) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lat` VARCHAR(30) NOT NULL,
  `lng` VARCHAR(30) NOT NULL,
  `property_type` VARCHAR(30) NULL,
  `bulding_type` VARCHAR(45) NULL,
  `plate_number` VARCHAR(20) NOT NULL,
  `ctl_pin` VARCHAR(25) NULL,
  `cadastral_code` VARCHAR(40) NULL,
  `department_name` VARCHAR(50) NOT NULL,
  `city_name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `neighborhood` VARCHAR(45) NULL,
  `last_owner_name` VARCHAR(255) NULL,
  `area` FLOAT NULL,
  `coefficient` DOUBLE NULL,
  `property_open_date` DATETIME NULL,
  `age_of_property` INT NULL,
  `ctl_expedition_date` DATETIME NULL,
  `age_of_ctl` INT NULL,
  `property_folder_id` VARCHAR(60) NOT NULL,
  `water_account_number` VARCHAR(45) NULL,
  `light_account_number` VARCHAR(45) NULL,
  `gas_account_number` VARCHAR(45) NULL,
  `inactive_property` TINYINT NOT NULL,
  `CLIENT_id` INT NOT NULL,
  `CLIENT_USERS_id` INT NOT NULL,
  PRIMARY KEY (`id`, `CLIENT_id`, `CLIENT_USERS_id`),
  UNIQUE INDEX `idPROPERTY_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) VISIBLE,
  UNIQUE INDEX `plate_number_UNIQUE` (`plate_number` ASC) VISIBLE,
  INDEX `fk_PROPERTY_CLIENT1_idx` (`CLIENT_id` ASC, `CLIENT_USERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_PROPERTY_CLIENT1`
    FOREIGN KEY (`CLIENT_id` , `CLIENT_USERS_id`)
    REFERENCES `BD_BRP`.`CLIENT` (`id` , `USERS_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`RISK`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`RISK` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`RISK` (
  `idRISK` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(15) NOT NULL,
  `risk_name` VARCHAR(45) NOT NULL,
  `property_id` INT NOT NULL,
  PRIMARY KEY (`idRISK`),
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) VISIBLE,
  UNIQUE INDEX `idRISK_UNIQUE` (`idRISK` ASC) VISIBLE,
  INDEX `fk_RISK_PROPERTY1_idx` (`property_id` ASC) VISIBLE,
  CONSTRAINT `fk_RISK_PROPERTY1`
    FOREIGN KEY (`property_id`)
    REFERENCES `BD_BRP`.`PROPERTY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`RISK_LEVEL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`RISK_LEVEL` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`RISK_LEVEL` (
  `idRISK_LEVEL` INT NOT NULL AUTO_INCREMENT,
  `level_name` VARCHAR(45) NOT NULL,
  `RISK_idRISK` INT NOT NULL,
  PRIMARY KEY (`idRISK_LEVEL`),
  UNIQUE INDEX `idRISK_LEVEL_UNIQUE` (`idRISK_LEVEL` ASC) VISIBLE,
  INDEX `fk_RISK_LEVEL_RISK1_idx` (`RISK_idRISK` ASC) VISIBLE,
  CONSTRAINT `fk_RISK_LEVEL_RISK1`
    FOREIGN KEY (`RISK_idRISK`)
    REFERENCES `BD_BRP`.`RISK` (`idRISK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`TRANSACTION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`TRANSACTION` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`TRANSACTION` (
  `idRECURRING_PAYMENTS` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(15) NOT NULL,
  `transaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_name` VARCHAR(255) NULL,
  `status` VARCHAR(50) NULL,
  `reference_number` VARCHAR(100) NULL,
  `PROPERTY_id` INT NOT NULL,
  `PROPERTY_CLIENT_id` INT NOT NULL,
  `PROPERTY_CLIENT_USERS_id` INT NOT NULL,
  PRIMARY KEY (`idRECURRING_PAYMENTS`, `PROPERTY_id`, `PROPERTY_CLIENT_id`, `PROPERTY_CLIENT_USERS_id`),
  UNIQUE INDEX `idRECURRING_PAYMENTS_UNIQUE` (`idRECURRING_PAYMENTS` ASC) VISIBLE,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) VISIBLE,
  INDEX `fk_TRANSACTION_PROPERTY1_idx` (`PROPERTY_id` ASC, `PROPERTY_CLIENT_id` ASC, `PROPERTY_CLIENT_USERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSACTION_PROPERTY1`
    FOREIGN KEY (`PROPERTY_id` , `PROPERTY_CLIENT_id` , `PROPERTY_CLIENT_USERS_id`)
    REFERENCES `BD_BRP`.`PROPERTY` (`id` , `CLIENT_id` , `CLIENT_USERS_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`KEY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`KEY` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`KEY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(13) NOT NULL,
  `responsible_name` VARCHAR(255) NULL,
  `phone_number` VARCHAR(15) NULL,
  `address` VARCHAR(255) NULL,
  `lat` VARCHAR(30) NULL,
  `lng` VARCHAR(30) NULL,
  `PROPERTY_id` INT NOT NULL,
  `PROPERTY_CLIENT_id` INT NOT NULL,
  `PROPERTY_CLIENT_USERS_id` INT NOT NULL,
  PRIMARY KEY (`id`, `PROPERTY_id`, `PROPERTY_CLIENT_id`, `PROPERTY_CLIENT_USERS_id`),
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) VISIBLE,
  INDEX `fk_KEY_PROPERTY1_idx` (`PROPERTY_id` ASC, `PROPERTY_CLIENT_id` ASC, `PROPERTY_CLIENT_USERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_KEY_PROPERTY1`
    FOREIGN KEY (`PROPERTY_id` , `PROPERTY_CLIENT_id` , `PROPERTY_CLIENT_USERS_id`)
    REFERENCES `BD_BRP`.`PROPERTY` (`id` , `CLIENT_id` , `CLIENT_USERS_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`SERVICE_STATE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`SERVICE_STATE` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`SERVICE_STATE` (
  `idSERVICE_STATE` INT NOT NULL AUTO_INCREMENT,
  `origin` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `PROPERTY_idPROPERTY` INT NOT NULL,
  `PROPERTY_CLIENT_idCLIENT` INT NOT NULL,
  PRIMARY KEY (`idSERVICE_STATE`),
  INDEX `fk_SERVICE_STATE_PROPERTY1_idx` (`PROPERTY_idPROPERTY` ASC, `PROPERTY_CLIENT_idCLIENT` ASC) VISIBLE,
  CONSTRAINT `fk_SERVICE_STATE_PROPERTY1`
    FOREIGN KEY (`PROPERTY_idPROPERTY`)
    REFERENCES `BD_BRP`.`PROPERTY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_BRP`.`FILE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_BRP`.`FILE` ;

CREATE TABLE IF NOT EXISTS `BD_BRP`.`FILE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `origin` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `file_url` VARCHAR(1000) NOT NULL,
  `file_name` VARCHAR(255) NOT NULL,
  `PROPERTY_id` INT NOT NULL,
  `PROPERTY_CLIENT_id` INT NOT NULL,
  `PROPERTY_CLIENT_USERS_id` INT NOT NULL,
  PRIMARY KEY (`id`, `PROPERTY_id`, `PROPERTY_CLIENT_id`, `PROPERTY_CLIENT_USERS_id`),
  INDEX `fk_FILE_PROPERTY1_idx` (`PROPERTY_id` ASC, `PROPERTY_CLIENT_id` ASC, `PROPERTY_CLIENT_USERS_id` ASC) VISIBLE,
  CONSTRAINT `fk_FILE_PROPERTY1`
    FOREIGN KEY (`PROPERTY_id` , `PROPERTY_CLIENT_id` , `PROPERTY_CLIENT_USERS_id`)
    REFERENCES `BD_BRP`.`PROPERTY` (`id` , `CLIENT_id` , `CLIENT_USERS_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

