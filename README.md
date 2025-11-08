# Houston Fuel Price Tracker (2020–2025)

A MySQL and Power BI project that analyzes monthly Houston gasoline prices compared to the Texas and U.S. averages.  
The dashboard highlights the most recent values, price differences (spreads), seasonal patterns, yearly averages, and both month-over-month (MoM) and year-over-year (YoY) changes.

---

## Overview

This project provides a clear, data-driven view of how gasoline prices in Houston have changed relative to Texas and U.S. benchmarks from 2020 through 2025.  
All data was stored and processed in MySQL, then visualized in Power BI to produce the “Houston Gasoline Prices vs Texas & U.S.” dashboard.

---

## Data Structure

The MySQL table `fuel_prices` was created and populated manually using insert statements.  
Each record represents the average regular gasoline price for a given month.

**Table columns:**
- `date`
- `city`
- `gasoline_price`
- `texas_avg`
- `national_avg`

The dataset covers monthly data from **January 2020 to August 2025**.

---

## SQL Analysis

All major calculations and transformations were done in MySQL before being imported into Power BI.

### Key Queries
- **Monthly and yearly averages** — track price trends over time  
- **MoM and YoY percent changes** — identify short- and long-term shifts  
- **Spreads** — compute price differences between Houston, Texas, and the U.S.  
- **Rolling averages and volatility** — calculate 3-month moving averages and 6-month standard deviations  
- **Yearly summaries** — aggregate mean prices by year  

These queries ensured Power BI visuals reflected accurate and clean results directly from SQL outputs.

---

## Power BI Dashboard

The Power BI report visualizes all MySQL results with metrics, trends, and comparisons across multiple views.  
It includes the following components:

### 1. Key Performance Indicators (KPIs)
- Latest Houston gasoline price: **$2.669/gal (Aug 2025)**  
- Latest Texas statewide average: **$2.704/gal**  
- Latest U.S. national average: **$3.258/gal**  
- Spreads:
  - Houston − Texas: **−$0.035**
  - Houston − U.S.: **−$0.589**
- Month-over-month change: **−0.6 %**
- Year-over-year change: **−9.4 %**

### 2. Line Chart – Monthly Gasoline Price Trends
Shows the price movement for **Houston**, **Texas**, and **U.S.** from 2020–2025.  
Houston generally tracks the Texas average but stays below the national line.  
The **local peak** was June 2022 ($4.55/gal), and the **lowest** point was May 2020 ($1.53/gal):contentReference[oaicite:0]{index=0}.

### 3. Line Chart – Houston Price Spreads vs. Texas and U.S.
Displays the difference between Houston’s price and each benchmark.  
Negative values mean Houston was cheaper.  
Recent trends show the gap widening slightly against both Texas and U.S. averages.

### 4. Heatmap – Seasonality (Average Price by Month and Year)
Reveals recurring patterns where **prices peak around June (~$2.94/gal)** and **dip near December (~$2.48/gal)**.  
This helps identify predictable seasonal behavior across years.

### 5. Bar Chart – Yearly Average Prices
Summarizes average annual prices for Houston, Texas, and the U.S.  
The highest Houston yearly average was **2022 ($3.46/gal)**, with values staying below the national average but close to Texas throughout.

### 6. Line Chart – MoM and YoY % Change
Plots monthly and yearly percent changes.  
Notable swings include:
- **Largest monthly increase:** March 2022 (+24.2 %)  
- **Largest monthly drop:** April 2020 (−17.7 %)  
- **Biggest YoY rise:** November 2021 (+75.6 %)  
- **Biggest YoY fall:** June 2023 (−33.1 %):contentReference[oaicite:1]{index=1}

---

## Technical Workflow

1. Create and populate the `fuel_prices` table in MySQL using `create_table.sql`.  
2. Run `fuel_queries.sql` to calculate spreads, MoM, YoY, and rolling metrics.  
3. Export SQL results or connect Power BI directly to MySQL.  
4. Build visuals using fields such as date, price, spread, and calculated measures.  
5. Format KPIs, line charts, and heatmaps for consistent styling and readability.

---

## Key Insights
- Houston gasoline prices move closely with Texas averages but remain **consistently cheaper** than the U.S. average.  
- Major price volatility occurred in 2022 with record highs.  
- Regular seasonal dips appear at year-end months.  
- Yearly averages show 2022 as the costliest and 2020 as the cheapest period.

---
## Data Source
- All gasoline price data comes from the U.S. Energy Information Administration (EIA) monthly averages for regular gasoline.  
- The dataset includes Houston, Texas statewide, and U.S. national prices from January 2020 through August 2025.
---
## Summary
This project uses MySQL to manage and analyze monthly gasoline price data and Power BI to visualize the results.  
It focuses on showing how Houston’s prices compare with state and national averages over time.  
By combining SQL queries with Power BI dashboards, the project provides a clear picture of fuel price trends, seasonal patterns, and year-over-year changes in a simple, data-driven way.

