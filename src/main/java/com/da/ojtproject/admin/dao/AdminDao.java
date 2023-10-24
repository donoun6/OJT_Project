package com.da.ojtproject.admin.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;

@Repository
@Transactional
public class AdminDao {

    private final JdbcTemplate jdbcTemplate;

    public AdminDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public void saveAdmin(String passWord) {
        String sql = "INSERT INTO admin (password)\n" +
                "VALUES (?)";
        jdbcTemplate.update(sql,passWord);
    }
}
