-- Safe incremental seed for existing MySQL database
-- Purpose: add S1E1 intelligence expansion without damaging existing data.
-- Strategy:
--   1) Never drops/alters tables
--   2) Uses INSERT ... SELECT ... WHERE NOT EXISTS guards
--   3) Wraps in one transaction

START TRANSACTION;

-- ------------------------------------------------------------------
-- Crew bootstrap needed for NY entries
-- ------------------------------------------------------------------
INSERT INTO Crew (Name, Capo, FamilyID)
SELECT 'Lupertazzi', 'Carmine Lupertazzi Sr.', 2
WHERE NOT EXISTS (
    SELECT 1
    FROM Crew c
    WHERE c.Name = 'Lupertazzi' AND c.FamilyID = 2
);

-- ------------------------------------------------------------------
-- Mobster additions (S1E1 intelligence perspective)
-- ------------------------------------------------------------------
INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Corrado', 'Soprano', 'Junior', 'Capo', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Junior'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Corrado' AND m.LastName = 'Soprano'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Christopher', 'Moltisanti', 'Chrissy', 'Associate', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Mikey', 'Palmice', NULL, 'Soldier', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Junior'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Mikey' AND m.LastName = 'Palmice'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Lawrence', 'Barese', 'Larry Boy', 'Capo', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Lawrence' AND m.LastName = 'Barese'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Jimmy', 'Altieri', NULL, 'Capo', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Jimmy' AND m.LastName = 'Altieri'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Raymond', 'Curto', NULL, 'Capo', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Raymond' AND m.LastName = 'Curto'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Richie', 'Aprile', NULL, 'Soldier', 'In Jail', c.id
FROM Crew c
WHERE c.Name = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Richie' AND m.LastName = 'Aprile'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Tony', 'Blundetto', 'Tony B', 'Associate', 'In Jail', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Tony' AND m.LastName = 'Blundetto'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Feech', 'La Manna', NULL, 'Capo', 'In Jail', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Feech' AND m.LastName = 'La Manna'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Richard', 'Moltisanti', 'Dickie', 'Soldier', 'Deceased', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Richard' AND m.LastName = 'Moltisanti'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Ercole', 'DiMeo', 'Eckley', 'Boss', 'In Jail', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Ercole' AND m.LastName = 'DiMeo'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Herman', 'Rabkin', 'Hesh', 'Associate', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Herman' AND m.LastName = 'Rabkin'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Gennaro', 'Malanga', 'Little Pussy', 'Associate', 'Unknown', c.id
FROM Crew c
WHERE c.Name = 'Junior'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Gennaro' AND m.LastName = 'Malanga'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Joseph', 'Sasso', 'Beppy', 'Underboss', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Joseph' AND m.LastName = 'Sasso'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'Carmine', 'Lupertazzi Sr.', 'Carmine', 'Boss', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Lupertazzi'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'Carmine' AND m.LastName = 'Lupertazzi Sr.'
  )
LIMIT 1;

INSERT INTO Mobster (FirstName, LastName, Moniker, `Rank`, Status, CrewID)
SELECT 'John', 'Sacrimoni', 'Johnny Sack', 'Underboss', 'In Streets', c.id
FROM Crew c
WHERE c.Name = 'Lupertazzi'
  AND NOT EXISTS (
      SELECT 1 FROM Mobster m WHERE m.FirstName = 'John' AND m.LastName = 'Sacrimoni'
  )
LIMIT 1;

