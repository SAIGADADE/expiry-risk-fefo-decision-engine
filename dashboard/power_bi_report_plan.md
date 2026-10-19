# Power BI report plan (the .pbix is NOT built yet; you build it from these files)

Steps: Get Data > Blank Query > paste power-query/inventory_batches_query.m (fix the file path) > Close & Apply > add measures from dax/measures.dax.

1. Executive Expiry Exposure: cards (Total Stock Value, At-Risk Value, At-Risk %, Expired Batches, Critical Batches), risk-band bar chart, slicers for Category and Warehouse.
2. Batch-Level Risk: table sorted by Excess_Value_INR with Days_To_Expiry, Days_Of_Cover, Risk_Band; scatter of Days_To_Expiry vs Days_Of_Cover.
3. FEFO Queue: table from data/processed/fefo_action_queue.csv sorted by Priority_Rank, filter on Primary_Action.
4. Warehouse/Category Exposure: matrix Warehouse x Category with At-Risk Value, heat colouring.
5. Action Recommendations: counts per Primary_Action, transfer candidates by destination.
Every visual needs a clear title and units (INR). Label as synthetic data.
