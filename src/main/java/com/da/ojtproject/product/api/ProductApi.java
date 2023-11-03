package com.da.ojtproject.product.api;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class ProductApi {

    private final ProductService productService;

    @DeleteMapping("/api/product/{productId}")
    public HttpStatus productDelete(@PathVariable int productId) {
        productService.DeleteProduct(productId);
        return HttpStatus.OK;
    }

    @PutMapping("/api/product/{productId}")
    public HttpStatus productRecover(@PathVariable int productId) {
        productService.RecoverProdcut(productId);
        return HttpStatus.OK;
    }

    @PatchMapping("/api/product")
    public HttpStatus productUpdate(@RequestBody Product product) {
        productService.updateProduct(product);
        return HttpStatus.OK;
    }

}
