DROP TABLE if EXISTS appointments;
DROP TABLE if EXISTS tutorials;
DROP TABLE if EXISTS teachersSubjects;
DROP TABLE if EXISTS teachers;
DROP TABLE if EXISTS grades;
DROP TABLE if EXISTS groupsStudents;
DROP TABLE if EXISTS students;
DROP TABLE if EXISTS groups;
DROP TABLE if EXISTS classrooms;
DROP TABLE if EXISTS offices;
DROP TABLE if EXISTS spaces;
DROP TABLE if EXISTS subjects;
DROP TABLE if EXISTS departments;
DROP TABLE if EXISTS degrees;


-- Tabla de grados
CREATE TABLE degrees(
degreeId INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL UNIQUE,
years INT DEFAULT (4) NOT NULL,
PRIMARY KEY(degreeId),
CONSTRAINT invalidDegreeYear CHECK (years>= 3 AND years <=6)
); 

/*Datos prueba*/
INSERT INTO DEGREES(name, years) VALUES('Grado en Ingenieria Informatica-
Tecnologias Informaticas',4);
INSERT INTO DEGREES(name, years) VALUES('Grado en Ingenieria Informatica-
Ingenieria del Software',4);
INSERT INTO DEGREES(name, years) VALUES('Grado en Ingenieria Informatica-
Ingenieria del Computadores',4);

-- Tabla de Departamentos
CREATE TABLE Departments(departmentId INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL UNIQUE, PRIMARY KEY(departmentId));

/* Datos de prueba*/

INSERT INTO Departments(name) VALUES('Ciencias de la Computacion e 
Inteligencia artificial');
INSERT INTO Departments(name) VALUES('Lenguajes y sistemas informaticos');
INSERT INTO Departments(name) VALUES('Matematica Aplicada I');


-- Tabla de Asignaturas
CREATE TABLE Subjects(subjectId INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL UNIQUE,
acronym VARCHAR(8) NOT NULL UNIQUE,
credits INT NOT NULL,
course INT NOT NULL,
type VARCHAR(20) NOT NULL,
degreeId INT NOT NULL,
departmentId INT, PRIMARY KEY(subjectId),
FOREIGN KEY(degreeId) REFERENCES Degrees(degreeId) ON DELETE CASCADE,
FOREIGN KEY (departmentId) REFERENCES Departments(departmentId) ON DELETE SET NULL,
CONSTRAINT negativeSubjectCredits CHECK (credits > 0 ),
CONSTRAINT invalidSubjectCourse CHECK(course > 0 AND course < 6),
CONSTRAINT invalidSubjectType CHECK (type IN ('Formacion Basica','Optativa','Obligatoria')));

/* Datos de Prueba*/
INSERT INTO Subjects(name ,acronym,credits,course,type,degreeId,departmentId) 
VALUES ('Inteligencia Artificial','IA',6,3,'Obligatoria',1,1);
INSERT INTO Subjects(name ,acronym,credits,course,type,degreeId,departmentId) 
VALUES ('Diseño de Sistemas Digitales','DSD',6,2,'Obligatoria',2,2);
INSERT INTO Subjects(name ,acronym,credits,course,type,degreeId,departmentId) 
VALUES ('Tecnologia de Computadores','TC',6,2,'Obligatoria',3,3);

-- Tabla de Espacios
CREATE TABLE Spaces(spaceId INT NOT NULL AUTO_INCREMENT,name VARCHAR(100)NOT NULL UNIQUE,
FLOOR INT NOT NULL, capacity INT NOT NULL,
PRIMARY KEY(spaceId),
CONSTRAINT invalidCapacity CHECK(capacity > 0));

/*Datos de Prueba*/
INSERT INTO Spaces(name,floor,capacity) VALUES('A2.10',2,70);
INSERT INTO Spaces(name,floor,capacity) VALUES('H1.10',1,60);
INSERT INTO Spaces(name,floor,capacity) VALUES('G1.30',1,25);

-- Tabla de Despachos
CREATE TABLE Offices(officeId INT AUTO_INCREMENT,isShared BOOLEAN NOT NULL,
isThereFreeSpace BOOLEAN NOT NULL,
spaceId INT,
PRIMARY KEY(officeId),
FOREIGN KEY (spaceId) REFERENCES spaces (spaceId) ON DELETE CASCADE ON UPDATE CASCADE);

/*Datos de Prueba*/
INSERT INTO Offices(isShared,isThereFreeSpace,spaceId) VALUES (0,0,2);

-- Tabla de Aulas
CREATE TABLE Classrooms(classroomId INT NOT NULL AUTO_INCREMENT,
loudspeakers BOOLEAN NOT NULL,
proyector BOOLEAN NOT NULL,
spaceId INT NOT NULL,
PRIMARY KEY(classroomId),
FOREIGN KEY (spaceId) REFERENCES Spaces(spaceId) ON DELETE CASCADE ON UPDATE CASCADE);

/* Datos de Prueba*/
INSERT INTO Classrooms(loudspeakers,proyector,spaceId) VALUES (0,1,1);
INSERT INTO Classrooms(loudspeakers,proyector,spaceId) VALUES (1,1,2);
INSERT INTO Classrooms(loudspeakers,proyector,spaceId) VALUES (0,0,3);

-- Tabla de Grupos
CREATE TABLE Groups(groupId INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL, activity VARCHAR(20) NOT NULL,
year INT NOT NULL,
subjectId INT NOT NULL, classroomId INT,
PRIMARY KEY(groupId),
FOREIGN KEY(subjectId) REFERENCES subjects (subjectId)ON DELETE CASCADE,
FOREIGN KEY(classroomId) REFERENCES classrooms (classroomId)ON DELETE SET NULL,
UNIQUE (name ,year ,subjectId),
CONSTRAINT negativeGroupYear CHECK (year> 0),
CONSTRAINT invalidGroupActivity CHECK (activity IN ('Teoria','Laboratorio')));

/*Datos de Prueba*/
INSERT INTO Groups(name ,activity,year ,subjectId,classroomId) 
VALUES('1','Laboratorio',2020, 1,1);
INSERT INTO Groups(name ,activity,year ,subjectId,classroomId) 
VALUES('2','Teoria',2020, 1,2);

-- Tabla de Alumos
CREATE TABLE Students(studentId INT NOT NULL AUTO_INCREMENT,
accessMethod VARCHAR(30)NOT NULL,
dni CHAR(9) NOT NULL UNIQUE,
firstName VARCHAR(100) NOT NULL,
surname VARCHAR(100) NOT NULL,
birthDate DATE NOT NULL,
email VARCHAR(250) NOT NULL UNIQUE,
PRIMARY KEY (studentId),
CONSTRAINT invalidStudentAccessMethod 
CHECK (accessMethod IN('Selectividad','Ciclo','Mayor','Titulado Extranjero')));

/* Datos de Prueba*/
INSERT INTO Students(accessMethod,dni,firstName,surname,birthDate,email)
VALUES('Selectividad','87654321W','Pepe','Pérez','1999-05-29','pepeperez@alum.us.es');
INSERT INTO Students(accessMethod,dni,firstName,surname,birthDate,email)
VALUES('Ciclo','13456789R','Marta','Miñam','1997-03-02','martamiñan@alum.us.es');



-- Tabla de GruposAlumnos
CREATE TABLE GroupsStudents(groupStudentId INT NOT NULL AUTO_INCREMENT,
groupId INT NOT NULL,
studentId INT NOT NULL,
PRIMARY KEY(groupStudentId),
FOREIGN KEY(groupId) REFERENCES groups (groupId) ON DELETE CASCADE,
FOREIGN KEY(studentId) REFERENCES students( studentId) ON DELETE CASCADE,
UNIQUE (groupId,studentId));

/*Datos de Prueba*/
INSERT INTO GroupsStudents(groupId,studentId) VALUES(1,1);
INSERT INTO GroupsStudents(groupId,studentId) VALUES(1,2);
INSERT INTO GroupsStudents(groupId,studentId) VALUES(2,1);
INSERT INTO GroupsStudents(groupId,studentId) VALUES(2,2);


-- Tabla de Notas
CREATE TABLE Grades(
	gradeId INT NOT NULL AUTO_INCREMENT,
	value DECIMAL(4,2) NOT NULL,
	gradeCall INT NOT NULL,
	withHonours BOOLEAN NOT NULL,
	studentId INT NOT NULL,
	groupId INT NOT NULL,
	PRIMARY KEY(gradeId),
	FOREIGN KEY(studentId) REFERENCES students (studentId) ON DELETE CASCADE,
	FOREIGN KEY(groupId) REFERENCES  groups (groupId) ON DELETE CASCADE,
	CONSTRAINT invalidGradeValue CHECK (value >= 0 AND value <= 10),
	CONSTRAINT invalidGradeCall CHECK (gradeCall >= 1 AND gradeCall <= 3),
	CONSTRAINT duplicatedCallGrade UNIQUE (gradeCall, studentId, groupId),
	CONSTRAINT invalidWithHonours CHECK (NOT withHonours OR value >= 9));

/*Datos de Prueba*/
INSERT INTO Grades(value , gradeCall,withHonours,studentId,groupId) 
VALUES(5,1,0,2,1);
INSERT INTO Grades(value , gradeCall,withHonours,studentId,groupId) 
VALUES(6.5,1,0,1,2);
INSERT INTO Grades(value , gradeCall,withHonours,studentId,groupId) 
VALUES(9,2,1,2,1);

/*Tabla de Profesores*/

CREATE TABLE Teachers(teacherId INT NOT NULL AUTO_INCREMENT,
dni CHAR(9) NOT NULL UNIQUE,
firstName VARCHAR(100)NOT NULL,
surname VARCHAR(100) NOT NULL,
birthDate DATE NOT NULL,
email VARCHAR(250) NOT NULL UNIQUE,
category VARCHAR(30) NOT NULL,
officeId INT,
departmentId INT,
PRIMARY KEY (teacherId),
FOREIGN KEY(officeId) REFERENCES offices (officeId) ON DELETE SET NULL,
FOREIGN KEY(departmentId) REFERENCES departments(departmentId) ON DELETE SET NULL,
CONSTRAINT invalidTeacherCategory CHECK (category IN ('Profesor','Titular de Universidad',
'Profesor Contratado Doctor','Profesor Ayudante Doctor')));

/*Datos de Prueba*/
INSERT INTO Teachers(dni,firstName,surname,birthDate,email,category,officeId,departmentId)
VALUES('43652797W','Antonio','Romero','1960-04-13','antonioRomero@us.es','Titular de Universidad',1,2);

/*Tabla de Profesores_Asignaturas*/

CREATE TABLE TeachersSubjects(teacherSubjectId INT NOT NULL AUTO_INCREMENT,
	teachingLoad INT NOT NULL,
	teacherId INT NOT NULL,
	subjectId INT NOT NULL,
	PRIMARY KEY(teacherSubjectId),
	FOREIGN KEY(teacherId) REFERENCES teachers(teacherId) ON DELETE CASCADE,
	FOREIGN KEY (subjectId) REFERENCES subjects(subjectId) ON DELETE CASCADE);

/*Datos de Prueba*/
INSERT INTO TeachersSubjects(teachingLoad,teacherId,subjectId)
VALUES(2,1,2);

/*Tabla de Tutorias*/
CREATE TABLE Tutorials(tutorialId INT NOT NULL AUTO_INCREMENT,
dayWeek VARCHAR(100) NOT NULL,
startTime TIME NOT NULL,
endTime TIME NOT NULL,
teacherId INT,
PRIMARY KEY(tutorialId),
FOREIGN KEY(teacherId) REFERENCES teachers(teacherId)ON DELETE SET NULL,
CONSTRAINT invalidTutorialWeekday CHECK (dayWeek IN ('Lunes','Martes','Miercoles','Jueves','Viernes')));

/*Datos de Prueba*/
INSERT INTO Tutorials(dayWeek,startTime,endTime,teacherId)
VALUES('Viernes','08:00:00','10:00:00',1);
INSERT INTO Tutorials(dayWeek,startTime,endTime,teacherId)
VALUES('Miercoles','09:30:00','12:00:00',1);
INSERT INTO Tutorials(dayWeek,startTime,endTime,teacherId)
VALUES('Lunes','11:00:00','13:00:00',1);


/*Tabla de Citas*/
CREATE TABLE Appointments(appointmentId INT NOT NULL AUTO_INCREMENT,
dateAppointment DATE NOT NULL,
hourAppointment TIME NOT NULL,
tutorialId INT NOT NULL,
studentId INT NOT NULL,
PRIMARY KEY(appointmentId),
FOREIGN KEY(tutorialId)REFERENCES tutorials(tutorialId) ON DELETE CASCADE,
FOREIGN KEY (studentId) REFERENCES students(studentId) ON DELETE CASCADE,
UNIQUE(dateAppointment,hourAppointment));

/*Datos de Prueba*/
INSERT INTO Appointments(dateAppointment,hourAppointment,tutorialId,studentId)
VALUES ('2020-11-27','08:00:00',1,2);





