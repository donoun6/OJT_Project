package com.da.ojtproject.home.service;

import com.da.ojtproject.home.domain.Home;
import com.da.ojtproject.product.domain.Product;

import java.util.List;

public interface HomeService {

    List<Home> findAllCategories();
    List<Product> findItemsOfFirstCategory();
    List<Product> findProductsByCategoryId(int categoryId);
    int getLastOrderNumber();

}
