/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Agumon', '2020-02-03', 0,true, 10.23),
('Gabumon', '2018-11-15', 2,true, 8),
('Pikachu', '2021-01-07', 1,false, 15.04),
('Devimon', '2017-05-12', 5,true, 11);

-- inserting more data of animals

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Charmander', '2020-02-08', 0,false, -11),
('Plantmon', '2021-11-15', 2,true, -5.7),
('Squirtle', '1993-04-02', 3,false, -12.13),
('Angemon', '2005-06-12', 1,true, -45),
('Boarmon', '2005-06-07', 7,true, 20.04),
('Blossom', '1998-10-13', 3,true, 17),
('Ditto','2022-05-14',4,true,22);

-- Insert the following data into the owners table
INSERT INTO owners (full_name,age) VALUES ('Sam Smith',34),
('Jennifer Orwell',19),
('Bob',45),
('Melody Pond',77),
('Dean Winchester',14),
('Jodie Whittaker',38);

-- Insert the following data into the species table
INSERT INTO species (name) VALUES ('Pokemon'),
('Digimon');

-- Modify your inserted animals so it includes the species_id value:
UPDATE animals SET species_id = 2  WHERE name LIKE '%mon'; 

-- All other animals are Pokemon
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id)
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN('Gabumon','Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

-- Insert the following data for vets
INSERT INTO vets (name,age,date_of_graduation)
 VALUES ('William Tatcher',45,'2000-04-23'),
('Maisy Smith',26,'2019-01-17'),
('Stephanie Mendez',64,'1981-05-04'),
('Jack Harkness',38,'2008-02-14');

--insert data for specialities

INSERT INTO specializations (vet_id, species_id) 
VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id FROM species WHERE name = 'Digimon'));


--inserting visits data into table
INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May 24, 2020'),
       ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'July 22, 2020'),
       ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'February 2, 2021'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'January 5, 2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'March 8, 2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May 14, 2020'),
       ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 4, 2021'),
      ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'February 24, 2021'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'December 21, 2019'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'August 10, 2020'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'April 7, 2021'),
      ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'September 29, 2019'),
      ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'October 3, 2020'),
      ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'November 4, 2020'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'January 24, 2019'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), ' May 15, 2019'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'February 27, 2020'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'August 3, 2020'),
      ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 24, 2020'),
      ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'January 11, 2021');






