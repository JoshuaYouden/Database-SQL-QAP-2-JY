CREATE TABLE students (
	student_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT,
	enrollment_date DATE
);

CREATE TABLE professers (
	professor_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	department TEXT
);

CREATE TABLE courses (
	course_id SERIAL PRIMARY KEY,
    course_name TEXT,
    course_description TEXT,
	professor_id INT REFERENCES professers(professor_id)
);

CREATE TABLE enrollments  (
	student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
	enrollment_date DATE,
	PRIMARY KEY (student_id, course_id)
);

INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('Alice', 'Zueberg', 'alice.leah@example.com', '2024-04-25'),
('Charlie', 'Smith', 'charlie.smith@example.com', '2024-04-26'),
('Kait', 'Broma', 'kait.broma@example.com', '2024-04-27'),
('Leah', 'Smith', 'niki.smith@example.com', '2024-04-28'),
('Matthew', 'English', 'matthew.english@example.com', '2024-04-29')

INSERT INTO professers (first_name, last_name, department) VALUES
('Dalice', 'Johnson', 'Physics'),
('Niki', 'Roman', 'English'),
('Tyrone', 'Hiyema', 'History'),
('Peter', 'Hawthorn', 'Counselor')

INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to Physics', 1),
('English 201', 'Basics of English', 2),
('History 101', 'A Look into Historical Events', 3)

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
((SELECT student_id FROM students WHERE first_name = 'Alice' AND last_name = 'Zueberg'), (SELECT course_id FROM courses WHERE course_name = 'Physics 101'), '2024-04-25'),
((SELECT student_id FROM students WHERE first_name = 'Alice' AND last_name = 'Zueberg'), (SELECT course_id FROM courses WHERE course_name = 'English 201'), '2024-04-25'),
((SELECT student_id FROM students WHERE first_name = 'Kait' AND last_name = 'Broma'), (SELECT course_id FROM courses WHERE course_name = 'History 101'), '2024-04-27'),
((SELECT student_id FROM students WHERE first_name = 'Leah' AND last_name = 'Smith'), (SELECT course_id FROM courses WHERE course_name = 'History 101'), '2024-04-28'),
((SELECT student_id FROM students WHERE first_name = 'Leah' AND last_name = 'Smith'), (SELECT course_id FROM courses WHERE course_name = 'English 201'), '2024-04-28'),
((SELECT student_id FROM students WHERE first_name = 'Matthew' AND last_name = 'English'), (SELECT course_id FROM courses WHERE course_name = 'English 201'), '2024-04-29'),
((SELECT student_id FROM students WHERE first_name = 'Charlie' AND last_name = 'Smith'), (SELECT course_id FROM courses WHERE course_name = 'Physics 101'), '2024-04-26'),
((SELECT student_id FROM students WHERE first_name = 'Charlie' AND last_name = 'Smith'), (SELECT course_id FROM courses WHERE course_name = 'History 101'), '2024-04-26')

SELECT first_name || ' ' || last_name AS full_name FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON courses.course_id = enrollments.course_id
WHERE courses.course_name = 'Physics 101'

SELECT course_name, first_name || ' ' || last_name AS full_name FROM courses
JOIN professers ON courses.professor_id = professers.professor_id

SELECT course_name FROM courses
JOIN enrollments ON courses.course_id = enrollments.course_id
JOIN students ON students.student_id = enrollments.student_id

UPDATE students
SET email = 'matthew.e.neweremail@example.com'
WHERE first_name = 'Matthew' AND last_name = 'English'

DELETE FROM enrollments
WHERE student_id = (SELECT student_id FROM students WHERE first_name = 'Leah' AND last_name = 'Smith')
AND course_id = (SELECT course_id FROM courses WHERE course_name = 'History 101')