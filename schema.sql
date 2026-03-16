-- schema for DB starting March 16
CREATE TABLE Family (
    FamilyID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    BaseCity VARCHAR(255) NOT NULL
);