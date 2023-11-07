package com.da.ojtproject.inventory.dao;

import com.da.ojtproject.inventory.domain.Inventory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class InventoryDao {

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private static final String UPLOAD_DIR = "src/main/resources/static/img/";
    private SimpleJdbcCall addOrResetCategoryProcedure;
    private SimpleJdbcCall updateCategoryIfNotExistsProcedure;
    private SimpleJdbcCall AddOrCountCart;
    private SimpleJdbcCall GetInventoryByProductId;

    public InventoryDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
        this.addOrResetCategoryProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("AddOrResetCategory");
        this.updateCategoryIfNotExistsProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("UpdateCategoryIfNotExists");
        this.AddOrCountCart = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("AddOrCountCart");
        this.GetInventoryByProductId = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("GetInventoryByProductId");
    }

    public Inventory getInventoryByProductId(int productId) {
        String sql = "SELECT i.* FROM Product p INNER JOIN Inventory i ON p.product_id = i.product_id WHERE p.product_id = :productId";
        SqlParameterSource param = new MapSqlParameterSource().addValue("productId", productId);

        return namedParameterJdbcTemplate.queryForObject(sql, param, new BeanPropertyRowMapper<>(Inventory.class));
    }

}
