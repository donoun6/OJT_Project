package com.da.ojtproject.admin.api;

import com.da.ojtproject.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class AdminApi {

    private final AdminService adminService;
}
