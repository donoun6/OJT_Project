package com.da.ojtproject.cart.service;

import com.da.ojtproject.cart.dao.CartDao;
import com.da.ojtproject.cart.domain.Cart;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CartServiceImpl implements CartService {

    private final CartDao cartDao;

    @Override
    public void AddOrCountCart(int productId) {
        cartDao.AddOrCountCart(productId);
    }
    @Override
    public List<Cart> findAllCartItems() {
        return cartDao.findAllCartItems();
    }
    @Override
    public void deleteCart() {
        cartDao.deleteCart();
    }
    @Override
    public void deleteCartItem(int id) {
        cartDao.deleteCartItem(id);
    }
    @Override
    public void updateQuantity(int cartId) {
        cartDao.updateQuantity(cartId);
    }
    @Override
    public void decreaseQuantity(int cartId) {
        cartDao.decreaseQuantity(cartId);
    }
    @Override
    public Cart findCartItemById(int cartId) {
        return cartDao.findCartItemById(cartId);
    }
}
