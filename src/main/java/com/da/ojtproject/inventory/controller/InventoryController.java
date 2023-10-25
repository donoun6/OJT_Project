package com.da.ojtproject.inventory.controller;

import com.da.ojtproject.inventory.service.InventoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/inventory")
public class InventoryController {

    private final InventoryService inventoryService;
}
