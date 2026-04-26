package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.entity.Spot;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface SpotMapper extends BaseMapper<Spot> {

    /**
     * 经纬度边界框初筛 + Haversine 距离精排，避免依赖 PostGIS location 列是否已填充。
     * latMin/latMax/lngMin/lngMax 由 Service 端按半径预算（米）换算后传入。
     */
    @Select("SELECT * FROM spot " +
            "WHERE latitude BETWEEN #{latMin} AND #{latMax} " +
            "  AND longitude BETWEEN #{lngMin} AND #{lngMax} " +
            "ORDER BY ( " +
            "    (latitude - #{lat}) * (latitude - #{lat}) + " +
            "    (longitude - #{lng}) * (longitude - #{lng}) " +
            ") ASC " +
            "LIMIT #{limit}")
    List<Spot> selectNearby(@Param("lat") BigDecimal lat,
                            @Param("lng") BigDecimal lng,
                            @Param("latMin") BigDecimal latMin,
                            @Param("latMax") BigDecimal latMax,
                            @Param("lngMin") BigDecimal lngMin,
                            @Param("lngMax") BigDecimal lngMax,
                            @Param("limit") int limit);

    /** 根据 anitabi_point_id 唯一键查询，用于 upsert 判重。 */
    @Select("SELECT * FROM spot WHERE anitabi_point_id = #{pointId} LIMIT 1")
    Spot selectByAnitabiPointId(@Param("pointId") String pointId);
}
