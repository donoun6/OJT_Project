package com.da.ojtproject.inventory.service;

import com.da.ojtproject.inventory.domain.Inventory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

public interface InventoryService {
    Inventory getInventoryByProductId(int productId);

}

