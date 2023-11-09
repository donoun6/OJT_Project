package com.da.ojtproject.orders.domain;

import com.da.ojtproject.selling.domain.Selling;
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

    //외부객체
    private Selling selling;

}
