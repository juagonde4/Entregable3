-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.5.8-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para entregable3
CREATE DATABASE IF NOT EXISTS `entregable3` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `entregable3`;

-- Volcando estructura para tabla entregable3.appointments
CREATE TABLE IF NOT EXISTS `appointments` (
  `appointmentId` int(11) NOT NULL AUTO_INCREMENT,
  `dateAppointment` date NOT NULL,
  `hourAppointment` time NOT NULL,
  `tutorialId` int(11) NOT NULL,
  `studentId` int(11) NOT NULL,
  PRIMARY KEY (`appointmentId`),
  UNIQUE KEY `dateAppointment` (`dateAppointment`,`hourAppointment`),
  KEY `tutorialId` (`tutorialId`),
  KEY `studentId` (`studentId`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`tutorialId`) REFERENCES `tutorials` (`tutorialId`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.appointments: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
REPLACE INTO `appointments` (`appointmentId`, `dateAppointment`, `hourAppointment`, `tutorialId`, `studentId`) VALUES
	(1, '2020-11-27', '08:00:00', 1, 2);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;

-- Volcando estructura para procedimiento entregable3.AppointmentsInformation
DELIMITER //
CREATE PROCEDURE `AppointmentsInformation`(teacher INT, thisDay VARCHAR(12))
BEGIN
	SELECT  Appointments.*,  Students.* 
	FROM Appointments, Students 
	WHERE Students.studentId = Appointments.studentId AND teacher = ( SELECT teacherId FROM	Tutorials WHERE Appointments.tutorialId = Tutorials.tutorialId) AND thisDay = ( SELECT WEEKDAY FROM Tutorials WHERE  Appointments.tutorialId  = Tutorials.tutorialId );

END//
DELIMITER ;

-- Volcando estructura para procedimiento entregable3.AssignTeacherToGroup
DELIMITER //
CREATE PROCEDURE `AssignTeacherToGroup`(teacher INT, grp INT, cred INT)
BEGIN
	INSERT  INTO  teacherssubjects (credits,  groupId,  teacherId)  VALUES (cred,  grp,  teacher);

END//
DELIMITER ;

-- Volcando estructura para tabla entregable3.classrooms
CREATE TABLE IF NOT EXISTS `classrooms` (
  `classroomId` int(11) NOT NULL AUTO_INCREMENT,
  `loudspeakers` tinyint(1) NOT NULL,
  `proyector` tinyint(1) NOT NULL,
  `spaceId` int(11) NOT NULL,
  PRIMARY KEY (`classroomId`),
  KEY `spaceId` (`spaceId`),
  CONSTRAINT `classrooms_ibfk_1` FOREIGN KEY (`spaceId`) REFERENCES `spaces` (`spaceId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.classrooms: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
REPLACE INTO `classrooms` (`classroomId`, `loudspeakers`, `proyector`, `spaceId`) VALUES
	(1, 0, 1, 1),
	(2, 1, 1, 2),
	(3, 0, 0, 3);
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.degrees
CREATE TABLE IF NOT EXISTS `degrees` (
  `degreeId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `years` int(11) NOT NULL DEFAULT 4,
  PRIMARY KEY (`degreeId`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `invalidDegreeYear` CHECK (`years` >= 3 and `years` <= 6)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.degrees: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `degrees` DISABLE KEYS */;
REPLACE INTO `degrees` (`degreeId`, `name`, `years`) VALUES
	(1, 'Grado en Ingenieria Informatica-\r\nTecnologias Informaticas', 4),
	(2, 'Grado en Ingenieria Informatica-\r\nIngenieria del Software', 4),
	(3, 'Grado en Ingenieria Informatica-\r\nIngenieria del Computadores', 4);
/*!40000 ALTER TABLE `degrees` ENABLE KEYS */;

-- Volcando estructura para procedimiento entregable3.DeleteGrades
DELIMITER //
CREATE PROCEDURE `DeleteGrades`(studentDni CHAR(9))
BEGIN
	DECLARE id INT;
	SET id = (SELECT studentId FROM Students WHERE dni=studentDni); 
	DELETE FROM Grades WHERE studentId=id;

END//
DELIMITER ;

-- Volcando estructura para tabla entregable3.departments
CREATE TABLE IF NOT EXISTS `departments` (
  `departmentId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`departmentId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.departments: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
REPLACE INTO `departments` (`departmentId`, `name`) VALUES
	(1, 'Ciencias de la Computacion e \r\nInteligencia artificial'),
	(2, 'Lenguajes y sistemas informaticos'),
	(3, 'Matematica Aplicada I');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.grades
CREATE TABLE IF NOT EXISTS `grades` (
  `gradeId` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(4,2) NOT NULL,
  `gradeCall` int(11) NOT NULL,
  `withHonours` tinyint(1) NOT NULL,
  `studentId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`gradeId`),
  UNIQUE KEY `duplicatedCallGrade` (`gradeCall`,`studentId`,`groupId`),
  KEY `studentId` (`studentId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE,
  CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `groups` (`groupId`) ON DELETE CASCADE,
  CONSTRAINT `invalidGradeValue` CHECK (`value` >= 0 and `value` <= 10),
  CONSTRAINT `invalidGradeCall` CHECK (`gradeCall` >= 1 and `gradeCall` <= 3),
  CONSTRAINT `invalidWithHonours` CHECK (`withHonours` = 0 or `value` >= 9)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.grades: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
REPLACE INTO `grades` (`gradeId`, `value`, `gradeCall`, `withHonours`, `studentId`, `groupId`) VALUES
	(1, 5.00, 1, 0, 2, 1),
	(2, 6.50, 1, 0, 1, 2),
	(3, 9.00, 2, 1, 2, 1);
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `groupId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `activity` varchar(20) NOT NULL,
  `year` int(11) NOT NULL,
  `subjectId` int(11) NOT NULL,
  `classroomId` int(11) DEFAULT NULL,
  PRIMARY KEY (`groupId`),
  UNIQUE KEY `name` (`name`,`year`,`subjectId`),
  KEY `subjectId` (`subjectId`),
  KEY `classroomId` (`classroomId`),
  CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`subjectId`) REFERENCES `subjects` (`subjectId`) ON DELETE CASCADE,
  CONSTRAINT `groups_ibfk_2` FOREIGN KEY (`classroomId`) REFERENCES `classrooms` (`classroomId`) ON DELETE SET NULL,
  CONSTRAINT `negativeGroupYear` CHECK (`year` > 0),
  CONSTRAINT `invalidGroupActivity` CHECK (`activity` in ('Teoria','Laboratorio'))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.groups: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
REPLACE INTO `groups` (`groupId`, `name`, `activity`, `year`, `subjectId`, `classroomId`) VALUES
	(1, '1', 'Laboratorio', 2020, 1, 1),
	(2, '2', 'Teoria', 2020, 1, 2);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.groupsstudents
CREATE TABLE IF NOT EXISTS `groupsstudents` (
  `groupStudentId` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `studentId` int(11) NOT NULL,
  PRIMARY KEY (`groupStudentId`),
  UNIQUE KEY `groupId` (`groupId`,`studentId`),
  KEY `studentId` (`studentId`),
  CONSTRAINT `groupsstudents_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `groups` (`groupId`) ON DELETE CASCADE,
  CONSTRAINT `groupsstudents_ibfk_2` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.groupsstudents: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `groupsstudents` DISABLE KEYS */;
REPLACE INTO `groupsstudents` (`groupStudentId`, `groupId`, `studentId`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 2, 1),
	(4, 2, 2);
/*!40000 ALTER TABLE `groupsstudents` ENABLE KEYS */;

-- Volcando estructura para procedimiento entregable3.InsertGrades
DELIMITER //
CREATE PROCEDURE `InsertGrades`(val  DECIMAL,  gdCall VARCHAR(20), withHon BOOLEAN, student INT, grp INT)
BEGIN
	INSERT  INTO  Grades  (value,  gradeCall,  withHonours,  studentId, groupId)  VALUES  (val,  gdCall,  withHon,  student,  grp);

END//
DELIMITER ;

-- Volcando estructura para tabla entregable3.offices
CREATE TABLE IF NOT EXISTS `offices` (
  `officeId` int(11) NOT NULL AUTO_INCREMENT,
  `isShared` tinyint(1) NOT NULL,
  `isThereFreeSpace` tinyint(1) NOT NULL,
  `spaceId` int(11) DEFAULT NULL,
  PRIMARY KEY (`officeId`),
  KEY `spaceId` (`spaceId`),
  CONSTRAINT `offices_ibfk_1` FOREIGN KEY (`spaceId`) REFERENCES `spaces` (`spaceId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.offices: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
REPLACE INTO `offices` (`officeId`, `isShared`, `isThereFreeSpace`, `spaceId`) VALUES
	(1, 0, 0, 2);
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;

-- Volcando estructura para procedimiento entregable3.procedureGrades
DELIMITER //
CREATE PROCEDURE `procedureGrades`(val DECIMAL,grCall VARCHAR(20),
withHon BOOLEAN,student INT, groupi INT)
BEGIN
		INSERT INTO Grades(value,gradeCall,withHonours,studentId,groupId)
		VALUES(val,grCall,withH,student,groupi);
	END//
DELIMITER ;

-- Volcando estructura para tabla entregable3.spaces
CREATE TABLE IF NOT EXISTS `spaces` (
  `spaceId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `FLOOR` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`spaceId`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `invalidCapacity` CHECK (`capacity` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.spaces: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `spaces` DISABLE KEYS */;
REPLACE INTO `spaces` (`spaceId`, `name`, `FLOOR`, `capacity`) VALUES
	(1, 'A2.10', 2, 70),
	(2, 'H1.10', 1, 60),
	(3, 'G1.30', 1, 25);
/*!40000 ALTER TABLE `spaces` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.students
CREATE TABLE IF NOT EXISTS `students` (
  `studentId` int(11) NOT NULL AUTO_INCREMENT,
  `accessMethod` varchar(30) NOT NULL,
  `dni` char(9) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `birthDate` date NOT NULL,
  `email` varchar(250) NOT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `invalidStudentAccessMethod` CHECK (`accessMethod` in ('Selectividad','Ciclo','Mayor','Titulado Extranjero'))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.students: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
REPLACE INTO `students` (`studentId`, `accessMethod`, `dni`, `firstName`, `surname`, `birthDate`, `email`) VALUES
	(1, 'Selectividad', '87654321W', 'Pepe', 'Pérez', '1999-05-29', 'pepeperez@alum.us.es'),
	(2, 'Ciclo', '13456789R', 'Marta', 'Miñam', '1997-03-02', 'martamiñan@alum.us.es');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.subjects
CREATE TABLE IF NOT EXISTS `subjects` (
  `subjectId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `acronym` varchar(8) NOT NULL,
  `credits` int(11) NOT NULL,
  `course` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `degreeId` int(11) NOT NULL,
  `departmentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`subjectId`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `acronym` (`acronym`),
  KEY `degreeId` (`degreeId`),
  KEY `departmentId` (`departmentId`),
  CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`degreeId`) REFERENCES `degrees` (`degreeId`) ON DELETE CASCADE,
  CONSTRAINT `subjects_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `departments` (`departmentId`) ON DELETE SET NULL,
  CONSTRAINT `negativeSubjectCredits` CHECK (`credits` > 0),
  CONSTRAINT `invalidSubjectCourse` CHECK (`course` > 0 and `course` < 6),
  CONSTRAINT `invalidSubjectType` CHECK (`type` in ('Formacion Basica','Optativa','Obligatoria'))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.subjects: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
REPLACE INTO `subjects` (`subjectId`, `name`, `acronym`, `credits`, `course`, `type`, `degreeId`, `departmentId`) VALUES
	(1, 'Inteligencia Artificial', 'IA', 6, 3, 'Obligatoria', 1, 1),
	(2, 'Diseño de Sistemas Digitales', 'DSD', 6, 2, 'Obligatoria', 2, 2),
	(3, 'Tecnologia de Computadores', 'TC', 6, 2, 'Obligatoria', 3, 3);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.teachers
CREATE TABLE IF NOT EXISTS `teachers` (
  `teacherId` int(11) NOT NULL AUTO_INCREMENT,
  `dni` char(9) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `birthDate` date NOT NULL,
  `email` varchar(250) NOT NULL,
  `category` varchar(30) NOT NULL,
  `officeId` int(11) DEFAULT NULL,
  `departmentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`teacherId`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `email` (`email`),
  KEY `officeId` (`officeId`),
  KEY `departmentId` (`departmentId`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`officeId`) REFERENCES `offices` (`officeId`) ON DELETE SET NULL,
  CONSTRAINT `teachers_ibfk_2` FOREIGN KEY (`departmentId`) REFERENCES `departments` (`departmentId`) ON DELETE SET NULL,
  CONSTRAINT `invalidTeacherCategory` CHECK (`category` in ('Profesor','Titular de Universidad','Profesor Contratado Doctor','Profesor Ayudante Doctor'))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.teachers: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
REPLACE INTO `teachers` (`teacherId`, `dni`, `firstName`, `surname`, `birthDate`, `email`, `category`, `officeId`, `departmentId`) VALUES
	(1, '43652797W', 'Antonio', 'Romero', '1960-04-13', 'antonioRomero@us.es', 'Titular de Universidad', 1, 2);
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.teacherssubjects
CREATE TABLE IF NOT EXISTS `teacherssubjects` (
  `teacherSubjectId` int(11) NOT NULL AUTO_INCREMENT,
  `teachingLoad` int(11) NOT NULL,
  `teacherId` int(11) NOT NULL,
  `subjectId` int(11) NOT NULL,
  PRIMARY KEY (`teacherSubjectId`),
  KEY `teacherId` (`teacherId`),
  KEY `subjectId` (`subjectId`),
  CONSTRAINT `teacherssubjects_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`teacherId`) ON DELETE CASCADE,
  CONSTRAINT `teacherssubjects_ibfk_2` FOREIGN KEY (`subjectId`) REFERENCES `subjects` (`subjectId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.teacherssubjects: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `teacherssubjects` DISABLE KEYS */;
REPLACE INTO `teacherssubjects` (`teacherSubjectId`, `teachingLoad`, `teacherId`, `subjectId`) VALUES
	(1, 2, 1, 2);
/*!40000 ALTER TABLE `teacherssubjects` ENABLE KEYS */;

-- Volcando estructura para tabla entregable3.tutorials
CREATE TABLE IF NOT EXISTS `tutorials` (
  `tutorialId` int(11) NOT NULL AUTO_INCREMENT,
  `dayWeek` varchar(100) NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `teacherId` int(11) DEFAULT NULL,
  PRIMARY KEY (`tutorialId`),
  KEY `teacherId` (`teacherId`),
  CONSTRAINT `tutorials_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`teacherId`) ON DELETE SET NULL,
  CONSTRAINT `invalidTutorialWeekday` CHECK (`dayWeek` in ('Lunes','Martes','Miercoles','Jueves','Viernes'))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla entregable3.tutorials: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `tutorials` DISABLE KEYS */;
REPLACE INTO `tutorials` (`tutorialId`, `dayWeek`, `startTime`, `endTime`, `teacherId`) VALUES
	(1, 'Viernes', '08:00:00', '10:00:00', 1),
	(2, 'Miercoles', '09:30:00', '12:00:00', 1),
	(3, 'Lunes', '11:00:00', '13:00:00', 1);
/*!40000 ALTER TABLE `tutorials` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
