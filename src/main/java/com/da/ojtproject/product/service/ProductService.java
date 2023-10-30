package com.da.ojtproject.product.service;

import com.da.ojtproject.product.domain.Product;
import java.util.List;

public interface ProductService {
    void saveProduct(Product product);
    Product getProductById(int productId);
    List<Product> getAllProducts();
    void updateProduct(Product product);
    void deleteProduct(int productId);
}
