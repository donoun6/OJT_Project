package com.da.ojtproject.selling.controller;

import com.da.ojtproject.selling.service.SellingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/selling")
public class SellingController {

    private final SellingService sellingService;
}
