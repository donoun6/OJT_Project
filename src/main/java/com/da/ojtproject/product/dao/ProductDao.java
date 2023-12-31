package com.da.ojtproject.product.dao;

import com.da.ojtproject.product.domain.Product;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class ProductDao {

    private JdbcTemplate template;
    private SimpleJdbcCall AddProductAndAddInventory;

    public ProductDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
        this.AddProductAndAddInventory = new SimpleJdbcCall(template)
                .withProcedureName("AddProductAndAddInventory");
    }

    /**
     * 전체 product list 반환
     */
    public List<Product> getAllProducts() {
        String sql = "SELECT " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.sell_price, " +
                "product.image, " +
                "product.category_id, " +
                "product.check_product, " +
                "product.register_date, " +
                "category.name, " +
                "category.check_category, " +
                "inventory.inventory_id, " +
                "inventory.quantity, " +
                "IFNULL(SUM(selling.selling_id), 0) AS selling_id, " +
                "IFNULL(SUM(CASE WHEN selling.check_selling = true THEN selling.quantity ELSE 0 END), 0) AS selling_quantity, " +
                "IFNULL(SUM(CASE WHEN selling.check_selling = true THEN selling.total_price ELSE 0 END), 0) AS total_price " +
                "FROM product " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "LEFT JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "LEFT JOIN selling " +
                "ON product.product_id = selling.product_id " +
                "WHERE category.check_category = true " +
                "AND product.check_product = true " +
                "GROUP BY product.product_id, product.name, product.code, product.sell_price, " +
                "product.image, product.category_id, category.name, " +
                "inventory.inventory_id, inventory.quantity";
        return template.query(sql, new ProductListRowMapper());
    }

    /**
     * 검색 조건에 맞는 product list 반환
     */
    public List<Product> getSelectProducts(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.sell_price, " +
                "product.image, " +
                "product.category_id, " +
                "product.check_product, " +
                "product.register_date, " +
                "category.name, " +
                "category.check_category, " +
                "inventory.inventory_id, " +
                "inventory.quantity, " +
                "IFNULL(SUM(selling.selling_id), 0) AS selling_id, " +
                "IFNULL(SUM(CASE WHEN selling.check_selling = true THEN selling.quantity ELSE 0 END), 0) AS selling_quantity, " +
                "IFNULL(SUM(CASE WHEN selling.check_selling = true THEN selling.total_price ELSE 0 END), 0) AS total_price " +
                "FROM product " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "LEFT JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "LEFT JOIN selling " +
                "ON product.product_id = selling.product_id " +
                "WHERE 1 = 1 ");
        /**
         * categoryDeleteCheck : 조회 방식 선택
         */
        if (data.get("categoryDeleteCheck").equals("N")) {
            /**
             * deleteCheck : 삭제상품 포함 여부
             */
            if (data.get("productDeleteCheck").equals("N")) {
                sb.append("AND product.check_product = true " +
                        "AND category.check_category = true ");
            } else {
                sb.append("AND product.check_product IS NOT NULL ");
            }
        } else {
            sb.append("AND product.check_product = false ");
        }

        /**
         * checkName : 검색 value (상품 이름 검색, 초성 검색)
         */
        if (data.get("checkName").equals("Y")) {
            sb.append("AND fn_choSearch(Product.name) LIKE CONCAT('%', '" + data.get("name") + "', '%')");
        } else {
            sb.append("AND Product.name LIKE'%" + data.get("name") + "%'");
        }
        /**
         * startRegisterDate : 시작 날짜
         * endRegisterDate : 종료 날짜
         * 범위 지정 검색
         */
        if (!data.get("startRegisterDate").equals("") && !data.get("endRegisterDate").equals("")) {
            sb.append("AND DATE(product.register_date) BETWEEN '" + data.get("startRegisterDate") + "' AND '" + data.get("endRegisterDate") + "'");
        }
        /**
         * category : 카테고리 별 상품 출력
         */
        if (!data.get("category").equals("all")) {
            sb.append("AND product.category_id = " + data.get("category") + " ");
        }
        sb.append("GROUP BY product.product_id, product.name, product.code, product.sell_price, " +
                "product.image, product.category_id, category.name, " +
                "inventory.inventory_id, inventory.quantity ");
        /**
         * col : 조건 컬럼
         * order : 정렬 상태
         */
        if (!data.get("col").equals("") && !data.get("order").equals("")) {
            sb.append("ORDER BY " + data.get("col") + " " + data.get("order"));
        }
        String sql = sb.toString();
        return template.query(sql, new ProductListRowMapper());
    }

    /**
     * product 등록, 재고 수량 등록
     */
    public void saveProduct(Product product) {
        AddProductAndAddInventory.execute(product.getCategoryId(), product.getName(), product.getCode(),
                product.getSellPrice(), product.getImage(), product.getInventory().getQuantity());
    }

    /**
     * 상품 삭제
     */
    public void deleteProduct(int productId) {
        String sql = "UPDATE Product SET check_product = FALSE " +
                "WHERE product_id = ?";
        template.update(sql, productId);
    }

    /**
     * 상품 복구
     */
    public void recoverProduct(int productId) {
        String sql = "UPDATE Product SET check_product = TRUE " +
                "WHERE product_id = ?";
        template.update(sql, productId);
    }

    /**
     * 상품 수정
     */
    public void updateProduct(Product product) {
        String sql = "UPDATE Product SET name = ?, code = ?, " +
                "category_id = ?, sell_price = ?, register_date = NOW() " +
                "WHERE product_id = ?";
        template.update(sql,
                product.getName(),
                product.getCode(),
                product.getCategoryId(),
                product.getSellPrice(),
                product.getProductId()
        );
    }

}
