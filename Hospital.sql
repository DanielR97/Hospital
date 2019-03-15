DROP DATABASE IF EXISTS `Hospital`;
CREATE DATABASE `Hospital`;
USE `Hospital`;

CREATE TABLE `Patient` (
	`ID` VARCHAR(9) NOT NULL,
    `Name` VARCHAR(45) NOT NULL,
    `Surname` VARCHAR(45) NOT NULL,
    `Birthdate` DATE NOT NULL,
    `Gender` ENUM('Male','Female','Other'),
    PRIMARY KEY (`ID`)
);

CREATE TABLE `Room` (
	`ID` VARCHAR(4) NOT NULL,
    `Type` ENUM('Single Room','Deluxe Room','Intensive Care Unit','Labor') NOT NULL,
    `Doctor` VARCHAR(9) NOT NULL,
    PRIMARY KEY (`ID`)
);

CREATE TABLE `Doctor` (
	`ID` VARCHAR(9) NOT NULL,
    `Name` VARCHAR(45) NOT NULL,
    `Surname` VARCHAR(45) NOT NULL,
    `Birthdate` DATE NOT NULL,
    `Gender` ENUM('Male','Female','Other'),
    `Room` VARCHAR(4) NOT NULL,
    PRIMARY KEY (`ID`)
);

CREATE TABLE `Appointment` (
	`ID` INT(11) NOT NULL AUTO_INCREMENT,
    `Reason` VARCHAR(255) NOT NULL,
    `Date` DATE NOT NULL,
    `Patient` VARCHAR(9) NOT NULL,
    `Doctor` VARCHAR(9) NOT NULL,
    `Room` VARCHAR(4) NOT NULL,
    PRIMARY KEY (`ID`)
);

INSERT INTO Patient VALUES ('123456789','Lidia','Ortiz Suárez','1985/05/05','Female');
INSERT INTO Patient VALUES ('123456788','Daniel','Ramos Fuentes','1997/03/28','Male');
INSERT INTO Patient VALUES ('123456787','Marta','Vázquez Melero','2003/11/12','Other');
INSERT INTO Patient VALUES ('123587459', 'Pedro', 'De la Rosa Bentaleb', '2012-9-15', 'Male');
INSERT INTO Patient VALUES ('363636367', 'Rebeca', 'Muñiz García', '2001-1-5', 'Female');
INSERT INTO Patient VALUES ('456564546', 'José', 'Vélez Gray', '1955-2-3', 'Male');
INSERT INTO Patient VALUES ('231231231', 'Rocío', 'Del Castillo González', '2007-11-21', 'Female');
INSERT INTO Patient VALUES ('456789465', 'Laura', 'Martínez Cano', '1995-8-9', 'Female');
INSERT INTO Patient VALUES ('789465123', 'Martín', 'Cuenca Rosales', '1945-5-6', 'Male');
INSERT INTO Patient VALUES ('546231654', 'Juan', 'Pérez Sánchez', '1965/05/03', 'Male');

INSERT INTO Room VALUES ('PS-2','Single Room','123456788');
INSERT INTO Room VALUES ('P9-8','Labor','123456789');
INSERT INTO Room VALUES ('PB-4','Intensive Care Unit','123456787');
INSERT INTO Room VALUES ('PS-1','Single Room','456789456');
INSERT INTO Room VALUES ('P1-2','Deluxe Room','123456123');
INSERT INTO Room VALUES ('PB-3','Deluxe Room','789456123');
INSERT INTO Room VALUES ('P3-5','Intensive Care Unit','789456456');
INSERT INTO Room VALUES ('PS-8','Single Room','456123456');
INSERT INTO Room VALUES ('P4-6','Single Room','165745687');
INSERT INTO Room VALUES ('PB-1','Deluxe Room','658954521');

INSERT INTO Appointment VALUES (NULL,'Leg pain','2018/12/30','123456789','123456789','P9-8');
INSERT INTO Appointment VALUES (NULL,'Headache','2019/01/03','123456787','123456787','PB-4');
INSERT INTO Appointment VALUES (NULL,'Monthly check','1994/05/06','123456788','123456788','PS-2');
INSERT INTO Appointment VALUES (NULL,'Urgency','2018/05/01','123587459','456789456','PS-1');
INSERT INTO Appointment VALUES (NULL,'Labor','2019/02/03','363636367','123456123','P1-2');
INSERT INTO Appointment VALUES (NULL,'Vaccine','2018/02/02','456564546','789456123','PB-3');
INSERT INTO Appointment VALUES (NULL,'Broken ankle','2018/11/11','231231231','789456456','P3-5');
INSERT INTO Appointment VALUES (NULL,'Rehab','2019/03/06','456789465','456123456','PS-8');
INSERT INTO Appointment VALUES (NULL,'Card renew','2018/06/13','789465123','165745687','P4-6');
INSERT INTO Appointment VALUES (NULL,'Fever','2018/07/08','546231654','658954521','PB-1');

INSERT INTO Doctor VALUES ('123456789','Johanna','Krystof','1990/01/01','Female','P9-8');
INSERT INTO Doctor VALUES ('123456787','Connor','McGregor','1987/11/18','Male','PB-4');
INSERT INTO Doctor VALUES ('123456788','Antoine','Griezmann','1991/02/22','Male','PS-2');
INSERT INTO Doctor VALUES ('456789456','María','López Borges','1985/11/06','Female','PS-1');
INSERT INTO Doctor VALUES ('123456123','Juana','De Arco Delgado','1957/07/19','Female','P1-2');
INSERT INTO Doctor VALUES ('789456123','Mario','Mesa Casas','1961/06/24','Male','PB-3');
INSERT INTO Doctor VALUES ('789456456','Carlos','Pérez López','1941/04/24','Male','P3-5');
INSERT INTO Doctor VALUES ('456123456','Lorena','Martínez Mesa','1956/07/21','Female','PS-8');
INSERT INTO Doctor VALUES ('165745687','África','Demaray','1959/11/12','Female','P4-6');
INSERT INTO Doctor VALUES ('658954521','Julen','Etxebarría López','1963/12/11','Male','PB-1');

ALTER TABLE `Room` ADD FOREIGN KEY (`Doctor`) REFERENCES `Doctor`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Doctor` ADD FOREIGN KEY (`Room`) REFERENCES `Room`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Appointment` ADD FOREIGN KEY (`Patient`) REFERENCES `Patient`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Appointment` ADD FOREIGN KEY (`Doctor`) REFERENCES `Doctor`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `Appointment` ADD FOREIGN KEY (`Room`) REFERENCES `Room`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
