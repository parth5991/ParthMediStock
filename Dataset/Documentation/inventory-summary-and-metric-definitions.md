# Inventory Summary and Metric Definitions

The `Inventory Summary` worksheet provides an at-a-glance view of the cleaned dataset. The figures below are from the V1.1 analysis workbook.

| Metric | Result | Definition |
|---|---:|---|
| Total Unique Medicines | 50 | Count of distinct `MedID` values |
| Total Batch Records | 150 | Count of batch identifiers (`BatchNum`) |
| Total Physical Stock Units | 3,558 | Sum of all batch quantities, including expired and unknown-expiry batches |
| Total Usable Stock Units | 3,207 | Sum of quantities in Safe and Soon batches; excludes Expired and Unknown batches |
| Total Inventory Cost | ₹685,520.00 | Sum of batch quantity multiplied by unit cost |
| Total Retail Value | ₹872,238.28 | Sum of batch quantity multiplied by listed selling price |
| Potential Expiry Exposure | ₹355,043.00 | Acquisition cost of Expired and Soon batches; Unknown expiry rows are blank |

## Interpretation notes

### Inventory cost

This is the acquisition cost represented by the full physical stock, including batches already expired and batches with an unknown expiry date.

### Retail value

This is the listed selling price multiplied by the full physical stock quantity. It is a potential retail value, not revenue already earned.

### Usable stock

The project treats both Safe and Soon batches as usable for the current stock-status calculation. Expired and Unknown batches are excluded. A Soon batch is still counted as usable stock under this project's chosen rule, while its acquisition cost is also included in expiry exposure.

### Potential expiry exposure

The measure includes the acquisition cost of batches classified as Expired or Soon. It should be interpreted as stock value exposed to expiry risk, not a booked loss or a forecast of actual write-offs.

### Gross profit and gross margin

Estimated gross profit is total retail value minus inventory cost. Estimated gross margin is gross profit divided by retail value. The calculation assumes all current units are sold at the listed selling price and does not account for discounts, operating expenses, taxes, returns or unsold stock.
