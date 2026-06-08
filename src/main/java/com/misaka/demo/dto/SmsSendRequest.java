package com.misaka.demo.dto;

import lombok.Data;

@Data
public class SmsSendRequest {
    private String phone;
    private String type; // REGISTER, LOGIN, RESET_PASSWORD
}
