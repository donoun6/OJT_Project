package com.da.ojtproject.receiving.controller;

import com.da.ojtproject.receiving.service.ReceivingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/receiving")
public class ReceivingController {

    private final ReceivingService receivingService;
}
