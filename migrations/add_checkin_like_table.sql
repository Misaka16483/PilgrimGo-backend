-- Migration: 新增 checkin_like 表，支持点赞去重与取消点赞
-- 作者: 成员E
-- 日期: 2026-05-15
-- 说明: check_in 表原只有 like_count 计数，无法防止重复点赞。
--       本迁移新增明细表记录"谁点赞了哪条打卡"，并加唯一约束。

CREATE TABLE public.checkin_like (
    id          bigserial PRIMARY KEY,
    check_in_id bigint NOT NULL REFERENCES public.check_in(id),
    user_id     bigint NOT NULL REFERENCES public."user"(id),
    created_at  timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT checkin_like_check_in_id_user_id_key UNIQUE (check_in_id, user_id)
);

CREATE INDEX idx_checkin_like_check_in_id ON public.checkin_like USING btree (check_in_id);
CREATE INDEX idx_checkin_like_user_id     ON public.checkin_like USING btree (user_id);
