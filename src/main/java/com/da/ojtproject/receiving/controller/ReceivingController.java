package com.da.ojtproject.receiving.controller;

import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import com.da.ojtproject.receiving.service.ReceivingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/receiving")
public class ReceivingController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final ReceivingService receivingService;

    /**
     * 입고 조회
     */
    @GetMapping()
    public String receiving(Model model) {
        model.addAttribute("receivingList", receivingService.getAllReceiving());
        model.addAttribute("categoryList",categoryService.getAllCategory());
        model.addAttribute("productList",productService.getAllProducts());
        return "admin/receiving/receiving";
    }

    /**
     * 입고 검색 list 출력 Ajax
     */
    @GetMapping("/receiving-list")
    public String receivingList(Model model,
                                @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("receivingList",receivingService.getSelectReceiving(data));
        return "admin/receiving/ajax/receivingList";
    }

    @GetMapping("/product-list")
    public String productList(Model model,
                              @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("product", new Product());
        model.addAttribute("productList", productService.getSearchProducts(data));
        return "admin/receiving/ajax/receivingCategory";
    }
}
