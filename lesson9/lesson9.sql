/* Практическое задание #9. */

/* Практическое задание по теме “Транзакции, переменные, представления” */

/* Задание #1
 * В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/

-- Выбираем базу данных shop
USE shop;
-- Смотрим с какими порамитрами создавалась тоблица users
SHOW CREATE TABLE users;
-- создаём базу данных sample
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
-- Выбираем текущей базой данных sample
USE sample;
-- создаём таблицу users анологичную базе данных shop
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB
-- смотрим содержимое таблицы
SELECT * FROM users;
-- проводим транзвкцию из одной базы в другую в соответсвии с условием
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;
-- смотрим на результат транзакции
SELECT * FROM users;

/* Задание #2
 * Создайте представление, которое выводит название name товарной позиции из таблицы products
 * и соответствующее название каталога name из таблицы catalogs.
*/

USE shop;
-- создаём представления из двух соеденённых таблиц
CREATE VIEW v_products (products_name, catalog_name) AS 
	SELECT products.name, catalogs.name 
	FROM products
	JOIN catalogs ON products.catalog_id=catalogs.id;

SELECT * FROM v_products vp ;

/* Задание #3
 * (по желанию) Пусть имеется таблица с календарным полем created_at.
 * В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
 * Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

-- создаём таблицу и наполняем её
CREATE TABLE datetbl (
	created_at DATE
);

INSERT INTO datetbl VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');

SELECT * FROM datetbl ORDER BY created_at;

-- большую часть данного кода я нагулил и лишь поверхностно представляю как она работает. Надеюсь есть более изящное решение данного задания и вы нам его покажете
SELECT a.Date, NOT isnull(created_at) AS created_at 
from (
    select curdate() - INTERVAL (a.a + (10 * b.a) + (100 * c.a) + (1000 * d.a) ) DAY as Date
    from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
    JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
    JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
    JOIN (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as d
) a
LEFT JOIN datetbl ON a.date=datetbl.created_at
WHERE a.Date between '2018-08-01' and '2018-08-31'
ORDER BY a.date;

/* Задание #4
 * (по желанию) Пусть имеется любая таблица с календарным полем created_at.
 * Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

USE sample;

CREATE TABLE datetbl (
	created_at DATE
);

INSERT INTO datetbl VALUES
	('2020-04-01'),
	('2020-04-02'),
	('2020-04-03'),
	('2020-04-04'),
	('2020-04-05'),
	('2020-04-06'),
	('2020-04-07'),
	('2020-04-08'),
	('2020-04-09'),
	('2020-04-10'),
	('2020-04-11');

SELECT * FROM datetbl ORDER BY created_at DESC;

-- удаляем все что не входит в первую 5
DELETE FROM datetbl
WHERE created_at NOT IN (
	SELECT *
	FROM (
		SELECT *
		FROM datetbl
		ORDER BY created_at DESC
		LIMIT 5
	) AS foo
) ORDER BY created_at DESC;

SELECT * FROM datetbl ORDER BY created_at DESC;

/* Практическое задание по теме “Хранимые процедуры и функции, триггеры" */

/* Задание #1
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
 * с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

-- не удалось заставить работать данный код из dbever для тестирования использовал консоль

DELIMITER //

CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //

DELIMITER ;

CALL hello();

/* Задание #2
 * В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

delimiter //

CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //

delimiter ;
