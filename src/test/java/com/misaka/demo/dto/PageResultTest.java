package com.misaka.demo.dto;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class PageResultTest {

    @Test
    void from_mapsRecordsAndConvertsPageNumbersToZeroBased() {
        Page<String> page = new Page<>(2, 10);   // MyBatis-Plus 1-based current
        page.setRecords(List.of("a", "b", "c"));
        page.setTotal(25);

        PageResult<Integer> result = PageResult.from(page, String::length);

        assertEquals(List.of(1, 1, 1), result.getContent());
        assertEquals(25L, result.getTotalElements());
        assertEquals(3L, result.getTotalPages());
        assertEquals(1L, result.getNumber());      // zero-based
        assertEquals(10L, result.getSize());
        assertFalse(result.isLast());
    }

    @Test
    void from_lastPageMarksLastTrue() {
        Page<String> page = new Page<>(3, 10);     // current=3 → 0-based=2
        page.setRecords(List.of("x"));
        page.setTotal(21);                          // pages = ceil(21/10) = 3

        PageResult<String> result = PageResult.from(page, s -> s);

        assertTrue(result.isLast());
        assertEquals(2L, result.getNumber());
        assertEquals(3L, result.getTotalPages());
    }

    @Test
    void from_emptyPageIsLast() {
        Page<String> page = new Page<>(1, 10);
        page.setRecords(List.of());
        page.setTotal(0);

        PageResult<String> result = PageResult.from(page, s -> s);

        assertTrue(result.getContent().isEmpty());
        assertEquals(0L, result.getTotalElements());
        assertTrue(result.isLast());
    }
}
