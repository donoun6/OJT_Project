package com.da.ojtproject.selling.domain;

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
}
