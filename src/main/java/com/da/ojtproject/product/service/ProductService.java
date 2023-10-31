package com.da.ojtproject.product.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;

import java.util.List;
import java.util.Map;

public interface ProductService {
    /**
     * 전체 product list 반환
     */
    List<Product> getAllProducts();

    /**
     * 검색 조건에 맞는 product list 반환
     */
    List<Product> getSearchProducts(Map<String, Object> data);

    /**
     * 전체 category list 반환
     */
    List<Category> getAllCategory();
}
