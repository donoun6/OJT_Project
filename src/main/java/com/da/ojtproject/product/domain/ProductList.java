package com.da.ojtproject.product.domain;

import com.da.ojtproject.cart.domain.Cart;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ProductList {
    private int productId;
    private String name;
    private String code;
    private int sellPrice;
    private String image;
    private int categoryId;
    private String categoryName;
    private int inventoryId;
    private int inventoryQuantity;
    private int sellingId;
    private int sellingQuantity;
    private int totalPrice;
}
