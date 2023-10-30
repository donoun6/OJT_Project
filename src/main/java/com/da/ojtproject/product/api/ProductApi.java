package com.da.ojtproject.product.api;

import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.Response;
import java.util.List;

@RestController
@RequestMapping("api/products")
@RequiredArgsConstructor
public class ProductApi {

    private final ProductService productService;

    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() {

        List<Product> products = productService.getAllProducts();

        return new ResponseEntity<>(products, HttpStatus.OK);

    }

    // 항목별로 상품을 검색하는 방법
    @GetMapping("{productId}")
    public ResponseEntity<Product> getProductById(@PathVariable int productId) {

        Product product = productService.getProductById(productId);

        if (product != null) {
            return new ResponseEntity<>(product, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

    }

    @PostMapping
    public ResponseEntity<Product> updateProduct(@PathVariable int productId, @RequestBody Product product) {

        productService.updateProduct(product);

        return new ResponseEntity<>(product, HttpStatus.CREATED);

    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<Void> deleteProduct(@PathVariable int productId) {

        productService.deleteProduct(productId);

        return new ResponseEntity<>(HttpStatus.NO_CONTENT);

    }


}
