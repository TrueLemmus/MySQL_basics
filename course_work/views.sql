USE shop_sample;

/* Представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs. */

CREATE VIEW v_products (products_name, catalog_name) AS 
	SELECT products.name, catalogs.name 
	FROM products
	JOIN catalogs ON products.catalog_id = catalogs.catalog_id;

SELECT * FROM v_products vp ;


/* Представление выводящее количество заказов пользователя */

CREATE VIEW v_customer_orders AS 
	SELECT customers.name, count(*) AS orders_qnt
	FROM orders JOIN customers ON orders.customer_id = customers.customer_id
	GROUP BY customers.customer_id;
	
SELECT * FROM v_customer_orders;