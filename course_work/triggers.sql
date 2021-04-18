USE shop_sample;

/* При изменении адреса элетронной почты записываем старую почту в лог.
 * Email взят для примера таким же способом можно вести лог любой колонки.
*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	updeted_at DATETIME NOT NULL,
	customer_id bigint UNSIGNED NOT NULL,
	customer_name VARCHAR(255) NOT NULL,
	new_email VARCHAR(255) NOT NULL,
	old_email VARCHAR(255) NOT NULL
) ENGINE = ARCHIVE;


DROP TRIGGER IF EXISTS watchlog_customers;

DELIMITER //

CREATE TRIGGER watchlog_customers AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
	INSERT INTO logs (updeted_at, customer_id, customer_name, new_email, old_email)
	VALUES (NOW(), OLD.customer_id, OLD.name, NEW.email, OLD.email);
END //

DELIMITER ;


UPDATE customers 
SET email = 'somenew3@mail.ru'
WHERE customer_id = 1;

SELECT * FROM logs;