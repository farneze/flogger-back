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


CREATE TABLE flogger.users(
	id 			SERIAL,
	first_name	VARCHAR(50),
	last_name	VARCHAR(50),
	nickname	VARCHAR(20)     NOT NULL,
	years		SMALLINT        NOT NULL,
	last_login	TIMESTAMPTZ,
	created_at	TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
	updated_at	TIMESTAMPTZ,

    PRIMARY KEY (id)
);

CREATE TABLE flogger.country(
    id 			    SERIAL,
    name            VARCHAR,
    iso_3166_code   VARCHAR,
    flag            VARCHAR,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,

    PRIMARY KEY (id)
);

CREATE TABLE flogger.foods(
    id 			        SERIAL,
    id_users	        INTEGER             NOT NULL,
    name                VARCHAR(100)        NOT NULL,
    description	        VARCHAR,
    image	            VARCHAR,
    calories	        REAL                NOT NULL,
    carbohydrates	    REAL                NOT NULL,
    protein	            REAL                NOT NULL,
    fat	                REAL                NOT NULL,
    sugar	            REAL                NOT NULL,
    portion_type	    flogger.PORTION_TYPE        NOT NULL,
    constructor_type	flogger.CONSTRUCTOR_TYPE    NOT NULL,
    portion_quantity	SMALLINT            NOT NULL,
    price	            SMALLINT            NOT NULL,
    unit	            SMALLINT            NOT NULL,
    is_dish	            BOOLEAN             NOT NULL,
    server_default	    BOOLEAN,
    id_country	        INTEGER             NOT NULL,
    created_at	        TIMESTAMPTZ         NOT NULL DEFAULT current_timestamp,
    updated_at	        TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (id_users) REFERENCES flogger.users(id),
    FOREIGN KEY (id_country) REFERENCES flogger.country(id)
);

CREATE TABLE flogger.dish(
    id 			        SERIAL,
    id_users	        INTEGER         NOT NULL,
    name                VARCHAR(100)    NOT NULL,
    description	        VARCHAR,
    created_at	        TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
    updated_at	        TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (id_users) REFERENCES flogger.users(id)
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

CREATE TABLE flogger.dish_has_foods(
    id_dish     INTEGER     NOT NULL,
    id_food     INTEGER     NOT NULL,
    quantity    SMALLINT    NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,

    PRIMARY KEY (id_dish, id_food),
    FOREIGN KEY (id_dish) REFERENCES flogger.dish(id),
    FOREIGN KEY (id_food) REFERENCES flogger.foods(id)
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
