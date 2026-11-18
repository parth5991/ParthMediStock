USE ParthMediStock;

SELECT COUNT(*) 
FROM DatasetImport;

SELECT TOP 5 *
FROM DatasetImport;

SELECT *
FROM DatasetImport;

SELECT COUNT(DISTINCT MedID) AS UniqueMedicines
FROM DatasetImport;