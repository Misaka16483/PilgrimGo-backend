package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.entity.Route;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;

@Mapper
public interface RouteMapper extends BaseMapper<Route> {

    @Select("SELECT COALESCE(SUM(distance_km), 0) FROM route WHERE user_id = #{userId}")
    BigDecimal selectTotalDistanceByUserId(@Param("userId") Long userId);

    @Select("SELECT COALESCE(SUM(estimated_minutes), 0) FROM route WHERE user_id = #{userId}")
    Integer selectTotalDurationByUserId(@Param("userId") Long userId);

    /** pilgrimage_record 没有对应实体，但 route_id 外键非空，删路径前要先清掉引用行。 */
    @Delete("DELETE FROM pilgrimage_record WHERE route_id = #{routeId}")
    int deletePilgrimageRecordsByRouteId(@Param("routeId") long routeId);
}