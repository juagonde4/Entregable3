
/*Restricciones*/

-- RN-001
DELIMITER //
CREATE OR REPLACE TRIGGER triggerTeacherCreditLimit_insert
	BEFORE INSERT ON teachersSubjects
	FOR EACH ROW BEGIN
		DECLARE totalCredits INT;
		DECLARE total INT;
		SET totalCredits = (
			SELECT SUM(credits)
				FROM teachersSubjects,Groups
				WHERE teachersSubjects.groupId= Groups.groupsId AND
						teachersSubjects.teacherId = NEW.teacherId AND
						Groups.year = (SELECT YEAR FROM Groups WHERE
						Groups.groupId = new.groupId));
		SET total = totalCredits + new.credits;
		IF (total > 24) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un profesor no puede impartir
			 mas de 24 creditos por curso academico';
		END IF;
	END//
CREATE OR REPLACE TRIGGER triggerTeacherCreditLimit_update
	BEFORE UPDATE ON teachersSubjects
	FOR EACH ROW BEGIN
		DECLARE totalCredits INT;
		SET totalCredits =
			(SELECT SUM(credits)
				FROM teachersSubjects,Groups
				WHERE
					teachersSubjects.teacherId = new.teacherId AND
					Groups.groupId = teachersSubjects.groupId AND
					year = (SELECT year FROM Groups WHERE
					Groups.groupId = new.groupId));
					
		IF (totalCredits > 24) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'Un profesor no puede impartir mas de 24 creditos por curso academico';
		END IF;
	END //
DELIMITER;

--RN-003
DELIMITER //
CREATE OR REPLACE TRIGGER triggerProfesirPerteneceADepartamento_insert
	BEFORE INSERT ON TeachersGroups
	FOR EACH ROW BEGIN
		DECLARE subjectDepartment INT;
		DECLARE teacherDepartment INT;
		SET subjectDepartment = (SELECT departmentId 
				FROM Subjects,Groups
				WHERE Groups.groupId = new.groupId AND
						Subjects.subjectId = Groups.subjectId);
		SET teacherDepartment = (SELECT departmentId
				FROM Teacher
				WHERE Teachers.teacherId = new.teacherId);
		IF (subjectDepartment <> teacherDepartment) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
				'Los profesores que imparten una asignatura deben pertenecen
				al departamento que asumo la asignatura';
		END IF;
	END //
DELIMITER ;

--RN-005
DELIMITER //
CREATE OR REPLACE TRIGGER triggerCitaEnHorario_insert
		BEFORE INSERT ON Appointments
		FOR EACH ROW BEGIN
				DECLARE start TIME; 
				DECLARE end TIME;
				SET START = (SELECT startHour FROM tutorials
					WHERE tutorials.tutorialId = new.tutorialId);
				SET END = (SELECT endHour FROM tutorials WHERE tutorials.turotialId = newtutorialId);
				IF (new.hour < start OR start < new.hour) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
					'La hora de una cita debe estar entre la hora de comienzo y fin de la tutoría correspondiente';
				END IF;
		END //

CREATE OR REPLACE TRIGGER triggerCitaEnHorario_update 
	BEFORE UPDATE ON Appointments
	FOR EACH ROW BEGIN
		DECLARE start TIME; DECLARE end TIME;
		SET start =(SELECT startHour FROM tutorials
					WHERE tutorials.tutorialId = new.tutorialId);
		SET end =(SELECT endHour FROM tutorials
					WHERE tutorials.tutorialId = new.tutorialId);
		IF (new.hour < start OR start < new.hour) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'La hora de una cita debe estar entre la hora de comienzo y fin de la tutoría correspondiente';
		END IF;
	END // 		
DELIMITER ;


-- RN-006 DELIMITER //
CREATE OR REPLACE TRIGGER triggerWithHonours_insert BEFORE INSERT ON Grades
	FOR EACH ROW BEGIN
		IF (new.withHonours=1 AND new.value<9) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'Para obtener matrícula hay que sacar al menos un 9';
			END IF;
	END //
CREATE OR REPLACE TRIGGER triggerWithHonours_update BEFORE UPDATE ON Grades
	FOR EACH ROW BEGIN
		IF (new.withHonours=1 AND new.value<9.0) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'Para obtener matrícula hay que sacar al menos un 9';
			END IF;
	END //
DELIMITER;


-- RN-007 
DELIMITER //

CREATE OR REPLACE TRIGGER triggerUniqueGradesSubject_insert BEFORE INSERT ON Grades
	FOR EACH ROW BEGIN
		DECLARE thisSubject INT; 
		DECLARE groupYear INT; 
		DECLARE subjectGrades INT;
	   SET thisSubject = (SELECT Groups.subjectId FROM Groups
			WHERE Groups.groupId = new.groupId);
		SET groupYear = (SELECT Groups.year FROM Groups
			WHERE Groups.groupId = new.groupId);
		SET subjectGrades = (SELECT COUNT(*)
			FROM Grades, Groups WHERE (Grades.groupId = Groups.groupId 
						AND Grades.studentId = new.studentId 
						AND Grades.gradeCall = new.gradeCall 
						AND Groups.year = groupYear 
						AND Groups.subjectId = thisSubject));
		IF(subjectGrades > 0) THEN
			SIGNAL SQLSTATE '45000' SET message_text =
			'Un alumno no puede tener varias notas asociadas a
			la misma asignatura en la misma convocatoria, el mismo año';
		END IF;
	END //

