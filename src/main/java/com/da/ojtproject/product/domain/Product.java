package com.da.ojtproject.product.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    private int productId;
    private int categoryId;
    private String name;
    private String code;
    private int sellPrice;
    private String image;
    private MultipartFile imageFile;
    private boolean checkProduct;
    private Date registerDate;
}
