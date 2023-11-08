package com.da.ojtproject.cart.dao;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.da.ojtproject.cart.domain.Cart;
import com.da.ojtproject.product.domain.Product;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CartDao {

    private final JdbcTemplate jdbcTemplate;
    private static final String UPLOAD_DIR = "src/main/resources/static/img/";
    private SimpleJdbcCall addOrResetCategoryProcedure;
    private SimpleJdbcCall updateCategoryIfNotExistsProcedure;
    private final SimpleJdbcCall AddOrCountCart;

    public CartDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.addOrResetCategoryProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("AddOrResetCategory");
        this.updateCategoryIfNotExistsProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("UpdateCategoryIfNotExists");
        this.AddOrCountCart = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("AddOrCountCart");
    }

    public void AddOrCountCart(int productId) {
        SqlParameterSource in = new MapSqlParameterSource().addValue("param_product_id", productId);
        this.AddOrCountCart.execute(in);
    }

    public void deleteCartItem(int id) {
        String sql = "DELETE FROM Cart WHERE Cart_id = ?";
        jdbcTemplate.update(sql, id);
    }

    // *****************************************************************************
    // 이름과 사진이 나오지 않았던 이유는 일단 Cart 도메인에 product_name이 없었기 때문이고
    // 추가로 dao 부분에서 product_name을 받아왔어야 한다.
    // 생각보다 매우 중요했던 쿼리
    // *****************************************************************************
    public List<Cart> findAllCartItems() {

        String sql = "SELECT * FROM Cart";
        return jdbcTemplate.query(sql, (resultSet, rowNum) -> {

            Cart cart = new Cart();
            cart.setCartId(resultSet.getInt("Cart_id"));
            cart.setProductId(resultSet.getInt("product_id"));
            cart.setQuantity(resultSet.getInt("quantity"));
            cart.setTotalPrice(resultSet.getInt("total_price"));
            cart.setProductName(resultSet.getString("product_name"));
            cart.setImage(resultSet.getString("image"));

            return cart;
        });
    }

    // 장바구니 목록을 삭제하는 메서드. 임시입니다.
    public void deleteCart() {
        String sql = "DELETE FROM Cart";
        jdbcTemplate.update(sql);
    }

    // 장바구니 목록에서 선택한 목록의 수량을 증가시키는 메서드입니다.
    public void updateQuantity(int cartId) {
        String getPriceSQL = "SELECT sell_price FROM Product WHERE product_id = (SELECT product_id FROM Cart WHERE Cart_id = ?)";
        Integer price = jdbcTemplate.queryForObject(getPriceSQL, new Object[]{cartId}, Integer.class);

        if(price != null) {
            String sql = "UPDATE Cart SET quantity = quantity + 1, total_price = total_price + ? WHERE Cart_id = ?";
            jdbcTemplate.update(sql, price, cartId);
        }
    }

    public void decreaseQuantity(int cartId) {
        String getPriceSQL = "SELECT sell_price FROM Product WHERE product_id = (SELECT product_id FROM Cart WHERE Cart_id = ?)";
        Integer price = jdbcTemplate.queryForObject(getPriceSQL, new Object[]{cartId}, Integer.class);

        if(price != null) {
            String sql = "UPDATE Cart SET quantity = quantity - 1, total_price = total_price - ? WHERE Cart_id = ?";
            jdbcTemplate.update(sql, price, cartId);
        }
    }
    public Cart findCartItemById(int cartId) {
        String sql = "SELECT * FROM Cart WHERE Cart_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{cartId}, (resultSet, rowNum) -> {
                Cart cart = new Cart();
                cart.setCartId(resultSet.getInt("cart_id"));
                cart.setProductId(resultSet.getInt("product_id"));
                cart.setQuantity(resultSet.getInt("quantity"));
                cart.setTotalPrice(resultSet.getInt("total_price"));
                cart.setProductName(resultSet.getString("product_name"));
                cart.setImage(resultSet.getString("image"));
                return cart;
            });
        } catch (EmptyResultDataAccessException e) {
            return null; // 결과가 없는 경우 null 반환
        }
    }

}
