# **프로시저**

-- 카테고리 등록 이전에 삭제했던 카테고리면 삭제 취소, 아니면 새로 등록
CREATE PROCEDURE AddOrResetCategory(IN param_name VARCHAR(20))
BEGIN
    SET @cate_id = NULL;

    -- check_category 값 변수에 입력
    SELECT category_id INTO @cate_id FROM Category WHERE name = param_name;

    IF (@cate_id IS NOT NULL) THEN
        UPDATE Category SET check_category = TRUE WHERE category_id = @cate_id;
    ELSE
        INSERT INTO Category (name, check_category) VALUES (param_name, TRUE);
    END IF;
END;

-- 장바구니 담기 만약 해당 제품이 이미 장바구니에 있는경우 수량만 높이기
CREATE PROCEDURE AddOrCountCart(IN param_product_id INT)
BEGIN
    SET @sell_price = NULL;

    -- 먼저 제품 가격 가져오기
    SELECT sell_price INTO @sell_price FROM Product WHERE product_id = param_product_id;

    IF (param_product_id IN (SELECT product_id FROM cart)) THEN
        UPDATE Cart SET quantity = quantity + 1, total_price = total_price + @sell_price
        WHERE product_id = param_product_id;
    ELSE
        INSERT INTO Cart (product_id, quantity, total_price)
        VALUES (param_product_id, 1, @sell_price);
    END IF;
END;

-- 결제 완료시 판매정보 넘기고 장바구니 비우기
CREATE PROCEDURE AddSellingAndClearCart()
BEGIN
    -- 주문 번호 시퀀스
    INSERT INTO Orders (check_orders)
    VALUES (TRUE);

    SET @orders_id = NULL;
    SELECT orders_id INTO @orders_id FROM Orders
    ORDER BY orders_id DESC
    LIMIT 1;

    -- cart 정보 가져와서 판매정보 담기
    INSERT INTO Selling (product_id, orders_id, quantity, total_price)
    SELECT product_id, @orders_id, quantity, total_price FROM Cart;

    -- cart 비우기
    TRUNCATE TABLE Cart;
END;

# 프로시저 삭제
DROP PROCEDURE AddOrResetCategory;
DROP PROCEDURE AddOrCountCart;
DROP PROCEDURE AddSellingAndClearCart;

# **쿼리 테스트**

-- 전체 카테고리 출력
SELECT * FROM Category
WHERE check_category = TRUE;

-- 카테고리 변경
UPDATE Category set name = '커피'
WHERE category_id = 1;

-- 카테고리 삭제 처리
UPDATE Category set check_category = FALSE
WHERE category_id = 1;

-- 카테고리 등록 이전에 삭제했던 카테고리면 삭제 취소, 아니면 새로 등록
CALL AddOrResetCategory('커피');

-- 카테고리 별 품목 출력
SELECT *
FROM Category
    INNER JOIN Product
        ON Category.category_id = Product.category_id
    INNER JOIN Inventory
        ON Product.product_id = Inventory.product_id
WHERE Category.category_id = 1
  AND Category.check_category = TRUE
  AND Product.check_product = TRUE;

-- 상품 정보 출력
SELECT * FROM Product
WHERE product_id = 1
  AND Product.check_product = TRUE;

-- 상품 카테고리 수정
UPDATE Product set category_id = 1
WHERE product_id = 1;

-- 상품 삭제처리
UPDATE Product set check_product = FALSE
WHERE product_id = 1;

-- 장바구니 담기 만약 해당 제품이 이미 장바구니에 있는경우 수량만 높이기
CALL AddOrCountCart(5);

-- 장바구니 정보 출력
SELECT *
FROM Cart INNER JOIN Product
ON Cart.product_id = Product.product_id;

-- 결제 완료시 판매정보 넘기고 장바구니 비우기
CALL AddSellingAndClearCart();

-- 주문 번호 출력
SELECT * FROM Orders;

-- 주문 정보 출력
SELECT *
FROM Orders
    INNER JOIN Selling
        ON Orders.orders_id = Selling.orders_id
    INNER JOIN Product
        ON Selling.product_id = Product.product_id
WHERE Orders.orders_id = 1;

-- 아이템 판매 정보 출력
SELECT *
FROM Selling
    INNER JOIN Product
        ON Selling.product_id = Product.product_id;

-- 입고 등록
INSERT INTO Receiving (product_id, quantity)
VALUES (2,11);

-- 입고 내역 가져오기
SELECT * FROM Receiving
ORDER BY register_date desc;

-- 제품 삭제
UPDATE Product
SET check_product = 0
WHERE product_id = 1;

-- 주문 취소 (트리거를 사용해서 주문 취소를 하면 판매취소 재고까지 자동으로 변경시켜줌)
UPDATE Orders
SET check_orders = 0
WHERE orders_id = 1;

-- 판매 정보 가져오기
SELECT *
FROM Orders
    INNER JOIN Selling
        ON Orders.orders_id = Selling.orders_id
    INNER JOIN Product
        ON Selling.product_id = Product.product_id
WHERE Orders.check_orders != 1;

-- 주문 취소 number 가져오기.
SELECT * FROM Orders
WHERE Orders.check_orders = 0;

-- 주문 취소 정보 가져오기
SELECT *
FROM Orders
    INNER JOIN Selling
        ON Orders.orders_id = Selling.orders_id
    INNER JOIN Product
        ON Selling.product_id = Product.product_id
WHERE Orders.check_orders = 0;

-- 상품별 판매 정보
SELECT Selling.product_id , sum(Selling.quantity) AS quantity , Product.name,
    sum(Product.sell_price * Selling.quantity) AS total_price
FROM Selling
    INNER JOIN Product
ON Selling.product_id = Product.product_id
WHERE Selling.check_selling != 0
GROUP BY Selling.product_id , Product.name;

-- 판매 금액 조회
SELECT SUM(total_price)AS total_price FROM Selling
WHERE Selling.check_selling != 0;