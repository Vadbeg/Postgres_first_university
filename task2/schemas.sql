DROP TABLE IF EXISTS providers;
DROP TABLE IF EXISTS details;
DROP TABLE IF EXISTS projects;

CREATE TABLE providers (
    provider_id varchar(15) PRIMARY KEY,
    name varchar(25),
    status int,
    city varchar(50)
);

CREATE TABLE details (
    detail_id varchar(15) PRIMARY KEY,
    name varchar(25),
    color varchar(25),
    size int,
    city varchar(50)
);

CREATE TABLE projects (
    project_id varchar(15) PRIMARY KEY,
    name varchar(25),
    city varchar(50)
);

CREATE TABLE num_of_details (
    provider_id varchar(15),
    detail_id varchar(15),
    project_id varchar(15),

    num_of_details int,

    FOREIGN KEY (provider_id)
        REFERENCES providers (provider_id),
    FOREIGN KEY (detail_id)
            REFERENCES details (detail_id),
    FOREIGN KEY (project_id)
        REFERENCES projects (project_id)
);