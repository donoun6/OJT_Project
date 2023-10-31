# Trigger

# 아이템 판매시 재고처리
CREATE TRIGGER SellingAndCountInventory AFTER INSERT ON Selling
    FOR EACH ROW
BEGIN
    DECLARE var_quantity INT;
    DECLARE var_product_id INT;

    -- 커서 대신 각 행에 대한 트리거를 사용
    SET var_quantity = NEW.quantity;
    SET var_product_id = NEW.product_id;

    -- 재고 업데이트
    UPDATE Inventory SET quantity = quantity - var_quantity
    WHERE product_id = var_product_id;
END;

# 아이템 입고시 재고처리
CREATE TRIGGER ReceivingAndCountInventory AFTER INSERT ON Receiving
    FOR EACH ROW
BEGIN
    DECLARE var_quantity INT;
    DECLARE var_product_id INT;

    -- 커서를 사용하지 않고 직접 INSERTED 테이블의 데이터에 접근
    SET var_quantity = NEW.quantity;
    SET var_product_id = NEW.product_id;

    -- 재고 업데이트
    UPDATE Inventory SET quantity = quantity + var_quantity
    WHERE product_id = var_product_id;
END;

# 주문 취소 -> 판매상품 취소
CREATE TRIGGER OrdersCancelAndSellingCancel
    AFTER UPDATE ON Orders
    FOR EACH ROW
BEGIN
    DECLARE var_orders_id INT;
    SET var_orders_id = NEW.orders_id;

    UPDATE Selling
    SET check_selling = FALSE
    WHERE orders_id = var_orders_id;
END;

# 판매취소 -> 재고처리
CREATE TRIGGER SellingCancelAndCountInventory
    AFTER UPDATE ON Selling
    FOR EACH ROW
BEGIN
    -- 변수 선언
    DECLARE var_quantity INT;
    DECLARE var_product_id INT;

    SET var_quantity = NEW.quantity;
    SET var_product_id = NEW.product_id;

    -- 재고 업데이트
    UPDATE Inventory
    SET quantity = quantity + var_quantity
    WHERE product_id = var_product_id;
END;

# 카테 삭제 -> 아이템 삭제
CREATE TRIGGER CategoryCencelAndProductCencel
    AFTER UPDATE ON Category
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
    AFTER UPDATE ON Category
    FOR EACH ROW
BEGIN
    IF NEW.check_category = TRUE THEN
        -- 카테고리의 check_category가 TRUE로 변경된 경우
        UPDATE Product
        SET check_product = TRUE
        WHERE category_id = NEW.category_id;
    END IF;
END;