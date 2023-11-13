package com.da.ojtproject.category.service;

import com.da.ojtproject.category.domain.Category;

import java.util.List;

public interface CategoryService {
    /**
     * 전체 category list 반환
     */
    List<Category> getAllCategory();

    /**
     * 카테고리 저장 or 재생성
     */
    void addOrResetCategory(Category category);

    /**
     * 카테고리 삭제처리
     */
    void deleteCategory(int categoryId);

    /**
     * 카테고리 복구
     */
    void recoverCategory(int categoryId);
}

