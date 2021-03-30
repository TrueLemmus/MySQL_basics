/* Практическое задание #7. */

USE shop;

/* Задание 1
 * Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

-- соеденяем две таблицы по полю user_id и id что бы получить необходимый результат для красоты группируем по id и считаем количество заказов
SELECT users.name, count(*) AS orders_qnt
FROM orders JOIN users ON orders.user_id = users.id
GROUP BY users.id;


/* Задание 2
 * Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT * FROM products p;
SELECT * FROM catalogs c;

-- соеденяем две таблицы с помощью left join чтобы получить все записи левой таблицы
SELECT p.name AS product_name, c.name AS catalog_name 
FROM products p LEFT JOIN catalogs c 
ON p.catalog_id = c.id; 

/* Задание 3
 * (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
 * Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/

-- создаём необходимые таблицы
CREATE TABLE flights (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`from` varchar(250),
	`to` varchar(250)
);

CREATE TABLE cities (
	label varchar(250),
	name varchar(250)
);

-- заполняем таблицы данными
INSERT INTO flights VALUES 
	(default, 'moscow', 'omsk'),
	(default, 'novgorod', 'kazan'),
	(default, 'irkutsk', 'moscow'),
	(default, 'omsk', 'irkutsk'),
	(default, 'moscow', 'kazan');

INSERT INTO flights VALUES 
	(default, 'kazan', 'omsk');

INSERT INTO cities VALUES 
	('moscow','Москва'),
	('novgorod','Новгород'),
	('irkutsk','Иркутск'),
	('omsk','Омск'),
	('kazan','Казань');


SELECT * FROM cities;

-- запрос с использованием подзапросов
SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;

-- Запрос с использованием left join
SELECT f.id AS flight_id, c1.name AS `from`, c2.name AS `to` FROM flights AS f
	LEFT JOIN cities AS c1 ON (c1.label = f.`from`)
	LEFT JOIN cities AS c2 ON (c2.label = f.`to`)
ORDER BY flight_id;
