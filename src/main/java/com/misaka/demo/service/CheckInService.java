package com.misaka.demo.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.misaka.demo.dto.CheckInRequest;
import com.misaka.demo.dto.CheckInVO;
import com.misaka.demo.entity.CheckIn;
import com.misaka.demo.entity.CheckInLike;
import com.misaka.demo.mapper.CheckInLikeMapper;
import com.misaka.demo.mapper.CheckInMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CheckInService {

    public record LikeResult(boolean liked, int likeCount) {}

    @Autowired
    private CheckInMapper checkInMapper;

    @Autowired
    private CheckInLikeMapper checkInLikeMapper;

    public CheckIn create(Long userId, CheckInRequest req) {
        if (req.getSpotId() == null) {
            throw new RuntimeException("spotId 不能为空");
        }
        CheckIn checkIn = new CheckIn();
        checkIn.setUserId(userId);
        checkIn.setSpotId(req.getSpotId());
        checkIn.setRouteId(req.getRouteId());
        checkIn.setPhotoUrl(req.getPhotoUrl());
        checkIn.setComparisonUrl(req.getComparisonUrl());
        checkIn.setContent(req.getContent());
        checkIn.setLatitude(req.getLatitude());
        checkIn.setLongitude(req.getLongitude());
        checkIn.setLikeCount(0);
        checkIn.setCreatedAt(LocalDateTime.now());
        checkInMapper.insert(checkIn);
        return checkIn;
    }

    public List<CheckInVO> getFeed(Long userId, int page, int size) {
        return checkInMapper.selectFeed(userId, size, (page - 1) * size);
    }

    public List<CheckInVO> getBySpot(Long userId, Long spotId, int page, int size) {
        return checkInMapper.selectBySpot(userId, spotId, size, (page - 1) * size);
    }

    /** "我的打卡"：当前用户自己的打卡列表。 */
    public List<CheckInVO> getMine(Long userId, int page, int size) {
        return checkInMapper.selectByUser(userId, size, (page - 1) * size);
    }

    public LikeResult like(Long userId, Long checkInId) {
        long exists = checkInLikeMapper.selectCount(new QueryWrapper<CheckInLike>()
                .eq("user_id", userId)
                .eq("check_in_id", checkInId));
        if (exists > 0) {
            checkInLikeMapper.delete(new QueryWrapper<CheckInLike>()
                    .eq("user_id", userId)
                    .eq("check_in_id", checkInId));
            checkInMapper.update(null, new UpdateWrapper<CheckIn>()
                    .eq("id", checkInId)
                    .setSql("like_count = GREATEST(like_count - 1, 0)"));
        } else {
            CheckInLike like = new CheckInLike();
            like.setUserId(userId);
            like.setCheckInId(checkInId);
            like.setCreatedAt(LocalDateTime.now());
            checkInLikeMapper.insert(like);
            checkInMapper.update(null, new UpdateWrapper<CheckIn>()
                    .eq("id", checkInId)
                    .setSql("like_count = like_count + 1"));
        }
        CheckIn updated = checkInMapper.selectById(checkInId);
        return new LikeResult(exists == 0, updated.getLikeCount());
    }
}