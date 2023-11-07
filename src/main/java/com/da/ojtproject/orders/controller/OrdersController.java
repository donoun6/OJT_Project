package com.da.ojtproject.orders.controller;

import com.da.ojtproject.category.service.CategoryService;
import com.da.ojtproject.orders.service.OrdersService;
import com.da.ojtproject.product.domain.Product;
import com.da.ojtproject.product.service.ProductService;
import com.da.ojtproject.receiving.service.ReceivingService;
import com.da.ojtproject.selling.domain.Selling;
import com.da.ojtproject.selling.service.SellingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
//@RequestMapping("/orders")
@RequestMapping("admin/order")
@RequiredArgsConstructor
public class OrdersController {

    private final OrdersService ordersService;
    private final CategoryService categoryService;
    private final ProductService productService;
    private final ReceivingService receivingService;
    private final SellingService sellingService;

    @GetMapping("/result")
    public String showPaymentResult(@RequestParam("imp_uid") String impUid, Model model, HttpSession session) {

        Integer currentOrderUid = (Integer) session.getAttribute("currentOrderUid");

        if (currentOrderUid == null) {
            currentOrderUid = 951008;
        }

        session.setAttribute("currentOrderUid", currentOrderUid);
        model.addAttribute("currentOrderUid", currentOrderUid);

        return "/payment/result"; // result.html 페이지 이름
    }
    /**
     * Order 기본 화면
     */
    @GetMapping()
    public String orderForm(Model model) {
        model.addAttribute("orders", new Selling());
        model.addAttribute("ordersList", ordersService.getAllOrdersProducts());
        model.addAttribute("categoryList", categoryService.getAllCategory());
        return "admin/orders/orders";
    }

    @GetMapping("/orders-list")
    public String productList(Model model,
                              @RequestParam(required = false) Map<String, Object> data) {
        model.addAttribute("orders", new Selling());
        model.addAttribute("ordersList", ordersService.getSearchOrders(data));
        return "admin/orders/ajax/ordersList";
    }


}
