package com.misaka.demo.dto;

import lombok.Data;

@Data
public class LoginWithSmsRequest {
    private String phone;
    private String code;
    private String type;
}
