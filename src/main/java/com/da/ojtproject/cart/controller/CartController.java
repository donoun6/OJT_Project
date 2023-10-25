package com.da.ojtproject.cart.controller;

import com.da.ojtproject.cart.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/product")
public class CartController {

    private final CartService cartService;
}
