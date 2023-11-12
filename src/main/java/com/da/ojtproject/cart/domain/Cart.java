package com.da.ojtproject.cart.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
//    장바구니 목록을 조회할때 이름이 필요한데 이름이 출력되지 않는다. 이름을 출력하기 위한 방법 강구가 필요하다.
    private int cartId;
    private int productId;
    private int quantity;
    private int totalPrice;
    private String image;
    private String productName;
}
