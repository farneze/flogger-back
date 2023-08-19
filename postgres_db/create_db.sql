-- Database: flogger_db

-- DROP DATABASE IF EXISTS flogger_db;

-- CREATE DATABASE flogger_db
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

-- USE flogger_db;

CREATE SCHEMA flogger;

CREATE TYPE CONSTRUCTOR_TYPE AS ENUM
('builder', 'regulatory', 'energy_foods');

CREATE TYPE PORTION_TYPE AS ENUM
('unit', 'kilograms', 'grams', 'liter', 'mililiter');


CREATE TABLE flogger.users(
	id 			SERIAL PRIMARY KEY,
	first_name	VARCHAR(50),
	last_name	VARCHAR(50),
	nickname	VARCHAR(20)   NOT NULL,
	years		SMALLINT      NOT NULL,
	last_login	TIMESTAMP,
	created_at	TIMESTAMP     NOT NULL DEFAULT current_timestamp,
	updated_at	TIMESTAMP
);

CREATE TABLE flogger.country(
    id 			    SERIAL PRIMARY KEY,
    name            VARCHAR,
    iso_3166_code   VARCHAR,
    flag            VARCHAR,
    created_at      TIMESTAMP     NOT NULL DEFAULT current_timestamp
);

CREATE TABLE flogger.foods(
    id 			        SERIAL  PRIMARY KEY,
    name                VARCHAR(100)        NOT NULL,
    description	        VARCHAR,
    image	            VARCHAR,
    calories	        REAL                NOT NULL,
    carbohydrates	    REAL                NOT NULL,
    protein	            REAL                NOT NULL,
    fat	                REAL                NOT NULL,
    sugar	            REAL                NOT NULL,
    is_solid	        BOOLEAN             NOT NULL,
    portion_type	    PORTION_TYPE        NOT NULL,
    constructor_type	CONSTRUCTOR_TYPE    NOT NULL,
    portion_quantity	SMALLINT            NOT NULL,
    price	            SMALLINT            NOT NULL,
    unit	            SMALLINT            NOT NULL,
    is_dish	            BOOLEAN             NOT NULL,
    server_default	    BOOLEAN,
    id_country	        INTEGER     REFERENCES flogger.country(id)  NOT NULL,
    created_at	        TIMESTAMP           NOT NULL DEFAULT current_timestamp,
    updated_at	        TIMESTAMP
);

CREATE TABLE flogger.dish(
    id 			        SERIAL  PRIMARY KEY,
    id_users	        INTEGER     REFERENCES flogger.users(id)  NOT NULL,
    name                VARCHAR(100)        NOT NULL,
    description	        VARCHAR,
    created_at	        TIMESTAMP           NOT NULL DEFAULT current_timestamp,
    updated_at	        TIMESTAMP
);

CREATE TABLE flogger.consumed(
    id_dish     INTEGER     REFERENCES flogger.dish(id)  NOT NULL,
    quantity    SMALLINT            NOT NULL,
    eaten_at    TIMESTAMP           NOT NULL,
    created_at  TIMESTAMP           NOT NULL DEFAULT current_timestamp
);

CREATE TABLE flogger.dish_has_foods(
    id_dish     INTEGER     REFERENCES flogger.dish(id)  NOT NULL,
    id_food     INTEGER     REFERENCES flogger.foods(id)  NOT NULL,
    quantity    SMALLINT            NOT NULL,
    created_at  TIMESTAMP           NOT NULL DEFAULT current_timestamp
);


INSERT INTO flogger.users(nickname, years, last_login)
VALUES ('Tutu', 35, current_timestamp);


-- EXAMPLES

-- https://www.youtube.com/watch?v=85pG_pDkITY

-- ALTER TABLE flogger.foods
-- ALTER COLUMN constructor_type TYPE constructor_type USING constructor_type::constructor_type

-- INSERT INTO flogger.users(nickname, years, last_login)
-- VALUES ('Tutu', 35, current_timestamp);

-- CREATE VIEW flogger.test AS
--     SELECT nickname FROM flogger.users WHERE name IS NOT NULL;

-- CREATE INDEX test_id ON test(column_test, column_test2)
