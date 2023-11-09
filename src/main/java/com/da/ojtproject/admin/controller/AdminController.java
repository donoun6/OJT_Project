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

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    /**
     * 현재 날짜 yyyy-MM-dd 형태로 date format
     */
    Date date = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   // yyyy-MM-dd HH:mm:ss
    String format = formatter.format(date);

    @GetMapping()
    public String adminPage(Model model) {
        model.addAttribute("sellingRankList", adminService.getSellingRank());
        model.addAttribute("todayOrderList", adminService.getTodayOrders());
        model.addAttribute("todayTotalPrice", adminService.getTodayTotalPrice());
        model.addAttribute("orderCount", adminService.getOrderCount());
        model.addAttribute("date", format);
        model.addAttribute("lowQuantity", adminService.getLowQuantity());
        return "admin/admin";
    }
}
