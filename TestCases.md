# Test Cases

**Case 1**
```
#Test 1 - Null values should not be able to be entered in certain attributes where not null is included as a condition for the data member 
insert into Student values (5, null, null, null);
insert into Course values (2, null, null, null, 'Fall', 2022);
```
Errors:Present (Test Passed) data cannot be entered due to null condition
```
20:30:05	insert into Student values (5, null, null, null)	Error Code: 1048. Column 'first_name' cannot be null	0.000 sec

20:31:00	insert into Course values (2, null, null, null, 'Fall', 2022)	Error Code: 1048. Column 'department' cannot be null	0.000 sec
```


**Case 2**
```
# Test 2- Cannot insert an assignment into a course if the course_id doesn't exist
insert into Assignment values(6, 'Group Project', 50  ,2);
```
Errors:Present (Test Passed)
```
20:35:43	insert into Assignment values(6, 'Group Project', 50  ,2)	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`testcases`.`assignment`, CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`))	0.015 sec
```
**Case 3**
```
#Test 3 - If a student does not have grades entered his final grade should be null not zero
insert into Student values (5, 'David', 'Blake', 1);
select Student.first_name, Student.last_name, sum(Grade.score*Assignment.percentage)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id
join Assignment on Grade.assignment_id = Assignment.assignment_id where Student.student_id = 5;
```

Errors: Not Present (Test Passed)
```
3	29	20:42:47	select Student.first_name, Student.last_name, sum(Grade.score*Assignment.percentage)/sum(Assignment.percentage) as final_grade 
 from Student join Grade on Student.student_id = Grade.student_id
 join Assignment on Grade.assignment_id = Assignment.assignment_id where Student.student_id = 5
 LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec
```