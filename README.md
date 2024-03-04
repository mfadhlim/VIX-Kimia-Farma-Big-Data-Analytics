# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : Google BigQuery - [Lihat script](https://github.com/mfadhlim/VIX-Kimia-Farma-Big-Data-Analytics/blob/main/master_table_query_code.sql) <br>
Visualization : Looker Data Studio - [Lihat dashboard](https://lookerstudio.google.com/reporting/91c8ebd9-97da-44a6-88d3-2da0968e9cbb) <br>
Dataset : [VIX Kimia Farma](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program)
<br>

---

## 📂 **Introduction**
VIX Big Data Analytics Kimia Farma merupakan virtual internship experience yang difasilitasi oleh [Rakamin Academy](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program). Pada project ini saya berperan sebagai Big Data Analytics Intern yang diminta untuk menganalisis dan membuat laporan penjualan perusahaan menggunakan data-data yang telah disediakan. Dari project ini, saya juga banyak belajar tentang data data warehouse, dataleke, dan datamart. <br>
<br>

**Objectives**
- Membuat master table
- Membuat visualisasi/dashboard performa penjualan perusahaan
<br>

**Dataset** <br>
Dataset yang disediakan terdiri dari tabel-tabel berikut:
- penjualan
- produk
- kantor cabang


---


##  **Analisis Tabel**
Dalam analisis tabel akan dibuat sebuah query untuk mengakses master table yang akan digunakan dalam pembuatan dashboard, tabel tersebut terdiri dari gabungan tabel penjualan (kf_final_transaction), tabel produk (kf_product), dan tabel kantor cabang (kf_kantor_cabang). <br>

<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql
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
```
<br>    


##  **Data Visualization**

[Lihat pada halaman Looker Data Studio](https://lookerstudio.google.com/reporting/91c8ebd9-97da-44a6-88d3-2da0968e9cbb).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://github.com/mfadhlim/VIX-Kimia-Farma-Big-Data-Analytics/blob/main/Dashboard.JPG"> </kbd> <br>
    Gambar 3 — Performmance Analytics Dashboard PT. Kimia Farma
</p>
<br>

---
