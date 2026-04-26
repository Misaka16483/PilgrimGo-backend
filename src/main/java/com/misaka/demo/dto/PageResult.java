package com.misaka.demo.dto;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.function.Function;

/** 与前端 src/types/index.ts 中的 PageResult 字段保持一致。 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageResult<T> {
    private List<T> content;
    private long totalElements;
    private long totalPages;
    private long number;
    private long size;
    private boolean last;

    public static <E, T> PageResult<T> from(IPage<E> page, Function<E, T> mapper) {
        List<T> content = page.getRecords().stream().map(mapper).toList();
        long current = page.getCurrent() - 1;
        long totalPages = page.getPages();
        return new PageResult<>(
                content,
                page.getTotal(),
                totalPages,
                current,
                page.getSize(),
                current >= totalPages - 1
        );
    }
}
