-- Select the database
USE UniversityDB;

-- Ensure foreign key constraints are enabled
SET FOREIGN_KEY_CHECKS = 1;

-- Drop tables if they already exist (to reset database)
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Professors;
DROP TABLE IF EXISTS Students;

-- Create Students table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    enrollment_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Professors table
CREATE TABLE Professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id) ON DELETE SET NULL
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade CHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'W', NULL)),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id) -- Prevent duplicate enrollments
);

-- Insert data into Students
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_date) VALUES
('Abdullah', 'Asif', 'alexasif4@gmail.com', '18628242273', '2001-12-17', '2023-09-01'),
('Amrun', 'Nakib', 'sadafnakib1.1@gmail.com', '13258127463', '2003-01-24', '2023-09-01'),
('Arman', 'Hossain', 'arman.hossain@gmail.com', '17582734982', '2002-05-15', '2023-09-01');

-- Insert data into Professors table
INSERT INTO Professors (first_name, last_name, email, phone, department) VALUES
('Dr. John', 'Doe', 'johndoe@university.com', '1234567890', 'Computer Science'),
('Dr. Jane', 'Smith', 'janesmith@university.com', '0987654321', 'Mathematics');

-- Insert data into Courses table
INSERT INTO Courses (course_name, course_code, credits, professor_id) VALUES
('Database Systems', 'CS101', 4, 1),
('Algorithms', 'CS102', 3, 1),
('Calculus', 'MATH101', 4, 2);

-- Insert data into Enrollments table
INSERT INTO Enrollments (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2024-01-10', 'A'),
(1, 2, '2024-01-10', 'B'),
(2, 1, '2024-01-10', 'B'),
(3, 3, '2024-01-10', 'A');