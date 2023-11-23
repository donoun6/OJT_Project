DELIMITER //
CREATE PROCEDURE AddOrCountCart(IN param_product_id INT)
BEGIN
    DECLARE v_sell_price INT;
    DECLARE v_name VARCHAR(20);
    DECLARE v_image VARCHAR(50); -- 이미지 파일명 변수
    DECLARE v_cart_quantity INT; -- 현재 장바구니에 있는 제품의 수량
    DECLARE v_inventory_quantity INT;
    -- 현재 인벤토리에 있는 제품의 수량

    -- 제품 가격, 이름, 이미지 가져오기
    SELECT sell_price, name, image
    INTO v_sell_price, v_name, v_image
    FROM Product
    WHERE product_id = param_product_id;
    -- 현재 장바구니에 있는 제품의 수량 가져오기
    SELECT IFNULL(quantity, 0)
    INTO v_cart_quantity
    FROM Cart
    WHERE product_id = param_product_id;
    -- Inventory에서 해당 제품의 재고 수량 가져오기
    SELECT IFNULL(quantity, 0)
    INTO v_inventory_quantity
    FROM Inventory
    WHERE product_id = param_product_id;
    -- Inventory에서 해당 제품의 재고 수량 가져오기
    SELECT IFNULL(quantity, 0)
    INTO v_inventory_quantity
    FROM Inventory
    WHERE product_id = param_product_id;
    IF (param_product_id IN (SELECT product_id FROM Cart)) THEN
        IF (v_cart_quantity < v_inventory_quantity) THEN -- 재고 수량이 장바구니 수량보다 많을 경우
            UPDATE Cart
            SET quantity    = quantity + 1,
                total_price = total_price + v_sell_price -- 이 부분에서 total_price를 제품 가격만큼 올림
            WHERE product_id = param_product_id;
        end if;
    ELSE
        IF (v_inventory_quantity > 0) THEN -- 재고가 있을 경우에만 추가
            INSERT INTO Cart(product_id, product_name, quantity, total_price, image)
            VALUES (param_product_id, v_name, 1, v_sell_price, v_image); -- 여기서는 수량 1 * 제품 가격으로 total_price 설정
        END IF;
    END IF;
END //
DELIMITER ;
