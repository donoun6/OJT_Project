package com.da.ojtproject.product.domain;

import com.da.ojtproject.category.domain.Category;
import com.da.ojtproject.inventory.domain.Inventory;
import com.da.ojtproject.selling.domain.Selling;
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
    //외부 객체
    private Category category;
    private Inventory inventory;
    private Selling selling;
}

