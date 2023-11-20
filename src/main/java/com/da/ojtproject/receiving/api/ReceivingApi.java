package com.da.ojtproject.receiving.api;

import com.da.ojtproject.receiving.domain.Receiving;
import com.da.ojtproject.receiving.service.ReceivingService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class ReceivingApi {

    private final ReceivingService receivingService;

    /**
     * 입고 취소처리
     */
    @DeleteMapping("/api/receiving")
    public HttpStatus receivingCancel(@RequestBody Receiving receiving) {
        int check = receiving.getInventory().getQuantity() + receiving.getQuantity();
        if (check < 0) {
            return HttpStatus.BAD_REQUEST;
        }
        receivingService.saveReceiving(receiving);
        receivingService.updateReceiving(receiving);
        return HttpStatus.OK;
    }

    /**
     * 입고 등록
     */
    @PostMapping("/api/receiving")
    public HttpStatus receivingSave(@RequestBody Receiving receiving) {
        if (receiving.getQuantity() <= 0) {
            return HttpStatus.BAD_REQUEST;
        }
        receivingService.saveReceiving(receiving);
        return HttpStatus.OK;
    }

}
