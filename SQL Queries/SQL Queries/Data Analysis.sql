-- Calculate total stock units that expired before 30 October 2026.

SELECT SUM(QtyStock) AS ExpiredStock
FROM InventoryBatches
WHERE ExpDate < '2026-10-30';

-- Calculate total stock units expiring within 90 days of 30 October 2026.

SELECT SUM(QtyStock) AS SoonExpiryStock
FROM InventoryBatches
WHERE ExpDate BETWEEN '2026-10-30' AND '2027-01-28';

-- Calculate usable stock, including Soon and Safe batches, excluding Expired and Unknown.

SELECT SUM(QtyStock) AS UsableStock
FROM InventoryBatches
WHERE ExpDate >= '2026-10-30';

-- Calculate the total acquisition cost of all physical stock.

SELECT SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS TotalInventoryCost
FROM InventoryBatches
JOIN Medicines
ON InventoryBatches.MedID = Medicines.MedID;

-- Calculate the total retail value of all physical stock.

SELECT SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS TotalRetailValue
FROM InventoryBatches
JOIN Medicines
ON InventoryBatches.MedID = Medicines.MedID;

-- Estimate gross profit by subtracting inventory cost from total retail value.

SELECT
    SUM(InventoryBatches.QtyStock * Medicines.SellPrice)
    - SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS EstimatedGrossProfit
FROM InventoryBatches
JOIN Medicines
ON InventoryBatches.MedID = Medicines.MedID;

-- Calculate the estimated gross margin as a percentage of total retail value.

SELECT
    (SUM(InventoryBatches.QtyStock * Medicines.SellPrice)
    - SUM(InventoryBatches.QtyStock * Medicines.UnitCost))
    / SUM(InventoryBatches.QtyStock * Medicines.SellPrice) * 100
    AS EstimatedGrossMarginPercent
FROM InventoryBatches
JOIN Medicines
ON InventoryBatches.MedID = Medicines.MedID;

-- Calculate usable stock and stock status for each medicine.

SELECT
    Medicines.MedID,
    Medicines.MedName,
    ISNULL(SUM(InventoryBatches.QtyStock), 0) AS UsableStock,
    Medicines.ReorderLvl,
    CASE
        WHEN ISNULL(SUM(InventoryBatches.QtyStock), 0) = 0
            THEN 'Out of Stock'
        WHEN ISNULL(SUM(InventoryBatches.QtyStock), 0) <= Medicines.ReorderLvl
            THEN 'Low Stock'
        ELSE 'In Stock'
    END AS StockStatus
FROM Medicines
LEFT JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
    AND InventoryBatches.ExpDate >= '2026-10-30'
GROUP BY
    Medicines.MedID,
    Medicines.MedName,
    Medicines.ReorderLvl
ORDER BY Medicines.MedID;

-- Count medicines in each stock category.

WITH MedicineStock AS (
    SELECT
        Medicines.MedID,
        Medicines.ReorderLvl,
        ISNULL(SUM(InventoryBatches.QtyStock), 0) AS UsableStock
    FROM Medicines
    LEFT JOIN InventoryBatches
        ON Medicines.MedID = InventoryBatches.MedID
        AND InventoryBatches.ExpDate >= '2026-10-30'
    GROUP BY Medicines.MedID, Medicines.ReorderLvl
)

SELECT
    CASE
        WHEN UsableStock = 0 THEN 'Out of Stock'
        WHEN UsableStock <= ReorderLvl THEN 'Low Stock'
        ELSE 'In Stock'
    END AS StockStatus,
    COUNT(*) AS MedicineCount
FROM MedicineStock
GROUP BY
    CASE
        WHEN UsableStock = 0 THEN 'Out of Stock'
        WHEN UsableStock <= ReorderLvl THEN 'Low Stock'
        ELSE 'In Stock'
    END;

-- Summarize total physical stock units by medicine type.

SELECT
    Medicines.MedType,
    SUM(InventoryBatches.QtyStock) AS TotalStock
