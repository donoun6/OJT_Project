package com.da.ojtproject.orders.service;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.selling.domain.Selling;

import java.util.List;
import java.util.Map;

public interface OrdersService {
    /**
     * 전체 Order list 반환
     */
    List<Orders> getAllOrdersProducts();

    List<Orders> getSearchOrders(Map<String, Object> data);

    List<Selling> getSellingsByOrdersId(int ordersId);

    boolean partialRefund(int ordersId, int productId);

    boolean refundAll(int ordersId);

    boolean refundAllCancel(int ordersId3);

    boolean partialRefundCancel(int ordersId4, int productId4);

    List<Orders> sortOrdersByDate(String order);
}
