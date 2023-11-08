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
         LEFT JOIN inventory
             ON product.product_id = inventory.product_id
         LEFT JOIN selling
             ON product.product_id = selling.product_id
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.category_id, category.name, inventory.inventory_id, inventory.quantity;
;

SELECT selling.selling_id,
       selling.quantity,
       selling.total_price,
       selling.check_selling,
       selling.register_date,
       product.product_id,
       product.name,
       product.code,
       product.sell_price,
       product.image,
       product.check_product,
       category.category_id,
       category.name,
       category.check_category,
       orders.orders_id,
       orders.check_orders
FROM selling
    INNER JOIN product
        ON selling.product_id = product.product_id
    INNER JOIN category
        ON product.category_id = category.category_id
    INNER JOIN orders
        ON selling.orders_id = orders.orders_id
where 1 = 1
and DATE(selling.register_date) = '2023-11-07';

SELECT selling.selling_id,
       selling.quantity,
       selling.total_price,
       selling.check_selling,
       selling.register_date,
       product.product_id,
       product.name,
       product.code,
       product.sell_price,
       product.image,
       product.check_product,
       category.name,
       category.check_category,
       orders.orders_id,
       orders.check_orders
FROM selling
         INNER JOIN product
                    ON selling.product_id = product.product_id
         INNER JOIN category
                    ON product.category_id = category.category_id
         INNER JOIN orders
                    ON selling.orders_id = orders.orders_id

UNION ALL

SELECT NULL, NULL, SUM(total_price), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM selling

SELECT product.product_id,
       product.name,
       product.code,
       product.sell_price,
       product.image,
       product.check_product,
       category.name,
       category.check_category,
       SUM(selling.quantity) as quantity,
       SUM(selling.total_price) as total_price
FROM selling
         INNER JOIN product
                    ON selling.product_id = product.product_id
         INNER JOIN category
                    ON product.category_id = category.category_id
         INNER JOIN orders
                    ON selling.orders_id = orders.orders_id
WHERE 1 =1
AND selling.register_date = 20231108
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.check_product, category.name, category.check_category
ORDER BY total_price DESC;


