/* Практическое задание #6. */

/* Задание #1.
 * Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем. (можете взять пользователя с любым id).
*/

SELECT from_user_id, to_user_id, count(*) AS send_messenges
FROM messages
-- смотрим кто из друзей отправил пользователю больше всего сообщений
WHERE from_user_id IN (
	SELECT id
	FROM users WHERE id IN (
		-- получаем id всех друзей пользователя
		SELECT to_user_id FROM friend_requests WHERE from_user_id = 3 AND request_type = 1
		UNION
		SELECT from_user_id FROM friend_requests WHERE to_user_id = 3 AND request_type = 1
	)
) AND to_user_id = 3
GROUP BY from_user_id
ORDER BY send_messenges DESC;

/* Задание #2.
 * Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.
*/

SELECT count(*) AS likes FROM posts_likes
WHERE like_type = 1 AND post_id IN (
	-- получаем id постов написанных пользователями младше 18 лет
	SELECT id
	FROM posts
	WHERE user_id IN (
		-- получаем id пользователей младше 18 лет
		SELECT user_id
		FROM profiles
		WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 18
		)
	);

/* Задание #3
 * Определить, кто больше поставил лайков (всего) - мужчины или женщины?
 */

-- Считаем лайки сгрупировав пользователей по полу
SELECT COUNT(*) AS likes, gender FROM posts_likes, profiles
WHERE posts_likes.user_id = profiles.user_id
GROUP BY gender
ORDER BY likes DESC;


/* Задание #4
 * (по желанию) Найти пользователя, который проявляет наименьшую активность в использовании социальной сети.
 */

/* Очень сложно далось это задание. Казалось бы выполнить по отдельности эти запросы не составляет труда,
 * но как же сложно было их обеденить и получить нужный результат.
 * В теории здесь мы считаем упоминание каждого id в каждой таблице 
 * на последнем этапе просто складываем результаты работы запросов к разным таблицам 
 */
SELECT user_id, SUM(activities) as total_activite FROM 
	(
	SELECT user_id, count(*) AS activities FROM media
	GROUP BY user_id
	UNION ALL 
	SELECT user_id, COUNT(*) AS activities FROM posts_likes
	GROUP BY user_id
	UNION ALL 
	SELECT from_user_id AS user_id, COUNT(*) AS activities FROM messages
	GROUP BY user_id
	UNION ALL
	SELECT user_id, COUNT(*) AS activities FROM posts
	GROUP BY user_id
	) AS acts
GROUP BY user_id
ORDER BY total_activite
LIMIT 1;