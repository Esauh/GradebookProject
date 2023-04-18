# Completed Task Report

## *SQL Commands for Task 2*
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
## *The Tables with contents filled for Task 3*
**Course Table**
| course_id | department            | course_number | course_name              | semester | year |
| --------- | --------------------- | ------------- | ------------------------ | -------- | ---- |
| 1         | Electical Engineering | 200           | Principles of Eletronics | Spring   | 2023 |

**Assignment Table**
| assignment_id | category      | percentage | course_id |
| ------------- | ------------- | ---------- | --------- |
| 1             | Participation | 10         | 1         |
| 2             | Homework      | 20         | 1         |
| 3             | Tests         | 50         | 1         |
| 4             | Projects      | 20         | 1         |

**Student Table**
| student_id | first_name | last_name | course_id |
| ---------- | ---------- | --------- | --------- |
| 1          | Darius     | Quinton   | 1         |
| 2          | Alex       | Smith     | 1         |
| 3          | Chad       | Johnson   | 1         |
| 4          | Sally      | Fullman   | 1         |

**Grade Table**
| grade_id | score | assignment_id | student_id |
| -------- | ----- | ------------- | ---------- |
| 1        | 14    | 1             | 1          |
| 2        | 108   | 2             | 1          |
| 3        | 101   | 3             | 1          |
| 4        | 84    | 4             | 1          |
| 5        | 8     | 1             | 2          |
| 6        | 86    | 2             | 2          |
| 7        | 75    | 3             | 2          |
| 8        | 70    | 4             | 2          |
| 9        | 7     | 1             | 3          |
| 10       | 79    | 2             | 3          |
| 11       | 95    | 3             | 3          |
| 12       | 80    | 4             | 3          |
| 13       | 9.5   | 1             | 4          |
| 14       | 99    | 2             | 4          |
| 15       | 97    | 3             | 4          |
| 16       | 100   | 4             | 4          |

## *SQL Commands for Task 4-12*

**Task 4**
```
# Gets the avg/max/min of a particular assignment type (assignment_id[3] = 'Tests')
select avg(score) as average from Grade where assignment_id = 3;

select max(score) as highest from Grade where assignment_id = 3;

select min(score) as lowest from Grade where assignment_id = 3;
```
**Task 5**
```
#Lists all the students in a given course (course_id[1] = 'Principles of Electronics' )
select s. * from Student s join Course c on s.course_id = c.course_id where c.course_id = 1;
```
**Task 6**
```
# Lists all the students in the course along with their score from every assignment
select Student.student_id, Student.first_name, Student.last_name, Assignment.assignment_id, Assignment.category, Grade.score
from Student join Course on Student.course_id = Course.course_id
join Assignment on Course.course_id = Assignment.course_id
left join Grade on Assignment.assignment_id = Grade.assignment_id and Student.student_id = Grade.student_id
order by Student.student_id, Assignment.assignment_id;
```
**Task 7**
```
#This will add an assignment to the course named Midterm as assignment_id 5 with a percentage weight of 20%
insert into Assignment values (5,'Midterm', 20.0, 1);
```
**Task 8**
```
#This will change the percentage of the category Tests to 50% and Participation to 5%
update Assignment set percentage = 50.0 where category = 'Tests' and course_id = 1
update Assignment set percentage = 5.0 where category = 'Participation' and course_id = 1
```
**Task 9**
```
# This will add 2 points to the score of every student
update Grade set score = score + 2 where assignment_id = '2';
```
**Task 10**
```
#This will add 2 points to the score of students if their last name contains a Q
update Grade join Student on Grade.student_id = Student.student_id
set score = score + 2 where Student.last_name like '%Q%';
```
**Task 11**
```
#This will compute the grade of a student (student_id = 1 = Darius)
select Student.first_name, Student.last_name, sum(Grade.score*Assignment.percentage)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id
join Assignment on Grade.assignment_id = Assignment.assignment_id where Student.student_id = 1;
```
**Task 12**
```
#This will compute the grade for a student when the lowest score for a given category is dropped (student_id = 1 = Darius)
select Student.first_name, Student.last_name, sum(Assignment.percentage*Grade.score)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id 
join Assignment on Grade.assignment_id = Assignment.assignment_id 
where Grade.score not in (
    select min(Grade.score) 
    from Grade join Assignment on Grade.assignment_id = Assignment.assignment_id 
    where Assignment.category ='Tests') and Student.student_id = 1
group by Student.student_id;
```

