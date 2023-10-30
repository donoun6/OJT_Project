package com.da.ojtproject.category.service;

import com.da.ojtproject.category.domain.Category;

import java.util.List;

public interface CategoryService {


    void addOrResetCategory(String categoryName);

    void editCategoryName(String oldName, String newName);

    List<Category> findAllCategories();

//    void deleteBoard(int );
    void deleteCategory(int id);

}

