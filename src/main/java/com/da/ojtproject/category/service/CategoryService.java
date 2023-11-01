package com.da.ojtproject.category.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;

import java.util.List;

public interface CategoryService {
    /**
     * 전체 category list 반환
     */
    List<Category> getAllCategory();
}

