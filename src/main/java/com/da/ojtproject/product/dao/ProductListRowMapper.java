package com.da.ojtproject.product.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductListRowMapper implements RowMapper<Product> {

    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
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
        inventory.setInventoryId(rs.getInt("inventory_id"));
        inventory.setQuantity(rs.getInt("inventory.quantity"));
        selling.setSellingId(rs.getInt("selling_id"));
        selling.setQuantity(rs.getInt("selling_quantity"));
        selling.setTotalPrice(rs.getInt("total_price"));
        product.setCategory(category);
        product.setInventory(inventory);
        product.setSelling(selling);
        return product;
    }
}
