-- Database: wyrd_db

-- DROP DATABASE IF EXISTS wyrd_db;

-- CREATE DATABASE wyrd_db
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

-- USE wyrd_db;

CREATE SCHEMA main;

CREATE TABLE main.users(
	id 			SERIAL,
	firstName	VARCHAR(50),
	lastName	VARCHAR(50),
	nickname	VARCHAR(20)     NOT NULL,
	email   	VARCHAR(50),
    login       VARCHAR(20)     UNIQUE,
    hash        VARCHAR(100)    NOT NULL,
	createdAt	TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
	updatedAt	TIMESTAMPTZ,

    PRIMARY KEY (id)
);

CREATE SCHEMA flogger;

CREATE TYPE flogger.CONSTRUCTOR_TYPE AS ENUM
('builder', 'regulatory', 'energy_foods');

CREATE TYPE flogger.PORTION_TYPE AS ENUM
('unit', 'kilograms', 'grams', 'liter', 'mililiter');

CREATE TABLE flogger.users(
	id 			SERIAL,
    idUser	    INTEGER         NOT NULL,
	birthdate   TIMESTAMPTZ,
	lastLogin	TIMESTAMPTZ,
	createdAt	TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
	updatedAt	TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (idUser) REFERENCES main.users(id)
);

CREATE TABLE flogger.weight(
    id 			        SERIAL,
    idFloggerUser	    INTEGER             NOT NULL,
    weight	            NUMERIC             NOT NULL,
    date	            TIMESTAMPTZ         NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (idFloggerUser) REFERENCES flogger.users(id)
);

CREATE TABLE flogger.goal(
    id 			        SERIAL,
    idFloggerUser	    INTEGER             NOT NULL,
    goal	            NUMERIC             NOT NULL,
    date	            TIMESTAMPTZ         NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (idFloggerUser) REFERENCES flogger.users(id)
);

CREATE TABLE flogger.foods(
    id 			        SERIAL,
    idFloggerUser	    INTEGER             NOT NULL,
    name                VARCHAR(100)        NOT NULL,
    description	        VARCHAR,
    image	            VARCHAR,
    calories	        REAL                NOT NULL,
    carbohydrates	    REAL                NOT NULL,
    protein	            REAL                NOT NULL,
    fat	                REAL                NOT NULL,
    sugar	            REAL                NOT NULL,
    portionType	        flogger.PORTION_TYPE        NOT NULL,
    constructorType	    flogger.CONSTRUCTOR_TYPE    NOT NULL,
    portionQuantity     NUMERIC             NOT NULL,
    price	            NUMERIC,
    unit	            SMALLINT            NOT NULL,
    createdAt	        TIMESTAMPTZ         NOT NULL DEFAULT current_timestamp,
    updatedAt	        TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (idFloggerUser) REFERENCES flogger.users(id)
);

CREATE TABLE flogger.dish(
    id 			    SERIAL,
    idFloggerUser   INTEGER         NOT NULL,
    name            VARCHAR(100)    NOT NULL,
    description     VARCHAR,
    createdAt	    TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
    updatedAt	    TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (idFloggerUser) REFERENCES flogger.users(id)
);

CREATE TABLE flogger.dishHasFoods(
    id 		    SERIAL,
    idDish      INTEGER     NOT NULL,
    idFood      INTEGER     NOT NULL,
    quantity    SMALLINT    NOT NULL,
    createdAt   TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,

    PRIMARY KEY (id),
    FOREIGN KEY (idDish) REFERENCES flogger.dish(id),
    FOREIGN KEY (idFood) REFERENCES flogger.foods(id)
);

CREATE TABLE flogger.consumed(
    id 		    SERIAL,
    idDish      INTEGER     NOT NULL,
    quantity    SMALLINT    NOT NULL,
    eatenAt     TIMESTAMPTZ NOT NULL,
    createdAt   TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    
    PRIMARY KEY (id),
    FOREIGN KEY (idDish) REFERENCES flogger.dish(id)
);

INSERT INTO main.users(nickname, login, hash)
VALUES ('Tutucuruco', 'tutudefeijao', '$argon2id$v=19$m=65536,t=3,p=4$jHn7YOxdwOq7rVWMXaHGew$sWuSZphb8n0iZr3x1GG/LezMggoEihme9TaMEp79mi0');

INSERT INTO flogger.users(idUser, birthdate)
VALUES (1, '1991-05-05 03:44:23.790 -0300');

INSERT INTO flogger.weight(weight, idFloggerUser, date)    
VALUES (133.01, 1, '2023-08-29 03:44:23.790 -0300');

INSERT INTO flogger.goal(goal, idFloggerUser, date)    
VALUES (2000.01, 1, '2023-08-29 03:44:23.790 -0300');

INSERT INTO flogger.foods(name, idFloggerUser, calories, carbohydrates, protein, fat, sugar, portionType, constructorType, portionQuantity, price, unit)
VALUES ('batata', 1, 5, 6, 7, 8, 9, 'unit', 'builder', 10, 1, 1);

INSERT INTO flogger.foods(name, idFloggerUser, calories, carbohydrates, protein, fat, sugar, portionType, constructorType, portionQuantity, price, unit)
VALUES ('ovo', 1, 1, 2, 3, 4, 5, 'grams', 'energy_foods', 11, 2, 1);

INSERT INTO flogger.foods(name, idFloggerUser, calories, carbohydrates, protein, fat, sugar, portionType, constructorType, portionQuantity, price, unit)
VALUES ('leite', 1, 3, 2, 4, 1, 5, 'liter', 'regulatory', 81, 20, 17);

INSERT INTO flogger.dish(name, idFloggerUser)    
VALUES ('batata com ovo', 1);

INSERT INTO flogger.dish(name, idFloggerUser)
VALUES ('ovo com leite', 1);

INSERT INTO flogger.dish(name, idFloggerUser)
VALUES ('leite com batata', 1);

INSERT INTO flogger.dish(name, idFloggerUser)
VALUES ('batata', 1);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (1, 1, 1);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (1, 2, 2);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (2, 2, 3);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (2, 3, 4);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (3, 2, 5);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (3, 1, 6);

INSERT INTO flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (4, 1, 1);

INSERT INTO flogger.consumed(idDish, quantity, eatenAt)
VALUES (1, 1, current_timestamp);

INSERT INTO flogger.consumed(idDish, quantity, eatenAt)
VALUES (3, 3, current_timestamp);

INSERT INTO flogger.consumed(idDish, quantity, eatenAt)
VALUES (3, 3, current_timestamp);