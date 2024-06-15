-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Here are the queries that I'd imagine most of the users will probably run on the 'car' database

-- 1. What are the top 100 most fuel-efficient cars sold in 2024?
SELECT "make", "model", "combined_mpg" FROM "car_fuel_efficiency"
WHERE "model_id" IN (
    SELECT "model_id" FROM "car_performance_specs"
    WHERE "year" = 2024
)
ORDER BY "combined_mpg" DESC
LIMIT 10;

-- 2. What are the latest available crossover models (model year 2023 and 2024)?
SELECT "make", "model", "vehicle_class"
FROM "car_performance_specs"
WHERE "vehicle_class" LIKE '%small sport utility vehicle%'
AND "year" IN (2023, 2024)
ORDER BY "year" DESC
LIMIT 100;

-- 3. What are the latest sports cars that have been released into the market?
SELECT "make", "model", "vehicle_class", "cylinders", "transmission", "year"
FROM "car_performance_specs"
WHERE "vehicle_class" = 'Two Seaters'
ORDER BY "year" DESC
LIMIT 100;

-- 4. What are the latest hybrid vehicles available?
SELECT "make", "model", "vehicle_class", "year"
FROM "car_performance_specs"
WHERE "model" LIKE '%hybrid%'
ORDER BY "year" DESC
LIMIT 100;

-- 5. What are the latest electric vehicles out in the market?
SELECT "make", "model", "vehicle_class", "fuel_type", "year"
FROM "car_performance_specs"
WHERE "fuel_type" = 'Electricity'
ORDER BY "year" DESC
LIMIT 100;
