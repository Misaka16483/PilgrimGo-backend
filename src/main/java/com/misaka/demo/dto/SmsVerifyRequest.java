package com.misaka.demo.dto;

import lombok.Data;

@Data
public class SmsVerifyRequest {
    private String phone;
    private String code;
    private String type; // REGISTER, LOGIN, RESET_PASSWORD
}