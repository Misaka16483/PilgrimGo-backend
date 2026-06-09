package com.misaka.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/** route_rating 一行 = 某用户对某路径的一次评价（评分 + 可选文字评论）。
 *  (route_id, user_id) 唯一，所以同一用户重复提交是覆盖而非新增。 */
@Data
@TableName("route_rating")
public class RouteRating {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private Long routeId;
    private Long userId;
    private Integer score;
    private String comment;
    private LocalDateTime createdAt;
}
