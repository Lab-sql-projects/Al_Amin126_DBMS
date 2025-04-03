PRAGMA foreign_keys = ON; -- Enable foreign keys in SQLite

-- Students Table
CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    date_of_birth DATE,
    enrollment_date DATE DEFAULT (DATE('now')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Professors Table
CREATE TABLE Professors (
    professor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    department TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses Table
CREATE TABLE Courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name TEXT NOT NULL,
    course_code TEXT UNIQUE NOT NULL,
    credits INTEGER CHECK (credits > 0),
    professor_id INTEGER,
    prerequisite_course_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id) ON DELETE SET NULL,
    FOREIGN KEY (prerequisite_course_id) REFERENCES Courses(course_id) ON DELETE SET NULL
);

-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE DEFAULT (DATE('now')),
    grade TEXT CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'W', NULL)),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id) -- Prevent duplicate enrollments
);

-- Insert Sample Data
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth) VALUES
('Abdullah', 'Asif', 'alexasif4@gmail.com', '18628242273', '2001-12-17'),
('Amrun', 'Nakib', 'sadafnakib1.1@gmail.com', '13258127463', '2003-01-24'),
('Arman', 'Hossain', 'armanfhossain@gmail.com', '8801920824499', '2001-08-26');

INSERT INTO Professors (first_name, last_name, email, phone, department) VALUES
('Jingyu', 'Zhang', 'jinZhang@scu.edu.cn', '1866383167', 'Computer Network'),
('Wenchao', 'Du', 'Wenchaodu@scu.edu.cn', '13233445566', 'Software Engineering'),
('Mingjie', 'Tang', 'MingjieTang@scu.edu.cn', '13235948455', 'Database System');

INSERT INTO Courses (course_name, course_code, credits, professor_id) VALUES
('Computer Network', 'CS101', 4, 1),
('Software Engineering', 'CS102', 3, 1),
('Database System', 'SE201', 4, 2);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'A'),
(3, 3, 'A');
