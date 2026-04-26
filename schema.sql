-- schema for DB starting March 16
CREATE TABLE Family (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    BaseCity VARCHAR(255) NOT NULL
);

CREATE TABLE Crew (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Capo VARCHAR(255) NOT NULL,
    FamilyID INT NOT NULL,
    CONSTRAINT fk_Family
    FOREIGN KEY (FamilyID)  
    REFERENCES Family(id)
);

CREATE TABLE Mobster (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Moniker VARCHAR(255),
    `Rank` VARCHAR(255) NOT NULL,
    Status VARCHAR(255) NOT NULL,
    CrewID INT NOT NULL,
    CONSTRAINT fk_Crew
    FOREIGN KEY (CrewID)
    REFERENCES Crew(id)
);

-- March 18 -  Finished schema and started Inserts

CREATE TABLE KnownAssociate (
    id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    RelationType VARCHAR(255) NOT NULL,
    MobsterID INT NOT NULL,
    CONSTRAINT fk_Mobster
    FOREIGN KEY (MobsterID)
    REFERENCES Mobster(id)
);

CREATE TABLE BusinessFront (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Industry VARCHAR(255) NOT NULL,
    StreetAddress VARCHAR(255) NOT NULL
);

CREATE TABLE CollectionLog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Amount FLOAT NOT NULL,
    DateCollected DATE NOT NULL,
    MobsterID INT NOT NULL,
    CONSTRAINT fk_MobsterID
    FOREIGN KEY (MobsterID)
    REFERENCES Mobster(id),
    BusinessID INT NOT NULL,
    CONSTRAINT fk_BusinessID
    FOREIGN KEY (BusinessID)
    REFERENCES BusinessFront(id)
);

INSERT INTO Family (Name, BaseCity)
VALUES ('DiMeo', 'North Jersey');

INSERT INTO Family (Name, BaseCity)
VALUES ('Lupertazzi', 'New York City');

INSERT INTO Crew (Name, Capo, FamilyID)
VALUES ('Soprano', 'Anthony Soprano', 1);

INSERT INTO Crew (Name, Capo, FamilyID)
VALUES ('Aprile', 'Giacomo Aprile', 1);

INSERT INTO Crew (Name, Capo, FamilyID)
VALUES ('Junior', 'Corrado Soprano', 1);

-- March 19 
INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Anthony', 'Soprano', 'Tony', 'Capo', 'Active', 1);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Giacomo', 'Aprile', 'Jackie', 'Acting Boss', 'Active', 2);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Peter', 'Gualtieri', 'Paulie Walnuts', 'Soldier', 'Active', 1);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Silvio', 'Dante', 'Sil', 'Soldier', 'Active', 1); 

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Salvatore', 'Bompansiero', 'Pussy', 'Soldier', 'Informant', 1);

-- S1E1 FBI intelligence snapshot (additional tracked characters)
INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Corrado', 'Soprano', 'Junior', 'Capo', 'In Streets', 3);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Christopher', 'Moltisanti', 'Chrissy', 'Associate', 'In Streets', 1);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Mikey', 'Palmice', NULL, 'Soldier', 'In Streets', 3);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Lawrence', 'Barese', 'Larry Boy', 'Capo', 'In Streets', 1);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Jimmy', 'Altieri', NULL, 'Capo', 'In Streets', 1);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Raymond', 'Curto', NULL, 'Capo', 'In Streets', 1);

-- Off-screen but known to law enforcement during S1E1 timeframe
INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Richie', 'Aprile', NULL, 'Soldier', 'In Jail', 2);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Tony', 'Blundetto', 'Tony B', 'Associate', 'In Jail', 1);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Feech', 'La Manna', NULL, 'Capo', 'In Jail', 1);

-- Historical context record
INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
VALUES ('Richard', 'Moltisanti', 'Dickie', 'Soldier', 'Deceased', 1);

