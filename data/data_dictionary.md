# Data Dictionary (all data is synthetic)

Grain: one row = one SKU x batch x warehouse record on Snapshot_Date 2026-10-20. 5,000 rows, 1,500 SKU x warehouse combinations.

## inventory_batches.csv (raw)
| Field | Type | Definition |
|---|---|---|
| Batch_Record_ID | Text | Unique ID of the batch record |
| Snapshot_Date | Date | Fixed date for every day calculation (2026-10-20) |
| SKU_ID | Text | Synthetic item ID |
| Batch_ID | Text | Lot ID; one SKU has several batches |
| Product_Name | Text | Fictional product name |
| Category | Text | FMCG, Beauty, Personal Care, Home Care |
| Warehouse | Text | Fictional DC-North/South/East/West/Central |
| Supplier_ID | Text | Synthetic supplier S001-S025 |
| Receipt_Date, Manufacture_Date, Expiry_Date | Date | Receipt on/before snapshot; expiry after manufacture; some expiry dates are before the snapshot (expired cases) |
| Qty_On_Hand | Whole number | Units at snapshot; 80 rows are zero stock |
| Unit_Cost_INR, Selling_Price_INR | Decimal | Synthetic; cost drives exposure |
| Sales_Qty_7D / 30D / 90D | Whole number | Units sold from this batch record. 30D is the demand input |
| Destination_Warehouse | Text | Possible transfer location (another warehouse) |
| Destination_Sales_Qty_30D | Whole number | 30-day sales of the same SKU at the destination (from sku_demand_summary.csv) |
| Destination_On_Hand_Qty | Whole number | Total on-hand of the same SKU at the destination |
| Quality_Hold_Flag | TRUE/FALSE | On quality hold |

Not used on purpose: Open_Order_Qty and Temperature_Sensitivity (optional in the brief; no handling rules defined).

## Calculated fields (batch_risk_output.csv, Excel Batches sheet)
Days_To_Expiry, Avg_Daily_Demand, Days_Of_Cover, Expected_Sell_Through, Expected_Excess_At_Expiry, Stock_Value_INR, Excess_Value_INR, Risk_Band, Dest_Absorb_Capacity, Transfer_Candidate, Primary_Action, Priority_Rank. Formulas are in documentation/methodology.md.

## Other raw tables
- sku_demand_summary.csv: SKU x warehouse totals of 30D/90D sales and on-hand (reconciles to the batch table).
- category_rules.csv: shelf-life ranges used to generate dates, and promotion/transfer allowed flags.
- risk_rules.csv: configurable thresholds.
