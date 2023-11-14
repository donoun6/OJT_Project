-- **임시 데이터**

# 카테고리 등록
INSERT INTO Category (name)
VALUES ('커피'),('디저트'),('음료');

# 물품 등록
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,'AAA-0000-0001','아메리카노',2500,'/img/am.png')
,(1,'AAA-0000-0002','카푸치노',3000,'/img/bla.jpg')
,(1,'AAA-0000-0003','디카페인',2500,'/img/bs.jpg')
,(1,'AAA-0000-0004','에스프레소',2000,'/img/ca.jpg')
,(1,'AAA-0000-0005','카페라떼',3000,'/img/cf.png')
,(2,'AAA-0000-0011','초코케이크',6000,'/img/ck.png')
,(2,'AAA-0000-0012','치즈케이크',6000,'/img/ck2.png')
,(2,'AAA-0000-0013','소금빵',3000,'/img/ck3.png')
,(2,'AAA-0000-0014','마들렌',1500,'/img/ck4.png')
,(2,'AAA-0000-0015','쿠키',1000,'/img/cl.png')
,(3,'AAA-0000-0021','바나나주스',5000,'/img/cm.jpg')
,(3,'AAA-0000-0022','사과주스',5000,'/img/cmm.jpg')
,(3,'AAA-0000-0023','콜라',1500,'/img/gk.png')
,(3,'AAA-0000-0024','사이다',1500,'/img/hb.jpg')
,(3,'AAA-0000-0025','박카스',1000,'/img/it.jpg');

# 재고 수량 등록
INSERT INTO Inventory (product_id, quantity)
VALUES (1,50);
INSERT INTO Inventory (product_id, quantity)
VALUES (2,24);
INSERT INTO Inventory (product_id, quantity)
VALUES (3,12);
INSERT INTO Inventory (product_id, quantity)
VALUES (4,34);
INSERT INTO Inventory (product_id, quantity)
VALUES (5,22);
INSERT INTO Inventory (product_id, quantity)
VALUES (6,12);
INSERT INTO Inventory (product_id, quantity)
VALUES (7,5);
INSERT INTO Inventory (product_id, quantity)
VALUES (8,0);
INSERT INTO Inventory (product_id, quantity)
VALUES (9,2);
INSERT INTO Inventory (product_id, quantity)
VALUES(10,32);
INSERT INTO Inventory (product_id, quantity)
VALUES (11,4);
INSERT INTO Inventory (product_id, quantity)
VALUES (12,12);
INSERT INTO Inventory (product_id, quantity)
VALUES (13,21);
INSERT INTO Inventory (product_id, quantity)
VALUES (14,18);
INSERT INTO Inventory (product_id, quantity)
VALUES (15,22);

#입고 등록
INSERT INTO Receiving (product_id, quantity, description)
VALUES (1,50,'50개 입고');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (2,2,'소량 입고');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (1,8,'');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (9,12,'');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (15,82,'입고');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (12,2,'');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (12,5,'추가 입고');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (6,3,'');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (11,15,'');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (1, 50, '50개 입고');
INSERT INTO Receiving (product_id, quantity, description)
VALUES (4, 2, '');

CALL AddOrCountCart(8);
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