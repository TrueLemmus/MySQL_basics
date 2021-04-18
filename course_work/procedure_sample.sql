USE shop_sample;

/* Процедура подсчёта рейтинга товара.
 * На вход получает id товара выводит его рейтинг по пятибальной шкале.
 */

DROP PROCEDURE IF EXISTS avg_rating;

delimiter //

CREATE PROCEDURE avg_rating (IN id INT)
BEGIN
	SELECT avg(c.rating / 20) FROM comments c 
	WHERE product_id = id;
END//

delimiter ;


CALL avg_rating(4);