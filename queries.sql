/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals ; 

-- queries for my animals table
Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--start transaction 
BEGIN;

-- update species column to unspecified

UPDATE animals SET species = 'unspecified';

ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

BEGIN;

-- Delete all records in the animals table, then roll back the transaction.
DELETE FROM animals;

ROLLBACK;

--begin transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT origin;


-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT origin;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name FROM animals AS a INNER JOIN species AS s ON species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT a.name, o.full_name FROM animals AS a RIGHT JOIN owners As o ON owner_id = o.id;

-- How many animals are there per species?
SELECT s.name, COUNT(a.name) FROM animals AS a INNER JOIN species AS s ON species_id = s.id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name FROM animals AS a INNER JOIN owners AS o ON owner_id = o.id INNER JOIN species AS s ON species_id = s.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT o.full_name AS owner,a.name AS  Not_Tried_To_ESCAPE FROM animals AS a INNER JOIN owners As o ON owner_id = o.id 
WHERE full_name = 'Dean Winchester' and escape_attempts = 0 ;

-- Who owns the most animals?
SELECT o.full_name AS owner,COUNT(*) as owns   FROM animals AS a INNER JOIN owners As o ON owner_id = o.id  
GROUP BY o.full_name ORDER BY owns DESC LIMIT 1  ;











