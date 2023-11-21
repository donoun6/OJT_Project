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
CREATE TABLE Admin
(
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(20) NOT NULL
) AUTO_INCREMENT = 1;

CREATE TABLE Category
(
    category_id    INT PRIMARY KEY AUTO_INCREMENT,
    name           VARCHAR(10) NOT NULL,
    check_category BOOLEAN     NOT NULL DEFAULT TRUE,
    register_date  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
) AUTO_INCREMENT = 1;

CREATE TABLE Product
(
    product_id    INT PRIMARY KEY AUTO_INCREMENT,
    category_id   INT         NOT NULL,
    name          VARCHAR(20) NOT NULL,
    code          VARCHAR(20) NOT NULL,
    sell_price    INT         NOT NULL,
    image         VARCHAR(50) NOT NULL,
    check_product BOOLEAN     NOT NULL DEFAULT TRUE,
    register_date TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Product_category_id_FK FOREIGN KEY (category_id) REFERENCES Category (category_id)
) AUTO_INCREMENT = 1;

CREATE TABLE Inventory
(
    inventory_id  INT PRIMARY KEY AUTO_INCREMENT,
    product_id    INT       NOT NULL,
    quantity      INT       NOT NULL,
    register_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Inventory_product_id_FK FOREIGN KEY (product_id) REFERENCES Product (product_id)
) AUTO_INCREMENT = 1;

CREATE TABLE Receiving
(
    receiving_id    INT PRIMARY KEY AUTO_INCREMENT,
    product_id      INT          NOT NULL,
    quantity        INT          NOT NULL,
    description     VARCHAR(100) NULL,
    check_receiving BOOLEAN      NOT NULL DEFAULT TRUE,
    register_date   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Receiving_product_id_FK FOREIGN KEY (product_id) REFERENCES Product (product_id)
) AUTO_INCREMENT = 1000;

CREATE TABLE Cart
(
    Cart_id     INT PRIMARY KEY AUTO_INCREMENT,
    product_id  INT NOT NULL,
    quantity    INT NOT NULL,
    total_price INT NOT NULL,
    CONSTRAINT Cart_product_id_FK FOREIGN KEY (product_id) REFERENCES Product (product_id)
) AUTO_INCREMENT = 1;

CREATE TABLE Orders
(
    orders_id     INT PRIMARY KEY AUTO_INCREMENT,
    check_orders  BOOLEAN   NOT NULL DEFAULT TRUE,
    register_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) AUTO_INCREMENT = 43102;

CREATE TABLE Selling
(
    selling_id    INT PRIMARY KEY AUTO_INCREMENT,
    product_id    INT       NOT NULL,
    orders_id     INT       NOT NULL,
    quantity      INT       NOT NULL,
    total_price   INT       NOT NULL,
    check_selling BOOLEAN   NOT NULL DEFAULT TRUE,
    register_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Selling_product_id_FK FOREIGN KEY (product_id) REFERENCES Product (product_id),
    CONSTRAINT Selling_orders_id_FK FOREIGN KEY (orders_id) REFERENCES Orders (orders_id)
) AUTO_INCREMENT = 1;

# 테이블 수정
ALTER TABLE Cart
    ADD product_name VARCHAR(20) NOT NULL;
ALTER TABLE Cart
    ADD image VARCHAR(50);

# 카테고리 등록
INSERT INTO Category (name)
VALUES ('음료/커피'),
       ('스낵'),
       ('라면/가공식품'),
       ('도시락/김밥'),
       ('빵/디저트'),
       ('샌드위치/햄버거'),
       ('젤리/캔디/껌'),
       ('아이스크림');

# 물품 등록
# 음료
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '코카)코카콜라P500ml', 2500, '/img/5ED4673A0D7C47689870677C71FAB0ED.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '코카)코카콜라뚱캔', 3000, '/img/B082A4D4F55B481E95A9303CAECAA935.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '코카)코카콜라캔250ml', 2500, '/img/8801094013004.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '펩시)펩시P500ml', 2000, '/img/27B6C6F57E2A41F0A14E29A53D20A3F6.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '펩시)펩시뚱캔', 3000, '/img/8801056150013.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '펩시)펩시캔250ml', 6000, '/img/8801056610012.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)포카리스웨트P500ml', 6000, '/img/8801097250079.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)포카리스웨트캔250ml', 3000, '/img/8801097150010.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)박카스F', 1500, '/img/8806011615408.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)오로나민C', 1500, '/img/EB25B5B9D10D4E6C93F04924E536D0EA.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)데미소다', 1000, '/img/8801097160064.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '핫식스', 5000, '/img/8801056038861.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '레드불', 5000, '/img/9002490100070.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '레쓰비', 1500, '/img/8801056018979.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '조지아맥스', 1500, '/img/8801094523206.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '조지아라떼', 1000, '/img/8801094513009.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 1, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '조지아오리지날', 1000, '/img/8801094503000.jpg');
do sleep(1);

