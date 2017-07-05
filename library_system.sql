DROP SCHEMA IF EXISTS `library_system`;
CREATE SCHEMA `library_system`;

CREATE TABLE `library_system`.`user_types` (
  `user_type_id` INT NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(45) NOT NULL,
  `user_borrowing_time` INT NOT NULL,
  PRIMARY KEY (`user_type_id`));

CREATE TABLE `library_system`.`user_secret_questions` (
  `secret_questions_id` INT NOT NULL,
  `secret_question` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`secret_questions_id`));

CREATE TABLE `library_system`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_type_id` INT NOT NULL,
  `user_firstname` VARCHAR(45) NOT NULL,
  `user_lastname` VARCHAR(45) NOT NULL,
  `user_middlename` VARCHAR(45) NOT NULL DEFAULT 'N/A',
  `user_username` VARCHAR(20) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_birthday` DATE NOT NULL,
  `user_date_created` DATE NOT NULL,
  `user_activated` BOOLEAN NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `user_type_id_idx` (`user_type_id` ASC),
  CONSTRAINT `user_type_id`
    FOREIGN KEY (`user_type_id`)
    REFERENCES `library_system`.`user_types` (`user_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `library_system`.`user_secret_answers` (
  `user_secret_answer_id` INT NOT NULL AUTO_INCREMENT,
  `user_secret_question_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `user_secret_answer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_secret_answer_id`),
  INDEX `user_secret_question_id_idx` (`user_secret_question_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `user_secret_question_id`
    FOREIGN KEY (`user_secret_question_id`)
    REFERENCES `library_system`.`user_secret_questions` (`secret_questions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `library_system`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `library_system`.`reservable_authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_lastname` VARCHAR(45) NOT NULL,
  `author_firstname` VARCHAR(45) NOT NULL,
  `author_middlename` VARCHAR(45) NOT NULL DEFAULT 'N/A',
  PRIMARY KEY (`author_id`));

