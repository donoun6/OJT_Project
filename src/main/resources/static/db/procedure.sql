# **프로시저**

# 프로시저 삭제
DROP PROCEDURE AddOrResetCategory;
DROP PROCEDURE AddOrCountCart;
DROP PROCEDURE AddSellingAndClearCart;

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

-- 환불을 위한 프로시저 Orders 테이블의 orders_id 컬럼을 바탕으로 환불을 진행합니다.
CREATE PROCEDURE ProcessRefund(IN input_orders_id INT)
BEGIN
    -- 재고를 업데이트하기 위해 Selling 테이블에서 판매 내역을 가져옵니다.
    -- 'done'은 커서의 끝을 확인하기 위한 플래그, 'prod_id'와 'sold_qty'는 판매된 제품의 ID와 수량을 저장합니다.
    DECLARE done INT DEFAULT FALSE;
    DECLARE prod_id INT;
    DECLARE sold_qty INT;

    -- 판매된 제품의 정보를 가져오기 위한 커서를 선언합니다. 입력된 'orders_id'에 해당하는 모든 판매 레코드를 선택합니다.
    DECLARE cur CURSOR FOR
        SELECT product_id, quantity FROM Selling WHERE orders_id = input_orders_id;

    -- 커서에서 더 이상 행이 없을 경우 'done'을 TRUE로 설정하여 루프를 종료하기 위한 핸들러를 선언합니다.
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Cursor를 사용하여 각 제품에 대해 재고를 되돌립니다.
    OPEN cur;

    -- 'read_loop' 라벨을 사용하여 루프를 시작합니다. 이 루프는 커서의 모든 행을 순회하며 작업을 수행합니다.
    read_loop: LOOP
        -- 커서에서 다음 행을 가져옵니다.
        FETCH cur INTO prod_id, sold_qty;
        -- 'done' 플래그가 TRUE이면 루프를 종료합니다.
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Inventory 테이블을 업데이트하여 제품 재고를 원래대로 돌려놓습니다.
        -- 가져온 판매 데이터를 바탕으로 재고를 업데이트 합니다. 판매된 수량만큼 재고를 늘립니다.
        UPDATE Inventory SET quantity = quantity + sold_qty
        WHERE product_id = prod_id;
    END LOOP;

    -- 커서를 닫습니다.
    CLOSE cur;

    -- Selling 테이블에서 환불된 orders_id에 해당하는 모든 레코드를 삭제합니다.
    -- DELETE FROM Selling WHERE orders_id = input_orders_id;

    -- 필요한 경우 Orders 테이블의 상태를 업데이트합니다.
    -- 예를 들어, check_orders를 FALSE로 설정하여 환불된 것을 표시할 수 있습니다.

    -- Selling 테이블에서 해당 'orders_id'의 모든 레코드를 환불 상태로 업데이트합니다.
    UPDATE Orders SET check_orders = FALSE WHERE orders_id = input_orders_id;

    -- Orders 테이블에서 해당 'orders_id'의 레코드를 환불 상태로 업데이트합니다.
    UPDATE selling SET check_selling = FALSE WHERE orders_id = input_orders_id;
END;

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
END
