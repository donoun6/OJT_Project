package com.da.ojtproject.home.service;

import com.da.ojtproject.home.dao.HomeDao;
import com.da.ojtproject.home.domain.Home;
import com.da.ojtproject.payment.dao.PaymentDao;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HomeServiceImpl implements HomeService{

    private final HomeDao homeDao;
    private final PaymentDao paymentDao;
    @Override
    public List<Home> findAllCategories() { return homeDao.findAllCategories(); }
    @Override
    public List<Product> findItemsOfFirstCategory() {
        return homeDao.findItemsOfFirstCategory();
    }
    @Override
    public List<Product> findProductsByCategoryId(int categoryId) { return homeDao.findProductsByCategoryId(categoryId); }
    @Override
    public int getLastOrderNumber() { return paymentDao.getLastOrderNumber(); }


}
