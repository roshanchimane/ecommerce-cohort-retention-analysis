# E-Commerce Customer & Cohort Analytics

## Objective
Analyze customer behavior using cohort analysis to understand retention, churn, repeat purchases, and customer lifetime value (CLV).

## Dataset Overview
The dataset contains e-commerce order-level data including:
- Customer ID
- Order ID
- Order Date
- Order Value
- Customer Type (One-Time / Repeat Buyer)

Cohort tables were derived based on the customer’s first purchase month.

## Key Metrics
- Total Customers
- Total Orders
- Total Revenue
- Average CLV
- Month 1 Retention
- Monthly Churn Rate

## Cohort Analysis Methodology
- Customers are grouped into cohorts by **first purchase month**
- Retention is tracked using a **cohort index** (months since first purchase)
- Retention % = Active customers in month N / Cohort size

## Dashboard Features
- KPI cards for business metrics
- Cohort retention matrix
- Retention trend by cohort index
- Orders per customer distribution
- Customer type contribution (Repeat vs One-Time)
- Interactive slicers (Month, Cohort Month)

## Tools Used
- Power BI
- DAX
- SQL (for data preparation logic)
- Excel / CSV

## Outcome
The dashboard provides clear visibility into customer retention behavior and highlights opportunities to improve repeat purchases and long-term value.
