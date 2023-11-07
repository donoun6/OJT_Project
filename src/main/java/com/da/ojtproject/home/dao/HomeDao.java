package com.da.ojtproject.home.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.home.domain.Home;
import com.da.ojtproject.product.domain.Product;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class HomeDao {
    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall addOrResetCategoryProcedure;
    private SimpleJdbcCall updateCategoryIfNotExistsProcedure;

    public HomeDao(DataSource dataSource) {

        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.addOrResetCategoryProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("AddOrResetCategory");
        this.updateCategoryIfNotExistsProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("UpdateCategoryIfNotExists");

    }



    // 카테고리 목록을 추가하는 메서드(하지만 동일이름이면 새롭게 업데이트 되는것을 방지합니다)
    public void addOrResetCategory(String categoryName) {

        Map<String, Object> params = new HashMap<>();
        params.put("param_name", categoryName);
        addOrResetCategoryProcedure.execute(params);

    }

    // 카테고리 이름을 수정하는 메서드 (프로시저 사용)
    public void editCategoryName(String oldName, String newName) {

        Map<String, Object> params = new HashMap<>();
        params.put("old_name", oldName);
        params.put("new_name", newName);
        updateCategoryIfNotExistsProcedure.execute(params);

    }

    // 모든 카테고리 목록을 출력하는 메서드(현재 존재하는 모든 카테고리 목록을 출력하는 메서드입니다.)
    public List<Home> findAllCategories() {
        String sql = "SELECT * FROM Category";
        return jdbcTemplate.query(sql, (resultSet, rowNum) -> {
            Home home = new Home();
            try {

                home.setCategoryId(resultSet.getInt("category_id"));
                home.setName(resultSet.getString("name"));
                home.setCheckCategory(resultSet.getBoolean("check_category"));
                home.setRegisterDate(resultSet.getTimestamp("register_date"));

            } catch (SQLException e) {

                e.printStackTrace();

            }

            return home;

        });
    }

    public List<Product> findItemsOfFirstCategory() {
        String sql = "SELECT p.*, i.quantity FROM Product p " +
                "LEFT JOIN inventory i ON p.product_id = i.product_id " +
                "WHERE p.category_id = ?";
        int firstCategoryId = 1; // 첫 번째 카테고리의 ID (실제 ID에 따라 변경해야 합니다.)
        return jdbcTemplate.query(sql, new Object[]{firstCategoryId}, (resultSet, rowNum) -> {
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
                product.setQuantity(resultSet.getInt("quantity"));  // 이 부분을 추가
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return product;
        });
    }

    // 해당 카테고리의 제품 목록을 가져오는 메서드
    // 재고가 없는 상품을 조회하기 위해 inventory 메서드의 quantity 컬럼이 필요하다.
    // 해당 카테고리의 제품 목록을 가져오는 메서드
    // 재고가 없는 상품을 조회하기 위해 inventory 메서드의 quantity 컬럼이 필요하다.
    public List<Product> findProductsByCategoryId(int categoryId) {
        String sql = "SELECT p.*, i.quantity FROM Product p " +
                "LEFT JOIN inventory i ON p.product_id = i.product_id " +
                "WHERE p.category_id = ?";
        return jdbcTemplate.query(sql, new Object[]{categoryId}, (resultSet, rowNum) -> {
            Product product = new Product();
            product.setProductId(resultSet.getInt("product_id"));
            product.setCategoryId(resultSet.getInt("category_id"));
            product.setName(resultSet.getString("name"));
            product.setCode(resultSet.getString("code"));
            product.setSellPrice(resultSet.getInt("sell_price"));
            product.setImage(resultSet.getString("image"));
            product.setCheckProduct(resultSet.getBoolean("check_product"));
            product.setRegisterDate(resultSet.getTimestamp("register_date"));
            product.setQuantity(resultSet.getInt("quantity"));  // 이 부분을 추가
            return product;
        });
    }
}
