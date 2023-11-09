package com.da.ojtproject.orders.dao;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.dao.ProductListRowMapper;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
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

    public OrdersDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
        this.AddProductAndAddInventory = new SimpleJdbcCall(template)
                .withProcedureName("AddProductAndAddInventory");
        this.ProcessSpecificOrFullRefund = new SimpleJdbcCall(template)
                .withProcedureName("ProcessSpecificOrFullRefund");

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
}
