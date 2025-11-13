-- Product Performance Metrics
-- Métricas de rendimiento por producto utilizando Google Analytics Sample

SELECT
  p.v2ProductName AS product_name,
  COUNT(DISTINCT s.fullVisitorId) AS unique_visitors,
  SUM(p.productQuantity) AS total_units_sold,
  SUM(p.productRevenue) / 1000000 AS revenue_usd,
  SAFE_DIVIDE(SUM(p.productRevenue), COUNT(DISTINCT s.fullVisitorId)) / 1000000 
    AS revenue_per_visitor_usd
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*` s
LEFT JOIN
  UNNEST(s.hits) h
LEFT JOIN
  UNNEST(h.product) p
GROUP BY
  product_name
HAVING
  product_name IS NOT NULL
ORDER BY
  revenue_usd DESC;
