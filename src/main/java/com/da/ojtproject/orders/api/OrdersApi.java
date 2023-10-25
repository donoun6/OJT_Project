package com.da.ojtproject.orders.api;

import com.da.ojtproject.orders.service.OrdersService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class OrdersApi {

    private final OrdersService ordersService;
}