CREATE TABLE `library_system`.`reservable_types` (
  `reservation_type_id` INT NOT NULL AUTO_INCREMENT,
  `reservation_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`reservation_type_id`));

CREATE TABLE `library_system`.`reservable_information` (
  `reservable_id` INT NOT NULL AUTO_INCREMENT,
  `reservable_type_id` INT NOT NULL,
  `reservable_title` VARCHAR(200) NOT NULL,
  `reservable_date` DATE NOT NULL,
  `reservable_publisher` VARCHAR(100) NOT NULL,
  `reservable_dds` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`reservable_id`),
  INDEX `reservable_type_id_idx` (`reservable_type_id` ASC),
  CONSTRAINT `reservable_type_id`
    FOREIGN KEY (`reservable_type_id`)
    REFERENCES `library_system`.`reservable_types` (`reservation_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `library_system`.`reserved_information` (
  `reserved_information_id` INT NOT NULL AUTO_INCREMENT,
  `reserved_user_id` INT NOT NULL,
  `reserved_reservable_id` INT NOT NULL,
  `reserved_borrowed_date` DATE NOT NULL,
  `reserved_due_date` DATE NOT NULL,
  PRIMARY KEY (`reserved_information_id`),
  INDEX `reserved_reservable_id_idx` (`reserved_reservable_id` ASC),
  INDEX `reserved_user_id_idx` (`reserved_user_id` ASC),
  CONSTRAINT `reserved_reservable_id`
    FOREIGN KEY (`reserved_reservable_id`)
    REFERENCES `library_system`.`reservable_information` (`reservable_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `reserved_user_id`
    FOREIGN KEY (`reserved_user_id`)
    REFERENCES `library_system`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `library_system`.`reservable_authors_tags` (
  `reservable_authors_tag` INT NOT NULL AUTO_INCREMENT,
  `reservable_information_id` INT NOT NULL,
  `reservable_authors_id` INT NOT NULL,
  PRIMARY KEY (`reservable_authors_tag`),
  INDEX `reservable_authors_idx` (`reservable_authors_id` ASC),
  INDEX `reservable_information_id_idx` (`reservable_information_id` ASC),
  CONSTRAINT `reservable_authors_id`
    FOREIGN KEY (`reservable_authors_id`)
    REFERENCES `library_system`.`reservable_authors` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `reservable_information_id`
    FOREIGN KEY (`reservable_information_id`)
    REFERENCES `library_system`.`reservable_information` (`reservable_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `library_system`.`discussion_rooms` (
  `discussion_rooms_id` INT NOT NULL AUTO_INCREMENT,
  `discussion_rooms_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`discussion_rooms_id`));

CREATE TABLE `library_system`.`reserved_discussion_rooms` (
  `reserved_rooms_id` INT NOT NULL AUTO_INCREMENT,
  `room_user_id` INT NOT NULL,
  `discussion_room_id` INT NOT NULL,
  `reserved_room_date` DATE NOT NULL,
  `reserved_room_time_start` TIME NOT NULL,
  `reserved_room_time_end` TIME NOT NULL,
  PRIMARY KEY (`reserved_rooms_id`),
  INDEX `discussion_room_id_idx` (`discussion_room_id` ASC),
  INDEX `room_user_id_idx` (`room_user_id` ASC),
  CONSTRAINT `discussion_room_id`
    FOREIGN KEY (`discussion_room_id`)
    REFERENCES `library_system`.`discussion_rooms` (`discussion_rooms_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `room_user_id`
    FOREIGN KEY (`room_user_id`)
    REFERENCES `library_system`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `library_system`.`user_reviews` (
  `reservable_reviews_id` INT NOT NULL AUTO_INCREMENT,
  `reservable_id` INT NOT NULL,
  `reservable_user_id` INT NOT NULL,
  `user_review` TEXT NOT NULL,
  PRIMARY KEY (`reservable_reviews_id`),
  INDEX `user_id_idx` (`reservable_user_id` ASC),
  INDEX `reservable_id_idx` (`reservable_id` ASC),
  CONSTRAINT `reservable_id`
    FOREIGN KEY (`reservable_id`)
    REFERENCES `library_system`.`reservable_information` (`reservable_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `reservable_user_id`
    FOREIGN KEY (`reservable_user_id`)
    REFERENCES `library_system`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `library_system`.`admin_types` (
  `admin_types_id` INT NOT NULL AUTO_INCREMENT,
  `admin_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`admin_types_id`));

CREATE TABLE `library_system`.`admins` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `admin_type` INT NOT NULL,
  `admin_firstname` VARCHAR(45) NOT NULL,
  `admin_lastname` VARCHAR(45) NOT NULL,
  `admin_middlename` VARCHAR(45) NOT NULL DEFAULT 'N/A',
  `admin_email` VARCHAR(45) NOT NULL,
  `admin_password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `admin_type_idx` (`admin_type` ASC),
  CONSTRAINT `admin_type`
    FOREIGN KEY (`admin_type`)
    REFERENCES `library_system`.`admin_types` (`admin_types_id`)
    ON DELETE NO ACTION
	ON UPDATE NO ACTION);

DELIMITER $$
USE `library_system`$$
CREATE PROCEDURE `get_user_information` (IN user VARCHAR(45), IN pass VARCHAR(45))
BEGIN
	SELECT *
	FROM `library_system`.`users` users
	WHERE users.`user_username` = user AND  users.`user_password` = pass;
END$$

CREATE PROCEDURE `check_user_exists` (IN user VARCHAR(45), IN pass VARCHAR(45), OUT exist BOOLEAN)
BEGIN
	DECLARE existing_user INT;
	SET existing_user =
	(SELECT COUNT(users.`user_id`) 
	FROM `library_system`.`users` users
	WHERE users.`user_username` = user AND  users.`user_password` = pass);
	IF existing_user > 0 THEN
		SET exist = TRUE;
	ELSE
		SET exist = FALSE;
	END IF;
END$$ 

CREATE PROCEDURE `get_all_literature` ()
BEGIN
	SELECT *
	FROM `library_system`.`reservable_information`;
END$$ 

CREATE PROCEDURE `get_all_literatures_by_title` (IN lit_name VARCHAR(200))
BEGIN 
	SELECT *
	FROM `library_system`.`reservable_information` library
	WHERE LOCATE(lit_name,library.`reservable_title`);
END$$

CREATE PROCEDURE `get_all_literatures_by_publisher` (IN lit_pub VARCHAR(100))
BEGIN 
	SELECT *
	FROM `library_system`.`reservable_information` library
	WHERE LOCATE(lit_pub,library.`reservable_publisher`);
END$$

CREATE PROCEDURE `get_all_literatures_by_date` (IN lit_date DATE)
BEGIN 
	SELECT *
	FROM `library_system`.`reservable_information` library
	WHERE library.`reservable_date` LIKE lit_date;
END$$

CREATE PROCEDURE `get_all_literatures_by_author` (IN author_last VARCHAR(45), IN author_first VARCHAR(45))
BEGIN
	SELECT *
	FROM `library_system`.`reservable_information` library
	WHERE library.`reservable_Id` IN(SELECT tags.`reservable_information_id`
		   FROM `library_system`.`reservable_authors_tags` tags
		   WHERE tags.`reservable_authors_id` IN (SELECT author.`author_id`
				  FROM `library_system`.`reservable_authors` author
				  WHERE author.`author_lastname` LIKE author_last OR 
						author.`author_firstname` LIKE author_first) 
				  );
END$$


CREATE PROCEDURE `get_all_authors` ()
BEGIN 
	SELECT *
	FROM `library_system`.`reservable_authors`;
END$$

CREATE PROCEDURE `get_all_authors_by_name` (IN author_last VARCHAR(45), IN author_first VARCHAR(45))
BEGIN 
	SELECT *
	FROM `library_system`.`reservable_authors` author
	WHERE author.`author_lastname` LIKE author_last OR 
		  author.`author_firstname` LIKE author_first;
END$$

CREATE PROCEDURE `get_all_authors_by_reservable` (IN indx INT)
BEGIN 
	SELECT *
	FROM `library_system`.`reservable_authors` author
	WHERE author.`author_id` IN (SELECT `reservable_authors_id`
		   FROM `library_system`.`reservable_authors_tags` tags
		   WHERE tags.`reservable_information_id` LIKE indx);
END$$

CREATE PROCEDURE `get_all_author_id_by_name` (IN author_last VARCHAR(45), IN author_first VARCHAR(45))
BEGIN 
	SELECT author.`author_id`
	FROM `library_system`.`reservable_authors` author
	WHERE author.`author_lastname` LIKE author_last OR 
		  author.`author_firstname` LIKE author_first;
END$$

DELIMITER ;

/*DELIMITER $$
DROP TRIGGER IF EXISTS library_system.encrypt_data$$
USE `library_system`$$
CREATE TRIGGER `encrypt_data` 
BEFORE INSERT ON `users` FOR EACH ROW
	BEGIN
		DECLARE x INT; 
		DECLARE temp INT;
		DECLARE cryptopass VARCHAR(45);
		DECLARE pass VARCHAR(45);
		DECLARE y CHAR;
		SET x = 1;
		SET cryptopass = '';
		SET pass = NEW.user_password;
		WHILE x <= CHAR_LENGTH(pass) DO
			SET y = SUBSTRING(pass FROM x FOR 1);
			SET temp = ASCII(y) + 10;
			SET y = CHAR(temp);
			SET cryptopass = CONCAT(cryptopass, y);
			SET x = x + 1;
		END WHILE;
		SET NEW.user_password = cryptopass;
	END
$$ DELIMITER ;*/

/*test data*/
INSERT INTO `library_system`.`user_types` (`user_type_id`, `user_type`, `user_borrowing_time`)
VALUES 	(1,'Student', 7),
		(2,'Faculty', 14);

INSERT INTO `library_system`.`reservable_types` (`reservation_type_id`, `reservation_type`)
VALUES 	(1, 'Book'),
		(2, 'Magazine'),
		(3, 'Thesis');

INSERT INTO `library_system`.`users` 	
	(`user_id`, `user_type_id`, `user_firstname`, `user_lastname`, 
	`user_middlename`, `user_username`, `user_password`, `user_email`,
	`user_birthday`, `user_date_created`, `user_activated`)
VALUES	(1,1,'testname', 'test', 'name', 'testing', 'testingencryption', 'abcd@abc.com', '1998-10-10', '2017-10-11', TRUE);

INSERT INTO `library_system`.`reservable_information`
	(`reservable_id`, `reservable_type_id`, `reservable_title`,
	`reservable_date`, `reservable_publisher`, `reservable_dds`)
VALUES	(1,1,'The Moby Dick', '1851-10-18', 'Herman Melville', '810'),
		(2,1,'Don Quixote', '1615-01-01','Miguel Cervantes','863'),
		(3,2,'Top Gear', '2013-04-30', 'Immediate Media Company', '642');

INSERT INTO `library_system`.`reservable_authors` 
	(`author_id`, `author_lastname`, `author_firstname`, `author_middlename`)
VALUES 	(1, 'Melville', 'Herman', 'N/A'),
		(2, 'Cervantes', 'Miguel', 'N/A'),
		(3, 'Clarkson', 'Jeremy', 'N/A'),
		(4, 'Hammond', 'Richmond', 'N/A');
INSERT INTO `library_system`.`reservable_authors_tags`
	(`reservable_authors_tag`,`reservable_information_id`,`reservable_authors_id`)
VALUES 	(1,1,1),
		(2,2,2),
		(3,3,3),
		(4,3,4);
		
			