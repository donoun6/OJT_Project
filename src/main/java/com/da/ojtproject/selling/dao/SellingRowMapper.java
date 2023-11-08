package com.da.ojtproject.selling.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SellingRowMapper implements RowMapper<Selling> {
    /**
     * rowMapper
     * @param rs     the {@code ResultSet} to map (pre-initialized for the current row)
     * @param rowNum the number of the current row
     * @return
     * @throws SQLException
     */
    @Override
    public Selling mapRow(ResultSet rs, int rowNum) throws SQLException {
        Selling selling = new Selling();
        Product product = new Product();
        Category category = new Category();
        Orders orders = new Orders();
        selling.setSellingId(rs.getInt("selling_id"));
        selling.setQuantity(rs.getInt("quantity"));
        selling.setTotalPrice(rs.getInt("total_price"));
        selling.setCheckSelling(rs.getBoolean("check_selling"));
        selling.setRegisterDate(rs.getTimestamp("register_date"));
        product.setProductId(rs.getInt("product_id"));
        product.setName(rs.getString("product.name"));
        product.setCode(rs.getString("code"));
        product.setSellPrice(rs.getInt("sell_price"));
        product.setImage(rs.getString("image"));
        product.setCheckProduct(rs.getBoolean("check_product"));
        category.setCategoryId(rs.getInt("category_id"));
        category.setName(rs.getString("category.name"));
        category.setCheckCategory(rs.getBoolean("check_category"));
        orders.setOrdersId(rs.getInt("orders_id"));
        orders.setCheckOrders(rs.getBoolean("check_orders"));
        selling.setProduct(product);
        selling.setCategory(category);
        selling.setOrders(orders);
        return selling;
    }
}
