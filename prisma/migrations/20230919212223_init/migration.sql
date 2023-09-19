-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "main";

-- CreateEnum
CREATE TYPE "flogger"."constructor_type" AS ENUM ('builder', 'regulatory', 'energy_foods');

-- CreateEnum
CREATE TYPE "flogger"."portion_type" AS ENUM ('unit', 'grams', 'mililiter');

-- CreateTable
CREATE TABLE "flogger"."consumed" (
    "id" SERIAL NOT NULL,
    "iduser" INTEGER NOT NULL,
    "iddish" INTEGER NOT NULL,
    "quantity" SMALLINT NOT NULL,
    "eatenat" TIMESTAMPTZ(6) NOT NULL,
    "createdat" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "consumed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flogger"."dish" (
    "id" SERIAL NOT NULL,
    "iduser" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" VARCHAR,
    "createdat" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMPTZ(6),

    CONSTRAINT "dish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flogger"."dishhasfoods" (
    "id" SERIAL NOT NULL,
    "iddish" INTEGER NOT NULL,
    "idfood" INTEGER NOT NULL,
    "quantity" SMALLINT NOT NULL,
    "createdat" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "dishhasfoods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flogger"."foods" (
    "id" SERIAL NOT NULL,
    "iduser" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" VARCHAR,
    "image" VARCHAR,
    "calories" REAL NOT NULL,
    "carbohydrates" REAL NOT NULL,
    "protein" REAL NOT NULL,
    "fat" REAL NOT NULL,
    "sugar" REAL NOT NULL,
    "portiontype" "flogger"."portion_type" NOT NULL,
    "constructortype" "flogger"."constructor_type" NOT NULL,
    "portionquantity" DECIMAL NOT NULL,
    "price" DECIMAL,
    "unit" SMALLINT NOT NULL,
    "createdat" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMPTZ(6),

    CONSTRAINT "foods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flogger"."goal" (
    "id" SERIAL NOT NULL,
    "iduser" INTEGER NOT NULL,
    "goal" DECIMAL NOT NULL,
    "date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "goal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flogger"."weight" (
    "id" SERIAL NOT NULL,
    "iduser" INTEGER NOT NULL,
    "weight" DECIMAL NOT NULL,
    "date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "weight_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "main"."users" (
    "id" SERIAL NOT NULL,
    "firstname" VARCHAR(50),
    "lastname" VARCHAR(50),
    "nickname" VARCHAR(20) NOT NULL,
    "email" VARCHAR(50),
    "login" VARCHAR(20) NOT NULL,
    "hash" VARCHAR(100) NOT NULL,
    "birthdate" TIMESTAMPTZ(6),
    "lastlogin" TIMESTAMPTZ(6),
    "createdat" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedat" TIMESTAMPTZ(6),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_login_key" ON "main"."users"("login");

-- AddForeignKey
ALTER TABLE "flogger"."consumed" ADD CONSTRAINT "consumed_iddish_fkey" FOREIGN KEY ("iddish") REFERENCES "flogger"."dish"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."consumed" ADD CONSTRAINT "consumed_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "main"."users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."dish" ADD CONSTRAINT "dish_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "main"."users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."dishhasfoods" ADD CONSTRAINT "dishhasfoods_iddish_fkey" FOREIGN KEY ("iddish") REFERENCES "flogger"."dish"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."dishhasfoods" ADD CONSTRAINT "dishhasfoods_idfood_fkey" FOREIGN KEY ("idfood") REFERENCES "flogger"."foods"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."foods" ADD CONSTRAINT "foods_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "main"."users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."goal" ADD CONSTRAINT "goal_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "main"."users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flogger"."weight" ADD CONSTRAINT "weight_iduser_fkey" FOREIGN KEY ("iduser") REFERENCES "main"."users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
