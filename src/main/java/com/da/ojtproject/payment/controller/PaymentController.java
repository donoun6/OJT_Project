package com.da.ojtproject.payment.controller;

import com.da.ojtproject.payment.service.PaymentService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/payment")
public class PaymentController {

    private final PaymentService paymentService;

    @PostMapping("/process/{imp_uid}")
    public ResponseEntity<?> processPayment(@PathVariable String imp_uid) {
        try {
            boolean paymentSuccess = paymentService.processPayment(imp_uid);
            return ResponseEntity.ok().body(paymentSuccess);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while processing the payment.");
        }
    }
}

