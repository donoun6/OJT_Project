package com.da.ojtproject.receiving.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Receiving {
    private int receivingId;
    private int productId;
    private int quantity;
    private Date registerDate;

}
