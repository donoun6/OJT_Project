package com.da.ojtproject.cart.service;

import com.da.ojtproject.cart.domain.Cart;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

public interface CartService {
    void AddOrCountCart(int productId);
    List<Cart> findAllCartItems();
    void deleteCart();
    void deleteCartItem(int id);
    void updateQuantity(int cartId);
    void decreaseQuantity(int cartId);
    Cart findCartItemById(int cartId);
}