# Data Cleaning Methodology

## 1. Source and structure

The source workbook is `ParthMediStock_Inventory_V1.0.xlsx`. The cleaned analysis workbook is the V1.1 copy. The source table initially contained 155 data rows. After duplicate removal, the cleaned dataset contains 150 batch records, covering 50 unique medicines with three batches per medicine.

Each row represents one batch, not one unique medicine. The first 12 columns are the source fields:

`MedID`, `MedName`, `Manufacturer`, `MedType`, `IntendedUse`, `PrescriptionNeeded`, `UnitCost`, `SellPrice`, `ReorderLvl`, `BatchNum`, `ExpDate`, `QtyStock`.

The cleaned data occupies rows 2–151 on the `Dataset` worksheet.

## 2. Duplicate removal

**Method used:** Excel Data → Remove Duplicates.

- Selected all 12 source columns so the comparison used the complete batch record.
- Removed five exact duplicate rows.
- Retained 150 records after removal.
- The cleaned copy was used for analysis; the original V1.0 workbook was preserved as the raw source.

## 3. Missing-value handling

The initial data review identified four blank source fields:

| Cell | Field | Cleaning action |
|---|---|---|
| C18 | Manufacturer | Filled using the matching medicine's value in its other batch records |
| G43 | UnitCost | Filled using the matching medicine's value in its other batch records |
| E86 | IntendedUse | Filled using the matching medicine's value in its other batch records |
| K111 | ExpDate | Left blank because expiry is batch-specific and could not safely be inferred |

The K111 blank was retained deliberately. Its calculated `ExpiryStatus` is `Unknown`; it was not replaced with an assumed date.

## 4. Text consistency and whitespace checks

### Capitalization and category consistency

Filtered the categorical columns and checked their values for inconsistent capitalization and category labels. For example, the lower-case `tablet` value in `MedType` was standardized to `Tablet`.

Cross-batch consistency was also checked for attributes expected to remain the same for a medicine, including `Manufacturer`, `MedType` and `IntendedUse`. Where a batch row disagreed with the other rows for the same `MedID`, the value was reviewed and corrected to match the medicine's consistent value.

The manufacturer name is **NovaMeds**. Preserve this spelling in the dataset and documentation.

### Leading/trailing spaces

Used a helper formula on the reviewed text/identifier fields:

```excel
=LEN(A2)<>LEN(TRIM(A2))
```

The column reference was changed for each field checked (`MedID`, `MedName`, `Manufacturer`, `MedType`, `IntendedUse`, `PrescriptionNeeded` and `BatchNum`). The check returned no remaining leading/trailing-space issues in the reviewed values.

## 5. Date-format standardization

A helper formula was used to distinguish blank dates, Excel date values and text dates:

```excel
=IF(K2="","Blank",IF(ISNUMBER(K2),"Excel Date","Text Date"))
```

Four text-formatted dates were converted to real Excel dates using `DATE(year,month,day)` and formatted consistently as `dd-mmm-yyyy`:

| Cell | Date after conversion | Formula used |
|---|---|---|
| K22 | 14-Nov-2026 | `=DATE(2026,11,14)` |
| K47 | 15-Dec-2026 | `=DATE(2026,12,15)` |
| K75 | 12-Jan-2027 | `=DATE(2027,1,12)` |
| K121 | 03-Feb-2027 | `=DATE(2027,2,3)` |

K111 remained blank and was not converted into a date.

## 6. Numeric and record-level validation

The following checks were performed on the cleaned data:

### Quantity is a non-negative whole number

```excel
=AND(ISNUMBER(L2),L2>=0,MOD(L2,1)=0)
```

### Reorder level is a non-negative whole number

```excel
=AND(ISNUMBER(I2),I2>=0,MOD(I2,1)=0)
```

### Unit cost and selling price are numeric and valid

```excel
=AND(ISNUMBER(G2),ISNUMBER(H2),G2>0,H2>G2)
```

### Each batch number is unique

```excel
=COUNTIF($J$2:$J$151,J2)=1
```

### Each medicine has three batch records

```excel
=COUNTIF($A$2:$A$151,A2)=3
```

### Manufacturer consistency across a medicine's batches

```excel
=COUNTIFS($A$2:$A$151,A2,$C$2:$C$151,C2)=COUNTIF($A$2:$A$151,A2)
```

Equivalent checks were used for `MedType` (column D) and `IntendedUse` (column E), substituting the relevant column in the `COUNTIFS` formula.

## 7. Cleaning outcome

| Check | Outcome |
|---|---|
| Exact duplicate rows | 5 removed; 150 records retained |
| Unique medicines | 50 |
| Batch records per medicine | 3 |
| Missing Manufacturer, UnitCost and IntendedUse | Filled from matching medicine records |
| Missing ExpDate | 1 retained as blank / Unknown |
| Text dates | 4 converted to real Excel dates |
| Quantity and reorder level | Validated as non-negative whole numbers |
| Prices | Validated as numeric, positive, with selling price greater than unit cost |
| Batch identifiers | Validated as unique |
| Cross-batch attributes | Reviewed for consistency |

The raw workbook should remain unchanged. The V1.1 workbook is the cleaned and analysis-ready version.
