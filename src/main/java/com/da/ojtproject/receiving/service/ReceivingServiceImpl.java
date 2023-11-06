package com.da.ojtproject.receiving.service;

import com.da.ojtproject.receiving.dao.ReceivingDao;
import com.da.ojtproject.receiving.domain.Receiving;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
public class ReceivingServiceImpl implements ReceivingService {

    private final ReceivingDao receivingDao;

    @Override
    public List<Receiving> getAllReceiving() {
        return receivingDao.getAllReceiving();
    }

    @Override
    public List<Receiving> getSelectReceiving(Map<String, Object> data) {
        return receivingDao.getSelectReceiving(data);
    }

    @Override
    public void saveReceiving(Receiving receiving) {
        receivingDao.saveReceiving(receiving);
    }

    @Override
    public void updateReceiving(Receiving receiving) {
        receivingDao.updateReceiving(receiving);
    }
}
