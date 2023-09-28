SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DEFINER=`mc`@`%` PROCEDURE `delete_variable` (IN `key1` VARCHAR(200))   DELETE FROM syncvariables WHERE `syncvariables`.`var_name` = key1$$

CREATE DEFINER=`mc`@`%` PROCEDURE `delete_variable_list` (IN `key1` VARCHAR(200))   DELETE FROM syncvariables WHERE `syncvariables`.`var_name` LIKE CONCAT(key1,'::%')$$

CREATE DEFINER=`mc`@`%` PROCEDURE `load_variable` (IN `varname` VARCHAR(200))   SELECT value,type type FROM `syncvariables` WHERE `var_name` LIKE varname$$

CREATE DEFINER=`mc`@`%` PROCEDURE `load_variable_keys` (IN `str` VARCHAR(200))   SELECT var_name FROM `syncvariables` WHERE var_name LIKE CONCAT(str,'::%')$$

CREATE DEFINER=`mc`@`%` PROCEDURE `load_variable_list` (IN `key1` VARCHAR(200))   SELECT var_name,value,type FROM `syncvariables` WHERE var_name LIKE CONCAT(key1,'::%')$$

CREATE DEFINER=`mc`@`%` PROCEDURE `write_variable` (IN `name` VARCHAR(200), IN `value` LONGTEXT, IN `type` VARCHAR(50))   INSERT INTO `syncvariables` (`raw_id`, `var_name`, `value`, `type`) VALUES (NULL, name, value, type)
ON DUPLICATE KEY UPDATE var_name=VALUES(var_name) , value=VALUES(value) , type=VALUES(type)$$

DELIMITER ;


CREATE TABLE `syncvariables` (
  `raw_id` int(11) NOT NULL,
  `var_name` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `syncvariables`
  ADD PRIMARY KEY (`raw_id`),
  ADD UNIQUE KEY `var_name` (`var_name`);


ALTER TABLE `syncvariables`
  MODIFY `raw_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1552;
