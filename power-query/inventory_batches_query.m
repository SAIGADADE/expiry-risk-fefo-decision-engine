// Power Query (M): load and type inventory_batches.csv, keep raw columns, add calculated columns
let
    Source = Csv.Document(File.Contents("C:\path\to\data\raw\inventory_batches.csv"), [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Typed = Table.TransformColumnTypes(Promoted, {
        {"Snapshot_Date", type date}, {"Receipt_Date", type date}, {"Manufacture_Date", type date}, {"Expiry_Date", type date},
        {"Qty_On_Hand", Int64.Type}, {"Unit_Cost_INR", type number}, {"Selling_Price_INR", type number},
        {"Sales_Qty_7D", Int64.Type}, {"Sales_Qty_30D", Int64.Type}, {"Sales_Qty_90D", Int64.Type},
        {"Destination_Sales_Qty_30D", Int64.Type}, {"Destination_On_Hand_Qty", Int64.Type},
        {"Quality_Hold_Flag", type logical}}),
    Trimmed = Table.TransformColumns(Typed, {{"Category", Text.Trim, type text}, {"Warehouse", Text.Trim, type text}}),
    DTE = Table.AddColumn(Trimmed, "Days_To_Expiry", each Duration.Days([Expiry_Date] - [Snapshot_Date]), Int64.Type),
    ADD = Table.AddColumn(DTE, "Avg_Daily_Demand", each [Sales_Qty_30D] / 30, type number),
    DOC = Table.AddColumn(ADD, "Days_Of_Cover", each if [Avg_Daily_Demand] > 0 then [Qty_On_Hand] / [Avg_Daily_Demand] else null, type nullable number),
    EST = Table.AddColumn(DOC, "Expected_Sell_Through", each [Avg_Daily_Demand] * List.Max({[Days_To_Expiry], 0}), type number),
    EXC = Table.AddColumn(EST, "Expected_Excess_At_Expiry", each List.Max({[Qty_On_Hand] - [Expected_Sell_Through], 0}), type number),
    SV = Table.AddColumn(EXC, "Stock_Value_INR", each [Qty_On_Hand] * [Unit_Cost_INR], type number),
    EV = Table.AddColumn(SV, "Excess_Value_INR", each [Expected_Excess_At_Expiry] * [Unit_Cost_INR], type number),
    Band = Table.AddColumn(EV, "Risk_Band", each
        if [Qty_On_Hand] = 0 then "No Stock"
        else if [Days_To_Expiry] < 0 then "Expired"
        else if [Avg_Daily_Demand] = 0 then "Zero Demand"
        else if [Expected_Excess_At_Expiry] = 0 then "Healthy"
        else if [Days_To_Expiry] <= 30 then "Critical"
        else if [Days_To_Expiry] <= 90 then "High"
        else "Medium", type text)
in
    Band
