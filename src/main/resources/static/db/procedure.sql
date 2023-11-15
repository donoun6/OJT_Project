# **프로시저**

# 프로시저 삭제
DROP PROCEDURE AddOrResetCategory;
DROP PROCEDURE AddOrCountCart;
DROP PROCEDURE AddSellingAndClearCart;
DROP PROCEDURE ProcessSpecificOrFullRefund;
DROP PROCEDURE ProcessSpecificOrFullRefund2;
DROP PROCEDURE ProcessRefundCancellation;
DROP PROCEDURE ProcessSpecificOrFullRefund3;

# 프로시저 생성
-- 카테고리 등록 이전에 삭제했던 카테고리면 등록 X, 아니면 새로 등록
CREATE PROCEDURE AddOrResetCategory(IN param_name VARCHAR(20))
BEGIN
    SET @cate_id = NULL;
    -- check_category 값 변수에 입력
    SELECT category_id INTO @cate_id
    FROM Category
    WHERE name = param_name;

    IF (@cate_id IS NULL) THEN
        INSERT INTO Category (name, check_category)
        VALUES (param_name, TRUE);
    END IF;
END;


-- 장바구니에 상품을 담을때 창고에 있는 수량보다 많이 담는 것을 방지하기 위한 프로시저입니다.
DELIMITER //
CREATE PROCEDURE AddOrCountCart(IN param_product_id INT)
BEGIN
    DECLARE v_sell_price INT;
    DECLARE v_name VARCHAR(20);
    DECLARE v_image VARCHAR(20); -- 이미지 파일명 변수
    DECLARE v_cart_quantity INT; -- 현재 장바구니에 있는 제품의 수량
    DECLARE v_inventory_quantity INT; -- 현재 인벤토리에 있는 제품의 수량
    -- 제품 가격, 이름, 이미지 가져오기
    SELECT sell_price, name, image INTO v_sell_price, v_name, v_image
    FROM Product
    WHERE product_id = param_product_id;
    -- 현재 장바구니에 있는 제품의 수량 가져오기
    SELECT IFNULL(quantity, 0) INTO v_cart_quantity
    FROM Cart
    WHERE product_id = param_product_id;
    -- Inventory에서 해당 제품의 재고 수량 가져오기
    SELECT IFNULL(quantity, 0) INTO v_inventory_quantity
    FROM Inventory
    WHERE product_id = param_product_id;
    IF (param_product_id IN (SELECT product_id FROM Cart)) THEN
        IF (v_cart_quantity < v_inventory_quantity) THEN -- 재고 수량이 장바구니 수량보다 많을 경우
            UPDATE Cart
            SET quantity = quantity + 1,
                total_price = total_price + v_sell_price  -- 이 부분에서 total_price를 제품 가격만큼 올림
            WHERE product_id = param_product_id;
        END IF;
    ELSE
        IF (v_inventory_quantity > 0) THEN -- 재고가 있을 경우에만 추가
            INSERT INTO Cart (product_id, product_name, quantity, total_price, image)
            VALUES (param_product_id, v_name, 1, v_sell_price, v_image); -- 여기서는 수량 1 * 제품 가격으로 total_price 설정
        END IF;
    END IF;
END //
DELIMITER ;

-- 결제 완료시 판매정보 넘기고 장바구니 비우기 V2
# 주문 완료 - 데이터 입력시 사용
CREATE PROCEDURE AddSellingAndClearCart()

BEGIN

    INSERT INTO Orders (check_orders)
    VALUES (TRUE);

    SET @orders_id = NULL;
    SELECT orders_id INTO @orders_id
    FROM Orders
    ORDER BY orders_id DESC
    LIMIT 1;

    INSERT INTO Selling (product_id, orders_id, quantity, total_price)
    SELECT product_id, @orders_id, quantity, total_price FROM Cart;

    UPDATE Inventory
        JOIN Selling ON Inventory.product_id = Selling.product_id
    SET Inventory.quantity = Inventory.quantity - Selling.quantity
    WHERE Selling.orders_id = @orders_id;

    TRUNCATE TABLE Cart;

END;

CREATE PROCEDURE ProcessSpecificOrFullRefund(IN input_orders_id INT, IN input_product_id INT)
BEGIN
    DECLARE refundable INT DEFAULT 0;

    IF input_product_id IS NOT NULL THEN

        UPDATE Inventory i
            JOIN Selling s ON i.product_id = s.product_id
        SET i.quantity = i.quantity + s.quantity
        WHERE s.orders_id = input_orders_id AND s.product_id = input_product_id AND s.check_selling = TRUE;

        UPDATE Selling
        SET check_selling = FALSE
        WHERE orders_id = input_orders_id AND product_id = input_product_id AND check_selling = TRUE;
    ELSE

        UPDATE Inventory i
            JOIN Selling s ON i.product_id = s.product_id
        SET i.quantity = i.quantity + s.quantity
        WHERE s.orders_id = input_orders_id AND s.check_selling = TRUE;

        UPDATE Selling
        SET check_selling = FALSE,
            register_date = CURRENT_TIMESTAMP -- 현재 시간으로 날짜 업데이트
        WHERE orders_id = input_orders_id AND check_selling = TRUE;


        SELECT COUNT(*) INTO refundable
        FROM Selling
        WHERE orders_id = input_orders_id AND check_selling = TRUE;


        IF refundable = 0 THEN
            UPDATE Orders
            SET check_orders = FALSE
            WHERE orders_id = input_orders_id;
        END IF;
    END IF;
