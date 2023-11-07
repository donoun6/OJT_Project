package com.da.ojtproject.home.controller;


import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.home.domain.Home;
import com.da.ojtproject.home.service.HomeService;
import com.da.ojtproject.product.domain.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/home")
public class HomeController {

    private final HomeService homeService;

    @GetMapping("/menu")
    public String menuPage(Model model) {
        model.addAttribute("category", new Category());
        return "index";
    }

    @ResponseBody
    @GetMapping("/products/byCategory/{categoryId}")
    public List<Product> getProductsByCategory(@PathVariable int categoryId) {
        // 카테고리 아이디를 통해서 카테고리 목록을 조회합니다.
        return homeService.findProductsByCategoryId(categoryId);
    }

    @GetMapping("/menu-list")
    public String Categories(Model model, HttpSession session) {

        // 서버 사이드에서 UIDs 초기화 및 증가
        Integer currentMerchantUid = (Integer) session.getAttribute("currentMerchantUid");
        Integer currentOrderUid = (Integer) session.getAttribute("currentOrderUid");

        if (currentMerchantUid == null || currentOrderUid == null) {
            currentMerchantUid = 15654; // 시작 값 설정
            currentOrderUid = 245156; // 시작 값 설정
        } else {
            currentMerchantUid++;
            currentOrderUid++;
        }
        session.setAttribute("currentMerchantUid", currentMerchantUid);
        session.setAttribute("currentOrderUid", currentOrderUid);

        List<Product> itemsOfFirstCategory = homeService.findItemsOfFirstCategory();
        List<Home> categories = homeService.findAllCategories();
        model.addAttribute("items", itemsOfFirstCategory);
        model.addAttribute("categories", categories);
        model.addAttribute("currentMerchantUid", currentMerchantUid); // 모델에 추가
        model.addAttribute("currentOrderUid", currentOrderUid); // 모델에 추가

        return "index";

    }

    @GetMapping("/result")
    public String resultPage(Model model) {
        model.addAttribute("category", new Category());
        return "payment/result";
    }
}
