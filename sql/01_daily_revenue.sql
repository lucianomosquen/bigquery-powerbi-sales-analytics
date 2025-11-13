-- 01_daily_revenue.sql
-- Daily Revenue: Google Analytics Sample

SELECT
  PARSE_DATE('%Y%m%d', date) AS fecha,
  SUM(totals.totalTransactionRevenue) / 1000000 AS revenue_usd,
  SUM(totals.transactions) AS total_transactions,
  COUNT(*) AS sesiones
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
  totals.totalTransactionRevenue IS NOT NULL
GROUP BY
  fecha
ORDER BY
  fecha;
