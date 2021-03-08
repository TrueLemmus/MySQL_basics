/* Практическое задание №2. */

/* Задание 2.
 * Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
*/
-- создание базы данных
create database exemple;
-- выбор базы поумолчанию
use exemple;
-- создание таблицы
create table users (id int, name VARCHAR(255));
-- добовление строки в таблицу
insert into users values (1, 'Vasya');
-- выбор значения
select id, name from users;