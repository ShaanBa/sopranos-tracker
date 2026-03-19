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