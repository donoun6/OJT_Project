package com.da.ojtproject.selling.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
@RequiredArgsConstructor
public class SellingDao {

    private final JdbcTemplate template;

    /**
     * 현재 날짜 yyyy-MM-dd 형태로 date format
     */
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   // yyyy-MM-dd HH:mm:ss
    String format = formatter.format(date);

    /**
     * 초기 현재 날짜 조회
     */
    public List<Selling> getAllSelling() {
        String sql = "SELECT " +
                "selling.selling_id, " +
                "selling.quantity, " +
                "selling.total_price, " +
                "selling.check_selling, " +
                "selling.register_date, " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.sell_price, " +
                "product.image, " +
                "product.check_product, " +
                "category.category_id, " +
                "category.name, " +
                "category.check_category, " +
                "orders.orders_id, " +
                "orders.check_orders " +
                "FROM selling " +
                "INNER JOIN product " +
                "ON selling.product_id = product.product_id " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "INNER JOIN orders " +
                "ON selling.orders_id = orders.orders_id " +
                "WHERE 1 = 1 " +
                "AND DATE(selling.register_date) = '" + format + "' " +
                "AND selling.check_selling = true " +
                "AND orders.check_orders = true " +
                "ORDER BY selling.register_date DESC ";
        return template.query(sql, new SellingRowMapper());
    }

    /**
     * 조건 검색
     */
    public List<Selling> getSelectSelling(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " +
                "selling.selling_id, " +
                "selling.quantity, " +
                "selling.total_price, " +
                "selling.check_selling, " +
                "selling.register_date, " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.sell_price, " +
                "product.image, " +
                "product.check_product, " +
                "category.category_id, " +
                "category.name, " +
                "category.check_category, " +
                "orders.orders_id, " +
                "orders.check_orders " +
                "FROM selling " +
                "INNER JOIN product " +
                "ON selling.product_id = product.product_id " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "INNER JOIN orders " +
                "ON selling.orders_id = orders.orders_id " +
                "WHERE 1= 1 " +
                "AND orders.check_orders = true " +
                "AND selling.check_selling = true ");
        /**
         * startDate : 시작 날짜
         * endDate : 종료 날짜
         * 범위 지정 검색
         */
        if (!data.get("startDate").equals("N") && !data.get("endDate").equals("N")) {
            sb.append("AND DATE(selling.register_date) BETWEEN '" + data.get("startDate") + "' AND '" + data.get("endDate") + "' ");
        }
        /**
         * 상품명 검색
         */
        if (data.get("checkName").equals("Y")) {
            sb.append("AND fn_choSearch(Product.name) LIKE CONCAT('%', '" + data.get("name") + "', '%') ");
        } else {
            sb.append("AND Product.name LIKE'%" + data.get("name") + "%' ");
        }
        /**
         * column 별 정렬
         */
        if (data.get("order").equals("")) {
            sb.append("ORDER BY selling.register_date DESC ");
        } else {
            sb.append("ORDER BY " + data.get("col") + " " + data.get("order"));
        }
        String sql = sb.toString();
        return template.query(sql, new SellingRowMapper());
    }

    /**
     * 묶음 조회
     */
    public List<Selling> getSelectBundleSelling(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.sell_price, " +
                "product.image, " +
                "product.check_product, " +
                "category.name, " +
                "category.check_category, " +
                "SUM(selling.quantity) as quantity, " +
                "SUM(selling.total_price) as total_price " +
                "FROM selling " +
                "INNER JOIN product " +
                "ON selling.product_id = product.product_id " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "INNER JOIN orders " +
                "ON selling.orders_id = orders.orders_id " +
                "WHERE 1 = 1 " +
                "AND orders.check_orders = true " +
                "AND selling.check_selling = true ");
        /**
         * startDate : 시작 날짜
         * endDate : 종료 날짜
         * 범위 지정 검색
         */
        if (!data.get("startDate").equals("N") && !data.get("endDate").equals("N")) {
            sb.append("AND DATE(selling.register_date) BETWEEN '" + data.get("startDate") + "' AND '" + data.get("endDate") + "' ");
        }

        /**
         * 상품명 검색
         */
        if (data.get("checkName").equals("Y")) {
            sb.append("AND fn_choSearch(Product.name) LIKE CONCAT('%', '" + data.get("name") + "', '%') ");
        } else {
            sb.append("AND Product.name LIKE'%" + data.get("name") + "%' ");
        }
        /**
         * 묶음 처리
         */
        sb.append("GROUP BY product.product_id, product.name, product.code, product.sell_price, " +
                "product.image, product.check_product, category.name, category.check_category ");
        /**
         * column 별 정렬
         */
        if (!data.get("order").equals("") && !data.get("col").equals("register_date")) {
            sb.append("ORDER BY " + data.get("col") + " " + data.get("order"));
        }
        String sql = sb.toString();
        return template.query(sql, (rs, rowNum) -> {
            Selling selling = new Selling();
            Product product = new Product();
            Category category = new Category();
            Orders orders = new Orders();
            product.setProductId(rs.getInt("product_id"));
            product.setName(rs.getString("product.name"));
            product.setCode(rs.getString("code"));
            product.setSellPrice(rs.getInt("sell_price"));
            product.setImage(rs.getString("image"));
            product.setCheckProduct(rs.getBoolean("check_product"));
            category.setName(rs.getString("category.name"));
            category.setCheckCategory(rs.getBoolean("check_category"));
            selling.setQuantity(rs.getInt("quantity"));
            selling.setTotalPrice(rs.getInt("total_price"));
            orders.setOrdersId(0);
            orders.setCheckOrders(true);
            selling.setProduct(product);
            selling.setCategory(category);
            selling.setOrders(orders);
            return selling;
        });
    }
}
