/* Database schema to keep the structure of entire database. */



CREATE DATABASE vet_clinic; -- Create the database

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY (id)
);

--add a column species_id to the animals tables
ALTER TABLE animals ADD COLUMN species VARCHAR(30);
