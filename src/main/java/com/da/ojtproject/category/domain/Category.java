package com.da.ojtproject.category.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Category {

    private int categoryId;
    private String name;
    private boolean checkCategory;
    private Timestamp registerDate;

}
