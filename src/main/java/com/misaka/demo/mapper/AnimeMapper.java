package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.misaka.demo.entity.Anime;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface AnimeMapper extends BaseMapper<Anime> {
    @Select("SELECT a.* FROM anime a " +
            "WHERE EXISTS (" +
            "  SELECT 1 FROM spot s WHERE s.anime_id = a.bangumi_id" +
            ") " +
            "ORDER BY a.synced_at DESC NULLS LAST, a.bangumi_id DESC " +
            "LIMIT #{limit}")
    List<Anime> selectCachedAnimeOptions(@Param("limit") int limit);

    @Select({
            "<script>",
            "SELECT a.* FROM anime a",
            "WHERE EXISTS (",
            "  SELECT 1 FROM spot s WHERE s.anime_id = a.bangumi_id",
            ")",
            "<if test='keyword != null and keyword != \"\"'>",
            "AND (",
            "  a.title_cn LIKE CONCAT('%', #{keyword}, '%')",
            "  OR a.title_jp LIKE CONCAT('%', #{keyword}, '%')",
            "  OR a.title_en LIKE CONCAT('%', #{keyword}, '%')",
            "  OR a.abbr LIKE CONCAT('%', #{keyword}, '%')",
            ")",
            "</if>",
            "ORDER BY a.synced_at DESC NULLS LAST, a.bangumi_id DESC",
            "</script>"
    })
    Page<Anime> selectSearchAnimeWithSpots(Page<Anime> page, @Param("keyword") String keyword);

    @Select("SELECT a.*, " +
            "  (SELECT COUNT(*) FROM spot s WHERE s.anime_id = a.bangumi_id AND s.location IS NOT NULL) AS points_count " +
            "FROM anime a " +
            "WHERE EXISTS (" +
            "  SELECT 1 FROM spot s WHERE s.anime_id = a.bangumi_id AND s.location IS NOT NULL" +
            ") " +
            "ORDER BY a.synced_at DESC NULLS LAST, a.bangumi_id DESC " +
            "LIMIT #{limit}")
    List<Anime> selectMapAnimeOptions(@Param("limit") int limit);

    @Select("SELECT COUNT(*) FROM spot WHERE anime_id = #{animeId}")
    Long countSpotsByAnimeId(@Param("animeId") int animeId);

    @Select({
            "<script>",
            "SELECT anime_id, COUNT(*) AS spot_count",
            "FROM spot",
            "WHERE anime_id IN",
            "<foreach collection='animeIds' item='animeId' open='(' separator=',' close=')'>",
            "#{animeId}",
            "</foreach>",
            "GROUP BY anime_id",
            "</script>"
    })
    List<Map<String, Object>> selectSpotCountsByAnimeIds(@Param("animeIds") List<Integer> animeIds);
}
