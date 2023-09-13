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
	firstName	VARCHAR(50),
	lastName	VARCHAR(50),
	nickname	VARCHAR(20)     NOT NULL,
	age		    SMALLINT        NOT NULL,
    email       VARCHAR(50)     UNIQUE,
    hash        VARCHAR(100)    NOT NULL,
	lastLogin	TIMESTAMPTZ,
	createdAt	TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
	updatedAt	TIMESTAMPTZ,

    PRIMARY KEY (id)
);

CREATE TABLE flogger.foods(
    id 			        SERIAL,
    idUsers	            INTEGER             NOT NULL,
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
    portionQuantity     SMALLINT            NOT NULL,
    price	            SMALLINT            NOT NULL,
    unit	            SMALLINT            NOT NULL,
    createdAt	        TIMESTAMPTZ         NOT NULL DEFAULT current_timestamp,
    updatedAt	        TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (idUsers) REFERENCES flogger.users(id)
);

CREATE TABLE flogger.dish(
    id 			SERIAL,
    idUsers	    INTEGER         NOT NULL,
    name        VARCHAR(100)    NOT NULL,
    description VARCHAR,
    createdAt	TIMESTAMPTZ     NOT NULL DEFAULT current_timestamp,
    updatedAt	TIMESTAMPTZ,

    PRIMARY KEY (id),
    FOREIGN KEY (idUsers) REFERENCES flogger.users(id)
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

INSERT INTO flogger.users(nickname, age, email, hash)
VALUES ('Tutu', 35, 'arthur@hotmal.com', 'ausdhasuighsdufygsd');

insert into flogger.foods(name, idUsers, calories, carbohydrates, protein, fat, sugar, portionType, constructorType, portionQuantity, price, unit)
VALUES ('batata', 1, 5, 6, 7, 8, 9, 'unit', 'builder', 10, 1, 1);

insert into flogger.foods(name, idUsers, calories, carbohydrates, protein, fat, sugar, portionType, constructorType, portionQuantity, price, unit)
VALUES ('ovo', 1, 1, 2, 3, 4, 5, 'grams', 'energy_foods', 11, 2, 1);

insert into flogger.foods(name, idUsers, calories, carbohydrates, protein, fat, sugar, portionType, constructorType, portionQuantity, price, unit)
VALUES ('leite', 1, 3, 2, 4, 1, 5, 'liter', 'regulatory', 81, 20, 17);

insert into flogger.dish(name, idUsers)    
VALUES ('batata com ovo', 1);

insert into flogger.dish(name, idUsers)
VALUES ('ovo com leite', 1);

insert into flogger.dish(name, idUsers)
VALUES ('leite com batata', 1);

insert into flogger.dish(name, idUsers)
VALUES ('batata', 1);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (1, 1, 1);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (1, 2, 2);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (2, 2, 3);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (2, 3, 4);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (3, 2, 5);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (3, 1, 6);

insert into flogger.dishHasFoods(idDish, idFood, quantity)
VALUES (4, 1, 1);

insert into flogger.consumed(idDish, quantity, eatenAt)
VALUES (1, 1, current_timestamp);

insert into flogger.consumed(idDish, quantity, eatenAt)
VALUES (3, 3, current_timestamp);

insert into flogger.consumed(idDish, quantity, eatenAt)
VALUES (3, 3, current_timestamp);