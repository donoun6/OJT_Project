#초기화 데이터 그냥 ctrl + a 해서 실행하면 됩니다. 현재는 제작중 data.sql파일 맨 밑에 입력 프로시저 있습니다. 그거 활성화

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

# 카테고리 등록
INSERT INTO Category (name)
VALUES ('음료/커피'),('스낵'),('라면/가공식품'),('빵/디저트'),('도시락/김밥'),
       ('샌드위치/햄버거'),('젤리/캔디/껌'),('아이스크림'),('생활용품');

# 물품 등록
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'롯데)칠성사이다P500ml',2500,'/img/am.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'롯데)칠성사이다캔250ml',3000,'/img/bla.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'코카)코카콜라P500ml',2500,'/img/bs.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'코카)코카콜라캔250ml',2000,'/img/ca.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'동아)데미소다애플캔250ml',3000,'/img/cf.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (2,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'초코케이크',6000,'/img/ck.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'치즈케이크',6000,'/img/ck2.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'소금빵',3000,'/img/ck3.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'마들렌',1500,'/img/ck4.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'쿠키',1000,'/img/cl.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'바나나주스',5000,'/img/cm.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'사과주스',5000,'/img/cmm.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'콜라',1500,'/img/gk.png');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'사이다',1500,'/img/hb.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),  concat(lpad(FLOOR(RAND()*1000),'4','0'),concat('-' ,lpad(FLOOR(RAND()*1000),'4','0'))))
       ,'박카스',1000,'/img/it.jpg');
do sleep(1);

# 재고 수량 등록
INSERT INTO Inventory (product_id, quantity)
VALUES (1,200);
INSERT INTO Inventory (product_id, quantity)
VALUES (2, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (3, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (4, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (5, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (6, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (7, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (8, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (9, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES(10, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (11, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (12, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (13, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (14, 200);
INSERT INTO Inventory (product_id, quantity)
VALUES (15, 200);

#입고 등록
INSERT INTO Receiving (product_id, quantity, description)
VALUES (1,50,'50개 입고');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (2,2,'소량 입고');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (1,8,'');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (9,12,'');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (15,82,'입고');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (12,2,'');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (12,5,'추가 입고');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (6,3,'');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (11,15,'');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (1, 50, '50개 입고');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (4, 2, '');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (8, 30, '추가입고');
do sleep(1);
INSERT INTO Receiving (product_id, quantity, description)
VALUES (7, 30, '추가입고');
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(4);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(4);
CALL AddOrCountCart(2);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(6);
CALL AddOrCountCart(6);
CALL AddOrCountCart(2);
CALL AddOrCountCart(3);
CALL AddOrCountCart(14);
CALL AddOrCountCart(12);
CALL AddOrCountCart(12);
CALL AddOrCountCart(10);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(15);
CALL AddOrCountCart(15);
CALL AddOrCountCart(15);
CALL AddOrCountCart(15);
CALL AddOrCountCart(15);
CALL AddOrCountCart(5);
CALL AddOrCountCart(4);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
CALL AddOrCountCart(8);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(5);
CALL AddOrCountCart(5);
CALL AddOrCountCart(5);
CALL AddOrCountCart(4);
CALL AddOrCountCart(4);
CALL AddOrCountCart(11);
CALL AddOrCountCart(11);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(4);
CALL AddOrCountCart(4);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(8);
CALL AddOrCountCart(9);
CALL AddOrCountCart(10);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(15);
CALL AddOrCountCart(15);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(13);
CALL AddOrCountCart(13);
CALL AddOrCountCart(12);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(1);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(1);
CALL AddOrCountCart(5);
CALL AddOrCountCart(15);
CALL AddOrCountCart(5);
CALL AddOrCountCart(12);
CALL AddOrCountCart(12);
CALL AddOrCountCart(2);
CALL AddOrCountCart(14);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(13);
CALL AddOrCountCart(13);
CALL AddOrCountCart(13);
CALL AddOrCountCart(13);
CALL AddOrCountCart(12);
CALL AddOrCountCart(2);
CALL AddOrCountCart(12);
CALL AddOrCountCart(6);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(6);
CALL AddOrCountCart(6);
CALL AddOrCountCart(6);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(3);
CALL AddOrCountCart(4);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(9);
CALL AddOrCountCart(9);
CALL AddOrCountCart(9);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(4);
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
call AddSellingAndClearCartTest(0);