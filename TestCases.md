# Test Cases

## **Case 1**
```
#Test 1 - Null values should not be able to be entered in certain attributes where not null is included as a condition for the data member 
insert into Student values (5, null, null, null);
insert into Course values (2, null, null, null, 'Fall', 2022);
```
Errors:Present (Test Passed data not entered due to null condition) 
```
20:30:05	insert into Student values (5, null, null, null)	Error Code: 1048. Column 'first_name' cannot be null	0.000 sec

20:31:00	insert into Course values (2, null, null, null, 'Fall', 2022)	Error Code: 1048. Column 'department' cannot be null	0.000 sec
```


## **Case 2**
```
# Test 2- Cannot insert an assignment into a course if the course_id doesn't exist
insert into Assignment values(6, 'Group Project', 50  ,2);
```
Errors:Present (Test Passed value assignment not entered)
```
20:35:43	insert into Assignment values(6, 'Group Project', 50  ,2)	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`testcases`.`assignment`, CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`))	0.015 sec
```
## **Case 3**
```
#Test 3 - If a student does not have grades entered his final grade should be null not zero
insert into Student values (5, 'David', 'Blake', 1);
select Student.first_name, Student.last_name, sum(Grade.score*Assignment.percentage)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id
join Assignment on Grade.assignment_id = Assignment.assignment_id where Student.student_id = 5;
```

Errors: Not Present (Test Passed null row returned)
```
3	29	20:42:47	select Student.first_name, Student.last_name, sum(Grade.score*Assignment.percentage)/sum(Assignment.percentage) as final_grade 
 from Student join Grade on Student.student_id = Grade.student_id
 join Assignment on Grade.assignment_id = Assignment.assignment_id where Student.student_id = 5
 LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec
```

## **Case 4**
```
#Test 4- Testing final grade calculator correctly drops the final grade of a selected student (should return 100 as final grade since the grade of 50 is dropped)
insert into Grade values (18, 100.0, 3, 5), (19,50.0,3,5);

select Student.first_name, Student.last_name, sum(Assignment.percentage*Grade.score)/sum(Assignment.percentage) as final_grade 
from Student join Grade on Student.student_id = Grade.student_id 
join Assignment on Grade.assignment_id = Assignment.assignment_id 
where Grade.score not in (
    select min(Grade.score) 
    from Grade join Assignment on Grade.assignment_id = Assignment.assignment_id 
    where Assignment.category ='Tests') and Student.student_id = 5
group by Student.student_id;
```
Errors:Not Present (Test Passed final score of 100 returned)
```
20:53:56	select Student.first_name, Student.last_name, sum(Assignment.percentage*Grade.score)/sum(Assignment.percentage) as final_grade  from Student join Grade on Student.student_id = Grade.student_id  join Assignment on Grade.assignment_id = Assignment.assignment_id  where Grade.score not in (     select min(Grade.score)      from Grade join Assignment on Grade.assignment_id = Assignment.assignment_id      where Assignment.category ='Tests') and Student.student_id = 5 group by Student.student_id LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec
```

## **Case 5**
```
#Test 5 - Checking that an added assignment is correctly added to the assignment table
insert into Assignment values(6, 'Group Project', 50  ,1);
select * from Assignment; 
```
Errors: None Present (Test Passed select statement queried and displayed the Group Project added to the Assignment table)
```
20:56:59	insert into Assignment values(6, 'Group Project', 50  ,1)	1 row(s) affected	0.000 sec

20:59:42	select * from Assignment LIMIT 0, 1000	6 row(s) returned	0.000 sec / 0.000 sec
```

## **Case 6**
```
#Test 6- Checking that adding points to certain students with the letter Q in the last name works
insert into Student values(6, 'Test', 'QName', 1);
insert into Grade values (20, 50, 3, 6);
update Grade join Student on Grade.student_id = Student.student_id
set score = score + 2 where Student.last_name like '%Q%';
select Student.student_id, Student.first_name, Student.last_name, Assignment.assignment_id, Assignment.category, Grade.score
from Student join Course on Student.course_id = Course.course_id
join Assignment on Course.course_id = Assignment.course_id
left join Grade on Assignment.assignment_id = Grade.assignment_id and Student.student_id = Grade.student_id
where Student.student_id=6;
```
Errors: None Present (Test Passed Test QName score in Tests is 52 after score was incremented by 2 and not the original 50 that it was set as)
```
21:04:15	update Grade join Student on Grade.student_id = Student.student_id set score = score + 2 where Student.last_name like '%Q%'	6 row(s) affected Rows matched: 6  Changed: 6  Warnings: 0	0.015 sec

21:04:18	select Student.student_id, Student.first_name, Student.last_name, Assignment.assignment_id, Assignment.category, Grade.score from Student join Course on Student.course_id = Course.course_id join Assignment on Course.course_id = Assignment.course_id left join Grade on Assignment.assignment_id = Grade.assignment_id and Student.student_id = Grade.student_id where Student.student_id=6 LIMIT 0, 1000	6 row(s) returned	0.000 sec / 0.000 sec
```

# **All relevant Test Passed!**