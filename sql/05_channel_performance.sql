SELECT
  trafficSource.channelGrouping AS channel,
  COUNT(*) AS sessions,
  SUM(totals.transactions) AS total_transactions,
  SUM(totals.totalTransactionRevenue) / 1000000 AS revenue_usd,
  SAFE_DIVIDE(
      SUM(totals.totalTransactionRevenue) / 1000000,
      COUNT(*)
  ) AS revenue_per_session_usd,
  SAFE_DIVIDE(
      SUM(totals.transactions),
      COUNT(*)
  ) AS conversion_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE trafficSource.channelGrouping IS NOT NULL
GROUP BY channel
ORDER BY revenue_usd DESC;