-- ------------------------------------------------------------------
-- Known associates additions
-- ------------------------------------------------------------------
INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Carmela', 'Soprano', 'Spouse', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Carmela' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Spouse' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Meadow', 'Soprano', 'Daughter', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Meadow' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Daughter' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano Jr.', 'Son', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano Jr.'
        AND ka.RelationType = 'Son' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Livia', 'Soprano', 'Mother', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Livia' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Mother' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Corrado', 'Soprano', 'Uncle', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Corrado' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Uncle' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Janice', 'Soprano', 'Sister', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Janice' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Sister' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Christopher', 'Moltisanti', 'Protege', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Christopher' AND ka.LastName = 'Moltisanti'
        AND ka.RelationType = 'Protege' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Silvio', 'Dante', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Silvio' AND ka.LastName = 'Dante'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Peter', 'Gualtieri', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Peter' AND ka.LastName = 'Gualtieri'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Herman', 'Rabkin', 'Advisor', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Herman' AND ka.LastName = 'Rabkin'
        AND ka.RelationType = 'Advisor' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Artie', 'Bucco', 'Civilian Friend', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Artie' AND ka.LastName = 'Bucco'
        AND ka.RelationType = 'Civilian Friend' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jennifer', 'Melfi', 'Therapist', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Jennifer' AND ka.LastName = 'Melfi'
        AND ka.RelationType = 'Therapist' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Charmaine', 'Bucco', 'Friend', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Charmaine' AND ka.LastName = 'Bucco'
        AND ka.RelationType = 'Friend' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Irina', 'Peltsin', 'Romantic Partner', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Irina' AND ka.LastName = 'Peltsin'
        AND ka.RelationType = 'Romantic Partner' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Dick', 'Barone', 'Business Contact', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Dick' AND ka.LastName = 'Barone'
        AND ka.RelationType = 'Business Contact' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Father Phil', 'Intintola', 'Spiritual Advisor', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Father Phil' AND ka.LastName = 'Intintola'
        AND ka.RelationType = 'Spiritual Advisor' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Hunter', 'Scangarelo', 'Family Friend', m.id
FROM Mobster m
WHERE m.FirstName = 'Anthony' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Hunter' AND ka.LastName = 'Scangarelo'
        AND ka.RelationType = 'Family Friend' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Rosalie', 'Aprile', 'Spouse', m.id
FROM Mobster m
WHERE m.FirstName = 'Giacomo' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Rosalie' AND ka.LastName = 'Aprile'
        AND ka.RelationType = 'Spouse' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jackie', 'Aprile Jr.', 'Son', m.id
FROM Mobster m
WHERE m.FirstName = 'Giacomo' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Jackie' AND ka.LastName = 'Aprile Jr.'
        AND ka.RelationType = 'Son' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Richie', 'Aprile', 'Brother', m.id
FROM Mobster m
WHERE m.FirstName = 'Giacomo' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Richie' AND ka.LastName = 'Aprile'
        AND ka.RelationType = 'Brother' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Nucci', 'Gualtieri', 'Mother', m.id
FROM Mobster m
WHERE m.FirstName = 'Peter' AND m.LastName = 'Gualtieri'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Nucci' AND ka.LastName = 'Gualtieri'
        AND ka.RelationType = 'Mother' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Superior', m.id
FROM Mobster m
WHERE m.FirstName = 'Peter' AND m.LastName = 'Gualtieri'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Superior' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Silvio', 'Dante', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Peter' AND m.LastName = 'Gualtieri'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Silvio' AND ka.LastName = 'Dante'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Gabriella', 'Dante', 'Spouse', m.id
FROM Mobster m
WHERE m.FirstName = 'Silvio' AND m.LastName = 'Dante'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Gabriella' AND ka.LastName = 'Dante'
        AND ka.RelationType = 'Spouse' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Superior', m.id
FROM Mobster m
WHERE m.FirstName = 'Silvio' AND m.LastName = 'Dante'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Superior' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Peter', 'Gualtieri', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Silvio' AND m.LastName = 'Dante'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Peter' AND ka.LastName = 'Gualtieri'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Superior', m.id
FROM Mobster m
WHERE m.FirstName = 'Salvatore' AND m.LastName = 'Bompansiero'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Superior' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Silvio', 'Dante', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Salvatore' AND m.LastName = 'Bompansiero'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Silvio' AND ka.LastName = 'Dante'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Mikey', 'Palmice', 'Driver-Aide', m.id
FROM Mobster m
WHERE m.FirstName = 'Corrado' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Mikey' AND ka.LastName = 'Palmice'
        AND ka.RelationType = 'Driver-Aide' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Bobby', 'Baccalieri', 'Driver-Aide', m.id
FROM Mobster m
WHERE m.FirstName = 'Corrado' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Bobby' AND ka.LastName = 'Baccalieri'
        AND ka.RelationType = 'Driver-Aide' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Livia', 'Soprano', 'Sister-In-Law', m.id
