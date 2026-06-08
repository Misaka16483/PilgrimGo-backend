package com.misaka.demo.dto;

import lombok.Data;

@Data
public class BindPhoneRequest {
    private String phone;
    private String smsCode;
}
