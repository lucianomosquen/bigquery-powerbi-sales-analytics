-- 03_customer_segments.sql
-- Segmentación de clientes con métricas RFM (Recency, Frequency, Monetary)

WITH base AS (
  SELECT
    fullvisitorid AS customer_id,
    PARSE_DATE('%Y%m%d', date) AS visit_date,
    totals.totalTransactionRevenue/1000000 AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE totals.totalTransactionRevenue IS NOT NULL
),

rfm AS (
  SELECT
    customer_id,
    MAX(visit_date) AS last_purchase_date,
    COUNT(*) AS frequency,
    SUM(revenue) AS total_revenue,
    DATE_DIFF(DATE('2017-08-01'), MAX(visit_date), DAY) AS recency
  FROM base
  GROUP BY customer_id
)

SELECT
  customer_id,
  recency,
  frequency,
  total_revenue,
  -- Segmentación simple
  CASE
    WHEN recency < 30 AND frequency >= 2 THEN 'Cliente Leal'
    WHEN recency < 60 THEN 'Cliente Activo'
    WHEN recency BETWEEN 60 AND 120 THEN 'Cliente en Riesgo'
    ELSE 'Cliente Perdido'
  END AS customer_segment
FROM rfm
ORDER BY total_revenue DESC;
