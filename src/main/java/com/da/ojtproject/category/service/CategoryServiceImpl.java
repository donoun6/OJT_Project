package com.da.ojtproject.category.service;

import com.da.ojtproject.category.dao.CategoryDao;
import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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
    public void deleteCateogory(int categoryId) {
        categoryDao.deleteCateogory(categoryId);
    }

    @Override
    public void recoverCategory(int categoryId) {
        categoryDao.recoverCateogory(categoryId);
    }
}
