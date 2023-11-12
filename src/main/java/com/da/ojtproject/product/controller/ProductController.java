package com.da.ojtproject.product.controller;

import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import com.da.ojtproject.receiving.service.ReceivingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/product")
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private static final String UPLOAD_DIR = "src/main/resources/static/img/";

    /**
     * product 기본 화면
     */
    @GetMapping()
    public String productForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("productList", productService.getAllProducts());
        model.addAttribute("categoryList", categoryService.getAllCategory());
        return "admin/product/product";
    }

    /**
     * product , inventory 등록
     */
    @PostMapping("/save")
    public String productSave(@ModelAttribute Product product) throws IOException {
        MultipartFile imageFile = product.getImageFile();

        if (!imageFile.isEmpty()) {

            String fileName = imageFile.getOriginalFilename();
            Path filePath = Paths.get(UPLOAD_DIR, fileName);

            Files.write(filePath, imageFile.getBytes());

            product.setImage("img/" + fileName);
        }

        productService.saveProduct(product);

        return "redirect:/admin/product";
    }

    /**
     * Ajax html 비동기 화면 반환
     */
    @GetMapping("/product-list")
    public String productList(Model model,
                              @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("product", new Product());
        model.addAttribute("productList", productService.getSearchProducts(data));
        return "admin/product/ajax/productList";
    }

}
