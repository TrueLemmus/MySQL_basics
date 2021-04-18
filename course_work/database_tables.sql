/* Creating a database and required tables */

CREATE DATABASE shop_sample;

USE shop_sample;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR (255) UNIQUE NOT NULL,
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  catalog_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  product_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2), -- цену стоит вынести в отдельную таблицу для хранения истории изменения цен
  catalog_id bigint UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_products_catalogs FOREIGN KEY (catalog_id) REFERENCES catalogs (catalog_id)
);

DROP TABLE IF EXISTS `attributes`;
CREATE TABLE `attributes` (
	attribute_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	attribute_name varchar (250),
	attribute_value varchar (250)
);

DROP TABLE IF EXISTS product_attributes;
CREATE TABLE product_attributes (
	product_id bigint UNSIGNED NOT NULL,
	attribute_id bigint UNSIGNED NOT NULL,
	PRIMARY KEY (product_id, attribute_id),
	INDEX idx_product_attributes_product_id (product_id),
	INDEX idx_product_attributes_attribute_id (attribute_id),
	CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products (product_id),
	CONSTRAINT fk_attribute_id FOREIGN KEY (attribute_id) REFERENCES `attributes` (attribute_id)
);

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  storehouse_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  storehouse_name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  storehouse_id bigint UNSIGNED,
  product_id bigint UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_storehouse_id FOREIGN KEY (storehouse_id) REFERENCES storehouses (storehouse_id),
  CONSTRAINT fk_storehouses_product_id FOREIGN KEY (product_id) REFERENCES products (product_id)
) COMMENT = 'Запасы на складе';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_id bigint UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  order_id bigint UNSIGNED NOT NULL,
  product_id bigint UNSIGNED NOT NULL,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id, product_id),
  CONSTRAINT fk_orders_products_orders FOREIGN KEY (order_id) REFERENCES orders (order_id),
  CONSTRAINT fk_orders_products_products FOREIGN KEY (product_id) REFERENCES products (product_id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	comment_id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	product_id bigint UNSIGNED NOT NULL,
	customer_id bigint UNSIGNED NOT NULL,
	order_id bigint UNSIGNED NOT NULL,
	rating SMALLINT NOT NULL, -- SMALLINT для лучшей совместимости и скорости работы.
	comment varchar(1000), -- количество символов выбрано случайным образом в дальнейшем может быть изменено 
	INDEX idx_comments_product_id (product_id),
	INDEX idx_comments_customer_id (customer_id),
	INDEX idx_comments_order_id (order_id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	UNIQUE unique_comment (product_id, customer_id, order_id), 
	CONSTRAINT fk_comments_products FOREIGN KEY (product_id) REFERENCES products (product_id),
	CONSTRAINT fk_comments_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
	CONSTRAINT fk_comments_orders FOREIGN KEY (order_id) REFERENCES orders (order_id)
);
   
   

