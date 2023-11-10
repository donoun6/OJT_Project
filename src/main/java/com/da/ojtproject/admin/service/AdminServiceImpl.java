package com.da.ojtproject.admin.service;

import com.da.ojtproject.admin.dao.AdminDao;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AdminServiceImpl implements AdminService {

    private final AdminDao adminDao;

    @Override
    public List<Selling> getSellingRank() {
        return adminDao.getSellingRank();
    }

    @Override
    public List<Selling> getSellingInfo() {
        return adminDao.getSellingInfo();
    }

    @Override
    public List<Orders> getTodayOrders() {
        return adminDao.getTodayOrders();
    }

    @Override
    public Integer getTodayTotalPrice() {
        return adminDao.getTodayTotalPrice();
    }

    @Override
    public Integer getOrderCount() {
        return adminDao.getOrderCount();
    }

    @Override
    public List<Product> getLowQuantity() {
        return adminDao.getLowQuantity();
    }

    @Override
    public List<Selling> getSellingDay() {
        return adminDao.getSellingDay();
    }
}