FROM Medicines
JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
GROUP BY Medicines.MedType
ORDER BY Medicines.MedType;

-- Summarize stock quantity and potential expiry exposure by expiry status.

SELECT
    CASE
        WHEN InventoryBatches.ExpDate IS NULL THEN 'Unknown'
        WHEN InventoryBatches.ExpDate < '2026-10-30' THEN 'Expired'
        WHEN InventoryBatches.ExpDate <= '2027-01-28' THEN 'Soon'
        ELSE 'Safe'
    END AS ExpiryStatus,
    SUM(InventoryBatches.QtyStock) AS TotalStock,
    SUM(
        CASE
            WHEN InventoryBatches.ExpDate IS NULL THEN 0
            WHEN InventoryBatches.ExpDate <= '2027-01-28'
                THEN InventoryBatches.QtyStock * Medicines.UnitCost
            ELSE 0
        END
    ) AS PotentialExpiryExposure
FROM InventoryBatches
JOIN Medicines
    ON InventoryBatches.MedID = Medicines.MedID
GROUP BY
    CASE
        WHEN InventoryBatches.ExpDate IS NULL THEN 'Unknown'
        WHEN InventoryBatches.ExpDate < '2026-10-30' THEN 'Expired'
        WHEN InventoryBatches.ExpDate <= '2027-01-28' THEN 'Soon'
        ELSE 'Safe'
    END;

-- Calculate inventory cost and retail value by medicine type.

SELECT
    Medicines.MedType,
    SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS InventoryCost,
    SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS RetailValue
FROM Medicines
JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
GROUP BY Medicines.MedType
ORDER BY Medicines.MedType;

-- Summarize physical stock, inventory cost, and retail value by manufacturer.

SELECT
    Medicines.Manufacturer,
    SUM(InventoryBatches.QtyStock) AS TotalStock,
    SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS InventoryCost,
    SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS RetailValue
FROM Medicines
JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
GROUP BY Medicines.Manufacturer
ORDER BY Medicines.Manufacturer;

-- Summarize physical stock, inventory value, and medicine count by prescription requirement.

SELECT
    CASE
        WHEN Medicines.PrescriptionNeeded = '1' THEN 'Yes'
        WHEN Medicines.PrescriptionNeeded = '0' THEN 'No'
    END AS PrescriptionRequired,
    COUNT(DISTINCT Medicines.MedID) AS MedicineCount,
    SUM(InventoryBatches.QtyStock) AS TotalStock,
    SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS InventoryCost,
    SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS RetailValue
FROM Medicines
JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
GROUP BY
    CASE
        WHEN Medicines.PrescriptionNeeded = '1' THEN 'Yes'
        WHEN Medicines.PrescriptionNeeded = '0' THEN 'No'
    END
ORDER BY PrescriptionRequired;

-- Summarize medicine count, physical stock, and inventory value by intended use.

SELECT
    Medicines.IntendedUse,
    COUNT(DISTINCT Medicines.MedID) AS MedicineCount,
    SUM(InventoryBatches.QtyStock) AS TotalStock,
    SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS InventoryCost,
    SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS RetailValue
FROM Medicines
JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
GROUP BY Medicines.IntendedUse
ORDER BY Medicines.IntendedUse;

-- Calculate estimated gross profit and gross margin by medicine type.

SELECT
    Medicines.MedType,
    SUM(InventoryBatches.QtyStock * Medicines.UnitCost) AS InventoryCost,
    SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS RetailValue,
    SUM(InventoryBatches.QtyStock * (Medicines.SellPrice - Medicines.UnitCost)) AS GrossProfit,
    SUM(InventoryBatches.QtyStock * (Medicines.SellPrice - Medicines.UnitCost)) * 100.0
        / SUM(InventoryBatches.QtyStock * Medicines.SellPrice) AS GrossMarginPercent
FROM Medicines
JOIN InventoryBatches
    ON Medicines.MedID = InventoryBatches.MedID
GROUP BY Medicines.MedType
ORDER BY Medicines.MedType;