-- S1E1 intelligence roster additions (off-screen but plausibly known to FBI)
INSERT INTO Crew (Name, Capo, FamilyID)
SELECT 'Lupertazzi', 'Carmine Lupertazzi Sr.', 2
WHERE NOT EXISTS (
    SELECT 1 FROM Crew WHERE Name = 'Lupertazzi' AND FamilyID = 2
);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Ercole', 'DiMeo', 'Eckley', 'Boss', 'In Jail', 1
WHERE NOT EXISTS (
    SELECT 1 FROM Mobster WHERE FirstName = 'Ercole' AND LastName = 'DiMeo'
);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Herman', 'Rabkin', 'Hesh', 'Associate', 'In Streets', 1
WHERE NOT EXISTS (
    SELECT 1 FROM Mobster WHERE FirstName = 'Herman' AND LastName = 'Rabkin'
);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Gennaro', 'Malanga', 'Little Pussy', 'Associate', 'Unknown', 3
WHERE NOT EXISTS (
    SELECT 1 FROM Mobster WHERE FirstName = 'Gennaro' AND LastName = 'Malanga'
);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Joseph', 'Sasso', 'Beppy', 'Underboss', 'In Streets', 2
WHERE NOT EXISTS (
    SELECT 1 FROM Mobster WHERE FirstName = 'Joseph' AND LastName = 'Sasso'
);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Carmine', 'Lupertazzi Sr.', 'Carmine', 'Boss', 'In Streets',
       (SELECT id FROM Crew WHERE Name = 'Lupertazzi' AND FamilyID = 2 LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM Mobster WHERE FirstName = 'Carmine' AND LastName = 'Lupertazzi Sr.'
);

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'John', 'Sacrimoni', 'Johnny Sack', 'Underboss', 'In Streets',
       (SELECT id FROM Crew WHERE Name = 'Lupertazzi' AND FamilyID = 2 LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM Mobster WHERE FirstName = 'John' AND LastName = 'Sacrimoni'
);

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
VALUES ('Angela', 'Bompansiero', 'Spouse', 5);

-- Expanded known associates (FBI-style intelligence web)
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Carmela', 'Soprano', 'Spouse', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Meadow', 'Soprano', 'Daughter', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano Jr.', 'Son', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Livia', 'Soprano', 'Mother', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Corrado', 'Soprano', 'Uncle', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Janice', 'Soprano', 'Sister', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Christopher', 'Moltisanti', 'Protege', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Silvio', 'Dante', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Peter', 'Gualtieri', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Herman', 'Rabkin', 'Advisor', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Artie', 'Bucco', 'Civilian Friend', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jennifer', 'Melfi', 'Therapist', id FROM Mobster WHERE FirstName = 'Anthony' AND LastName = 'Soprano';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Rosalie', 'Aprile', 'Spouse', id FROM Mobster WHERE FirstName = 'Giacomo' AND LastName = 'Aprile';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jackie', 'Aprile Jr.', 'Son', id FROM Mobster WHERE FirstName = 'Giacomo' AND LastName = 'Aprile';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Richie', 'Aprile', 'Brother', id FROM Mobster WHERE FirstName = 'Giacomo' AND LastName = 'Aprile';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Nucci', 'Gualtieri', 'Mother', id FROM Mobster WHERE FirstName = 'Peter' AND LastName = 'Gualtieri';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Superior', id FROM Mobster WHERE FirstName = 'Peter' AND LastName = 'Gualtieri';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Silvio', 'Dante', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Peter' AND LastName = 'Gualtieri';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Gabriella', 'Dante', 'Spouse', id FROM Mobster WHERE FirstName = 'Silvio' AND LastName = 'Dante';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Superior', id FROM Mobster WHERE FirstName = 'Silvio' AND LastName = 'Dante';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Peter', 'Gualtieri', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Silvio' AND LastName = 'Dante';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Superior', id FROM Mobster WHERE FirstName = 'Salvatore' AND LastName = 'Bompansiero';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Silvio', 'Dante', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Salvatore' AND LastName = 'Bompansiero';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Mikey', 'Palmice', 'Driver-Aide', id FROM Mobster WHERE FirstName = 'Corrado' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Bobby', 'Baccalieri', 'Driver-Aide', id FROM Mobster WHERE FirstName = 'Corrado' AND LastName = 'Soprano';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Livia', 'Soprano', 'Sister-In-Law', id FROM Mobster WHERE FirstName = 'Corrado' AND LastName = 'Soprano';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Adriana', 'La Cerva', 'Fiancee', id FROM Mobster WHERE FirstName = 'Christopher' AND LastName = 'Moltisanti';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Joanne', 'Moltisanti', 'Mother', id FROM Mobster WHERE FirstName = 'Christopher' AND LastName = 'Moltisanti';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Brendan', 'Filone', 'Criminal Associate', id FROM Mobster WHERE FirstName = 'Christopher' AND LastName = 'Moltisanti';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Mentor', id FROM Mobster WHERE FirstName = 'Christopher' AND LastName = 'Moltisanti';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jojo', 'Palmice', 'Spouse', id FROM Mobster WHERE FirstName = 'Mikey' AND LastName = 'Palmice';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Corrado', 'Soprano', 'Crew Superior', id FROM Mobster WHERE FirstName = 'Mikey' AND LastName = 'Palmice';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Albert', 'Barese', 'Cousin', id FROM Mobster WHERE FirstName = 'Lawrence' AND LastName = 'Barese';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Lawrence' AND LastName = 'Barese';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Jimmy' AND LastName = 'Altieri';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Peer', id FROM Mobster WHERE FirstName = 'Raymond' AND LastName = 'Curto';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Giacomo', 'Aprile', 'Brother', id FROM Mobster WHERE FirstName = 'Richie' AND LastName = 'Aprile';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jackie', 'Aprile Jr.', 'Nephew', id FROM Mobster WHERE FirstName = 'Richie' AND LastName = 'Aprile';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Adriana', 'La Cerva', 'Niece', id FROM Mobster WHERE FirstName = 'Richie' AND LastName = 'Aprile';
-- Inference: relationship becomes explicit post-pilot timeframe
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Janice', 'Soprano', 'Romantic Partner', id FROM Mobster WHERE FirstName = 'Richie' AND LastName = 'Aprile';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Cousin', id FROM Mobster WHERE FirstName = 'Tony' AND LastName = 'Blundetto';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Former Associate', id FROM Mobster WHERE FirstName = 'Feech' AND LastName = 'La Manna';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Peter', 'Gualtieri', 'Old Guard Associate', id FROM Mobster WHERE FirstName = 'Feech' AND LastName = 'La Manna';

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Christopher', 'Moltisanti', 'Son', id FROM Mobster WHERE FirstName = 'Richard' AND LastName = 'Moltisanti';
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Joanne', 'Moltisanti', 'Spouse', id FROM Mobster WHERE FirstName = 'Richard' AND LastName = 'Moltisanti';

