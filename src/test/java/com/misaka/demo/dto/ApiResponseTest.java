package com.misaka.demo.dto;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ApiResponseTest {

    @Test
    void ok_setsCode200AndPayload() {
        ApiResponse<String> r = ApiResponse.ok("hello");
        assertEquals(200, r.getCode());
        assertEquals("success", r.getMessage());
        assertEquals("hello", r.getData());
    }

    @Test
    void ok_acceptsNullPayload() {
        ApiResponse<String> r = ApiResponse.ok(null);
        assertEquals(200, r.getCode());
        assertNull(r.getData());
    }

    @Test
    void error_setsCustomCodeAndNullData() {
        ApiResponse<Object> r = ApiResponse.error(404, "not found");
        assertEquals(404, r.getCode());
        assertEquals("not found", r.getMessage());
        assertNull(r.getData());
    }
}
