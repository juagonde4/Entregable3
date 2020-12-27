CREATE DATABASE Entregable3;

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM degrees;
DELETE FROM Subjects; 
DELETE FROM Groups;
DELETE FROM students;
DELETE FROM GroupsStudents;
DELETE FROM Grades;

SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE Degrees AUTO_INCREMENT=1; 
ALTER TABLE Subjects AUTO_INCREMENT=1; 
ALTER TABLE Groups AUTO_INCREMENT=1; 
ALTER TABLE Students AUTO_INCREMENT=1;
ALTER TABLE GroupsStudents AUTO_INCREMENT=1; 
ALTER TABLE Grades AUTO_INCREMENT=1;

/* Datos de Prueba */
INSERT INTO Degrees (name, years) 
VALUES ('Ingeniería del Software', 4), ('Ingeniería del Computadores', 4), ('Tecnologías Informáticas', 4);

/* Datos de Prueba */
INSERT INTO Departments(NAME) 
VALUES ('Lenguajes y Sistemas Informáticos'); 
INSERT INTO Departments(NAME) 
VALUES ('Tecnología Electrónica');
INSERT INTO Departments(NAME) 
VALUES ('Matemáticas Aplicadas');

/* Datos de Prueba */
INSERT INTO Subjects (name, acronym, credits, course, type, degreeId, departmentId) 
VALUES('Diseño y Pruebas', 'DP', 12, 3, 'Obligatoria', 1, 1),
('Acceso Inteligente a la Informacion', 'AII', 6, 4, 'Optativa', 1,1),
('Optimizacion de Sistemas', 'OS', 6, 4, 'Optativa', 1, 1),
('Ingeniería de Requisitos', 'IR', 6, 2, 'Obligatoria', 1, 1), 
('Análisis y Diseño de Datos y Algoritmos', 'ADDA', 12, 2,'Obligatoria', 1, 1),
('Introducción a la Matematica Discreta', 'IMD', 6, 1, 'Formacion Basica', 2, 3),
('Redes de Computadores', 'RC', 6, 2, 'Obligatoria', 2, 2),
('Teoría de Grafos', 'TG', 6, 3, 'Obligatoria', 2, 3),
('Aplicaciones de Soft Computing', 'ASC', 6, 4, 'Optativa', 2, 2),
('Fundamentos de Programación', 'FP', 12, 1, 'Formacion Basica', 3,1),
 ('Lógica Informatica', 'LI', 6, 2, 'Optativa', 3, 1),
('Gestión y Estrategia Empresarial', 'GEE', 90, 3, 'Optativa', 3, 2),
('Trabajo de Fin de Grado', 'TFG', 12, 4, 'Obligatoria', 3, 3);

/* Datos de Prueba */

INSERT INTO Classrooms(name, floor, capacity, loudspeakers, proyector) VALUES (
'2_C10', 2, 60, TRUE, FALSE);
INSERT INTO Classrooms(name, floor, capacity, loudspeakers, proyector) VALUES (
'1_C08', 1, 40, FALSE, FALSE);
INSERT INTO Classrooms(name, floor, capacity, loudspeakers, proyector) VALUES (
'2_O03', 2, 65, TRUE, TRUE);

/* Datos de Prueba */
INSERT INTO Groups (name, activity, year, subjectId, classroomId) VALUES ('T1', 'Teoria', 2018, 1, 1),
('T2', 'Teoria', 2018, 2, 2),
('L1', 'Laboratorio', 2018, 3, 3),
('L2', 'Laboratorio', 2018, 4, 1),
('L3', 'Laboratorio', 2018, 5, 2),
('T1', 'Teoria', 2019, 6, 3),
('T2', 'Teoria', 2019, 7, 1),
('L1', 'Laboratorio', 2019, 8, 2),
('L2', 'Laboratorio', 2019, 9, 3),
('Teor1', 'Teoria', 2018, 2, 1),
('Teor2', 'Teoria', 2018, 2, 2),
('Lab1', 'Laboratorio', 2018, 2, 3),
('Lab2', 'Laboratorio', 2018, 2, 1),
('Teor1', 'Teoria', 2019, 2, 2),
('Lab1', 'Laboratorio', 2019, 2, 3),
('Lab2', 'Laboratorio', 2019, 2, 2),
('T1',	'Teoria', 2019,	10,	1),	
('T2',	'Teoria', 2019,	10,	2),	
('T3',	'Teoria', 2019,	10,	3),	
('L1',	'Laboratorio',	2019,	10,	1),
('L2',	'Laboratorio',	2019,	10,	2),
('L3',	'Laboratorio',	2019,	10,	3),
('L4',	'Laboratorio',	2019,	10,	1),
('Clase', 'Teoria', 2019, 12, 3);

