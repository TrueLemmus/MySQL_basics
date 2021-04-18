USE shop_sample;

/* Вывод всей информации о товаре */

SELECT p.name, c.name AS catalog_name, concat(atr.attribute_name, ' ', atr.attribute_value) AS prod_attributes
FROM products p 
JOIN product_attributes pa ON p.product_id = pa.product_id
JOIN `attributes` atr ON atr.attribute_id = pa.attribute_id
JOIN catalogs c ON c.catalog_id = p.catalog_id 
WHERE p.product_id = 1;

/* Выводим пользователей совешивших заказы и их количество заказов */

SELECT customers.name, count(*) AS orders_qnt
FROM orders JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id;

/* Выводим соответсвующию товару категорию */

SELECT p.name AS product_name, c.name AS catalog_name 
FROM products p LEFT JOIN catalogs c 
ON p.catalog_id = c.catalog_id ; 
