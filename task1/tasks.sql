-- 1

SELECT *
FROM teachers;

-- 2

SELECT *
FROM students_groups
WHERE students_groups.speciality = 'ЭВМ';

-- 3

SELECT DISTINCT teachers_groups_subjects.teacher_id,
       teachers_groups_subjects.room_number
FROM teachers_groups_subjects
WHERE teachers_groups_subjects.subject_id = '18П';

-- 4

SELECT DISTINCT s.subject_name, s.subject_id
FROM teachers_groups_subjects
LEFT JOIN teachers t on t.teacher_id = teachers_groups_subjects.teacher_id
LEFT JOIN subjects s on s.subject_id = teachers_groups_subjects.subject_id
WHERE t.second_name = 'Костин';

-- 5

SELECT DISTINCT teachers_groups_subjects.group_id
FROM teachers_groups_subjects
LEFT JOIN teachers as t on t.teacher_id = teachers_groups_subjects.teacher_id
WHERE t.second_name = 'Фролов';

-- 6

SELECT *
FROM subjects
WHERE subjects.speciality = 'АСОИ';

-- 7

SELECT *
FROM teachers
WHERE speciality similar to '%АСОИ%';

-- 8

SELECT DISTINCT t.teacher_id, t.second_name, t.position, t.faculty_department, t.speciality, t.number
FROM teachers_groups_subjects
LEFT JOIN teachers as t on t.teacher_id = teachers_groups_subjects.teacher_id
WHERE teachers_groups_subjects.room_number = '210';

-- 9

SELECT DISTINCT s.subject_name, teachers_groups_subjects.group_id
FROM teachers_groups_subjects
LEFT JOIN subjects as s on s.subject_id = teachers_groups_subjects.subject_id
WHERE teachers_groups_subjects.room_number <= 200 and teachers_groups_subjects.room_number >= 100;

-- 10

SELECT speciality, array_agg(group_id)
FROM students_groups
GROUP BY students_groups.speciality;

-- 11

SELECT sum(students_groups.number_of_people)
FROM students_groups
WHERE students_groups.speciality = 'АСОИ';

-- 12

SELECT teachers.number
FROM teachers
WHERE speciality similar to '%ЭВМ%';

-- 13

SELECT subject_id, count(group_id)
FROM teachers_groups_subjects
GROUP BY teachers_groups_subjects.subject_id
HAVING count(teachers_groups_subjects.group_id) in
       (SELECT count(subjects.group_id)
        FROM
             (SELECT DISTINCT teachers_groups_subjects.group_id
              FROM teachers_groups_subjects) as subjects);

-- 14

WITH temp_table as (
    SELECT DISTINCT teacher_id
    FROM teachers_groups_subjects
    WHERE subject_id = '14П'
)
SELECT DISTINCT teacher_id
FROM teachers_groups_subjects
WHERE subject_id in
(
    SELECT DISTINCT subject_id
    FROM teachers_groups_subjects
    WHERE teacher_id in (
        SELECT teacher_id
        FROM temp_table
    )
);

-- 15

SELECT *
FROM subjects
WHERE subject_id in (
    SELECT DISTINCT subject_id
    FROM teachers_groups_subjects
    WHERE subject_id not in
          (
              SELECT DISTINCT subject_id
              FROM teachers_groups_subjects
              WHERE teacher_id = '221Л'
          )
);

-- 16

SELECT *
FROM subjects
WHERE subject_id in (
    SELECT DISTINCT subject_id
    FROM teachers_groups_subjects
    WHERE subject_id not in
          (
              SELECT DISTINCT subject_id
              FROM teachers_groups_subjects
              WHERE group_id = (
                      SELECT distinct group_id
                      FROM students_groups
                      WHERE students_groups.group_name = 'М-6'
                  )
          )
);

-- 17

SELECT *
FROM teachers
WHERE teachers.position = 'Доцент' AND
      teachers.teacher_id in (
            SELECT DISTINCT teacher_id
            FROM teachers_groups_subjects
            WHERE group_id in ('3Г', '8Г')
        );

-- 18

SELECT *
FROM teachers_groups_subjects
WHERE teachers_groups_subjects.teacher_id in (
    SELECT teacher_id
    FROM teachers
    WHERE teachers.speciality similar to '%ЭВМ%' AND
          teachers.faculty_department = 'ЭВМ'
);

-- 19

SELECT DISTINCT group_id
FROM students_groups
WHERE speciality in (
    SELECT DISTINCT unnest(regexp_split_to_array(speciality, ', '))
    FROM teachers
);

-- 20

WITH teacher_ids_coincide_table as (
    SELECT DISTINCT teacher_id
    FROM teachers_groups_subjects
    LEFT JOIN subjects s on teachers_groups_subjects.subject_id = s.subject_id
    LEFT JOIN students_groups sg on teachers_groups_subjects.group_id = sg.group_id
    WHERE s.speciality = sg.speciality
)
SELECT teachers.number
FROM teachers
WHERE teachers.teacher_id in (
        SELECT teacher_id
        FROM teacher_ids_coincide_table
    );

-- 21

SELECT speciality
FROM students_groups
WHERE students_groups.group_id in (
    SELECT group_id
    FROM teachers_groups_subjects
    WHERE teachers_groups_subjects.teacher_id IN (
        SELECT teachers.teacher_id
        FROM teachers
        WHERE teachers.faculty_department = 'АСУ'
    )
);

-- 22

SELECT subject_id
FROM teachers_groups_subjects
WHERE teachers_groups_subjects.group_id IN (
        SELECT group_id
        FROM students_groups
        WHERE students_groups.group_name = 'АС-8'
    );

-- 23

SELECT DISTINCT group_id
FROM teachers_groups_subjects
WHERE teachers_groups_subjects.subject_id in (
        SELECT subject_id
        FROM teachers_groups_subjects
        WHERE teachers_groups_subjects.group_id IN (
            SELECT group_id
            FROM students_groups
            WHERE students_groups.group_name = 'АС-8'
        )

    );

-- 24

SELECT *
FROM teachers_groups_subjects
WHERE teachers_groups_subjects.group_id not in (
    SELECT DISTINCT teachers_groups_subjects.group_id
    FROM teachers_groups_subjects
    WHERE teachers_groups_subjects.subject_id in (
        SELECT (subject_id)
        FROM teachers_groups_subjects
        WHERE teachers_groups_subjects.group_id IN (
            SELECT group_id
            FROM students_groups
            WHERE students_groups.group_name = 'АС-8'
            )

        )
    );

-- 25

SELECT *
FROM teachers_groups_subjects
WHERE teachers_groups_subjects.group_id not in (
    SELECT DISTINCT teachers_groups_subjects.group_id
    FROM teachers_groups_subjects
    WHERE teachers_groups_subjects.subject_id in (
        SELECT (subject_id)
        FROM teachers_groups_subjects
        WHERE teachers_groups_subjects.teacher_id = '430Л'
        )
    );

-- 26

SELECT number
FROM teachers
WHERE teachers.teacher_id IN (
        SELECT DISTINCT teacher_id
        FROM teachers_groups_subjects
        WHERE group_id = (
            SELECT students_groups.group_id
            FROM students_groups
            WHERE students_groups.group_name = 'Э-15'
        ) AND
              subject_id != '12П'
    );
