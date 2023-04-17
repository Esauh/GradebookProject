### Completed Task Report

# *SQl Commands for Task 2*
```
#Instantiates Course Table (PK: course_id)
create table course(
course_id int primary key,
department varchar(255) not null,
course_number int not null,
course_name varchar(255) not null,
semester varchar(255) not null,
year int not null);

#Instantiates Student Table (PK: student_id FK: course_id from Course)
create table Student(
student_id int primary key,
first_name varchar(255) not null,
last_name varchar(255) not null,
course_id int not null,
foreign key (course_id) references Course(course_id));

#Instantiates Assignment Table (PK: assignment_id FK: course_id from Course)
create table Assignment(
assignment_id int primary key,
category varchar(255) not null, 
percentage decimal(5,2),
course_id int,
foreign key (course_id) references Course(course_id));

#Instantiates Grade Table (PK: grade_id FK: student_id from Student & assignment_id from Assignment)
create table Grade(
grade_id int primary key,
score decimal(5,2),
assignment_id int,
student_id int,
foreign key (assignment_id) references Assignment(assignment_id),
foreign key (student_id) references Student(student_id));

#Inserting one course into the Course Table
insert into Course values(1, 'Electical Engineering', 200, 'Principles of Eletronics', 'Spring', 2023);

#Inserting various students into students table
insert into Student values
(1, 'Darius', 'Quinton', 1), 
(2, 'Alex', 'Smith', 1),
(3, 'Chad', 'Johnson', 1),
(4, 'Sally', 'Fullman',1);

insert into Assignment values
(1, 'Participation',10.0, 1),
(2, 'Homework', 20.0, 1),
(3, 'Tests', 50.0, 1),
(4, 'Projects', 20.0, 1);

insert into Grade values
#Grades for Darius (student_id=1)
(1, 10.0, 1, 1),
(2, 98.0, 2, 1),
(3, 99.0, 3, 1),
(4, 80.0, 4, 1),
#Grades for Alex
(5, 8.0, 1, 2),
(6, 80.0, 2, 2),
(7, 75.0, 3, 2),
(8, 70.0, 4, 2),
#Grades for Chad
(9, 7.0, 1, 3),
(10, 73.0, 2, 3),
(11, 95.0, 3, 3),
(12, 80.0, 4, 3),
#Grades for Sally
(13, 9.5, 1, 4),
(14, 93.0, 2, 4),
(15, 97.0, 3, 4),
(16, 100.0, 4, 4);
```
# *The Tables with contents filled for Task 3*

# *SQL Commands for Task 4-12*

**Task 4**

**Task 5**

**Task 6**

**Task 7**

**Task 8**

**Task 9**

**Task 10**

**Task 11**

**Task 12**


