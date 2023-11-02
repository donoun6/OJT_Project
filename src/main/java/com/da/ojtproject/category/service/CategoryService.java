package com.da.ojtproject.category.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;

import java.util.List;

public interface CategoryService {
    /**
     * 전체 category list 반환
     */
    List<Category> getAllCategory();

    /**
     * 카테고리 저장 or 재생성
     * @param category
     */
    void addOrResetCategory(Category category);
}

