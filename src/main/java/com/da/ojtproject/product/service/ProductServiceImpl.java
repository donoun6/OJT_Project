package com.da.ojtproject.product.service;

import com.da.ojtproject.product.dao.ProductDao;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class ProductServiceImpl implements ProductService {

    private final ProductDao productDao;

    // 제일 중요합니다.
    @Override
    public void saveProduct(Product product) {
        productDao.saveProduct(product);
    }

    @Override
    public Product getProductById(int productId) {
        return productDao.getProductById(productId);
    }


    @Override
    public List<Product> getAllProducts() {

        return productDao.getAllProducts();

    }

    @Override
    public void updateProduct(Product product) {
    }

    @Override
    public void deleteProduct(int productId) {
    }
}