-- Additional S1E1 research imports (schema-compatible fields only)
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Charmaine', 'Bucco', 'Friend', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Charmaine'
        AND ka.LastName = 'Bucco'
        AND ka.RelationType = 'Friend'
        AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Irina', 'Peltsin', 'Romantic Partner', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Irina'
        AND ka.LastName = 'Peltsin'
        AND ka.RelationType = 'Romantic Partner'
        AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Dick', 'Barone', 'Business Contact', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Dick'
        AND ka.LastName = 'Barone'
        AND ka.RelationType = 'Business Contact'
        AND ka.MobsterID = m.id
  );

-- Carmela/Meadow are not Mobster rows in current schema, so these are attached to Anthony for FBI-family context.
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Father Phil', 'Intintola', 'Spiritual Advisor', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Father Phil'
        AND ka.LastName = 'Intintola'
        AND ka.RelationType = 'Spiritual Advisor'
        AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Hunter', 'Scangarelo', 'Family Friend', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Hunter'
        AND ka.LastName = 'Scangarelo'
        AND ka.RelationType = 'Family Friend'
        AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Emil', 'Kolar', 'Business Contact', m.id
FROM Mobster m
WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Emil'
        AND ka.LastName = 'Kolar'
        AND ka.RelationType = 'Business Contact'
        AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Alex', 'Mahaffey', 'Business Contact', m.id
FROM Mobster m
WHERE m.FirstName = 'Herman' AND m.LastName = 'Rabkin'
  AND NOT EXISTS (
      SELECT 1
      FROM KnownAssociate ka
      WHERE ka.FirstName = 'Alex'
        AND ka.LastName = 'Mahaffey'
        AND ka.RelationType = 'Business Contact'
        AND ka.MobsterID = m.id
  );

-- Additional S1E1 business fronts (schema-compatible fields only)
INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Nuovo Vesuvio', 'Hospitality/Restaurant', 'Elizabeth, NJ'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name = 'Nuovo Vesuvio'
);

INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Kolar Bros. Sanitation', 'Waste Management', 'Unknown (Czech-American Operated)'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name = 'Kolar Bros. Sanitation'
);

INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Blue Cross Blue Shield (HMO Affiliate)', 'Healthcare/Insurance', 'Long Valley, NJ'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name = 'Blue Cross Blue Shield (HMO Affiliate)'
);

INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Green Grove Retirement Community', 'Assisted Living', 'New Jersey'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name = 'Green Grove Retirement Community'
);

INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Centanni''s Meat Market', 'Food/Butcher', 'Elizabeth, NJ'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name = 'Centanni''s Meat Market'
);

-- Keep existing names aligned with research payload (guarded to avoid duplicates)
INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Bada Bing!', 'Adult Entertainment', 'Lodi, NJ'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name IN ('Bada Bing', 'Bada Bing!')
);

