# sql_joins_syntax_heroes
SQL practice
-- hero table
CREATE TABLE heroes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    alias VARCHAR(200)
);

-- hero identity data
INSERT INTO heroes (name, alias) 
VALUES ('Superman', 'Clark Kent'),
('Batman', 'Bruce Wayne'),
('Professor X', 'Charles Xavier'),
('Wolverine', 'Logan'),
('Cyclops', 'Scott Summers');

SELECT * FROM heroes;

-- powers table
CREATE TABLE powers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    description VARCHAR(255)
);

-- powers data
INSERT INTO powers (name, description)
VALUES 
('Flight', 'Can fly'), 
('Telekinesis', 'Can physically move things with the mind'), 
('Healing Factor', 'Heals at an accelerated rate'),
('Super Strength', 'Abnormally physically strong'),
('Super Intelligence', 'Way, way, way smarter than the average bear'),
('Telepathy', 'Can communicate mentally with another being'),
('Laser Vision', 'Emits energy beams from the eyes'),
('Super Speed', 'Faster than a speeding bullet');

SELECT * FROM powers;


CREATE TABLE heroes_powers (
    id SERIAL PRIMARY KEY,
    hero_id INT REFERENCES heroes,
    power_id INT REFERENCES powers,
    power_level INT
);

-- Now, assign powers to heroes
INSERT INTO heroes_powers (hero_id, power_id, power_level)
VALUES 
(1,1,5), (1,4,5), (1,7,1), (1,8,3),
(2,5,5), (2,4,4), (2,8,1),
(3,2,4), (3,6,5), (3,5,5),
(4,3,5), (4,4,2),
(5,4,2), (5,7,5), (5,8,1);

-- 1. How many powers are there?
SELECT COUNT(name) from powers;
-- 2. List all heroes and their powers. It's okay that heroes appear multiple times.
SELECT hero_id, power_id, heroes.name, powers.name FROM heroes_powers
JOIN heroes on heroes.id = heroes_powers.hero_id
JOIN powers on powers.id = heroes_powers.power_id
ORDER BY heroes.id;
-- 3. Find all of Professor X's powers.
SELECT hero_id, power_id, heroes.name, powers.name FROM heroes_powers
JOIN heroes on heroes.id = heroes_powers.hero_id
JOIN powers on powers.id = heroes_powers.power_id
WHERE heroes.name='Professor X';
-- 4. Add a new super power. 
INSERT INTO powers (name, description)
VALUES 
('Zoolingual', 'Can speak to animals');
-- 5. Add this power to an existing hero.
INSERT INTO heroes_powers(hero_id, power_id, power_level)
VALUES
(2, 9, 4);
-- 6. Which heroes have laser vision? Include their name and alias.
SELECT hero_id, power_id, heroes.name, heroes.alias, powers.name FROM heroes_powers
JOIN heroes on heroes.id = heroes_powers.hero_id
JOIN powers on powers.id = heroes_powers.power_id
WHERE powers.name = 'Laser Vision';
-- 7. How many can fly? A twist on the above...
SELECT hero_id, power_id, heroes.name, heroes.alias, powers.name FROM heroes_powers
JOIN heroes on heroes.id = heroes_powers.hero_id
JOIN powers on powers.id = heroes_powers.power_id
WHERE powers.name = 'Flight';
-- 8. What is the average super strength power level?
SELECT AVG(power_level) from heroes_powers;
-- 9. Show all the information for heroes with super strength power level over 2.
SELECT * FROM heroes_powers 
JOIN heroes on heroes.id = heroes_powers.hero_id
JOIN powers on powers.id = heroes_powers.power_id 
WHERE power_level > 2; 
-- 10. Find the average power level for all powers. Include the power name and descriptions.
