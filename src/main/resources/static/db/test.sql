SELECT
    product.product_id,
    product.name,
    product.code,
    product.sell_price,
    product.image,
    product.category_id,
    category.name,
    inventory.inventory_id,
    inventory.quantity,
    IFNULL(SUM(selling.selling_id), 0) AS selling_id,
    IFNULL(SUM(selling.quantity), 0) AS selling_quantity,
    IFNULL(SUM(selling.total_price), 0) AS total_price
FROM product
         INNER JOIN category
             ON product.category_id = category.category_id
         INNER JOIN inventory
             ON product.product_id = inventory.product_id
         LEFT JOIN selling
             ON product.product_id = selling.product_id
WHERE product.check_product = true
    AND category.check_category = true
    AND fn_choSearch(Product.name) like concat('%', '박ㅋ', '%')
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.category_id, category.name, inventory.inventory_id, inventory.quantity
ORDER BY total_price;





