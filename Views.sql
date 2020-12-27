

/RF-037/
CREATE OR REPLACE VIEW TeacherCreditsSubjects AS 
SELECT teachers.firstName, surname, YEAR, SUM(credits) totalCredits
FROM teachers, teacherssubjects, groups
WHERE teacherssubjects.teacherId = teachers.teacherId AND teacherssubjects.subjectId = groups.subjectId
GROUP BY teachers.teacherId;

/RF-036/
CREATE OR REPLACE VIEW StudentsList AS 
SELECT students.surname, students.firstName, subjects.name SubjectName, groups.name GroupName
FROM students, groupsstudents, groups, subjects
WHERE students.studentId = groupsstudents.studentId AND groupsstudents.groupId = groups.groupId AND groups.subjectId = subjects.subjectId
ORDER BY surname;

/RF-008/
CREATE OR REPLACE VIEW OlderStudents AS 
SELECT surname, firstName
FROM students
WHERE accessMethod = 'Mayor';

/RF-009/
CREATE OR REPLACE VIEW SubjectsGradesYear AS 
SELECT NAME, acronym, credits, TYPE
FROM subjects
WHERE degreeId = 1 AND course = 2;


