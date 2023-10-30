package com.da.ojtproject.home.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.home.dao.HomeDao;
import com.da.ojtproject.home.domain.Home;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HomeServiceImpl implements HomeService{

    private final HomeDao homeDao;

    // 프로시저를 이용해서 카테고리를 추가하는 방법
    @Override
    public void addOrResetCategory(String categoryName) {
        homeDao.addOrResetCategory(categoryName);
    }

    @Override
    public void editCategoryName(String oldName, String newName) {

    }

    @Override
    public List<Home> findAllCategories() {
        return homeDao.findAllCategories();
    }

    @Override
    public void deleteCategory(int id) {

    }
}
