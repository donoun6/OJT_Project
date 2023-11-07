package com.da.ojtproject.orders.service;

import com.da.ojtproject.product.domain.Product;

import java.util.List;
import java.util.Map;

public interface OrdersService {

    /**
     * 전체 Order list 반환
     */
    List<Product> getAllOrdersProducts();

    List<Product> getSearchOrders(Map<String, Object> data);

}
