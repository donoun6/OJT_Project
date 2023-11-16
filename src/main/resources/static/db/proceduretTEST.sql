CREATE PROCEDURE AddOrResetCategory(IN param_name VARCHAR(20))
BEGIN
    SET @cate_id = NULL;
    -- check_category 값 변수에 입력
    SELECT category_id INTO @cate_id
    FROM Category
    WHERE name = paran_name;

    IF (@cate_id IS NULL) THEN
       INSERT INTO Category (name, check_category)
       VALUES (param_name, TRUE);
    END IF;
END;

CREATE PROCEDURE Add