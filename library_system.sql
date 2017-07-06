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
/************/
/*LITERATURE*/
CREATE PROCEDURE `get_all_literature` ()
BEGIN
	SELECT *
	FROM `library_system`.`reservable_information`;
END$$

CREATE PROCEDURE `get_literature_by_id` (IN id INT)
BEGIN
	SELECT *
	FROM `library_system`.`reservable_information` library
	WHERE library.`reservable_id` = id;
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

CREATE PROCEDURE `add_literature`(IN utype INT, IN title VARCHAR(200), IN udate DATE, IN pub VARCHAR(100), IN dds INT)
BEGIN
	INSERT INTO `library_system`.`reservable_information`
	(`reservable_type_id`, `reservable_title`, `reservable_date`, `reservable_publisher`, `reservable_dds`)
	VALUES(utype, title, udate, pub, dds);

END$$

CREATE PROCEDURE `add_literature_with_id`(IN id INT, IN utype INT, IN title VARCHAR(200), IN udate DATE, IN pub VARCHAR(100), IN dds INT)
BEGIN
	INSERT INTO `library_system`.`reservable_information`
	(`reservable_id`, `reservable_type_id`, `reservable_title`, `reservable_date`, `reservable_publisher`, `reservable_dds`)
	VALUES(id, utype, title, udate, pub, dds);

END$$

CREATE PROCEDURE `delete_literature`(IN id INT)
BEGIN
	DELETE FROM `library_system`.`reservable_authors_tags`
	WHERE reservable_information_id = id;
	DELETE FROM `library_system`.`reservable_information`
	WHERE reservable_id = id;
END$$

CREATE PROCEDURE `update_literature`(IN id INT, IN utype INT, IN title VARCHAR(200), IN udate DATE, IN pub VARCHAR(100), IN dds INT)
BEGIN
	UPDATE `library_system`.`reservable_information` lib
	SET lib.`reservable_utype` = utype, lib.`reservable_title` = title,
		lib.`reservable_date` = udate, lib.`reservable_publisher` = pub,
		lib.`reservable_dds` = dds
	WHERE lib.`reservable_id` = id;
END$$

/*********/
/*AUTHORS*/
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

CREATE PROCEDURE `add_author` (IN author_last VARCHAR(45), IN author_first VARCHAR(45), IN author_middle VARCHAR(45))
BEGIN
	INSERT INTO `library_system`.`reservable_authors`
	(`author_lastname`, `author_firstname`, `author_middlename`)
	VALUES(author_last, author_first, author_middle);
END$$

CREATE PROCEDURE `add_author_with_id` (IN id INT, IN author_last VARCHAR(45), IN author_first VARCHAR(45), IN author_middle VARCHAR(45))
BEGIN
	INSERT INTO `library_system`.`reservable_authors`
	(`author_id`,`author_lastname`, `author_firstname`, `author_middlename`)
	VALUES(id, author_last, author_first, author_middle);
END$$

CREATE PROCEDURE `delete_author`(IN id INT)
BEGIN
	DELETE FROM `library_system`.`reservable_authors_tags`
	WHERE reservable_author_id = id;
	DELETE FROM `library_system`.`reservable_authors`
	WHERE author_id = id;
END$$

CREATE PROCEDURE `update_author` (IN id INT, IN author_last VARCHAR(45), IN author_first VARCHAR(45), IN author_middle VARCHAR(45))
BEGIN
	UPDATE `library_system`.`reservable_authors` auth
	SET auth.`author_lastname` = author_last, 
		auth.`author_firstname` = author_first,
		auth.`author_middlename` = author_middle
	WHERE auth.`author_id` = id;
END$$

/******/
/*TAGS*/
CREATE PROCEDURE `delete_tag` (IN tag INT)
BEGIN
	DELETE FROM `library_system`.`reservable_authors_tags`
	WHERE reservable_authors_tag = tag;
END$$

CREATE PROCEDURE `add_tag` (IN lit_id INT, IN auth_id INT)
BEGIN
	INSERT INTO `library_system`.`reservable_authors_tags` (`reservable_information_id`,`reservable_authors_id`)
	VALUES(lit_id, auth_id);
END$$

CREATE PROCEDURE `add_tag_with_id` (IN id INT, IN lit_id INT, IN auth_id INT)
BEGIN
	INSERT INTO `library_system`.`reservable_authors_tags` (`reservable_authors_tag`,`reservable_information_id`,`reservable_authors_id`)
	VALUES(id, lit_id, auth_id);
END$$

CREATE PROCEDURE `update_tag` (IN id INT, IN lit_id INT, IN auth_id INT)
BEGIN
	UPDATE `library_system`.`reservable_authors_tags` auth
	SET auth.`reservable_information_id` = lit_id, 
		auth.`reservable_authors_id` = auth_id
	WHERE auth.`reservable_authors_tag` = id;
