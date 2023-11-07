package com.da.ojtproject.payment.controller;

import com.da.ojtproject.cart.service.CartService;
import com.da.ojtproject.home.domain.Home;
import com.da.ojtproject.home.service.HomeService;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.inventory.service.InventoryService;
import com.da.ojtproject.payment.domain.Payment;
import com.da.ojtproject.payment.service.PaymentService;
import com.da.ojtproject.product.domain.Product;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;
import java.io.IOException;
import java.util.List;

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

