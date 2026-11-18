# ParthMediStock

A pharmacy inventory analytics portfolio project built around a fictional retail pharmacy. The project uses Excel for dataset preparation, data cleaning, calculated inventory metrics and exploratory analysis. SQL Server is used for database creation, data validation and inventory analysis. Power BI will be used in the next stage for dashboard creation and visualization.

## Project objective

The objective is to turn batch-level pharmacy inventory data into useful operational insights. The analysis focuses on:

- Inventory quantity and value by medicine type and manufacturer.
- Expired, soon-to-expire, safe and unknown-expiry stock.
- Medicines that are out of stock, low on stock or in stock.
- Prescription-required versus non-prescription inventory.
- Inventory distribution by intended-use category.
- Estimated gross profit and gross margin based on listed unit costs and selling prices.

This is a fictional portfolio dataset. Medicine names and manufacturers are fictional, and intended-use categories are broad dataset labels only. The project is not medical advice and does not provide treatment recommendations.

## Project progress

| Stage | Description | Status |
|---|---|---|
| Stage 1 | Business Problem & Scope | Completed |
| Stage 2 | Dataset Structure & Column Definitions | Completed |
| Stage 3 | Dataset Creation | Completed |
| Stage 4 | Data Cleaning & Excel Analysis | Completed |
| Stage 5 | SQL Database & Analysis | Completed |
| Stage 6 | Power BI Dashboard & Visualization | Pending |
| Stage 7 | Business Insights & Recommendations | Pending |

## Dataset overview

Each row represents one medicine batch. The cleaned dataset contains **50 unique medicines** and **150 batch records** (three batches per medicine).

The original source data contains 12 fields. Eight calculated fields were then added in Excel, giving 20 populated columns in the analysis worksheet.

| Field | Description |
|---|---|
| MedID | Identifier shared by the batches of one medicine |
| MedName | Fictional medicine name |
| Manufacturer | Fictional manufacturer |
| MedType | Tablet, Capsule, Syrup, Injection or Ointment |
| IntendedUse | Broad intended-use category |
| PrescriptionNeeded | Whether a prescription is required (Yes/No) |
| UnitCost | Pharmacy acquisition cost per unit |
| SellPrice | Listed selling price per unit |
| ReorderLvl | Reorder threshold at medicine level |
| BatchNum | Unique batch identifier |
| ExpDate | Batch expiry date |
| QtyStock | Quantity held in that batch |

The calculated fields are `TotalInventoryCost`, `TotalRetailValue`, `GrossProfitPerUnit`, `GrossMargin%`, `ExpiryStatus`, `PotentialExpiryLoss`, `UsableStock` and `StockStatus`.

## Excel analysis completed

The Excel analysis workbook contains these worksheets:

1. `Dataset` — cleaned batch-level data and calculated fields.
2. `Inventory Summary` — key inventory metrics.
3. `Pivot - Stock by Type` — stock quantity by medicine type.
4. `Pivot - Expiry Analysis` — quantity and expiry exposure by expiry status.
5. `Pivot - Value by Type` — inventory cost and retail value by medicine type.
6. `Pivot - Manufacturer` — stock and value by manufacturer.
7. `Pivot - Stock Status` — distinct medicine count by stock status.
8. `Pivot - Prescription Analysis` — stock, value and distinct medicine count by prescription requirement.
9. `Pivot - Intended Use` — medicine count, stock and value by intended-use category.
10. `Pivot - Profit Analysis` — estimated gross profit and margin by medicine type.

## SQL database and analysis

The cleaned dataset was imported into Microsoft SQL Server using the Import Flat File Wizard.

The database contains two main tables:

**Medicines**
- Stores medicine-level information such as manufacturer, medicine type, intended use, prices and reorder level.
- Contains 50 unique medicine records.
- `MedID` is the primary key.

**InventoryBatches**
- Stores batch number, medicine ID, expiry date and stock quantity.
- Contains 150 batch records.
- `BatchNum` is the primary key and `MedID` is the foreign key.

A staging table named `DatasetImport` was used during data import.

A total of **16 SQL queries** were written and verified against the Excel analysis. The queries cover:

- Expired, soon-to-expire and usable stock.
- Inventory cost and retail value.
- Estimated gross profit and gross margin.
- Stock status and reorder levels.
- Inventory analysis by medicine type, manufacturer, prescription requirement and intended use.
- Potential expiry exposure.

The SQL scripts and their descriptions are available in the [SQL folder](SQL/README.md).

## Key results

| Metric | Result |
|---|---:|
| Unique medicines | 50 |
| Batch records | 150 |
| Physical stock units | 3,558 |
| Usable stock units | 3,207 |
| Total inventory cost | ₹685,520.00 |
| Total retail value | ₹872,238.28 |
| Potential expiry exposure | ₹355,043.00 |
| Estimated gross profit on current stock | ₹186,718.28 |
| Overall estimated gross margin | 21.41% |

The stock-status analysis counts 30 medicines as In Stock, 15 as Low Stock and 5 as Out of Stock.

## Version History

| Version | Updates |
|---|---|
| v1.0 | Initial project setup, business problem definition, dataset structure and synthetic inventory dataset creation. |
| v1.1 | Completed data cleaning, added calculated fields, created the Inventory Summary and completed 8 Excel PivotTables. Added Excel analysis documentation. |
| v1.2 | Created the SQL Server database, designed the Medicines and InventoryBatches tables, imported and validated the cleaned dataset, and completed 16 SQL analysis queries. Added SQL scripts and documentation. |

## Notes and assumptions

- All inventory data is synthetic and intended for portfolio practice.
- Expiry classification uses a fixed analysis snapshot date of **30 October 2026**.
- `PotentialExpiryLoss` is an exposure estimate based on acquisition cost for expired and soon-to-expire batches. It is not a confirmed loss.
- `UsableStock` includes Safe and Soon batches and excludes Expired and Unknown batches, following the project's agreed stock logic.
- Retail value and estimated gross profit assume every unit currently in stock can be sold at the listed selling price. They are not realized revenue or realized profit.
