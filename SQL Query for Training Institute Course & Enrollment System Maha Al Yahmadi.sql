create database Project_for_DB;
use Project_for_DB; 


-- Course table
create table Course
(
  course_id int primary key identity (1,1),
  title nvarchar(30),
  category nvarchar(30),
  duration_hours int check (duration_hours > 0),
  levels varchar(20) check (levels in ('Beginner', 'Intermediate', 'Advanced'))
);

-- Trainee table
create table Trainee
(
  trainee_id int primary key identity (1,1),
  name nvarchar(30),
  gender varchar(10) check (gender in ('Male', 'Female')),
  email varchar(30) unique,
  background nvarchar(30)
);

-- Trainer table
create table Trainer
(
  trainer_id int primary key identity (1,1),
  name nvarchar (30),
  specialty nvarchar(30),
  phone varchar(20),
  email varchar (30) unique

);

drop table Trainer;

create table Trainer
(
  trainer_id int primary key identity (1,1),
  name nvarchar(30) not null,
  specialty nvarchar(30),
  phone nvarchar(20),
  email varchar(30) unique
);

-- Schedule table
create table Schedule
(
  schedule_id int primary key identity (1,1),
  course_id int,
  trainer_id int,
  start_date date,
  end_date date,
  time_slot varchar(20) check (time_slot in ('Morning', 'Evening', 'Weekend')),
  foreign key (course_id) references Course(course_id),
  foreign key (trainer_id) references Trainer(trainer_id)
);

-- Enrollment table
create table Enrollment
(
  enrollment_id int primary key identity(1,1),
  trainee_id int,
  course_id int,
  enrollment_date date,
  foreign key (trainee_id) references Trainee(trainee_id),
  foreign key (course_id) references Course(course_id)
);


-- Inserting Data 

-- Insert data into Course
insert into Course (title, category, duration_hours, levels) values
('Database Fundamentals', 'Databases', 20, 'Beginner'),
('Web Development Basics', 'Web', 30, 'Beginner'),
('Data Science Introduction', 'Data Science', 25, 'Intermediate'),
('Advanced SQL Queries', 'Databases', 15, 'Advanced');


-- Insert data into Trainee
insert into Trainee (name, gender, email, background) values
('Aisha Al-Harthy', 'Female', 'aisha@example.com', 'Engineering'),
('Sultan Al-Farsi', 'Male', 'sultan@example.com', 'Business'),
('Mariam Al-Saadi', 'Female', 'mariam@example.com', 'Marketing'),
('Omar Al-Balushi', 'Male', 'omar@example.com', 'Computer Science'),
('Fatma Al-Hinai', 'Female', 'fatma@example.com', 'Data Science');

-- Insert data into Trainer
insert into Trainer (name, specialty, phone, email) values
('Khalid Al-Maawali', 'Databases', '93934848', 'khalid@example.com'),
('Noura Al-Kindi', 'Web Development', '96964343', 'noura@example.com'),
('Salim Al-Harthy', 'Data Science', '7787777', 'salim@example.com');


-- Insert data into Schedule
insert into Schedule (course_id, trainer_id, start_date, end_date, time_slot) values
(1, 1, '2025-07-01', '2025-07-10', 'Morning'),
(2, 2, '2025-07-05', '2025-07-20', 'Evening'),
(3, 3, '2025-07-10', '2025-07-25', 'Weekend'),
(4, 1, '2025-07-15', '2025-07-22', 'Morning');

-- Insert data into Enrollment
insert into Enrollment (trainee_id, course_id, enrollment_date) values
(1, 1, '2025-06-01'),
(2, 1, '2025-06-02'),
(3, 2, '2025-06-03'),
(4, 3, '2025-06-04'),
(5, 3, '2025-06-05'),
(1, 4, '2025-06-06');

-- Representing the tables:
select * from Course;
select * from Trainee;
select * from Trainer;
select * from Schedule;
select * from Enrollment;



-- Questions: 


-- Trainee Perspective

-- 1)
select title, levels, category
from Course

-- 2)
select title, levels, category
from Course
where levels = 'Beginner' and category = 'Data Science';

-- 3) 
select Trainee.trainee_id, Course.title
from Enrollment
inner join Trainee on Enrollment.trainee_id = Trainee.trainee_id
inner join Course on Enrollment.course_id = Course.course_id;

-- 4)
select Course.title as  course_title, Schedule.start_date, Schedule.time_slot
from Enrollment
inner join Trainee on Enrollment.trainee_id = Trainee.trainee_id
inner join Course on Enrollment.course_id = Course.course_id
inner join Schedule on Course.course_id = Schedule.course_id

-- 5)
select trainee_id, count(*) as total_courses
from Enrollment
group by trainee_id;


-- 6)
select Course.title as course_titles, Trainer.name as trainer_name, Schedule.time_slot
from Enrollment
inner join Trainee on Enrollment.trainee_id = Trainee.trainee_id
inner join Course on Enrollment.course_id = Course.course_id
inner join Schedule on Course.course_id = Schedule.course_id
inner join Trainer on Schedule.trainer_id = Trainer.trainer_id



-- Trainer Perspective

-- 1) 
select trainer_id, title as course_title
from Schedule
inner join Course on Schedule.course_id = Course.course_id

-- 2) 
select Trainer.name, Schedule.start_date, Schedule.end_date, Schedule.time_slot
from Schedule
inner join Trainer on Schedule.trainer_id = Trainer.trainer_id

-- 3)
select Course.title as course_title, 
count(enrollment.trainee_id) as total_trainees
from schedule
inner join course on schedule.course_id = course.course_id
inner join enrollment on course.course_id = enrollment.course_id
group by Course.title


-- 4)
select Trainee.name, Trainee.email
from Schedule
inner join Course on Schedule.course_id = Course.course_id
inner join Enrollment on Course.course_id = Enrollment.course_id
inner join Trainee on Enrollment.trainee_id = Trainee.trainee_id


-- 5)
select Trainer.phone as trainer_Phone_number, Trainer.email, Course.title as course_title
from Schedule
inner join Trainer on Schedule.trainer_id = Trainer.trainer_id
inner join Course on Schedule.course_id = Course.course_id

-- 6) 
select count(distinct Schedule.course_id) as number_of_courses
from Schedule
group by Schedule.trainer_id;


-- Admin Perspective

-- 1) 
insert into Course (title, category, duration_hours, levels) values
('python basics', 'programming', 20, 'beginner');

-- 2)
insert into Schedule (course_id, trainer_id, start_date, end_date, time_slot) values 
(3, 1, '2025-09-05', '2025-11-20', 'evening');

-- 3)
select Trainee.name as trainee_name, Course.title as course_title, Schedule.start_date, Schedule.end_date, Schedule.time_slot
from Enrollment
inner join Trainee on Enrollment.trainee_id = Trainee.trainee_id
inner join Course on Enrollment.course_id = Course.course_id
inner join Schedule on Course.course_id = Schedule.course_id

-- 4)
select trainer_id, count(*) as total_courses
from Schedule
group by trainer_id;

-- 5)
select Trainee.name as trainee_name, Trainee.email
from Enrollment
inner join Trainee on Enrollment.trainee_id = Trainee.trainee_id
inner join Course on Enrollment.course_id = Course.course_id
where Course.title = 'Data Basics'

-- 6) 
select top 1 course_id, count(*) AS enrollment_count
from Enrollment
group by course_id

-- 7)
select * from schedule
order by start_date;

