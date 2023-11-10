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
group by rollup()
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
       SUM(selling.total_price) as total_price,
FROM selling
         INNER JOIN product
                    ON selling.product_id = product.product_id
         INNER JOIN category
                    ON product.category_id = category.category_id
         INNER JOIN orders
                    ON selling.orders_id = orders.orders_id
WHERE 1 =1
# AND DATE(selling.register_date) = '20231108'
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.check_product, category.name, category.check_category;

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
WHERE 1 = 1
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.check_product, category.name, category.check_category
WITH ROLLUP;


SELECT IFNULL(product.product_id, 'N/A') as product_id,
       IFNULL(product.name, 'N/A') as name,
       IFNULL(product.code, 'N/A') as code,
       IFNULL(product.sell_price, 0) as sell_price,
       IFNULL(product.image, 'N/A') as image,
       IFNULL(product.check_product, 'N/A') as check_product,
       IFNULL(category.name, 'N/A') as category_name,
       IFNULL(category.check_category, 'N/A') as check_category,
       IFNULL(SUM(selling.quantity), 0) as quantity,
       IFNULL(SUM(selling.total_price), 0) as total_price
FROM selling
         INNER JOIN product
                    ON selling.product_id = product.product_id
         INNER JOIN category
                    ON product.category_id = category.category_id
         INNER JOIN orders
                    ON selling.orders_id = orders.orders_id
WHERE 1 = 1
GROUP BY product.product_id, product.name, product.code, product.sell_price,
         product.image, product.check_product, category.name, category.check_category
WITH ROLLUP;


-- 상품 및 판매 정보 가져오기
SELECT
    product.product_id,
    product.name,
    product.code,
    product.sell_price,
    product.image,
    product.check_product,
    category.name AS category_name,
    category.check_category,
    SUM(selling.quantity) AS quantity,
    SUM(selling.total_price) AS total_price
FROM
    selling
        INNER JOIN
    product ON selling.product_id = product.product_id
        INNER JOIN
    category ON product.category_id = category.category_id
        INNER JOIN
    orders ON selling.orders_id = orders.orders_id
WHERE 1 = 1
GROUP BY
    product.product_id, product.name, product.code, product.sell_price,
    product.image, product.check_product, category.name, category.check_category;

# union all
-- 총 합계 계산
SELECT
    SUM(selling.quantity) AS quantity,
    SUM(selling.total_price) AS total_price
FROM
selling
WHERE 1 = 1
AND DATE (selling.register_date) = '2023-11-09';

SELECT count(*) as count FROM orders;

SELECT
    product.name,
    product.image,
    SUM(selling.quantity) AS quantity,
    SUM(selling.total_price) AS total_price
FROM
    selling
        INNER JOIN
    product ON selling.product_id = product.product_id
        INNER JOIN
    category ON product.category_id = category.category_id
        INNER JOIN
    orders ON selling.orders_id = orders.orders_id
WHERE 1 = 1
AND product.check_product = TRUE
GROUP BY
    product.name, product.sell_price, product.image
ORDER BY quantity desc , total_price DESC
limit 10;

SELECT
    product.name,
    product.image,
    SUM(selling.quantity) AS quantity,
    SUM(selling.total_price) AS total_price
FROM
    selling
        INNER JOIN
    product ON selling.product_id = product.product_id
        INNER JOIN
    category ON product.category_id = category.category_id
        INNER JOIN
    orders ON selling.orders_id = orders.orders_id
WHERE 1 = 1
  AND product.check_product = TRUE
  AND DATE(selling.register_date) = '2023-11-09'
GROUP BY
    product.name, product.sell_price, product.image
ORDER BY quantity desc , total_price DESC;

SELECT
    orders.orders_id,
    SUM(selling.quantity) as quantity,
    SUM(selling.total_price) as total_price,
    orders.register_date
FROM orders
INNER JOIN selling
ON orders.orders_id = selling.orders_id
where orders.check_orders = TRUE
AND DATE (orders.register_date) = '2023-11-09'
GROUP BY orders.orders_id;

SELECT
    name,
    quantity
FROM product
INNER JOIN inventory
ON product.product_id = inventory.product_id
where product.check_product =true
AND inventory.quantity <= -1;

SELECT * FROM selling