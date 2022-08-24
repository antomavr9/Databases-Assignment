-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spacexmissiondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spacexmissiondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spacexmissiondb` DEFAULT CHARACTER SET utf8 ;
USE `spacexmissiondb` ;

-- -----------------------------------------------------
-- Table `spacexmissiondb`.`astronaut`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`astronaut` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `birth_date` VARCHAR(45) NULL DEFAULT NULL,
  `sex` VARCHAR(45) NULL DEFAULT NULL,
  `nationality` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`payload`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`payload` (
  `serial_number` INT(11) NOT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `initial_mass` VARCHAR(45) NULL DEFAULT NULL,
  `final_mass` VARCHAR(45) NULL DEFAULT NULL,
  `mission_number` VARCHAR(45) NULL DEFAULT NULL,
  `destination_code` VARCHAR(45) NULL DEFAULT NULL,
  `payload_release_date` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`serial_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`mission` (
  `mission_number` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `budget` FLOAT NULL DEFAULT NULL,
  `client` VARCHAR(45) NULL DEFAULT NULL,
  `purpose` VARCHAR(45) NULL DEFAULT NULL,
  `spaceship_serial` VARCHAR(45) NULL DEFAULT NULL,
  `launch_sp_code` VARCHAR(45) NULL DEFAULT NULL,
  `launch_date` VARCHAR(45) NULL DEFAULT NULL,
  `return_sp_code` VARCHAR(45) NULL DEFAULT NULL,
  `return_date` VARCHAR(45) NULL DEFAULT NULL,
  `Payload_serial_number` INT(11) NOT NULL,
  PRIMARY KEY (`mission_number`, `Payload_serial_number`),
  INDEX `fk_Mission_Payload1_idx` (`Payload_serial_number` ASC),
  CONSTRAINT `fk_Mission_Payload1`
    FOREIGN KEY (`Payload_serial_number`)
    REFERENCES `spacexmissiondb`.`payload` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`astronaut_is_assigned_to_mission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`astronaut_is_assigned_to_mission` (
  `mission_number` INT(11) NOT NULL,
  `astronaut_id` INT(11) NOT NULL,
  `astronaut_role` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`mission_number`, `astronaut_id`),
  INDEX `fk_Mission_has_Astronaut_Astronaut1_idx` (`astronaut_id` ASC),
  INDEX `fk_Mission_has_Astronaut_Mission1_idx` (`mission_number` ASC),
  CONSTRAINT `fk_Mission_has_Astronaut_Mission1`
    FOREIGN KEY (`mission_number`)
    REFERENCES `spacexmissiondb`.`mission` (`mission_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mission_has_Astronaut_Astronaut1`
    FOREIGN KEY (`astronaut_id`)
    REFERENCES `spacexmissiondb`.`astronaut` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`engineer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`engineer` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `birth_date` VARCHAR(45) NULL DEFAULT NULL,
  `sex` VARCHAR(45) NULL DEFAULT NULL,
  `nationality` VARCHAR(45) NULL DEFAULT NULL,
  `specialty` VARCHAR(45) NULL DEFAULT NULL,
  `age` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`spaceship's_part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`spaceship's_part` (
  `serial_number` INT(11) NOT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `construction_date` VARCHAR(45) NULL DEFAULT NULL,
  `state_of_use` VARCHAR(45) NULL DEFAULT NULL,
  `certification` VARCHAR(45) NULL DEFAULT NULL,
  `spaceship_serial` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`serial_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`engineer_woks_on_spaceship's_part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`engineer_woks_on_spaceship's_part` (
  `work_id` VARCHAR(45) NOT NULL,
  `engineer_id` INT(11) NULL DEFAULT NULL,
  `spaceship's_Part_serial_number` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`work_id`),
  INDEX `fk_Engineer_has_Spaceship's_Part_Spaceship's_Part1_idx` (`spaceship's_Part_serial_number` ASC),
  INDEX `fk_Engineer_has_Spaceship's_Part_Engineer1_idx` (`engineer_id` ASC),
  CONSTRAINT `fk_Engineer_has_Spaceship's_Part_Engineer1`
    FOREIGN KEY (`engineer_id`)
    REFERENCES `spacexmissiondb`.`engineer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Engineer_has_Spaceship's_Part_Spaceship's_Part1`
    FOREIGN KEY (`spaceship's_Part_serial_number`)
    REFERENCES `spacexmissiondb`.`spaceship's_part` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`spaceship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`spaceship` (
  `serial_number` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `assembly_date` VARCHAR(45) NULL DEFAULT NULL,
  `state_of_use` VARCHAR(45) NULL DEFAULT NULL,
  `number_of_seats` VARCHAR(45) NULL DEFAULT NULL,
  `certification` VARCHAR(45) NULL DEFAULT NULL,
  `certification_date` VARCHAR(45) NULL DEFAULT NULL,
  `mission_number` VARCHAR(45) NULL DEFAULT NULL,
  `Spaceship's_Part_serial_number` INT(11) NOT NULL,
  `Mission_mission_number` INT(11) NOT NULL,
  PRIMARY KEY (`serial_number`, `Spaceship's_Part_serial_number`, `Mission_mission_number`),
  INDEX `fk_Spaceship_Spaceship's_Part1_idx` (`Spaceship's_Part_serial_number` ASC),
  INDEX `fk_Spaceship_Mission1_idx` (`Mission_mission_number` ASC),
  CONSTRAINT `fk_Spaceship_Spaceship's_Part1`
    FOREIGN KEY (`Spaceship's_Part_serial_number`)
    REFERENCES `spacexmissiondb`.`spaceship's_part` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Spaceship_Mission1`
    FOREIGN KEY (`Mission_mission_number`)
    REFERENCES `spacexmissiondb`.`mission` (`mission_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`engineer_works_on_spaceship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`engineer_works_on_spaceship` (
  `work_id` VARCHAR(45) NOT NULL,
  `engineer_id` INT(11) NULL DEFAULT NULL,
  `spaceship_serial_number` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`work_id`),
  INDEX `fk_Engineer_has_Spaceship_Spaceship1_idx` (`spaceship_serial_number` ASC),
  INDEX `fk_Engineer_has_Spaceship_Engineer1_idx` (`engineer_id` ASC),
  CONSTRAINT `fk_Engineer_has_Spaceship_Engineer1`
    FOREIGN KEY (`engineer_id`)
    REFERENCES `spacexmissiondb`.`engineer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Engineer_has_Spaceship_Spaceship1`
    FOREIGN KEY (`spaceship_serial_number`)
    REFERENCES `spacexmissiondb`.`spaceship` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`final destination`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`final destination` (
  `destination_code` INT(11) NOT NULL,
  `celestial_body` VARCHAR(45) NULL DEFAULT NULL,
  `orbit` VARCHAR(45) NULL DEFAULT NULL,
  `distance_from_sun` VARCHAR(45) NULL DEFAULT NULL,
  `distance_from_earth` VARCHAR(45) NULL DEFAULT NULL,
  `Payload_serial_number` INT(11) NOT NULL,
  PRIMARY KEY (`destination_code`, `Payload_serial_number`),
  INDEX `fk_Final Destination_Payload1_idx` (`Payload_serial_number` ASC),
  CONSTRAINT `fk_Final Destination_Payload1`
    FOREIGN KEY (`Payload_serial_number`)
    REFERENCES `spacexmissiondb`.`payload` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spacexmissiondb`.`spaceport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spacexmissiondb`.`spaceport` (
  `Spaceport_code` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `owner` VARCHAR(45) NULL DEFAULT NULL,
  `Spaceportcol` VARCHAR(45) NULL DEFAULT NULL,
  `Mission_mission_number` INT(11) NOT NULL,
  `Mission_Payload_serial_number` INT(11) NOT NULL,
  PRIMARY KEY (`Spaceport_code`, `Mission_mission_number`, `Mission_Payload_serial_number`),
  INDEX `fk_Spaceport_Mission1_idx` (`Mission_mission_number` ASC, `Mission_Payload_serial_number` ASC),
  CONSTRAINT `fk_Spaceport_Mission1`
    FOREIGN KEY (`Mission_mission_number` , `Mission_Payload_serial_number`)
    REFERENCES `spacexmissiondb`.`mission` (`mission_number` , `Payload_serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
