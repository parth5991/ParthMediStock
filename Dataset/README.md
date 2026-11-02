# ParthMediStock

A pharmacy inventory analytics portfolio project built around a fictional retail pharmacy. The project uses Excel for dataset preparation, data cleaning, calculated inventory metrics and exploratory analysis. SQL and Power BI are planned for subsequent stages.

## Project objective

The objective is to turn batch-level pharmacy inventory data into useful operational insights. The analysis focuses on:

- Inventory quantity and value by medicine type and manufacturer.
- Expired, soon-to-expire, safe and unknown-expiry stock.
- Medicines that are out of stock, low on stock or in stock.
- Prescription-required versus non-prescription inventory.
- Inventory distribution by intended-use category.
- Estimated gross profit and gross margin based on listed unit costs and selling prices.

This is a fictional portfolio dataset. Medicine names and manufacturers are fictional, and intended-use categories are broad dataset labels only. The project is not medical advice and does not provide treatment recommendations.

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

## Excel work completed

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

The stock-status PivotTable counts 30 medicines as In Stock, 15 as Low Stock and 5 as Out of Stock.

## Project documentation

- [Data Cleaning Methodology](docs/data-cleaning-methodology.md)
- [Calculated Fields and Excel Formulas](docs/calculated-fields-and-formulas.md)
- [PivotTable Analysis](docs/pivot-table-analysis.md)
- [Inventory Summary and Metric Definitions](docs/inventory-summary-and-metric-definitions.md)

## Suggested repository structure

```text
ParthMediStock/
├── README.md
├── data/
│   ├── raw/
│   │   └── ParthMediStock_Inventory_V1.0.xlsx
│   └── processed/
│       └── ParthMediStock_Inventory_V1.1.xlsx
└── docs/
    ├── data-cleaning-methodology.md
    ├── calculated-fields-and-formulas.md
    ├── pivot-table-analysis.md
    └── inventory-summary-and-metric-definitions.md
```

Keep the original V1.0 workbook unchanged in `data/raw/`. Place the cleaned workbook with the Inventory Summary and PivotTables in `data/processed/`. The filenames above are suggested repository names; use the exact workbook files you have.

## Project progress

| Stage | Work | Status |
|---|---|---|
| 1 | Business problem and scope | Completed |
| 2 | Dataset structure and field definitions | Completed |
| 3 | Dataset creation and cleaning | Completed |
| 4 | Excel calculated fields, summary metrics and PivotTables | Completed |
| 5 | Power BI dashboard | Next |
| 6 | SQL analysis and final project documentation | Planned |

## Notes and assumptions

- All inventory data is synthetic and intended for portfolio practice.
- Expiry classification uses a fixed analysis snapshot date of **30 October 2026**.
- `PotentialExpiryLoss` is an exposure estimate based on acquisition cost for expired and soon-to-expire batches. It is not a confirmed loss.
- `UsableStock` includes Safe and Soon batches and excludes Expired and Unknown batches, following the project's agreed stock logic.
- Retail value and estimated gross profit assume every unit currently in stock can be sold at the listed selling price. They are not realized revenue or realized profit.
