package com.da.ojtproject.admin.service;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;

import java.util.List;

public interface AdminService {

    /**
     * 전체 판매 순위 10개
     */
    List<Selling> getSellingRank();

    /**
     * 판매 정보
     */
    List<Selling> getSellingInfo();

    /**
     * 금일 주문
     */
    List<Orders> getTodayOrders();

    /**
     * 금일 매출
     */
    Integer getTodayTotalPrice();

    /**
     * 금일 주문 건
     */
    Integer getOrderCount();

    /**
     * 재고 알림
     */
    List<Product> getLowQuantity();

    /**
     * 날짜별 판매 정보
     */
    List<Selling> getSellingDay();
}