-- S1E1 mapping imports + additional plausible pickup logs
INSERT INTO CollectionLog (Amount, DateCollected, MobsterID, BusinessID)
SELECT v.Amount, v.DateCollected, m.id, b.id
FROM (
    SELECT 3200.00 AS Amount, '1998-12-06' AS DateCollected, 'Christopher' AS FirstName, 'Moltisanti' AS LastName, 'Kolar Bros. Sanitation' AS BusinessName
    UNION ALL SELECT 4200.00, '1998-12-14', 'Herman', 'Rabkin', 'Blue Cross Blue Shield (HMO Affiliate)'
    UNION ALL SELECT 2600.00, '1998-12-19', 'Silvio', 'Dante', 'Nuovo Vesuvio'
    UNION ALL SELECT 1800.00, '1998-12-10', 'Corrado', 'Soprano', 'Nuovo Vesuvio'
    UNION ALL SELECT 2100.00, '1998-12-18', 'Anthony', 'Soprano', 'Centanni''s Meat Market'
    UNION ALL SELECT 1400.00, '1998-11-29', 'Peter', 'Gualtieri', 'Satriale''s Pork Store'
    UNION ALL SELECT 1700.00, '1998-12-03', 'Silvio', 'Dante', 'Bada Bing'
    UNION ALL SELECT 2400.00, '1998-12-08', 'Salvatore', 'Bompansiero', 'Barone Sanitation'
    UNION ALL SELECT 1300.00, '1998-12-09', 'Christopher', 'Moltisanti', 'Satriale''s Pork Store'
    UNION ALL SELECT 3500.00, '1998-12-12', 'Anthony', 'Soprano', 'Barone Sanitation'
    UNION ALL SELECT 1650.00, '1998-12-16', 'Lawrence', 'Barese', 'Bada Bing'
    UNION ALL SELECT 1550.00, '1998-12-17', 'Jimmy', 'Altieri', 'Satriale''s Pork Store'
    UNION ALL SELECT 1450.00, '1998-12-20', 'Raymond', 'Curto', 'Barone Sanitation'
    UNION ALL SELECT 1250.00, '1998-12-22', 'Mikey', 'Palmice', 'Nuovo Vesuvio'
    UNION ALL SELECT 1950.00, '1998-12-27', 'Anthony', 'Soprano', 'Bada Bing'
    UNION ALL SELECT 2050.00, '1999-01-03', 'Corrado', 'Soprano', 'Centanni''s Meat Market'
    UNION ALL SELECT 2300.00, '1999-01-07', 'Silvio', 'Dante', 'Centanni''s Meat Market'
) v
INNER JOIN Mobster m
    ON m.FirstName = v.FirstName
   AND m.LastName = v.LastName
INNER JOIN BusinessFront b
    ON b.Name = v.BusinessName
WHERE NOT EXISTS (
    SELECT 1
    FROM CollectionLog c
    WHERE c.Amount = v.Amount
      AND c.DateCollected = v.DateCollected
      AND c.MobsterID = m.id
      AND c.BusinessID = b.id
);

INSERT INTO BusinessFront (Name, Industry, StreetAddress) 
VALUES ('Satriale''s Pork Store', 'Food', '101 Kearny Ave');


INSERT INTO BusinessFront (Name, Industry, StreetAddress) 
VALUES ('Bada Bing', 'Adult Entertainment', 'Route 17');


INSERT INTO BusinessFront (Name, Industry, StreetAddress) 
VALUES ('Barone Sanitation', 'Waste Management', '47 Industrial Rd, Jersey City');

INSERT INTO CollectionLog (Amount, DateCollected, MobsterID, BusinessID)
VALUES (1000, '2000-03-09', 3, 1);

INSERT INTO CollectionLog (Amount, DateCollected, MobsterID, BusinessID)
VALUES (800, '1999-12-20', 4, 2);

INSERT INTO CollectionLog (Amount, DateCollected, MobsterID, BusinessID)
VALUES (2500, '2000-01-17', 1, 3);

SELECT FirstName, LastName, `Rank`, Status FROM Mobster
WHERE Moniker = 'Tony' 
OR `Rank` = 'Capo'
OR Status = 'Active';
      

SELECT Name, StreetAddress FROM BusinessFront
Where Industry = 'Waste Management';

SELECT KnownAssociate.FirstName, KnownAssociate.LastName, RelationType 
FROM KnownAssociate
INNER JOIN Mobster
ON KnownAssociate.MobsterID = Mobster.id 
WHERE Mobster.Status = 'Informant';

SELECT Crew.Name, sum(Amount) AS AmtCollected 
FROM CollectionLog
INNER JOIN Mobster on CollectionLog.MobsterID = Mobster.id 
INNER JOIN Crew on Mobster.CrewID = Crew.id
GROUP BY Crew.Name;


SELECT BusinessFront.Name, sum(Amount) as AmtCollected
FROM BusinessFront
INNER JOIN CollectionLog on BusinessFront.id = CollectionLog.BusinessID
GROUP BY BusinessFront.Name
ORDER BY AmtCollected DESC
LIMIT 3;

SELECT Mobster.`FirstName`, `Mobster`.`LastName`, `CollectionLog`.`DateCollected`, `BusinessFront`.`Name`, `Amount` 
FROM `CollectionLog`
INNER JOIN `BusinessFront` ON `BusinessFront`.id = `CollectionLog`.`BusinessID`
INNER JOIN `Mobster` ON `Mobster`.id = `CollectionLog`.`MobsterID`
WHERE `DateCollected` = @targetDate; 
