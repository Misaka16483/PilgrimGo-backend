package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.dto.RouteReviewVO;
import com.misaka.demo.entity.RouteRating;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface RouteRatingMapper extends BaseMapper<RouteRating> {

    /** 路径的评价列表，带评价人昵称/头像；有文字评论的优先靠前，再按时间倒序。 */
    @Select("""
        SELECT rr.id, rr.route_id, rr.user_id, rr.score, rr.comment, rr.created_at,
               COALESCE(NULLIF(u.nickname, ''), u.username) AS author_name,
               u.avatar_url AS author_avatar
        FROM route_rating rr
        JOIN "user" u ON rr.user_id = u.id
        WHERE rr.route_id = #{routeId}
        ORDER BY (rr.comment IS NOT NULL AND rr.comment <> '') DESC, rr.created_at DESC
        LIMIT #{limit} OFFSET #{offset}
    """)
    List<RouteReviewVO> selectReviews(@Param("routeId") long routeId,
                                      @Param("limit") int limit,
                                      @Param("offset") int offset);

    /** 用聚合结果回写 route.avg_rating / rating_count，保持冗余统计与明细一致。 */
    @Update("""
        UPDATE route SET
            avg_rating = COALESCE((SELECT ROUND(AVG(score)::numeric, 1)
                                   FROM route_rating WHERE route_id = #{routeId}), 0),
            rating_count = (SELECT COUNT(*) FROM route_rating WHERE route_id = #{routeId})
        WHERE id = #{routeId}
    """)
    void recalcRouteRating(@Param("routeId") long routeId);
}
