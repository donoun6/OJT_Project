package com.da.ojtproject.admin.service;

import com.da.ojtproject.admin.dao.AdminDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class AdminServiceImpl implements AdminService {

    private final AdminDao adminDao;

    @Override
    public void saveAdmin(String password) {
        adminDao.saveAdmin(password);
    }
}
