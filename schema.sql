    -- schema for DB starting March 16
    CREATE TABLE Family (
        id INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR(255) NOT NULL,
        BaseCity VARCHAR(255) NOT NULL
    );

    CREATE TABLE Crew (
        id INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR(255) NOT NULL,
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
        Rank VARCHAR(255) NOT NULL,
        Status VARCHAR(255) NOT NULL,
        CrewID INT NOT NULL,
        CONSTRAINT fk_Crew
        FOREIGN KEY (CrewID)
        REFERENCES Crew(id)
    );

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