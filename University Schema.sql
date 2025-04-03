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
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Professors Table
CREATE TABLE Professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credits INT CHECK (credits > 0),
    professor_id INT,
    prerequisite_course_id INT, -- Allows prerequisites for courses
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id) ON DELETE SET NULL,
    FOREIGN KEY (prerequisite_course_id) REFERENCES Courses(course_id) ON DELETE SET NULL
);

-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    grade CHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'W', NULL)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id) -- Prevent duplicate enrollments
);

-- Insert Sample Data

-- Insert Students
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '2000-05-15'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '1999-08-22'),
('Alice', 'Brown', 'alice.brown@example.com', '4561237890', '2001-02-10');

-- Insert Professors
INSERT INTO Professors (first_name, last_name, email, phone, department) VALUES
('Dr. Alan', 'Turing', 'alan.turing@example.com', '1122334455', 'Computer Science'),
('Dr. Grace', 'Hopper', 'grace.hopper@example.com', '2233445566', 'Software Engineering');

-- Insert Courses
INSERT INTO Courses (course_name, course_code, credits, professor_id) VALUES
('Data Structures', 'CS101', 4, 1),
('Algorithms', 'CS102', 3, 1),
('Software Engineering', 'SE201', 4, 2);

-- Insert Enrollments
INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'B'),
(3, 3, 'C');
