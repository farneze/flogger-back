-- CreateTable
CREATE TABLE "consumed" (
    "id_dish" INTEGER NOT NULL,
    "quantity" SMALLINT NOT NULL,
    "eaten_at" TIMESTAMP(6) NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "country" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR,
    "iso_3166_code" VARCHAR,
    "flag" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dish" (
    "id" SERIAL NOT NULL,
    "id_users" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6),

    CONSTRAINT "dish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dish_has_foods" (
    "id_dish" INTEGER NOT NULL,
    "id_food" INTEGER NOT NULL,
    "quantity" SMALLINT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "foods" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" VARCHAR,
    "image" VARCHAR,
    "calories" REAL NOT NULL,
    "carbohydrates" REAL NOT NULL,
    "protein" REAL NOT NULL,
    "fat" REAL NOT NULL,
    "sugar" REAL NOT NULL,
    "is_solid" BOOLEAN NOT NULL,
    "portion_type" portion_type NOT NULL,
    "constructor_type" constructor_type NOT NULL,
    "portion_quantity" SMALLINT NOT NULL,
    "price" SMALLINT NOT NULL,
    "unit" SMALLINT NOT NULL,
    "is_dish" BOOLEAN NOT NULL,
    "server_default" BOOLEAN,
    "id_country" INTEGER NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6),

    CONSTRAINT "foods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "first_name" VARCHAR(50),
    "last_name" VARCHAR(50),
    "nickname" VARCHAR(20) NOT NULL,
    "years" SMALLINT NOT NULL,
    "last_login" TIMESTAMP(6),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "consumed" ADD CONSTRAINT "consumed_id_dish_fkey" FOREIGN KEY ("id_dish") REFERENCES "dish"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dish" ADD CONSTRAINT "dish_id_users_fkey" FOREIGN KEY ("id_users") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dish_has_foods" ADD CONSTRAINT "dish_has_foods_id_dish_fkey" FOREIGN KEY ("id_dish") REFERENCES "dish"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dish_has_foods" ADD CONSTRAINT "dish_has_foods_id_food_fkey" FOREIGN KEY ("id_food") REFERENCES "foods"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "foods" ADD CONSTRAINT "foods_id_country_fkey" FOREIGN KEY ("id_country") REFERENCES "country"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
