CREATE DATABASE Entregable3;

/*Procedimientos(test)*/

-- RF-001 funciona
CALL procedureGrades(4,'Extraordinaria',0,15,13);

-- RF-002 funciona
CALL procedureAppointmentsInformation(3,'Martes');

--RF-003 funciona
CALL procedureAssignTeacherToGroup(1,3,5);

--RF-006
CALL procedureDeleteGrades('87654321W');