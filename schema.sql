CREATE DATABASE UniversityDB;
USE UniversityDB;

-- Students Table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Professors Table
CREATE TABLE Professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100) NOT NULL
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credits INT CHECK (credits > 0),
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id) ON DELETE SET NULL
);

-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    grade CHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'W', NULL)),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id) -- Prevent duplicate enrollments
);
