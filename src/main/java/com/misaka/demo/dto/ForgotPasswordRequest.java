package com.misaka.demo.dto;

import lombok.Data;

@Data
public class ForgotPasswordRequest {
    private String phone;
    private String smsCode;
    private String newPassword;
}
