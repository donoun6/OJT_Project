package com.da.ojtproject.selling.controller;

import com.da.ojtproject.selling.service.SellingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/selling")
public class SellingController {

    private final SellingService sellingService;

    @GetMapping()
    public String SellingForm(Model model) {
        model.addAttribute("sellingList", sellingService.getAllSelling());
        return "admin/selling/selling";
    }

    /**
     * selling-list Ajax 호출
     */
    @GetMapping("/selling-list")
    public String sellingList(Model model,
                              @RequestParam(required = false) Map<String, Object> data) {
        if (data.get("bundle").equals("N")) {
            model.addAttribute("sellingList", sellingService.getSelectSelling(data));
        } else {
            model.addAttribute("sellingList", sellingService.getSelectBundleSelling(data));
        }
        return "admin/selling/ajax/sellingList";
    }
}
