# product 조회 list
SELECT
    product.product_id,
    product.name,
    product.code,
    product.sell_price,
    product.image,
    product.category_id,
    product.register_date,
    product.check_product,
    category.name,
    category.check_category,
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
AND DATE(product.register_date) BETWEEN '2023-10-30' AND '2023-10-30'
#     AND category.check_category = true
#   AND product.check_product = false
#   AND category.check_category = false
#     AND fn_choSearch(Product.name) like concat('%', '박ㅋ', '%')
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.category_id, category.name, inventory.inventory_id, inventory.quantity

;

select * from product
WHERE register_date = 2023-10-31







