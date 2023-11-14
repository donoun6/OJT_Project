package com.da.ojtproject.category.controller;


import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.category.service.CategoryService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@AllArgsConstructor
@RequestMapping("category")
public class CategoryController {

    private final CategoryService categoryService;

    /**
     * Ajax 비동기 통신 카테고리 저장 form 출력
     */
    @GetMapping("/save")
    public String categoryForm(Model model) {
        model.addAttribute("category", new Category());
        return "category/ajax/categorySave";
    }

}