/* Datos de Prueba */
INSERT INTO Students (accessMethod, dni, firstname, surname, birthdate, email) VALUES
('Selectividad', '12345678A', 'Daniel', 'Pérez', '1991-01-01', 'daniel@alum.us.es'),
('Selectividad', '22345678A', 'Rafael', 'Ramírez', '1992-01-01', 'rafael@alum.us.es'),
('Selectividad', '32345678A', 'Gabriel', 'Hernández', '1993-01-01', 'gabriel@alum.us.es'),
('Selectividad', '42345678A', 'Manuel', 'Fernández', '1994-01-01', 'manuel@alum.us.es'),
('Selectividad', '52345678A', 'Joel', 'Gómez', '1995-01-01', 'joel@alum.us.es'),
('Selectividad', '62345678A', 'Abel', 'López', '1996-01-01', 'abel@alum.us.es'),
('Selectividad', '72345678A', 'Azael', 'González', '1997-01-01', 'azael@alum.us.es'),
('Selectividad', '82345678A', 'Uriel', 'Martínez', '1998-01-01', 'uriel@alum.us.es'),
('Selectividad', '92345678A', 'Gael', 'Sánchez', '1999-01-01', 'gael@alum.us.es'),
('Titulado Extranjero', '12345678B', 'Noel', 'Álvarez', '1991-02-02', 'noel@alum.us.es'),
('Titulado Extranjero', '22345678B', 'Ismael', 'Antúnez', '1992-02- 02', 'ismael@alum.us.es'),
('Titulado Extranjero', '32345678B', 'Nathanael', 'Antolinez', '1993- 02-02', 'nathanael@alum.us.es'),
('Titulado Extranjero', '42345678B', 'Ezequiel', 'Aznárez', '1994-02- 02', 'ezequiel@alum.us.es'),
('Titulado Extranjero', '52345678B', 'Ángel', 'Chávez', '1995-02-02', 'angel@alum.us.es'),
('Titulado Extranjero', '62345678B', 'Matusael', 'Gutiérrez', '1996- 02-02', 'matusael@alum.us.es'),
('Titulado Extranjero', '72345678B', 'Samael', 'Gálvez', '1997-02-02', 'samael@alum.us.es'),
('Titulado Extranjero', '82345678B', 'Baraquiel', 'Ibáñez', '1998-02- 02', 'baraquiel@alum.us.es'),
('Titulado Extranjero', '92345678B', 'Otoniel', 'Idiáquez', '1999-02- 02', 'otoniel@alum.us.es'),
('Titulado Extranjero', '12345678C', 'Niriel', 'Benítez', '1991-03- 03', 'niriel@alum.us.es'),
('Titulado Extranjero', '22345678C', 'Múriel', 'Bermúdez', '1992-03- 03', 'muriel@alum.us.es'),
('Titulado Extranjero', '32345678C', 'John', 'AII', '2000-01-01', 'john@alum.us.es'),
('Mayor', '09870987Z', 'Pepita', 'Palos', '2000-01-01',
'pepitapalos@alum.us.es');


/* Datos de Prueba */
INSERT INTO GroupsStudents (groupId, studentId) 
VALUES (1, 1),(3, 1),(7, 1),(8, 1),(10, 1),
(12, 1),(2, 2),(3, 2),(10, 2),(12, 2),
(18, 21),(21, 21);


/* Datos de Prueba */
INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES (4.50, 'Primera', 0, 1, 1),
(3.25, 'Segunda', 0, 1, 2),
(9.95, 'Primera', 0, 1, 7),
(7.50, 'Primera', 0, 1, 10),
(2.50, 'Primera', 0, 2, 1),
(5.00, 'Segunda', 0, 2, 2),
(10.00, 'Primera', 1, 2, 10),
(0.00, 'Primera', 0, 21, 16),
(1.25, 'Segunda', 0, 21, 17),
(0.50, 'Tercera', 0, 21, 18);

/* Datos de Prueba */
INSERT INTO Spaces(name, floor, capacity) VALUES ('1_O15', 1, 1); 
INSERT INTO Spaces(name, floor, capacity) VALUES ('1_O02', 1, 2); 
INSERT INTO Spaces(name, floor, capacity) VALUES ('4_O11', 4, 1);

/* Datos de Prueba */
INSERT INTO Teachers(dni, NAME, surnames, birthDate, email, category, departmentId, officeId) VALUES (
'72240642A','Ana','Amor Moreno', '1975:02:28','anadelasrosas@gmail.com', 'Catedratico',1,1);
INSERT INTO Teachers(dni, NAME, surnames, birthDate, email, category, departmentId, officeId) VALUES (
'25752708M','Mario', 'Martín Mula', '1965:12:20','mmmula@us.es','Titular de Universidad', 2,2);
INSERT INTO Teachers(dni, NAME, surnames, birthDate, email, category, departmentId, officeId) VALUES (
'37720784R','Rocío','Rueda Ramírez', '1991:04:14','rociorura@gmail.com', 'Profesor Contratado Doctor', 3,1);

/* Datos de Prueba */
INSERT INTO tutorials(weekDay, startHour, endHour, teacherId) VALUES ( 
'Lunes','11:15','12:40',2);
INSERT INTO tutorials(weekDay, startHour, endHour, teacherId) VALUES (
'Miercoles','11:45','13:00',2);
INSERT INTO tutorials(weekDay, startHour, endHour, teacherId) VALUES ( 
'Martes','10:00','10:50',1);


/* Datos de Prueba */
INSERT INTO Appointments(date, hour, mentoryId, studentId) VALUES ( 
'2019:11:04','11:20',1,1);
INSERT INTO Appointments(date, hour, mentoryId, studentId) VALUES ( 
'2019:11:04','12:00',2,3);
INSERT INTO Appointments(date, hour, mentoryId, studentId) VALUES ( 
'2019:11:07','10:15',3,2);

/* Datos de Prueba */
INSERT INTO TeachersGroups(credits, groupId, teacherId) VALUES
(6,	1,	1),
(6,	2,	1),
(6,	3,	2),
(6,	4,	2),
(6,	5,	3),
(6,	6,	3);



