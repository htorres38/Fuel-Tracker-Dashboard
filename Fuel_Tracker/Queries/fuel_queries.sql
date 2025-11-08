SELECT
  date,
  'Houston' AS series,
  gasoline_price AS price
FROM fuel_prices
UNION ALL
SELECT date, 'Texas Statewide' AS series, texas_avg AS price FROM fuel_prices
UNION ALL
SELECT date, 'U.S. National' AS series, national_avg AS price FROM fuel_prices;

WITH base AS (
  SELECT
    date,
    city,
    gasoline_price,
    texas_avg,
    national_avg,
    (gasoline_price - texas_avg)  AS spread_vs_tx,
    (gasoline_price - national_avg) AS spread_vs_us,
    YEAR(date)  AS yr,
    MONTH(date) AS mo
  FROM fuel_prices
),
lagged AS (
  SELECT
    *,
    LAG(gasoline_price, 1)  OVER (ORDER BY date)  AS prev_m,
    LAG(gasoline_price, 12) OVER (ORDER BY date)  AS prev_y,
    AVG(gasoline_price) OVER (ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS roll_3m_avg,
    STDDEV_SAMP(gasoline_price) OVER (ORDER BY date ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS roll_6m_vol
  FROM base
)
SELECT
  *,
  CASE WHEN prev_m IS NULL OR prev_m = 0 THEN NULL
       ELSE (gasoline_price - prev_m) / prev_m END    AS mom_pct,
  CASE WHEN prev_y IS NULL OR prev_y = 0 THEN NULL
       ELSE (gasoline_price - prev_y) / prev_y END    AS yoy_pct
FROM lagged
ORDER BY date;

SELECT date, gasoline_price
FROM fuel_prices
WHERE city = 'Houston'
ORDER BY date DESC
LIMIT 1;

SELECT date, texas_avg
FROM fuel_prices
WHERE city = 'Houston'
ORDER BY date DESC
LIMIT 1;

SELECT date, national_avg
FROM fuel_prices
WHERE city = 'Houston'
ORDER BY date DESC
LIMIT 1;

SELECT date, gasoline_price - texas_avg AS spread
FROM fuel_prices
ORDER BY date DESC
LIMIT 1;


SELECT
  YEAR(`date`) AS year,
  MONTH(`date`) AS month_num,
  DATE_FORMAT(`date`, '%b') AS month_lbl,
  AVG(gasoline_price) AS avg_price
FROM fuel_prices
GROUP BY 1,2,3
ORDER BY 1,2;

WITH yrs AS (
  SELECT
    YEAR(date) AS year,
    AVG(gasoline_price) AS houston_avg,
    AVG(texas_avg)      AS texas_avg,
    AVG(national_avg)   AS us_avg
  FROM fuel_prices
  GROUP BY YEAR(date)
)
SELECT year, 'Houston' AS series, houston_avg AS avg_price FROM yrs
UNION ALL
SELECT year, 'Texas Statewide', texas_avg FROM yrs
UNION ALL
SELECT year, 'U.S. National', us_avg FROM yrs
ORDER BY year, series;

WITH calc AS (
  SELECT
    date,
    gasoline_price,
    LAG(gasoline_price, 1)  OVER (ORDER BY date)  AS prev_m,
    LAG(gasoline_price, 12) OVER (ORDER BY date)  AS prev_y,
    CASE
      WHEN LAG(gasoline_price,1) OVER (ORDER BY date) IS NULL
        THEN NULL
      ELSE (gasoline_price - LAG(gasoline_price,1) OVER (ORDER BY date))
    END AS mom_abs,
    CASE
      WHEN LAG(gasoline_price,1) OVER (ORDER BY date) IS NULL
           OR LAG(gasoline_price,1) OVER (ORDER BY date) = 0
        THEN NULL
      ELSE (gasoline_price - LAG(gasoline_price,1) OVER (ORDER BY date))
           / LAG(gasoline_price,1) OVER (ORDER BY date)
    END AS mom_pct,
    CASE
      WHEN LAG(gasoline_price,12) OVER (ORDER BY date) IS NULL
           OR LAG(gasoline_price,12) OVER (ORDER BY date) = 0
        THEN NULL
      ELSE (gasoline_price - LAG(gasoline_price,12) OVER (ORDER BY date))
           / LAG(gasoline_price,12) OVER (ORDER BY date)
    END AS yoy_pct
  FROM fuel_prices
  WHERE city = 'Houston'            
)
SELECT date, 'MoM %' AS metric, mom_pct AS pct
FROM calc
WHERE mom_pct IS NOT NULL

UNION ALL
SELECT date, 'YoY %' AS metric, yoy_pct AS pct
FROM calc
WHERE yoy_pct IS NOT NULL

ORDER BY date, metric;

WITH m AS (
  SELECT
    date,
    (gasoline_price - LAG(gasoline_price, 1) OVER (ORDER BY date))
      / NULLIF(LAG(gasoline_price, 1) OVER (ORDER BY date), 0) AS mom_pct
  FROM fuel_prices
)
SELECT date, mom_pct
FROM m
WHERE mom_pct IS NOT NULL
ORDER BY date DESC
LIMIT 1;

WITH y AS (
  SELECT
    date,
    (gasoline_price - LAG(gasoline_price, 12) OVER (ORDER BY date))
      / NULLIF(LAG(gasoline_price, 12) OVER (ORDER BY date), 0) AS yoy_pct
  FROM fuel_prices
)
SELECT date, yoy_pct
FROM y
WHERE yoy_pct IS NOT NULL
ORDER BY date DESC
LIMIT 1;

