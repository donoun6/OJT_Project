package com.da.ojtproject.product.service;

import com.da.ojtproject.product.domain.Product;

import java.util.List;
import java.util.Map;

public interface ProductService {
    /**
     * 전체 product list 반환
     */
    List<Product> getAllProducts();

    /**
     * 검색 조건에 맞는 product list 반환
     */
    List<Product> getSearchProducts(Map<String, Object> data);

    /**
     * 상품 등록
     */
    void saveProduct(Product product);

    /**
     * 상품 삭제
     */
    void DeleteProduct(int productId);

    /**
     * 상품 복구
     */
    void RecoverProdcut(int productId);

    /**
     * 상품 정보 수정
     */
    void updateProduct(Product product);
}
