package com.da.ojtproject.admin.service;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.selling.domain.Selling;

import java.util.List;

public interface AdminService {

    List<Selling> getSellingRank();

    List<Orders> getTodayOrders();

    Selling getTodayTotalPrice();

    Integer getOrderCount();
}