FROM Mobster m
WHERE m.FirstName = 'Corrado' AND m.LastName = 'Soprano'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Livia' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Sister-In-Law' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Adriana', 'La Cerva', 'Fiancee', m.id
FROM Mobster m
WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Adriana' AND ka.LastName = 'La Cerva'
        AND ka.RelationType = 'Fiancee' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Joanne', 'Moltisanti', 'Mother', m.id
FROM Mobster m
WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Joanne' AND ka.LastName = 'Moltisanti'
        AND ka.RelationType = 'Mother' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Brendan', 'Filone', 'Criminal Associate', m.id
FROM Mobster m
WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Brendan' AND ka.LastName = 'Filone'
        AND ka.RelationType = 'Criminal Associate' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Mentor', m.id
FROM Mobster m
WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Mentor' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Emil', 'Kolar', 'Business Contact', m.id
FROM Mobster m
WHERE m.FirstName = 'Christopher' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Emil' AND ka.LastName = 'Kolar'
        AND ka.RelationType = 'Business Contact' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jojo', 'Palmice', 'Spouse', m.id
FROM Mobster m
WHERE m.FirstName = 'Mikey' AND m.LastName = 'Palmice'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Jojo' AND ka.LastName = 'Palmice'
        AND ka.RelationType = 'Spouse' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Corrado', 'Soprano', 'Crew Superior', m.id
FROM Mobster m
WHERE m.FirstName = 'Mikey' AND m.LastName = 'Palmice'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Corrado' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Superior' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Albert', 'Barese', 'Cousin', m.id
FROM Mobster m
WHERE m.FirstName = 'Lawrence' AND m.LastName = 'Barese'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Albert' AND ka.LastName = 'Barese'
        AND ka.RelationType = 'Cousin' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Lawrence' AND m.LastName = 'Barese'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Jimmy' AND m.LastName = 'Altieri'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Crew Peer', m.id
FROM Mobster m
WHERE m.FirstName = 'Raymond' AND m.LastName = 'Curto'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Crew Peer' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Giacomo', 'Aprile', 'Brother', m.id
FROM Mobster m
WHERE m.FirstName = 'Richie' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Giacomo' AND ka.LastName = 'Aprile'
        AND ka.RelationType = 'Brother' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Jackie', 'Aprile Jr.', 'Nephew', m.id
FROM Mobster m
WHERE m.FirstName = 'Richie' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Jackie' AND ka.LastName = 'Aprile Jr.'
        AND ka.RelationType = 'Nephew' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Adriana', 'La Cerva', 'Niece', m.id
FROM Mobster m
WHERE m.FirstName = 'Richie' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Adriana' AND ka.LastName = 'La Cerva'
        AND ka.RelationType = 'Niece' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Janice', 'Soprano', 'Romantic Partner', m.id
FROM Mobster m
WHERE m.FirstName = 'Richie' AND m.LastName = 'Aprile'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Janice' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Romantic Partner' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Cousin', m.id
FROM Mobster m
WHERE m.FirstName = 'Tony' AND m.LastName = 'Blundetto'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Cousin' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Anthony', 'Soprano', 'Former Associate', m.id
FROM Mobster m
WHERE m.FirstName = 'Feech' AND m.LastName = 'La Manna'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Anthony' AND ka.LastName = 'Soprano'
        AND ka.RelationType = 'Former Associate' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Peter', 'Gualtieri', 'Old Guard Associate', m.id
FROM Mobster m
WHERE m.FirstName = 'Feech' AND m.LastName = 'La Manna'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Peter' AND ka.LastName = 'Gualtieri'
        AND ka.RelationType = 'Old Guard Associate' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Christopher', 'Moltisanti', 'Son', m.id
FROM Mobster m
WHERE m.FirstName = 'Richard' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Christopher' AND ka.LastName = 'Moltisanti'
        AND ka.RelationType = 'Son' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Joanne', 'Moltisanti', 'Spouse', m.id
FROM Mobster m
WHERE m.FirstName = 'Richard' AND m.LastName = 'Moltisanti'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Joanne' AND ka.LastName = 'Moltisanti'
        AND ka.RelationType = 'Spouse' AND ka.MobsterID = m.id
  );

