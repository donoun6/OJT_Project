package com.da.ojtproject.selling.api;

import com.da.ojtproject.selling.service.SellingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class SellingApi {

    private final SellingService sellingService;
}
