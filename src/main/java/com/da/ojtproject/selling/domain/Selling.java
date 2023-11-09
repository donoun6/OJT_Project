package com.da.ojtproject.selling.domain;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.orders.domain.Orders;
import com.da.ojtproject.product.domain.Product;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Selling {
    private int sellingId;
    private int productId;
    private int ordersId;
    private int quantity;
    private int totalPrice;
    private boolean checkSelling;
    private Date registerDate;
    private String productName; // Product의 name에 해당하는 필드

    //외부 객체
    private Product product;
    private Category category;
    private Orders orders;
}
