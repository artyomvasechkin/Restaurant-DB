DROP SCHEMA restaurant CASCADE;
CREATE SCHEMA restaurant;

CREATE TABLE restaurant.Workers (
  Worker_ID   INT PRIMARY KEY,
  Salary_amt NUMERIC(10, 2)
      CHECK (
          Salary_amt >= 0 ),
  Position_value TEXT,
  Shifts_worked_amt NUMERIC(10, 1)
      CHECK (
          Shifts_worked_amt >= 0 ),
  Works_now_flg BOOL
);

CREATE TABLE restaurant.Individual_properties (
  ID  INT PRIMARY KEY,
  Worker_ID INT REFERENCES restaurant.Workers,
  Worker_nm TEXT,
  Passport_no VARCHAR(4)
      CHECK (
          length(Passport_no) = 4) NOT NULL,
  Passport_series VARCHAR(6)
      CHECK (
          length(Passport_series) = 6 ) NOT NULL,
  Credit_card_no TEXT,
  Contract_no TEXT
);

CREATE TABLE restaurant.Sales (
    Sale_ID INT PRIMARY KEY,
    Worker_ID INT REFERENCES restaurant.Workers,
    Cost_amt NUMERIC(10, 2)
        CHECK (
            Cost_amt >= 0 ),
    Sales_dttm timestamp
);

CREATE TABLE restaurant.Providers (
  Provider_ID   INT PRIMARY KEY,
  Contract_expiry_dt DATE
);

CREATE TABLE restaurant.Entity_properties (
  ID  INT PRIMARY KEY,
  Provider_ID INT REFERENCES restaurant.Providers,
  Entity_nm TEXT,
  License_no TEXT,
  Account_code TEXT,
  Contract_no TEXT
);

CREATE TABLE restaurant.Products (
  Product_ID  INT PRIMARY KEY,
  Provider_ID INT REFERENCES restaurant.Providers
);

CREATE TABLE restaurant.Products_info (
  Product_ID INT REFERENCES restaurant.Products,
  Product_name TEXT NOT NULL,
  Price_rate NUMERIC(10, 2)
      CHECK (
          Price_rate >= 0 ),
  Left_amt FLOAT,
  Units_desc TEXT,
  Valid_from_dt DATE NOT NULL,
  Valid_to_dt DATE
);

CREATE TABLE restaurant.Goods (
  Good_ID   INT PRIMARY KEY,
  Price_rate NUMERIC(10, 2)
      CHECK (
          Price_rate > 0 ),
  Good_name TEXT NOT NULL,
  Sold_cnt INT
);

CREATE TABLE restaurant.Goods_info (
  Good_ID   INT REFERENCES restaurant.Goods,
  Price_rate NUMERIC(10, 2)
      CHECK (
          Price_rate > 0 ),
  Good_name text NOT NULL,
  Sold_cnt INT,
  Valid_from_dt DATE NOT NULL,
  Valid_to_dt DATE
);

CREATE TABLE restaurant.Sales_Goods (
    Sale_ID INT REFERENCES restaurant.Sales,
    Good_ID INT REFERENCES restaurant.Goods
);

CREATE TABLE restaurant.Products_Goods (
    Good_ID INT REFERENCES restaurant.Goods,
    Product_ID INT REFERENCES restaurant.Products
);



INSERT INTO restaurant.Workers VALUES (1, 50000.0, 'Manager', 100, true);
INSERT INTO restaurant.Workers VALUES (2, 50000.0, 'Manager', 50, true);
INSERT INTO restaurant.Workers VALUES (3, 30000.0, 'Cashier', 40, true);
INSERT INTO restaurant.Workers VALUES (4, 30000.0, 'Cashier', 30, true);
INSERT INTO restaurant.Workers VALUES (5, 30000.0, 'Cashier', 40, true);
INSERT INTO restaurant.Workers VALUES (6, 0, 'Cashier', 10, false);
INSERT INTO restaurant.Workers VALUES (7, 15000.0, 'Cleaner', 20, true);
INSERT INTO restaurant.Workers VALUES (8, 0, 'Cleaner', 0, false);

