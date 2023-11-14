package com.da.ojtproject.category.service;

import com.da.ojtproject.category.dao.CategoryDao;
import com.da.ojtproject.category.domain.Category;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryDao categoryDao;

    @Override
    public List<Category> getAllCategory() {
        return categoryDao.getAllCategory();
    }

    @Override
    public void addOrResetCategory(Category category) {
        categoryDao.addOrResetCategory(category);
    }

    @Override
    public void deleteCategory(int categoryId) {
        categoryDao.deleteCategory(categoryId);
    }

    @Override
    public void recoverCategory(int categoryId) {
        categoryDao.recoverCategory(categoryId);
    }
}
