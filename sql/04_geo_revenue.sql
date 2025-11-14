SELECT
  geoNetwork.country AS country,
  COUNT(*) AS sessions,
  SUM(totals.transactions) AS total_transactions,
  SUM(totals.totalTransactionRevenue) / 1000000 AS revenue_usd
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE geoNetwork.country IS NOT NULL
GROUP BY country
ORDER BY revenue_usd DESC;
