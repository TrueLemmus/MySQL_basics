/* Практическое задание #11. */

/* Задание # 1.
 * Создайте таблицу logs типа Archive.
 * Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи,
 * название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


-- триггер для user
DROP TRIGGER IF EXISTS watchlog_users;
DELIMITER //

CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //

DELIMITER ;


-- триггер для catalogs
DROP TRIGGER IF EXISTS watchlog_catalogs;

DELIMITER //

CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //

DELIMITER ;


-- триггер для products
DELIMITER //

CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //

DELIMITER ;


/* Заданеие 2.
 * (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

-- создаём цикл добавляющий заданное количество записей.
DROP PROCEDURE IF EXISTS insert_many;

DELIMITER //

CREATE PROCEDURE insert_many(IN Q INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    
    WHILE i < Q DO
	INSERT INTO users (name) VALUES (concat('user', i));
        SET i = i + 1;
    END WHILE;
    
END//

DELIMITER ;

-- на моём пк данный цикл выполнялся 7 минут
CALL insert_many(10000);

SELECT * FROM users u ;
