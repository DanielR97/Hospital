DROP DATABASE IF EXISTS `Hospital`;
CREATE DATABASE `Hospital`;
USE `Hospital`;

DROP TABLE IF EXISTS `hospital_patient`;
CREATE TABLE `hospital_patient` (
	`id` VARCHAR(9) NOT NULL,
    `name` VARCHAR(45) NOT NULL,
    `surname` VARCHAR(45) NOT NULL,
    `birthdate` DATE NOT NULL,
    `gender` ENUM('Hombre','Mujer','Otro'),
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
    `gender` ENUM('Hombre','Mujer','Otro'),
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

INSERT INTO hospital_patient VALUES ('123456789','Lidia','Ortiz Suárez','1985/05/05','Mujer');
INSERT INTO hospital_patient VALUES ('123456788','Daniel','Ramos Fuentes','1997/03/28','Hombre');
INSERT INTO hospital_patient VALUES ('123456787','Marta','Vázquez Melero','2003/11/12','Otro');
INSERT INTO hospital_patient VALUES ('123587459', 'Pedro', 'De la Rosa Bentaleb', '2012-9-15', 'Hombre');
INSERT INTO hospital_patient VALUES ('363636367', 'Rebeca', 'Muñiz García', '2001-1-5', 'Mujer');
INSERT INTO hospital_patient VALUES ('456564546', 'José', 'Vélez Gray', '1955-2-3', 'Hombre');
INSERT INTO hospital_patient VALUES ('231231231', 'Rocío', 'Del Castillo González', '2007-11-21', 'Mujer');
INSERT INTO hospital_patient VALUES ('456789465', 'Laura', 'Martínez Cano', '1995-8-9', 'Mujer');
INSERT INTO hospital_patient VALUES ('789465123', 'Martín', 'Cuenca Rosales', '1945-5-6', 'Hombre');
INSERT INTO hospital_patient VALUES ('546231654', 'Juan', 'Pérez Sánchez', '1965/05/03', 'Hombre');

INSERT INTO hospital_room VALUES ('PS-2','Single Room','123456788');
INSERT INTO hospital_room VALUES ('P9-8','Labor','123456789');
INSERT INTO hospital_room VALUES ('PB-4','Intensive Care Unit','123456787');
INSERT INTO hospital_room VALUES ('PS-1','Single Room','456789456');
INSERT INTO hospital_room VALUES ('P1-2','Deluxe Room','123456123');
INSERT INTO hospital_room VALUES ('PB-3','Deluxe Room','789456123');
INSERT INTO hospital_room VALUES ('P3-5','Intensive Care Unit','789456456');
INSERT INTO hospital_room VALUES ('PS-8','Single Room','456123456');
INSERT INTO hospital_room VALUES ('P4-6','Single Room','165745687');
INSERT INTO hospital_room VALUES ('PB-1','Deluxe Room','658954521');

INSERT INTO hospital_appointment VALUES (NULL,'Leg pain','2018/12/30','123456789','123456789','P9-8');
INSERT INTO hospital_appointment VALUES (NULL,'Headache','2019/01/03','123456787','123456787','PB-4');
INSERT INTO hospital_appointment VALUES (NULL,'Monthly check','1994/05/06','123456788','123456788','PS-2');
INSERT INTO hospital_appointment VALUES (NULL,'Urgency','2018/05/01','123587459','456789456','PS-1');
INSERT INTO hospital_appointment VALUES (NULL,'Labor','2019/02/03','363636367','123456123','P1-2');
INSERT INTO hospital_appointment VALUES (NULL,'Vaccine','2018/02/02','456564546','789456123','PB-3');
INSERT INTO hospital_appointment VALUES (NULL,'Broken ankle','2018/11/11','231231231','789456456','P3-5');
INSERT INTO hospital_appointment VALUES (NULL,'Rehab','2019/03/06','456789465','456123456','PS-8');
INSERT INTO hospital_appointment VALUES (NULL,'Card renew','2018/06/13','789465123','165745687','P4-6');
INSERT INTO hospital_appointment VALUES (NULL,'Fever','2018/07/08','546231654','658954521','PB-1');

INSERT INTO hospital_doctor VALUES ('123456789','Johanna','Krystof','1990/01/01','Mujer','P9-8');
INSERT INTO hospital_doctor VALUES ('123456787','Connor','McGregor','1987/11/18','Hombre','PB-4');
INSERT INTO hospital_doctor VALUES ('123456788','Antoine','Griezmann','1991/02/22','Hombre','PS-2');
INSERT INTO hospital_doctor VALUES ('456789456','María','López Borges','1985/11/06','Mujer','PS-1');
INSERT INTO hospital_doctor VALUES ('123456123','Juana','De Arco Delgado','1957/07/19','Mujer','P1-2');
INSERT INTO hospital_doctor VALUES ('789456123','Mario','Mesa Casas','1961/06/24','Hombre','PB-3');
INSERT INTO hospital_doctor VALUES ('789456456','Carlos','Pérez López','1941/04/24','Hombre','P3-5');
INSERT INTO hospital_doctor VALUES ('456123456','Lorena','Martínez Mesa','1956/07/21','Mujer','PS-8');
INSERT INTO hospital_doctor VALUES ('165745687','África','Demaray','1959/11/12','Mujer','P4-6');
INSERT INTO hospital_doctor VALUES ('658954521','Julen','Etxebarría López','1963/12/11','Hombre','PB-1');

ALTER TABLE `hospital_room` ADD FOREIGN KEY (`doctor`) REFERENCES `hospital_doctor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_doctor` ADD FOREIGN KEY (`room`) REFERENCES `hospital_room`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_appointment` ADD FOREIGN KEY (`patient`) REFERENCES `hospital_patient`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_appointment` ADD FOREIGN KEY (`doctor`) REFERENCES `hospital_doctor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `hospital_appointment` ADD FOREIGN KEY (`room`) REFERENCES `hospital_room`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
