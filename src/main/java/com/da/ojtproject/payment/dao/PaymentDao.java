package com.da.ojtproject.payment.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;

@Repository
@Transactional
public class PaymentDao {

    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall AddSellingAndClearCart;




    public PaymentDao(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.AddSellingAndClearCart = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("AddSellingAndClearCart");
    }

    public boolean addSellingAndClearCart() {
        try {
            AddSellingAndClearCart.execute(); // 프로시저 호출
            return true;
        } catch (Exception e) {
            e.printStackTrace(); // 예외 정보를 출력합니다. 실제 프로덕션에서는 적절한 로깅을 해야 합니다.
            return false;
        }
    }

    public int getLastOrderNumber() {
        String sql = "SELECT MAX(orders_id) FROM Orders";
        Integer lastOrderId = jdbcTemplate.queryForObject(sql, Integer.class);
        return (lastOrderId != null) ? lastOrderId : 43102; // 주문이 없는 경우 0을 반환
    }
}