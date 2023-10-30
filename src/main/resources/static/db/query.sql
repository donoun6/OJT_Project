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
CALL AddOrCountCart(2);

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
VALUES (2,100);

-- 입고 내역 가져오기
SELECT * FROM Receiving
ORDER BY register_date desc;

-- 제품 삭제
UPDATE Product
SET check_product = FALSE
WHERE product_id = 1;

-- 주문 취소 (트리거를 사용해서 주문 취소를 하면 판매취소 재고까지 자동으로 변경시켜줌)
UPDATE Orders
SET check_orders = FALSE
WHERE orders_id = 1;

-- 판매 정보 가져오기
SELECT *
FROM Orders
    INNER JOIN Selling
        ON Orders.orders_id = Selling.orders_id
    INNER JOIN Product
        ON Selling.product_id = Product.product_id
WHERE Orders.check_orders = TRUE;

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
WHERE Orders.check_orders = FALSE;

-- 상품별 판매 정보
SELECT Selling.product_id , SUM(Selling.quantity) AS quantity , Product.name,
       SUM(Product.sell_price * Selling.quantity) AS total_price
FROM Selling
    INNER JOIN Product
        ON Selling.product_id = Product.product_id
WHERE Selling.check_selling = TRUE
GROUP BY Selling.product_id ,Product.name;

-- 판매 금액 조회
SELECT SUM(total_price)AS total_price FROM Selling
WHERE Selling.check_selling = TRUE;