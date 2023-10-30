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


drop function fn_choSearch;

CREATE DEFINER=`daojt`@`localhost` FUNCTION `fn_choSearch`(
    `str` varchar(20)
) RETURNS varchar(20) CHARSET utf8

BEGIN
    -- 초성검색 function
    declare returnStr varchar(100);
    declare cnt int;
    declare i int;
    declare j int;
    declare tmpStr varchar(10);

    if str is null then
        return '';
    end if;

    set cnt = length(str)/3;
    set i = 1;
    set j = 1;

    while i <=cnt DO
            set tmpStr = substring(str,i,j);
            set returnStr = concat(ifnull(returnStr,''),

                                   case when tmpStr rlike '^(ㄱ|ㄲ)' OR ( tmpStr >= '가' AND tmpStr < '나' ) then 'ㄱ'
                                        when tmpStr rlike '^ㄴ' OR ( tmpStr >= '나' AND tmpStr < '다' ) then 'ㄴ'
                                        when tmpStr rlike '^(ㄷ|ㄸ)' OR ( tmpStr >= '다' AND tmpStr < '라' ) then 'ㄷ'
                                        when tmpStr rlike '^ㄹ' OR ( tmpStr >= '라' AND tmpStr < '마' ) then 'ㄹ'
                                        when tmpStr rlike '^ㅁ' OR ( tmpStr >= '마' AND tmpStr < '바' ) then 'ㅁ'
                                        when tmpStr rlike '^ㅂ' OR ( tmpStr >= '바' AND tmpStr < '사' ) then 'ㅂ'
                                        when tmpStr rlike '^(ㅅ|ㅆ)' OR ( tmpStr >= '사' AND tmpStr < '아' ) then 'ㅅ'
                                        when tmpStr rlike '^ㅇ' OR ( tmpStr >= '아' AND tmpStr < '자' ) then 'ㅇ'
                                        when tmpStr rlike '^(ㅈ|ㅉ)' OR ( tmpStr >= '자' AND tmpStr < '차' ) then 'ㅈ'
                                        when tmpStr rlike '^ㅊ' OR ( tmpStr >= '차' AND tmpStr < '카' ) then 'ㅊ'
                                        when tmpStr rlike '^ㅋ' OR ( tmpStr >= '카' AND tmpStr < '타' ) then 'ㅋ'
                                        when tmpStr rlike '^ㅌ' OR ( tmpStr >= '타' AND tmpStr < '파' ) then 'ㅌ'
                                        when tmpStr rlike '^ㅍ' OR ( tmpStr >= '파' AND tmpStr < '하' ) then 'ㅍ'
                                        else 'ㅎ' end);
            set i=i+1;
        end while;
    RETURN returnStr;

END;

show global variables like 'log_bin_trust_function_creators';

SET GLOBAL log_bin_trust_function_creators = 1; //ON
#SET GLOBAL log_bin_trust_function_creators = 0; //OFF


