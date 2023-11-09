package com.da.ojtproject.admin.service;

import com.da.ojtproject.admin.dao.AdminDao;
import com.da.ojtproject.orders.domain.Orders;
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
    public List<Orders> getTodayOrders() {
        return adminDao.getTodayOrders();
    }

    @Override
    public Selling getTodayTotalPrice() {
        return adminDao.getTodayTotalPrice();
    }

    @Override
    public Integer getOrderCount() {
        return adminDao.getOrderCount();
    }
}
