INSERT INTO Medicines (
    MedID, MedName, Manufacturer, MedType,
    IntendedUse, PrescriptionNeeded,
    UnitCost, SellPrice, ReorderLvl
)
SELECT DISTINCT
    MedID, MedName, Manufacturer, MedType,
    IntendedUse, PrescriptionNeeded,
    UnitCost, SellPrice, ReorderLvl
FROM DatasetImport;

SELECT COUNT(*) AS TotalMedicines
FROM Medicines;