# 스낵
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)포카칩오리지날', 2500, '/img/8801117760106.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)포카칩오리지날대용량', 3000, '/img/8801117760205.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)포카칩어니언', 2500, '/img/8801117760304.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)포카칩어니언대용량', 2000, '/img/8801117760403.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)스윙칩', 3000, '/img/8801117775001.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)새우깡', 6000, '/img/8801043035989.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)새우깡매운맛', 6000, '/img/8801043036078.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)꼬깔콘', 3000, '/img/8801062011315.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)치토스', 1500, '/img/8801062383436.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)허니버터칩', 1000, '/img/8801019606557.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)맛동산', 5000, '/img/8801019608766.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)오예스', 5000, '/img/8801019313219.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '크라운)쿠크다스', 1500, '/img/8801111186117.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)카스타드', 1500, '/img/8801117948511.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 2, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '오리온)초코파이', 1000, '/img/8801117534912.jpg');
do sleep(1);

# 라면/가공식품
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)신라면', 2500, '/img/8801043015981.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)신라면작은컵', 3000, '/img/D180E0ECA21F41D09AD5D9EBCFFA94DD.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)신라면블랙', 1000, '/img/8801043041447.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)김치큰사발면', 2500, '/img/8801043015929.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)김치사발면', 2000, '/img/8801043015639.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)육개장큰사발면', 3000, '/img/8801043016025.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)육개장사발면', 6000, '/img/8801043015653.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)짜파게티', 6000, '/img/8801043016049.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)오징어짬뽕', 3000, '/img/8801043016117.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)너구리', 1500, '/img/8801043017602.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '농심)불닭볶음면', 5000, '/img/8801073210363.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼양)삼양라면', 5000, '/img/8801073112278.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '팔도)왕뚜껑', 1500, '/img/8801128503211.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '핫도그', 1500, '/img/8805489001874.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '핫도그2', 1000, '/img/8805489001102.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '핫도그3', 1000, '/img/8805489001607.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 3, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '비엔나소시지', 1000, '/img/8801123309481.jpg');
do sleep(1);


# 도시락/김밥
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '매콤불고기반상', 2500, '/img/8809196618172.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '제육불고기정식', 2500, '/img/8809196618134.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '부대볶음정식', 1000, '/img/8809948341495.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '묵은지삼겹주먹밥', 2500, '/img/8809948342041.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '간장버터치즈주먹밥', 2000, '/img/8809948342089.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '제육불고기', 3000, '/img/8809948343154.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '비빔밥한줄', 6000, '/img/8809948343192.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '고추참치3XL', 6000, '/img/8809948343338.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 4, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '간장직화불고기2XL', 3000, '/img/8809948343413.jpg');
do sleep(1);


# 빵/디저트
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '405빵', 2500, '/img/8809895798380.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '생크림빵', 2500, '/img/8801753111614.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)쌀슈크림빵', 2500, '/img/8801062859559.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)단팥생크림', 1000, '/img/8801062859566.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼립)고추장제육볶음호빵', 2500, '/img/8801068919820.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼립)갈릭페퍼치킨호빵', 2000, '/img/8801068919837.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼립)꿀먹은고구마쿠키', 3000, '/img/8801068920130.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼립)밤생크림찹쌀떡', 6000, '/img/8801121287743.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '매일)치즈케이크', 6000, '/img/8809844301043.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '매일)초코케이크', 3000, '/img/8809844301050.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 5, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '매일)소금롤케이크', 1500, '/img/8809844301111.jpg');
do sleep(1);


# 샌드위치/햄버거
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼립)한돈애쉬포테이토', 2500, '/img/8801068918731.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '삼립)훈제목살버거', 2500, '/img/8801068917055.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '국민불고기버거', 1000, '/img/8801771028451.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '고추듬뿍유린기버거', 2500, '/img/8809453267952.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '불불버거', 2000, '/img/8809948342447.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '탑티어통닭다리살버거', 3000, '/img/8809383958050.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '치즈함박버거', 6000, '/img/8801771029403.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '반미샌드위치', 6000, '/img/8809453267839.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '치킨데리야끼', 3000, '/img/8809895798922.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 6, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '디럭스통밀햄', 3000, '/img/8809895798809.jpg');
do sleep(1);

# 젤리/캔디/껌
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)박카스젤리신맛', 2500, '/img/8806011435679.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '동아)박카스젤리', 2500, '/img/8806011435631.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '츄파츕스', 1000, '/img/8410031920093.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)해태온단', 2500, '/img/1798B6BD6E764483A87D8E036ECC8BD2.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '멘토스', 2000, '/img/6921211104292.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '호올스', 3000, '/img/6924513900098.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '아폴로', 6000, '/img/6943545500014.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '크라운)마이쮸', 6000, '/img/8801111187879.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '크라운)새콤달콤복숭아', 6000, '/img/8801111188036.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 7, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '크라운)새콤달콤레몬', 6000, '/img/8801111907934.jpg');
do sleep(1);