CREATE OR REPLACE TRIGGER triggerUniqueGradesSubject_update BEFORE UPDATE ON Grades
	FOR EACH ROW BEGIN
		DECLARE thisSubject INT;
		DECLARE groupYear INT; 
		DECLARE subjectGrades INT; 
		SET thisSubject = (SELECT Groups.subjectId FROM Groups
			WHERE Groups.groupId = new.groupId);
		SET groupYear = (SELECT Groups.year FROM Groups
			WHERE Groups.groupId = new.groupId);
		SET subjectGrades = (SELECT COUNT(*)
			FROM Grades, Groups WHERE (Grades.groupId = Groups.groupId 
			AND Grades.studentId = new.studentId 
			AND Grades.gradeCall = new.gradeCall 
			AND Groups.year = groupYear 
			AND Groups.subjectId = thisSubject));
		IF(subjectGrades > 0) THEN
			SIGNAL SQLSTATE '45000' SET message_text =
			'Un alumno no puede tener varias notas asociadas a la misma 
			asignatura en la misma convocatoria, el mismo año';
		END IF;
	END // 
DELIMITER;

-- RN-008 DELIMITER //
CREATE OR REPLACE TRIGGER triggerRestriccionEdad_insert BEFORE INSERT ON Students
	FOR EACH ROW BEGIN
		DECLARE diferencia INT;
		SET diferencia = DATEDIFF(new.birthDate, DATE_SUB(CURDATE(), INTERVAL 16 YEAR));
		IF(new.accessMethod = 'Selectividad' AND diferencia > 0) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'Un alumno no puede acceder por selectividad teniendo menos de 16 años.';
		END IF;
	END //
CREATE OR REPLACE TRIGGER triggerRestriccionEdad_update BEFORE UPDATE ON Students
	FOR EACH ROW BEGIN
		DECLARE diferencia INT;
		SET diferencia = DATEDIFF(new.birthDate, DATE_SUB(CURDATE(), INTERVAL 16 YEAR));
		IF(new.accessMethod = 'Selectividad' AND diferencia > 0) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'Un alumno no puede acceder por selectividad teniendo menos de 16 años.';
		END IF;
	END // 
DELIMITER ;
	
-- RN-009 DELIMITER //
CREATE OR REPLACE TRIGGER triggerGradeStudentGroup_insert BEFORE INSERT ON Grades
	FOR EACH ROW BEGIN
		DECLARE isInGroup INT;
		SET isInGroup = (SELECT COUNT(*) FROM GroupsStudents
			WHERE studentId = new.studentId AND groupId = new.groupId);
		IF(isInGroup<1) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'Un alumno no puede tener notas en grupos a los que
			no pertenece';
		END IF;
	END //

CREATE OR REPLACE TRIGGER triggerGradeStudentGroup_update BEFORE UPDATE ON grades 
	FOR EACH ROW BEGIN
		DECLARE isInGroup INT;
		SET isInGroup = (SELECT COUNT(*) FROM GroupsStudents
			WHERE studentId = new.studentId AND groupId = new.groupId);
		IF(isInGroup<1) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
			'Un alumno no puede tener notas en grupos a los que
			no pertenece';
		END IF;
	END // 
DELIMITER ;

-- RN-010 DELIMITER //
CREATE OR REPLACE TRIGGER triggerGradesChangeDifference_update BEFORE UPDATE ON Grades
	FOR EACH ROW BEGIN
		DECLARE difference DECIMAL(4,2);
		DECLARE student ROW TYPE OF Students; 
		SET difference = new.value - old.value; 
		IF(difference > 4) THEN
			SELECT * INTO student FROM Students WHERE studentId = new.studentId;
		   SET @error_message = CONCAT('Al lumno ', student.firstName, ' ', student.surname,
      	 ' Se le ha intentado subir una nota en ', difference, ' puntos');
			SET new.value = old.value + 4; 
		END IF;
	END // 
DELIMITER ;

-- RN-022
CREATE OR REPLACE TRIGGER triggerTutorialHoursLimit BEFORE INSERT ON tutorials
	FOR EACH ROW BEGIN
		DECLARE hours = (SELECT SUM(endHour - startHour) FROM tutorials
			WHERE tutorials.teacherId = new.teacherId);
END //

--RN-019
 
DELIMITER //
 
CREATE OR REPLACE TRIGGER StudentsGroups_insert BEFORE INSERT ON groupsstudents 
	FOR EACH ROW BEGIN 
		DECLARE TeoryGroup INT;
		DECLARE LabGroup INT;
		SET TeoryGroup = ( SELECT activity FROM subjects, groups WHERE subjects.subjectId = groups.activity);
		SET LabGroup = (SELECT activity FROM subjects, groups WHERE subjects.subjectId = groups.activity);
		IF (TeoryGroup<>LabGroup) THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = ' Un alumno no puede pertenecer a más de un grupo de teoría y de laboratorio de una misma asignatura. ';
		END IF;
 
	END //

CREATE OR REPLACE TRIGGER StudentsGroups_update BEFORE INSERT ON groupsstudents 
	FOR EACH ROW BEGIN 
		DECLARE TeoryGroup INT;
		DECLARE LabGroup INT;
		SET TeoryGroup = ( SELECT activity FROM subjects, groups WHERE subjects.subjectId = groups.activity);
		SET LabGroup = (SELECT activity FROM subjects, groups WHERE subjects.subjectId = groups.activity);
		IF (TeoryGroup<>LabGroup) THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = ' Un alumno no puede pertenecer a más de un grupo de teoría y de laboratorio de una misma asignatura. ';
		END IF;

	END //

DELIMITER;



















