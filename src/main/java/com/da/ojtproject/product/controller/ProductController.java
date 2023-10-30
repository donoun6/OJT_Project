package com.da.ojtproject.product.controller;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/product")
public class ProductController {

    private final ProductService productService;

    private final CategoryService categoryService;

    private static final String UPLOAD_DIR = "src/main/resources/static/img/";

    // 상품을 등록하는 페이지입니다..
    @GetMapping("/register")
    public String showRegisterForm(Model model) {

        model.addAttribute("categories", categoryService.findAllCategories());

        model.addAttribute("product", new Product());

        return "product/productPractice";

    }

    // 상품을 이미지와 함께 등록하는 메서드입니다.

    @PostMapping("/register")
    public String registerProduct(@ModelAttribute Product product, @RequestParam("imageFile") MultipartFile imageFile) throws IOException {
        if (!imageFile.isEmpty()) {

            String fileName = imageFile.getOriginalFilename();
            Path filePath = Paths.get(UPLOAD_DIR, fileName);

            Files.write(filePath, imageFile.getBytes());

            product.setImage("img/" + fileName);
        }
        productService.saveProduct(product);
//        return "product/productPractice";
        return "redirect:/admin/product/productList";
    }

    // 상품의 전체 목록을 출력하는 메서드입니다.
    @GetMapping("/productList")
    public String listProducts(Model model) {

        List<Product> products = productService.getAllProducts();

        model.addAttribute("products", products);

        return "product/productList";

    }


    @GetMapping("/categoryList")
    public String listCategories(Model model) {

        List<Category> categories = categoryService.findAllCategories();

        model.addAttribute("categories", categories);

        return "category/categoryList";
    }

}
