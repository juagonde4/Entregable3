

DELIMITER //

/* FUNCIONES */
--RF-005
CREATE OR REPLACE FUNCTION funcionTeacherMostCredits(sub INT,yeari INT)
RETURN INT
	BEGIN
	DECLARE res INT;
	DECLARE cred INT;
	SELECT teachersSubjects.teacherId,SUM(teachersSubjects.credits) sumi INTO
res,cred
		FROM teachersSubjects.Groups
		WHERE
			teachersSubjects.groupId=Groups.groupId AND
			Groups.subjectId = sub AND
			Groups.year = yeari
		ORDER BY sumi DESC
		LIMIT 1;

		
--RF-011
CREATE OR REPLACE FUNCTION avgGrade(studentId INT) RETURNS DOUBLE
	BEGIN
		RETURN(SELECT AVG(value)
					FROM Grades
					WHERE Grades.studentId = studentId);
					
		END //
		
DELIMITER;