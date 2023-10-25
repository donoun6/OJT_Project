package com.da.ojtproject.home.service;

import com.da.ojtproject.home.dao.HomeDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class HomeServiceImpl implements HomeService{

    private final HomeDao homeDao;
}
