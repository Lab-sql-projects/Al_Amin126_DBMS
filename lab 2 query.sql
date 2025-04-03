-- Select the database
USE UniversityDB;

-- Ensure foreign key constraints are enabled
SET FOREIGN_KEY_CHECKS = 1;


-- INNER JOIN: Get students and their enrolled courses
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM Students s
INNER JOIN Enrollments e ON s.student_id = e.student_id
INNER JOIN Courses c ON e.course_id = c.course_id;

-- LEFT JOIN: Get all professors and the courses they teach (if any)
SELECT
    p.professor_id,
    p.first_name,
    p.last_name,
    COALESCE(c.course_name, 'No Course Assigned') AS course_name
FROM Professors p
LEFT JOIN Courses c ON p.professor_id = c.professor_id;

-- UPDATE: Change the grade of a student
UPDATE Enrollments
SET grade = 'B+'
WHERE student_id = 1 AND course_id = 1;

-- DELETE: Remove a student's enrollment
DELETE FROM Enrollments
WHERE student_id = 2 AND course_id = 1;

-- Aggregation Query: Count students in each course, only showing courses with more than 0 students
SELECT
    c.course_name,
    COUNT(e.student_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING num_students > 0;

-- Subquery: Get students enrolled in more courses than the average number of courses per student
SELECT student_id, first_name, last_name
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    GROUP BY student_id
    HAVING COUNT(course_id) > (
        SELECT AVG(course_count)
        FROM (SELECT student_id, COUNT(course_id) AS course_count FROM Enrollments GROUP BY student_id) AS avg_table
    )
);
