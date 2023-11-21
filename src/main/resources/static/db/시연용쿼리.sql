CREATE PROCEDURE ProcessSpecificOfFullRefund(IN input_orders_id INT, IN input_product_id INT)
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
        SET i.quantity

    end if;
end;