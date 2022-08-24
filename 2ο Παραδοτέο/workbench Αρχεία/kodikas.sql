-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SpaceXMissionDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SpaceXMissionDB` ;

-- -----------------------------------------------------
-- Schema SpaceXMissionDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SpaceXMissionDB` DEFAULT CHARACTER SET utf8 ;
USE `SpaceXMissionDB` ;

-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`engineer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`engineer` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`engineer` (
  `id` INT NOT NULL,
  `name` VARCHAR(70) NOT NULL,
  `birth_date` DATE NOT NULL,
  `sex` ENUM('male', 'female', 'other') NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  `specialty` ENUM('Aeronautical', 'Chemical', 'Civil and Structural', 'Electrical and Electronic', 'General', 'Manufacturing and Production', 'Mechanical', 'Mineral and Mining', 'Petroleum') NOT NULL,
  `age` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`spaceship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`spaceship` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`spaceship` (
  `serial_number` VARCHAR(30) NOT NULL,
  `name` VARCHAR(70) NOT NULL,
  `type` ENUM('Falcon', 'Falcon Heavy', 'Starship') NOT NULL,
  `assembly_date` DATE NOT NULL,
  `state_of_use` TINYINT(1) NOT NULL,
  `number_of_seats` INT NOT NULL,
  `certification` TINYINT(1) NOT NULL,
  `certification_date` DATE NULL,
  `engineer_id` INT NULL,
  PRIMARY KEY (`serial_number`),
  INDEX `fk_spaceship_engineer1_idx` (`engineer_id` ASC),
  CONSTRAINT `fk_spaceship_engineer1`
    FOREIGN KEY (`engineer_id`)
    REFERENCES `SpaceXMissionDB`.`engineer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`spaceship_part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`spaceship_part` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`spaceship_part` (
  `serial_number` VARCHAR(30) NOT NULL,
  `type` VARCHAR(30) NOT NULL,
  `construction_date` DATE NOT NULL,
  `state_of_use` TINYINT(1) NOT NULL,
  `certification` TINYINT(1) NOT NULL,
  `certification_date` DATE NULL,
  `spaceship_serial` VARCHAR(30) NULL,
  PRIMARY KEY (`serial_number`, `spaceship_serial`),
  INDEX `fk_spaceship_part_spaceship1_idx` (`spaceship_serial` ASC),
  CONSTRAINT `fk_spaceship_part_spaceship1`
    FOREIGN KEY (`spaceship_serial`)
    REFERENCES `SpaceXMissionDB`.`spaceship` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`engineer_works_on_spaceship_part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`engineer_works_on_spaceship_part` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (
  `work_id` INT NOT NULL,
  `engineer_id` INT NULL,
  `part_serial` VARCHAR(30) NULL,
  PRIMARY KEY (`work_id`),
  INDEX `fk_Engineer_Works_On_Spaceship_Part_Engineer_idx` (`engineer_id` ASC),
  INDEX `fk_Engineer_Works_On_Spaceship_Part_Spaceship_Part1_idx` (`part_serial` ASC),
  CONSTRAINT `fk_Engineer_Works_On_Spaceship_Part_Engineer`
    FOREIGN KEY (`engineer_id`)
    REFERENCES `SpaceXMissionDB`.`engineer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Engineer_Works_On_Spaceship_Part_Spaceship_Part1`
    FOREIGN KEY (`part_serial`)
    REFERENCES `SpaceXMissionDB`.`spaceship_part` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`astronaut`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`astronaut` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`astronaut` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(70) NOT NULL,
  `birth_date` DATE NOT NULL,
  `sex` ENUM('male', 'female', 'other') NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  `age` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`spaceport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`spaceport` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`spaceport` (
  `spaceport_code` CHAR(7) NOT NULL,
  `name` VARCHAR(70) NOT NULL,
  `location` VARCHAR(70) NOT NULL,
  `type` ENUM('Static', 'Floating') NOT NULL,
  `owner` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`spaceport_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`mission` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`mission` (
  `mission_number` INT(11) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `budget` FLOAT NOT NULL,
  `client` VARCHAR(30) NOT NULL,
  `purpose` VARCHAR(200) NOT NULL,
  `spaceship_serial` VARCHAR(30) NULL,
  `launch_sp_code` CHAR(7) NULL,
  `launch_date` DATE NOT NULL,
  `return_sp_code` CHAR(7) NULL,
  `return_date` DATE NOT NULL,
  PRIMARY KEY (`mission_number`),
  INDEX `fk_mission_spaceship1_idx` (`spaceship_serial` ASC),
  INDEX `fk_mission_spaceport1_idx` (`launch_sp_code` ASC),
  INDEX `fk_mission_spaceport2_idx` (`return_sp_code` ASC),
  CONSTRAINT `fk_mission_spaceship1`
    FOREIGN KEY (`spaceship_serial`)
    REFERENCES `SpaceXMissionDB`.`spaceship` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mission_spaceport1`
    FOREIGN KEY (`launch_sp_code`)
    REFERENCES `SpaceXMissionDB`.`spaceport` (`spaceport_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mission_spaceport2`
    FOREIGN KEY (`return_sp_code`)
    REFERENCES `SpaceXMissionDB`.`spaceport` (`spaceport_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`astronaut_is_assigned_to_mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (
  `astronaut_id` INT(11) NOT NULL,
  `mission_number` INT(11) NOT NULL,
  `astronaut_role` ENUM('Spacecraft Commander', 'Payload Commander', 'Pilot', 'Mission Specialist', 'Payload Specialist', 'Spaceflight Participant') NOT NULL,
  INDEX `fk_Mission_has_Astronaut_Astronaut1_idx` (`astronaut_id` ASC),
  INDEX `fk_Mission_has_Astronaut_Mission1_idx` (`mission_number` ASC),
  PRIMARY KEY (`astronaut_id`, `mission_number`),
  CONSTRAINT `fk_Mission_has_Astronaut_Mission1`
    FOREIGN KEY (`mission_number`)
    REFERENCES `SpaceXMissionDB`.`mission` (`mission_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mission_has_Astronaut_Astronaut1`
    FOREIGN KEY (`astronaut_id`)
    REFERENCES `SpaceXMissionDB`.`astronaut` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`final_destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`final_destination` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`final_destination` (
  `destination_code` CHAR(7) NOT NULL,
  `celestial_body` VARCHAR(30) NOT NULL,
  `orbit` VARCHAR(30) NOT NULL,
  `distance_from_sun` FLOAT NOT NULL,
  `distance_from_earth` FLOAT NOT NULL,
  PRIMARY KEY (`destination_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SpaceXMissionDB`.`payload`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SpaceXMissionDB`.`payload` ;

CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`payload` (
  `serial_number` VARCHAR(30) NOT NULL,
  `type` ENUM('Satellite', 'Space Probe', 'Spacecraft', 'Cargo') NOT NULL,
  `initial_mass` FLOAT NOT NULL,
  `final_mass` FLOAT NOT NULL,
  `mission_number` INT(11) NULL,
  `destination_code` CHAR(7) NULL,
  `payload_release_date` DATE NOT NULL,
  PRIMARY KEY (`serial_number`),
  INDEX `fk_payload_mission1_idx` (`mission_number` ASC),
  INDEX `fk_payload_final destination1_idx` (`destination_code` ASC),
  CONSTRAINT `fk_payload_mission1`
    FOREIGN KEY (`mission_number`)
    REFERENCES `SpaceXMissionDB`.`mission` (`mission_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payload_final destination1`
    FOREIGN KEY (`destination_code`)
    REFERENCES `SpaceXMissionDB`.`final_destination` (`destination_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `SpaceXMissionDB` ;

-- -----------------------------------------------------
-- Placeholder table for view `SpaceXMissionDB`.`used_spaceships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`used_spaceships` (`name` INT, `serial_number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `SpaceXMissionDB`.`parts_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`parts_number` (`name` INT, `serial_number` INT, `parts_number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `SpaceXMissionDB`.`temp_checked_spaceships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`temp_checked_spaceships` (`spaceship_serial` INT, `passed_checking` INT);

-- -----------------------------------------------------
-- Placeholder table for view `SpaceXMissionDB`.`checked_spaceships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SpaceXMissionDB`.`checked_spaceships` (`spaceship_serial` INT);

-- -----------------------------------------------------
-- View `SpaceXMissionDB`.`used_spaceships`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `SpaceXMissionDB`.`used_spaceships` ;
DROP TABLE IF EXISTS `SpaceXMissionDB`.`used_spaceships`;
USE `SpaceXMissionDB`;
#view that contains all the serial number and the name of the spaceships
#that have been already used at least once
CREATE  OR REPLACE VIEW `used_spaceships` AS
SELECT name, serial_number
FROM spaceship
WHERE state_of_use = TRUE;

-- -----------------------------------------------------
-- View `SpaceXMissionDB`.`parts_number`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `SpaceXMissionDB`.`parts_number` ;
DROP TABLE IF EXISTS `SpaceXMissionDB`.`parts_number`;
USE `SpaceXMissionDB`;
#view that contains the compartments every spaceship has, along with the name and the serial number of the spaceship
CREATE  OR REPLACE VIEW `parts_number` AS
SELECT name, spaceship.serial_number, COUNT(spaceship.serial_number) AS parts_number
FROM spaceship JOIN spaceship_part ON spaceship.serial_number = spaceship_part.spaceship_serial
GROUP BY spaceship.serial_number, name;

-- -----------------------------------------------------
-- View `SpaceXMissionDB`.`temp_checked_spaceships`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `SpaceXMissionDB`.`temp_checked_spaceships` ;
DROP TABLE IF EXISTS `SpaceXMissionDB`.`temp_checked_spaceships`;
USE `SpaceXMissionDB`;
#assisting view that contains the spaceship serials and if they are certified
CREATE  OR REPLACE VIEW `temp_checked_spaceships` AS
SELECT spaceship_serial, MIN(certification) AS passed_checking
FROM spaceship_part
GROUP BY spaceship_serial;

-- -----------------------------------------------------
-- View `SpaceXMissionDB`.`checked_spaceships`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `SpaceXMissionDB`.`checked_spaceships` ;
DROP TABLE IF EXISTS `SpaceXMissionDB`.`checked_spaceships`;
USE `SpaceXMissionDB`;
#view that contains all the serial number of the spaceships
#that have fully passed checking
#(meaning that all their parts have a certificate)
CREATE  OR REPLACE VIEW `checked_spaceships` AS
SELECT spaceship_serial
FROM temp_checked_spaceships 
WHERE passed_checking = TRUE;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`engineer`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (13145, 'Jeff Laurens', '1973/4/23', 'Male', 'USA', 'Mechanical', 47);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (87653, 'Marry Johnson', '1980/7/5', 'Female', 'UK', 'Chemical', 40);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (53467, 'Pete Morton', '1980/11/6', 'Male', 'UK', 'Mechanical', 40);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (47356, 'Helen Patrick', '1971/12/13', 'Female', 'USA', 'Chemical', 49);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (84572, 'Anne Murrins', '1973/9/2', 'Female', 'Scotland', 'Electrical and Electronic', 47);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (82490, 'John Johson', '1972/4/22', 'Male', 'Australia', 'Mechanical', 48);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (67123, 'Jason Cole', '1975/9/30', 'Male', 'UK', 'Electrical and Electronic', 45);
INSERT INTO `SpaceXMissionDB`.`engineer` (`id`, `name`, `birth_date`, `sex`, `country`, `specialty`, `age`) VALUES (34563, 'Giorgos Fotiou', '1971/9/1', 'Male', 'Greece', 'Electrical and Electronic', 49);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`spaceship`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('534678A', 'Mars11', 'Falcon', '2020/1/11', True, 7, False, NULL, 13145);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('645783K', 'JJ12', 'Falcon Heavy', '2019/10/22', False, 7, True, '2020/4/28', 87653);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('467823Y', 'Moon00', 'Starship', '2020/10/10', True, 100, True, '2020/12/12', 53467);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('924678L', 'Helios11', 'Starship', '2018/10/21', True, 100, False, NULL, 47356);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('682345O', 'FYG1', 'Falcon', '2019/1/30', False, 7, True, '2019/10/11', 84572);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('191816A', 'Mary', 'Falcon', '2017/10/10', True, 7, True, '2020/8/20', 82490);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('346872G', 'Helios12', 'Falcon', '2018/2/1', True, 7, True, '2019/3/20', 67123);
INSERT INTO `SpaceXMissionDB`.`spaceship` (`serial_number`, `name`, `type`, `assembly_date`, `state_of_use`, `number_of_seats`, `certification`, `certification_date`, `engineer_id`) VALUES ('453627F', 'Jupiter', 'Falcon Heavy', '2018/5/9', False, 7, True, '2019/7/19', 34563);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`spaceship_part`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('173648Α', 'Exhaust Muffler', '2020/4/3', False, True, '2020/5/8', '534678A');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('462378K', 'Oil Cooler', '2019/10/12', False, True, '2020/9/4', '645783K');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('354689A', 'Fuel Pump', '2019/4/10', False, True, '2020/1/6', '467823Y');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('534789K', 'Radiator', '2020/2/24', True, True, '2020/10/18', '924678L');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('923422D', 'Intake', '2019/8/19', True, True, '2019/12/4', '682345O');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('534789G', 'Hydraulic Pump', '2019/10/18', False, True, '2020/8/8', '191816A');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('564754U', 'Water Separator', '2020/11/20', False, False, NULL, '346872G');
INSERT INTO `SpaceXMissionDB`.`spaceship_part` (`serial_number`, `type`, `construction_date`, `state_of_use`, `certification`, `certification_date`, `spaceship_serial`) VALUES ('584653O', 'Fuel Cell', '2019/8/9', True, True, '2019/8/15', '453627F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`engineer_works_on_spaceship_part`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (2134, 13145, '173648Α');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (3241, 87653, '462378K');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (3455, 53467, '354689A');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (6758, 47356, '534789K');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (5234, 84572, '923422D');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (8942, 82490, '534789G');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (2347, 67123, '564754U');
INSERT INTO `SpaceXMissionDB`.`engineer_works_on_spaceship_part` (`work_id`, `engineer_id`, `part_serial`) VALUES (2342, 34563, '584653O');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`astronaut`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (34456, 'Johan Karens', '1982/10/12', 'Male', 'UK', 38);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (23467, 'John John', '1970/11/10', 'Male', 'USA', 50);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (17361, 'Marry Popins', '1975/3/12', 'Female', 'UK', 45);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (12389, 'Kostas Dimitriou', '1979/10/13', 'Male', 'Cyprus', 41);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (78345, 'George Floyd', '1976/12/20', 'Male', 'Austria', 43);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (53467, 'Helen Patrick', '1979/7/17', 'Female', 'Sweden', 41);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (98387, 'Matt Willys', '1973/12/19', 'Male', 'USA', 47);
INSERT INTO `SpaceXMissionDB`.`astronaut` (`id`, `name`, `birth_date`, `sex`, `country`, `age`) VALUES (65143, 'Helen Patrick', '1976/11/17', 'Female', 'Australia', 44);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`spaceport`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('C39A', 'John F. Kennedy Space Center ', 'Florida, USA', 'Static', 'NASA');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('SPX1', 'Floating Platform 1', 'Atlantic Ocean', 'Floating', 'SpaceX');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('G12G', 'Aero 1', 'Medditeranean', 'Static', 'SpaceX');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('RR12R', 'Cosmos 100', 'Coloraro, USA', 'Floating', 'NASA');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('HG564', 'Launchpad C', 'Poland', 'Static', 'ESA');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('KK567', 'Launchpad B', 'Greece', 'Static', 'ESA');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('PL123', 'GG100', 'Greenland', 'Floating', 'NASA');
INSERT INTO `SpaceXMissionDB`.`spaceport` (`spaceport_code`, `name`, `location`, `type`, `owner`) VALUES ('FG23', 'Launchpad A', 'French Guinea', 'Static', 'ESA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`mission`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (12545, 'Helios2', 100000000, 'Nasa', 'Exploration', '645783K', 'C39A', '2021/2/12', 'SPX1', '2021/9/2');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (67487, 'Mars9', 150000000, 'ESA', 'Education', '924678L', 'FG23', '2022/5/3', 'FG23', '2022/9/23');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (63457, 'JJ11', 100000000, 'Nasa', 'Exploration', '645783K', 'C39A', '2020/12/25', 'SPX1', '2021/1/7');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (42367, 'Moon3', 90000000, 'SpaceX', 'Education', '924678L', 'KK567', '2025/12/5', 'SPX1', '2026/5/1');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (98034, 'AAB12', 88000000, 'Nasa', 'Exploration', '346872G', 'C39A', '2021/3/21', 'SPX1', '2021/2/25');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (78249, 'JK90', 120000000, 'Rota', 'Education', '191816A', 'PL123', '2023/5/9', 'PL123', '2023/6/24');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (42678, 'PLA', 100000000, 'WWO', 'Intelligence', '924678L', 'HG564', '2022/8/9', 'HG564', '2023/9/7');
INSERT INTO `SpaceXMissionDB`.`mission` (`mission_number`, `name`, `budget`, `client`, `purpose`, `spaceship_serial`, `launch_sp_code`, `launch_date`, `return_sp_code`, `return_date`) VALUES (85709, 'Orbit5', 125000000, 'USAirforce', 'Intelligence', '346872G', 'RR12R', '2021/6/16', 'RR12R', '2021/8/30');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`astronaut_is_assigned_to_mission`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (34456, 12545, 'Spacecraft Commander');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (23467, 67487, 'Mission Specialist');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (17361, 63457, 'Pilot');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (12389, 42367, 'Spaceflight Participant');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (78345, 98034, 'Pilot');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (53467, 78249, 'Payload Specialist');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (98387, 42678, 'Mission Specialist');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (65143, 85709, 'Payload Commander');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (12389, 12545, 'Spaceflight Participant');
INSERT INTO `SpaceXMissionDB`.`astronaut_is_assigned_to_mission` (`astronaut_id`, `mission_number`, `astronaut_role`) VALUES (12389, 98034, 'Spaceflight Participant');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`final_destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('ERT21P', 'Earth', 'Geostationary Orbit', 149000000, 35000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('GHD98K', 'Mars', 'Low Mars Orbit', 227000000, 56000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('FGW25F', 'Jupiter', 'Elliptical Orbit', 200000000, 20000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('FEW45K', 'Earth', 'Geostationary Orbit', 173000000, 109000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('FEG45L', 'Mars', 'Elliptical Orbit', 209000000, 197000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('GHJ78I', 'Mars', 'Geostationary Orbit', 197000000, 108000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('HDE56K', 'Jupiter', 'Elliptical Orbit', 435000000, 398000000);
INSERT INTO `SpaceXMissionDB`.`final_destination` (`destination_code`, `celestial_body`, `orbit`, `distance_from_sun`, `distance_from_earth`) VALUES ('JAS124', 'Thebe', 'Elliptical Orbit', 778000000, 750000000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SpaceXMissionDB`.`payload`
-- -----------------------------------------------------
START TRANSACTION;
USE `SpaceXMissionDB`;
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('ERT21P', 'Space Probe', 41000, 40000 , 12545, 'ERT21P', '2019/11/20');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('GHD98K', 'Satellite', 39000 , 30000, 67487, 'GHD98K', '2020/10/12');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('FGW25F', 'Spacecraft', 46000 , 40000 , 63457, 'FGW25F', '2019/3/7');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('FEW45K', 'Satellite', 42000 , 38800 , 42367, 'FEW45K', '2020/3/5');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('FEG45L', 'Space Probe', 40000 , 36000 , 98034, 'FEG45L', '2020/1/7');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('GHJ78I', 'Satellite', 46000 , 36000 , 78249, 'GHJ78I', '2019/11/17');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('HDE56K', 'Space Probe', 40000 , 38800 , 42678, 'HDE56K', '2020/3/18');
INSERT INTO `SpaceXMissionDB`.`payload` (`serial_number`, `type`, `initial_mass`, `final_mass`, `mission_number`, `destination_code`, `payload_release_date`) VALUES ('JAS124', 'Spacecraft', 100000 , 90000 , 85709, 'JAS124', '2019/6/22');

COMMIT;

