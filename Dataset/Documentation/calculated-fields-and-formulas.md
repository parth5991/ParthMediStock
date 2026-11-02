# Calculated Fields and Excel Formulas

The calculated fields are on the `Dataset` worksheet, after the 12 source columns. The examples below show the formula in row 2; fill the formula down through row 151.

## 1. Calculated columns

| Column | Field | Formula in row 2 | Meaning |
|---|---|---|---|
| M | TotalInventoryCost | `=L2*G2` | Quantity in the batch × unit acquisition cost |
| N | TotalRetailValue | `=L2*H2` | Quantity in the batch × listed selling price |
| O | GrossProfitPerUnit | `=H2-G2` | Selling price per unit − unit cost per unit |
| P | GrossMargin% | `=O2/H2` | Gross profit per unit ÷ selling price per unit |
| Q | ExpiryStatus | See formula below | Expiry category using the fixed snapshot date |
| R | PotentialExpiryLoss | See formula below | Acquisition-cost exposure for Expired and Soon batches |
| S | UsableStock | See formula below | Total Safe and Soon stock for the medicine across batches |
| T | StockStatus | `=IF(S2=0,"Out of Stock",IF(S2<=I2,"Low Stock","In Stock"))` | Medicine-level stock status compared with reorder level |

### ExpiryStatus — Q2

```excel
=IF(K2="","Unknown",IF(K2<DATE(2026,10,30),"Expired",IF(K2<=DATE(2026,10,30)+90,"Soon","Safe")))
```

The fixed snapshot date is **30 October 2026**:

- `Unknown`: expiry date is blank.
- `Expired`: expiry date is before 30 October 2026.
- `Soon`: expiry date is from 30 October 2026 through 28 January 2027 (inclusive), using the 90-day threshold in the formula.
- `Safe`: expiry date is after the 90-day threshold.

### PotentialExpiryLoss — R2

```excel
=IF(Q2="Unknown","",IF(OR(Q2="Expired",Q2="Soon"),L2*G2,0))
```

This estimates acquisition cost tied up in expired and soon-to-expire batches. Safe batches return zero. Unknown-expiry batches return blank. This is an exposure measure, not a confirmed financial loss.

### UsableStock — S2

```excel
=SUMIFS($L$2:$L$151,$A$2:$A$151,A2,$Q$2:$Q$151,"Safe")+SUMIFS($L$2:$L$151,$A$2:$A$151,A2,$Q$2:$Q$151,"Soon")
```

The formula adds Safe and Soon quantities for all batches with the same `MedID`. It excludes Expired and Unknown batches. The resulting medicine-level total is repeated on each batch row for that medicine; do not sum the repeated `UsableStock` column across all rows.

### StockStatus — T2

```excel
=IF(S2=0,"Out of Stock",IF(S2<=I2,"Low Stock","In Stock"))
```

The formula compares medicine-level `UsableStock` with `ReorderLvl`:

- `Out of Stock`: usable stock equals zero.
- `Low Stock`: usable stock is greater than zero and less than or equal to the reorder level.
- `In Stock`: usable stock is greater than the reorder level.

## 2. Inventory Summary formulas

The `Inventory Summary` worksheet contains these metrics in cells A2:B8.

| Cell | Metric | Formula in Value cell |
|---|---|---|
| B2 | Total Unique Medicines | `=SUMPRODUCT((Dataset!A2:A151<>"")/COUNTIF(Dataset!A2:A151,Dataset!A2:A151))` |
| B3 | Total Batch Records | `=COUNTA(Dataset!J2:J151)` |
| B4 | Total Physical Stock Units | `=SUM(Dataset!L2:L151)` |
| B5 | Total Usable Stock Units | `=SUMIFS(Dataset!L2:L151,Dataset!Q2:Q151,"Safe")+SUMIFS(Dataset!L2:L151,Dataset!Q2:Q151,"Soon")` |
| B6 | Total Inventory Cost | `=SUM(Dataset!M2:M151)` |
| B7 | Total Retail Value | `=SUM(Dataset!N2:N151)` |
| B8 | Potential Expiry Exposure | `=SUM(Dataset!R2:R151)` |

**Precision note for B2:** the workbook's current `SUMPRODUCT` formula calculates the unique count as approximately 50 because of floating-point precision. For a whole-number result, use this optional rounded version:

```excel
=ROUND(SUMPRODUCT((Dataset!A2:A151<>"")/COUNTIF(Dataset!A2:A151,Dataset!A2:A151)),0)
```

## 3. Profit Analysis formulas

On `Pivot - Profit Analysis`, the PivotTable provides total inventory cost and total retail value by medicine type. Adjacent calculated columns use:

```excel
Gross Profit = Retail Value - Inventory Cost
```

Example for the first medicine-type row (row 4):

```excel
D4 = C4-B4
E4 = D4/C4
```

Fill the formulas down through the medicine-type rows and the Grand Total row. Format column E as a percentage. The Grand Total gross margin is calculated from the Grand Total profit divided by the Grand Total retail value; it is not the simple average of the individual medicine-type margins.

## 4. Number formats

- `UnitCost`, `SellPrice`, `TotalInventoryCost`, `TotalRetailValue`, `GrossProfitPerUnit` and `PotentialExpiryLoss`: Indian Rupee currency with two decimal places.
- `GrossMargin%`: percentage.
- `ExpDate`: `dd-mmm-yyyy`.
- `QtyStock`, `ReorderLvl` and summary counts: whole numbers.