END$$
	
/*******/
/*USERS*/
CREATE PROCEDURE `get_all_user_types` ()
BEGIN
	SELECT *
	FROM `library_system`.`user_types`;
END$$

CREATE PROCEDURE `get_all_user_secret_questions` ()
BEGIN
	SELECT *
	FROM `library_system`.`user_secret_questions`;
END$$

CREATE PROCEDURE `get_user_secret_answers` (IN user VARCHAR(45), IN pass VARCHAR(45))
BEGIN
	SELECT ans.`user_secret_answer`, quest.`user_secret_question`
	FROM `library_system`.`user_secret_answers` ans, `library_system`.`user_secret_questions` quest
	WHERE ans.`user_id` IN (SELECT *
							FROM `library_system`.`users` users
							WHERE users.`user_username` = user AND
								  users.`user_password` = pass) AND
		  ans.`user_secret_questions_id` = quest.`secret_questions_id`;
END$$

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

CREATE PROCEDURE `add_user` (IN utype INT, IN fname VARCHAR(45), IN lname VARCHAR(45), IN mname VARCHAR(45), 
							 IN user VARCHAR(20), IN pass VARCHAR(45), IN email VARCHAR(45),
							 IN bday DATE)
BEGIN
	INSERT INTO `library_system`.`users` 	
		(`user_type_id`, `user_firstname`, `user_lastname`, 
		`user_middlename`, `user_username`, `user_password`, `user_email`,
		`user_birthday`, `user_date_created`, `user_activated`)
	VALUES	(utype, fname, lname, mname, user, pass, email, 
			bday, CURDATE(), FALSE);
END$$

CREATE PROCEDURE `add_user_with_id` (IN id INT, IN utype INT, IN fname VARCHAR(45), IN lname VARCHAR(45), IN mname VARCHAR(45), 
							 IN user VARCHAR(20), IN pass VARCHAR(45), IN email VARCHAR(45),
							 IN bday DATE)
BEGIN
	INSERT INTO `library_system`.`users` 	
		(`user_id`, `user_type_id`, `user_firstname`, `user_lastname`, 
		`user_middlename`, `user_username`, `user_password`, `user_email`,
		`user_birthday`, `user_date_created`, `user_activated`)
	VALUES	(id, utype, fname, lname, mname, user, pass, email, 
			bday, CURDATE(), FALSE);
END$$

CREATE PROCEDURE `update_user` (IN past_user VARCHAR(20), IN past_pass VARCHAR(45),
								 IN utype INT, IN fname VARCHAR(45), IN lname VARCHAR(45), 
								 IN mname VARCHAR(45), IN user VARCHAR(20), IN pass VARCHAR(45), 
								 IN email VARCHAR(45), IN bday DATE)
BEGIN
	UPDATE `library_system`.`users` users
	SET users.`user_type_id` = utype,
		users.`user_firstname` = fname,
		users.`user_lastname` = lname,
		users.`user_middlename` = mname,
		users.`user_username` = user,
		users.`user_password` = pass,
		users.`user_email` = email,
		users.`birthday` = bday
	WHERE users.`user_id` IN (SELECT users2.`user_id`
							FROM `library_system`.`users` users2
							WHERE users2.`user_username` = past_user AND
								  users2.`user_password` = past_pass);
END$$

CREATE PROCEDURE `delete_user` (IN user VARCHAR(20), IN pass VARCHAR(45))
BEGIN
	DELETE FROM `library_system`.`users`
	WHERE user_id IN (SELECT users.`user_id`
							FROM `library_system`.`users` users
							WHERE users.`user_username` = user AND
								  users.`user_password` = pass);
END$$


/**************/
/*RESERVATIONS*/
CREATE PROCEDURE `get_all_reservations`()
BEGIN
	SELECT `reservable_id`, `reservable_type_id`, `reservable_title`, `reservable_date`, `reservable_publisher`, `reservable_dds`
	FROM `library_system`.`reserved_information` res, `library_system`.`reservable_information` lib
	WHERE res.`reserved_reservable_id` = lib.`reservable_id`;
END$$

CREATE PROCEDURE `get_user_literature_reservations` (IN user VARCHAR(20), IN pass VARCHAR(20))
BEGIN
	SELECT `reservable_id`, `reservable_type_id`, `reservable_title`, `reservable_date`, `reservable_publisher`, `reservable_dds`,
		   `reserved_borrowed_date`, `reserved_due_date`
	FROM `library_system`.`reserved_information` res, `library_system`.`reservable_information` lib
	WHERE res.`reserved_reservable_id` = lib.`reservable_id` AND
		  res.`reserved_user_id` IN (SELECT users.`user_id`
									 FROM `library_system`.`users` users
									 WHERE users.`user_username` = user AND
										   users.`user_password` = pass);
