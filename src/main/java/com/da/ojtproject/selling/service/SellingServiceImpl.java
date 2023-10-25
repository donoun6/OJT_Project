package com.da.ojtproject.selling.service;

import com.da.ojtproject.selling.dao.SellingDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class SellingServiceImpl implements SellingService {

    private final SellingDao sellingDao;
}
