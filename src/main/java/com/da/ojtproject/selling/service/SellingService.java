package com.da.ojtproject.selling.service;

import com.da.ojtproject.selling.domain.Selling;

import java.util.List;
import java.util.Map;

public interface SellingService {
    /**
     * 전체 조회
     */
    List<Selling> getAllSelling();

    /**
     * 조건 검색
     */
    List<Selling> getSelectSelling(Map<String, Object> data);

    /**
     * 묶음 검색
     */
    List<Selling> getSelectBundleSelling(Map<String, Object> data);

}
