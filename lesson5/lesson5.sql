/* Практическое задание #5. */

/* Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение» */

/* Задание #1.
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

USE shop;

SELECT * FROM users;

/* 
 * Обновляем значение полей created_at и updated_at на текущее время.
 * В конце можно добавить WHERE is NULL чтобы обновились только пустые значения,
 * по условию же они у нас все пустые
 * И можно не обновлять столбец updated_at он обновляется автоматически
*/
UPDATE users SET created_at = NOW(), updated_at = NOW();

/* Задание #2.
 * Таблица users была неудачно спроектирована.
 * Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
 * Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/

-- Обновим таблицу в соответствии заданию
ALTER TABLE users 
    CHANGE COLUMN `created_at` `created_at` VARCHAR(255) NULL,
    CHANGE COLUMN `updated_at` `updated_at` VARCHAR(255) NULL;

UPDATE users
SET created_at = '20.10.2017 8:10',
    updated_at = '20.10.2017 8:10';

-- Создадим промежуточные столбцы для новых значений
ALTER TABLE users 
	ADD created_at_dt DATETIME DEFAULT CURRENT_TIMESTAMP,
	ADD updated_at_dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- обновим значения в новых столбцах сковертировав сторочную дату
UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');

-- удалим ненужные столбцы и переименуем новые
ALTER TABLE users 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;
    
/* Задание #3.
 * В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 * 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
 * чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
*/

SELECT * FROM storehouses_products;

-- наполним таблицу значениями
INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15),
    (1, 3, 0),
    (1, 5, 10),
    (1, 7, 5),
    (1, 8, 0);
    
-- делаем запрос с сортировкой
SELECT 
    value
FROM
    storehouses_products ORDER BY IF(value > 0, 0, 1), value;
    
/* Задание #4.
 * (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
 * Месяцы заданы в виде списка английских названий (may, august)
*/
    
SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august');


/* Задание #5.
 * (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
*/

SELECT* FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

/* Практическое задание теме «Агрегация данных» */

/* Задание #1.
 * Подсчитайте средний возраст пользователей в таблице users.
*/

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS AVG_Age FROM users;

/* Задание #2.
 * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;
	
/* Задание #3.
 * (по желанию) Подсчитайте произведение чисел в столбце таблицы.
*/
	
SELECT ROUND(exp(SUM(ln(id))), 0) AS factorial FROM users;
