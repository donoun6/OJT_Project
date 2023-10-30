package com.da.ojtproject.product.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// RestAPI로 CRUD를 구현한다고 해도 DAO 는 일반적인 컨트롤러를 사용했을때와 차이점이 없다는것이 매우 신기했다.
@Repository
@Transactional
public class ProductDao {

    private final JdbcTemplate template;

    private SimpleJdbcCall addOrResetCategoryProcedure;
    private SimpleJdbcCall updateCategoryIfNotExistsProcedure;

    public ProductDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
        this.addOrResetCategoryProcedure = new SimpleJdbcCall(template)
                .withProcedureName("AddOrResetCategory");
        this.updateCategoryIfNotExistsProcedure = new SimpleJdbcCall(template)
                .withProcedureName("UpdateCategoryIfNotExists");
    }

    // 관리자가 상품을 등록합니다.
    public void saveProduct(Product product) {

        String sql = "INSERT INTO product (product_id, category_id, name, code, sell_price, image, check_product, register_date) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        template.update(sql, product.getProductId(), product.getCategoryId(), product.getName(), product.getCode(), product.getSellPrice(), product.getImage(), product.isCheckProduct());

    }

    public Product getProductById(int productId) {
        String sql = "SELECT * FROM product WHERE product_id = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), productId);
    }


    // 모든 상품의 리스트를 출력하는 메서드
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM product";
        return template.query(sql, (resultSet, rowNum) -> {
            Product product = new Product();
            try {
                product.setProductId(resultSet.getInt("product_id"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setName(resultSet.getString("name"));
                product.setCode(resultSet.getString("code"));
                product.setSellPrice(resultSet.getInt("sell_price"));
                product.setImage(resultSet.getString("image"));
                product.setCheckProduct(resultSet.getBoolean("check_product"));
                product.setRegisterDate(resultSet.getTimestamp("register_date"));

            } catch (SQLException e) {
                e.printStackTrace();
            }

            return product;

        });

    }

    // 관리자가 상품을 업데이트 합니다.
    public void updateProduct(Product product) {

        String sql = "UPDATE product SET categoryId = ?, name = ?, code = ?, sellPrice = ?, image = ?, checkProduct = ?, registerDate = ? WHERE productId = ?";
        template.update(sql, product.getCategoryId(), product.getName(), product.getCode(), product.getSellPrice(), product.getImage(), product.isCheckProduct(), product.getRegisterDate(), product.getProductId());

    }

    public void deleteProduct(int productId) {

        String sql = "DELETE FROM product WHERE product_id = ?";
        template.update(sql, productId);

    }

}
