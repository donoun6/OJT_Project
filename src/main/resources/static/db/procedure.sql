# **프로시저**

# 프로시저 삭제
DROP PROCEDURE AddOrResetCategory;
DROP PROCEDURE AddOrCountCart;
DROP PROCEDURE AddSellingAndClearCart;

# 프로시저 생성
-- 카테고리 등록 이전에 삭제했던 카테고리면 삭제 취소, 아니면 새로 등록
CREATE PROCEDURE AddOrResetCategory(IN param_name VARCHAR(20))
BEGIN
    SET @cate_id = NULL;
    -- check_category 값 변수에 입력
    SELECT category_id INTO @cate_id
                       FROM Category
                       WHERE name = param_name;

    IF (@cate_id IS NOT NULL) THEN
        UPDATE Category SET check_category = TRUE
                        WHERE category_id = @cate_id;
    ELSE
        INSERT INTO Category (name, check_category)
        VALUES (param_name, TRUE);
    END IF;
END;


-- 장바구니 담기 만약 해당 제품이 이미 장바구니에 있는경우 수량만 높이기
CREATE PROCEDURE AddOrCountCart(IN param_product_id INT)
BEGIN
    SET @sell_price = NULL;
    -- 먼저 제품 가격 가져오기
    SELECT sell_price INTO @sell_price
                      FROM Product
                      WHERE product_id = param_product_id;

    IF (param_product_id IN (SELECT product_id FROM cart)) THEN
        UPDATE Cart SET quantity = quantity + 1,
                        total_price = total_price + @sell_price
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
    SELECT orders_id INTO @orders_id
                     FROM Orders
                     ORDER BY orders_id DESC
                     LIMIT 1;
    -- cart 정보 가져와서 판매정보 담기
    INSERT INTO Selling (product_id, orders_id, quantity, total_price)
    SELECT product_id, @orders_id, quantity, total_price FROM Cart;
    -- cart 비우기
    TRUNCATE
TABLE Cart;
END;
