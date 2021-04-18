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

/*  Представление выводящее все материнские платы на сокете 1151-v2 */

CREATE VIEW v_1151_motherboards as
	SELECT p.product_id, p.name, atr.attribute_name, atr.attribute_value, p.price FROM products p 
	JOIN product_attributes pa ON p.product_id = pa.product_id
	JOIN `attributes` atr ON pa.attribute_id = atr.attribute_id 
	JOIN catalogs c ON c.catalog_id = p.catalog_id 
	WHERE atr.attribute_value = '1151-v2' AND c.name = 'Материнские платы';
	
SELECT * FROM v_1151_motherboards;