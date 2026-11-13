CREATE DATABASE subquery;
USE  subquery;

CREATE TABLE Student
( StudentID INT PRIMARY KEY,
StudentName VARCHAR (100),
Department VARCHAR (100),
Age INT,
Marks INT,
City VARCHAR (100)
);
INSERT INTO Student VALUES
(1, 'Rahul', 'CSE', 21, 85, 'Chennai'),
(2, 'Amit', 'ECE', 22, 72, 'Coimbatore'),
(3, 'Simran', 'CSE', 20, 92, 'Bengaluru'),
(4, 'Priya', 'IT', 23, 88, 'Mysuru'),
(5, 'Karan', 'ECE', 21, 65, 'Chennai'),
(6, 'Neha', 'IT', 22, 95, 'Bengaluru'),
(7, 'Arjun', 'CSE', 24, 78, 'Hyderabad'),
(8, 'Divya', 'ECE', 20, 81, 'Kochi'),
(9, 'Vikram', 'IT', 23, 88, 'Chennai'),
(10, 'Meera', 'MECH', 21, 70, 'Bengaluru');

CREATE TABLE Course
(CourseID INT PRIMARY KEY,
CourseName VARCHAR (100),
Department VARCHAR (100),
Credits INT,
Faculty VARCHAR (100)
);
INSERT INTO Course VALUES
(101, 'DBMS', 'CSE', 4, 'Kumar'),
(102, 'Python', 'CSE', 3, 'Ravi'),
(103, 'Networks', 'ECE', 4, 'Suresh'),
(104, 'Signals', 'ECE', 3, 'Priya'),
(105, 'Data Analytics', 'IT', 4, 'Anitha'),
(106, 'Machine Learning', 'IT', 4, 'Karthik'),
(107, 'Operating Systems', 'CSE', 3, 'Meena'),
(108, 'Java', 'IT', 3, 'Arjun'),
(109, 'Embedded Systems', 'ECE', 4, 'Divya'),
(110, 'Mathematics', 'MECH', 3, 'Ramesh');

CREATE TABLE Enrollment
(EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
Semester INT,
Grade VARCHAR (10)
);
ALTER TABLE Enrollment
MODIFY COLUMN Semester VARCHAR(20);
INSERT INTO Enrollment VALUES
(1001, 1, 101, 'Semester 1', 'A'),
(1002, 1, 102, 'Semester 1', 'B'),
(1003, 2, 103, 'Semester 1', 'B'),
(1004, 3, 101, 'Semester 1', 'A'),
(1005, 3, 107, 'Semester 2', 'A'),
(1006, 4, 105, 'Semester 1', 'A'),
(1007, 5, 104, 'Semester 1', 'C'),
(1008, 6, 106, 'Semester 2', 'A'),
(1009, 8, 109, 'Semester 2', 'B'),
(1010, 9, 108, 'Semester 1', 'A');

#1. Find students who scored more than the average marks of all students.
SELECT * FROM Student 
WHERE Marks > (SELECT AVG(Marks) FROM Student); 

#2. Find the student who scored the highest marks.
SELECT * FROM Student 
WHERE Marks = (SELECT MAX(Marks) FROM Student); 

#3. Find students who scored the same marks as Rahul.
SELECT * FROM Student 
WHERE Marks = (SELECT Marks FROM Student WHERE StudentName = 'Rahul');

#4. Find students who scored more marks than Amit.
SELECT * FROM Student 
WHERE Marks > (SELECT Marks FROM Student WHERE StudentName = 'Amit');

#5. Find students belonging to the same department as Simran.
SELECT * FROM Student 
WHERE Department = (SELECT Department FROM Student WHERE StudentName = 'Simran');

#6. Find students older than the average age of all students.
SELECT * FROM Student 
WHERE Age > (SELECT AVG(Age) FROM Student);

#7. Find the youngest student.
SELECT * FROM Student
WHERE Age = (SELECT MIN(Age) FROM Student);

#8. Find students whose marks are greater than the marks of every ECE student.
SELECT * FROM Student 
WHERE Marks > ALL (SELECT Marks FROM Student WHERE Department = 'ECE');

#9. Find students who scored higher than the average marks of their department.
SELECT * FROM Student S
WHERE Marks >  (SELECT AVG(Marks) FROM Student 
WHERE Department = S.Department);

#10. Find students who scored higher than at least one ECE student.
SELECT * FROM Student
WHERE Marks > ANY (SELECT Marks FROM Student WHERE Department = 'ECE');

#11. Find students belonging to departments whose average marks are 
#greater than 80.
SELECT * FROM Student
WHERE Department IN (SELECT Department FROM Student GROUP BY Department
HAVING AVG(Marks) > 80);

#12. Find students who are enrolled in the DBMS course.
SELECT * FROM Student 
WHERE StudentID IN (SELECT StudentID FROM Enrollment WHERE CourseID=
(SELECT CourseID FROM Course WHERE CourseName ='DBMS'));

#13. Find students enrolled in courses offered by the CSE department.
SELECT * FROM Student 
WHERE StudentID IN (SELECT StudentID FROM Enrollment 
WHERE CourseID IN (SELECT CourseID FROM Course
WHERE Department = 'CSE' ) );

#14. Find students who are enrolled in at least one IT course.
SELECT * FROM Student 
WHERE StudentID IN (SELECT StudentID FROM Enrollment 
WHERE CourseID IN (SELECT CourseID FROM Course
WHERE Department = 'IT' ) );

#15. Find students who are not enrolled in any ECE course.
SELECT * FROM Student 
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollment 
WHERE CourseID  IN (SELECT CourseID FROM Course
WHERE Department = 'ECE' ) );

#16. Find the second-highest marks.
SELECT MAX(Marks)
FROM Student
WHERE Marks < (SELECT MAX(Marks) FROM Student); 

#17. Find students who obtained the second-highest marks.
SELECT * FROM Student
WHERE Marks = (SELECT MAX(Marks) FROM Student
WHERE Marks < (SELECT MAX(Marks) FROM Student));

#18. Find students who scored the highest marks in their department.
SELECT * FROM Student S 
WHERE Marks =  (SELECT MAX(Marks) FROM Student 
WHERE Department = S.Department);

#19. Find students whose marks are greater 
#than the average marks of students enrolled in DBMS.
SELECT * FROM Student
WHERE Marks > (SELECT AVG(Marks) FROM Student
WHERE StudentID IN (SELECT StudentID FROM Enrollment
WHERE CourseID = (SELECT CourseID FROM Course
WHERE CourseName = 'DBMS')));

#20. Find students who are enrolled in more courses than Amit.
SELECT * FROM Student
WHERE (SELECT COUNT(*) FROM Enrollment
WHERE Enrollment.StudentID = Student.StudentID) > (SELECT COUNT(*) FROM Enrollment
WHERE StudentID = (SELECT StudentID FROM Student
WHERE StudentName = 'Amit'));

#21. Find students who are enrolled in at least one course.
SELECT * FROM Student
WHERE StudentID IN (SELECT StudentID FROM Enrollment);

#22. Find students who are not enrolled in any course.
SELECT * FROM Student
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollment);

#23. Find courses that have at least one student enrolled.
SELECT * FROM Course
WHERE CourseID IN (SELECT CourseID FROM Enrollment);

#24. Find courses in which no student is enrolled.
SELECT * FROM Course
WHERE CourseID NOT IN (SELECT CourseID FROM Enrollment);
	





