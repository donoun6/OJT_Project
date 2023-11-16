package com.da.ojtproject.admin.dao;

import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Map;

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

    /**
     * 일주일전 날
     */
    LocalDate currentDate = LocalDate.now();
    // 현재 날짜에서 7일을 빼기
    LocalDate oneWeekAgoLocalDate = currentDate.minusDays(7);
    // LocalDate를 Date로 변환
    String oneWeekAgo = formatter.format(Date.from(oneWeekAgoLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

    /**
     * 판매 랭크
     */
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
                "AND selling.check_selling = TRUE " +
                "GROUP BY " +
                "product.name, product.sell_price, product.image " +
                "ORDER BY quantity desc , total_price DESC " +
                "limit 5";
        return tmeTemplate.query(sql, (rs, rowNum) -> {
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

    /**
     * 판매 랭크 기간 조회
     */
    public List<Selling> getSellingRankDate(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " +
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
                "AND selling.check_selling = TRUE ");
        /**
         * startDate : 시작 날짜
         * endDate : 종료 날짜
         * 범위 지정 검색
         */
        if (!data.get("startDate").equals("") && !data.get("endDate").equals("")) {
            sb.append("AND DATE(orders.register_date) BETWEEN '" + data.get("startDate") + "' AND '" + data.get("endDate") + "'");
        }
        sb.append("GROUP BY " +
                "product.name, product.sell_price, product.image " +
                "ORDER BY quantity desc , total_price DESC " +
                "limit 10");
        String sql = sb.toString();
        return tmeTemplate.query(sql, (rs, rowNum) -> {
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

    /**
     * 판매 정보
     */
    public List<Selling> getSellingInfo() {
        String sql = "SELECT " +
                "product.name, " +
                "SUM(selling.quantity) AS quantity " +
                "FROM " +
                "selling " +
                "INNER JOIN " +
                "product ON selling.product_id = product.product_id " +
                "INNER JOIN " +
                "orders ON selling.orders_id = orders.orders_id " +
                "WHERE 1 = 1 " +
                "AND product.check_product = TRUE " +
                "AND orders.check_orders = TRUE " +
                "AND selling.check_selling = TRUE " +
                "GROUP BY " +
                "product.name ";
        return tmeTemplate.query(sql, (rs, rowNum) -> {
            Product product = new Product();
            Selling selling = new Selling();
            product.setName(rs.getString("name"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setProduct(product);
            return selling;
        });
    }

    /**
     * 판매 정보 기간 조회
     */
    public List<Selling> getSellingInfoDate(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " +
                "product.name, " +
                "SUM(selling.quantity) AS quantity " +
                "FROM " +
                "selling " +
                "INNER JOIN " +
                "product ON selling.product_id = product.product_id " +
                "INNER JOIN " +
                "orders ON selling.orders_id = orders.orders_id " +
                "WHERE 1 = 1 " +
                "AND product.check_product = TRUE " +
                "AND orders.check_orders = TRUE " +
                "AND selling.check_selling = TRUE ");
        /**
         * startDate : 시작 날짜
         * endDate : 종료 날짜
         * 범위 지정 검색
         */
        if (!data.get("startDate").equals("") && !data.get("endDate").equals("")) {
            sb.append("AND DATE(orders.register_date) BETWEEN '" + data.get("startDate") + "' AND '" + data.get("endDate") + "'");
        }
        sb.append("GROUP BY product.name ");
        String sql = sb.toString();
        return tmeTemplate.query(sql, (rs, rowNum) -> {
            Product product = new Product();
            Selling selling = new Selling();
            product.setName(rs.getString("name"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setProduct(product);
            return selling;
        });
    }

    /**
     * 금일 판매정보
     */
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
                "AND selling.check_selling = TRUE " +
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

    /**
     * 금일 매출
     */
    public Integer getTodayTotalPrice() {
        String sql = "SELECT " +
                "SUM(selling.total_price) AS total_price " +
                "FROM " +
                "selling " +
                "WHERE 1 = 1 " +
                "AND check_selling = TRUE " +
                "AND DATE (selling.register_date) = '" + format + "' ";
        return tmeTemplate.queryForObject(sql, (rs, rowNum) -> {
            Integer totalPrice = rs.getInt("total_price");
            return totalPrice;
        });
    }

    /**
     * 금일 주문건
     */
    public Integer getOrderCount() {
        String sql = "SELECT count(*) AS count FROM orders " +
                "WHERE DATE (register_date) = '" + format + "' " +
                "AND check_orders = TRUE ";
        return tmeTemplate.queryForObject(sql, (rs, rowNum) -> {
            Integer count = rs.getInt("count");
            return count;
        });
    }

    /**
     * 재고 알림
     */
    public List<Product> getLowQuantity() {
        String sql = "SELECT " +
                "name, " +
                "image,  " +
                "quantity " +
                "FROM product " +
                "INNER JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "where product.check_product =true " +
                "AND inventory.quantity <= 5";
        return tmeTemplate.query(sql, (rs, rowNum) -> {
            Product product = new Product();
            Inventory inventory = new Inventory();
            product.setName(rs.getString("name"));
            product.setImage(rs.getString("image"));
            inventory.setQuantity(rs.getInt("quantity"));
            product.setInventory(inventory);
            return product;
        });
    }

    /**
     * 날짜별 판매정보
     */
    public List<Selling> getSellingDay() {
        String sql = "SELECT " +
                "DATE(selling.register_date) AS register_date, " +
                "SUM(selling.quantity) AS quantity, " +
                "SUM(selling.total_price) AS total_price " +
                "FROM selling " +
                "INNER JOIN orders " +
                "ON selling.orders_id = orders.orders_id " +
                "WHERE selling.check_selling = TRUE " +
                "AND orders.check_orders = TRUE " +
                "AND DATE(orders.register_date) BETWEEN  '" + oneWeekAgo + "' AND '" + format + "' " +
                "GROUP BY register_date " +
                "ORDER BY register_date ";
        return tmeTemplate.query(sql, (rs, rowNum) -> {
            Selling selling = new Selling();
            selling.setRegisterDate(rs.getTimestamp("register_date"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setTotalPrice(rs.getInt("total_price"));
            selling.setTotalPriceMinimal((double) selling.getTotalPrice() / 1000);
            return selling;
        });
    }
}
