package com.da.ojtproject.payment.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Payment {

    private int paymentId; // payment_id
    private int ordersId; // orders_id
    private String paymentMethod; // payment_method
    private int paymentAmount; // payment_amount
    private Timestamp paymentDate; // payment_date

}
