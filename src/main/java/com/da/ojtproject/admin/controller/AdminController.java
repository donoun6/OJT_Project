package com.da.ojtproject.admin.controller;

import com.da.ojtproject.admin.domain.Admin;
import com.da.ojtproject.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping()
    public String adminPage(Model model) {
        model.addAttribute("sellingRankList", adminService.getSellingRank());
        model.addAttribute("todayOrderList", adminService.getTodayOrders());
        model.addAttribute("todayTotalPrice", adminService.getTodayTotalPrice());
        model.addAttribute("orderCount", adminService.getOrderCount());
        return "admin/admin";
    }
}
