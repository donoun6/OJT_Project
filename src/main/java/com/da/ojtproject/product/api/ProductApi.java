package com.da.ojtproject.product.api;

import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/products")
@RequiredArgsConstructor
public class ProductApi {

    private final ProductService productService;

}
