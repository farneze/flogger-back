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

CREATE TYPE flogger.CONSTRUCTOR_TYPE AS ENUM
('builder', 'regulatory', 'energy_foods');

CREATE TYPE flogger.PORTION_TYPE AS ENUM
('unit', 'kilograms', 'grams', 'liter', 'mililiter');

CREATE TYPE flogger.NUTRITIONAL_INFO AS (
    calories        INT,
    carbohydrates   NUMERIC(5, 2),
    protein         NUMERIC(5, 2),
    fat             NUMERIC(5, 2),
    sugar           NUMERIC(5, 2)
);

CREATE TYPE flogger.FOOD_INFO AS (
    constructor_type    flogger.CONSTRUCTOR_TYPE,
    portion_type        flogger.PORTION_TYPE,
    portion_quantity X   NUMERIC(5, 2),
    total_quantity      NUMERIC(5, 2),
    price               NUMERIC(5, 2)
);

CREATE TYPE flogger.FOOD_LIST AS (
    id_food     INT,
    quantity    INT
);

CREATE TABLE flogger.users(
	id 			    SERIAL,
	first_name	    VARCHAR(50),
	last_name	    VARCHAR(50),
	nickname	    VARCHAR(20)                     NOT NULL,
	years		    SMALLINT,
    weight          NUMERIC(5, 2)                   NOT NULL,
    daily_intake    flogger.NUTRITIONAL_INFO  NOT NULL,
	last_login	    TIMESTAMPTZ,
	created_at	    TIMESTAMPTZ                     NOT NULL DEFAULT current_timestamp,
	updated_at	    TIMESTAMPTZ,

    PRIMARY KEY (id)
);

CREATE TABLE flogger.foods(
    id 			        SERIAL,
    id_users	        INTEGER             NOT NULL,
    name                VARCHAR(100)        NOT NULL,
    description	        VARCHAR,
    image	            VARCHAR,
    nutritional_info    flogger.NUTRITIONAL_INFO,
    food_info           flogger.FOOD_INFO,
    created_at	        TIMESTAMPTZ         NOT NULL DEFAULT current_timestamp,
    updated_at	        TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (id_users) REFERENCES flogger.users(id)
);

CREATE TABLE flogger.dish(
    id 			        SERIAL,
    name                VARCHAR(100)    NOT NULL,
    description	        VARCHAR,
    foods               flogger.FOOD_LIST[],
    created_at	        TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
    updated_at	        TIMESTAMPTZ,

    PRIMARY KEY (id)
);

CREATE TABLE flogger.consumed(
    id_dish     INTEGER     NOT NULL,
    id_food     INTEGER     NOT NULL,
    quantity    SMALLINT    NOT NULL,
    eaten_at    TIMESTAMPTZ NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    
    PRIMARY KEY (id_dish, id_food),
    FOREIGN KEY (id_dish) REFERENCES flogger.dish(id),
    FOREIGN KEY (id_food) REFERENCES flogger.foods(id)
);

INSERT INTO flogger.users(nickname, weight, daily_intake, created_at)
VALUES ('Tutu', 133, JSONB_BUILD_OBJECT('200', '0.8', '0.8', '0.8', '0.8'), current_timestamp);
    

-- EXAMPLES

-- https://www.youtube.com/watch?v=85pG_pDkITY

-- ALTER TABLE flogger.foods
-- ALTER COLUMN constructor_type TYPE constructor_type USING constructor_type::constructor_type

-- INSERT INTO flogger.users(nickname, years, last_login)
-- VALUES ('Tutu', 35, current_timestamp);

-- CREATE VIEW flogger.test AS
--     SELECT nickname FROM flogger.users WHERE name IS NOT NULL;

-- CREATE INDEX test_id ON test(column_test, column_test2)
