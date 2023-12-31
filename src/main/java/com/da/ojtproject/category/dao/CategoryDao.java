package com.da.ojtproject.category.dao;

import com.da.ojtproject.category.domain.Category;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;

@Repository
@Transactional
public class CategoryDao {
    private final JdbcTemplate template;
    private SimpleJdbcCall addOrResetCategoryProcedure;

    /**
     * bean 객체 등록 생성자 주입
     */
    public CategoryDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
        this.addOrResetCategoryProcedure = new SimpleJdbcCall(template)
                .withProcedureName("AddOrResetCategory");
    }

    /**
     * 전체 category 반환
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
    }

    /**
     * 카테고리 저장 Or 재활용
     */
    public void addOrResetCategory(Category category) {
        addOrResetCategoryProcedure.execute(category.getName());
    }

    /**
     * 카테고리 삭제 처리
     */
    public void deleteCategory(int categoryId) {
        String sql = "UPDATE Category set check_category = FALSE " +
                "WHERE category_id = ?";
        template.update(sql, categoryId);
    }

    /**
     * 카테고리 복구
     */
    public void recoverCategory(int categoryId) {
        String sql = "UPDATE Category set check_category = TRUE " +
                "WHERE category_id = ?";
        template.update(sql, categoryId);
    }

}
