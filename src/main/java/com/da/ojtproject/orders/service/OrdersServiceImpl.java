package com.da.ojtproject.orders.service;

import com.da.ojtproject.orders.dao.OrdersDao;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
public class OrdersServiceImpl implements OrdersService {

    private final OrdersDao ordersDao;

    @Override
    public List<Orders> getAllOrdersProducts() { return ordersDao.getAllOrdersProducts() ;
    }

    @Override
    public List<Orders> getSearchOrders(Map<String, Object> data) { return ordersDao.getAllOrdersProducts(); }

    @Override
    public List<Selling> getSellingsByOrdersId(int ordersId) { return ordersDao.findSellingsByOrdersId(ordersId); }

    // 전체 주문 목록 환불 ServiceImpl
    @Override
    public boolean refundAll(int ordersId) { return ordersDao.refundAll(ordersId); }

    @Override
    public boolean partialRefund(int ordersId, int productId) { return ordersDao.partialRefund(ordersId,productId); }

//    @ResponseBody
//    @PostMapping("/refundAll")
//    public ResponseEntity<?> fullRefund(@RequestParam int ordersId) {
//        boolean result = ordersService.refundAll(ordersId);
//
//        Map<String, String> response = new HashMap<>();
//        if (result) {
//            response.put("message", "환불 처리가 완료되었습니다.");
//            return ResponseEntity.ok(response);
//        } else {
//            response.put("message", "환불 처리에 실패하였습니다.");
//            return ResponseEntity.badRequest().body(response);
//        }
//    }
}


