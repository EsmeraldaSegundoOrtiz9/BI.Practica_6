DROP TABLE IF EXISTS data_mart_ventas;

CREATE TABLE data_mart_ventas AS

SELECT
    p.category,

    COUNT(*) AS total_transacciones,

    SUM(f.quantity::numeric) AS total_unidades_vendidas,

    ROUND(
        AVG(
            REPLACE(f.unit_price,'$','')::numeric
        ),
        2
    ) AS precio_promedio,

    ROUND(
        AVG(f.rating::numeric),
        2
    ) AS rating_promedio,

    ROUND(
        AVG(f.profit_margin::numeric),
        2
    ) AS margen_promedio

FROM fact_ventas f

JOIN dim_producto p
    ON f.id_producto = p.id_producto

GROUP BY p.category

ORDER BY total_unidades_vendidas DESC;