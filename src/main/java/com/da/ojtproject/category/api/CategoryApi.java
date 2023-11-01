package com.da.ojtproject.category.api;

import com.da.ojtproject.category.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class CategoryApi {

    private  final CategoryService categoryService;
}
