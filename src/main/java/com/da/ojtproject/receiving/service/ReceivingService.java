package com.da.ojtproject.receiving.service;

import com.da.ojtproject.receiving.domain.Receiving;

import java.util.List;
import java.util.Map;

public interface ReceivingService {
    /**
     * 기본 전체 조회
     */
    List<Receiving> getAllReceiving();

    /**
     * 검색 조건 조회
     */
    List<Receiving> getSelectReceiving(Map<String, Object> data);

    /**
     * 입고 등록
     */
    void saveReceiving(Receiving receiving);

    /**
     * 입고수정
     */
    void updateReceiving(Receiving receiving);
}
