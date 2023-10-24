package com.da.ojtproject.admin.controller;

import com.da.ojtproject.admin.domain.Admin;
import com.da.ojtproject.admin.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AdminController {

    @Autowired
    AdminService adminService;

    @GetMapping("/admin")
    public String adminPage(Model model) {
        model.addAttribute("admin",new Admin());
        return "admin/admin";
    }

    @PostMapping("/admin")
    public String adminFrom(@ModelAttribute("admin") Admin admin, Model model) {
        adminService.saveAdmin(admin.getPassword());
        return "redirect:/";
    }
}
