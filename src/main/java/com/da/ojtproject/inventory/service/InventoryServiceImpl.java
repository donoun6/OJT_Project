package com.da.ojtproject.inventory.service;

import com.da.ojtproject.inventory.dao.InventoryDao;
import com.da.ojtproject.inventory.domain.Inventory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class InventoryServiceImpl implements InventoryService{

    private final InventoryDao inventoryDao;

    @Override
    public Inventory getInventoryByProductId(int productId) {
        return inventoryDao.getInventoryByProductId(productId);
    }

}
