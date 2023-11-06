package com.da.ojtproject.receiving.dao;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.receiving.domain.Receiving;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class ReceivingDao {

    private JdbcTemplate template;

    public ReceivingDao(DataSource dataSource) {
        this.template = new JdbcTemplate(dataSource);
    }

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
                "ORDER BY receiving.register_date DESC";
        return template.query(sql, new ReceivingRowMapper());
    }

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
        /**
         * startDate : 시작 날짜
         * endDate : 종료 날짜
         * 범위 지정 검색
         */
        if (!data.get("startDate").equals("N") && !data.get("endDate").equals("N")) {
            sb.append("AND DATE(receiving.register_date) BETWEEN '" + data.get("startDate") + "' AND '" + data.get("endDate") + "'");
        }
        /**
         * 상품 검색 or 입고번호 검색
         */
        if (data.get("option").equals("product")) {
            /**
             * checkName : 검색 value (상품 이름 검색, 초성 검색)
             */
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
        if(data.get("order").equals("asc")){
            sb.append("ORDER BY receiving.register_date ASC ");
        }else {
            sb.append("ORDER BY receiving.register_date DESC ");
        }
        String sql = sb.toString();
        return template.query(sql, new ReceivingRowMapper());
    }

    /**
     * 입고 등록
     * @param receiving
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
