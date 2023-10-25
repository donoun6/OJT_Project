package com.da.ojtproject.admin.dao;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
@RequiredArgsConstructor
public class AdminDao {

    private final JdbcTemplate tmeTemplate;

    public void saveAdmin(String passWord) {
        String sql = "INSERT INTO daojt.admin (password)" +
                "VALUES (?)";
        tmeTemplate.update(sql,passWord);
    }
}
