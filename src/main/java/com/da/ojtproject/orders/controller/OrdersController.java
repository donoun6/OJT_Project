package com.da.ojtproject.orders.controller;

import com.da.ojtproject.orders.service.OrdersService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/orders")
@RequiredArgsConstructor
public class OrdersController {

    private final OrdersService ordersService;
}
