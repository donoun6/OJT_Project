# 테이블 조회
SELECT * FROM Selling;
SELECT * FROM Cart;
SELECT * FROM Orders;
SELECT * FROM Receiving;
SELECT * FROM Inventory;
SELECT * FROM Product;
SELECT * FROM Category;
SELECT * FROM Admin;

# 테이블 비우기
TRUNCATE TABLE Selling;
TRUNCATE TABLE Cart;
TRUNCATE TABLE Orders;
TRUNCATE TABLE Receiving;
TRUNCATE TABLE Inventory;
TRUNCATE TABLE Product;
TRUNCATE TABLE Category;
TRUNCATE TABLE Admin;

# 테이블 삭제
DROP TABLE Selling;
DROP TABLE Cart;
DROP TABLE Orders;
DROP TABLE Receiving;
DROP TABLE Inventory;
DROP TABLE Product;
DROP TABLE Category;
DROP TABLE Admin;


# 테이블 생성
CREATE TABLE Admin (
admin_id            INT                     PRIMARY KEY AUTO_INCREMENT,
password            VARCHAR(20)             NOT NULL
)AUTO_INCREMENT = 1;

CREATE TABLE Category (
category_id         INT                     PRIMARY KEY AUTO_INCREMENT,
name                VARCHAR(10)             NOT NULL,
check_category      BOOLEAN                 NOT NULL DEFAULT TRUE,
register_date       TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT = 1;

CREATE TABLE Product (
product_id          INT                     PRIMARY KEY AUTO_INCREMENT,
category_id         INT                     NOT NULL,
name                VARCHAR(20)             NOT NULL,
code                VARCHAR(20)             NOT NULL,
sell_price          INT                     NOT NULL,
image               VARCHAR(30)             NOT NULL,
check_product       BOOLEAN                 NOT NULL DEFAULT TRUE,
register_date       TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT Product_category_id_FK FOREIGN KEY (category_id) REFERENCES Category(category_id)
)AUTO_INCREMENT = 1;

CREATE TABLE Inventory (
inventory_id            INT                 PRIMARY KEY AUTO_INCREMENT,
product_id              INT                 NOT NULL,
quantity                INT                 NOT NULL,
register_date           TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT Inventory_product_id_FK FOREIGN KEY (product_id) REFERENCES Product(product_id)
)AUTO_INCREMENT = 1;

CREATE TABLE Receiving (
receiving_id            INT                 PRIMARY KEY AUTO_INCREMENT,
product_id              INT                 NOT NULL,
quantity                INT                 NOT NULL,
description             VARCHAR(100)        NULL,
check_receiving         BOOLEAN             NOT NULL DEFAULT TRUE,
register_date           TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT Receiving_product_id_FK FOREIGN KEY (product_id) REFERENCES Product(product_id)
)AUTO_INCREMENT = 1000;

CREATE TABLE Cart (
Cart_id                 INT                 PRIMARY KEY AUTO_INCREMENT,
product_id              INT                 NOT NULL,
quantity                INT                 NOT NULL,
total_price             INT                 NOT NULL,
CONSTRAINT Cart_product_id_FK FOREIGN KEY (product_id) REFERENCES Product(product_id)
)AUTO_INCREMENT = 1;

CREATE TABLE Orders (
orders_id               INT                 PRIMARY KEY AUTO_INCREMENT,
check_orders            BOOLEAN             NOT NULL DEFAULT TRUE,
register_date           TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP
)AUTO_INCREMENT = 43102;

CREATE TABLE Selling (
selling_id              INT                 PRIMARY KEY AUTO_INCREMENT,
product_id              INT                 NOT NULL,
orders_id               INT                 NOT NULL,
quantity                INT                 NOT NULL,
total_price             INT                 NOT NULL,
check_selling           BOOLEAN             NOT NULL DEFAULT TRUE,
register_date           TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT Selling_product_id_FK FOREIGN KEY (product_id) REFERENCES Product(product_id),
CONSTRAINT Selling_orders_id_FK FOREIGN KEY (orders_id) REFERENCES Orders(orders_id)
)AUTO_INCREMENT = 1;

# 테이블 수정
ALTER TABLE Cart ADD product_name VARCHAR(20) NOT NULL;
ALTER TABLE Cart ADD image VARCHAR(20);

select * from Inventory;
SELECT * FROM ORDERS;
SELECT * FROM Orders WHERE check_orders = '1';
select * from product;

SELECT
    product_id AS '상품번호',
    name AS '상품이름',
    CASE
        WHEN check_product = 1 THEN '수량있음'
        ELSE '품절'
        END AS '재고상태'
FROM
    Product;


select product_id as '상품 이름', quantity as '남은수량' from Inventory;

SELECT
    orders_id AS '주문번호',
    CASE
        WHEN check_orders = 1 THEN '환불 안했습니다'
        ELSE '환불 완료'
        END AS '환불상황'
FROM
    Orders;

select * from selling;
select orders_id as '주문번호', quantity as '잔여수량', check_selling as '환불상황' from Selling;

SELECT
    orders_id AS '주문번호',
    quantity AS '잔여수량',
    CASE
        WHEN check_selling = 1 THEN '수량 있습니다.'
        ELSE '수량 없습니다.'
        END AS '재고상태'
FROM
    Selling;