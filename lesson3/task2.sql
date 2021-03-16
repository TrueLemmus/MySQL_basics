/* Практическое задание №3. */

/* Задание 2.
 * Придумать 2-3 таблицы для БД vk, которую мы создали на занятии (с перечнем полей, указанием индексов и внешних ключей).
*/

-- выбираем текущую базу с которой будем работать
USE vk;

-- таблица постов пользователя
CREATE TABLE user_posts (
	post_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	post_txt TEXT NOT NULL,
	INDEX fk_user_post_idx (user_id),
	CONSTRAINT fk_user_post FOREIGN KEY (user_id) REFERENCES users (id)
);

-- таблица чёрного списка
CREATE TABLE blacklist (
  user_id BIGINT UNSIGNED NOT NULL,
  banned_user_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, banned_user_id),
  CONSTRAINT fk_blacklist_user_id FOREIGN KEY (user_id) REFERENCES users (id),
  CONSTRAINT fk_blacklist_banned_user_id FOREIGN KEY (banned_user_id) REFERENCES users (id)
);

DROP TABLE blacklist;

DESCRIBE blacklist;