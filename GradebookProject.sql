create database gradebook;

use gradebook;

#Instantiates Course Table (PK: course_id)
create table course(
course_id int primary key,
department varchar(255),
course_number int,
course_name varchar(255),
semester varchar(255),
year int);

#Instantiates Student Table (PK: student_id FK: course_id from Course)
create table Student(
student_id int primary key,
first_name varchar(255),
last_name varchar(255),
course_id int,
foreign key (course_id) references Course(course_id));

#Instantiates Assignment Table (PK: assignment_id FK: course_id from Course)
create table Assignment(
assignment_id int primary key,
category varchar(255), 
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

#Un commenting and executing line below will all data inserted into Course Table  
select * from Course

#Inserting various students into students table
insert into Student values
(1, 'Darius', 'Quinton', 1), 
(2, 'Alex', 'Smith', 1),
(3, 'Chad', 'Johnson', 1),
(4, 'Sally', 'Fullman',1);

# Un commenting and executing line below will show all student data inserted into the Student Table
#select * from Student

insert into Assignment values
(1, 'Participation',10.0, 1),
(2, 'Homework', 20.0, 1),
(3, 'Tests', 50.0, 1),
(4, 'Projects', 20.0, 1);

#Uncommenting and executing line below will show all assignment data insrted into the Assignment table
#select * from Assignment; 

#Inserting various grades into the Grade table for each student in our student table
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


# Uncomment and execute line to see all grades in the grade table
select * from Grade;

#Lists all the students in a course
select s. * from Student s join Course c on s.course_id = c.course_id where c.course_id = 1;



# lists all the students in the course along with their score from every assignment
select Student.student_id, Student.first_name, Student.last_name, Assignment.assignment_id, Assignment.category, Grade.score
from Student join Course on Student.course_id = Course.course_id
join Assignment on Course.course_id = Assignment.course_id
left join Grade on Assignment.assignment_id = Grade.assignment_id and Student.student_id = Grade.student_id
order by Student.student_id, Assignment.assignment_id;

# Gets the average/maxe of a particular assignment type (assignment_id 3 = 'Tests')
select avg(score) as average from Grade where assignment_id = 3;

select max(score) as highest from Grade where assignment_id = 3;

select min(score) as lowest from Grade where assignment_id = 3;

#This will add an assignment to the course named Midterm as assignment_id 5 with a percentage weight of 20%
insert into Assignment values (5,'Midterm', 20.0, 1);



#This will change the percentage of the category Tests to 25%
update Assignment set percentage = 50.0 where category = 'Tests' and course_id = 1

# This will add 2 points to the score of every student
update Grade set score = score + 2 where assignment_id = '2';


#This will add 2 points to the score of students if their last name contains a Q
update Grade join Student on Grade.student_id = Student.student_id
set score = score + 2 where Student.last_name like '%Q%';

#This will compute the grade of a student (student_id = 1 = Darius)
select Student.first_name, Student.last_name, sum(Grade.score*Assignment.percentage)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id
join Assignment on Grade.assignment_id = Assignment.assignment_id where Student.student_id = 1;


#TODO: This will compute the grade for a student when the lowest score for a given category is dropped (student_id = 1 = Darius)
select Student.first_name, Student.last_name, sum(Assignment.percentage*Grade.score)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id 
join Assignment on Grade.assignment_id = Assignment.assignment_id 
where Grade.score not in (
    select min(Grade.score) 
    from Grade join Assignment on Grade.assignment_id = Assignment.assignment_id 
    where Assignment.category ='Tests') and Student.student_id = 1
group by Student.student_id;

#TODO: Test Cases
insert into Grade values (17, 50, 3, 1);
delete from Grade where grade_id = (17);