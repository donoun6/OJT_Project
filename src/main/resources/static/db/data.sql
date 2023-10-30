-- **임시 데이터**

# 카테고리 등록
INSERT INTO Category (name)
VALUES ('커피'),('디저트'),('음료');

# 물품 등록
INSERT INTO Product (category_id, code, name, sell_price, image)
VALUES (1,'AAA-0000-0001','아메리카노',2500,'file/img1')
,(1,'AAA-0000-0002','카푸치노',3000,'file/img2')
,(1,'AAA-0000-0003','디카페인',2500,'file/img3')
,(1,'AAA-0000-0004','에스프레소',2000,'file/img4')
,(1,'AAA-0000-0005','카페라떼',3000,'file/img5')
,(2,'AAA-0000-0011','초코케이크',6000,'file/img11')
,(2,'AAA-0000-0012','치즈케이크',6000,'file/img12')
,(2,'AAA-0000-0013','소금빵',3000,'file/img13')
,(2,'AAA-0000-0014','마들렌',1500,'file/img14')
,(2,'AAA-0000-0015','쿠키',1000,'file/img15')
,(3,'AAA-0000-0021','바나나주스',5000,'file/img21')
,(3,'AAA-0000-0022','사과주스',5000,'file/img22')
,(3,'AAA-0000-0023','콜라',1500,'file/img23')
,(3,'AAA-0000-0024','사이다',1500,'file/img24')
,(3,'AAA-0000-0025','박카스',1000,'file/img25');

# 재고 수량 등록
INSERT INTO Inventory (product_id, quantity)
VALUES (1,50),(2,24),(3,12),(4,34),(5,22),
(6,12),(7,5),(8,0),(9,2),(10,32),
(11,4),(12,12),(13,21),(14,18),(15,22);

# 관리자 직접 등록
INSERT INTO Admin (password)
VALUES (1111)