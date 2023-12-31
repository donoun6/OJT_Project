package com.da.ojtproject.product.api;

import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class ProductApi {

    private final ProductService productService;

    /**
     * 상품 삭제 API
     */
    @DeleteMapping("/api/product/{productId}")
    public HttpStatus productDelete(@PathVariable int productId) {
        productService.deleteProduct(productId);
        return HttpStatus.OK;
    }

    /**
     * 삭제 상품 복구
     */
    @PutMapping("/api/product/{productId}")
    public HttpStatus productRecover(@PathVariable int productId) {
        productService.recoverProduct(productId);
        return HttpStatus.OK;
    }

    /**
     * 상품 정보 수정
     */
    @PatchMapping("/api/product")
    public HttpStatus productUpdate(@RequestBody Product product) {
        if (product.getName() == "" || product.getCode() == "" ||
                product.getCategoryId() == 0 || product.getSellPrice() == 0 ||
                product.getSellPrice() < 100) {
            return HttpStatus.BAD_REQUEST;
        }
        productService.updateProduct(product);
        return HttpStatus.OK;
    }

}
