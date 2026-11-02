# PivotTable Analysis

All PivotTables were created in Excel from the cleaned `Dataset` worksheet. The cleaned source contains 150 batch rows (rows 2–151). The field labels below use the exact column headers in the workbook.

## PivotTable 1 — Stock by Medicine Type

**Worksheet:** `Pivot - Stock by Type`

| Pivot area | Field |
|---|---|
| Rows | MedType |
| Values | Sum of QtyStock |

| Medicine type | Stock units |
|---|---:|
| Capsule | 583 |
| Injection | 885 |
| Ointment | 693 |
| Syrup | 635 |
| Tablet | 762 |
| **Grand Total** | **3,558** |

**Purpose:** Compare physical stock quantities across medicine types.

## PivotTable 2 — Expiry Analysis

**Worksheet:** `Pivot - Expiry Analysis`

| Pivot area | Field |
|---|---|
| Rows | ExpiryStatus |
| Values | Sum of QtyStock; Sum of PotentialExpiryLoss |

| Expiry status | Stock units | Potential expiry exposure |
|---|---:|---:|
| Expired | 351 | ₹61,722.00 |
| Safe | 1,783 | ₹0.00 |
| Soon | 1,424 | ₹293,321.00 |
| Unknown | 0 | ₹0.00 |
| **Grand Total** | **3,558** | **₹355,043.00** |

**Purpose:** Quantify stock and acquisition-cost exposure by expiry category. The exposure amount is not a confirmed loss.

## PivotTable 3 — Inventory Value by Medicine Type

**Worksheet:** `Pivot - Value by Type`

| Pivot area | Field |
|---|---|
| Rows | MedType |
| Values | Sum of TotalInventoryCost; Sum of TotalRetailValue |

| Medicine type | Inventory cost | Retail value |
|---|---:|---:|
| Capsule | ₹84,504.00 | ₹106,401.75 |
| Injection | ₹219,486.00 | ₹280,836.04 |
| Ointment | ₹129,859.00 | ₹160,064.56 |
| Syrup | ₹63,734.00 | ₹82,281.38 |
| Tablet | ₹187,937.00 | ₹242,654.55 |
| **Grand Total** | **₹685,520.00** | **₹872,238.28** |

**Purpose:** Compare acquisition cost and potential retail value by medicine type.

## PivotTable 4 — Manufacturer Analysis

**Worksheet:** `Pivot - Manufacturer`

| Pivot area | Field |
|---|---|
| Rows | Manufacturer |
| Values | Sum of QtyStock; Sum of TotalInventoryCost; Sum of TotalRetailValue |

| Manufacturer | Stock units | Inventory cost | Retail value |
|---|---:|---:|---:|
| NovaMeds | 429 | ₹97,407.00 | ₹121,162.17 |
| ParthCureHome | 488 | ₹100,519.00 | ₹123,274.42 |
| PixieHome | 829 | ₹118,179.00 | ₹152,738.15 |
| PixieMeds | 792 | ₹167,191.00 | ₹221,067.92 |
| PrayagCure | 480 | ₹98,321.00 | ₹124,179.10 |
| SecurHealth | 540 | ₹103,903.00 | ₹129,816.52 |
| **Grand Total** | **3,558** | **₹685,520.00** | **₹872,238.28** |

**Purpose:** Identify how inventory quantities and values are distributed across manufacturers.

## PivotTable 5 — Stock Status

**Worksheet:** `Pivot - Stock Status`

| Pivot area | Field |
|---|---|
| Rows | StockStatus |
| Values | Distinct Count of MedID |

The PivotTable uses **Distinct Count** of `MedID`, so each medicine is counted once even though it has three batch records. The source was added to the Excel Data Model to make Distinct Count available.

| Stock status | Unique medicines |
|---|---:|
| In Stock | 30 |
| Low Stock | 15 |
| Out of Stock | 5 |
| **Grand Total** | **50** |

