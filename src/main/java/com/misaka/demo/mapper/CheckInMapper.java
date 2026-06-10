package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.dto.CheckInVO;
import com.misaka.demo.entity.CheckIn;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface CheckInMapper extends BaseMapper<CheckIn> {

    @Select("""
        SELECT ci.id, ci.user_id, ci.spot_id, ci.route_id,
               ci.photo_url, ci.comparison_url, ci.content,
               ci.latitude, ci.longitude, ci.like_count, ci.is_public, ci.created_at,
               u.username, u.avatar_url,
               s.name AS spot_name, s.name_cn AS spot_name_cn,
               EXISTS (
                   SELECT 1 FROM checkin_like cl
                   WHERE cl.check_in_id = ci.id AND cl.user_id = #{userId}
               ) AS liked
        FROM check_in ci
        JOIN "user" u ON ci.user_id = u.id
        JOIN spot s ON ci.spot_id = s.id
        WHERE (ci.is_public = TRUE OR ci.user_id = #{userId})
        ORDER BY ci.created_at DESC
        LIMIT #{limit} OFFSET #{offset}
    """)
    List<CheckInVO> selectFeed(@Param("userId") Long userId,
                                @Param("limit") int limit,
                                @Param("offset") int offset);

    @Select("""
        SELECT ci.id, ci.user_id, ci.spot_id, ci.route_id,
               ci.photo_url, ci.comparison_url, ci.content,
               ci.latitude, ci.longitude, ci.like_count, ci.is_public, ci.created_at,
               u.username, u.avatar_url,
               s.name AS spot_name, s.name_cn AS spot_name_cn,
               EXISTS (
                   SELECT 1 FROM checkin_like cl
                   WHERE cl.check_in_id = ci.id AND cl.user_id = #{userId}
               ) AS liked
        FROM check_in ci
        JOIN "user" u ON ci.user_id = u.id
        JOIN spot s ON ci.spot_id = s.id
        WHERE ci.spot_id = #{spotId}
          AND (ci.is_public = TRUE OR ci.user_id = #{userId})
        ORDER BY ci.created_at DESC
        LIMIT #{limit} OFFSET #{offset}
    """)
    List<CheckInVO> selectBySpot(@Param("userId") Long userId,
                                  @Param("spotId") Long spotId,
                                  @Param("limit") int limit,
                                  @Param("offset") int offset);

    /** "我的打卡"：当前用户自己发布的全部打卡，按时间倒序分页。liked 仍按本人视角计算。 */
    @Select("""
        SELECT ci.id, ci.user_id, ci.spot_id, ci.route_id,
               ci.photo_url, ci.comparison_url, ci.content,
               ci.latitude, ci.longitude, ci.like_count, ci.is_public, ci.created_at,
               u.username, u.avatar_url,
               s.name AS spot_name, s.name_cn AS spot_name_cn,
               EXISTS (
                   SELECT 1 FROM checkin_like cl
                   WHERE cl.check_in_id = ci.id AND cl.user_id = #{userId}
               ) AS liked
        FROM check_in ci
        JOIN "user" u ON ci.user_id = u.id
        JOIN spot s ON ci.spot_id = s.id
        WHERE ci.user_id = #{userId}
        ORDER BY ci.created_at DESC
        LIMIT #{limit} OFFSET #{offset}
    """)
    List<CheckInVO> selectByUser(@Param("userId") Long userId,
                                  @Param("limit") int limit,
                                  @Param("offset") int offset);

    /** 拉一条路径里、作者本人打的全部观景点照片，给重放页"观景地"区块用。 */
    @Select("""
        SELECT * FROM check_in
        WHERE route_id = #{routeId} AND user_id = #{userId}
        ORDER BY spot_id ASC, created_at ASC
    """)
    List<CheckIn> selectByRouteAndUser(@Param("routeId") long routeId,
                                        @Param("userId") long userId);

    @Select("SELECT COUNT(DISTINCT spot_id) FROM check_in WHERE user_id = #{userId}")
    Integer selectDistinctSpotCountByUserId(@Param("userId") Long userId);

    @Select("SELECT TO_CHAR(created_at, 'YYYY-MM') as month, COUNT(*) as count " +
            "FROM check_in WHERE user_id = #{userId} " +
            "GROUP BY TO_CHAR(created_at, 'YYYY-MM') " +
            "ORDER BY month DESC")
    List<Map<String, Object>> selectMonthlyStatsByUserId(@Param("userId") Long userId);
}