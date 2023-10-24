package com.da.ojtproject.admin.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class Admin {
    private int adminId;
    private String password;

    public Admin() {

    }
}
