/* Практическое задание №4. */

/* Задание 3.
 * Написать запрос для переименования названий типов медиа (колонка name в media_types) в осмысленные для полученного дампа с данными (например, в "фото", "видео", ...).
*/


USE vk2;

SELECT * FROM media_types;

-- не нашёл изящного способа обновить все данные за один запрос поэтому четыре отдельных :(

UPDATE media_types 
SET name = 'image'
WHERE id = 1;

UPDATE media_types 
SET name = 'video'
WHERE id = 2;

UPDATE media_types 
SET name = 'audio'
WHERE id = 3;

UPDATE media_types 
SET name = 'doc'
WHERE id = 4;

-- c помощью друга решение было найдено :)

UPDATE media_types SET name = CASE id WHEN 1 THEN 'doc' WHEN 2 THEN 'audio' WHEN 3 THEN 'video' WHEN 4 THEN 'image' END WHERE id IN (1,2,3,4);