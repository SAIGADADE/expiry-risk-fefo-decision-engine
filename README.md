# Expiry Risk Prediction & FEFO Decision Engine for Warehouse Inventory

**Synthetic data only.** No employer or real company data. A rule-based (heuristic) model, not machine learning.

## Business problem
Stock can be physically available while its remaining shelf life is shorter than the time needed to sell it. This project finds those batches, sizes the exposed value and recommends an action (FEFO, transfer, promotion, replenishment hold, quarantine). Decision owner: Inventory Manager / FMCG Warehouse Supervisor.

## Dataset
5,000 batch records (SKU x batch x warehouse), 300 SKUs, 5 fictional warehouses, 4 categories, snapshot 20-Oct-2026. See data/data_dictionary.md.

## Method and formulas
See documentation/methodology.md. Thresholds are configurable (data/raw/risk_rules.csv, Rules sheet in excel/expiry_risk_model.xlsx).

## Headline results (synthetic, modeled)
INR 22.7M of INR 85.3M stock value (26.7%) modeled as at risk; 215 expired and 366 critical batches; 188 transfer candidates. Details in documentation/findings.md.

## Recommendations
Quarantine expired batches per approved procedure; FEFO-pick and review promotion for critical/high batches; evaluate transfers where destination demand can absorb the excess; stop replenishing zero-demand SKUs; keep quality-hold batches out of routine sell/transfer. Follow-up KPI: at-risk % of stock value.

## Repository map
data/raw, data/processed, excel/expiry_risk_model.xlsx (live formulas), power-query/, dax/, documentation/, dashboard/ (report plan, .pbix not built), linkedin/ (post draft + summary PDF).

## Validation
24 checks, all pass: documentation/test_cases.md.

## Limitations
documentation/limitations.md. Tools: Excel, Power Query, Power BI (DAX).

## Reproduce
Open the Excel model, change thresholds on the Rules sheet, and the Batches and Summary sheets recalculate. In Power BI, follow dashboard/power_bi_report_plan.md.
