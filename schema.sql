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

