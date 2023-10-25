package com.da.ojtproject.inventory.api;

import com.da.ojtproject.inventory.service.InventoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class InventoryApi {

    private final InventoryService inventoryService;
}
