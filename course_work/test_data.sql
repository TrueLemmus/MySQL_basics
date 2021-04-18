USE shop_sample;

INSERT INTO customers (name, email, birthday_at) VALUES
  ('Геннадий', '1@mail.ru', '1990-10-05'),
  ('Наталья', '2@mail.ru', '1984-11-12'),
  ('Александр', '3@mail.ru', '1985-05-20'),
  ('Сергей', '4@mail.ru', '1988-02-14'),
  ('Иван', '5@mail.ru', '1998-01-12'),
  ('Мария', '6@mail.ru', '1992-08-29');

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
 INSERT INTO products (name, description, price, catalog_id) VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2),
  ('Gigabyte B450M S2H rev. 1.0', 'Доступная и компактная материнская плата формата microATX', 5150.00, 2);
 
INSERT INTO `attributes` VALUES
	(DEFAULT, 'Частота', '3,5Ghz'),
	(DEFAULT, 'Частота', '3,8Ghz'),
	(DEFAULT, 'Частота', '3,3Ghz'),
	(DEFAULT, 'Сокет', '1151-v2'),
	(DEFAULT, 'Сокет', 'AM4'),
	(DEFAULT, 'RAM', 'DDR4'),
	(DEFAULT, 'RAM', 'DDR3');

INSERT INTO product_attributes VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 3),
	(5, 4),
	(6, 4),
	(7, 4),
	(8, 5),
	(1, 4),
	(2, 4),
	(3, 5),
	(4, 5);

INSERT INTO storehouses (storehouse_name) VALUES
	('Склад 1'), ('Склад 2'), ('Склад 3');
 
INSERT INTO orders (customer_id) VALUES
  (1), (2), (2), (3), (3), (3), (4), (5), (6), (6);
 
INSERT INTO orders_products (order_id, product_id, total) VALUES 
	(1, 1, 1),
	(1, 3, 2),
	(1, 7, 1),
	(2, 2, 2),
	(2, 6, 1),
	(3, 1, 4),
	(3, 5, 1),
	(3, 4, 2),
	(3, 6, 1),
	(4, 2, 1),
	(4, 7, 2),
	(5, 6, 3),
	(5, 7, 1),
	(6, 2, 4),
	(6, 3, 1),
	(6, 6, 2),
	(6, 7, 1),
	(6, 5, 1),
	(7, 2, 2),
	(7, 3, 1),
	(7, 4, 3),
    (8, 3, 1),
    (9, 4, 4),
    (9, 6, 3),
    (9, 7, 3),
    (10, 1, 1),
    (10, 8, 1);
    
  INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
	(1, 1, 5),
	(1, 2, 4),
	(1, 6, 6),
	(2, 3, 4),
	(2, 7, 6),
	(3, 4, 3),
	(3, 5, 2),
    (3, 8, 1);

   
INSERT INTO comments (product_id, customer_id, order_id, rating, comment) VALUES
   	(4, 1, 1, 100, 'FX топ!!!'),
   	(4, 2, 3, 80, 'Норм работает'),
   	(4, 4, 7, 20, 'Intel лучше'),
   	(7, 1, 1, 0, 'Не подходит под FX :(');
   

   
    