**Purpose:** Show medicine-level availability rather than counting individual batch rows.

## PivotTable 6 — Prescription Analysis

**Worksheet:** `Pivot - Prescription Analysis`

| Pivot area | Field |
|---|---|
| Rows | PrescriptionNeeded |
| Values | Sum of QtyStock; Sum of TotalInventoryCost; Sum of TotalRetailValue; Distinct Count of MedID |

| Prescription needed | Stock units | Inventory cost | Retail value | Unique medicines |
|---|---:|---:|---:|---:|
| No | 1,892 | ₹294,607.00 | ₹367,284.39 | 26 |
| Yes | 1,666 | ₹390,913.00 | ₹504,953.89 | 24 |
| **Grand Total** | **3,558** | **₹685,520.00** | **₹872,238.28** | **50** |

**Purpose:** Compare stock volume and inventory value for prescription-required and non-prescription medicines.

## PivotTable 7 — Intended-Use Analysis

**Worksheet:** `Pivot - Intended Use`

| Pivot area | Field |
|---|---|
| Rows | IntendedUse |
| Values | Distinct Count of MedID; Sum of QtyStock; Sum of TotalInventoryCost; Sum of TotalRetailValue |

| Intended use | Unique medicines | Stock units | Inventory cost | Retail value |
|---|---:|---:|---:|---:|
| Acidity | 7 | 767 | ₹198,522.00 | ₹250,023.06 |
| Allergy | 7 | 406 | ₹88,004.00 | ₹118,040.61 |
| Bacterial Infection | 7 | 543 | ₹113,385.00 | ₹149,069.51 |
| Cough | 7 | 260 | ₹23,115.00 | ₹29,730.19 |
| Fever | 8 | 511 | ₹91,456.00 | ₹111,931.02 |
| Pain Relief | 7 | 551 | ₹60,177.00 | ₹77,620.46 |
| Vomiting | 7 | 520 | ₹110,861.00 | ₹135,823.43 |
| **Grand Total** | **50** | **3,558** | **₹685,520.00** | **₹872,238.28** |

**Purpose:** Compare the number of medicines, physical stock and inventory value across the dataset's intended-use categories.

## PivotTable 8 — Profit Analysis

**Worksheet:** `Pivot - Profit Analysis`

| Pivot area | Field |
|---|---|
| Rows | MedType |
| Values | Sum of TotalInventoryCost; Sum of TotalRetailValue |
| Calculated columns beside PivotTable | Gross Profit; Gross Margin % |

Gross Profit is Retail Value minus Inventory Cost. Gross Margin % is Gross Profit divided by Retail Value.

| Medicine type | Inventory cost | Retail value | Estimated gross profit | Gross margin |
|---|---:|---:|---:|---:|
| Capsule | ₹84,504.00 | ₹106,401.75 | ₹21,897.75 | 20.58% |
| Injection | ₹219,486.00 | ₹280,836.04 | ₹61,350.04 | 21.85% |
| Ointment | ₹129,859.00 | ₹160,064.56 | ₹30,205.56 | 18.87% |
| Syrup | ₹63,734.00 | ₹82,281.38 | ₹18,547.38 | 22.54% |
| Tablet | ₹187,937.00 | ₹242,654.55 | ₹54,717.55 | 22.55% |
| **Grand Total** | **₹685,520.00** | **₹872,238.28** | **₹186,718.28** | **21.41%** |

**Purpose:** Compare estimated gross profit and gross margin by medicine type. These are potential values based on all current stock selling at the listed prices, not actual sales or realized profit.

## Reconciliation checks

The PivotTable grand totals reconcile to the `Inventory Summary` worksheet:

- Total physical stock: 3,558 units.
- Total inventory cost: ₹685,520.00.
- Total retail value: ₹872,238.28.
- Unique medicines: 50.

The expiry exposure total reconciles to ₹355,043.00. The stock-status counts reconcile to 50 unique medicines.
