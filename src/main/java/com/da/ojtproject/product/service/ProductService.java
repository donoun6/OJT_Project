package com.da.ojtproject.product.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;

import java.util.List;
import java.util.Map;

public interface ProductService {
    List<Product> getAllProducts();

    List<Product> getSearchProducts(Map<String, Object> data);

    List<Category> getAllCategory();
}
