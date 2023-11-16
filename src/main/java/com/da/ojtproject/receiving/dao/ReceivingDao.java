package com.da.ojtproject.receiving.dao;

import com.da.ojtproject.receiving.domain.Receiving;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class ReceivingDao {

    private JdbcTemplate template;

    public ReceivingDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
    }

    /**
     * 현재 날짜 yyyy-MM-dd 형태로 date format
     */
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   // yyyy-MM-dd HH:mm:ss
    String format = formatter.format(date);

    /**
     * 기본 전체 조회
     */
    public List<Receiving> getAllReceiving() {
        String sql = "SELECT " +
                "receiving_id, " +
                "receiving.quantity, " +
                "receiving.description, " +
                "receiving.register_date, " +
                "receiving.check_receiving, " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.image, " +
                "product.sell_price, " +
                "product.check_product, " +
                "inventory.quantity, " +
                "category.category_id, " +
                "category.name, " +
                "category.check_category " +
                "FROM receiving " +
                "INNER JOIN product " +
                "ON receiving.product_id = product.product_id " +
                "INNER JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "WHERE 1 = 1 " +
                "AND DATE(receiving.register_date) = '" + format + "' " +
                "ORDER BY receiving.register_date DESC";
        return template.query(sql, new ReceivingRowMapper());
    }

    /**
     * 조건 검색
     */
    public List<Receiving> getSelectReceiving(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " +
                "receiving_id, " +
                "receiving.quantity, " +
                "receiving.description, " +
                "receiving.register_date, " +
                "receiving.check_receiving, " +
                "product.product_id, " +
                "product.name, " +
                "product.code, " +
                "product.image, " +
                "product.sell_price, " +
                "product.check_product, " +
                "inventory.quantity, " +
                "category.category_id, " +
                "category.name, " +
                "category.check_category " +
                "FROM receiving " +
                "INNER JOIN product " +
                "ON receiving.product_id = product.product_id " +
                "INNER JOIN inventory " +
                "ON product.product_id = inventory.product_id " +
                "INNER JOIN category " +
                "ON product.category_id = category.category_id " +
                "WHERE 1 = 1 ");

        sb.append("AND DATE(receiving.register_date) BETWEEN '" + data.get("startDate") + "' AND '" + data.get("endDate") + "'");
        /**
         * option 상품 or 입고번호 검색
         */
        if (data.get("option").equals("product")) {
            if (data.get("checkName").equals("Y")) {
                sb.append("AND fn_choSearch(Product.name) LIKE CONCAT('%', '" + data.get("name") + "', '%')");
            } else {
                sb.append("AND Product.name LIKE'%" + data.get("name") + "%'");
            }
        } else {
            sb.append("AND receiving.receiving_id LIKE'%" + data.get("name") + "%'");
        }

        /**
         * 등록일자 별 정렬
         */
        if (data.get("order").equals("asc")) {
            sb.append("ORDER BY receiving.register_date ASC ");
        } else {
            sb.append("ORDER BY receiving.register_date DESC ");
        }
        String sql = sb.toString();
        return template.query(sql, new ReceivingRowMapper());
    }

    /**
     * 입고 등록
     */
    public void saveReceiving(Receiving receiving) {
        String sql = "INSERT INTO receiving (product_id, quantity, description)" +
                "VALUES(?,?,?)";
        template.update(sql, receiving.getProductId(), receiving.getQuantity(), receiving.getDescription());
    }

    /**
     * 입고 수정
     */
    public void updateReceiving(Receiving receiving) {
        String sql = "UPDATE receiving SET check_receiving = FALSE " +
                "WHERE receiving_id = ?";
        template.update(sql, receiving.getReceivingId());
    }
}
