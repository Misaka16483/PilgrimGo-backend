package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.entity.Anime;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AnimeMapper extends BaseMapper<Anime> {
    @Select("SELECT a.* FROM anime a " +
            "JOIN (" +
            "  SELECT anime_id, COUNT(*) AS spot_count " +
            "  FROM spot " +
            "  WHERE location IS NOT NULL " +
            "  GROUP BY anime_id" +
            ") s ON s.anime_id = a.bangumi_id " +
            "ORDER BY s.spot_count DESC, a.synced_at DESC NULLS LAST " +
            "LIMIT #{limit}")
    List<Anime> selectMapAnimeOptions(@Param("limit") int limit);
}
