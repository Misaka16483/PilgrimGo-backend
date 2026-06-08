package com.misaka.demo.dto;

import lombok.Data;

import java.util.List;

/**
 * 用户巡礼统计VO
 */
@Data
public class UserStatsVO {
    /** 已巡礼作品数 */
    private int totalAnimes;

    /** 已打卡取景地数 */
    private int totalSpots;

    /** 录制路径数 */
    private int totalRoutes;

    /** 总里程（公里） */
    private double totalDistance;

    /** 总时长（分钟） */
    private int totalDuration;

    /** 连续巡礼天数 */
    private int currentStreak;

    /** 按月统计 */
    private List<MonthlyStats> monthlyStats;

    @Data
    public static class MonthlyStats {
        /** 月份，格式：2026-05 */
        private String month;
        /** 该月打卡数 */
        private int checkInCount;
        /** 该月里程 */
        private double distance;
    }
}
