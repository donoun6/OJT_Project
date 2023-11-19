package com.da.ojtproject.orders.controller;

import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.home.service.HomeService;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.orders.service.OrdersService;
import com.da.ojtproject.payment.service.PaymentService;
import com.da.ojtproject.selling.domain.Selling;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
//@RequestMapping("/orders")
@RequestMapping("admin/order")
@RequiredArgsConstructor
public class OrdersController {
    private final OrdersService ordersService;
    private final CategoryService categoryService;
    private final HomeService homeService;
    private final PaymentService paymentService;

    /**
     * 결제 성공시 결과 화면
     */
    @GetMapping("/result")
    public String showPaymentResult(@RequestParam("imp_uid") String impUid, Model model, HttpSession session) {
        int lastOrderNumber = homeService.getLastOrderNumber();
        model.addAttribute("currentOrderUid", lastOrderNumber);
        return "/payment/result"; // result.html 페이지 이름
    }

    /**
     * Order 기본 화면
     */
    @GetMapping()
    public String orderForm(Model model) {
        model.addAttribute("orders", new Orders());
        model.addAttribute("ordersList", ordersService.getAllOrdersProducts());
        model.addAttribute("categoryList", categoryService.getAllCategory());
        return "admin/orders/orders";
    }

    /**
     * Ajax html 비동기 화면 반환
     */
    @GetMapping("/orders-list")
    public String productList(Model model, @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("orders", new Orders());
        model.addAttribute("ordersList", ordersService.getSearchOrders(data));
        return "admin/orders/ajax/ordersList";
    }

    @ResponseBody
    @PostMapping("/refundAll")
    public ResponseEntity<?> fullRefund(@RequestParam int ordersId) {
        boolean result = ordersService.refundAll(ordersId);

        Map<String, String> response = new HashMap<>();
        if (result) {
            response.put("message", "환불 처리가 완료되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "환불 처리에 실패하였습니다.");
            return ResponseEntity.badRequest().body(response);
        }
    }

    // AJAX를 통해 부분 환불 정보를 불러오는 엔드포인트
    @GetMapping("/getPartialRefundDetails")
    public String getPartialRefundDetails(@RequestParam("ordersId") int ordersId, Model model) {
//        List<Selling> sellingList = sellingService.getSellingsByOrdersId(ordersId); 최초 번호 77
        List<Selling> sellingList = ordersService.getSellingsByOrdersId(ordersId);
        model.addAttribute("sellingList", sellingList);
        // 부분 환불 정보를 담은 Thymeleaf 뷰의 이름을 반환합니다.
        // "partialRefundDetails"는 src/main/resources/templates/admin/order 디렉터리 내에 있는 .html 파일의 이름입니다.
        return "admin/orders/partialRefundDetails";
    }

    // 부분환불 처리 코드
    @ResponseBody
    @PostMapping("/partialRefund")
    public ResponseEntity<?> partialRefund(@RequestParam int ordersId2, @RequestParam int productId2) {
        boolean result = ordersService.partialRefund(ordersId2, productId2);

        Map<String, String> response = new HashMap<>();
        if (result) {
            response.put("message", "환불 처리가 완료되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "환불 처리에 실패하였습니다.");
            return ResponseEntity.badRequest().body(response);
        }
    }

    // 부분환불 취소 처리 코드
    @ResponseBody
    @PostMapping("/partialRefundCancel")
    public ResponseEntity<?> partialRefundCancel(@RequestParam int ordersId4, @RequestParam int productId4) {
        boolean result = ordersService.partialRefundCancel(ordersId4, productId4);

        Map<String, String> response = new HashMap<>();
        if (result) {
            response.put("message", "부분 환불 처리가 완료되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "부분 환불 처리에 실패하였습니다.");
            return ResponseEntity.badRequest().body(response);
        }
    }

    /* 여기서 자꾸 문제가 발생합니다. 원인이 뭔지 모르겠음...*/
    @ResponseBody
    @PostMapping("/refundAllCancel")
    public ResponseEntity<?> fullRefundCancel(@RequestParam int ordersId3) {
        boolean result = ordersService.refundAllCancel(ordersId3);

        Map<String, String> response = new HashMap<>();
        if (result) {
            response.put("message", "전체 환불 처리가 완료되었습니다. - OrdersController");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "전체 환불 처리에 실패하였습니다.");
            return ResponseEntity.badRequest().body(response);
        }
    }

    // 날짜별 정렬을 위한 컨트롤러 메서드
    @GetMapping("/sort-by-date")
    public String productList(Model model, @RequestParam(required = false, defaultValue = "asc") String order) {
        model.addAttribute("orders", new Orders());
        model.addAttribute("ordersList", ordersService.sortOrdersByDate(order)); // 'asc' 또는 'desc'에 따라 정렬
        return "admin/orders/ajax/ordersList";
    }

    @GetMapping("/search-by-date")
    public String searchOrdersByDate(@RequestParam String startDate, @RequestParam String endDate, Model model) {
        model.addAttribute("orders", new Orders());
        // 서비스 메서드를 호출하여 해당 날짜 범위의 주문 데이터를 조회합니다.
        model.addAttribute("ordersList", ordersService.searchOrdersByDate(startDate, endDate));
        return "admin/orders/ajax/ordersList";
    }

    @GetMapping("/search-by-key")
    public String searchOrdersByKey(@RequestParam("type") String searchType,
                                    @RequestParam("query") String searchQuery,
                                    Model model) {
        // 검색 타입에 따라 다른 검색 로직을 수행할 수 있습니다.
        List<Orders> ordersList;
        switch (searchType) {
            case "receiving_number":
                // 예시: 입고번호에 따른 검색 로직
                ordersList = ordersService.searchOrdersByReceivingNumber(searchQuery);
                break;
            // 다른 검색 타입에 대한 케이스 추가 가능
            default:
                // 기본적인 처리 또는 예외 처리
                ordersList = Collections.emptyList();
                break;
        }
        model.addAttribute("ordersList", ordersList);
        return "admin/orders/ajax/ordersList"; // 검색 결과를 보여줄 뷰
    }

    @GetMapping("/fetch-orders")
    public String fetchOrders(@RequestParam("type") String type, Model model) {
        List<Orders> ordersList;
        if ("refund".equals(type)) {
            ordersList = ordersService.getRefundOrders(); // 환불 주문 조회
        } else if ("refund2".equals(type)) {
            ordersList = ordersService.getNotRefundOrders();
        } else {
            ordersList = ordersService.getAllOrdersProducts(); // 전체 주문 조회
        }

        model.addAttribute("ordersList", ordersList);
        return "admin/orders/ajax/ordersList"; // 주문 목록을 보여줄 뷰
    }


}
