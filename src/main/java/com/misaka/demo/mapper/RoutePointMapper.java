package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.entity.RoutePoint;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface RoutePointMapper extends BaseMapper<RoutePoint> {

    @Select("SELECT * FROM route_point WHERE route_id = #{routeId} ORDER BY sequence ASC")
    List<RoutePoint> selectByRouteId(@Param("routeId") long routeId);
}