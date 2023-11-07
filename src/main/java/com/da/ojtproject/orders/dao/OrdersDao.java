package com.da.ojtproject.orders.dao;

import com.da.ojtproject.product.dao.ProductListRowMapper;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;

@Repository
@Transactional
public class OrdersDao {

    private final JdbcTemplate template;
    private SimpleJdbcCall AddProductAndAddInventory;

    public OrdersDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
        this.AddProductAndAddInventory = new SimpleJdbcCall(template)
                .withProcedureName("AddProductAndAddInventory");
    }
    public List<Product> getAllOrdersProducts() {
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
                "selling.orders_id, " +
                "IFNULL(SUM(selling.selling_id), 0) AS selling_id, " +
                "IFNULL(SUM(selling.quantity), 0) AS selling_quantity, " +
                "IFNULL(SUM(selling.total_price), 0) AS total_price " +
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
}
