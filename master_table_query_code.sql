WITH temp_table AS(
  SELECT
    transaction_id,
    price * (1-discount_percentage) AS nett_sales,
    CASE
      WHEN price * (1-discount_percentage) <= 50000 THEN 0.1
      WHEN price * (1-discount_percentage) <= 100000 THEN 0.15
      WHEN price * (1-discount_percentage) <= 300000 THEN 0.2
      WHEN price * (1-discount_percentage) <= 500000 THEN 0.25
      ELSE 0.3
    END AS persentase_gross_laba
  FROM KF_FInal_Task.kf_final_transaction
)
SELECT 
  ft.transaction_id,
  ft.date,
  ft.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  ft.customer_name,
  ft.product_id,
  p.product_name,
  p.price AS actual_price,
  ft.discount_percentage,
  tt.persentase_gross_laba,
  tt.nett_sales,
  ROUND(tt.nett_sales * tt.persentase_gross_laba,1) AS nett_profit,
  ft.rating
FROM KF_FInal_Task.kf_final_transaction AS ft
JOIN KF_FInal_Task.kf_kantor_cabang AS kc
ON ft.branch_id = kc.branch_id
JOIN KF_FInal_Task.kf_product AS p
ON ft.product_id = p.product_id
JOIN temp_table as tt
ON ft.transaction_id = tt.transaction_id
ORDER BY 1 desc