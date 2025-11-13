-- Daily Revenue: Google Analytics Sample
SELECT
  DATE(date) AS fecha,
  SUM(totals.totalTransactionRevenue) / 1000000 AS revenue_usd,
  SUM(totals.transactions) AS total_transactions,
  COUNT(*) AS sesiones
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`
GROUP BY
  fecha
ORDER BY
  fecha;
