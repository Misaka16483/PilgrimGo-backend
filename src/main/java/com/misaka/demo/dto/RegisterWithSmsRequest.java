package com.misaka.demo.dto;

import lombok.Data;

@Data
public class RegisterWithSmsRequest {
    private String phone;
    private String password;
    private String nickname;
    private String smsCode;
}