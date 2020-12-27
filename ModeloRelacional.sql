CREATE DATABASE modelo_relacional


Degrees(degreeId,name,years)PK(degreeId)AK(name)
Departments(departmentId,name)PK(departmentId)AK(name)
Subjects(subjectId,degreeId,departmentId,name ,acronym,credits,course,type)PK(subjectId)
AK(name,acronym) FK(degreeId,departmentId)
Spaces(spaceId,name,floor,capacity) PK(spaceId) AK(name)
Offices(officeId,spaceId,isShared,isThereFreeSpace) PK(spaceId)AK(name)
Classrooms(classroomId,spaceId,loudspeakers,proyector)PK(classroomId)FK(spaceId)
Groups(groupId,subjectId,classroomId,name,activity,year)PK(groupId)FK(subjectId,classroomId)
Students(studentId,accessMethod,dni,firstName,surname,birthDate,email) PK(studentId) AK(dni,email)
groupsstudents(groupStudentId,groupId,studentId)PK(groupStudentId)FK(groupId,studentId)
Grades(gradeId,studentId,groupId,value,gradeCall,withHonours) PK(gradeId) FK(groupId,studentId)
Teachers(teacherId,officeId,departmentId,dni,firstName,surname,birthDate,email,category) PK(teacherId)
AK(dni,email) FK(officeId,departmentId)
teacherssubjects(teacherSubjectId,teachingLoad,teacherId,subjectId) PK(teacherSubjectId) 
FK(teacherId,subjectId)
Tutorials(tutorialId,teacherId,dayWeek,startTime,endTime) PK(tutorialId) FK(teacherId)
Appointments(appointmentId,tutorialId,studentId,dateAppointment,hourAppointment) PK(appointmentId)
FK(tutorialId,studentId)








