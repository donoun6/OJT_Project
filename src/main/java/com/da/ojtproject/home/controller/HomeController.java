package com.da.ojtproject.home.controller;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.home.domain.Home;
import com.da.ojtproject.home.service.HomeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/home")
public class HomeController {

    private final HomeService homeService;

    @GetMapping("/menu")
    public String menuPage(Model model) {
        model.addAttribute("category", new Category());
        return "index";

    }

    @GetMapping("/menu-list")
    public String menulistCategories(Model model) {
        List<Home> categories = homeService.findAllCategories();
        model.addAttribute("categories", categories);
        return "index";
    }


}
