DROP DATABASE IF EXISTS `Hospital`;
CREATE DATABASE `Hospital`;
USE `Hospital`;

DROP TABLE IF EXISTS `hospital_patient`;
CREATE TABLE `hospital_patient` (
	`id` VARCHAR(9) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `surname` VARCHAR(45) NOT NULL,
    `birthdate` DATE NOT NULL,
    `gender` ENUM('Male','Female','Other'),
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `hospital_room`;
CREATE TABLE `hospital_room` (
	`id` VARCHAR(4) NOT NULL,
    `type` ENUM('Single Room','Deluxe Room','Intensive Care Unit','Labor') NOT NULL,
    `doctor` VARCHAR(9) NOT NULL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `hospital_doctor`;
CREATE TABLE `hospital_doctor` (
	`id` VARCHAR(9) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `surname` VARCHAR(45) NOT NULL,
    `birthdate` DATE NOT NULL,
    `gender` ENUM('Male','Female','Other'),
    `room` VARCHAR(4) NOT NULL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `hospital_appointment`;
CREATE TABLE `hospital_appointment` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
    `reason` VARCHAR(255) NOT NULL,
    `date` DATE NOT NULL,
    `patient` VARCHAR(9) NOT NULL,
    `doctor` VARCHAR(9) NOT NULL,
    `room` VARCHAR(4) NOT NULL,
    PRIMARY KEY (`id`)
);

INSERT INTO hospital_patient VALUES ('123456789','Lidia','Ortiz Suárez','1985/05/05','Female');
INSERT INTO hospital_patient VALUES ('123456788','Daniel','Ramos Fuentes','1997/03/28','Male');
INSERT INTO hospital_patient VALUES ('123456787','Marta','Vázquez Melero','2003/11/12','Other');
INSERT INTO hospital_room VALUES ('PS-2','Single Room','123456788');
INSERT INTO hospital_room VALUES ('P9-8','Labor','123456789');
INSERT INTO hospital_room VALUES ('PB-4','Intensive Care Unit','123456787');
INSERT INTO hospital_appointment VALUES (NULL,'Worries','2018/12/30','123456789','123456789','P9-8');
INSERT INTO hospital_appointment VALUES (NULL,'Pain','2019/01/03','123456787','123456787','PB-4');
INSERT INTO hospital_appointment VALUES (NULL,'Check','1994/05/06','123456788','123456788','PS-2');
INSERT INTO hospital_doctor VALUES ('123456789','Johanna','Krystof','1990/01/01','Female','P9-8');
INSERT INTO hospital_doctor VALUES ('123456787','Connor','McGregor','1997/11/18','Male','PB-4');
INSERT INTO hospital_doctor VALUES ('123456788','Antoine','Griezmann','1991/02/22','Male','PS-2');

ALTER TABLE `hospital_room` ADD FOREIGN KEY (`doctor`) REFERENCES `hospital_doctor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_doctor` ADD FOREIGN KEY (`room`) REFERENCES `hospital_room`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_appointment` ADD FOREIGN KEY (`patient`) REFERENCES `hospital_patient`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_appointment` ADD FOREIGN KEY (`doctor`) REFERENCES `hospital_doctor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_appointment` ADD FOREIGN KEY (`room`) REFERENCES `hospital_room`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
