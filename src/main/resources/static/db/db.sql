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
register_date           TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT Receiving_product_id_FK FOREIGN KEY (product_id) REFERENCES Product(product_id)
)AUTO_INCREMENT = 1;

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
)AUTO_INCREMENT = 1;

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

# Trigger

# 아이템 판매시 재고처리
CREATE TRIGGER SellingAndCountInventory AFTER INSERT ON Selling
    FOR EACH ROW
BEGIN
    DECLARE var_quantity INT;
    DECLARE var_product_id INT;

    -- 커서 대신 각 행에 대한 트리거를 사용
    SET var_quantity = NEW.quantity;
    SET var_product_id = NEW.product_id;

    -- 재고 업데이트
    UPDATE Inventory SET quantity = quantity - var_quantity
    WHERE product_id = var_product_id;
END;

# 아이템 입고시 재고처리
CREATE TRIGGER ReceivingAndCountInventory AFTER INSERT ON Receiving
    FOR EACH ROW
BEGIN
    DECLARE var_quantity INT;
    DECLARE var_product_id INT;

    -- 커서를 사용하지 않고 직접 INSERTED 테이블의 데이터에 접근
    SET var_quantity = NEW.quantity;
    SET var_product_id = NEW.product_id;

    -- 재고 업데이트
    UPDATE Inventory SET quantity = quantity + var_quantity
    WHERE product_id = var_product_id;
END;



