INSERT INTO InventoryBatches (
    BatchNum,
    MedID,
    ExpDate,
    QtyStock
)
SELECT
    BatchNum,
    MedID,
    CASE
        WHEN ExpDate IS NULL OR ExpDate = '' THEN NULL
        ELSE CAST(ExpDate AS DATE)
    END,
    QtyStock
FROM DatasetImport;

SELECT COUNT(*) AS TotalBatches
FROM InventoryBatches;

SELECT COUNT(DISTINCT MedID) AS MedicinesWithBatches
FROM InventoryBatches;

SELECT SUM(QtyStock) AS TotalPhysicalStock
FROM InventoryBatches;

SELECT COUNT(*) AS MissingExpiryDates
FROM InventoryBatches
WHERE ExpDate IS NULL;

SELECT MedID, COUNT(*) AS BatchCount
FROM InventoryBatches
GROUP BY MedID
HAVING COUNT(*) <> 3;