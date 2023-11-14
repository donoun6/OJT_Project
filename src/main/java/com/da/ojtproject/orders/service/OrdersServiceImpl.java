package com.da.ojtproject.orders.service;

import com.da.ojtproject.orders.dao.OrdersDao;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.selling.domain.Selling;
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
    public List<Orders> getAllOrdersProducts() { return ordersDao.getAllOrdersProducts() ; }
    @Override
    public List<Orders> getSearchOrders(Map<String, Object> data) { return ordersDao.getAllOrdersProducts(); }
    @Override
    public List<Selling> getSellingsByOrdersId(int ordersId) { return ordersDao.findSellingsByOrdersId(ordersId); }
    // 전체 주문 목록 환불 ServiceImpl
    @Override
    public boolean refundAll(int ordersId) { return ordersDao.refundAll(ordersId); }
    @Override
    public boolean partialRefund(int ordersId, int productId) { return ordersDao.partialRefund(ordersId,productId); }
    @Override
    public boolean refundAllCancel(int ordersId3) { return ordersDao.refundAllCancel(ordersId3); }
    @Override
    public boolean partialRefundCancel(int ordersId4, int productId4) { return ordersDao.partialRefundCancel(ordersId4,productId4); }


}


