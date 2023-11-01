package com.da.ojtproject.product.controller;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/product")
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;

    /**
     * @param model
     * @return
     */
    @GetMapping()
    public String productForm(Model model) {
        model.addAttribute("productList", productService.getAllProducts());
        model.addAttribute("categoryList", categoryService.getAllCategory());
        return "admin/product/product";
    }

    /**
     * Ajax html 비동기 화면 반환
     * @param model
     * @param data
     * @return
     */
    @GetMapping("/product-list")
    public String productList(Model model,
                              @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("productList", productService.getSearchProducts(data));
        return "admin/product/Ajax/productList";
    }

}
