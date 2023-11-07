package com.da.ojtproject.orders.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Orders {
    private int ordersId;
    private boolean checkOrders;
    private Date registerDate;
//    private String impUid; // 결제 고유번호
}
