package com.da.ojtproject.orders.controller;

import com.da.ojtproject.orders.service.OrdersService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/orders")
@RequiredArgsConstructor
public class OrdersController {

    private final OrdersService ordersService;

    @GetMapping("/result")
    public String showPaymentResult(@RequestParam("imp_uid") String impUid, Model model, HttpSession session) {
//        Integer OrdersId = (Integer) session.getAttribute("OrderId");
        Integer currentOrderUid = (Integer) session.getAttribute("currentOrderUid");

        if (currentOrderUid == null) {
            currentOrderUid = 951008;
        }
//        else {
//            currentOrderUid++;
//        }
        session.setAttribute("currentOrderUid", currentOrderUid);
        model.addAttribute("currentOrderUid", currentOrderUid);

        // ordersService를 사용하여 결제 정보와 주문 정보를 가져옵니다.
        // 이 부분은 실제 주문 처리 로직에 따라 달라질 수 있습니다.
        // 예를 들어, 결제 정보를 조회하고, 주문 정보를 가져오는 로직이 들어가야 합니다.

        // 예시를 위한 가상의 메소드 호출
        // Order order = ordersService.getOrderDetailsByImpUid(impUid);

        // 모델에 결제 정보와 주문 정보를 추가합니다.
        // model.addAttribute("order", order);

        // 'result' 페이지를 반환합니다. Thymeleaf 같은 템플릿 엔진을 사용한다고 가정합니다.
        return "/payment/result"; // result.html 페이지 이름
    }

}
