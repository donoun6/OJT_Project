package com.da.ojtproject.admin.controller;

import com.da.ojtproject.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping()
    public String adminPage(Model model) {
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");   // yyyy-MM-dd HH:mm:ss
        String format = formatter.format(date);

        model.addAttribute("sellingRankList", adminService.getSellingRank());
        model.addAttribute("todayOrderList", adminService.getTodayOrders());
        model.addAttribute("todayTotalPrice", adminService.getTodayTotalPrice());
        model.addAttribute("orderCount", adminService.getOrderCount());
        model.addAttribute("date", format);
        model.addAttribute("lowQuantity", adminService.getLowQuantity());
        model.addAttribute("sellingInfo", adminService.getSellingInfo());
        model.addAttribute("sellingDay", adminService.getSellingDay());
        return "admin/admin";
    }

    /**
     * 랭크 list 출력 Ajax
     */
    @GetMapping("/rank-list")
    public String rankList(Model model,
                                @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("sellingRankList", adminService.getSellingRankDate(data));
        return "admin/main/rankAjax";
    }
}