INSERT INTO restaurant.Individual_properties VALUES (1, 1, 'Katya', '6381', '783372', '9876 8987 6758 3212', 'A5BV90');
INSERT INTO restaurant.Individual_properties VALUES (2, 2, 'Michael', '4513', '745477', '9876 9087 6758 3212', 'H04ED1');
INSERT INTO restaurant.Individual_properties VALUES (3, 3, 'Dmitrij', '9835', '019344', '9876 3456 6758 3212', 'L9N432');
INSERT INTO restaurant.Individual_properties VALUES (4, 4, 'Lena', '3452', '901093', '9876 8987 1235 3212', 'CC912K');
INSERT INTO restaurant.Individual_properties VALUES (5, 5, 'Ann', '1234', '134555', '9876 8987 0786 3212', 'X5DA09');
INSERT INTO restaurant.Individual_properties VALUES (6, 6, 'Boris', '0598', '345190', '9876 8987 1237 3212', NULL);
INSERT INTO restaurant.Individual_properties VALUES (7, 7, 'Tony', '4574', '090394', '9876 8987 6756 3212', '44SP09');
INSERT INTO restaurant.Individual_properties VALUES (8, 8, 'Raul', '4332', '783444', '9876 8987 6755 3212', 'HH56IO');


INSERT INTO restaurant.Providers VALUES (1, '2022-01-01');
INSERT INTO restaurant.Providers VALUES (2, '2021-05-01');
INSERT INTO restaurant.Providers VALUES (3, '2023-06-01');
INSERT INTO restaurant.Providers VALUES (4, '2021-02-01');
INSERT INTO restaurant.Providers VALUES (5, '2030-08-01');
INSERT INTO restaurant.Providers VALUES (6, '2022-02-01');
INSERT INTO restaurant.Providers VALUES (7, '2023-06-01');
INSERT INTO restaurant.Providers VALUES (8, '2021-03-01');
INSERT INTO restaurant.Providers VALUES (9, NULL);

