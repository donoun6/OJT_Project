package com.da.ojtproject.product.service;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.dao.ProductDao;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
public class ProductServiceImpl implements ProductService {

    private final ProductDao productDao;

    @Override
    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }

    @Override
    public List<Product> getSearchProducts(Map<String, Object> data) {
        return productDao.getSelectProducts(data);
    }

    @Override
    public List<Category> getAllCategory() {
        return productDao.getAllCategory();
    }
}
