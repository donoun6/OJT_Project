package com.da.ojtproject.home.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.home.domain.Home;

import java.util.List;

public interface HomeService {


    void addOrResetCategory(String categoryName);

    void editCategoryName(String oldName, String newName);

    List<Home> findAllCategories();

    //    void deleteBoard(int );
    void deleteCategory(int id);

}
