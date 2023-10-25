package com.da.ojtproject.cart.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
    private int cartId;
    private int productId;
    private int quantity;
    private int totalPrice;
}
