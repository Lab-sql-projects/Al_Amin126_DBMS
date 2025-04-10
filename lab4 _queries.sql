-- Lab 4: Advanced SQL Operations
-- Student: [Your Name]
-- Course: SQL Operations & Database Management 3
-- Instructor: Salma Filali

-- Step 1: Use your project database
USE UniversityDB;

-- Step 2: Create a VIEW that hides sensitive columns
CREATE OR REPLACE VIEW student_public_info AS
SELECT student_id, first_name, last_name, date_of_birth, enrollment_date
FROM Students;

-- Step 3: Add at least TWO integrity constraints
-- 1. CHECK constraint on phone length
ALTER TABLE Students
ADD CONSTRAINT chk_phone_length CHECK (CHAR_LENGTH(phone) >= 10);

-- 2. UNIQUE constraint on course_name to prevent duplicate courses
ALTER TABLE Courses
ADD CONSTRAINT unique_course_name UNIQUE (course_name);

-- Step 4: Create an INDEX on a commonly used column
CREATE INDEX idx_student_id ON Enrollments(student_id);

-- Step 5: Create and test a TRANSACTION
-- PART 1: Test with ROLLBACK
START TRANSACTION;

INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_date)
VALUES ('Temp', 'User', 'tempuser@uni.com', '1234567890', '2001-01-01', '2024-04-01');

UPDATE Students
SET first_name = 'Updated'
WHERE email = 'tempuser@uni.com';

-- Cancel the above changes
ROLLBACK;

-- Verify student was not inserted
SELECT * FROM Students WHERE email = 'tempuser@uni.com';

-- PART 2: Test with COMMIT
START TRANSACTION;

INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_date)
VALUES ('Temp', 'User', 'tempuser@uni.com', '1234567890', '2001-01-01', '2024-04-01');

COMMIT;

-- Verify student was inserted
SELECT * FROM Students WHERE email = 'tempuser@uni.com';

-- Step 6: Complex Query using JOIN + SUBQUERY + HAVING
-- Get students enrolled in more courses than the average number of courses per student
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    GROUP BY e.student_id
    HAVING COUNT(e.course_id) > (
        SELECT AVG(course_count)
        FROM (
            SELECT student_id, COUNT(course_id) AS course_count
            FROM Enrollments
            GROUP BY student_id
        ) AS avg_table
    )
);

-- BONUS: Create a new user and grant privileges
-- Create read-only user
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonly_pass';

-- Grant SELECT privilege on the view
GRANT SELECT ON UniversityDB.student_public_info TO 'readonly_user'@'localhost';

-- Show grants for verification (run separately if needed)
-- SHOW GRANTS FOR 'readonly_user'@'localhost';
SHOW INDEX FROM Enrollments;
