package com.da.ojtproject.category.dao;

import com.da.ojtproject.category.domain.Category;
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
public class CategoryDao {
    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall addOrResetCategoryProcedure;
    private SimpleJdbcCall updateCategoryIfNotExistsProcedure;

    public CategoryDao(DataSource dataSource) {

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
    public List<Category> findAllCategories() {
        String sql = "SELECT * FROM Category";
        return jdbcTemplate.query(sql, (resultSet, rowNum) -> {
            Category category = new Category();
            try {

                category.setCategoryId(resultSet.getInt("category_id"));
                category.setName(resultSet.getString("name"));
                category.setCheckCategory(resultSet.getBoolean("check_category"));
                category.setRegisterDate(resultSet.getTimestamp("register_date"));

            } catch (SQLException e) {

                e.printStackTrace();

            }

            return category;

        });
    }

    public void deleteCategory(int id) {
    }

//     모든 상품의 리스트를 출력하는 메서드
//    public List<Product> getAllProducts() {
//        String sql = "SELECT * FROM product";
//        return template.query(sql, (resultSet, rowNum) -> {
//            Product product = new Product();
//            try {
//                product.setProductId(resultSet.getInt("product_id"));
//                product.setCategoryId(resultSet.getInt("category_id"));
//                product.setName(resultSet.getString("name"));
//                product.setCode(resultSet.getString("code"));
//                product.setSellPrice(resultSet.getInt("sell_price"));
//                product.setImage(resultSet.getString("image"));
//                product.setCheckProduct(resultSet.getBoolean("check_product"));
//                product.setRegisterDate(resultSet.getTimestamp("register_date"));
//
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//            return product;
//        });
//    }


}
