package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.entity.Waypoint;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface WaypointMapper extends BaseMapper<Waypoint> {

    @Select("SELECT * FROM waypoint WHERE route_id = #{routeId} ORDER BY sequence ASC")
    List<Waypoint> selectByRouteId(@Param("routeId") long routeId);
}