package com.da.ojtproject.cart.api;

import com.da.ojtproject.cart.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class CartApi {

    private final CartService cartService;
}
