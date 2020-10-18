DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students_groups;
DROP TABLE IF EXISTS teachers_groups_subjects;

CREATE TABLE teachers (
    teacher_id varchar(20) PRIMARY KEY,
    second_name varchar(50),
    position varchar(50),
    faculty_department varchar(50),
    speciality varchar(50),
    number int
);

CREATE TABLE subjects (
    subject_id varchar(20) PRIMARY KEY,
    subject_name varchar(50),
    number_of_hours int,
    speciality varchar(50),
    semester int
);

CREATE TABLE students_groups (
    group_id varchar(20) PRIMARY KEY,
    group_name varchar(20),
    number_of_people int,
    speciality varchar(50),
    headman_second_name varchar(50)
);

CREATE TABLE teachers_groups_subjects (
    group_id varchar(20) ,
    subject_id varchar(20),
    teacher_id varchar(20),
    room_number int,

    FOREIGN KEY (group_id)
        REFERENCES students_groups (group_id),
    FOREIGN KEY (subject_id)
        REFERENCES subjects (subject_id),
    FOREIGN KEY (teacher_id)
        REFERENCES teachers (teacher_id)
);
