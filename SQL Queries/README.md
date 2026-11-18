# SQL – ParthMediStock

## Overview

This folder contains the SQL scripts used for database creation, data import, validation, and inventory analysis for the ParthMediStock project.

**Database:** ParthMediStock  
**Database Tool:** Microsoft SQL Server  
**SQL Environment:** SQL Server Management Studio (SSMS)  
**Snapshot Date:** 30 October 2026

## SQL Files

| File Name | Description |
|---|---|
| `Database Created.sql` | Creates the ParthMediStock database. |
| `Medicine Table Created.sql` | Creates the Medicines table. |
| `InventoryBatches Table Created.sql` | Creates the InventoryBatches table and its relationship with the Medicines table. |
| `Dataset Import Verify.sql` | Checks the imported dataset and verifies the number of records and unique medicines. |
| `Populate Medicines.sql` | Transfers medicine details from the staging table into the Medicines table. |
| `Populate InventoryBatches.sql` | Transfers batch details and performs basic data validation. |
| `Data Analysis.sql` | Contains 16 queries for inventory and business analysis. |

## Database Structure

The original dataset is divided into two tables.

### 1. Medicines

Stores medicine-level information:

- MedID (Primary Key)
- MedName
- Manufacturer
- MedType
- IntendedUse
- PrescriptionNeeded
- UnitCost
- SellPrice
- ReorderLvl

### 2. InventoryBatches

Stores batch-level information:

- BatchNum (Primary Key)
- MedID (Foreign Key)
- ExpDate
- QtyStock

Each medicine has three associated inventory batches.

## Data Import and Validation

The cleaned Excel dataset was exported to CSV and imported into SQL Server using the Import Flat File Wizard.

The imported records were initially stored in a staging table named `DatasetImport`. The data was then transferred into the two main tables.

The following validation checks were completed:

| Validation | Result |
|---|---:|
| Total medicines | 50 |
| Total batch records | 150 |
| Medicines with associated batches | 50 |
| Total physical stock | 3,558 units |
| Missing expiry dates | 1 |
| Medicines without exactly 3 batches | 0 |

## SQL Analysis

A total of 16 queries were written to answer inventory-related business questions.

### Inventory and Expiry Analysis

1. Calculate total expired stock.
2. Calculate stock expiring within 90 days.
3. Calculate total usable stock.
4. Calculate total inventory cost.
5. Calculate total retail value.
6. Estimate gross profit.
7. Calculate estimated gross margin.

### Stock Availability Analysis

8. Calculate usable stock and stock status for each medicine.
9. Count medicines by stock status.
10. Analyse physical stock by medicine type.

### Further Inventory Analysis

11. Analyse stock quantity and potential expiry exposure by expiry status.
12. Analyse inventory cost and retail value by medicine type.
13. Analyse inventory by manufacturer.
14. Analyse inventory by prescription requirement.
15. Analyse inventory by intended use.
16. Calculate estimated gross profit and gross margin by medicine type.

## Business Rules

The SQL analysis follows the same business rules used during Excel analysis.

### Expiry Classification

- **Expired:** Expiry date before 30 October 2026.
- **Soon:** Expiry date between 30 October 2026 and 28 January 2027, inclusive.
- **Safe:** Expiry date after 28 January 2027.
- **Unknown:** Missing expiry date.

### Usable Stock

Usable stock includes Safe and Soon batches. Expired and Unknown batches are excluded.

### Potential Expiry Exposure

Potential expiry exposure represents the acquisition cost of Expired and Soon stock. It is an estimate, not a confirmed financial loss.

### Inventory Valuation

Inventory cost and retail value include all physical stock, including expired and unknown-expiry batches.

### Gross Profit and Gross Margin

Gross profit and gross margin are estimates based on current inventory quantities and listed prices. They do not represent actual sales or realized profit.

## Results

The SQL query results were compared with the Excel Inventory Summary and PivotTables.

The key inventory totals and analysis results matched the Excel calculations.

## Note

ParthMediStock is a fictional pharmacy inventory analytics project. All medicine names, manufacturers, prices, batch details, and stock quantities are synthetic and used for learning and portfolio purposes.
