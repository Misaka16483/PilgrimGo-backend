package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.dto.SpotMapCluster;
import com.misaka.demo.entity.Spot;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface SpotMapper extends BaseMapper<Spot> {

    @Select("SELECT * FROM spot WHERE anitabi_point_id = #{pointId} LIMIT 1")
    Spot selectByAnitabiPointId(@Param("pointId") String pointId);

    @Select("SELECT * FROM spot " +
            "WHERE location IS NOT NULL " +
            "  AND (#{animeId} IS NULL OR anime_id = #{animeId}) " +
            "  AND location && ST_MakeEnvelope(#{minLng}, #{minLat}, #{maxLng}, #{maxLat}, 4326) " +
            "  AND ST_Intersects(location, ST_MakeEnvelope(#{minLng}, #{minLat}, #{maxLng}, #{maxLat}, 4326)) " +
            "ORDER BY id ASC " +
            "LIMIT #{limit}")
    List<Spot> selectInBounds(@Param("minLat") BigDecimal minLat,
                              @Param("maxLat") BigDecimal maxLat,
                              @Param("minLng") BigDecimal minLng,
                              @Param("maxLng") BigDecimal maxLng,
                              @Param("limit") int limit,
                              @Param("animeId") Integer animeId);

    @Select("SELECT AVG(latitude)::double precision AS latitude, " +
            "       AVG(longitude)::double precision AS longitude, " +
            "       COUNT(*)::int AS count " +
            "FROM spot " +
            "WHERE location IS NOT NULL " +
            "  AND (#{animeId} IS NULL OR anime_id = #{animeId}) " +
            "  AND location && ST_MakeEnvelope(#{minLng}, #{minLat}, #{maxLng}, #{maxLat}, 4326) " +
            "  AND ST_Intersects(location, ST_MakeEnvelope(#{minLng}, #{minLat}, #{maxLng}, #{maxLat}, 4326)) " +
            "GROUP BY FLOOR(latitude / #{cellSize}), FLOOR(longitude / #{cellSize}) " +
            "ORDER BY count DESC " +
            "LIMIT #{limit}")
    List<SpotMapCluster> selectClustersInBounds(@Param("minLat") BigDecimal minLat,
                                                @Param("maxLat") BigDecimal maxLat,
                                                @Param("minLng") BigDecimal minLng,
                                                @Param("maxLng") BigDecimal maxLng,
                                                @Param("cellSize") BigDecimal cellSize,
                                                @Param("limit") int limit,
                                                @Param("animeId") Integer animeId);

    @Update("UPDATE spot " +
            "SET location = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326) " +
            "WHERE latitude IS NOT NULL " +
            "  AND longitude IS NOT NULL " +
            "  AND location IS NULL")
    int backfillMissingLocations();

    @Update("UPDATE spot " +
            "SET location = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326) " +
            "WHERE id = #{id} " +
            "  AND latitude IS NOT NULL " +
            "  AND longitude IS NOT NULL")
    int updateLocationById(@Param("id") Long id);
}
