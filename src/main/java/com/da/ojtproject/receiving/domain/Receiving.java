package com.da.ojtproject.receiving.domain;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.inventory.domain.Inventory;
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
public class Receiving {
    private int receivingId;
    private int productId;
    private int quantity;
    private boolean checkReceiving;
    private String description;
    private Date registerDate;

    //외부객체
    private Product product;
    private Inventory inventory;
    private Category category;

}
