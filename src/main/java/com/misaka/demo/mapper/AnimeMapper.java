package com.misaka.demo.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.misaka.demo.entity.Anime;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AnimeMapper extends BaseMapper<Anime> {
}