END$$

CREATE PROCEDURE `reserve_literature` (IN user_id INT, IN lit_id INT, IN borrowed DATE, IN due DATE)
BEGIN
	INSERT INTO `library_system`.`reserved_literature`
	(`reserved_user_id`,`reserved_reservable_id`, `reserved_borrowed_date`, `reserved_due_date`)
	VALUES(user_id, lit_id, borrowed, due);
END$$

CREATE PROCEDURE `reserve_literature_with_id` (IN id INT, IN user_id INT, IN lit_id INT, IN borrowed DATE, IN due DATE)
BEGIN
	INSERT INTO `library_system`.`reserved_literature`
	(`reserved_information_id`, `reserved_user_id`,`reserved_reservable_id`, `reserved_borrowed_date`, `reserved_due_date`)
	VALUES(id, user_id, lit_id, borrowed, due);
END$$

CREATE PROCEDURE `delete_reservation` (IN user_id INT, IN lit_id INT)
BEGIN
	DELETE FROM `library_system`.`reserved_literature`
	WHERE reserved_user_id = user_id AND
		  reserved_reservable_id = lit_id;
END$$

/******************/
/*DISCUSSION ROOMS*/
CREATE PROCEDURE `get_all_discussion_rooms` ()
BEGIN
	SELECT *
	FROM `library_system`.`discussion_rooms`;
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
VALUES	(1,1,'Rofi', 'Santos', 'Lectura', 'testing', 'testingencryption', 'rofi_santos@dlsu.edu.ph', '1997-04-19', '2017-05-05', TRUE),
		(2,1,'Winfred', 'Villaluna', 'Dela Cruz', 'testing2', 'testingencryption', 'winfred_villaluna@dlsu.edu.ph', '1998-12-12', '2017-05-05', TRUE),
		(3,2,'Darlene', 'Marpa', 'Something', 'testing3', 'testingencryption', 'darlene_marpa@dlsu.edu.ph', '1997-12-12', '2017-05-05', TRUE);

INSERT INTO `library_system`.`reservable_information`
	(`reservable_id`, `reservable_type_id`, `reservable_title`,
	`reservable_date`, `reservable_publisher`, `reservable_dds`)
VALUES	(1,1,'The Moby Dick', '1851-10-18', 'Herman Melville', 810),
		(2,1,'Don Quixote', '1615-01-01','Miguel Cervantes',860),
		(3,2,'Top Gear', '2013-04-30', 'Immediate Media Company', 640),
		(4,1, 'The Catcher in the Rye', '1951-07-16', 'Little, Brown and ', 813),
		(5,1, 'Theories of Personality', '2001-05-29', 'Mcgraw-Hill', 155),
		(6,1, 'Memories, Dreams, Reflections', '1961-06-03', 'C.G. Jung', 150),
		(7,1, 'Outline of Psychoanalysis', '1940-10-30', 'S. Freud', 151),
		(8,2, 'Esquire', '2017-06-24', 'Hearst Communications, Inc.', 391),
		(25,1,'Harry Potter 1', '1997-06-16', 'Scholastic', 811),
		(26,1,'Harry Potter 2', '1998-05-21', 'Scholastic', 812),
		(27,1,'Harry Potter 3', '1999-10-04', 'Scholastic', 813),
		(28,1,'Harry Potter 4', '2000-12-13', 'Scholastic', 814),
		(29,1,'Harry Potter 5', '2003-01-31', 'Scholastic', 815),
		(30,1,'Harry Potter 6', '2005-10-18', 'Scholastic', 816),
		(31,1,'Harry Potter 7', '2007-10-18', 'Scholastic', 817),
		(32,2,'FHM Top 100 Sexiest Women in the World 2014', '2014-02-14', 'Bauer Media Group', 200),
		(33,1,'Shared Memory Parallelism Can Be Simple, Fast and Scalable', '2017-01-01', 'ACM', 005),
		(34,3,'Towards compressing web graphs', '2001-09-23', 'IEEE', 005),
		(35,3,'Rethinking computing', '2009-03-04', 'ACM', 006),
		(36,3,'Understanding computer mediated social experience: implications for CSCL', '2005-05-27', 'International Society of the Learning Sciences', 006),
		(37,3,'Affective prediction in photographic images using probabilistic affective model', '2010-06-07', 'ACM', 006),
		(38,3,'An affect detection technique using mobile commodity sensors in the wild', '2016-09-12','ACM', 006),
		(39,3,'Against software patents','1992-11-16','ACM',001),
		(40,3,'A glimpse of Hopjs','2016-09-18', 'ACM', 000),
		(41,3,'The Evolutionary Origins of Human Cognitive Development: Insights from Research on Chimpanzees','2015-10-21','ACM', 508),
		(42,3,'Synthetic biology: from bacteria to stem cells','2007-06-04','ACM', 572),
		(43,3,'Bioinformatics','2010-07-07','ACM', 576),
		(44,3,'(Computational) synthetic biology','2011-07-12','ACM',575),
		(45,3,'SMITE: battleground of the gods','2015-09-09','ACM',005),
		(46,3,'Software engineering and performance: a roadmap', '2000-06-04','ACM', 005),
		(47,3,'Peer assisted instruction and VLE in enquiry based learning in chemical engineering', '2013-09-18', 'IEEE', 660),
		(48,3,'On-line labs to teach Chemical engineering: Synergies between complementary tools', '2012-09-12', 'IEEE', 660),
		(49,3,'PULSE Extended', '2009-05-24', 'IEEE', 607),
		(50,3,'Mineral Explorations by Landsat Image Ratios', '2007-09-26', 'IEEE', 550);
		

