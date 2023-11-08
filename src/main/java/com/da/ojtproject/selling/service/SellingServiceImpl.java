package com.da.ojtproject.selling.service;

import com.da.ojtproject.selling.dao.SellingDao;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
public class SellingServiceImpl implements SellingService {

    private final SellingDao sellingDao;

    @Override
    public List<Selling> getAllSelling() {
        return sellingDao.getAllSelling();
    }

    @Override
    public List<Selling> getSelectSelling(Map<String, Object> data) {
        return sellingDao.getSelectSelling(data);
    }

    @Override
    public List<Selling> getSelectBundleSelling(Map<String, Object> data) {
        return sellingDao.getSelectBundleSelling(data);
    }
}