END;

/* Selling 테이블의 check_selling을 조회하면서 Selling테이블의 orders_id가 모두 0이면 Orders테이블의
   check_orders값을 0으로 바꿔놓는다. */
CREATE PROCEDURE ProcessSpecificOrFullRefund2(IN input_orders_id INT)
BEGIN
    DECLARE refundable INT DEFAULT 0;
    -- Selling 테이블에서 해당 orders_id로 환불 가능한 (check_selling = TRUE) 상품이 있는지 확인
    SELECT COUNT(*) INTO refundable
    FROM Selling
    WHERE orders_id = input_orders_id AND check_selling = TRUE;

    -- 환불 가능한 상품이 없으면 Orders 테이블의 check_orders를 FALSE로 업데이트
    IF refundable = 0 THEN
        UPDATE Orders
        SET check_orders = FALSE,
            register_date = CURRENT_TIMESTAMP -- 현재 시간으로 날짜 업데이트
        WHERE orders_id = input_orders_id;
    END IF;
END;

CREATE PROCEDURE ProcessSpecificOrFullRefund3(IN input_orders_id INT)
BEGIN
    DECLARE not_refunded INT DEFAULT 0;

    -- Selling 테이블에서 해당 orders_id에 대해 아직 환불되지 않은 (check_selling = FALSE) 상품의 수를 확인
    SELECT COUNT(*) INTO not_refunded
    FROM Selling
    WHERE orders_id = input_orders_id AND check_selling = FALSE;

    -- 환불되지 않은 상품이 없으면 (모든 상품이 환불된 상태면) Orders 테이블의 check_orders를 TRUE로 업데이트
    IF not_refunded = 0 THEN
        UPDATE Orders
        SET check_orders = TRUE,
            register_date = CURRENT_TIMESTAMP -- 현재 시간으로 날짜 업데이트
        WHERE orders_id = input_orders_id;
    END IF;
END;

DELIMITER ;

CREATE PROCEDURE AddProductAndAddInventory(IN category_id INT, IN product_name VARCHAR(255),
                                           IN product_code VARCHAR(255), IN product_sell_price INT, IN product_image VARCHAR(255), IN inventory_quantity INT)
BEGIN
    -- Add product
    INSERT INTO product (category_id, name, code, sell_price, image)
    VALUES (category_id, product_name, product_code, product_sell_price, product_image);

    -- Get the last inserted product_id
    SET @product_id = LAST_INSERT_ID();

    -- Add inventory
    INSERT INTO inventory (product_id, quantity)
    VALUES (@product_id, inventory_quantity);
END;

# 환불취소 기능입니다.
CREATE PROCEDURE ProcessRefundCancellation(IN input_orders_id INT, IN input_product_id INT)
BEGIN
    DECLARE restockable INT DEFAULT 0;

    IF input_product_id IS NOT NULL THEN
        -- 개별 상품 환불 취소 로직
        UPDATE Inventory i
            JOIN Selling s ON i.product_id = s.product_id
        SET i.quantity = i.quantity - s.quantity
        WHERE s.orders_id = input_orders_id AND s.product_id = input_product_id AND s.check_selling = FALSE;

        UPDATE Selling
        SET check_selling = TRUE
        WHERE orders_id = input_orders_id AND product_id = input_product_id AND check_selling = FALSE;
    ELSE
        -- 전체 주문 환불 취소 로직
        UPDATE Inventory i
            JOIN Selling s ON i.product_id = s.product_id
        SET i.quantity = i.quantity - s.quantity
        WHERE s.orders_id = input_orders_id AND s.check_selling = FALSE;

        UPDATE Selling
        SET check_selling = TRUE,
            register_date = CURRENT_TIMESTAMP -- 현재 시간으로 날짜 업데이트
        WHERE orders_id = input_orders_id AND check_selling = FALSE;

        -- Selling 테이블에서 해당 orders_id로 환불 취소 가능한 (check_selling = FALSE) 상품이 있는지 확인
        SELECT COUNT(*) INTO restockable
        FROM Selling
        WHERE orders_id = input_orders_id AND check_selling = FALSE;

        -- 환불 취소 가능한 상품이 없으면 Orders 테이블의 check_orders를 TRUE로 업데이트
        IF restockable = 0 THEN
            UPDATE Orders
            SET check_orders = TRUE
            WHERE orders_id = input_orders_id;
        END IF;
    END IF;
END;
