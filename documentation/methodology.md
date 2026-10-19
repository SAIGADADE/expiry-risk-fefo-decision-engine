# Methodology

Heuristic decision model. It is NOT a machine-learning forecast and makes no accuracy claim.

## Formulas
- Days to Expiry = Expiry_Date - Snapshot_Date
- Avg Daily Demand = Sales_Qty_30D / 30
- Days of Cover = Qty_On_Hand / Avg Daily Demand, blank when demand = 0 (flagged Zero Demand)
- Expected Sell-Through = Avg Daily Demand x max(Days to Expiry, 0)
- Expected Excess at Expiry = max(Qty_On_Hand - Expected Sell-Through, 0)
- Stock Value = Qty_On_Hand x Unit_Cost_INR; At-Risk Value = Expected Excess x Unit_Cost_INR
- Dest Absorb Capacity = max(0, Destination 30D sales / 30 x Days to Expiry - Destination On-Hand)

## Risk band (first rule that matches)
1. Qty = 0: No Stock
2. Days to Expiry < 0: Expired
3. Avg Daily Demand = 0: Zero Demand
4. Excess = 0: Healthy
5. Days to Expiry <= 30: Critical; <= 90: High; otherwise Medium
Thresholds live in data/raw/risk_rules.csv and the Rules sheet of the Excel model.

## Primary action
Quality hold first (no routine sell or transfer) -> Expired: quarantine per approved disposition -> Zero Demand: stop replenishment and investigate -> Healthy: normal operations -> Transfer candidate: evaluate transfer -> Critical: FEFO priority pick and promotion review -> High: promotion/clearance review -> Medium: monitor.
Transfer candidate = excess > 0, no quality hold, at least 15 days to expiry, and destination capacity >= excess. This is an evidence flag to evaluate, not an instruction; real transport cost and capacity still need checking.

## Worked example
Batch with 120 units, 60 sold in 30 days, 25 days left: demand 2.0/day, cover 60 days, sell-through 50, excess 70 units, band Critical.
