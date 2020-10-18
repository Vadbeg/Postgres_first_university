-- 9

SELECT detail_id
FROM num_of_details
WHERE provider_id in (
        SELECT provider_id
        FROM providers
        WHERE providers.city = 'Лондон'
    );


-- 34

SELECT detail_id
FROM num_of_details
WHERE project_id in (
        SELECT projects.project_id
        FROM projects
        WHERE city = 'Лондон'
    ) OR
      provider_id in (
        SELECT providers.provider_id
        FROM providers
        WHERE city = 'Лондон'
    );

-- 6

SELECT d.detail_id, p.provider_id, p2.project_id
FROM num_of_details
LEFT JOIN details d on num_of_details.detail_id = d.detail_id
LEFT JOIN providers p on num_of_details.provider_id = p.provider_id
LEFT JOIN projects p2 on num_of_details.project_id = p2.project_id
WHERE d.city = p.city and p.city= p2.city;

-- 12

SELECT detail_id
FROM num_of_details
LEFT JOIN providers p on num_of_details.provider_id = p.provider_id
LEFT JOIN projects p2 on num_of_details.project_id = p2.project_id
WHERE p.city= p2.city;

-- 16

SELECT count(detail_id)
FROM num_of_details
WHERE num_of_details.provider_id = 'П1' and num_of_details.detail_id = 'Д1';

-- 24

SELECT *
FROM providers
WHERE status < (
        SELECT status
        FROM providers
        WHERE providers.provider_id = 'П1'
    );

-- 28

SELECT DISTINCT project_id
FROM num_of_details
WHERE project_id not in (
        SELECT project_id
        FROM num_of_details
        WHERE provider_id in (
            SELECT provider_id
            FROM providers
            WHERE city = 'Лондон'
        ) and detail_id in (
            SELECT detail_id
            FROM details
            WHERE details.color = 'Красный'
        )
    )
ORDER BY project_id;

-- 20

SELECT color
FROM details
WHERE detail_id in (
        SELECT DISTINCT detail_id
        FROM num_of_details
        WHERE provider_id = 'П1'
    );

-- 10

SELECT detail_id
FROM num_of_details
WHERE provider_id in (
        SELECT provider_id
        FROM providers
        WHERE providers.city = 'Лондон'
    ) and
      project_id in (
        SELECT project_id
        FROM projects
        WHERE projects.city = 'Лондон'
    );

-- 30

SELECT detail_id
FROM num_of_details
WHERE num_of_details.project_id in (
        SELECT project_id
        FROM projects
        WHERE projects.city = 'Лондон'
    );

