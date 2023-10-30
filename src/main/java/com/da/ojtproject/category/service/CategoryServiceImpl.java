package com.da.ojtproject.category.service;

import com.da.ojtproject.category.dao.CategoryDao;
import com.da.ojtproject.category.domain.Category;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryDao categoryDao;

    // 프로시저를 이용해서 카테고리를 추가하는 방법
    @Override
    public void addOrResetCategory(String categoryName) {
        categoryDao.addOrResetCategory(categoryName);
    }

    @Override
    public void editCategoryName(String oldName, String newName) {
        categoryDao.editCategoryName(oldName, newName);
    }

    @Override
    public List<Category> findAllCategories() {
        return categoryDao.findAllCategories();
    }
    @Override
    public void deleteCategory(int id) {
        categoryDao.deleteCategory(id);
    }
}