INSERT INTO KnownAssociate (FirstName, LastName, RelationType, MobsterID)
SELECT 'Alex', 'Mahaffey', 'Business Contact', m.id
FROM Mobster m
WHERE m.FirstName = 'Herman' AND m.LastName = 'Rabkin'
  AND NOT EXISTS (
      SELECT 1 FROM KnownAssociate ka
      WHERE ka.FirstName = 'Alex' AND ka.LastName = 'Mahaffey'
        AND ka.RelationType = 'Business Contact' AND ka.MobsterID = m.id
  );

-- ------------------------------------------------------------------
-- Business fronts additions
-- ------------------------------------------------------------------
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

INSERT INTO BusinessFront (Name, Industry, StreetAddress)
SELECT 'Bada Bing!', 'Adult Entertainment', 'Lodi, NJ'
WHERE NOT EXISTS (
    SELECT 1 FROM BusinessFront WHERE Name IN ('Bada Bing', 'Bada Bing!')
);

-- ------------------------------------------------------------------
-- Collection logs additions
-- ------------------------------------------------------------------
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
    UNION ALL SELECT 1850.00, '1998-12-05', 'Giacomo', 'Aprile', 'Barone Sanitation'
    UNION ALL SELECT 2125.00, '1998-12-11', 'Giacomo', 'Aprile', 'Satriale''s Pork Store'
    UNION ALL SELECT 1750.00, '1998-12-15', 'Giacomo', 'Aprile', 'Nuovo Vesuvio'
    UNION ALL SELECT 1625.00, '1998-12-23', 'Giacomo', 'Aprile', 'Bada Bing'
    UNION ALL SELECT 2050.00, '1999-01-06', 'Giacomo', 'Aprile', 'Centanni''s Meat Market'
    UNION ALL SELECT 1550.00, '1998-12-07', 'Joseph', 'Sasso', 'Barone Sanitation'
    UNION ALL SELECT 1480.00, '1998-12-13', 'Joseph', 'Sasso', 'Satriale''s Pork Store'
    UNION ALL SELECT 1700.00, '1998-12-28', 'Joseph', 'Sasso', 'Centanni''s Meat Market'
    UNION ALL SELECT 1350.00, '1998-12-04', 'Gennaro', 'Malanga', 'Nuovo Vesuvio'
    UNION ALL SELECT 1450.00, '1998-12-21', 'Gennaro', 'Malanga', 'Satriale''s Pork Store'
    UNION ALL SELECT 1520.00, '1999-01-04', 'Mikey', 'Palmice', 'Centanni''s Meat Market'
    UNION ALL SELECT 1680.00, '1999-01-05', 'Corrado', 'Soprano', 'Barone Sanitation'
    UNION ALL SELECT 2800.00, '1998-12-06', 'John', 'Sacrimoni', 'Barone Sanitation'
    UNION ALL SELECT 2350.00, '1998-12-11', 'John', 'Sacrimoni', 'Centanni''s Meat Market'
    UNION ALL SELECT 2600.00, '1998-12-18', 'John', 'Sacrimoni', 'Nuovo Vesuvio'
    UNION ALL SELECT 2400.00, '1998-12-29', 'John', 'Sacrimoni', 'Blue Cross Blue Shield (HMO Affiliate)'
    UNION ALL SELECT 3000.00, '1999-01-02', 'Carmine', 'Lupertazzi Sr.', 'Barone Sanitation'
    UNION ALL SELECT 2700.00, '1999-01-08', 'Carmine', 'Lupertazzi Sr.', 'Centanni''s Meat Market'
    UNION ALL SELECT 2550.00, '1999-01-10', 'Carmine', 'Lupertazzi Sr.', 'Nuovo Vesuvio'
    UNION ALL SELECT 2200.00, '1999-01-12', 'Carmine', 'Lupertazzi Sr.', 'Blue Cross Blue Shield (HMO Affiliate)'
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

COMMIT;

-- Optional verification queries:
-- SELECT COUNT(*) AS mobster_count FROM Mobster;
-- SELECT COUNT(*) AS associate_count FROM KnownAssociate;
-- SELECT COUNT(*) AS business_count FROM BusinessFront;
-- SELECT COUNT(*) AS collection_count FROM CollectionLog;
