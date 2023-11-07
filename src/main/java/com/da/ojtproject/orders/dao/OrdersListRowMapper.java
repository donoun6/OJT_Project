package com.da.ojtproject.orders.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrdersListRowMapper implements RowMapper<Selling> {

    /**
     * RowMapper override
     * @param rs     the {@code ResultSet} to map (pre-initialized for the current row)
     * @param rowNum the number of the current row
     * @return
     * @throws SQLException
     */
    @Override
    public Selling mapRow(ResultSet rs, int rowNum) throws SQLException {
        Product product = new Product();
        Category category = new Category();
        Inventory inventory = new Inventory();
        Selling selling = new Selling();
        product.setProductId(rs.getInt("product_id"));
        product.setName(rs.getString("product.name"));
        product.setCode(rs.getString("code"));
        product.setSellPrice((rs.getInt("sell_price")));
        product.setImage(rs.getString("image"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setCheckProduct(rs.getBoolean("check_product"));
        product.setRegisterDate(rs.getTimestamp("register_date"));
        category.setName(rs.getString("category.name"));
        category.setCheckCategory(rs.getBoolean("check_category"));
        inventory.setInventoryId(rs.getInt("inventory_id"));
        inventory.setQuantity(rs.getInt("inventory.quantity"));
        selling.setSellingId(rs.getInt("selling_id"));
        selling.setQuantity(rs.getInt("selling_quantity"));
        selling.setTotalPrice(rs.getInt("total_price"));
        selling.setOrdersId(rs.getInt("orders_id"));
        product.setCategory(category);
        product.setInventory(inventory);
        product.setSelling(selling);
        return selling;
    }
}
