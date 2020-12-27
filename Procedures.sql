


DELIMITER //
/*RF-001*/
CREATE  OR  REPLACE  PROCEDURE  
	InsertGrades(val  DECIMAL,  gdCall VARCHAR(20), withHon BOOLEAN, student INT, grp INT)
	
	BEGIN
	INSERT  INTO  Grades  (value,  gradeCall,  withHonours,  studentId, groupId)  VALUES  (val,  gdCall,  withHon,  student,  grp);

END //

DELIMITER ;

/*RF-002*/

DELIMITER //

CREATE OR REPLACE PROCEDURE 
	AppointmentsInformation (teacher INT, thisDay VARCHAR(12))
	
	BEGIN
	SELECT  Appointments.*,  Students.* 
	FROM Appointments, Students 
	WHERE Students.studentId = Appointments.studentId AND teacher = ( SELECT teacherId FROM	Tutorials WHERE Appointments.tutorialId = Tutorials.tutorialId) AND thisDay = ( SELECT WEEKDAY FROM Tutorials WHERE  Appointments.tutorialId  = Tutorials.tutorialId );

END //

DELIMITER ;

/*RF-003*/

DELIMITER //

CREATE OR REPLACE PROCEDURE 
	AssignTeacherToGroup (teacher INT, grp INT, cred INT)
	BEGIN
	INSERT  INTO  teacherssubjects (credits,  groupId,  teacherId)  VALUES (cred,  grp,  teacher);

END //

DELIMITER ;

/*RF-006*/

DELIMITER //

CREATE OR REPLACE PROCEDURE 
	DeleteGrades (studentDni CHAR(9)) 
	BEGIN
	DECLARE id INT;
	SET id = (SELECT studentId FROM Students WHERE dni=studentDni); 
	DELETE FROM Grades WHERE studentId=id;

END //

DELIMITER ;



/* BORRAR DATABASE*/

/*DELIMITER //

CREATE OR REPLACE PROCEDURE 
	DeleteData() 
	BEGIN
	SET FOREIGN_KEY_CHECKS = 0;
	DELETE  FROM  Degrees; 
	DELETE FROM Subjects; 
	DELETE FROM Groups;
	DELETE FROM Students; 
	DELETE FROM GroupsStudents; 
	DELETE FROM Grades;
	SET FOREIGN_KEY_CHECKS = 1;
	ALTER TABLE Degrees AUTO_INCREMENT=1; 
	ALTER TABLE Subjects AUTO_INCREMENT=1; 
	ALTER  TABLE  Groups  AUTO_INCREMENT=1; 
	ALTER TABLE Students AUTO_INCREMENT=1;
	ALTER TABLE GroupsStudents AUTO_INCREMENT=1; 
	ALTER  TABLE  Grades  AUTO_INCREMENT=1;

END // */

	