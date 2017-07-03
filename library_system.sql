DROP SCHEMA IF EXISTS `library_system`;
CREATE SCHEMA `library_system`;

CREATE TABLE `library_system`.`user_types` (
  `user_type_id` INT NOT NULL,
  `user_type` VARCHAR(45) NOT NULL,
  `user_borrowing_time` INT NOT NULL,
  PRIMARY KEY (`user_type_id`));

CREATE TABLE `library_system`.`user_secret_questions` (
  `secret_questions_id` INT NOT NULL,
  `secret_question` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`secret_questions_id`));

CREATE TABLE `library_system`.`users` (
  `user_id` INT NOT NULL,
  `user_type_id` INT NOT NULL,
  `user_firstname` VARCHAR(45) NOT NULL,
  `user_lastname` VARCHAR(45) NOT NULL,
  `user_middlename` VARCHAR(45) NOT NULL,
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
  `user_secret_answer_id` INT NOT NULL,
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
  `author_middlename` VARCHAR(45) NOT NULL,
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
  `reservation_publisher` VARCHAR(100) NOT NULL,
  `reservation_dds` VARCHAR(3) NOT NULL,
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
  `admin_middlename` VARCHAR(45) NOT NULL,
  `admin_email` VARCHAR(45) NOT NULL,
  `admin_password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `admin_type_idx` (`admin_type` ASC),
  CONSTRAINT `admin_type`
    FOREIGN KEY (`admin_type`)
    REFERENCES `library_system`.`admin_types` (`admin_types_id`)
    ON DELETE NO ACTION

DELIMITER $$
USE `library_system`$$
BEGIN
	DECLARE existing_user INT;
	SET existing_user =
	(SELECT COUNT(users.`user_id`) 
	FROM `borrowing_system`.`users` users
	WHERE users.`user_username` = user AND  users.`user_password`);
	IF existing_user > 0 THEN
		SET exist = TRUE;
	ELSE
		SET exist = FALSE;
	END IF;
END$$

DELIMITER ;