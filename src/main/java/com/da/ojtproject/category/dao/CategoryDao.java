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
    private final JdbcTemplate template;
    private SimpleJdbcCall addOrResetCategoryProcedure;

    public CategoryDao(DataSource dataSource) {

        this.template = new JdbcTemplate(dataSource);
        this.addOrResetCategoryProcedure = new SimpleJdbcCall(template)
                .withProcedureName("AddOrResetCategory");
    }

    /**
     * 전체 category 반환
     * @return category
     */
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

    /**
     * 카테고리 저장 Or 재활용
     * @param category
     */
    public void addOrResetCategory(Category category) {
        addOrResetCategoryProcedure.execute(category.getName());
    }

    /**
     * 카테고리 삭제 처리
     */
    public void deleteCateogory(int categoryId) {
        String sql = "UPDATE Category set check_category = FALSE " +
                "WHERE category_id = ?";
        template.update(sql,categoryId);
    }

}
