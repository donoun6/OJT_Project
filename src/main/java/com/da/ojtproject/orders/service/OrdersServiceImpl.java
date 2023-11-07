package com.da.ojtproject.orders.service;

import com.da.ojtproject.orders.dao.OrdersDao;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
public class OrdersServiceImpl implements OrdersService {

    private final OrdersDao ordersDao;

    @Override
    public List<Product> getAllOrdersProducts() {
        return ordersDao.getAllOrdersProducts();
    }

    @Override
    public List<Product> getSearchOrders(Map<String, Object> data) {
        return null;
    }
}
