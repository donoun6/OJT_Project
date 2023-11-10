package com.da.ojtproject.admin.service;

import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;

import java.util.List;

public interface AdminService {

    List<Selling> getSellingRank();

    List<Selling> getSellingInfo();

    List<Orders> getTodayOrders();

    Integer getTodayTotalPrice();

    Integer getOrderCount();

    List<Product> getLowQuantity();
}
