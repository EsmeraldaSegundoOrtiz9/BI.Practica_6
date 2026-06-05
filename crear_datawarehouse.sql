DROP TABLE IF EXISTS fact_ventas CASCADE;
DROP TABLE IF EXISTS dim_producto CASCADE;
DROP TABLE IF EXISTS dim_sucursal CASCADE;
DROP TABLE IF EXISTS dim_pago CASCADE;
DROP TABLE IF EXISTS dim_tiempo CASCADE;

-- DIMENSION PRODUCTO

CREATE TABLE dim_producto AS
SELECT
    ROW_NUMBER() OVER() AS id_producto,
    category
FROM (
    SELECT DISTINCT category
    FROM raw_walmart_sales
) x;

ALTER TABLE dim_producto
ADD PRIMARY KEY (id_producto);

-- DIMENSION SUCURSAL

CREATE TABLE dim_sucursal AS
SELECT
    ROW_NUMBER() OVER() AS id_sucursal,
    branch,
    city
FROM (
    SELECT DISTINCT branch, city
    FROM raw_walmart_sales
) x;

ALTER TABLE dim_sucursal
ADD PRIMARY KEY (id_sucursal);

-- DIMENSION PAGO

CREATE TABLE dim_pago AS
SELECT
    ROW_NUMBER() OVER() AS id_pago,
    payment_method
FROM (
    SELECT DISTINCT payment_method
    FROM raw_walmart_sales
) x;

ALTER TABLE dim_pago
ADD PRIMARY KEY (id_pago);

-- DIMENSION TIEMPO

CREATE TABLE dim_tiempo AS
SELECT
    ROW_NUMBER() OVER() AS id_tiempo,
    date::date AS fecha,
    year,
    month,
    day
FROM (
    SELECT DISTINCT date, year, month, day
    FROM raw_walmart_sales
) x;

ALTER TABLE dim_tiempo
ADD PRIMARY KEY (id_tiempo);

-- TABLA DE HECHOS

CREATE TABLE fact_ventas AS
SELECT
    r.invoice_id,

    p.id_producto,
    s.id_sucursal,
    pg.id_pago,
    t.id_tiempo,

    r.unit_price,
    r.quantity,
    r.rating,
    r.profit_margin

FROM raw_walmart_sales r

JOIN dim_producto p
    ON r.category = p.category

JOIN dim_sucursal s
    ON r.branch = s.branch
   AND r.city = s.city

JOIN dim_pago pg
    ON r.payment_method = pg.payment_method

JOIN dim_tiempo t
    ON r.date::date = t.fecha;

ALTER TABLE fact_ventas
ADD PRIMARY KEY (invoice_id);