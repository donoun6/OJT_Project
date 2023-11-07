package com.da.ojtproject.receiving.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.receiving.domain.Receiving;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReceivingRowMapper implements RowMapper<Receiving> {

    /**
     * RowMapper override
     * @param rs     the {@code ResultSet} to map (pre-initialized for the current row)
     * @param rowNum the number of the current row
     * @return
     * @throws SQLException
     */
    @Override
    public Receiving mapRow(ResultSet rs, int rowNum) throws SQLException {
        Receiving receiving = new Receiving();
        Product product = new Product();
        Inventory inventory = new Inventory();
        Category category = new Category();
        receiving.setReceivingId(rs.getInt("receiving_id"));
        receiving.setQuantity(rs.getInt("quantity"));
        receiving.setDescription(rs.getString("description"));
        receiving.setRegisterDate(rs.getTimestamp("receiving.register_date"));
        receiving.setCheckReceiving(rs.getBoolean("check_receiving"));
        product.setProductId(rs.getInt("product_id"));
        product.setName(rs.getString("product.name"));
        product.setCode(rs.getString("code"));
        product.setCheckProduct(rs.getBoolean("check_product"));
        product.setImage(rs.getString("image"));
        product.setSellPrice(rs.getInt("sell_price"));
        inventory.setQuantity(rs.getInt("inventory.quantity"));
        category.setCategoryId(rs.getInt("category_id"));
        category.setName(rs.getString("category.name"));
        category.setCheckCategory(rs.getBoolean("check_category"));
        receiving.setProduct(product);
        receiving.setInventory(inventory);
        receiving.setCategory(category);
        return receiving;
    }
}
