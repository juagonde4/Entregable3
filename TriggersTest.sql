/*Probar triggers */

--RN-001 
INSERT INTO teacherssubjects(credits,groupId,teacherId) 
VALUES (25,24,2);
INSERT INTO teacherssubjects(credits,groupId,teacherId) 
VALUES (25,9,2);
INSERT INTO teacherssubjects(credits,groupId,teacherId) 
VALUES (6,24,2);
UPDATE teacherssubjects SET credits = 25 WHERE teacherssubjects =13;

-- RN-003
INSERT INTO teacherssubjects(credits,groupId,teacherId) 
VALUES (6,24,1);
INSERT INTO teacherssubjects(credits,groupId,teacherId) 
VALUES (6,24,2);
UPDATE teacherssubjects SET teacherId = 1 WHERE teacherSubjectId = 7;

--RN-005
INSERT INTO appointments(DATE,HOUR,tutorialId,studentId)
VALUES ('2019-11-04','11:00:00',1,1);
INSERT INTO appointments(DATE,HOUR,tutorialId,studentId)
VALUES ('2019-11-04','11:30:00',1,1);
UPDATE appointments SET HOUR = '11:00:00' WHERE appointmentId =4;

--RN-006
INSERT INTO grades (VALUE,gradeCall,withHonours,studentId,groupId)
VALUES(1,'Extraordinaria',1,1,10);
INSERT INTO grades (VALUE,gradeCall,withHonours,studentId,groupId)
VALUES(10,'Extraordinaria',1,1,10);
UPDATE grades SET VALUE = 1 WHERE gradeId=11;

--RN-007
INSERT INTO grades (VALUE,gradeCall,withHonours,studentId,groupId)
VALUES(1,'Primera',0,1,8);
INSERT INTO grades (VALUE,gradeCall,withHonours,studentId,groupId)
VALUES(1,'Segunda',0,1,12);
UPDATE grades SET gradeCall = 'Primera' WHERE gradeId = 12;

--RN-008
INSERT INTO students (dni,firstName,surname,birthDate,email,accessMethod)
VALUES ('01234567A','Pepito','Palos','2018-01-01','pepito@gmail.com','Selectividad');
INSERT INTO students (dni,firstName,surname,birthDate,email,accessMethod)
VALUES ('01234567A','Pepito','Palos','2000-01-01','pepito@gmail.com','Selectividad');
UPDATE students SET birthDate = '2018-01-01' WHERE studentId = 24;

--RN-009
INSERT INTO grades (VALUE,gradeCall,withHonours,studentId,groupId)
VALUES(1,'Primera',0,20,1);
INSERT INTO grades (VALUE,gradeCall,withHonours,studentId,groupId)
VALUES(1,'Primera',0,1,12);
UPDATE grades SET groupId =23 WHERE gradeId =1;


--RN-010
UPDATE grades SET VALUE = 10 WHERE gradeId = 1;