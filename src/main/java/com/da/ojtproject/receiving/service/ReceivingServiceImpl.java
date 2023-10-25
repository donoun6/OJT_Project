package com.da.ojtproject.receiving.service;

import com.da.ojtproject.receiving.dao.ReceivingDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class ReceivingServiceImpl implements ReceivingService {

    private final ReceivingDao receivingDao;
}
