package com.da.ojtproject.orders.dao;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;

@Repository
@Transactional
public class OrdersDao {

    private final JdbcTemplate template;
    private SimpleJdbcCall AddProductAndAddInventory;
    private SimpleJdbcCall ProcessSpecificOrFullRefund;

    private SimpleJdbcCall ProcessRefundCancellation;

    private SimpleJdbcCall ProcessSpecificOrFullRefund2;

    private SimpleJdbcCall ProcessSpecificOrFullRefund3;

    public OrdersDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
        this.AddProductAndAddInventory = new SimpleJdbcCall(template)
                .withProcedureName("AddProductAndAddInventory");
        this.ProcessSpecificOrFullRefund = new SimpleJdbcCall(template)
                .withProcedureName("ProcessSpecificOrFullRefund");
        this.ProcessSpecificOrFullRefund2 = new SimpleJdbcCall(template)
                .withProcedureName("ProcessSpecificOrFullRefund2");
        this.ProcessRefundCancellation = new SimpleJdbcCall(template)
                .withProcedureName("ProcessRefundCancellation");
        this.ProcessSpecificOrFullRefund3 = new SimpleJdbcCall(template)
                .withProcedureName("ProcessSpecificOrFullRefund3");

    }
    public List<Orders> getAllOrdersProducts() {
        String sql = "SELECT * FROM Orders";
        return template.query(sql, new OrdersRowMapper());
    }

    public List<Selling> findSellingsByOrdersId(int ordersId) {
        // JOIN을 사용하여 Selling과 Product 테이블을 연결하고, 필요한 정보를 선택합니다.
        String sql = "SELECT s.selling_id, s.product_id, s.orders_id, s.quantity, s.total_price, " +
                "s.check_selling, s.register_date, p.name AS product_name " +
                "FROM Selling s " +
                "JOIN Product p ON s.product_id = p.product_id " +
                "WHERE s.orders_id = ?";

        return template.query(sql, new Object[]{ordersId}, sellingRowMapper());
    }

    private RowMapper<Selling> sellingRowMapper() {
        return (rs, rowNum) -> {
            Selling selling = new Selling();
            Product product = new Product();
            selling.setSellingId(rs.getInt("selling_id"));
            selling.setProductId(rs.getInt("product_id"));
            selling.setOrdersId(rs.getInt("orders_id"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setTotalPrice(rs.getInt("total_price"));
            selling.setCheckSelling(rs.getBoolean("check_selling"));
            selling.setRegisterDate(rs.getTimestamp("register_date"));
            // Product 객체에 상품명을 설정합니다.
            product.setName(rs.getString("product_name"));
            // Selling 객체에 Product 객체를 설정합니다.
            selling.setProduct(product);
            return selling;
        };
    }

    public boolean refundAll(int ordersId) {
        SqlParameterSource inParams = new MapSqlParameterSource()
                .addValue("input_orders_id", ordersId)
                .addValue("input_product_id", null); // 전체 환불을 위해 product_id에 null 전달
        // 프로시저 실행
        ProcessSpecificOrFullRefund.execute(inParams);
        // 결과 처리 로직이 필요합니다. 성공 여부에 따라 true 또는 false를 반환합니다.
        return true;
    }

    // 전체 환불 취소 함수
    public boolean refundAllCancel(int ordersId3) {
        SqlParameterSource inParams = new MapSqlParameterSource()
                .addValue("input_orders_id", ordersId3)
                .addValue("input_product_id", null); // 전체 환불 취소를 위해 product_id에 null값을 전달합니다.
        ProcessRefundCancellation.execute(inParams);

        // 결과 처리 로직이 필요합니다. 성공 여부에 따라 true 또는 false를 반환합니다.
        return true;
    }

    public boolean partialRefund(int ordersId, int productId) {
        SqlParameterSource inParams = new MapSqlParameterSource()
                .addValue("input_orders_id", ordersId)
                .addValue("input_product_id", productId);
        // 부분환불 프로시저를 우선 실행해보자.
        ProcessSpecificOrFullRefund.execute(inParams);
        // 일부분만 부분환불만 진행해도 계속해서 그 다음 ProcessSpecificOrFullRefund2 프로시저를 불러온다.
        // 과부하가 일어날 수 있지만 동시에 현재 내 실력으로는 이게 최상이다.
        // 그다음에 전체 환불 프로시저를 실행해본다.
        ProcessSpecificOrFullRefund2.execute(ordersId);
        // 부분환불 결과 처리 로직입니다. fullRefund와 마찬가지로 파라미터값을 inParams 값으로 넘겨줘야 합니다.
        return true;
    }

    public boolean partialRefundCancel(int ordersId4, int productId4) {
        SqlParameterSource inParams = new MapSqlParameterSource()
                .addValue("input_orders_id", ordersId4)
                .addValue("input_product_id", productId4);

        // 부분환불 프로시저를 우선 실행해보자.
        ProcessRefundCancellation.execute(inParams);

        // 일부분만 부분환불만 진행해도 계속해서 그 다음 ProcessSpecificOrFullRefund2 프로시저를 불러온다.
        // 과부하가 일어날 수 있지만 동시에 현재 내 실력으로는 이게 최상이다.
        // 그다음에 전체 환불 프로시저를 실행해본다.
        // ProcessSpecificOrFullRefund2.execute(ordersId4);

        ProcessSpecificOrFullRefund3.execute(ordersId4);

        // 부분환불 결과 처리 로직입니다. fullRefund와 마찬가지로 파라미터값을 inParams 값으로 넘겨줘야 합니다.
        return true;
    }

    // 주문 목록을 날짜별로 정렬하는 메서드
    public List<Orders> sortOrdersByDate(String order) {
        String sql;
        if ("desc".equals(order)) {
            sql = "SELECT * FROM Orders ORDER BY register_date DESC"; // 내림차순 정렬
        } else {
            sql = "SELECT * FROM Orders ORDER BY register_date ASC"; // 오름차순 정렬 (기본값)
        }
        return template.query(sql, new OrdersRowMapper());
    }
}
