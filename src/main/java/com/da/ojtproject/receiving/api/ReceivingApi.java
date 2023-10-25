package com.da.ojtproject.receiving.api;

import com.da.ojtproject.receiving.service.ReceivingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ReceivingApi {

    private final ReceivingService receivingService;
}
