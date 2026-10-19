# LinkedIn draft (DRAFT, not posted; needs your approval; target Sat 24 Oct 2026, 4:00 PM IST)

Stock can sit on the shelf and still be a loss. If a batch has 20 days of shelf life left but 60 days of cover, it will not sell in time.

I built a decision engine around that question: Expiry Risk Prediction & FEFO Decision Engine for Warehouse Inventory.

What I did: 5,000 synthetic batch records across 5 warehouses, with a fixed snapshot date. For each batch I worked out days to expiry, days of cover, expected sell-through and the quantity likely left at expiry. Then simple, adjustable rules sort every batch into a risk band and a next action: quarantine, FEFO priority, promotion review, transfer evaluation, or stop replenishment.

What the synthetic data showed:
- About 26.7% of stock value (INR 22.7M of 85.3M) was modeled as at risk
- 215 batches already past expiry, 366 more in the critical band with a median of 12 days left
- 188 at-risk batches where another warehouse's demand could absorb the excess

This is a rule-based model, not machine learning, and the data is synthetic, so these are not real savings. The point is the method.

Built with Excel, Power Query and Power BI (DAX). Repo: [GitHub link here]

#SupplyChain #InventoryManagement #WarehouseOperations #PowerBI #DataAnalytics

Before posting: attach the PDF (linkedin/expiry-risk-fefo-decision-engine-summary.pdf) or your Power BI report PDF, one document only; add the GitHub link.