INSERT INTO restaurant.Entity_properties VALUES (1, 1, 'Mimishka', '11234567', '098765', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (2, 2, 'Pimenov&Sons', '10009222', '009532', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (3, 3, 'AlisherCo', '2992944', '16776', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (4, 4, 'ElkGoods', '44444444', '487684', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (5, 5, 'FrEsH!', '4302912', '1351345', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (6, 6, 'OOO NISHTYAK', '1130027', '514515', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (7, 7, 'BTV', '283923', '45145', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (8, 8, '220B', '203892', '1543515', '3485791');
INSERT INTO restaurant.Entity_properties VALUES (9, 9, 'piro', '78910093', '31451', NULL);

INSERT INTO restaurant.Products VALUES (1, 3);
INSERT INTO restaurant.Products VALUES (2, 3);
INSERT INTO restaurant.Products VALUES (3, 4);
INSERT INTO restaurant.Products VALUES (4, 8);
INSERT INTO restaurant.Products VALUES (5, 6);
INSERT INTO restaurant.Products VALUES (6, 7);
INSERT INTO restaurant.Products VALUES (7, 7);
INSERT INTO restaurant.Products VALUES (8, 6);
INSERT INTO restaurant.Products VALUES (9, 6);
INSERT INTO restaurant.Products VALUES (10, 2);
INSERT INTO restaurant.Products VALUES (11, 2);
INSERT INTO restaurant.Products VALUES (12, 5);

INSERT INTO restaurant.Products_info VALUES (1, 'Black tea', 5000.0, 10, 'kg', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (2, 'Green tea', 5000.0, 12, 'kg', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (3, 'Coffee grains', 5000.0, 5, 'kg', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (4, 'Nestle Capsules', 100.0, 1243, 'units', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (5, 'Tiramisu', 100.0, 50, 'units', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (6, 'Sugar', 50.0, 20, 'kg', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (7, 'Milk', 60.0, 18, 'l', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (8, 'Maffin', 60.0, 34, 'kg', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (9, 'Chockolate', 3000.0, 50, 'kg', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (10, 'Nut syrop', 500.0, 29, 'l', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (11, 'Caramel syrop', 500.0, 31, 'l', '2021-04-01');
INSERT INTO restaurant.Products_info VALUES (12, 'Cup', 5.0, 500, 'units', '2021-04-01');

INSERT INTO restaurant.Goods values (1, 50.0, 'Black tea with sugar', 23);
INSERT INTO restaurant.Goods values (2, 100.0, 'Caramel ruf', 6);
INSERT INTO restaurant.Goods values (3, 90.0, 'Capuccino with nut syrop', 45);
INSERT INTO restaurant.Goods values (4, 90.0, 'Caramel Moccacino', 17);
INSERT INTO restaurant.Goods values (5, 120.0, 'Tiramisu', 9);
INSERT INTO restaurant.Goods values (6, 75.0, 'Maffin', 31);
INSERT INTO restaurant.Goods values (7, 60.0, 'Hot chocolate', 67);
INSERT INTO restaurant.Goods values (8, 60.0, 'Espresso with milk', 22);

INSERT INTO restaurant.Products_Goods VALUES (1, 1);
INSERT INTO restaurant.Products_Goods VALUES (1, 6);
INSERT INTO restaurant.Products_Goods VALUES (2, 3);
INSERT INTO restaurant.Products_Goods VALUES (2, 7);
INSERT INTO restaurant.Products_Goods VALUES (2, 6);
INSERT INTO restaurant.Products_Goods VALUES (2, 11);
INSERT INTO restaurant.Products_Goods VALUES (3, 4);
INSERT INTO restaurant.Products_Goods VALUES (3, 10);
INSERT INTO restaurant.Products_Goods VALUES (4, 4);
INSERT INTO restaurant.Products_Goods VALUES (4, 7);
INSERT INTO restaurant.Products_Goods VALUES (4, 11);
INSERT INTO restaurant.Products_Goods VALUES (5, 5);
INSERT INTO restaurant.Products_Goods VALUES (6, 8);
INSERT INTO restaurant.Products_Goods VALUES (7, 9);
INSERT INTO restaurant.Products_Goods VALUES (8, 3);
INSERT INTO restaurant.Products_Goods VALUES (8, 7);
INSERT INTO restaurant.Products_Goods VALUES (1, 12);
INSERT INTO restaurant.Products_Goods VALUES (2, 12);
INSERT INTO restaurant.Products_Goods VALUES (3, 12);
INSERT INTO restaurant.Products_Goods VALUES (4, 12);
INSERT INTO restaurant.Products_Goods VALUES (7, 12);
INSERT INTO restaurant.Products_Goods VALUES (8, 12);


INSERT INTO restaurant.Sales VALUES (1, 3, 100.0, '2021-04-01 10:20');
INSERT INTO restaurant.Sales VALUES (2, 3, 90.0, '2021-04-01 10:33');
INSERT INTO restaurant.Sales VALUES (3, 3, 135.0, '2021-04-01 11:19');
INSERT INTO restaurant.Sales VALUES (4, 4, 50.0, '2021-03-31 18:57');
INSERT INTO restaurant.Sales VALUES (5, 4, 90.0, '2021-03-30 15:29');
INSERT INTO restaurant.Sales VALUES (6, 5, 90.0, '2021-03-30 17:12');
INSERT INTO restaurant.Sales VALUES (7, 5, 90.0, '2021-03-29 18:53');
INSERT INTO restaurant.Sales VALUES (8, 3, 120.0, '2021-03-29 11:44');
INSERT INTO restaurant.Sales VALUES (9, 4, 180.0, '2021-03-29 10:09');
INSERT INTO restaurant.Sales VALUES (10, 4, 90.0, '2021-03-29 10:41');
INSERT INTO restaurant.Sales VALUES (11, 4, 210.0, '2021-03-29 19:55');

INSERT INTO restaurant.Sales_Goods VALUES (1, 2);
INSERT INTO restaurant.Sales_Goods VALUES (2, 3);
INSERT INTO restaurant.Sales_Goods VALUES (3, 6);
INSERT INTO restaurant.Sales_Goods VALUES (3, 7);
INSERT INTO restaurant.Sales_Goods VALUES (4, 1);
INSERT INTO restaurant.Sales_Goods VALUES (5, 2);
INSERT INTO restaurant.Sales_Goods VALUES (6, 3);
INSERT INTO restaurant.Sales_Goods VALUES (7, 4);
INSERT INTO restaurant.Sales_Goods VALUES (8, 5);
INSERT INTO restaurant.Sales_Goods VALUES (9, 2);
INSERT INTO restaurant.Sales_Goods VALUES (9, 5);
INSERT INTO restaurant.Sales_Goods VALUES (10, 4);
INSERT INTO restaurant.Sales_Goods VALUES (11, 8);
INSERT INTO restaurant.Sales_Goods VALUES (11, 2);
INSERT INTO restaurant.Sales_Goods VALUES (11, 1);

SELECT *
    FROM restaurant.Workers;

SELECT *
    FROM restaurant.Individual_properties;

SELECT *
    FROM restaurant.Providers;

SELECT *
    FROM restaurant.Entity_properties;

SELECT *
    FROM restaurant.Products;

SELECT *
    FROM restaurant.Goods;

SELECT *
    FROM restaurant.Sales;






UPDATE restaurant.Providers
    SET contract_expiry_dt = NULL
    WHERE contract_expiry_dt < '2021-04-07';

SELECT entity_nm
    FROM restaurant.Providers
        RIGHT JOIN restaurant.entity_properties
            ON providers.provider_id = entity_properties.provider_id
    WHERE contract_expiry_dt IS NULL;

UPDATE restaurant.Products_info
    SET valid_to_dt = '2021-04-07';

INSERT INTO restaurant.Products_info VALUES (1, 'Black tea', 5000.0, 9, 'kg', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (2, 'Green tea', 5000.0, 12, 'kg', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (3, 'Coffee grains', 5000.0, 2, 'kg', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (4, 'Nestle Capsules', 100.0, 998, 'units', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (5, 'Tiramisu', 100.0, 23, 'units', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (6, 'Sugar', 50.0, 2, 'kg', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (7, 'Milk', 60.0, 5, 'l', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (8, 'Maffin', 60.0, 30, 'kg', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (9, 'Chockolate', 3000.0, 49, 'kg', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (10, 'Nut syrop', 500.0, 25, 'l', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (11, 'Caramel syrop', 500.0, 20, 'l', '2021-04-07');
INSERT INTO restaurant.Products_info VALUES (12, 'Cup', 5.0,  30, 'units', '2021-04-07');


INSERT INTO restaurant.Sales VALUES (12, 4, 100.0, '2021-04-05 10:28');
INSERT INTO restaurant.Sales VALUES (13, 5, 90.0, '2021-04-03 10:39');
INSERT INTO restaurant.Sales VALUES (14, 5, 260.0, '2021-04-04 11:17');
INSERT INTO restaurant.Sales VALUES (15, 3, 90.0, '2021-04-06 18:50');
INSERT INTO restaurant.Sales VALUES (16, 4, 90.0, '2021-04-07 15:20');
INSERT INTO restaurant.Sales VALUES (17, 5, 90.0, '2021-04-06 17:19');
INSERT INTO restaurant.Sales VALUES (18, 3, 90.0, '2021-04-06 18:53');
INSERT INTO restaurant.Sales VALUES (19, 4, 135.0, '2021-04-05 11:46');
INSERT INTO restaurant.Sales VALUES (20, 4, 60.0, '2021-04-02 10:01');
INSERT INTO restaurant.Sales VALUES (21, 5, 60.0, '2021-04-03 10:49');
INSERT INTO restaurant.Sales VALUES (22, 3, 75.0, '2021-04-03 19:58');

INSERT INTO restaurant.Sales_Goods VALUES (12, 1);
INSERT INTO restaurant.Sales_Goods VALUES (12, 1);
INSERT INTO restaurant.Sales_Goods VALUES (13, 4);
INSERT INTO restaurant.Sales_Goods VALUES (14, 5);
INSERT INTO restaurant.Sales_Goods VALUES (14, 3);
INSERT INTO restaurant.Sales_Goods VALUES (14, 4);
INSERT INTO restaurant.Sales_Goods VALUES (15, 3);
INSERT INTO restaurant.Sales_Goods VALUES (16, 4);
INSERT INTO restaurant.Sales_Goods VALUES (17, 3);
INSERT INTO restaurant.Sales_Goods VALUES (18, 3);
INSERT INTO restaurant.Sales_Goods VALUES (19, 6);
INSERT INTO restaurant.Sales_Goods VALUES (19, 7);
INSERT INTO restaurant.Sales_Goods VALUES (20, 7);
INSERT INTO restaurant.Sales_Goods VALUES (21, 8);
INSERT INTO restaurant.Sales_Goods VALUES (22, 6);

DELETE
    FROM restaurant.Sales_Goods
    WHERE sale_ID = 22;

DELETE
    FROM restaurant.Sales
    WHERE sale_id = 22;

SELECT *
    FROM restaurant.Products_info
    WHERE ((left_amt < 10
                AND units_desc = 'kg')
               OR (left_amt < 50
                       AND units_desc = 'units')
                      AND valid_to_dt ISNULL);





--1) вывести суммарную прибыль, принесенную каждым продавцом
SELECT worker_id, SUM(cost_amt)
    FROM restaurant.Sales
    GROUP BY worker_id
    ORDER BY SUM(cost_amt) DESC;

--2) вывести среднюю цену за товары, которых было продано меньше/больше 10 штук, но которые при этом продавались
SELECT AVG(price_rate)
    FROM restaurant.Goods_info
    GROUP BY sold_cnt < 10
    HAVING sold_cnt > 0;

--3) вывести сколько мы платим каждому типу работников
SELECT DISTINCT position_value, SUM(salary_amt) OVER (PARTITION BY position_value)
    FROM restaurant.Workers
    WHERE works_now_flg;

--4) вывести сумму чека в бд, сумму чека, какой она должна быть и id работника, ответственного за чек
SELECT Sales.cost_amt, Sales.worker_id, SUM(Goods.price_rate)
    OVER (
        PARTITION BY Sales.sale_id
        ORDER BY Sales.sales_dttm)
    FROM restaurant.Sales
        LEFT JOIN  restaurant.Sales_Goods
            ON Sales.sale_id = Sales_Goods.sale_id
        LEFT JOIN restaurant.Goods
            ON Goods.good_id = Sales_Goods.good_id;

--5) разобьем товары на группы по цене за unit
SELECT products_info.product_name, products_info.price_rate, DENSE_RANK()
    OVER (
        ORDER BY price_rate)
    FROM restaurant.Products
        LEFT JOIN restaurant.products_info
            ON Products.product_id = products_info.product_id
    WHERE products_info.valid_to_dt IS NULL;

--6) для чека каждого работника выведем дату и время предыдущего и следующего чека
SELECT *, LAG(sales_dttm, 1, NULL)
    OVER (
        PARTITION BY worker_id
        ORDER BY sales_dttm),
       LEAD(sales_dttm, 1, NULL)
           OVER (
               PARTITION BY worker_id
               ORDER BY sales_dttm)
    FROM restaurant.Sales;



-- индексы по Individual_properties, Goods_info, Entity_properties, Products_info потому что эти таблицы самые большие и по **_ID, так как это везде первичный ключ
CREATE INDEX ON restaurant.Individual_properties((Individual_properties.worker_ID));

CREATE INDEX ON restaurant.Goods_info((Goods_info.good_ID));

CREATE INDEX ON restaurant.Entity_properties((Entity_properties.ID));

CREATE INDEX ON restaurant.Products_info((Products_info.Product_ID));



-- персональные данные работников со скрытыми паспортными данными и номером кредитки
CREATE OR REPLACE VIEW ind_personal_data AS
    SELECT worker_id, worker_nm,
           coalesce(substring(passport_no, 0, 2), '') || '**' || coalesce(substring(passport_no, 4, 5), '') AS passport_no,
           coalesce(substring(passport_series, 0, 2), '') || '***' || coalesce(substring(passport_series, 5, 6), '') AS passport_series,
           coalesce(substring(credit_card_no, 0, 5), '') || ' **** ****' || coalesce(substring(credit_card_no, 15, 19), '') AS credit_card, Contract_no
    FROM restaurant.Individual_properties;


-- персональные данные поставщиков со скрытыми номром лицензии и номером счета
CREATE OR REPLACE VIEW ent_personal_data AS
    SELECT provider_id, entity_nm,
           coalesce(substring(license_no, 0, 2), '') || '****' || coalesce(substring(license_no, length(license_no) - 2, length(license_no)), '') AS license_no,
           coalesce(substring(account_code, 0, 2), '') || '*****' || coalesce(substring(account_code, length(account_code) - 2, length(account_code)), '') AS account_code,  contract_no
        FROM restaurant.entity_properties;


-- сводная таблица товаров и продуктов, из которых они состоят
CREATE OR REPLACE VIEW consistency_of_goods AS
    SELECT good_name, goods.price_rate AS good_price, p.Product_name, p.price_rate AS product_price
        FROM restaurant.goods
            LEFT JOIN restaurant.Products_Goods pxg
                ON goods.good_id = pxg.good_id
            LEFT JOIN restaurant.products_info p
                ON p.product_id = pxg.product_id
    WHERE p.valid_to_dt IS NULL
    ORDER BY good_name;


-- сводная таблица продаж и товаров, которые были проданы
CREATE OR REPLACE VIEW consistency_of_sales AS
    SELECT sales.sale_id, cost_amt, good_name, price_rate, sales_dttm
        FROM restaurant.sales
            LEFT JOIN restaurant.Sales_Goods sxg
                ON sales.sale_id = sxg.sale_id
            LEFT JOIN restaurant.goods g
                ON g.good_id = sxg.good_id
        ORDER BY sale_id;


-- сводная таблица работников и их продаж
CREATE OR REPLACE VIEW workers_sales AS
    SELECT workers.worker_id, position_value, worker_nm, s.sale_id, cost_amt
        FROM restaurant.workers
            RIGHT JOIN restaurant.sales s
                ON workers.worker_id = s.worker_id
            LEFT JOIN restaurant.Individual_properties ip
                ON workers.worker_id = ip.worker_id
        ORDER BY worker_nm;


-- поставщики, у которых скоро придется заказывать товары
CREATE OR REPLACE VIEW actual_providers AS
    SELECT entity_nm, product_name, price_rate, left_amt, units_desc
        FROM restaurant.Products
            LEFT JOIN restaurant.products_info pi
                ON Products.product_id = pi.product_id
            LEFT JOIN restaurant.Entity_properties Ep
                ON Products.provider_id = Ep.Provider_ID
        WHERE left_amt < 10
          AND valid_to_dt IS NULL;




CREATE OR REPLACE FUNCTION check_goods_update() RETURNS TRIGGER
 AS $$
    BEGIN
        UPDATE restaurant.goods_info SET valid_to_dt = substring(now()::text, 0, 11)::DATE
            WHERE good_id = NEW.good_id AND valid_to_dt isnull;
        INSERT INTO restaurant.goods_info VALUES (new.good_id, new.price_rate, new.good_name, new.sold_cnt, substring(now()::text, 0, 11)::date);
        RETURN new;
    END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_products_update() RETURNS TRIGGER
 AS $$
    BEGIN
        update restaurant.products_info SET valid_to_dt = substring(now()::text, 0, 11)::DATE
            WHERE product_id = NEW.product_id AND valid_to_dt isnull;
        INSERT INTO restaurant.products_info VALUES (new.product_id, new.price_rate, new.left_amt, new.units_desc, substring(now()::text, 0, 11)::date);
        RETURN new;
    END
$$ LANGUAGE plpgsql;





CREATE TRIGGER log_goods AFTER UPDATE ON restaurant.goods
    FOR EACH ROW
        EXECUTE FUNCTION check_goods_update();

CREATE TRIGGER log_products AFTER UPDATE ON restaurant.products_info
    FOR EACH ROW
        EXECUTE function check_products_update();