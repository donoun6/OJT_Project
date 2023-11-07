package com.da.ojtproject.orders.dao;

import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
@RequiredArgsConstructor
public class OrdersDao {

    private final JdbcTemplate template;
//
//    public Order getOrder(String impUid) throws DataAccessException {
//        String sql = "SELECT * FROM orders WHERE imp_uid = ?";
//        return jdbcTemplate.queryForObject(sql, new Object[]{impUid}, new OrderRowMapper());
//    }
//
//    // 이 RowMapper는 결과를 Order 객체로 변환합니다. 실제 DB의 칼럼에 맞게 수정해야 합니다.
//    private static class OrderRowMapper implements RowMapper<Order> {
//        @Override
//        public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
//            Order order = new Order();
//            order.setId(rs.getLong("id"));
//            order.setImpUid(rs.getString("imp_uid"));
//            // 기타 필드 매핑...
//            return order;
//        }
//    }
}
