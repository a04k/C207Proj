-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Club_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Club_DB` ;

-- -----------------------------------------------------
-- Schema Club_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Club_DB` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema club_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `club_db` ;

-- -----------------------------------------------------
-- Schema club_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `club_db` DEFAULT CHARACTER SET utf8 ;
USE `Club_DB` ;

-- -----------------------------------------------------
-- Table `Club_DB`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`person` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`person` (
  `SSN` INT NOT NULL,
  `FName` VARCHAR(12) NOT NULL,
  `LName` VARCHAR(12) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `BDATE` DATE NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Gender` CHAR(1) NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Member` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Member` (
  `MembershipStartDate` DATE NOT NULL,
  `Member_SSN` INT NOT NULL,
  PRIMARY KEY (`Member_SSN`),
  CONSTRAINT `fk_Member_Perosn`
    FOREIGN KEY (`Member_SSN`)
    REFERENCES `Club_DB`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Pro_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Pro_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Pro_Player` (
  `Player_SSN` INT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Pro_Player_Member1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Member` (`Member_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Employee` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Employee` (
  `Salary` FLOAT NULL,
  `Employee_SSN` INT NOT NULL,
  PRIMARY KEY (`Employee_SSN`),
  CONSTRAINT `fk_Employee_Perosn1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `Club_DB`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Coach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Coach` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Coach` (
  `Coach_SSN` INT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Coach_SSN`),
  CONSTRAINT `fk_Coach_person1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Event` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Event` (
  `Name` VARCHAR(45) NOT NULL,
  `Date` DATE NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Sponsor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Sponsor` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Sponsor` (
  `Name` VARCHAR(15) NOT NULL,
  `Website` VARCHAR(20) NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Sponsor_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `Club_DB`.`Event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Management`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Management` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Management` (
  `Name` VARCHAR(10) NOT NULL,
  `Manager_SSN` INT NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Management_Employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Catering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Catering` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Catering` (
  `Name` VARCHAR(25) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `NumOfBranches` INT NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Catering_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Catering_Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Catering_Location` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Catering_Location` (
  `Location` VARCHAR(15) NOT NULL,
  `Supervisor_ssn` INT NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Location`, `Catering_Name`),
  CONSTRAINT `ay_haga`
    FOREIGN KEY (`Supervisor_ssn`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catering_Location_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Place` (
  `Location` VARCHAR(15) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Hall` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Hall` (
  `NumberOfSeats` INT NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Hall_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Field` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Field` (
  `Area` FLOAT NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Field_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`CateringStaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`CateringStaff` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`CateringStaff` (
  `Worker_SSN` INT NOT NULL,
  `Catering_Location` VARCHAR(15) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CateringStaff_Catering_Location1`
    FOREIGN KEY (`Catering_Location` , `Catering_Name`)
    REFERENCES `Club_DB`.`Catering_Location` (`Location` , `Catering_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Management_Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Management_Employee` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Management_Employee` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `Employee_SSN` INT NOT NULL,
  PRIMARY KEY (`Management_Name`, `Employee_SSN`),
  CONSTRAINT `fk_table2_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Management_Employee_Employee1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Event_Managment_Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Event_Managment_Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Event_Managment_Place` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Management_Name`, `PlaceName`, `Event_Name`),
  CONSTRAINT `fk_table3_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `Club_DB`.`Event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`TeamSport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`TeamSport` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`TeamSport` (
  `Player_SSN` INT NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`, `TeamName`),
  CONSTRAINT `fk_TeamSport_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`individualSport_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`individualSport_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`individualSport_Player` (
  `Player_SSN` INT NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`Player_SSN`, `Coach_SSN`),
  CONSTRAINT `fk_individualSport_Player_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_individualSport_Player_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Menu` (
  `optionNumber` INT NOT NULL,
  `option` VARCHAR(20) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`optionNumber`),
  CONSTRAINT `fk_Menu_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Menu-OpSize`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Menu-OpSize` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Menu-OpSize` (
  `Menu_optionNumber` INT NOT NULL,
  `Size` VARCHAR(1) NOT NULL,
  `Price` FLOAT NULL,
  CONSTRAINT `fk_Menu-OpSize_Menu1`
    FOREIGN KEY (`Menu_optionNumber`)
    REFERENCES `Club_DB`.`Menu` (`optionNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Pro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Pro` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Pro` (
  `Player_SSN` INT NULL,
  `Coach_SSN` INT NULL,
  `Salary` FLOAT NOT NULL,
  `ContractStart` DATE NOT NULL,
  `ContractEnd` DATE NOT NULL,
  PRIMARY KEY (`Player_SSN`, `Coach_SSN`),
  CONSTRAINT `fk_Pro_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pro_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Team` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Team` (
  `TeamName` VARCHAR(15) NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`TeamName`, `Coach_SSN`),
  CONSTRAINT `fk_Team_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `club_db` ;

-- -----------------------------------------------------
-- Table `club_db`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`person` ;

CREATE TABLE IF NOT EXISTS `club_db`.`person` (
  `SSN` INT(11) NOT NULL,
  `FName` VARCHAR(12) NOT NULL,
  `LName` VARCHAR(12) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `BDATE` DATE NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Gender` CHAR(1) NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`employee` ;

CREATE TABLE IF NOT EXISTS `club_db`.`employee` (
  `Salary` FLOAT NULL DEFAULT NULL,
  `Employee_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Employee_SSN`),
  CONSTRAINT `fk_Employee_Perosn1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `club_db`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`management`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`management` ;

CREATE TABLE IF NOT EXISTS `club_db`.`management` (
  `Name` VARCHAR(10) NOT NULL,
  `NumberOfEmployees` INT(11) NOT NULL,
  `Manager_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Management_Employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`catering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`catering` ;

CREATE TABLE IF NOT EXISTS `club_db`.`catering` (
  `Name` VARCHAR(25) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `NumOfBranches` INT(11) NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Catering_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `club_db`.`management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`catering_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`catering_location` ;

CREATE TABLE IF NOT EXISTS `club_db`.`catering_location` (
  `Location` VARCHAR(15) NOT NULL,
  `Supervisor_ssn` INT(11) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Location`, `Catering_Name`),
  CONSTRAINT `ay_haga`
    FOREIGN KEY (`Supervisor_ssn`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catering_Location_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `club_db`.`catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`cateringstaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`cateringstaff` ;

CREATE TABLE IF NOT EXISTS `club_db`.`cateringstaff` (
  `Worker_SSN` INT(11) NOT NULL,
  `Catering_Location` VARCHAR(15) NOT NULL,
  `Catering_Location_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_CateringStaff_Catering_Location1`
    FOREIGN KEY (`Catering_Location` , `Catering_Location_Name`)
    REFERENCES `club_db`.`catering_location` (`Location` , `Catering_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`coach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`coach` ;

CREATE TABLE IF NOT EXISTS `club_db`.`coach` (
  `StartDateCoaching` DATE NOT NULL,
  `Coach_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Coach_SSN`),
  CONSTRAINT `fk_Coach_Employee1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`event` ;

CREATE TABLE IF NOT EXISTS `club_db`.`event` (
  `Name` VARCHAR(45) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`place` ;

CREATE TABLE IF NOT EXISTS `club_db`.`place` (
  `Location` VARCHAR(15) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`event_managment_place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`event_managment_place` ;

CREATE TABLE IF NOT EXISTS `club_db`.`event_managment_place` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Management_Name`, `PlaceName`, `Event_Name`),
  CONSTRAINT `fk_table3_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `club_db`.`event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `club_db`.`management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `club_db`.`place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`field` ;

CREATE TABLE IF NOT EXISTS `club_db`.`field` (
  `Area` FLOAT NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Field_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `club_db`.`place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`hall` ;

CREATE TABLE IF NOT EXISTS `club_db`.`hall` (
  `NumberOfSeats` INT(11) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Hall_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `club_db`.`place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`member` ;

CREATE TABLE IF NOT EXISTS `club_db`.`member` (
  `MembershipStartDate` DATE NOT NULL,
  `Member_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Member_SSN`),
  CONSTRAINT `fk_Member_Perosn`
    FOREIGN KEY (`Member_SSN`)
    REFERENCES `club_db`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`pro_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`pro_player` ;

CREATE TABLE IF NOT EXISTS `club_db`.`pro_player` (
  `Salary` FLOAT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `Player_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Player_Member1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `club_db`.`member` (`Member_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`individualsport_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`individualsport_player` ;

CREATE TABLE IF NOT EXISTS `club_db`.`individualsport_player` (
  `Player_SSN` INT(11) NOT NULL,
  `Coach_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_individual sport - player_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `club_db`.`coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_individual sport - player_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `club_db`.`pro_player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`management_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`management_employee` ;

CREATE TABLE IF NOT EXISTS `club_db`.`management_employee` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `Employee_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Management_Name`, `Employee_SSN`),
  CONSTRAINT `fk_Management_Employee_Employee1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table2_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `club_db`.`management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`menu` ;

CREATE TABLE IF NOT EXISTS `club_db`.`menu` (
  `optionNumber` INT(11) NOT NULL,
  `option` VARCHAR(20) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`optionNumber`),
  CONSTRAINT `fk_Menu_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `club_db`.`catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`menu-opsize`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`menu-opsize` ;

CREATE TABLE IF NOT EXISTS `club_db`.`menu-opsize` (
  `Menu_optionNumber` INT(11) NOT NULL,
  `Size` VARCHAR(1) NOT NULL,
  `Price` FLOAT NULL DEFAULT NULL,
  CONSTRAINT `fk_Menu-OpSize_Menu1`
    FOREIGN KEY (`Menu_optionNumber`)
    REFERENCES `club_db`.`menu` (`optionNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`sponsor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`sponsor` ;

CREATE TABLE IF NOT EXISTS `club_db`.`sponsor` (
  `Name` VARCHAR(15) NOT NULL,
  `Website` VARCHAR(20) NULL DEFAULT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Sponsor_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `club_db`.`event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`team` ;

CREATE TABLE IF NOT EXISTS `club_db`.`team` (
  `TeamName` VARCHAR(15) NOT NULL,
  `Coach_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`TeamName`),
  CONSTRAINT `fk_Team_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `club_db`.`coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`teamsport_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`teamsport_player` ;

CREATE TABLE IF NOT EXISTS `club_db`.`teamsport_player` (
  `Player_SSN` INT(11) NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Team sport - player_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `club_db`.`pro_player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TeamSport_player_Team1`
    FOREIGN KEY (`TeamName`)
    REFERENCES `club_db`.`team` (`TeamName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
