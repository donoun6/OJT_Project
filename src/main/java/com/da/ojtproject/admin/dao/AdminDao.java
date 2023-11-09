package com.da.ojtproject.admin.dao;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.dao.SellingRowMapper;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Repository
@Transactional
@RequiredArgsConstructor
public class AdminDao {

    private final JdbcTemplate tmeTemplate;

    /**
     * 현재 날짜 yyyy-MM-dd 형태로 date format
     */
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   // yyyy-MM-dd HH:mm:ss
    String format = formatter.format(date);

    public List<Selling> getSellingRank() {
        String sql = "SELECT " +
                "product.name, " +
                "product.image, " +
                "SUM(selling.quantity) AS quantity, " +
                "SUM(selling.total_price) AS total_price " +
                "FROM " +
                "selling " +
                "INNER JOIN " +
                "product ON selling.product_id = product.product_id " +
                "INNER JOIN " +
                "category ON product.category_id = category.category_id " +
                "INNER JOIN " +
                "orders ON selling.orders_id = orders.orders_id " +
                "WHERE 1 = 1 " +
                "AND product.check_product = TRUE " +
                "GROUP BY " +
                "product.name, product.sell_price, product.image " +
                "ORDER BY quantity desc , total_price DESC " +
                "limit 10;";
        return tmeTemplate.query(sql,(rs, rowNum) -> {
            Product product = new Product();
            Selling selling = new Selling();
            product.setName(rs.getString("name"));
            product.setImage(rs.getString("image"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setTotalPrice(rs.getInt("total_price"));
            selling.setProduct(product);
            return selling;
        });
    }

    public List<Orders> getTodayOrders() {
        String sql = "SELECT " +
                "orders.orders_id, " +
                "SUM(selling.quantity) as quantity, " +
                "SUM(selling.total_price) as total_price, " +
                "orders.register_date " +
                "FROM orders " +
                "INNER JOIN selling " +
                "ON orders.orders_id = selling.orders_id " +
                "where orders.check_orders = TRUE " +
                "AND DATE (orders.register_date) = '" + format + "' " +
                "GROUP BY orders.orders_id " +
                "ORDER BY orders.register_date DESC ";
        return tmeTemplate.query(sql, (rs, rowNum) -> {
            Orders orders = new Orders();
            Selling selling = new Selling();
            orders.setOrdersId(rs.getInt("orders_id"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setTotalPrice(rs.getInt("total_price"));
            orders.setRegisterDate(rs.getTimestamp("register_date"));
            orders.setSelling(selling);
            return orders;
        });
    }

    public Selling getTodayTotalPrice() {
        String sql = "SELECT " +
                "SUM(selling.total_price) AS total_price " +
                "FROM " +
                "selling " +
                "WHERE 1 = 1 " +
                "AND check_selling = TRUE " +
                "AND DATE (selling.register_date) = '"+ format +"' ";
        return tmeTemplate.queryForObject(sql,(rs, rowNum) -> {
            Selling selling = new Selling();
            selling.setTotalPrice(rs.getInt("total_price"));
            return selling;
        });
    }

    public Integer getOrderCount() {
        String sql = "SELECT count(*) AS count FROM orders";
        return tmeTemplate.queryForObject(sql,(rs, rowNum) -> {
            Integer count = rs.getInt("count");
            return count;
        });
    }


}