# 아이스크림
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)수박바', 2500, '/img/8801062417117.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)비비빅', 2500, '/img/8801104123181.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)스크류바', 2500, '/img/8801062417018.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)죠스바', 1000, '/img/8801062417056.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)누가바', 2500, '/img/8809713220123.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)바밤바', 2000, '/img/8809713220055.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '해태)쌍쌍바', 3000, '/img/8809713220031.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '빙그레)메로나', 6000, '/img/8801104123280.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '빙그레)더위사냥', 6000, '/img/8801104111553.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '빙그레)구구콘', 6000, '/img/8801118250606.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)월드콘', 6000, '/img/8801062623471.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '더블비얀코', 6000, '/img/8801062623488.jpg');
do sleep(1);
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES ( 8, CONCAT(CONCAT(CHAR(ASCII('A') + FLOOR(RAND() * 26)), '-'),
                   concat(lpad(FLOOR(RAND() * 1000), '4', '0'), concat('-', lpad(FLOOR(RAND() * 1000), '4', '0'))))
       , '롯데)와', 6000, '/img/8801062435951.jpg');
do sleep(1);

# 재고 수량 등록
INSERT INTO Inventory (product_id, quantity)
VALUES (1, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (2, 80);
INSERT INTO Inventory (product_id, quantity)
VALUES (3, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (4, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (5, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (6, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (7, 80);
INSERT INTO Inventory (product_id, quantity)
VALUES (8, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (9, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (10, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (11, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (12, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (13, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (14, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (15, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (16, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (17, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (18, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (19, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (20, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (21, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (22, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (23, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (24, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (25, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (26, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (27, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (28, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (29, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (30, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (31, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (32, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (33, 80);
INSERT INTO Inventory (product_id, quantity)
VALUES (34, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (35, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (36, 70);
INSERT INTO Inventory (product_id, quantity)
VALUES (37, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (38, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (39, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (40, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (41, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (42, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (43, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (44, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (45, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (46, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (47, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (48, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (49, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (50, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (51, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (52, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (53, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (54, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (55, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (56, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (57, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (58, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (59, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (60, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (61, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (62, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (63, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (64, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (65, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (66, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (67, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (68, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (69, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (70, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (71, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (72, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (73, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (74, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (75, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (76, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (77, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (78, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (79, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (80, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (81, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (82, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (83, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (84, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (85, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (86, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (87, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (88, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (89, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (90, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (91, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (92, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (93, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (94, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (95, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (96, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (97, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (98, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (99, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (100, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (101, 50);
INSERT INTO Inventory (product_id, quantity)
VALUES (102, 50);

# 아이템 입고시 재고처리
CREATE TRIGGER ReceivingAndCountInventory
    AFTER INSERT
    ON Receiving
    FOR EACH ROW
BEGIN
    DECLARE var_quantity INT;
    DECLARE var_product_id INT;

    -- 커서를 사용하지 않고 직접 INSERTED 테이블의 데이터에 접근
    SET var_quantity = NEW.quantity;
    SET var_product_id = NEW.product_id;

    -- 재고 업데이트
    UPDATE Inventory
    SET quantity = quantity + var_quantity
    WHERE product_id = var_product_id;
END;

# 카테 삭제 -> 아이템 삭제
CREATE TRIGGER CategoryCencelAndProductCencel
    AFTER UPDATE
    ON Category
    FOR EACH ROW
BEGIN
    IF NEW.check_category = FALSE THEN
        -- 카테고리의 check_category가 FALSE로 변경된 경우
        UPDATE Product
        SET check_product = FALSE
        WHERE category_id = NEW.category_id;
    END IF;
END;

# 카테 복원  -> 아이템 복원
CREATE TRIGGER CategoryRestoreAndProductRestore
    AFTER UPDATE
    ON Category
    FOR EACH ROW
BEGIN
    IF NEW.check_category = TRUE THEN
        -- 카테고리의 check_category가 TRUE로 변경된 경우
        UPDATE Product
        SET check_product = TRUE
        WHERE category_id = NEW.category_id;
    END IF;
END;

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 7);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 7);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 6);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 6);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 5);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 5);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 4);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 4);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 3);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 3);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 2);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 2);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 1);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 1);
do sleep(1);

#입고 등록
Call receivingTest(FLOOR(1 + RAND() * 102), 50, '50개 입고', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '소량 입고', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '수량 조절', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 61, '대량 입고', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 2, '', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 5, '5개 입고', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 10, '입고', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 24, '', 0);
do sleep(1);
Call receivingTest(FLOOR(1 + RAND() * 102), 3, '', 0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
CALL AddOrCountCart(14);
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(7);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(33);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
CALL AddOrCountCart(2);
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(6);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(5);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(4);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(3);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);


CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(2);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
CALL AddOrCountCart(36);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
CALL AddOrCountCart(7);
call AddSellingAndClearCartTest(1);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
CALL AddOrCountCart(FLOOR(1 + RAND() * 102));
call AddSellingAndClearCartTest(0);
do sleep(1);

CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
CALL AddOrCountCart(3);
call AddSellingAndClearCartTest(0);
do sleep(1);