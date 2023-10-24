package com.da.ojtproject.admin.service;

import com.da.ojtproject.admin.dao.AdminDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService{

    @Autowired
    AdminDao adminDao;

    @Override
    public void saveAdmin(String password) {
        adminDao.saveAdmin(password);
    }
}
