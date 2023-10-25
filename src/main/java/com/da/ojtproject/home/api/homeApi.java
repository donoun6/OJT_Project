package com.da.ojtproject.home.api;

import com.da.ojtproject.home.service.HomeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class homeApi {

    private final HomeService homeService;

}
