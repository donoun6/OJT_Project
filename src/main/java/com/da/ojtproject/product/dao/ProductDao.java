package com.da.ojtproject.product.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Repository
@Transactional
@RequiredArgsConstructor
public class ProductDao {

    private final JdbcTemplate template;

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
                "inventory.inventory_id, " +
                "inventory.quantity, " +
                "IFNULL(SUM(selling.selling_id), 0) AS selling_id, " +
                "IFNULL(SUM(selling.quantity), 0) AS selling_quantity, " +
                "IFNULL(SUM(selling.total_price), 0) AS total_price " +
                "FROM product " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "INNER JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "LEFT JOIN selling " +
                "ON product.product_id = selling.product_id " +
                "WHERE product.check_product = true " +
                "AND category.check_category = true " +
                "GROUP BY product.product_id, product.name, product.code, product.sell_price, " +
                "product.image, product.category_id, category.name, " +
                "inventory.inventory_id, inventory.quantity";
        return template.query(sql, new ProductListRowMapper());
    };

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
                "inventory.inventory_id, " +
                "inventory.quantity, " +
                "IFNULL(SUM(selling.selling_id), 0) AS selling_id, " +
                "IFNULL(SUM(selling.quantity), 0) AS selling_quantity, " +
                "IFNULL(SUM(selling.total_price), 0) AS total_price " +
                "FROM product " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "INNER JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "LEFT JOIN selling " +
                "ON product.product_id = selling.product_id " +
                "WHERE product.check_product = true " +
                "AND category.check_category = true ");
        if(data.get("checkName").equals("Y")) {
            sb.append("AND fn_choSearch(Product.name) LIKE CONCAT('%', '"+data.get("name")+"', '%')");
        } else {
            sb.append("AND Product.name LIKE'%"+data.get("name")+"%'" );
        }
        if(!data.get("category").equals("all") ) {
            sb.append("AND product.category_id = "+data.get("category")+" ");
        }
        sb.append("GROUP BY product.product_id, product.name, product.code, product.sell_price, " +
                "product.image, product.category_id, category.name, " +
                "inventory.inventory_id, inventory.quantity");
        String sql = sb.toString();
        return template.query(sql, new ProductListRowMapper());
    };

    public List<Category> getAllCategory() {
        String sql = "SELECT * FROM Category " +
                "WHERE check_category = TRUE";
        return template.query(sql, (rs, rowNum) -> {
            Category category = new Category();
            category.setCategoryId(rs.getInt("category_id"));
            category.setName(rs.getString("name"));
            category.setCheckCategory(rs.getBoolean("check_category"));
            category.setRegisterDate(rs.getTimestamp("register_date"));
            return category;
        });
    };

}
