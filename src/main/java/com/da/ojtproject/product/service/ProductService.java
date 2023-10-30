package com.da.ojtproject.product.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.domain.ProductList;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface ProductService {
    List<ProductList> getAllProducts();

    List<ProductList> getSearchProducts(Map<String, Object> data);

    List<Category> getAllCategory();
}
