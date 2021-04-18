USE shop_sample;


/* При каждом создании записи в таблицах customers, catalogs и products в таблицу logs помещается время и дата создания записи,
 * название таблицы, идентификатор первичного ключа и содержимое поля name. */

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


-- триггер для user
DROP TRIGGER IF EXISTS watchlog_customers;

DELIMITER //

CREATE TRIGGER watchlog_customers AFTER INSERT ON customers
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'customers', NEW.customer_id, NEW.name);
END //

DELIMITER ;


-- триггер для catalogs
DROP TRIGGER IF EXISTS watchlog_catalogs;

DELIMITER //

CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.catalog_id, NEW.name);
END //

DELIMITER ;


-- триггер для products
DELIMITER //

CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.product_id, NEW.name);
END //

DELIMITER ;

