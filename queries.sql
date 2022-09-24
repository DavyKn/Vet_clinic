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

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.visit_date FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT  COUNT(DISTINCT animals.name), vets.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, vets.name, visits.visit_date FROM animals
JOIN visits on animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id WHERE vets.name ='Stephanie Mendez' 
AND visits.visit_date BETWEEN 'April 1, 2020' AND 'August 30, 2020';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.animal_id) AS visits_no FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visits_no DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.visit_date  FROM animals
JOIN visits on animals.id = visits.animal_id
JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date  LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, animals.date_of_birth,
animals.escape_attempts, animals.neutered, 
animals.weight_kg, species.name AS species,
owners.full_name AS owner, vets.name AS vet_name, vets.age,
vets.date_of_graduation AS grad_day,
visits.visit_date FROM animals
JOIN visits ON  animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
ORDER BY visits.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT  COUNT(visits.animal_id) FROM visits JOIN animals 
ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations 
    WHERE vet_id = vets.id
    );

  -- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
  SELECT species.name as advisable_specialization, COUNT(animals.species_id) as visit_no FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_no  DESC
LIMIT 1;