INSERT INTO `library_system`.`reservable_authors` 
	(`author_id`, `author_lastname`, `author_firstname`, `author_middlename`)
VALUES 	(1, 'Melville', 'Herman', 'N/A'),
		(2, 'Cervantes', 'Miguel', 'N/A'),
		(3, 'Clarkson', 'Jeremy', 'N/A'),
		(4, 'Hammond', 'Richmond', 'N/A'),
		(5, 'Rowling', 'Joanne', 'Katherine'),
		(6, 'FHM', 'Magazine', 'N/A'),
		(7, 'Julian', 'Shun', 'N/A'),
		(8, 'Adler', 'Micah', 'N/A'),
		(9, 'Mitzenmacher', 'Michael', 'N/A'),
		(10, 'Mundie', 'Craig', 'N/A'),
		(11, 'Social Computing Research Group', 'N/A', 'N/A'),
		(12, 'Shin', 'Yunhee', 'N/A'),
		(13, 'Kim', 'Eun', 'Yi'),
		(14, 'Mottelson', 'Aske', 'N/A'),
		(15, 'Hornbaek', 'Kasper', 'N/A'),
		(16, 'The League for Programming Freedom', 'N/A', 'N/A'),
		(17, 'Serrano', 'Manuel', 'N/A'),
		(18, 'Prunet', 'Vincent', 'N/A'),
		(19, 'Matsuzawa', 'Tetsuro', 'N/A'),
		(20, 'Weiss', 'Ron', 'N/A'),
		(21, 'Moore', 'Jason', 'H.'),
		(22, 'Krasnogor', 'Natalie', 'N/A'),
		(23, 'Cullinane', 'Dave', 'N/A'),
		(24, 'Pooley', 'Rob', 'N/A'),
		(25, 'Glassey', 'Jarka', 'N/A'),
		(26, 'Salinger', 'Jerome', 'Jillich'),
		(27, 'Feist', 'George', 'N/A'),
		(28, 'Feist', 'Jess', 'N/A'),
		(29, 'Roberts', 'Tomi-Ann', 'N/A'),
		(30, 'Jung', 'Carl', 'Gustav'),
		(31, 'Freud', 'Sigmund', 'N/A'),
		(32, 'Rasteiro', 'M.', 'G.'),
		(33, 'Dragos', 'Sandra', 'N/A'),
		(34, 'Imbroane', 'Mircea', 'Alexandru'),
		(35, 'Hearst Communications, Inc.', 'N/A', 'N/A');

INSERT INTO `library_system`.`reservable_authors_tags`
	(`reservable_authors_tag`,`reservable_information_id`,`reservable_authors_id`)
VALUES 	(1,1,1),	(2,2,2),	(3,3,3),
		(4,3,4),	(5,25,5),	(6,26,5),
		(7,27,5),	(8,28,5),	(9,29,5),
		(10,30,5),	(11,31,5),	(12,32,6),
		(13,33,7),	(14,34,8),	(15,34,9),
		(16,35,10),	(17,36,11),	(18,37,12),
		(19,37,13),	(20,38,14),	(21,38,15),
		(22,39,16),	(23,40,17),	(24,40,18),
		(25,41,19),	(26,42,20),	(27,43,21),
		(28,44,22),	(29,45,23), (30,46,24),
		(31,47,25),	(32,4,26),	(33,5,27),
		(34,5,28),	(35,5,29),	(36,6,30),
		(37,7,31),	(38,48,32),	(39,49,33),
		(40,50,34),	(41,8,35);

INSERT INTO `library_system`.`discussion_rooms`(`discussion_rooms_id`, `discussion_rooms_name`)
VALUES	(1, 'Room 1'),
		(2, 'Room 2'),
		(3, 'Room 3'),
		(4, 'Room 4'),
		(5, 'Room 5');
	
		
			