CREATE TABLE Medicines (
    MedID VARCHAR(10) PRIMARY KEY,
    MedName VARCHAR(50),
    Manufacturer VARCHAR(50),
    MedType VARCHAR(20),
    IntendedUse VARCHAR(50),
    PrescriptionNeeded VARCHAR(3),
    UnitCost DECIMAL(10,2),
    SellPrice DECIMAL(10,2),
    ReorderLvl INT
);