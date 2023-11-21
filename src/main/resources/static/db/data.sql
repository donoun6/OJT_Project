-- **임시 데이터**

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
VALUES (1,100);
INSERT INTO Inventory (product_id, quantity)
VALUES (2, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (3, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (4, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (5, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (6, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (7, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (8, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (9, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES(10, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (11, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (12, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (13, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (14, 100);
INSERT INTO Inventory (product_id, quantity)
VALUES (15, 100);

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

# 판매정보 날짜별 넣기
drop procedure AddSellingAndClearCartTest;

# 주문 완료 - 데이터 입력시 사용
CREATE PROCEDURE AddSellingAndClearCartTest(IN num INT)

BEGIN
    INSERT INTO Orders (check_orders,register_date)
    VALUES (TRUE,DATE_SUB(NOW(), INTERVAL num DAY));

    SET @orders_id = NULL;
    SET @orders_registerDate = NULL;

    SELECT orders_id, register_date INTO @orders_id, @orders_registerDate
    FROM Orders
    ORDER BY orders_id DESC
    LIMIT 1;

    INSERT INTO Selling (product_id, orders_id, quantity, total_price, register_date)
    SELECT product_id, @orders_id, quantity, total_price, @orders_registerDate FROM Cart;

    UPDATE Inventory
        JOIN Selling ON Inventory.product_id = Selling.product_id
    SET Inventory.quantity = Inventory.quantity - Selling.quantity
    WHERE Selling.orders_id = @orders_id;

    TRUNCATE TABLE Cart;

END;

drop procedure receivingTest;

create
    definer = root@localhost procedure receivingTest(IN proid int , IN quan int, IN des VARCHAR(50),  IN num int)
BEGIN
    INSERT INTO Receiving (product_id, quantity, description,register_date)
    VALUES (proid,quan,des,DATE_SUB(NOW(), INTERVAL num DAY));
END;

SELECT * FROM Orders WHERE check_orders = '0' ORDER BY orders_id DESC