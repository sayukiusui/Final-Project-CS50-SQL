-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Table for the car's Make (Manufacturer)
CREATE TABLE "make" (
    "id" INTEGER,
    "make" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Table for the car's model
CREATE TABLE "model" (
    "id" INTEGER,
    "model" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Table for the car's performance specs
CREATE TABLE "performance_specs" (
    "id" INTEGER,
    "make_id" INTEGER,
    "model_id" INTEGER,
    "cylinders" INTEGER,
    "engine_displacement" NUMERIC,
    "drivetrain" TEXT NOT NULL,
    "fuel_type" TEXT NOT NULL, 
    "transmission" TEXT NOT NULL,
    "vehicle_class" TEXT NOT NULL,
    "year" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("make_id") REFERENCES "make"("id"),
    FOREIGN KEY("model_id") REFERENCES "model"("id")
);

-- Table for the car's fuel efficiency specs
CREATE TABLE "fuel_efficiency" (
    "id" INTEGER,
    "make_id" INTEGER,
    "model_id" INTEGER,
    "annual_fuel" NUMERIC NOT NULL,
    "city_mpg" INTEGER NOT NULL,
    "combined_mpg" INTEGER NOT NULL,
    "highway_mpg" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("make_id") REFERENCES "make"("id"),
    FOREIGN KEY("model_id") REFERENCES "model"("id")
);

-- View for the Performance Specs
CREATE VIEW "car_performance_specs" AS
SELECT * FROM "performance_specs"
JOIN "make" ON "performance_specs"."make_id" = "make"."id"
JOIN "model" ON "performance_specs"."model_id" = "model"."id";

-- View for the Fuel Efficiency
CREATE VIEW "car_fuel_efficiency" AS
SELECT * FROM "fuel_efficiency"
JOIN "make" ON "fuel_efficiency"."make_id" = "make"."id"
JOIN "model" ON "fuel_efficiency"."model_id" = "model"."id";

-- Necessary Indexes
CREATE INDEX "performance_make_model" ON "performance_specs"("make_id", "model_id");
CREATE INDEX "fuel_efficiency_make_model" ON "fuel_efficiency"("make_id", "model_id");

-- Create necessary temp tables
.import --csv Make.csv make_temp
.import --csv Model.csv model_temp
.import --csv "Performance Specs.csv" specs_temp
.import --csv "Fuel Efficiency.csv" fuel_temp

-- Import all the necessary data
INSERT INTO "make"("id", "make")
SELECT "ID", "Make" FROM "make_temp";

INSERT INTO "model"("id", "model")
SELECT "ID", "Model" FROM "model_temp";

INSERT INTO "performance_specs"("id", "make_id", "model_id", "cylinders", "engine_displacement",
                                "drivetrain", "fuel_type", "transmission", "vehicle_class", "year")
SELECT "ID", "Make ID", "Model ID", "Cylinders", "Engine displacement", "Drive",
       "Fuel Type1", "Transmission", "Vehicle Size Class", "Year" FROM "specs_temp";

INSERT INTO "fuel_efficiency"("id", "make_id", "model_id", "annual_fuel", "city_mpg", "combined_mpg", "highway_mpg")
SELECT "ID", "Make ID", "Model ID", "Annual Petroleum Consumption For Fuel Type1", "City Mpg For Fuel Type1",
       "Combined Mpg For Fuel Type1", "Highway Mpg For Fuel Type1" FROM "fuel_temp";

-- Drop temp tables
DROP TABLE "make_temp";
DROP TABLE "model_temp";
DROP TABLE "specs_temp";
DROP TABLE "fuel_temp";
