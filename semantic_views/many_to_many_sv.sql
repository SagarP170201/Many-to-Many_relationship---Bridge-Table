USE DATABASE MY_DB;
USE SCHEMA MY_SCHEMA;

CREATE OR REPLACE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100)
);

CREATE OR REPLACE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100)
);

CREATE OR REPLACE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  grade VARCHAR(2)
);

INSERT INTO students VALUES
  (1, 'Alice'),
  (2, 'Bob'),
  (3, 'Charlie');

INSERT INTO courses VALUES
  (101, 'Mathematics'),
  (102, 'Physics'),
  (103, 'Chemistry');

INSERT INTO enrollments VALUES
  (1, 1, 101, '2025-01-15', 'A'),
  (2, 1, 102, '2025-01-15', 'B'),
  (3, 2, 101, '2025-02-01', 'A'),
  (4, 2, 103, '2025-02-01', 'C'),
  (5, 3, 102, '2025-03-10', 'B'),
  (6, 3, 103, '2025-03-10', 'A');

CREATE OR REPLACE SEMANTIC VIEW many_to_many_sv
  TABLES (
    students PRIMARY KEY (student_id),
    enrollments PRIMARY KEY (enrollment_id),
    courses PRIMARY KEY (course_id)
  )
  RELATIONSHIPS (
    enrollments_to_students AS enrollments(student_id) REFERENCES students(student_id),
    enrollments_to_courses AS enrollments(course_id) REFERENCES courses(course_id)
  )
  DIMENSIONS (
    students.student_name AS students.student_name,
    courses.course_name AS courses.course_name,
    enrollments.enrollment_date AS enrollments.enrollment_date,
    enrollments.grade AS enrollments.grade
  )
  METRICS (
    enrollments.enrollment_count AS COUNT(enrollment_id),
    students.student_count AS COUNT(DISTINCT student_id),
    courses.course_count AS COUNT(DISTINCT course_id)
  );
