package com.misaka.demo.dto;

import lombok.Data;

/** PATCH /api/checkins|routes/{id}/visibility 请求体。 */
@Data
public class VisibilityRequest {
    private Boolean isPublic;
}
