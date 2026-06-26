--
-- PostgreSQL database dump
--

\restrict yb4FonfIre1GFt1xBs0lCGFX2waeJPfwiCSrkdxiVNZDOjadgeci0RZFkjiKwHb

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.waypoint DROP CONSTRAINT IF EXISTS waypoint_spot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.waypoint DROP CONSTRAINT IF EXISTS waypoint_route_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_achievement DROP CONSTRAINT IF EXISTS user_achievement_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_achievement DROP CONSTRAINT IF EXISTS user_achievement_achievement_id_fkey;
ALTER TABLE IF EXISTS ONLY public.spot DROP CONSTRAINT IF EXISTS spot_anime_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route DROP CONSTRAINT IF EXISTS route_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_spot DROP CONSTRAINT IF EXISTS route_spot_spot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_spot DROP CONSTRAINT IF EXISTS route_spot_route_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_rating DROP CONSTRAINT IF EXISTS route_rating_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_rating DROP CONSTRAINT IF EXISTS route_rating_route_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route_point DROP CONSTRAINT IF EXISTS route_point_route_id_fkey;
ALTER TABLE IF EXISTS ONLY public.route DROP CONSTRAINT IF EXISTS route_anime_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pilgrimage_record DROP CONSTRAINT IF EXISTS pilgrimage_record_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pilgrimage_record DROP CONSTRAINT IF EXISTS pilgrimage_record_route_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pilgrimage_record DROP CONSTRAINT IF EXISTS pilgrimage_record_anime_id_fkey;
ALTER TABLE IF EXISTS ONLY public.membership DROP CONSTRAINT IF EXISTS membership_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.checkin_like DROP CONSTRAINT IF EXISTS checkin_like_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.checkin_like DROP CONSTRAINT IF EXISTS checkin_like_check_in_id_fkey;
ALTER TABLE IF EXISTS ONLY public.check_in DROP CONSTRAINT IF EXISTS check_in_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.check_in DROP CONSTRAINT IF EXISTS check_in_spot_id_fkey;
ALTER TABLE IF EXISTS ONLY public.check_in DROP CONSTRAINT IF EXISTS check_in_route_id_fkey;
DROP INDEX IF EXISTS public.idx_waypoint_route_id;
DROP INDEX IF EXISTS public.idx_spot_location;
DROP INDEX IF EXISTS public.idx_spot_anime_id_id;
DROP INDEX IF EXISTS public.idx_spot_anime_id;
DROP INDEX IF EXISTS public.idx_route_user_id;
DROP INDEX IF EXISTS public.idx_route_status_created_at;
DROP INDEX IF EXISTS public.idx_route_point_route_seq;
DROP INDEX IF EXISTS public.idx_route_anime_id;
DROP INDEX IF EXISTS public.idx_pilgrimage_record_user_id;
DROP INDEX IF EXISTS public.idx_membership_user_id;
DROP INDEX IF EXISTS public.idx_checkin_like_user_id;
DROP INDEX IF EXISTS public.idx_checkin_like_check_in_id;
DROP INDEX IF EXISTS public.idx_check_in_user_id;
DROP INDEX IF EXISTS public.idx_check_in_status_created_at;
DROP INDEX IF EXISTS public.idx_check_in_spot_id;
ALTER TABLE IF EXISTS ONLY public.waypoint DROP CONSTRAINT IF EXISTS waypoint_pkey;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_username_key;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_pkey;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_phone_key;
ALTER TABLE IF EXISTS ONLY public."user" DROP CONSTRAINT IF EXISTS user_email_key;
ALTER TABLE IF EXISTS ONLY public.user_achievement DROP CONSTRAINT IF EXISTS user_achievement_user_id_achievement_id_key;
ALTER TABLE IF EXISTS ONLY public.user_achievement DROP CONSTRAINT IF EXISTS user_achievement_pkey;
ALTER TABLE IF EXISTS ONLY public.spot DROP CONSTRAINT IF EXISTS spot_pkey;
ALTER TABLE IF EXISTS ONLY public.spot DROP CONSTRAINT IF EXISTS spot_anitabi_point_id_key;
ALTER TABLE IF EXISTS ONLY public.route_spot DROP CONSTRAINT IF EXISTS route_spot_route_id_visit_order_key;
ALTER TABLE IF EXISTS ONLY public.route_spot DROP CONSTRAINT IF EXISTS route_spot_route_id_spot_id_key;
ALTER TABLE IF EXISTS ONLY public.route_spot DROP CONSTRAINT IF EXISTS route_spot_pkey;
ALTER TABLE IF EXISTS ONLY public.route_rating DROP CONSTRAINT IF EXISTS route_rating_route_id_user_id_key;
ALTER TABLE IF EXISTS ONLY public.route_rating DROP CONSTRAINT IF EXISTS route_rating_pkey;
ALTER TABLE IF EXISTS ONLY public.route_point DROP CONSTRAINT IF EXISTS route_point_pkey;
ALTER TABLE IF EXISTS ONLY public.route DROP CONSTRAINT IF EXISTS route_pkey;
ALTER TABLE IF EXISTS ONLY public.pilgrimage_record DROP CONSTRAINT IF EXISTS pilgrimage_record_pkey;
ALTER TABLE IF EXISTS ONLY public.membership DROP CONSTRAINT IF EXISTS membership_pkey;
ALTER TABLE IF EXISTS ONLY public.checkin_like DROP CONSTRAINT IF EXISTS checkin_like_pkey;
ALTER TABLE IF EXISTS ONLY public.checkin_like DROP CONSTRAINT IF EXISTS checkin_like_check_in_id_user_id_key;
ALTER TABLE IF EXISTS ONLY public.check_in DROP CONSTRAINT IF EXISTS check_in_pkey;
ALTER TABLE IF EXISTS ONLY public.anime DROP CONSTRAINT IF EXISTS anime_pkey;
ALTER TABLE IF EXISTS ONLY public.achievement DROP CONSTRAINT IF EXISTS achievement_pkey;
ALTER TABLE IF EXISTS public.waypoint ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_achievement ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public."user" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.spot ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.route_spot ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.route_rating ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.route_point ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.route ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pilgrimage_record ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.membership ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.checkin_like ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.check_in ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.achievement ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.waypoint_id_seq;
DROP TABLE IF EXISTS public.waypoint;
DROP SEQUENCE IF EXISTS public.user_id_seq;
DROP SEQUENCE IF EXISTS public.user_achievement_id_seq;
DROP TABLE IF EXISTS public.user_achievement;
DROP TABLE IF EXISTS public."user";
DROP SEQUENCE IF EXISTS public.spot_id_seq;
DROP TABLE IF EXISTS public.spot;
DROP SEQUENCE IF EXISTS public.route_spot_id_seq;
DROP TABLE IF EXISTS public.route_spot;
DROP SEQUENCE IF EXISTS public.route_rating_id_seq;
DROP TABLE IF EXISTS public.route_rating;
DROP SEQUENCE IF EXISTS public.route_point_id_seq;
DROP TABLE IF EXISTS public.route_point;
DROP SEQUENCE IF EXISTS public.route_id_seq;
DROP TABLE IF EXISTS public.route;
DROP SEQUENCE IF EXISTS public.pilgrimage_record_id_seq;
DROP TABLE IF EXISTS public.pilgrimage_record;
DROP SEQUENCE IF EXISTS public.membership_id_seq;
DROP TABLE IF EXISTS public.membership;
DROP SEQUENCE IF EXISTS public.checkin_like_id_seq;
DROP TABLE IF EXISTS public.checkin_like;
DROP SEQUENCE IF EXISTS public.check_in_id_seq;
DROP TABLE IF EXISTS public.check_in;
DROP TABLE IF EXISTS public.anime;
DROP SEQUENCE IF EXISTS public.achievement_id_seq;
DROP TABLE IF EXISTS public.achievement;
DROP EXTENSION IF EXISTS postgis;
DROP EXTENSION IF EXISTS pg_trgm;
--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievement (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    icon_url character varying(500),
    condition_type character varying(50),
    condition_value integer
);


--
-- Name: achievement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achievement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achievement_id_seq OWNED BY public.achievement.id;


--
-- Name: anime; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anime (
    bangumi_id integer NOT NULL,
    title_cn character varying(200),
    title_jp character varying(200) NOT NULL,
    title_en character varying(200),
    cat character varying(20),
    cover_url character varying(500),
    icon_url character varying(500),
    description text,
    city character varying(100),
    color character varying(10),
    abbr character varying(50),
    site character varying(500),
    release_date character varying(10),
    default_lat numeric(10,7),
    default_lng numeric(10,7),
    default_zoom numeric(5,3),
    points_count integer DEFAULT 0,
    anitabi_modified bigint,
    synced_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: check_in; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.check_in (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    spot_id bigint NOT NULL,
    route_id bigint,
    photo_url character varying(500),
    comparison_url character varying(500),
    content text,
    latitude numeric(10,7),
    longitude numeric(10,7),
    like_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    review_note text,
    reviewed_at timestamp without time zone,
    is_public boolean DEFAULT true NOT NULL,
    CONSTRAINT check_in_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('approved'::character varying)::text, ('rejected'::character varying)::text])))
);


--
-- Name: check_in_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.check_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: check_in_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.check_in_id_seq OWNED BY public.check_in.id;


--
-- Name: checkin_like; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.checkin_like (
    id bigint NOT NULL,
    check_in_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: checkin_like_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.checkin_like_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: checkin_like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.checkin_like_id_seq OWNED BY public.checkin_like.id;


--
-- Name: membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.membership (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    plan_type character varying(20) NOT NULL,
    status character varying(20) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    payment_channel character varying(20),
    transaction_id character varying(100),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: membership_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.membership_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.membership_id_seq OWNED BY public.membership.id;


--
-- Name: pilgrimage_record; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pilgrimage_record (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    anime_id integer NOT NULL,
    route_id bigint,
    spots_visited integer DEFAULT 0,
    total_spots integer,
    distance_walked numeric(6,2),
    duration_minutes integer,
    status character varying(20),
    started_at timestamp without time zone,
    finished_at timestamp without time zone
);


--
-- Name: pilgrimage_record_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pilgrimage_record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pilgrimage_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pilgrimage_record_id_seq OWNED BY public.pilgrimage_record.id;


--
-- Name: route; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.route (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    anime_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    difficulty character varying(20),
    estimated_minutes integer,
    distance_km numeric(6,2),
    gpx_file_url character varying(500),
    avg_rating numeric(2,1) DEFAULT 0,
    rating_count integer DEFAULT 0,
    follow_count integer DEFAULT 0,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    recorded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    review_note text,
    reviewed_at timestamp without time zone,
    is_public boolean DEFAULT true NOT NULL,
    CONSTRAINT route_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('approved'::character varying)::text, ('rejected'::character varying)::text])))
);


--
-- Name: route_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.route_id_seq OWNED BY public.route.id;


--
-- Name: route_point; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.route_point (
    id bigint NOT NULL,
    route_id bigint NOT NULL,
    sequence integer NOT NULL,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    altitude numeric(7,2),
    recorded_at timestamp without time zone
);


--
-- Name: route_point_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.route_point_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: route_point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.route_point_id_seq OWNED BY public.route_point.id;


--
-- Name: route_rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.route_rating (
    id bigint NOT NULL,
    route_id bigint NOT NULL,
    user_id bigint NOT NULL,
    score integer NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT route_rating_score_check CHECK (((score >= 1) AND (score <= 5)))
);


--
-- Name: route_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.route_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: route_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.route_rating_id_seq OWNED BY public.route_rating.id;


--
-- Name: route_spot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.route_spot (
    id bigint NOT NULL,
    route_id bigint NOT NULL,
    spot_id bigint NOT NULL,
    visit_order integer NOT NULL
);


--
-- Name: route_spot_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.route_spot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: route_spot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.route_spot_id_seq OWNED BY public.route_spot.id;


--
-- Name: spot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spot (
    id bigint NOT NULL,
    anime_id integer NOT NULL,
    anitabi_point_id character varying(20) NOT NULL,
    name_cn character varying(200),
    name character varying(200) NOT NULL,
    image_url character varying(500),
    episode integer,
    scene_seconds integer,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    location public.geometry(Point,4326),
    origin character varying(50),
    origin_url character varying(500),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: spot_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.spot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.spot_id_seq OWNED BY public.spot.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    username character varying(50) NOT NULL,
    phone character varying(20),
    email character varying(100),
    password_hash character varying(255),
    avatar_url character varying(500),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    nickname character varying(50),
    bio text
);


--
-- Name: user_achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_achievement (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    achievement_id bigint NOT NULL,
    achieved_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: user_achievement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_achievement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_achievement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_achievement_id_seq OWNED BY public.user_achievement.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: waypoint; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.waypoint (
    id bigint NOT NULL,
    route_id bigint NOT NULL,
    spot_id bigint,
    sequence integer NOT NULL,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    photo_url character varying(500),
    instruction text,
    waypoint_type character varying(20) NOT NULL
);


--
-- Name: waypoint_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.waypoint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: waypoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.waypoint_id_seq OWNED BY public.waypoint.id;


--
-- Name: achievement id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement ALTER COLUMN id SET DEFAULT nextval('public.achievement_id_seq'::regclass);


--
-- Name: check_in id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in ALTER COLUMN id SET DEFAULT nextval('public.check_in_id_seq'::regclass);


--
-- Name: checkin_like id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkin_like ALTER COLUMN id SET DEFAULT nextval('public.checkin_like_id_seq'::regclass);


--
-- Name: membership id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.membership ALTER COLUMN id SET DEFAULT nextval('public.membership_id_seq'::regclass);


--
-- Name: pilgrimage_record id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilgrimage_record ALTER COLUMN id SET DEFAULT nextval('public.pilgrimage_record_id_seq'::regclass);


--
-- Name: route id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route ALTER COLUMN id SET DEFAULT nextval('public.route_id_seq'::regclass);


--
-- Name: route_point id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_point ALTER COLUMN id SET DEFAULT nextval('public.route_point_id_seq'::regclass);


--
-- Name: route_rating id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_rating ALTER COLUMN id SET DEFAULT nextval('public.route_rating_id_seq'::regclass);


--
-- Name: route_spot id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_spot ALTER COLUMN id SET DEFAULT nextval('public.route_spot_id_seq'::regclass);


--
-- Name: spot id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spot ALTER COLUMN id SET DEFAULT nextval('public.spot_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_achievement id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement ALTER COLUMN id SET DEFAULT nextval('public.user_achievement_id_seq'::regclass);


--
-- Name: waypoint id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waypoint ALTER COLUMN id SET DEFAULT nextval('public.waypoint_id_seq'::regclass);


--
-- Data for Name: achievement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.achievement (id, name, description, icon_url, condition_type, condition_value) FROM stdin;
\.


--
-- Data for Name: anime; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.anime (bangumi_id, title_cn, title_jp, title_en, cat, cover_url, icon_url, description, city, color, abbr, site, release_date, default_lat, default_lng, default_zoom, points_count, anitabi_modified, synced_at, created_at) FROM stdin;
386195	吹响吧！上低音号～合奏比赛～特别篇	特別編 響け！ユーフォニアム～アンサンブルコンテスト～	\N	\N	https://image.anitabi.cn/bangumi/386195.jpg?plan=h160	\N	\N	宇治市	#d49580	\N	\N	\N	34.9061783	135.8098959	18.779	16	1742411542323	2026-05-10 11:15:06.042405	2026-05-03 22:24:47.298796
115908	吹响吧！上低音号	響け！ユーフォニアム	\N	\N	https://image.anitabi.cn/bangumi/115908.jpg?plan=h160	\N	\N	宇治市	#02a7bd	\N	\N	\N	34.9077532	135.8060315	12.383	577	1768184598493	2026-05-10 10:49:26.745728	2026-05-03 22:24:40.612095
216372	吹响吧！上低音号～誓言的终章～	劇場版 響け！ユーフォニアム～誓いのフィナーレ～	\N	\N	https://image.anitabi.cn/bangumi/216372.jpg?plan=h160	\N	\N	宇治市	#80552a	\N	\N	\N	34.8981106	135.8074091	13.000	265	1777644165823	2026-05-10 10:56:32.023194	2026-05-03 22:24:45.736845
329906	间谍过家家	SPY×FAMILY	\N	\N	https://image.anitabi.cn/bangumi/329906.jpg?plan=h160	\N	\N	欧洲	#2a5580	\N	\N	\N	50.7587808	6.5217142	5.390	11	1731169321298	2026-05-11 21:00:13.991519	2026-05-11 21:00:14.086461
430699	金牌得主	メダリスト	\N	\N	http://lain.bgm.tv/pic/cover/l/ce/3c/430699_hsj90.jpg?plan=h160	\N	\N	名古屋市	#66e0ff	\N	\N	\N	35.1369669	136.9027840	12.131	109	1767319998086	2026-04-19 19:18:19.618485	2026-04-19 19:18:19.622295
548818	金牌得主 第二季	メダリスト 第2期	\N	\N	http://lain.bgm.tv/pic/cover/l/0c/08/548818_iLSG6.jpg?plan=h160	\N	\N	名古屋市	#00d0d4	\N	\N	\N	\N	\N	\N	7	1774366518610	2026-04-19 19:18:20.110528	2026-04-19 19:18:20.114655
215425	中二病也要谈恋爱！-Take On Me-	中二病でも恋がしたイ！-Take On Me-	\N	\N	https://image.anitabi.cn/bangumi/215425.jpg?plan=h160	\N	\N	日本	#da33ff	\N	\N	\N	34.9839446	135.8500805	11.930	206	1775609070119	2026-04-19 19:18:20.37207	2026-04-19 19:18:20.376213
7843	魔法禁书目录 第二季	とある魔術の禁書目録Ⅱ	\N	\N	http://lain.bgm.tv/pic/cover/l/8d/91/7843_KPkpp.jpg?plan=h160	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6	1758816556562	2026-04-19 19:20:25.452806	2026-04-19 19:20:25.457035
206925	一人之下 第二季	一人之下 the outcast 2	\N	\N	http://lain.bgm.tv/pic/cover/l/71/aa/206925_NpRkA.jpg?plan=h160	\N	\N	江西省	#026cf3	\N	\N	\N	\N	\N	\N	3	1773677083625	2026-04-19 20:06:28.19446	2026-04-19 20:06:28.203571
501023	我和班上最讨厌的女生结婚了。	クラスの大嫌いな女子と結婚することになった。	\N	\N	https://image.anitabi.cn/bangumi/501023.jpg?plan=h160	\N	\N	朝霞市	#e8307a	\N	\N	\N	\N	\N	\N	6	1742754529600	2026-04-19 20:07:15.78255	2026-04-19 20:07:15.788196
12426	轻音少女 剧场版	映画けいおん！	\N	\N	https://image.anitabi.cn/bangumi/12426.jpg?plan=h160	\N	\N	欧洲	#2a4080	\N	\N	\N	51.5267781	-0.0944513	11.461	286	1775241363107	2026-04-19 20:07:26.703826	2026-04-19 20:07:26.712965
3774	轻音少女 二期	けいおん!!	\N	\N	https://image.anitabi.cn/bangumi/3774.jpg?plan=h160	\N	\N	京都府	#2a802a	\N	\N	\N	34.8891603	135.8088320	11.910	201	1775012942363	2026-04-19 20:07:27.715555	2026-04-19 20:07:27.720524
400602	葬送的芙莉莲	葬送のフリーレン	\N	\N	https://image.anitabi.cn/bangumi/400602.jpg?plan=h160	\N	\N	\N	#00c742	\N	\N	\N	36.4031074	140.5898997	9.924	1	1722071374103	2026-04-19 20:12:24.037739	2026-04-19 20:12:24.157348
183878	紫罗兰永恒花园	ヴァイオレット・エヴァーガーデン	\N	\N	https://image.anitabi.cn/bangumi/183878.jpg?plan=h160	\N	\N	海外	#1e67da	\N	\N	\N	44.4083638	8.9200507	9.451	6	1767192336874	2026-04-19 20:12:26.251049	2026-04-19 20:12:26.357982
55113	玉子市场	たまこまーけっと	\N	\N	https://image.anitabi.cn/bangumi/55113.jpg?plan=h160	\N	\N	京都市	#ed85a8	\N	\N	\N	34.9923990	135.7699643	11.760	96	1757327017407	2026-05-04 16:22:17.766624	2026-05-04 16:22:16.861237
90880	玉子爱情故事	たまこラブストーリー	\N	\N	https://image.anitabi.cn/bangumi/90880.jpg?plan=h160	\N	\N	京都市	#474e63	\N	\N	\N	35.0297540	135.7722752	17.366	76	1751259367364	2026-05-04 16:22:18.981395	2026-05-04 16:22:18.075304
8452	玉响	たまゆら	\N	\N	https://image.anitabi.cn/bangumi/8452.jpg?plan=h160	\N	\N	竹原市	#ef734e	\N	\N	\N	34.3326567	132.9519452	12.171	82	1749233478830	2026-05-04 16:22:21.904123	2026-05-04 16:22:21.001601
216228	孤独的美食家	孤独のグルメ	\N	\N	https://image.anitabi.cn/bangumi/216228.jpg?plan=h160	\N	\N	东京都	#aaaaaa	\N	\N	\N	35.7879886	139.7102307	7.321	36	1726751623609	2026-05-10 10:49:53.775562	2026-05-04 00:33:36.138057
211089	剧场版 吹响吧！上低音号～想要传达的旋律～	劇場版 響け！ユーフォニアム～届けたいメロディ～	\N	\N	https://image.anitabi.cn/bangumi/211089.jpg?plan=h160	\N	\N	宇治市	#71c6e3	\N	\N	\N	34.8992910	135.8023160	15.998	1	1716774629058	2026-05-10 11:14:48.608594	2026-05-03 22:24:44.930109
226540	魔法禁书目录 第三季	とある魔術の禁書目録Ⅲ	\N	\N	https://image.anitabi.cn/bangumi/226540.jpg?plan=h160	\N	\N	东京都	#8fc7ff	\N	\N	\N	35.5519298	139.5816051	8.448	30	1753633889339	2026-05-11 21:05:10.339642	2026-05-11 21:05:10.430284
262939	某科学的一方通行	とある科学の一方通行	\N	\N	https://image.anitabi.cn/bangumi/262939.jpg?plan=h160	\N	\N	东京都	#afafaf	\N	\N	\N	35.6625683	139.7612486	14.666	17	1746387937145	2026-05-11 21:05:12.131405	2026-05-11 21:05:12.221592
283643	吹响吧！上低音号 3	響け！ユーフォニアム 3	\N	\N	https://image.anitabi.cn/bangumi/283643.jpg?plan=h160	\N	\N	宇治市	#f163cd	\N	\N	\N	34.9742733	135.7929851	11.141	340	1776234683548	2026-05-10 11:22:09.242307	2026-05-03 22:24:42.653366
347140	身为女主角 讨厌的女主角与秘密的工作	ヒロインたるもの！〜嫌われヒロインと内緒のお仕事〜	\N	\N	http://lain.bgm.tv/pic/cover/l/f5/ee/347140_40584.jpg?plan=h160	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1	1772416120996	2026-05-11 21:05:20.772405	2026-05-11 21:05:20.861508
2585	某科学的超电磁炮	とある科学の超電磁砲	\N	\N	https://image.anitabi.cn/bangumi/2585.jpg?plan=h160	\N	\N	立川市	#f58300	\N	\N	\N	35.5961541	139.5213678	9.973	12	1760172853261	2026-05-11 21:08:04.015992	2026-05-11 21:08:04.105817
51928	某科学的超电磁炮S	とある科学の超電磁砲S	\N	\N	https://image.anitabi.cn/bangumi/51928.jpg?plan=h160	\N	\N	立川市	#e86028	\N	\N	\N	35.6452501	139.5868960	10.820	54	1760172843564	2026-05-11 21:08:05.075272	2026-05-11 21:08:05.164283
98371	某科学的超电磁炮 OVA	とある科学の超電磁砲 炎天下の撮影モデルも楽じゃありませんわね	\N	\N	https://image.anitabi.cn/bangumi/98371.jpg?plan=h160	\N	\N	东京都	#b8b89c	\N	\N	\N	35.6929773	139.6983258	14.779	14	1744558619738	2026-05-11 21:08:07.119451	2026-05-11 21:08:07.208503
262940	某科学的超电磁炮T	とある科学の超電磁砲T	\N	\N	https://image.anitabi.cn/bangumi/262940.jpg?plan=h160	\N	\N	立川市	#d62f37	\N	\N	\N	35.7015287	139.4144599	15.162	36	1760172847491	2026-05-11 21:08:08.411335	2026-05-11 21:08:08.503023
1424	轻音少女	けいおん！	\N	\N	https://image.anitabi.cn/bangumi/1424.jpg?plan=h160	\N	\N	京都市	#e6302c	\N	\N	\N	34.9861280	135.7343670	11.000	214	1777644413157	2026-05-11 21:11:33.988411	2026-04-19 20:07:27.214381
186515	\N	BanG Dream!	\N	\N	https://image.anitabi.cn/bangumi/186515.jpg?plan=h160	\N	\N	东京都	#ed145b	\N	\N	\N	35.4313858	139.9749303	8.609	62	1760459876810	2026-05-17 10:47:46.334821	2026-05-17 10:47:39.43991
428735	\N	BanG Dream! It's MyGO!!!!!	\N	\N	https://image.anitabi.cn/bangumi/428735.jpg?plan=h160	\N	\N	丰岛区	#3381b1	\N	\N	\N	35.7301174	139.7163097	16.149	454	1773676719954	2026-05-17 10:47:43.955618	2026-05-04 16:21:57.477002
246429	BanG Dream! 第二季	BanG Dream! 2nd Season	\N	\N	http://lain.bgm.tv/pic/cover/l/d9/f3/246429_L8TbT.jpg?plan=h160	\N	\N	东京都	#3344aa	\N	\N	\N	35.6782949	139.6964625	12.516	49	1777903140324	2026-05-17 10:47:46.869655	2026-05-17 10:47:39.889961
246430	BanG Dream! 第三季	BanG Dream! 3rd Season	\N	\N	http://lain.bgm.tv/pic/cover/l/42/9f/246430_BpvBB.jpg?plan=h160	\N	\N	东京都	#33cccc	\N	\N	\N	35.4070896	139.8638255	8.115	12	1752286488480	2026-05-17 10:47:47.758702	2026-05-17 10:47:40.429979
328609	孤独摇滚！	ぼっち・ざ・ろっく！	\N	\N	https://image.anitabi.cn/bangumi/328609.jpg?plan=h160	\N	\N	东京都	#ff428e	\N	\N	\N	35.4794584	139.5892474	9.650	414	1777841726341	2026-05-31 22:40:14.486632	2026-05-31 22:40:14.498586
160209	你的名字	君の名は	\N	\N	https://image.anitabi.cn/bangumi/160209.jpg?plan=h160	\N	\N	高山市	#0080ff	\N	\N	\N	36.0416771	136.2137676	5.566	113	1774368126207	2026-06-08 16:14:02.394752	2026-06-08 16:14:02.496406
1650	你所期望的永远	君が望む永遠	\N	\N	https://image.anitabi.cn/bangumi/1650.jpg?plan=h160	\N	\N	横滨市	#556aaa	\N	\N	\N	35.4471263	139.6267760	11.309	6	1740310658199	2026-06-08 16:14:10.151274	2026-06-08 16:14:10.244471
409576	你的颜色	きみの色	\N	\N	https://image.anitabi.cn/bangumi/409576.jpg?plan=h160	\N	\N	长崎市	#407fbf	\N	\N	\N	33.3766499	132.6195446	5.607	24	1754017678935	2026-06-08 16:14:12.451529	2026-06-08 16:14:12.546005
280837	紫罗兰永恒花园 外传 - 永远与自动手记人偶 -	ヴァイオレット・エヴァーガーデン 外伝 - 永遠と自動手記人形 -	\N	\N	http://lain.bgm.tv/pic/cover/l/f0/15/280837_L6VeG.jpg?plan=h160	\N	\N	欧洲	#7c8254	\N	\N	\N	49.0469573	10.0980557	5.674	23	1766994421031	2026-06-08 18:43:11.599941	2026-06-08 18:43:11.739761
242216	剧场版 紫罗兰永恒花园	劇場版 ヴァイオレット・エヴァーガーデン	\N	\N	https://image.anitabi.cn/bangumi/242216.jpg?plan=h160	\N	\N	海外	#80aad4	\N	\N	\N	36.6275200	24.9016898	14.540	3	1753553731263	2026-06-08 18:43:56.823405	2026-06-08 18:43:56.942373
1905	夏日大作战	サマーウォーズ	\N	\N	https://image.anitabi.cn/bangumi/1905.jpg?plan=h160	\N	\N	上田市	#d4bf80	\N	\N	\N	36.3974863	138.2814474	10.756	7	1745593229294	2026-06-08 20:00:28.911444	2026-06-08 20:00:29.693419
326895	夏日重现	サマータイムレンダ	\N	\N	https://image.anitabi.cn/bangumi/326895.jpg?plan=h160	\N	\N	和歌山市	#1f6fde	\N	\N	\N	34.3151540	134.6785827	8.730	22	1777339940547	2026-06-08 20:00:31.33264	2026-06-08 20:00:31.814682
328674	夏日幽灵	サマーゴースト	\N	\N	https://image.anitabi.cn/bangumi/328674.jpg?plan=h160	\N	\N	\N	#1c398e	\N	\N	\N	34.8152476	135.5328222	8.953	7	1727218353507	2026-06-08 20:00:34.175449	2026-06-08 20:00:34.329001
363957	夏日口袋	Summer Pockets	\N	\N	https://image.anitabi.cn/bangumi/363957_rpxd9y92h.jpg?plan=h160	\N	\N	香川县	#86d8f3	\N	\N	\N	34.4134223	134.0373312	10.537	374	1774015800852	2026-06-08 20:00:36.838434	2026-06-08 20:00:36.996347
152091	吹响吧！上低音号 2	響け！ユーフォニアム2	\N	\N	https://image.anitabi.cn/bangumi/152091.jpg?plan=h160	\N	\N	宇治市	#2a5580	\N	\N	\N	34.9179663	135.8238810	13.126	434	1779371949620	2026-06-09 19:30:07.180073	2026-05-03 22:24:41.369513
293049	辉夜大小姐想让我告白？～天才们的恋爱头脑战～	かぐや様は告らせたい？～天才たちの恋愛頭脳戦～	\N	\N	https://image.anitabi.cn/bangumi/293049.jpg?plan=h160	\N	\N	\N	#d9204e	\N	\N	\N	\N	\N	\N	1	1753869504775	2026-06-11 14:48:17.183908	2026-06-11 14:48:17.436383
604826	超时空辉夜姬！	超かぐや姫！	\N	\N	https://image.anitabi.cn/bangumi/604826.jpg?plan=h160	\N	\N	立川市	#d49580	\N	\N	\N	35.7076390	139.4277309	14.441	58	1779981870700	2026-06-11 14:48:46.242052	2026-06-11 14:48:46.477906
\.


--
-- Data for Name: check_in; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.check_in (id, user_id, spot_id, route_id, photo_url, comparison_url, content, latitude, longitude, like_count, created_at, status, review_note, reviewed_at, is_public) FROM stdin;
25	10	1	\N	\N	\N	\N	\N	\N	0	2026-06-05 23:09:40.132854	pending	\N	\N	t
2	5	1	\N	https://example.com/test.jpg	\N	测试打卡（来自 http-tests）	\N	\N	1	2026-05-15 14:40:39.163317	pending	\N	\N	t
31	2	1238	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/315cca28-a8be-451f-adef-129db05e1cd5.jpg	https://image.anitabi.cn/user/1099/bangumi/51928/points/o516ekmxe-1726244264380.jpg?plan=h360	\N	39.9474139	116.3361654	0	2026-06-09 02:05:06.860555	pending	\N	\N	t
10	2	763	8	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/aae49dbf-fabb-4fd3-acf0-60cf889bc4bc.jpg	\N	\N	35.2033403	136.2327859	0	2026-05-24 15:04:26.065004	pending	\N	\N	t
3	5	1	\N	https://example.com/test.jpg	\N	测试打卡（来自 http-tests）	\N	\N	1	2026-05-16 21:14:54.860552	pending	\N	\N	t
5	6	543	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/17adb808-d52a-4451-b873-6b51e6922bce.png	\N	test	\N	\N	0	2026-05-23 17:41:59.37544	approved	\N	2026-06-09 20:12:52.873876	t
14	6	871	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/35fd6d3c-6647-434d-9892-453448b26360.jpg	https://image.anitabi.cn/points/246430/riacv5t90_1742808830139.jpg?plan=h160	\N	\N	\N	0	2026-05-31 10:41:47.313426	pending	\N	\N	t
21	6	931	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/93e8d33b-c62f-4470-adc0-db9268fc4233.jpg	https://image.anitabi.cn/points/1424/s9cnrj5kf_1737867150212.jpg?plan=h160	\N	\N	\N	1	2026-06-05 20:28:22.505886	pending	\N	\N	t
16	6	877	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/cf16c8d7-e715-4bab-811a-6fb8a9a59925.jpg	https://image.anitabi.cn/points/186515/78e0cd5e_1722414043756.jpg?plan=h160	\N	\N	\N	1	2026-05-31 11:17:04.166911	pending	\N	\N	t
15	2	931	10	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/10f74d3e-3370-4500-a908-f920e46e44cc.jpg	https://image.anitabi.cn/points/1424/s9cnrj5kf_1737867150212.jpg?plan=h160	1	39.9500850	116.3357956	1	2026-05-31 11:11:07.740736	pending	\N	\N	t
11	2	931	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/67b1038a-dde2-4600-b655-b49a9c96dab7.jpg	\N	\N	39.9504993	116.3357474	1	2026-05-24 15:29:28.781424	pending	\N	\N	t
12	2	931	9	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/089d4119-df59-4586-8630-363683893a5d.jpg	\N	\N	39.9504943	116.3357562	1	2026-05-24 15:30:25.038693	pending	\N	\N	t
8	2	763	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/49746ae5-ccae-403b-b6b8-5dff1024370e.jpg	\N	\N	35.2033375	136.2327882	0	2026-05-24 14:17:18.432095	pending	\N	\N	t
22	6	1228	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/c34c74c7-b7d7-4c6c-a627-3aed62c16adb.jpg	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyeduyjop-1728545573537.jpg?plan=h160	\N	\N	\N	1	2026-06-05 20:32:55.998419	pending	\N	\N	t
13	6	877	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/8739377f-5e19-4a07-82b6-f344a6e0a4e7.jpg	https://image.anitabi.cn/points/186515/78e0cd5e_1722414043756.jpg?plan=h160	testtest	\N	\N	0	2026-05-31 10:33:03.254741	pending	\N	\N	t
6	6	877	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/28c770fd-5f80-4b37-ac7a-f7278032e526.jpg	https://image.anitabi.cn/points/186515/78e0cd5e_1722414043756.jpg?plan=h160	test	\N	\N	0	2026-05-24 10:21:05.217561	pending	\N	\N	t
7	6	871	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/26efcf80-5e25-4e60-af1d-c332a38b632f.jpg	https://image.anitabi.cn/points/246430/riacv5t90_1742808830139.jpg?plan=h160	\N	\N	\N	0	2026-05-24 11:00:26.244023	pending	\N	\N	t
17	2	788	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/59082e12-4948-4ad7-a20b-46d22971d1c3.jpg	https://image.anitabi.cn/points/1424/s9nijut9a_1737890780649.jpg?plan=h160	\N	39.9502593	116.3385296	1	2026-06-03 19:26:36.028219	pending	\N	\N	t
18	2	788	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/82eaf145-2f6c-4ae4-b4cd-0cddd4404ad5.jpg	https://image.anitabi.cn/points/1424/s9nijut9a_1737890780649.jpg?plan=h160	great memories.	39.9502506	116.3385687	1	2026-06-03 19:29:24.76809	pending	\N	\N	t
36	117	1023	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/117/629fb145-291a-400f-bd2a-0633035c7b9b.jpg	https://image.anitabi.cn/points/328609/dfbf2731_1739363147444.jpg	\N	\N	\N	0	2026-06-26 00:39:06.735363	pending	\N	\N	t
19	2	860	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/186d1ef4-b13e-44c1-9e4e-3c113f781e78.jpg	https://image.anitabi.cn/user/2148/bangumi/2585/points/rm3jq6vd7-1736044971890.jpg?plan=h160	\N	39.9501620	116.3384521	0	2026-06-03 19:31:29.474464	pending	\N	\N	t
9	2	763	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/fb0496a5-3b73-4995-a555-be01974e87ef.jpg	\N	\N	35.2033382	136.2327856	0	2026-05-24 14:50:52.063054	pending	\N	\N	t
20	6	931	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/57fedccd-dcd3-4054-ab7b-adff158ae239.jpg	https://image.anitabi.cn/points/1424/s9cnrj5kf_1737867150212.jpg?plan=h160	\N	\N	\N	1	2026-06-03 21:28:56.966676	pending	\N	\N	t
4	5	1	\N	https://example.com/test.jpg	\N	测试打卡（来自 http-tests）	\N	\N	2	2026-05-16 21:29:26.636989	pending	\N	\N	t
26	10	1	\N	\N	\N	\N	\N	\N	0	2026-06-05 23:11:21.57315	pending	\N	\N	t
24	6	550	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/c34772dd-2ddb-4b37-8aa4-14e1ed5cc9ad.jpg	https://image.anitabi.cn/points/152091/kq685xgk3_1716616457260.jpg?plan=h160	\N	\N	\N	1	2026-06-05 20:57:21.499466	pending	\N	\N	t
1	3	1	\N	https://example.com/test.jpg	\N	测试打卡	\N	\N	1	2026-05-09 21:51:34.400443	pending	\N	\N	t
23	6	796	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/6/986911e3-631f-452f-b7c2-758393d0676a.jpg	https://image.anitabi.cn/points/1424/25idmc2.jpg?plan=h160	\N	\N	\N	1	2026-06-05 20:42:01.776588	pending	\N	\N	t
27	2	1231	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/ce00501b-902a-42eb-a401-87c5b9d6d191.jpg	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyeqj77hn-1728546367900.jpg?plan=h360	\N	39.9503298	116.3357887	0	2026-06-07 15:07:36.612662	pending	\N	\N	t
28	12	1226	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/12/99a1d9aa-9d37-45e7-9068-32864d9ecc7d.jpg	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyf2wdlfx-1728547181300.jpg?plan=h360	\N	39.9503316	116.3357929	0	2026-06-07 15:10:20.416416	pending	\N	\N	t
29	2	860	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/d6bec3f9-27a9-4e56-a950-9bb1ff910b1a.jpg	https://image.anitabi.cn/user/2148/bangumi/2585/points/rm3jq6vd7-1736044971890.jpg?plan=h160	\N	39.9485682	116.3363406	0	2026-06-08 12:13:12.587956	pending	\N	\N	t
30	2	826	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/99d2727b-9bda-4c04-8605-27e6ff257927.jpg	https://image.anitabi.cn/user/1099/bangumi/2585/points/l171nckph-1717480444079.jpg?plan=h160	\N	39.9485332	116.3363252	0	2026-06-08 12:16:41.494226	pending	\N	\N	t
37	2	1231	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/0c5aa403-653f-4a5e-8baf-f6be96e68b85.jpg	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyeqj77hn-1728546367900.jpg	\N	39.9502393	116.3385056	0	2026-06-26 16:01:57.505094	pending	\N	\N	t
35	117	1025	\N	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/117/e12aab54-b718-4cd9-90ec-4d661bbf1272.jpg	https://image.anitabi.cn/points/328609/cm9tso_1747773358419.jpg	test	\N	\N	0	2026-06-26 00:32:54.322707	pending	\N	\N	t
\.


--
-- Data for Name: checkin_like; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.checkin_like (id, check_in_id, user_id, created_at) FROM stdin;
2	2	5	2026-05-15 14:41:28.39676
4	3	5	2026-05-16 21:15:04.076554
6	4	5	2026-05-16 21:29:33.472716
19	4	6	2026-05-24 14:51:17.014592
21	16	6	2026-05-31 14:43:59.179882
22	15	6	2026-05-31 14:44:01.813023
23	11	6	2026-05-31 17:04:51.234163
24	12	6	2026-05-31 17:04:54.860059
26	17	2	2026-06-03 19:29:40.737036
27	18	2	2026-06-03 19:29:45.733074
28	20	6	2026-06-03 21:29:04.752491
30	21	6	2026-06-05 20:35:45.390674
31	22	6	2026-06-05 20:35:47.730821
32	23	6	2026-06-05 20:43:06.772392
33	24	7	2026-06-05 22:55:34.349096
\.


--
-- Data for Name: membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.membership (id, user_id, plan_type, status, start_date, end_date, payment_channel, transaction_id, created_at) FROM stdin;
\.


--
-- Data for Name: pilgrimage_record; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pilgrimage_record (id, user_id, anime_id, route_id, spots_visited, total_spots, distance_walked, duration_minutes, status, started_at, finished_at) FROM stdin;
\.


--
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.route (id, user_id, anime_id, title, description, difficulty, estimated_minutes, distance_km, gpx_file_url, avg_rating, rating_count, follow_count, status, recorded_at, created_at, review_note, reviewed_at, is_public) FROM stdin;
1	2	428735	test1	Test for recording route.	\N	3	5.57	\N	0.0	0	0	approved	2026-05-06 15:31:03.806	2026-05-06 23:35:13.158035	\N	\N	t
2	2	428735	test2	test	\N	2	6.07	\N	0.0	0	0	approved	2026-05-07 12:11:00.397	2026-05-07 20:12:52.130418	\N	\N	t
3	2	428735	test3	Testing	\N	1	1.45	\N	0.0	0	0	approved	2026-05-07 12:19:13.576	2026-05-07 20:19:55.903111	\N	\N	t
4	2	428735	Test for oss	Testing for oss	\N	1	1.61	\N	0.0	0	0	approved	2026-05-10 00:48:53.575	2026-05-10 08:49:44.992253	\N	\N	t
5	2	1424	test	\N	\N	8	4.59	\N	0.0	0	0	approved	2026-05-10 02:41:06.217	2026-05-10 10:48:59.113257	\N	\N	t
6	2	1424	111	\N	\N	1	0.10	\N	0.0	0	0	approved	2026-05-24 06:16:30.778	2026-05-24 14:18:02.686722	\N	\N	t
7	2	1424	Test for checkin	\N	\N	1	0.10	\N	0.0	0	0	approved	2026-05-24 06:50:20.59	2026-05-24 14:51:16.308986	\N	\N	t
8	2	1424	567	\N	\N	1	0.00	\N	0.0	0	0	approved	2026-05-24 07:04:11.204	2026-05-24 15:04:36.964922	\N	\N	t
9	2	1424	test1	\N	\N	1	0.14	\N	0.0	0	0	approved	2026-05-24 07:30:20.776	2026-05-24 15:30:58.436323	\N	\N	t
10	2	1424	test for new checkin	\N	\N	1	0.01	\N	0.0	0	0	approved	2026-05-31 03:06:29.797	2026-05-31 11:11:49.259924	\N	\N	t
\.


--
-- Data for Name: route_point; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.route_point (id, route_id, sequence, latitude, longitude, altitude, recorded_at) FROM stdin;
1	1	0	35.6938411	139.7501286	18.30	2026-05-06 15:31:03.806
2	1	1	35.6849767	139.7629150	18.30	2026-05-06 15:31:04.807
3	1	2	35.6849846	139.7627055	18.30	2026-05-06 15:31:06.076
4	1	3	35.6849883	139.7625880	18.30	2026-05-06 15:31:07.079
5	1	4	35.6849917	139.7624769	18.30	2026-05-06 15:31:08.079
6	1	5	35.6849967	139.7623583	18.30	2026-05-06 15:31:09.822
7	1	6	35.6850000	139.7622553	18.30	2026-05-06 15:31:10.824
8	1	7	35.6850033	139.7621465	18.30	2026-05-06 15:31:11.825
9	1	8	35.6850081	139.7620367	18.30	2026-05-06 15:31:12.825
10	1	9	35.6850147	139.7618277	18.30	2026-05-06 15:31:14.077
11	1	10	35.6850200	139.7616993	18.30	2026-05-06 15:31:15.83
12	1	11	35.6850264	139.7614967	18.30	2026-05-06 15:31:17.079
13	1	12	35.6850317	139.7613692	18.30	2026-05-06 15:31:18.833
14	1	13	35.6850350	139.7612646	18.30	2026-05-06 15:31:19.835
15	1	14	35.6850383	139.7611560	18.30	2026-05-06 15:31:20.839
16	1	15	35.6850429	139.7610465	18.30	2026-05-06 15:31:21.839
17	1	16	35.6850466	139.7609366	18.30	2026-05-06 15:31:22.839
18	1	17	35.6850500	139.7608266	18.30	2026-05-06 15:31:23.842
19	1	18	35.6850533	139.7607166	18.30	2026-05-06 15:31:24.843
20	1	19	35.6850579	139.7606066	18.30	2026-05-06 15:31:25.845
21	1	20	35.6850644	139.7604077	18.30	2026-05-06 15:31:27.077
22	1	21	35.6850701	139.7602701	18.30	2026-05-06 15:31:28.851
23	1	22	35.6850733	139.7601656	18.30	2026-05-06 15:31:29.855
24	1	23	35.6850812	139.7599582	18.30	2026-05-06 15:31:31.078
25	1	24	35.6850849	139.7598385	18.30	2026-05-06 15:31:32.079
26	1	25	35.6850883	139.7597283	18.30	2026-05-06 15:31:33.08
27	1	26	35.6850931	139.7596183	18.30	2026-05-06 15:31:34.082
28	1	27	35.6850968	139.7594995	18.30	2026-05-06 15:31:35.868
29	1	28	35.6851000	139.7593969	18.30	2026-05-06 15:31:36.87
30	1	29	35.6851048	139.7592880	18.30	2026-05-06 15:31:37.874
31	1	30	35.6851083	139.7591782	18.30	2026-05-06 15:31:38.875
32	1	31	35.6851117	139.7590682	18.30	2026-05-06 15:31:39.878
33	1	32	35.6851165	139.7589582	18.30	2026-05-06 15:31:40.884
34	1	33	35.6851200	139.7588482	18.30	2026-05-06 15:31:41.887
35	1	34	35.6851233	139.7587382	18.30	2026-05-06 15:31:42.889
36	1	35	35.6851267	139.7586282	18.30	2026-05-06 15:31:43.891
37	1	36	35.6851345	139.7584208	18.30	2026-05-06 15:31:45.076
38	1	37	35.6851382	139.7583002	18.30	2026-05-06 15:31:46.078
39	1	38	35.6851431	139.7581886	18.30	2026-05-06 15:31:47.079
40	1	39	35.6851468	139.7580694	18.30	2026-05-06 15:31:48.898
41	1	40	35.6851500	139.7579669	18.30	2026-05-06 15:31:49.9
42	1	41	35.6851548	139.7578580	18.30	2026-05-06 15:31:50.904
43	1	42	35.6851583	139.7577482	18.30	2026-05-06 15:31:51.905
44	1	43	35.6851617	139.7576382	18.30	2026-05-06 15:31:52.911
45	1	44	35.6851665	139.7575282	18.30	2026-05-06 15:31:53.912
46	1	45	35.6851700	139.7574182	18.30	2026-05-06 15:31:54.917
47	1	46	35.6851778	139.7572113	18.30	2026-05-06 15:31:56.08
48	1	47	35.6851818	139.7570805	18.30	2026-05-06 15:31:57.921
49	1	48	35.6851850	139.7569769	18.30	2026-05-06 15:31:58.929
50	1	49	35.6851896	139.7568682	18.30	2026-05-06 15:31:59.932
51	1	50	35.6852391	139.7569578	18.30	2026-05-06 15:32:00.936
52	1	51	35.6852914	139.7570524	18.30	2026-05-06 15:32:01.94
53	1	52	35.6853433	139.7571448	18.30	2026-05-06 15:32:02.942
54	1	53	35.6853936	139.7572367	18.30	2026-05-06 15:32:03.944
55	1	54	35.6854451	139.7573283	18.30	2026-05-06 15:32:04.947
56	1	55	35.6854967	139.7574199	18.30	2026-05-06 15:32:05.947
57	1	56	35.6855470	139.7575131	18.30	2026-05-06 15:32:06.952
58	1	57	35.6855984	139.7576049	18.30	2026-05-06 15:32:07.952
59	1	58	35.6856501	139.7576967	18.30	2026-05-06 15:32:08.956
60	1	59	35.6857003	139.7577883	18.30	2026-05-06 15:32:09.957
61	1	60	35.6857518	139.7578800	18.30	2026-05-06 15:32:10.958
62	1	61	35.6858034	139.7579717	18.30	2026-05-06 15:32:11.963
63	1	62	35.6858550	139.7580633	18.30	2026-05-06 15:32:12.964
64	1	63	35.6859053	139.7581565	18.30	2026-05-06 15:32:13.968
65	1	64	35.6859568	139.7582483	18.30	2026-05-06 15:32:14.973
66	1	65	35.6860084	139.7583400	18.30	2026-05-06 15:32:15.978
67	1	66	35.6860586	139.7584317	18.30	2026-05-06 15:32:16.98
68	1	67	35.6861101	139.7585233	18.30	2026-05-06 15:32:17.981
69	1	68	35.6861618	139.7586150	18.30	2026-05-06 15:32:18.986
70	1	69	35.6862120	139.7587080	18.30	2026-05-06 15:32:19.986
71	1	70	35.6862634	139.7588000	18.30	2026-05-06 15:32:20.99
72	1	71	35.6863151	139.7588917	18.30	2026-05-06 15:32:21.994
73	1	72	35.6863653	139.7589833	18.30	2026-05-06 15:32:22.999
74	1	73	35.6864168	139.7590750	18.30	2026-05-06 15:32:24.001
75	1	74	35.6864684	139.7591667	18.30	2026-05-06 15:32:25.005
76	1	75	35.6865213	139.7592580	18.30	2026-05-06 15:32:26.008
77	1	76	35.6867580	139.7589623	18.30	2026-05-06 15:32:27.014
78	1	77	35.6870143	139.7586264	18.30	2026-05-06 15:32:28.014
79	1	78	35.6872680	139.7582969	18.30	2026-05-06 15:32:29.016
80	1	79	35.6875194	139.7579725	18.30	2026-05-06 15:32:30.021
81	1	80	35.6877698	139.7576484	18.30	2026-05-06 15:32:31.025
82	1	81	35.6880199	139.7573265	18.30	2026-05-06 15:32:32.028
83	1	82	35.6882698	139.7570048	18.30	2026-05-06 15:32:33.029
84	1	83	35.6885199	139.7566830	18.30	2026-05-06 15:32:34.032
85	1	84	35.6887699	139.7563614	18.30	2026-05-06 15:32:35.037
86	1	85	35.6890214	139.7560382	18.30	2026-05-06 15:32:36.04
87	1	86	35.6892717	139.7557163	18.30	2026-05-06 15:32:37.046
88	1	87	35.6895216	139.7553947	18.30	2026-05-06 15:32:38.051
89	1	88	35.6897716	139.7550731	18.30	2026-05-06 15:32:39.053
90	1	89	35.6901938	139.7545305	18.30	2026-05-06 15:32:40.055
91	1	90	35.6904444	139.7541560	18.30	2026-05-06 15:32:41.06
92	1	91	35.6906730	139.7538060	18.30	2026-05-06 15:32:42.063
93	1	92	35.6909027	139.7534560	18.30	2026-05-06 15:32:43.064
94	1	93	35.6911321	139.7531063	18.30	2026-05-06 15:32:44.065
95	1	94	35.6912030	139.7529951	18.30	2026-05-06 15:32:45.065
96	1	95	35.6914232	139.7526893	18.30	2026-05-06 15:32:46.069
97	1	96	35.6916610	139.7523558	18.30	2026-05-06 15:32:47.074
98	1	97	35.6918991	139.7520225	18.30	2026-05-06 15:32:48.077
99	1	98	35.6921364	139.7516886	18.30	2026-05-06 15:32:49.079
100	1	99	35.6925899	139.7510529	18.30	2026-05-06 15:32:50.08
101	1	100	35.6930871	139.7503534	18.30	2026-05-06 15:32:52.08
102	1	101	35.6933216	139.7500229	18.30	2026-05-06 15:32:53.08
103	1	102	35.6934485	139.7498399	18.30	2026-05-06 15:32:54.082
104	1	103	35.6935624	139.7494470	18.30	2026-05-06 15:32:55.09
105	1	104	35.6936781	139.7490315	18.30	2026-05-06 15:32:56.094
106	1	105	35.6937954	139.7486153	18.30	2026-05-06 15:32:57.097
107	1	106	35.6939134	139.7481998	18.30	2026-05-06 15:32:58.102
108	1	107	35.6940331	139.7477863	18.30	2026-05-06 15:32:59.106
109	1	108	35.6942671	139.7469730	18.30	2026-05-06 15:33:00.579
110	1	109	35.6943917	139.7465258	18.30	2026-05-06 15:33:02.111
111	1	110	35.6945075	139.7461274	18.30	2026-05-06 15:33:03.113
112	1	111	35.6946262	139.7457134	18.30	2026-05-06 15:33:04.118
113	1	112	35.6947448	139.7452982	18.30	2026-05-06 15:33:05.123
114	1	113	35.6948632	139.7448829	18.30	2026-05-06 15:33:06.129
115	1	114	35.6949831	139.7444696	18.30	2026-05-06 15:33:07.131
116	1	115	35.6951017	139.7440547	18.30	2026-05-06 15:33:08.135
117	1	116	35.6952199	139.7436399	18.30	2026-05-06 15:33:09.135
118	1	117	35.6953026	139.7433234	18.30	2026-05-06 15:33:10.141
119	1	118	35.6950518	139.7435733	18.30	2026-05-06 15:33:11.145
120	1	119	35.6947696	139.7438761	18.30	2026-05-06 15:33:12.149
121	1	120	35.6944909	139.7441693	18.30	2026-05-06 15:33:13.154
122	1	121	35.6942143	139.7444550	18.30	2026-05-06 15:33:14.155
123	1	122	35.6939402	139.7447379	18.30	2026-05-06 15:33:15.156
124	1	123	35.6934022	139.7452932	18.30	2026-05-06 15:33:16.58
125	1	124	35.6931091	139.7455925	18.30	2026-05-06 15:33:18.167
126	1	125	35.6928459	139.7458638	18.30	2026-05-06 15:33:19.17
127	1	126	35.6923082	139.7464187	18.30	2026-05-06 15:33:20.58
128	1	127	35.6918899	139.7463723	18.30	2026-05-06 15:33:21.882
129	1	128	35.6915471	139.7462152	18.30	2026-05-06 15:33:22.934
130	1	129	35.6912064	139.7460566	18.30	2026-05-06 15:33:23.986
131	1	130	35.6908678	139.7459046	18.30	2026-05-06 15:33:25.039
132	1	131	35.6905268	139.7457538	18.30	2026-05-06 15:33:26.08
133	1	132	35.6901859	139.7456044	18.30	2026-05-06 15:33:27.189
134	1	133	35.6898483	139.7454557	18.30	2026-05-06 15:33:28.19
135	1	134	35.6895096	139.7453070	18.30	2026-05-06 15:33:29.195
136	1	135	35.6891683	139.7451570	18.30	2026-05-06 15:33:30.196
137	1	136	35.6888280	139.7450084	18.30	2026-05-06 15:33:31.199
138	1	137	35.6884894	139.7448585	18.30	2026-05-06 15:33:32.204
139	1	138	35.6881497	139.7447101	18.30	2026-05-06 15:33:33.209
140	1	139	35.6878081	139.7445602	18.30	2026-05-06 15:33:34.213
141	1	140	35.6874679	139.7444117	18.30	2026-05-06 15:33:35.22
142	1	141	35.6871281	139.7442619	18.30	2026-05-06 15:33:36.222
143	1	142	35.6867880	139.7441134	18.30	2026-05-06 15:33:37.223
144	1	143	35.6864479	139.7439635	18.30	2026-05-06 15:33:38.23
145	1	144	35.6862570	139.7438837	18.30	2026-05-06 15:33:39.231
146	1	145	35.6855877	139.7437693	18.30	2026-05-06 15:33:40.579
147	1	146	35.6852098	139.7437085	18.30	2026-05-06 15:33:41.58
148	1	147	35.6848266	139.7436481	18.30	2026-05-06 15:33:43.237
149	1	148	35.6844881	139.7435922	18.30	2026-05-06 15:33:44.244
150	1	149	35.6841328	139.7435323	18.30	2026-05-06 15:33:45.244
151	1	150	35.6837747	139.7434720	18.30	2026-05-06 15:33:46.248
152	1	151	35.6834178	139.7434119	18.30	2026-05-06 15:33:47.251
153	1	152	35.6833658	139.7434073	18.30	2026-05-06 15:33:48.254
154	2	0	35.6833627	139.7434109	18.30	2026-05-07 12:11:00.397
155	2	1	35.6849767	139.7629150	18.30	2026-05-07 12:11:12.427
156	2	2	35.6849966	139.7623664	18.30	2026-05-07 12:11:13.427
157	2	3	35.6850150	139.7618164	18.30	2026-05-07 12:11:14.431
158	2	4	35.6850163	139.7617307	18.30	2026-05-07 12:11:15.432
159	2	5	35.6850344	139.7612531	18.30	2026-05-07 12:11:16.435
160	2	6	35.6850530	139.7607143	18.30	2026-05-07 12:11:17.438
161	2	7	35.6850730	139.7601661	18.30	2026-05-07 12:11:18.44
162	2	8	35.6850931	139.7596176	18.30	2026-05-07 12:11:19.445
163	2	9	35.6851117	139.7590677	18.30	2026-05-07 12:11:20.45
164	2	10	35.6851316	139.7585181	18.30	2026-05-07 12:11:21.451
165	2	11	35.6851500	139.7579680	18.30	2026-05-07 12:11:22.454
166	2	12	35.6851699	139.7574178	18.30	2026-05-07 12:11:23.458
167	2	13	35.6851908	139.7568684	18.30	2026-05-07 12:11:24.463
168	2	14	35.6854324	139.7572587	18.30	2026-05-07 12:11:25.469
169	2	15	35.6856940	139.7577572	18.30	2026-05-07 12:11:26.474
170	2	16	35.6859546	139.7582379	18.30	2026-05-07 12:11:27.478
171	2	17	35.6862111	139.7587050	18.30	2026-05-07 12:11:28.478
172	2	18	35.6868143	139.7588725	18.30	2026-05-07 12:11:29.706
173	2	19	35.6871558	139.7584699	18.30	2026-05-07 12:11:31.484
174	2	20	35.6874546	139.7580648	18.30	2026-05-07 12:11:32.486
175	2	21	35.6877682	139.7576534	18.30	2026-05-07 12:11:33.486
176	2	22	35.6880826	139.7572480	18.30	2026-05-07 12:11:34.49
177	2	23	35.6883948	139.7568436	18.30	2026-05-07 12:11:35.493
178	2	24	35.6887080	139.7564416	18.30	2026-05-07 12:11:36.495
179	2	25	35.6890216	139.7560381	18.30	2026-05-07 12:11:37.497
180	2	26	35.6893334	139.7556363	18.30	2026-05-07 12:11:38.504
181	2	27	35.6896465	139.7552331	18.30	2026-05-07 12:11:39.508
182	2	28	35.6901902	139.7545353	18.30	2026-05-07 12:11:40.511
183	2	29	35.6905036	139.7540672	18.30	2026-05-07 12:11:41.517
184	2	30	35.6907894	139.7536297	18.30	2026-05-07 12:11:42.52
185	2	31	35.6911738	139.7530406	18.30	2026-05-07 12:11:44.527
186	2	32	35.6914829	139.7526045	18.30	2026-05-07 12:11:45.53
187	2	33	35.6917815	139.7521876	18.30	2026-05-07 12:11:46.53
188	2	34	35.6920769	139.7517713	18.30	2026-05-07 12:11:47.532
189	2	35	35.6923732	139.7513564	18.30	2026-05-07 12:11:48.533
190	2	36	35.6926699	139.7509399	18.30	2026-05-07 12:11:49.535
191	2	37	35.6929651	139.7505247	18.30	2026-05-07 12:11:50.539
192	2	38	35.6932616	139.7501083	18.30	2026-05-07 12:11:51.541
193	2	39	35.6934477	139.7498411	18.30	2026-05-07 12:11:52.545
194	2	40	35.6937313	139.7488822	18.30	2026-05-07 12:11:53.547
195	2	41	35.6938908	139.7483059	18.30	2026-05-07 12:11:54.551
196	2	42	35.6940364	139.7477841	18.30	2026-05-07 12:11:55.556
197	2	43	35.6941828	139.7472671	18.30	2026-05-07 12:11:56.558
198	2	44	35.6943303	139.7467493	18.30	2026-05-07 12:11:57.564
199	2	45	35.6946266	139.7457138	18.30	2026-05-07 12:11:59.537
200	2	46	35.6947750	139.7451948	18.30	2026-05-07 12:12:00.537
201	2	47	35.6949233	139.7446764	18.30	2026-05-07 12:12:01.539
202	2	48	35.6950720	139.7441564	18.30	2026-05-07 12:12:02.572
203	2	49	35.6952198	139.7436398	18.30	2026-05-07 12:12:03.572
204	2	50	35.6953052	139.7433143	18.30	2026-05-07 12:12:04.578
205	2	51	35.6949894	139.7436335	18.30	2026-05-07 12:12:05.579
206	2	52	35.6946359	139.7440116	18.30	2026-05-07 12:12:06.579
207	2	53	35.6942856	139.7443776	18.30	2026-05-07 12:12:07.581
208	2	54	35.6939411	139.7447360	18.30	2026-05-07 12:12:08.584
209	2	55	35.6935985	139.7450895	18.30	2026-05-07 12:12:09.587
210	2	56	35.6932567	139.7454416	18.30	2026-05-07 12:12:10.59
211	2	57	35.6929134	139.7457949	18.30	2026-05-07 12:12:11.593
212	2	58	35.6925716	139.7461468	18.30	2026-05-07 12:12:12.595
213	2	59	35.6922271	139.7464942	18.30	2026-05-07 12:12:13.598
214	2	60	35.6918074	139.7463436	18.30	2026-05-07 12:12:14.602
215	2	61	35.6913810	139.7461417	18.30	2026-05-07 12:12:15.604
216	2	62	35.6909550	139.7459455	18.30	2026-05-07 12:12:16.609
217	2	63	35.6905283	139.7457552	18.30	2026-05-07 12:12:17.61
218	2	64	35.6901031	139.7455673	18.30	2026-05-07 12:12:18.612
219	2	65	35.6896778	139.7453802	18.30	2026-05-07 12:12:19.618
220	2	66	35.6892544	139.7451934	18.30	2026-05-07 12:12:20.623
221	2	67	35.6884208	139.7448266	18.30	2026-05-07 12:12:22.038
222	2	68	35.6879772	139.7446330	18.30	2026-05-07 12:12:23.039
223	2	69	35.6875370	139.7444434	18.30	2026-05-07 12:12:24.63
224	2	70	35.6871285	139.7442635	18.30	2026-05-07 12:12:25.634
225	2	71	35.6867040	139.7440762	18.30	2026-05-07 12:12:26.635
226	2	72	35.6862773	139.7438897	18.30	2026-05-07 12:12:27.64
227	2	73	35.6858317	139.7438089	18.30	2026-05-07 12:12:28.641
228	2	74	35.6853846	139.7437371	18.30	2026-05-07 12:12:29.645
229	2	75	35.6849379	139.7436641	18.30	2026-05-07 12:12:30.648
230	2	76	35.6844911	139.7435914	18.30	2026-05-07 12:12:31.652
231	2	77	35.6840429	139.7435168	18.30	2026-05-07 12:12:32.658
232	2	78	35.6835962	139.7434418	18.30	2026-05-07 12:12:33.662
233	2	79	35.6831493	139.7433683	18.30	2026-05-07 12:12:34.67
234	2	80	35.6827028	139.7432935	18.30	2026-05-07 12:12:35.672
235	2	81	35.6818385	139.7431457	18.30	2026-05-07 12:12:37.036
236	2	82	35.6812966	139.7432762	18.30	2026-05-07 12:12:38.188
237	2	83	35.6808526	139.7434454	18.30	2026-05-07 12:12:39.672
238	3	0	35.6850150	139.7618167	0.00	2026-05-07 12:19:13.576
239	3	1	35.6850150	139.7618167	0.00	2026-05-07 12:19:13.576
240	3	2	35.6850350	139.7612559	0.00	2026-05-07 12:19:14.745
241	3	3	35.6850350	139.7612559	0.00	2026-05-07 12:19:14.745
242	3	4	35.6850532	139.7607147	0.00	2026-05-07 12:19:15.749
243	3	5	35.6850532	139.7607147	0.00	2026-05-07 12:19:15.749
244	3	6	35.6850731	139.7601661	0.00	2026-05-07 12:19:16.752
245	3	7	35.6850731	139.7601661	0.00	2026-05-07 12:19:16.752
246	3	8	35.6850932	139.7596177	0.00	2026-05-07 12:19:17.754
247	3	9	35.6850932	139.7596177	0.00	2026-05-07 12:19:17.754
248	3	10	35.6851117	139.7590681	0.00	2026-05-07 12:19:18.754
249	3	11	35.6851117	139.7590681	0.00	2026-05-07 12:19:18.754
250	3	12	35.6851316	139.7585178	0.00	2026-05-07 12:19:19.761
251	3	13	35.6851316	139.7585178	0.00	2026-05-07 12:19:19.761
252	3	14	35.6851500	139.7579682	0.00	2026-05-07 12:19:20.761
253	3	15	35.6851500	139.7579682	0.00	2026-05-07 12:19:20.761
254	3	16	35.6851699	139.7574181	0.00	2026-05-07 12:19:21.761
255	3	17	35.6851699	139.7574181	0.00	2026-05-07 12:19:21.761
256	3	18	35.6851908	139.7568686	0.00	2026-05-07 12:19:22.764
257	3	19	35.6851908	139.7568686	0.00	2026-05-07 12:19:22.764
258	3	20	35.6854323	139.7572584	0.00	2026-05-07 12:19:23.767
259	3	21	35.6854323	139.7572584	0.00	2026-05-07 12:19:23.767
260	3	22	35.6856940	139.7577571	0.00	2026-05-07 12:19:24.771
261	3	23	35.6856940	139.7577571	0.00	2026-05-07 12:19:24.771
262	3	24	35.6859545	139.7582378	0.00	2026-05-07 12:19:25.776
263	3	25	35.6859545	139.7582378	0.00	2026-05-07 12:19:25.776
264	3	26	35.6862112	139.7587052	0.00	2026-05-07 12:19:26.78
265	3	27	35.6862112	139.7587052	0.00	2026-05-07 12:19:26.78
266	3	28	35.6865165	139.7592405	0.00	2026-05-07 12:19:27.785
267	3	29	35.6865165	139.7592405	0.00	2026-05-07 12:19:27.785
268	3	30	35.6868298	139.7589030	0.00	2026-05-07 12:19:28.786
269	3	31	35.6868298	139.7589030	0.00	2026-05-07 12:19:28.786
270	3	32	35.6871442	139.7584761	0.00	2026-05-07 12:19:29.79
271	3	33	35.6871442	139.7584761	0.00	2026-05-07 12:19:29.79
272	3	34	35.6874565	139.7580595	0.00	2026-05-07 12:19:30.796
273	3	35	35.6874565	139.7580595	0.00	2026-05-07 12:19:30.796
274	3	36	35.6877698	139.7576506	0.00	2026-05-07 12:19:31.8
275	3	37	35.6877698	139.7576506	0.00	2026-05-07 12:19:31.8
276	3	38	35.6880831	139.7572472	0.00	2026-05-07 12:19:32.801
277	3	39	35.6880831	139.7572472	0.00	2026-05-07 12:19:32.801
278	3	40	35.6883950	139.7568433	0.00	2026-05-07 12:19:33.806
279	3	41	35.6883950	139.7568433	0.00	2026-05-07 12:19:33.806
280	3	42	35.6890185	139.7560422	0.00	2026-05-07 12:19:35.535
281	3	43	35.6890185	139.7560422	0.00	2026-05-07 12:19:35.535
282	3	44	35.6893388	139.7556292	0.00	2026-05-07 12:19:36.812
283	3	45	35.6893388	139.7556292	0.00	2026-05-07 12:19:36.812
284	3	46	35.6896453	139.7552346	0.00	2026-05-07 12:19:37.811
285	3	47	35.6896453	139.7552346	0.00	2026-05-07 12:19:37.811
286	3	48	35.6899575	139.7548324	0.00	2026-05-07 12:19:38.817
287	3	49	35.6899575	139.7548324	0.00	2026-05-07 12:19:38.817
288	3	50	35.6902141	139.7545032	0.00	2026-05-07 12:19:39.82
289	3	51	35.6902141	139.7545032	0.00	2026-05-07 12:19:39.82
290	3	52	35.6904966	139.7540752	0.00	2026-05-07 12:19:40.82
291	3	53	35.6904966	139.7540752	0.00	2026-05-07 12:19:40.82
292	3	54	35.6907847	139.7536352	0.00	2026-05-07 12:19:41.823
293	3	55	35.6907847	139.7536352	0.00	2026-05-07 12:19:41.823
294	3	56	35.6910732	139.7531957	0.00	2026-05-07 12:19:42.826
295	3	57	35.6910732	139.7531957	0.00	2026-05-07 12:19:42.826
296	4	0	35.6925595	139.7510947	0.00	2026-05-10 00:48:53.575
297	4	1	35.6925595	139.7510947	0.00	2026-05-10 00:48:53.575
298	4	2	35.6849767	139.7629150	0.00	2026-05-10 00:48:55.58
299	4	3	35.6849767	139.7629150	0.00	2026-05-10 00:48:55.58
300	4	4	35.6849800	139.7628049	0.00	2026-05-10 00:48:56.583
301	4	5	35.6849800	139.7628049	0.00	2026-05-10 00:48:56.583
302	4	6	35.6849848	139.7626964	0.00	2026-05-10 00:48:57.585
303	4	7	35.6849848	139.7626964	0.00	2026-05-10 00:48:57.585
304	4	8	35.6849883	139.7625865	0.00	2026-05-10 00:48:58.59
305	4	9	35.6849883	139.7625865	0.00	2026-05-10 00:48:58.59
306	4	10	35.6849917	139.7624767	0.00	2026-05-10 00:48:59.592
307	4	11	35.6849917	139.7624767	0.00	2026-05-10 00:48:59.592
308	4	12	35.6849965	139.7623666	0.00	2026-05-10 00:49:00.596
309	4	13	35.6849965	139.7623666	0.00	2026-05-10 00:49:00.596
310	4	14	35.6850000	139.7622566	0.00	2026-05-10 00:49:01.598
311	4	15	35.6850000	139.7622566	0.00	2026-05-10 00:49:01.598
312	4	16	35.6850033	139.7621466	0.00	2026-05-10 00:49:02.605
313	4	17	35.6850033	139.7621466	0.00	2026-05-10 00:49:02.605
314	4	18	35.6850081	139.7620366	0.00	2026-05-10 00:49:03.61
315	4	19	35.6850081	139.7620366	0.00	2026-05-10 00:49:03.61
316	4	20	35.6850116	139.7619266	0.00	2026-05-10 00:49:04.612
317	4	21	35.6850116	139.7619266	0.00	2026-05-10 00:49:04.612
318	4	22	35.6850150	139.7618166	0.00	2026-05-10 00:49:05.617
319	4	23	35.6850150	139.7618166	0.00	2026-05-10 00:49:05.617
320	4	24	35.6850198	139.7617066	0.00	2026-05-10 00:49:06.62
321	4	25	35.6850198	139.7617066	0.00	2026-05-10 00:49:06.62
322	4	26	35.6850233	139.7615965	0.00	2026-05-10 00:49:07.628
323	4	27	35.6850233	139.7615965	0.00	2026-05-10 00:49:07.628
324	4	28	35.6850267	139.7614865	0.00	2026-05-10 00:49:08.638
325	4	29	35.6850267	139.7614865	0.00	2026-05-10 00:49:08.638
326	4	30	35.6850533	139.7607174	0.00	2026-05-10 00:49:15.416
327	4	31	35.6850533	139.7607174	0.00	2026-05-10 00:49:15.416
328	4	32	35.6850581	139.7606062	0.00	2026-05-10 00:49:16.453
329	4	33	35.6850581	139.7606062	0.00	2026-05-10 00:49:16.453
330	4	34	35.6850617	139.7604936	0.00	2026-05-10 00:49:17.655
331	4	35	35.6850617	139.7604936	0.00	2026-05-10 00:49:17.655
332	4	36	35.6850650	139.7603862	0.00	2026-05-10 00:49:18.658
333	4	37	35.6850650	139.7603862	0.00	2026-05-10 00:49:18.658
334	4	38	35.6850698	139.7602765	0.00	2026-05-10 00:49:19.661
335	4	39	35.6850698	139.7602765	0.00	2026-05-10 00:49:19.661
336	4	40	35.6850733	139.7601666	0.00	2026-05-10 00:49:20.664
337	4	41	35.6850733	139.7601666	0.00	2026-05-10 00:49:20.664
338	5	0	35.6849966	139.7623666	0.00	2026-05-10 02:41:06.217
339	5	1	35.6851879	139.7568830	0.00	2026-05-10 02:41:55.439
340	5	2	35.6865203	139.7592571	0.00	2026-05-10 02:42:22.409
341	5	3	35.6902098	139.7545098	0.00	2026-05-10 02:43:20.441
342	5	4	35.6934393	139.7498593	0.00	2026-05-10 02:44:15.754
343	5	5	35.6953057	139.7433294	0.00	2026-05-10 02:45:18.901
344	5	6	35.6922296	139.7464964	0.00	2026-05-10 02:46:04.037
345	5	7	35.6862859	139.7438914	0.00	2026-05-10 02:47:13.435
346	5	8	35.6817183	139.7431311	0.00	2026-05-10 02:48:05.368
347	5	9	35.6803600	139.7436409	0.00	2026-05-10 02:48:21.408
348	5	10	35.6802919	139.7464034	0.00	2026-05-10 02:48:45.465
349	6	0	35.2033376	136.2327878	0.00	2026-05-24 06:16:30.778
350	6	1	35.2029805	136.2338258	0.00	2026-05-24 06:17:40.009
351	7	0	35.2029783	136.2338283	0.00	2026-05-24 06:50:20.59
352	7	1	35.2033283	136.2328154	0.00	2026-05-24 06:50:31.633
353	8	0	35.2033404	136.2327862	0.00	2026-05-24 07:04:11.204
354	8	1	35.2033404	136.2327862	0.00	2026-05-24 07:04:11.204
355	9	0	39.9504943	116.3357562	64.67	2026-05-24 07:30:20.776
356	9	1	39.9498669	116.3358290	64.18	2026-05-24 07:30:39.162
357	9	2	39.9504957	116.3357582	64.18	2026-05-24 07:30:40.776
358	10	0	39.9502107	116.3358607	46.10	2026-05-31 03:06:29.797
359	10	1	39.9500867	116.3357949	46.10	2026-05-31 03:07:37.849
\.


--
-- Data for Name: route_rating; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.route_rating (id, route_id, user_id, score, comment, created_at) FROM stdin;
\.


--
-- Data for Name: route_spot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.route_spot (id, route_id, spot_id, visit_order) FROM stdin;
1	8	763	0
2	9	931	0
3	10	931	0
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: spot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spot (id, anime_id, anitabi_point_id, name_cn, name, image_url, episode, scene_seconds, latitude, longitude, location, origin, origin_url, created_at) FROM stdin;
1028	328609	uqgdippqc	\N	白鵬女子高等学校	https://image.anitabi.cn/points/328609/uqgdippqc_1744849649178.jpg?plan=h160	1	428	35.5158000	139.6589000	0101000020E6100000B3EA73B5157561406EA301BC05C24140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.10926
1046	328609	cp5nbm	\N	下北沢パーキング	https://image.anitabi.cn/points/328609/cp5nbm_1747778203048.jpg?plan=h160	4	621	35.6627000	139.6691000	0101000020E61000001D386744697561409487855AD3D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:17.780376
1022	328609	uqdj3kh28	\N	下北沢SHELTER	https://image.anitabi.cn/points/328609/uqdj3kh28_1744843458012.jpg?plan=h160	1	253	35.6615000	139.6694000	0101000020E6100000287E8CB96B756140E9263108ACD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:15.469701
1025	328609	cm9tso	\N	八景生花店	https://image.anitabi.cn/points/328609/cm9tso_1747773358419.jpg?plan=h160	1	419	35.3312000	139.6206000	0101000020E6100000B9FC87F4DB736140B537F8C264AA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:15.789545
1026	328609	4xydgsp7r	\N	金沢八景マンション前の歩道	https://image.anitabi.cn/points/328609/4xydgsp7r_1672251037005.jpg?plan=h160	1	423	35.3297000	139.6238000	0101000020E6100000D5E76A2BF6736140E0BE0E9C33AA4140	87AnimeProject	\N	2026-05-31 22:40:15.897703
1031	328609	uqesctl9j	Village/Vanguard 下北沢店	ヴィレッジヴァンガード下北沢店	https://image.anitabi.cn/points/328609/uqesctl9j_1744846193527.jpg?plan=h160	1	619	35.6618000	139.6686000	0101000020E610000061C3D32B65756140143FC6DCB5D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.396817
1091	328609	ckhw5z	\N	江島神社 奉安殿	https://image.anitabi.cn/points/328609/ckhw5z_1747770376384.jpg?plan=h160	9	1110	35.3002000	139.4798000	0101000020E6100000DE9387855A6F61402D211FF46CA64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:29.581289
1027	328609	4yd2vzbcg	金沢八景站前罗森	Lawson 金沢八景駅前	https://image.anitabi.cn/points/328609/4yd2vzbcg_1672251032670.jpg?plan=h160	1	433	35.3311000	139.6206000	0101000020E6100000B9FC87F4DB73614051DA1B7C61AA4140	林宏	\N	2026-05-31 22:40:16.010512
1045	328609	4yd2vzc9s	\N	どんぐりひろば公園	https://image.anitabi.cn/points/328609/4yd2vzc9s.jpg?plan=h160	4	619	35.6643000	139.6687000	0101000020E6100000BADA8AFD65756140CC5D4BC807D54140	林宏	\N	2026-05-31 22:40:17.69031
1032	328609	4xygg8inc	Village Vanguard 下北沢店	ヴィレッジヴァンガード下北沢店	https://image.anitabi.cn/points/328609/4xygg8inc_1672251053625.jpg?plan=h160	1	633	35.6617000	139.6687000	0101000020E6100000BADA8AFD65756140B1E1E995B2D44140	7th-august	\N	2026-05-31 22:40:16.479506
1023	328609	dfbf2731	\N	金泽八景駅内	https://image.anitabi.cn/points/328609/dfbf2731_1739363147444.jpg?plan=h160	1	373	35.3314000	139.6202000	0101000020E6100000569FABADD87361407CF2B0506BAA4140	林宏	\N	2026-05-31 22:40:15.56764
1029	328609	4xyfjc6rm	\N	松ノ木児童遊園	https://image.anitabi.cn/points/328609/4xyfjc6rm_1672251023469.jpg?plan=h160	1	511	35.6948000	139.6465000	0101000020E6100000A69BC420B074614062A1D634EFD84140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-31 22:40:16.209789
1037	328609	croeok	\N	下北沢 美容室 estrella	https://image.anitabi.cn/points/328609/croeok_1747782442251.jpg?plan=h160	3	566	35.6619000	139.6683000	0101000020E6100000567DAEB662756140789CA223B9D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.97539
1033	328609	uqexb0y5s	\N	劇・小劇場	https://image.anitabi.cn/points/328609/uqexb0y5s_1744846493602.jpg?plan=h160	1	662	35.6616000	139.6690000	0101000020E6100000C520B072687561404D840D4FAFD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.570345
617	152091	kq99l94ew	\N	笠取​第一​中継​ポンプ場	https://image.anitabi.cn/points/152091/kq99l94ew_1716623077718.jpg?plan=h160	3	621	34.9378000	135.8532000	0101000020E61000004F1E166A4DFB60402B1895D409784140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:30.122888
1036	328609	cl5jpa	\N	金沢八景マンション前	https://image.anitabi.cn/points/328609/cl5jpa_1747771479220.jpg?plan=h160	3	65	35.3296000	139.6239000	0101000020E61000002EFF21FDF67361407C61325530AA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.873266
1034	328609	csr0hh	\N	江の島大橋	https://image.anitabi.cn/points/328609/csr0hh_1747784239628.jpg?plan=h160	2	337	35.3059000	139.4831000	0101000020E61000005396218E756F614057EC2FBB27A74140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.675202
1040	328609	cpdz63	\N	下北沢 時代屋	https://image.anitabi.cn/points/328609/cpdz63_1747778591856.jpg?plan=h160	4	599	35.6624000	139.6679000	0101000020E6100000F31FD26F5F756140696FF085C9D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:17.245118
1039	328609	uqdgd7ss5	\N	無印良品 下北沢	https://image.anitabi.cn/points/328609/uqdgd7ss5_1744843291381.jpg?plan=h160	4	598	35.6618000	139.6667000	0101000020E6100000C8073D9B55756140143FC6DCB5D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:17.150168
1047	328609	uqeh3wddi	Times下北泽第8	タイムズ下北沢第８	https://image.anitabi.cn/points/328609/uqeh3wddi_1744845513051.jpg?plan=h160	4	646	35.6626000	139.6691000	0101000020E61000001D38674469756140302AA913D0D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:17.913248
10	115908	7evkbmy2	井用机前步行道	あじろぎの道	https://image.anitabi.cn/points/115908/7evkbmy2.jpg?plan=h160	1	128	34.8899000	135.8081000	0101000020E6100000B9FC87F4DBF96040EE5A423EE8714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:19.148291
1044	328609	4yd0fz2uz	Times代沢第5	タイムズ代沢第５	https://image.anitabi.cn/points/328609/4yd0fz2uz_1744845419738.jpg?plan=h160	4	607	35.6590000	139.6690000	0101000020E6100000C520B072687561403108AC1C5AD44140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-31 22:40:17.596313
1038	328609	4yd2vzbuq	\N	RAINBOW cafe, dining & bar 下北沢	https://image.anitabi.cn/points/328609/4yd2vzbuq.jpg?plan=h160	4	596	35.6629000	139.6685000	0101000020E610000008AC1C5A647561405B423EE8D9D44140	林宏	\N	2026-05-31 22:40:17.067333
634	152091	s8gzmpepe	\N	(有)ウェルホーム	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8gzmpepe-1737798278454.jpg?plan=h160	9	1018	34.8988000	135.8061000	0101000020E6100000C7293A92CBF9604089D2DEE00B734140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:40.868452
1042	328609	4yd2vzc6m	\N	下北沢第二自転車等駐車場	https://image.anitabi.cn/points/328609/4yd2vzc6m.jpg?plan=h160	4	613	35.6605000	139.6694000	0101000020E6100000287E8CB96B756140068195438BD44140	林宏	\N	2026-05-31 22:40:17.420429
1048	328609	uqd7fzwah	\N	フォーカス	https://image.anitabi.cn/points/328609/uqd7fzwah_1744842751848.jpg?plan=h160	4	650	35.6639000	139.6680000	0101000020E61000004C378941607561403EE8D9ACFAD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:18.121193
1024	328609	uqg9tm0xs	\N	八景橋	https://image.anitabi.cn/points/328609/uqg9tm0xs_1744849428823.jpg?plan=h160	1	411	35.3290000	139.6249000	0101000020E6100000A7E8482EFF736140273108AC1CAA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:15.685502
1094	328609	50slhscxa	\N	小田急新宿駅	https://image.anitabi.cn/points/328609/50slhscxa_1672311106910.jpg?plan=h160	10	783	35.6896000	139.7005000	0101000020E610000023DBF97E6A7661402AA913D044D84140	林宏	\N	2026-05-31 22:40:30.398713
1053	328609	4yd2vzc2f	\N	第５話　自販機	https://image.anitabi.cn/user/0/bangumi/328609/points/4yd2vzc2f-1722093267516.jpg?plan=h160	5	743	35.6616000	139.6691000	0101000020E61000001D386744697561404D840D4FAFD44140	林宏	\N	2026-05-31 22:40:19.450458
1050	328609	4yd2vzby1	\N	ADRIFT	https://image.anitabi.cn/points/328609/4yd2vzby1.jpg?plan=h160	4	1216	35.6638000	139.6708000	0101000020E610000005C58F3177756140DB8AFD65F7D44140	林宏	\N	2026-05-31 22:40:18.634142
1076	328609	mf6w6uprc	藤泽警察署片濑江之岛派出所	藤沢警察署片瀬江の島交番	https://image.anitabi.cn/user/0/bangumi/328609/points/mf6w6uprc-1721398287194.jpg?plan=h160	9	684	35.3069000	139.4841000	0101000020E6100000CC7F48BF7D6F61403A92CB7F48A74140	Anitabi	https://anitabi.cn/	2026-05-31 22:40:25.79924
1060	328609	uqgvi85q1	\N	横浜金澤七福神 弁財天	https://image.anitabi.cn/points/328609/uqgvi85q1_1744850739931.jpg?plan=h160	6	182	35.3319000	139.6222000	0101000020E61000004772F90FE97361406DC5FEB27BAA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:21.398852
1075	328609	ne4els85a	\N	江の島東浜海水浴場	https://image.anitabi.cn/points/328609/ne4els85a_1724135455901.jpg?plan=h160	9	673	35.3072000	139.4846000	0101000020E610000088F4DBD7816F614065AA605452A74140	Anitabi@ꦿ ひとり࿐	https://anitabi.cn/	2026-05-31 22:40:25.483925
1077	328609	civzmb	\N	江ノ島海岸 バス停	https://image.anitabi.cn/points/328609/civzmb_1747767675816.jpg?plan=h160	9	685	35.3069000	139.4840000	0101000020E6100000736891ED7C6F61403A92CB7F48A74140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:26.209403
1062	328609	cmbyk3	\N	金沢八景駅前	https://image.anitabi.cn/points/328609/cmbyk3_1747773457112.jpg?plan=h160	6	1230	35.3313000	139.6205000	0101000020E610000060E5D022DB7361401895D40968AA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:21.911612
1074	328609	ne6c3mzey	KUA`AINA 片瀬江之岛店	Kua Aina Sandwich Shop	https://image.anitabi.cn/points/328609/ne6c3mzey_1724139658471.jpg?plan=h160	9	685	35.3085000	139.4835000	0101000020E6100000B6F3FDD4786F6140736891ED7CA74140	Anitabi@ꦿ ひとり࿐	https://anitabi.cn/	2026-05-31 22:40:25.181131
1056	328609	50slhschi	\N	湯田ダム	https://image.anitabi.cn/points/328609/50slhschi_1672311122120.jpg?plan=h160	5	1126	39.3015000	140.8850000	0101000020E6100000B81E85EB519C61403BDF4F8D97A64340	林宏	\N	2026-05-31 22:40:20.36721
1068	328609	uqcolbhrn	\N	46ma	https://image.anitabi.cn/points/328609/uqcolbhrn_1744841614219.jpg?plan=h160	7	919	35.6616000	139.6695000	0101000020E61000008195438B6C7561404D840D4FAFD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:23.481406
1065	328609	4xyq3y683	\N	追浜園入口付近	https://image.anitabi.cn/user/1000/bangumi/null/points/4xyq3y683.jpg?plan=h160	7	5	35.3302000	139.6228000	0101000020E61000005DFE43FAED736140D1915CFE43AA4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-31 22:40:22.774125
1055	328609	50slhscvm	\N	黒部ダム	https://image.anitabi.cn/points/328609/50slhscvm_1672311121240.jpg?plan=h160	5	1122	36.5665000	137.6621000	0101000020E6100000D0D556EC2F3561408D976E1283484240	林宏	\N	2026-05-31 22:40:20.066694
1057	328609	50slhscip	\N	味噌川ダム	https://image.anitabi.cn/points/328609/50slhscip_1672311123054.jpg?plan=h160	5	1132	35.9768000	137.7702000	0101000020E6100000226C787AA5386140CC5D4BC807FD4140	林宏	\N	2026-05-31 22:40:20.604521
1078	328609	50slhsc7s	\N	あさひ本店	https://image.anitabi.cn/points/328609/50slhsc7s_1672311110360.jpg?plan=h160	9	722	35.3009000	139.4804000	0101000020E6100000F31FD26F5F6F6140E6AE25E483A64140	林宏	\N	2026-05-31 22:40:26.519213
1072	328609	cn0zxm	\N	片瀬江ノ島駅	https://image.anitabi.cn/points/328609/cn0zxm_1747774628252.jpg?plan=h160	9	641	35.3093000	139.4828000	0101000020E61000004850FC18736F61408F53742497A74140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:24.675326
1073	328609	82a8a1d5	片濑江之岛站		https://image.anitabi.cn/points/328609/82a8a1d5_1739361888749.jpg?plan=h160	9	652	35.3087000	139.4834000	0101000020E61000005DDC4603786F61403A234A7B83A74140	林宏	\N	2026-05-31 22:40:24.977448
1054	328609	50slhsc7q	\N	滝沢ダム	https://image.anitabi.cn/points/328609/50slhsc7q_1672311120319.jpg?plan=h160	5	1118	35.9559000	138.8980000	0101000020E6100000DBF97E6ABC5C61408A1F63EE5AFA4140	林宏	\N	2026-05-31 22:40:19.759274
1069	328609	uqct3vrkm	\N	中華 丸長	https://image.anitabi.cn/points/328609/uqct3vrkm_1744841895784.jpg?plan=h160	7	938	35.6554000	139.6673000	0101000020E6100000DE9387855A75614032E6AE25E4D34140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:23.754109
1101	328609	co69di	\N	BigBossお茶の水駅前店 別館	https://image.anitabi.cn/points/328609/co69di_1747776551788.jpg?plan=h160	12	894	35.6993000	139.7630000	0101000020E610000023DBF97E6A786140E10B93A982D94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:32.349236
1063	328609	50slhscht	\N	金沢八景駅	https://image.anitabi.cn/points/328609/50slhscht_1672311103412.jpg?plan=h160	6	1243	35.3313000	139.6206000	0101000020E6100000B9FC87F4DB7361401895D40968AA4140	林宏	\N	2026-05-31 22:40:22.208834
1067	328609	uqgmy0i50	\N	純福音金沢教会	https://image.anitabi.cn/points/328609/uqgmy0i50_1744850220104.jpg?plan=h160	7	118	35.3249000	139.6235000	0101000020E6100000CBA145B6F3736140363CBD5296A94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:23.206062
1071	328609	cq56gy	\N	小田急線車内	https://image.anitabi.cn/points/328609/cq56gy_1747779859226.jpg?plan=h160	9	534	35.6602000	139.6655000	0101000020E61000009EEFA7C64B756140DC68006F81D44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:24.358222
37	115908	kq2co5wd9	\N	莵道高 教学楼入口处	https://image.anitabi.cn/points/115908/kq2co5wd9_1716608022743.jpg?plan=h160	12	777	34.9091000	135.8164000	0101000020E61000008A8EE4F21FFA6040956588635D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:48.644412
1064	328609	uqg73mmm6	海之公园	海の公園	https://image.anitabi.cn/points/328609/uqg73mmm6_1744849262987.jpg?plan=h160	6	1277	35.3392000	139.6346000	0101000020E610000055C1A8A44E746140CF66D5E76AAB4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:22.527539
1066	328609	uqgofed83	\N	後藤歯科医院	https://image.anitabi.cn/points/328609/uqgofed83_1744850309559.jpg?plan=h160	7	102	35.3268000	139.6255000	0101000020E6100000BC74931804746140992A1895D4A94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:22.933594
1059	328609	4xyo0266j	\N	琵琶島神社鳥居付近	https://image.anitabi.cn/user/1000/bangumi/null/points/4xyo0266j.jpg?plan=h160	6	176	35.3320000	139.6221000	0101000020E6100000EE5A423EE8736140D122DBF97EAA4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-31 22:40:21.194005
643	152091	s8ntk6jod	\N	プロジェクトアオキ	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8ntk6jod-1737813084128.jpg?plan=h160	6	790	34.8880000	135.8051000	0101000020E61000004F401361C3F960408B6CE7FBA9714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:47.016684
1058	328609	mmfhsd0ua	弁财天	弁財天	https://image.anitabi.cn/user/0/bangumi/328609/points/mmfhsd0ua-1721965409996.jpg?plan=h160	6	65	35.3319000	139.6223000	0101000020E6100000A089B0E1E97361406DC5FEB27BAA4140	Anitabi	https://anitabi.cn/	2026-05-31 22:40:20.881815
1206	215425	p9q75g3di	\N	やき鳥 福鳥 本店	https://image.anitabi.cn/user/1065/bangumi/215425/points/p9q75g3di-1729433339957.jpg?plan=h160	\N	3761	43.0568000	141.3549000	0101000020E610000036AB3E575BAB6140D734EF3845874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.274488
1097	328609	uqd394ow3	食其家 下北泽店	すき家 下北沢店	https://image.anitabi.cn/points/328609/uqd394ow3_1744842506336.jpg?plan=h160	10	1224	35.6610000	139.6676000	0101000020E6100000E8D9ACFA5C756140F853E3A59BD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:31.32155
1083	328609	ne66y5zn9	\N	メルヘン​グラス​フック	https://image.anitabi.cn/points/328609/ne66y5zn9_1724139345745.jpg?plan=h160	9	890	35.3006000	139.4804000	0101000020E6100000F31FD26F5F6F6140BC96900F7AA64140	Anitabi@ꦿ ひとり࿐	https://anitabi.cn/	2026-05-31 22:40:28.049941
1080	328609	f0ff9fbe	\N	江ノ島神社大鳥居	https://image.anitabi.cn/points/328609/f0ff9fbe_1739361977717.jpg?plan=h160	9	794	35.3007000	139.4803000	0101000020E61000009A081B9E5E6F61401FF46C567DA64140	林宏	\N	2026-05-31 22:40:27.128203
1090	328609	ne4qwvnsz	\N	サムエル・コッキング苑	https://image.anitabi.cn/points/328609/ne4qwvnsz_1724136202187.jpg?plan=h160	9	1101	35.2990000	139.4798000	0101000020E6100000DE9387855A6F614083C0CAA145A64140	Anitabi@ꦿ ひとり࿐	https://anitabi.cn/	2026-05-31 22:40:29.300605
1086	328609	b3yeyb	\N	大道芸広場	https://image.anitabi.cn/points/328609/b3yeyb_1747682126384.jpg?plan=h160	9	928	35.2989000	139.4803000	0101000020E61000009A081B9E5E6F61402063EE5A42A64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:28.512083
1095	328609	cqsz7t	\N	新宿LOFT	https://image.anitabi.cn/points/328609/cqsz7t_1747780970691.jpg?plan=h160	10	783	35.6954000	139.7025000	0101000020E610000014AE47E17A766140B7D100DE02D94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:30.713834
1082	328609	b40ee17a	\N	江ノ島 エスカー乗り場	https://image.anitabi.cn/points/328609/b40ee17a_1739364064402.jpg?plan=h160	9	886	35.3005000	139.4804000	0101000020E6100000F31FD26F5F6F61405839B4C876A64140	林宏	\N	2026-05-31 22:40:27.742903
1081	328609	ck81vp	江之岛自动扶梯 1区入口	江の島エスカー 1区乗り場	https://image.anitabi.cn/points/328609/ck81vp_1747769934888.jpg?plan=h160	9	875	35.3005000	139.4804000	0101000020E6100000F31FD26F5F6F61405839B4C876A64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:27.431347
1087	328609	ci1f8j	江之岛SeaCandle	江の島シーキャンドル	https://image.anitabi.cn/points/328609/ci1f8j_1747766285409.jpg?plan=h160	9	973	35.2996000	139.4798000	0101000020E6100000DE9387855A6F6140D8F0F44A59A64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:28.761971
1092	328609	ckq86a	\N	江島神社 辺津宮	https://image.anitabi.cn/points/328609/ckq86a_1747770764050.jpg?plan=h160	9	1140	35.3003000	139.4798000	0101000020E6100000DE9387855A6F6140917EFB3A70A64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:29.897082
1084	328609	b3e522	江之岛自动扶梯 3区	江の島エスカー 3区	https://image.anitabi.cn/points/328609/b3e522_1747681349725.jpg?plan=h160	9	904	35.2991000	139.4805000	0101000020E61000004C378941606F6140E71DA7E848A64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:28.287409
921	246429	ug8ouz	学习院下站·早稻田方向	学习院下站·早稻田方向	https://image.anitabi.cn/user/0/bangumi/246429/points/ug8ouz-1748851847918.jpg?plan=h160	8	1021	35.7161000	139.7124000	0101000020E610000074B515FBCB7661403255302AA9DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.722174
1085	328609	b3wtox	江之岛自动扶梯 3区出口	江の島エスカー 3区降り場	https://image.anitabi.cn/points/328609/b3wtox_1747682053685.jpg?plan=h160	9	925	35.2990000	139.4804000	0101000020E6100000F31FD26F5F6F614083C0CAA145A64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:28.381974
1093	328609	161b37c4	\N	瀬戸５−１ 金沢八景マンション	https://image.anitabi.cn/points/328609/161b37c4_1739363103451.jpg?plan=h160	10	634	35.3299000	139.6230000	0101000020E61000000E2DB29DEF736140A779C7293AAA4140	林宏	\N	2026-05-31 22:40:30.19164
923	246429	ulu183	不忍通り&目白通り·交叉口	不忍通り&目白通り·交叉口	https://image.anitabi.cn/user/0/bangumi/246429/points/ulu183-1748861073906.jpg?plan=h160	9	1127	35.7169000	139.7183000	0101000020E6100000F0164850FC7661404F401361C3DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.877704
73	115908	kq28w7gy2	\N	莵道高 久美子练号处 全景	https://image.anitabi.cn/points/115908/kq28w7gy2_1716607794034.jpg?plan=h160	12	717	34.9101000	135.8160000	0101000020E6100000273108AC1CFA6040780B24287E744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:19.055704
925	246429	un8n4q	本郷通り&明治通り·交叉口	本郷通り&明治通り·交叉口	https://image.anitabi.cn/user/0/bangumi/246429/points/un8n4q-1748863475984.jpg?plan=h160	11	667	35.7509000	139.7372000	0101000020E61000008F537424977761408048BF7D1DE04140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:57.032778
919	246429	umk0bm0lg	学习院下站	学習院下駅	https://image.anitabi.cn/points/186515/de7606b6_1722414039593.jpg?plan=h160	8	944	35.7166000	139.7126000	0101000020E610000026E4839ECD76614024287E8CB9DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.7166%2C139.712607&z=17	2026-05-24 11:02:56.583377
920	246429	umk0bm0np	学习院下站2	学習院下駅２	https://image.anitabi.cn/points/186515/22967403_1722414041681.jpg?plan=h160	8	949	35.7163000	139.7125000	0101000020E6100000CDCCCCCCCC766140F90FE9B7AFDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.716321%2C139.712516&z=17	2026-05-24 11:02:56.653608
1104	328609	50slhschl	\N	イシバシ楽器 御茶ノ水本店 HARVEST GUITARS	https://image.anitabi.cn/points/328609/50slhschl_1672311119386.jpg?plan=h160	12	927	35.6981000	139.7626000	0101000020E6100000BF7D1D386778614036AB3E575BD94140	林宏	\N	2026-05-31 22:40:33.170109
1207	215425	rb5m0lgok	\N	函館駅	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb5m0lgok-1735187430235.jpg?plan=h160	\N	3939	41.7736000	140.7264000	0101000020E6100000107A36AB3E976140C217265305E34440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.362484
1103	328609	co3msq	\N	イシバシ楽器 御茶ノ水本店	https://image.anitabi.cn/points/328609/co3msq_1747776429030.jpg?plan=h160	12	918	35.6992000	139.7631000	0101000020E61000007CF2B0506B7861407DAEB6627FD94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:32.853716
1208	215425	rb5qv44nb	\N	青森駅	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb5qv44nb-1735187719956.jpg?plan=h160	\N	4087	40.8288000	140.7343000	0101000020E61000007DAEB6627F97614060764F1E166A4440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.489485
1209	215425	mnx8l1rmr	\N	ファミリー​マート\n青森​駅前​店	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnx8l1rmr-1729910777117.jpg?plan=h160	\N	4093	40.8281000	140.7356000	0101000020E610000001DE02098A976140A7E8482EFF694440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.585008
1099	328609	co9ds0	\N	御茶ノ水駅	https://image.anitabi.cn/points/328609/co9ds0_1747776698437.jpg?plan=h160	12	893	35.6998000	139.7635000	0101000020E6100000DF4F8D976E786140D3DEE00B93D94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:31.832041
1210	215425	mnxauqby6	\N	青森駅前公園	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnxauqby6-1729910800741.jpg?plan=h160	\N	4099	40.8273000	140.7346000	0101000020E610000088F4DBD7819761408BFD65F7E4694440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.670006
1107	328609	cqfc39	\N	新代田駅前	https://image.anitabi.cn/points/328609/cqfc39_1747780333377.jpg?plan=h160	\N	\N	35.6625000	139.6602000	0101000020E6100000371AC05B20756140CDCCCCCCCCD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:33.984952
1211	215425	rb5v9d3vw	\N	青森空港	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb5v9d3vw-1735187989356.jpg?plan=h160	\N	4114	40.7385000	140.6893000	0101000020E610000040A4DFBE0E9661404A0C022B875E4440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.757005
1096	328609	uqcyq3ijj	汉堡王 下北泽站南口店	バーガーキング 下北沢駅南口店	https://image.anitabi.cn/points/328609/uqcyq3ijj_1744842227711.jpg?plan=h160	10	1135	35.6606000	139.6675000	0101000020E61000008FC2F5285C7561406ADE718A8ED44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:31.017601
1212	215425	9rn0ubg	\N	りとるはうす しもん	https://image.anitabi.cn/user/1073/bangumi/215425/points/9rn0ubg-1768272666140.jpg?plan=h160	\N	4186	40.8251000	140.7453000	0101000020E6100000AEB6627FD9976140FDF675E09C694440	Anitabi@月即别	https://anitabi.cn/	2026-05-31 23:04:44.860714
1213	215425	9rmohge	\N	カリヨンの塔	https://image.anitabi.cn/user/1073/bangumi/215425/points/9rmohge-1768272482625.jpg?plan=h160	\N	4190	40.8246000	140.7452000	0101000020E6100000569FABADD89761400B24287E8C694440	Anitabi@月即别	https://anitabi.cn/	2026-05-31 23:04:44.945714
1108	328609	cqoiwb	\N	Zepp Haneda	https://image.anitabi.cn/points/328609/cqoiwb_1747780761613.jpg?plan=h160	\N	\N	35.5474000	139.7564000	0101000020E610000039D6C56D347861404BEA043411C64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:34.290095
1214	215425	rb67sez6j	\N	ねぶたの家ワ・ラッセ旁	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb67sez6j-1735188752288.jpg?plan=h160	\N	4194	40.8294000	140.7352000	0101000020E61000009D8026C286976140B5A679C7296A4440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.033712
1215	215425	mnxchab7h	\N	青函连络船纪念船	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnxchab7h-1729910831103.jpg?plan=h160	\N	4199	40.8317000	140.7362000	0101000020E6100000166A4DF38E976140A60A4625756A4440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.122187
860	2585	rm3jq6vd7	\N	ゆうゆう桥	https://image.anitabi.cn/user/2148/bangumi/2585/points/rm3jq6vd7-1736044971890.jpg?plan=h160	1	8	35.6221000	139.4224000	0101000020E6100000933A014D846D6140BA6B09F9A0CF4140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-05-17 10:31:47.212517
1216	215425	rb63nfkf9	灿路都大饭店青森	ホテルサンルート​青森	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb63nfkf9-1735188499241.jpg?plan=h160	\N	4250	40.8276000	140.7379000	0101000020E6100000FDF675E09C976140B515FBCBEE694440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.210554
1217	215425	rb6egh69s	\N	渡海三角点（旧竜飞）	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb6egh69s-1735189150348.jpg?plan=h160	\N	4352	41.2590000	140.3420000	0101000020E61000006DE7FBA9F18A6140FED478E926A14440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.295558
1218	215425	mnxel3jb1	\N	階段国道南方向	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnxel3jb1-1729910905136.jpg?plan=h160	\N	4574	41.2586000	140.3465000	0101000020E61000000C022B87168B6140705F07CE19A14440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.390626
1219	215425	jfumy77s2	\N	階段国道	https://image.anitabi.cn/user/1065/bangumi/215425/points/jfumy77s2-1729910929234.jpg?plan=h160	\N	4583	41.2596000	140.3450000	0101000020E6100000D7A3703D0A8B61405305A3923AA14440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.477625
1220	215425	rb6pm2cng	\N	上山路	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb6pm2cng-1735189831651.jpg?plan=h160	\N	4700	41.2591000	140.3446000	0101000020E6100000744694F6068B6140613255302AA14440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.570733
1221	215425	rb6quzqev	\N	竜飛崎	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb6quzqev-1735189906583.jpg?plan=h160	\N	4695	41.2580000	140.3428000	0101000020E610000034A2B437F88A61401B2FDD2406A14440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.656724
108	115908	7g2b3jgq	\N	久美子椅 小鹿乱跳	https://image.anitabi.cn/points/115908/7g2b3jgq.jpg?plan=h160	1	907	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:48.995694
1110	215425	rb1cvpjnb	\N	旧町立鎌掛小学校	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1cvpjnb-1735178192446.jpg?plan=h160	\N	52	34.9893000	136.2596000	0101000020E610000055C1A8A44E08614066F7E461A17E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:20.069639
1111	215425	rb1ek584q	\N	旧鎌掛小学校 教室	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1ek584q-1735178281135.jpg?plan=h160	\N	96	34.9886000	136.2598000	0101000020E610000007F0164850086140AD69DE718A7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:20.301036
931	1424		北京交通大学	北京交通大学	https://image.anitabi.cn/points/1424/s9cnrj5kf_1737867150212.jpg?plan=h160	20	1310	39.9505000	116.3360000	0101000020E61000002FDD240681155D408B6CE7FBA9F94340	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:09.85561
1112	215425	rb1l8m35x	\N	旧鎌掛小学校 职员室	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1l8m35x-1735178676742.jpg?plan=h160	\N	121	34.9886000	136.2601000	0101000020E610000011363CBD52086140AD69DE718A7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:20.607348
1113	215425	rb1mdlodb	\N	旧町立鎌掛小学校 运动场	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1mdlodb-1735178794514.jpg?plan=h160	\N	126	34.9888000	136.2597000	0101000020E6100000AED85F764F086140742497FF907E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:20.862503
1114	215425	rb1o0rssc	\N	旧鎌掛小学校 职员室走廊	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1o0rssc-1735178844033.jpg?plan=h160	\N	129	34.9886000	136.2601000	0101000020E610000011363CBD52086140AD69DE718A7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:21.069649
1115	215425	rb1qq9s9j	\N	旧鎌掛小学校 一楼楼梯口	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1qq9s9j-1735179021700.jpg?plan=h160	\N	355	34.9886000	136.2600000	0101000020E6100000B81E85EB51086140AD69DE718A7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:21.324199
1116	215425	rb1ru8f3w	\N	旧鎌掛小学校 楼梯	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1ru8f3w-1735179072247.jpg?plan=h160	\N	365	34.9886000	136.2601000	0101000020E610000011363CBD52086140AD69DE718A7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:21.635715
1117	215425	rb1sk0bth	\N	旧鎌掛小学校 二楼走廊	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1sk0bth-1735179121778.jpg?plan=h160	\N	370	34.9886000	136.2600000	0101000020E6100000B81E85EB51086140AD69DE718A7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:21.819714
1118	215425	npa0bzwh9	\N	旧鎌掛小学校 極東魔術昼寝結社の夏	https://image.anitabi.cn/user/1065/bangumi/215425/points/npa0bzwh9-1729832742208.jpg?plan=h160	\N	448	34.9885000	136.2600000	0101000020E6100000B81E85EB510861404A0C022B877E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:22.043544
1119	215425	j45oypm0i	\N	瀬田川新港	https://image.anitabi.cn/user/1065/bangumi/215425/points/j45oypm0i-1735179167147.jpg?plan=h160	\N	475	34.9790000	135.9053000	0101000020E610000034A2B437F8FC60405A643BDF4F7D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:22.348859
1120	215425	j45j0jwue	\N	瀬田川大橋西岸	https://image.anitabi.cn/user/1065/bangumi/215425/points/j45j0jwue-1735179181719.jpg?plan=h160	\N	483	34.9780000	135.9055000	0101000020E6100000E5D022DBF9FC604077BE9F1A2F7D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:22.566226
1121	215425	j45wwib5p	唐桥公园的散步道	唐橋公園の遊歩道	https://image.anitabi.cn/user/1065/bangumi/215425/points/j45wwib5p-1729832823062.jpg?plan=h160	\N	623	34.9777000	135.9081000	0101000020E6100000EC2FBB270FFD60404CA60A46257D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:22.758991
1122	215425	olavt84t9	\N	桃山南団地（动画原型公寓所在位置）	https://image.anitabi.cn/user/1065/bangumi/215425/points/olavt84t9-1729832840724.jpg?plan=h160	\N	629	34.9244000	135.7878000	0101000020E61000003E7958A835F9604011363CBD52764140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:23.010233
1123	215425	rb1z1imwl	\N	公寓 单元门口	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb1z1imwl-1735179509544.jpg?plan=h160	\N	636	34.9245000	135.7878000	0101000020E61000003E7958A835F960407593180456764140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:23.269442
1124	215425	j462adxm7	\N	六花勇太所居住的公寓（动画所在位置）	https://image.anitabi.cn/user/1065/bangumi/215425/points/j462adxm7-1729832899059.jpg?plan=h160	\N	966	34.9767000	135.9102000	0101000020E6100000371AC05B20FD604069006F81047D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:23.577083
1125	215425	rb5ntqu64	\N	桃山南団地（动画原型公寓所在位置	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb5ntqu64-1735187548590.jpg?plan=h160	\N	3937	34.9243000	135.7880000	0101000020E6100000F0A7C64B37F96040AED85F764F764140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:24.008006
1126	215425	j4693utv8	\N	京阪石山駅	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4693utv8-1729832928756.jpg?plan=h160	\N	972	34.9795000	135.8999000	0101000020E610000074B515FBCBFC60404C378941607D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:24.279999
1127	215425	rb21j6jua	\N	京阪石山駅 京阪石山坂本线入口	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb21j6jua-1735179659624.jpg?plan=h160	\N	978	34.9796000	135.8996000	0101000020E6100000696FF085C9FC6040AF946588637D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:24.540453
1128	215425	rb235nfjj	\N	京阪石山駅 京阪石山坂本线入口内	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb235nfjj-1735179758133.jpg?plan=h160	\N	982	34.9796000	135.8995000	0101000020E6100000105839B4C8FC6040AF946588637D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:24.805763
1129	215425	j46bxo004	\N	京阪石山駅の入り口	https://image.anitabi.cn/user/1065/bangumi/215425/points/j46bxo004-1729832959755.jpg?plan=h160	\N	985	34.9796000	135.8996000	0101000020E6100000696FF085C9FC6040AF946588637D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:24.993689
1130	215425	j46gmhf5y	\N	京阪石山駅　ホーム	https://image.anitabi.cn/user/1065/bangumi/215425/points/j46gmhf5y-1729832979498.jpg?plan=h160	\N	992	34.9796000	135.8993000	0101000020E61000005F29CB10C7FC6040AF946588637D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:25.165191
1131	215425	j46ijmoxk	\N	京阪石山駅　ホーム西側	https://image.anitabi.cn/user/1065/bangumi/215425/points/j46ijmoxk-1729833001329.jpg?plan=h160	\N	1008	34.9797000	135.8990000	0101000020E610000054E3A59BC4FC604013F241CF667D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:25.420506
1132	215425	j7kem0ywb	伏见稻荷神社 楼门前	伏見稲荷神社 楼門の前	https://image.anitabi.cn/user/1065/bangumi/215425/points/j7kem0ywb-1729833028084.jpg?plan=h160	\N	1018	34.9671000	135.7723000	0101000020E61000006D567DAEB6F8604016FBCBEEC97B4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:25.727462
1133	215425	j7yx11wqk	重轻石	おもかる石	https://image.anitabi.cn/user/1065/bangumi/215425/points/j7yx11wqk-1729833055821.jpg?plan=h160	\N	1025	34.9664000	135.7756000	0101000020E6100000E25817B7D1F860405D6DC5FEB27B4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:26.034803
1134	215425	j7zq7dmar	千本鸟居	千本鳥居	https://image.anitabi.cn/user/1065/bangumi/215425/points/j7zq7dmar-1712370699673.jpg?plan=h160	\N	1029	34.9670000	135.7745000	0101000020E6100000105839B4C8F86040B29DEFA7C67B4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:26.208838
142	115908	k97znz3w	\N	京阪宇治	https://image.anitabi.cn/points/115908/k97znz3w_1673372490534.jpg?plan=h160	12	1283	34.8939000	135.8069000	0101000020E61000008FE4F21FD2F960407CF2B0506B724140	Anitabi@itorr	https://anitabi.cn/	2026-05-03 22:36:21.724895
901	246429	tzyo4u	东京国际邮轮码头	东京国际邮轮码头	https://image.anitabi.cn/user/0/bangumi/246429/points/tzyo4u-1748824344851.jpg?plan=h160	4	638	35.6167000	139.7713000	0101000020E6100000F46C567DAE786140BBB88D06F0CE4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.30998
899	246429	spb6dk	南藏院·门口	南藏院·门口	https://image.anitabi.cn/user/0/bangumi/246429/points/spb6dk-1748745925009.jpg?plan=h160	4	400	35.7147000	139.7145000	0101000020E6100000BE9F1A2FDD766140C139234A7BDB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.153269
886	246429	rehkdp	駒塚橋	駒塚橋	https://image.anitabi.cn/user/0/bangumi/246429/points/rehkdp-1748667278724.jpg?plan=h160	1	496	35.7119000	139.7232000	0101000020E6100000F38E537424776140DE02098A1FDB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.25771
890	246429	ribs14	都电荒川线·早稻田	都电荒川线·早稻田	https://image.anitabi.cn/user/0/bangumi/246429/points/ribs14-1748673777503.jpg?plan=h160	2	712	35.7117000	139.7192000	0101000020E610000010E9B7AF03776140174850FC18DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.528286
896	246429	s0kddu	金泉汤（旭汤原型）	金泉汤（旭汤原型）	https://image.anitabi.cn/user/0/bangumi/246429/points/s0kddu-1748704534409.jpg?plan=h160	3	552	35.7100000	139.7125000	0101000020E6100000CDCCCCCCCC7661407B14AE47E1DA4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.93347
908	246429	umk0bm0fd	sound studio noah三轩茶屋店	サウンドスタジオノア三軒茶屋店	https://image.anitabi.cn/points/186515/acc3efa4_1722414024541.jpg?plan=h160	5	572	35.6402000	139.6748000	0101000020E6100000E86A2BF6977561401973D712F2D14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.640297%2C139.67481&z=17	2026-05-24 11:02:55.798022
887	246429	umk0bm03i	胸突坂-石凳	胸突坂-石凳	https://image.anitabi.cn/user/0/bangumi/186515/points/n6sh10psj-1723561072037.jpg?plan=h160	1	498	35.7127000	139.7236000	0101000020E610000057EC2FBB27776140FAEDEBC039DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.323521
1100	328609	50slhscl0	\N	御茶之水	https://image.anitabi.cn/points/328609/50slhscl0_1672311116677.jpg?plan=h160	12	903	35.6997000	139.7644000	0101000020E6100000FF21FDF6757861406F8104C58FD94140	林宏	\N	2026-05-31 22:40:32.074875
909	246429	u6t9hl	鶴巻南公園·滑梯	鶴巻南公園·滑梯	https://image.anitabi.cn/user/0/bangumi/246429/points/u6t9hl-1748835843119.jpg?plan=h160	6	767	35.7061000	139.7242000	0101000020E61000006C787AA52C77614051DA1B7C61DA4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.892622
895	246429	s08ghd	江户川公园·滑梯旁	江户川公园·滑梯旁	https://image.anitabi.cn/user/0/bangumi/246429/points/s08ghd-1748703810690.jpg?plan=h160	3	510	35.7105000	139.7264000	0101000020E6100000107A36AB3E7761406DE7FBA9F1DA4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.86779
910	246429	u740vm	ストレージプラス文京関口	ストレージプラス文京関口	https://image.anitabi.cn/user/0/bangumi/246429/points/u740vm-1748836285760.jpg?plan=h160	6	918	35.7086000	139.7327000	0101000020E6100000EF3845477277614009F9A067B3DA4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.957525
177	115908	7ny6cwr8	\N	电车内 感觉不能离开它	https://image.anitabi.cn/points/115908/7ny6cwr8.jpg?plan=h160	6	1243	34.9135000	135.8031000	0101000020E61000005D6DC5FEB2F96040B0726891ED744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:52.508931
892	246429	umk0blzdz	忠犬八公像	忠犬ハチ公像（渋谷区）	https://image.anitabi.cn/points/186515/f2a228ef_1722413992934.jpg?plan=h160	2	818	35.6590000	139.7005000	0101000020E610000023DBF97E6A7661403108AC1C5AD44140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.659056%2C139.700581&z=17	2026-05-24 11:02:54.662248
902	246429	umk0blzp3	三轩茶屋站 世田谷通入口	三軒茶屋駅 世田谷通り口	https://image.anitabi.cn/points/186515/e6b78c18_1722414022709.jpg?plan=h160	5	326	35.6436000	139.6713000	0101000020E6100000C139234A7B75614051DA1B7C61D24140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.64364%2C139.671327&z=17	2026-05-24 11:02:55.377728
889	246429	ri5cea	駒塚橋·南十字路口	駒塚橋·南十字路口	https://image.anitabi.cn/user/0/bangumi/246429/points/ri5cea-1748673431816.jpg?plan=h160	2	657	35.7116000	139.7231000	0101000020E61000009A779CA223776140B3EA73B515DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.462858
897	246429	s0ypyn	永青文库（流星堂原型）	永青文库（流星堂原型）	https://image.anitabi.cn/user/0/bangumi/246429/points/s0ypyn-1748705026208.jpg?plan=h160	3	703	35.7129000	139.7237000	0101000020E6100000B003E78C28776140C1A8A44E40DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.002986
904	246429	u0pvwv	BIG ECHO	BIG ECHO	https://image.anitabi.cn/user/0/bangumi/246429/points/u0pvwv-1748825549925.jpg?plan=h160	5	355	35.6434000	139.6707000	0101000020E6100000ACADD85F767561408A1F63EE5AD24140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.527981
903	246429	umk0bm0rc	sound studio noad 驹泽店	サウンドスタジオノア駒沢店	https://image.anitabi.cn/points/186515/182c5348_1722414026093.jpg?plan=h160	5	354	35.6345000	139.6628000	0101000020E61000003E7958A835756140F0A7C64B37D14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.63452%2C139.662889&z=17	2026-05-24 11:02:55.452088
905	246429	al30e5	面影橋  北岸西小道	面影橋	https://image.anitabi.cn/user/0/bangumi/246429/points/al30e5-1747650459638.jpg?plan=h160	5	542	35.7134000	139.7140000	0101000020E6100000022B8716D9766140B37BF2B050DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.598164
611	152091	kq8xhc0zi	\N	アクトパル宇治 宿泊棟（未确定）	https://image.anitabi.cn/points/152091/kq8xhc0zi_1716622341338.jpg?plan=h160	2	1226	34.9345000	135.8550000	0101000020E61000008FC2F5285CFB6040560E2DB29D774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:26.330366
907	246429	umk0bm09j	丰桥	豊橋	https://image.anitabi.cn/points/186515/d0789b31_1722414056837.jpg?plan=h160	5	567	35.7132000	139.7142000	0101000020E6100000B459F5B9DA766140ECC039234ADB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.713295%2C139.714288&z=17	2026-05-24 11:02:55.733167
906	246429	al7qb5	面影橋	面影橋	https://image.anitabi.cn/user/0/bangumi/246429/points/al7qb5-1747650775793.jpg?plan=h160	5	564	35.7133000	139.7142000	0101000020E6100000B459F5B9DA7661404F1E166A4DDB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.665902
893	246429	rvki3z	永青文库（流星堂）门口	永青文库（流星堂）门口	https://image.anitabi.cn/user/0/bangumi/246429/points/rvki3z-1748695967102.jpg?plan=h160	3	178	35.7128000	139.7236000	0101000020E610000057EC2FBB277761405E4BC8073DDB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.730375
532	152091	kq6q8y88o	\N	宇治公园附近 黄昏 夏	https://image.anitabi.cn/points/152091/kq6q8y88o_1716617550555.jpg?plan=h160	1	1935	34.8880000	135.8088000	0101000020E610000027A089B0E1F960408B6CE7FBA9714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:28.78116
660	152091	u5y0rmib3	\N	白虹橋	https://image.anitabi.cn/points/152091/u5y0rmib3_1743242429357.jpg?plan=h160	11	\N	34.8824000	135.8240000	0101000020E6100000EE7C3F355EFA6040C5FEB27BF2704140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:58.583119
178	115908	qys7i0	\N	京阪黄檗站	https://image.anitabi.cn/points/115908/qys7i0.jpg?plan=h160	5	603	34.9143000	135.8026000	0101000020E6100000A1F831E6AEF96040CC5D4BC807754140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.91437%2C135.802678&z=17	2026-05-03 22:36:53.045625
1102	328609	50slhsci5	\N	明大通り	https://image.anitabi.cn/points/328609/50slhsci5_1672311117671.jpg?plan=h160	12	905	35.6991000	139.7630000	0101000020E610000023DBF97E6A7861401A51DA1B7CD94140	林宏	\N	2026-05-31 22:40:32.553893
1222	215425	rb6vkyo8q	\N	竜泊ライン	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb6vkyo8q-1735190186181.jpg?plan=h160	\N	4735	41.2578000	140.3447000	0101000020E6100000CC5D4BC8078B614054742497FFA04440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.745078
1135	215425	j7zloqk7t	四ツ辻展望点	四ツ辻展望スポット	https://image.anitabi.cn/user/1065/bangumi/215425/points/j7zloqk7t-1729833185034.jpg?plan=h160	\N	1030	34.9691000	135.7813000	0101000020E6100000AC8BDB6800F96040DC4603780B7C4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:26.546835
900	246429	spex5l	宿坂通り	宿坂通り	https://image.anitabi.cn/user/0/bangumi/246429/points/spex5l-1748746094936.jpg?plan=h160	4	405	35.7149000	139.7147000	0101000020E610000070CE88D2DE76614088F4DBD781DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.227627
1136	215425	jbf1q7pkr	\N	宇治橋	https://image.anitabi.cn/user/1065/bangumi/215425/points/jbf1q7pkr-1729833219812.jpg?plan=h160	\N	1031	34.8923000	135.8057000	0101000020E610000064CC5D4BC8F96040431CEBE236724140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:26.842187
928	246429	unqzox	飞鸟山公园·儿童城堡	飞鸟山公园·儿童城堡	https://image.anitabi.cn/user/0/bangumi/246429/points/unqzox-1748864235772.jpg?plan=h160	11	688	35.7502000	139.7386000	0101000020E61000006B9A779CA2776140C7BAB88D06E04140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:57.242208
1137	215425	k54wv0a7e	\N	久美子椅	https://image.anitabi.cn/user/1065/bangumi/215425/points/k54wv0a7e-1729833240614.jpg?plan=h160	\N	1034	34.8896000	135.8083000	0101000020E61000006B2BF697DDF96040C442AD69DE714140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:27.058589
913	246429	rj91voc7a	大塚站北口	大塚駅北口	https://image.anitabi.cn/user/0/bangumi/246429/points/rj91voc7a-1735821841455.jpg?plan=h160	7	1044	35.7316000	139.7290000	0101000020E610000017D9CEF75377614076E09C11A5DD4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.177918
1138	215425	nydp7xij6	\N	东福寺	https://image.anitabi.cn/user/1065/bangumi/215425/points/nydp7xij6-1729833284210.jpg?plan=h160	\N	1035	34.9765000	135.7734000	0101000020E61000003F575BB1BFF86040A245B6F3FD7C4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:27.252241
911	246429	umk0bm00a	旬八果菜店五反田店	旬八青果店 五反田店（トライアル店舗）	https://image.anitabi.cn/points/186515/8546c476_1722413929613.jpg?plan=h160	6	942	35.6247000	139.7196000	0101000020E6100000744694F606776140D5E76A2BF6CF4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.62476%2C139.719654&z=17	2026-05-24 11:02:56.026994
1139	215425	rb2g3tnkc	\N	东福寺 本堂前	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb2g3tnkc-1735180583069.jpg?plan=h160	\N	1036	34.9761000	135.7737000	0101000020E6100000499D8026C2F8604014D044D8F07C4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:27.535697
915	246429	u8c81e	大塚架道桥	大塚架道桥	https://image.anitabi.cn/user/0/bangumi/246429/points/u8c81e-1748838389528.jpg?plan=h160	7	1193	35.7314000	139.7293000	0101000020E6100000211FF46C56776140AF25E4839EDD4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.311783
1140	215425	j4tazmso3	\N	出町柳商店街	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4tazmso3-1729833374738.jpg?plan=h160	\N	1061	35.0302000	135.7692000	0101000020E6100000AA8251499DF860406B2BF697DD834140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:27.980554
1141	215425	j4t8nj883	\N	出町柳商店街(玉子市场中玉子家位置)	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4t8nj883-1729833340611.jpg?plan=h160	\N	1054	35.0300000	135.7691000	0101000020E6100000516B9A779CF86040A4703D0AD7834140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:28.263025
922	246429	umk0bm0wr	富士见坡	富士見坂上	https://image.anitabi.cn/points/186515/5360f912_1722414050058.jpg?plan=h160	9	1091	35.7165000	139.7176000	0101000020E610000082734694F6766140C1CAA145B6DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.716506%2C139.717634&z=17	2026-05-24 11:02:56.787951
1142	215425	j46xe33kx	京都塔	京都タワー 	https://image.anitabi.cn/user/1065/bangumi/215425/points/j46xe33kx-1729833682382.jpg?plan=h160	\N	1183	34.9862000	135.7583000	0101000020E6100000D1915CFE43F8604058A835CD3B7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:28.59595
912	246429	umk0bm0vb	大塚站	大塚駅	https://image.anitabi.cn/points/186515/49ceff45_1722418419375.jpg?plan=h160	7	620	35.7316000	139.7294000	0101000020E61000007A36AB3E5777614076E09C11A5DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.731686%2C139.729468&z=17	2026-05-24 11:02:56.113469
1143	215425	rb2xqj130	\N	京都塔 出口楼梯	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb2xqj130-1735181607646.jpg?plan=h160	\N	1413	34.9875000	135.7592000	0101000020E6100000F163CC5D4BF8604066666666667E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:28.847732
916	246429	u8gagl	大塚架道桥·北口	大塚架道桥·北口	https://image.anitabi.cn/user/0/bangumi/246429/points/u8gagl-1748838539371.jpg?plan=h160	7	1200	35.7314000	139.7295000	0101000020E6100000D34D621058776140AF25E4839EDD4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.379051
1144	215425	rb34lpptb	\N	京都塔 下层回廊	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb34lpptb-1735182032348.jpg?plan=h160	\N	1432	34.9875000	135.7592000	0101000020E6100000F163CC5D4BF8604066666666667E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:29.108193
917	246429	u8m0fm	豊島区立·南大塚公園	豊島区立·南大塚公園	https://image.anitabi.cn/user/0/bangumi/246429/points/u8m0fm-1748838965682.jpg?plan=h160	7	1224	35.7277000	139.7310000	0101000020E610000008AC1C5A647761404CA60A4625DD4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.452955
1145	215425	rb364vha9	\N	京都塔 出口电梯	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb364vha9-1735182127094.jpg?plan=h160	\N	1436	34.9875000	135.7593000	0101000020E61000004A7B832F4CF8604066666666667E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:29.230835
927	246429	unnutq	飞鸟山公园·儿童滑梯	飞鸟山公园·儿童滑梯	https://image.anitabi.cn/user/0/bangumi/246429/points/unnutq-1748864091497.jpg?plan=h160	11	683	35.7504000	139.7388000	0101000020E61000001DC9E53FA47761408E75711B0DE04140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:57.172608
894	246429	rzpguo	地藏通商店街·东口	地藏通商店街·东口	https://image.anitabi.cn/user/0/bangumi/246429/points/rzpguo-1748702966855.jpg?plan=h160	3	437	35.7080000	139.7340000	0101000020E6100000736891ED7C776140B4C876BE9FDA4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.802768
206	115908	7oiargz2	\N	みんな​のき​木幡​こども園	https://image.anitabi.cn/points/115908/7oiargz2.jpg?plan=h160	7	1126	34.9224000	135.7959000	0101000020E61000005DDC460378F960404BEA043411764140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:19.882796
209	115908	7neg9gax	\N	観流橋東	https://image.anitabi.cn/points/115908/7neg9gax.jpg?plan=h160	6	719	34.8904000	135.8098000	0101000020E6100000A089B0E1E9F96040E02D90A0F8714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:21.725705
1223	215425	mnwbivb1u	\N	苫小牧港	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnwbivb1u-1729910959800.jpg?plan=h160	\N	4799	42.6335000	141.6284000	0101000020E6100000CE1951DA1BB461400C022B8716514540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:45.830075
1146	215425	rb37elgn3	\N	京都塔 一楼电梯	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb37elgn3-1735182228901.jpg?plan=h160	\N	1440	34.9874000	135.7594000	0101000020E6100000A3923A014DF8604003098A1F637E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:29.51638
1147	215425	j47gy5r25	\N	大文字山	https://image.anitabi.cn/user/1065/bangumi/215425/points/j47gy5r25-1729833722708.jpg?plan=h160	\N	1210	35.0196000	135.8114000	0101000020E61000002EFF21FDF6F960403480B74082824140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:29.720881
1148	215425	rb39e5mga	\N	京都站 站前广场	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb39e5mga-1735182323752.jpg?plan=h160	\N	1446	34.9864000	135.7590000	0101000020E61000003F355EBA49F860402063EE5A427E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:30.028134
1149	215425	j4y0ai1nn	\N	京都駅	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4y0ai1nn-1729833775731.jpg?plan=h160	\N	1447	34.9862000	135.7590000	0101000020E61000003F355EBA49F8604058A835CD3B7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:30.240778
1150	215425	j4y36pk3p	\N	京都駅構内	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4y36pk3p-1729833814656.jpg?plan=h160	\N	1448	34.9860000	135.7588000	0101000020E61000008E06F01648F8604091ED7C3F357E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:30.422038
1151	215425	olas1a7bh	\N	京都站	https://image.anitabi.cn/user/1065/bangumi/215425/points/olas1a7bh-1729833885331.jpg?plan=h160	\N	1449	34.9857000	135.7588000	0101000020E61000008E06F01648F8604067D5E76A2B7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:30.746419
1152	215425	j4y4sy25l	\N	京都駅荷物預かり	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4y4sy25l-1729833904550.jpg?plan=h160	\N	1463	34.9859000	135.7590000	0101000020E61000003F355EBA49F860402E90A0F8317E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:30.958083
1153	215425	j4ydn6nhl	\N	京都駅ホーム	https://image.anitabi.cn/user/1065/bangumi/215425/points/j4ydn6nhl-1729834014227.jpg?plan=h160	\N	1467	34.9852000	135.7583000	0101000020E6100000D1915CFE43F8604075029A081B7E4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:31.21419
82	115908	kq1gc0kdk	\N	莵道高 四楼 网球场方向窗户	https://image.anitabi.cn/points/115908/kq1gc0kdk_1716606088116.jpg?plan=h160	12	115	34.9099000	135.8157000	0101000020E61000001CEBE2361AFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:25.920736
1154	215425	jabmwqrui	\N	旧サイゼリヤ北夙川店（旧址）	https://image.anitabi.cn/user/1065/bangumi/215425/points/jabmwqrui-1729834054227.jpg?plan=h160	\N	1549	34.7541000	135.3301000	0101000020E61000001B0DE02D90EA6040F1F44A5986604140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:31.4138
107	115908	7g0g4ww9	\N	久美子椅 头发特写	https://image.anitabi.cn/points/115908/7g0g4ww9.jpg?plan=h160	1	889	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:48.074296
117	115908	7h2bwofw	\N	久美子椅 全景 黄昏 久美子酱？	https://image.anitabi.cn/points/115908/7h2bwofw.jpg?plan=h160	2	1144	34.8897000	135.8082000	0101000020E610000012143FC6DCF9604027A089B0E1714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:58.681671
1155	215425	jaa97m231	\N	西御坊駅の近く	https://image.anitabi.cn/user/1065/bangumi/215425/points/jaa97m231-1729834094560.jpg?plan=h160	\N	1864	33.8865000	135.1530000	0101000020E610000037894160E5E46040B6F3FDD478F14040	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:31.596064
141	115908	qys7iw	\N	府道７号線ガスト前	https://image.anitabi.cn/points/115908/qys7iw.jpg?plan=h160	1	1191	34.8949000	135.8082000	0101000020E610000012143FC6DCF960405F984C158C724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.894912%2C135.808225&z=17	2026-05-03 22:36:20.709686
155	115908	qys7k0	\N	六地蔵駅付近鉄塔	https://image.anitabi.cn/points/115908/qys7k0.jpg?plan=h160	1	266	34.9315000	135.7941000	0101000020E61000001D38674469F96040AC1C5A643B774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.931533%2C135.794181&z=17	2026-05-03 22:36:32.474239
176	115908	7gzz1850	\N	电车内 是因为高坂同学那件事	https://image.anitabi.cn/points/115908/7gzz1850.jpg?plan=h160	2	1115	34.9318000	135.7936000	0101000020E610000061C3D32B65F96040D734EF3845774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:51.273372
189	115908	qys7k2	\N	さわらびの道（宇治上神社前）	https://image.anitabi.cn/user/0/bangumi/115908/points/qys7k2-1697124629986.jpg?plan=h160	8	808	34.8916000	135.8110000	0101000020E6100000CBA145B6F3F960408A8EE4F21F724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.891642%2C135.811012&z=17	2026-05-03 22:37:05.892816
1156	215425	jaahy9tq7	\N	尾上橋	https://image.anitabi.cn/user/1065/bangumi/215425/points/jaahy9tq7-1729834171450.jpg?plan=h160	\N	1885	33.8899000	135.1484000	0101000020E61000003F575BB1BFE46040EE5A423EE8F14040	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:31.871717
1157	215425	jaaz486dm	动漫中酒店所在的地方（酒店原型在东京）））	アニメでホテルのある場所	https://image.anitabi.cn/user/1065/bangumi/215425/points/jaaz486dm-1729834303875.jpg?plan=h160	\N	1903	33.8898000	135.1489000	0101000020E6100000FBCBEEC9C3E460408BFD65F7E4F14040	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:32.178304
1158	215425	mnx1mb6c3	\N	ホテル​シャンティ​赤坂	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnx1mb6c3-1729834319170.jpg?plan=h160	\N	1903	35.6710000	139.7377000	0101000020E61000004BC8073D9B776140D9CEF753E3D54140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:32.384423
1159	215425	jab4p7r4l	\N	煙樹海岸	https://image.anitabi.cn/user/1065/bangumi/215425/points/jab4p7r4l-1729834138114.jpg?plan=h160	\N	2526	33.8922000	135.1218000	0101000020E6100000E4141DC9E5E36040E0BE0E9C33F24040	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:32.690331
1160	215425	jabsa1vjw	\N	西宮北口駅前のにしきた公園	https://image.anitabi.cn/user/1065/bangumi/215425/points/jabsa1vjw-1729908561065.jpg?plan=h160	\N	2067	34.7465000	135.3561000	0101000020E610000061C3D32B65EB6040643BDF4F8D5F4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:32.998044
1161	215425	jabcsqawe	\N	和歌山駅前の高速バス乗り場	https://image.anitabi.cn/user/1065/bangumi/215425/points/jabcsqawe-1729908588337.jpg?plan=h160	\N	2075	34.2325000	135.1927000	0101000020E61000000EBE30992AE66040F6285C8FC21D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:33.313115
1162	215425	jabgpbcje	和歌山 Urban酒店	和歌山​アーバン​ホテル	https://image.anitabi.cn/user/1065/bangumi/215425/points/jabgpbcje-1712552957486.jpg?plan=h160	\N	2920	34.2328000	135.1936000	0101000020E61000002E90A0F831E660402041F163CC1D4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:33.612473
1163	215425	jep9szevb	\N	新宿高速巴士总站	https://image.anitabi.cn/user/1065/bangumi/215425/points/jep9szevb-1729908622836.jpg?plan=h160	\N	2258	35.6888000	139.7010000	0101000020E6100000DF4F8D976E7661400EBE30992AD84140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:33.919394
1164	215425	noed6r0re	\N	厳冬の新宿西口：ヨドバシカメラ本店と新宿高速バスターミナル	https://image.anitabi.cn/user/1065/bangumi/215425/points/noed6r0re-1729908654248.jpg?plan=h160	\N	2259	35.6898000	139.6980000	0101000020E61000007593180456766140F163CC5D4BD84140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:34.229184
1165	215425	j5sm606xx	六本木新城（展望台）	六本木ヒルズ（展望台）	https://image.anitabi.cn/user/1065/bangumi/215425/points/j5sm606xx-1729908743370.jpg?plan=h160	\N	2264	35.6604000	139.7291000	0101000020E61000006FF085C954776140A323B9FC87D44140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:34.445036
1166	215425	nof86db9c	\N	東京都庁第一本庁舎 南展望室（剧场版背景拍照位置）	https://image.anitabi.cn/user/1065/bangumi/215425/points/nof86db9c-1729908781441.jpg?plan=h160	\N	2293	35.6891000	139.6918000	0101000020E6100000EEEBC0392376614039D6C56D34D84140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:34.63693
1167	215425	jepmqwda6	\N	原宿竹下通	https://image.anitabi.cn/user/1065/bangumi/215425/points/jepmqwda6-1729908806423.jpg?plan=h160	\N	2295	35.6715000	139.7030000	0101000020E6100000D122DBF97E766140CBA145B6F3D54140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:34.840659
1168	215425	jepreew7c	\N	北参道入口	https://image.anitabi.cn/user/1065/bangumi/215425/points/jepreew7c-1729908835757.jpg?plan=h160	\N	2297	35.6801000	139.7031000	0101000020E61000002A3A92CB7F7661403B014D840DD74140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:35.150205
1169	215425	j5th2j93h	中野商店街	中野サンモール商店街	https://image.anitabi.cn/user/1065/bangumi/215425/points/j5th2j93h-1729908926907.jpg?plan=h160	\N	2304	35.7065000	139.6657000	0101000020E61000004F1E166A4D756140DF4F8D976EDA4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:35.46515
1170	215425	o1g6l5soh	\N	桜田通り	https://image.anitabi.cn/user/1065/bangumi/215425/points/o1g6l5soh-1729908868369.jpg?plan=h160	\N	2306	35.6614000	139.7437000	0101000020E61000002041F163CC77614086C954C1A8D44140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:35.76278
1171	215425	jeq1a7v24	\N	外苑東通り	https://image.anitabi.cn/user/1065/bangumi/215425/points/jeq1a7v24-1729908883286.jpg?plan=h160	\N	2306	35.6596000	139.7428000	0101000020E6100000006F8104C57761408638D6C56DD44140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:36.069894
1172	215425	j5t2dpvem	东京塔北塔底	東京タワー	https://image.anitabi.cn/user/1065/bangumi/215425/points/j5t2dpvem-1729908908274.jpg?plan=h160	\N	2312	35.6590000	139.7452000	0101000020E6100000569FABADD87761403108AC1C5AD44140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:36.377272
1173	215425	mmc8mxg9j	\N	第2佐藤ビル	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmc8mxg9j-1729908952881.jpg?plan=h160	\N	2313	35.7002000	139.7720000	0101000020E610000062105839B478614061545227A0D94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:36.630989
1174	215425	jf4uje0u9	\N	秋葉原	https://image.anitabi.cn/user/1065/bangumi/215425/points/jf4uje0u9-1729908970241.jpg?plan=h160	\N	2315	35.7000000	139.7712000	0101000020E61000009B559FABAD7861409A99999999D94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:36.888101
1175	215425	nodspvx6o	\N	PREMIUM STAGE ダイレクト リアル店	https://image.anitabi.cn/1065/2024-08/496769291b18d08c4f3ca0589a5e905e.jpeg?plan=h160	\N	2326	35.7014000	139.7706000	0101000020E610000086C954C1A87861400BB5A679C7D94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:37.195763
1176	215425	moubmaj4i	\N	武器商店	https://image.anitabi.cn/user/1065/bangumi/215425/points/moubmaj4i-1729909037642.jpg?plan=h160	\N	2336	35.7016000	139.7714000	0101000020E61000004D840D4FAF786140D26F5F07CED94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:37.401632
1177	215425	mmc6oisis	\N	秋叶原小路	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmc6oisis-1729909005464.jpg?plan=h160	\N	2357	35.7003000	139.7708000	0101000020E610000038F8C264AA786140C4B12E6EA3D94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:37.708967
1178	215425	mmc6263ws	\N	ファミリー​マート\n外神田​三丁目​東​店	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmc6263ws-1729909087473.jpg?plan=h160	\N	2357	35.7011000	139.7710000	0101000020E6100000E9263108AC786140E09C11A5BDD94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:37.912686
1179	215425	pfstb4whk	\N	堂·吉柯德 秋叶原店	https://image.anitabi.cn/user/1065/bangumi/215425/points/pfstb4whk-1729909170662.jpg?plan=h160	\N	2361	35.7009000	139.7717000	0101000020E610000058CA32C4B178614019E25817B7D94140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:38.188179
1180	215425	m6kjvb90u	千代田区立练成公园	千代田区立れんなり公園	https://image.anitabi.cn/user/1065/bangumi/215425/points/m6kjvb90u-1729909230625.jpg?plan=h160	\N	2391	35.7038000	139.7707000	0101000020E6100000DFE00B93A978614060764F1E16DA4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:38.355366
1181	215425	mmbzkr5dt	\N	电影院旁的小路	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmbzkr5dt-1729909261304.jpg?plan=h160	\N	2607	35.6926000	139.7030000	0101000020E6100000D122DBF97E766140D49AE61DA7D84140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:38.586646
1182	215425	mmby2kqiv	\N	新宿ピカデリー	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmby2kqiv-1729909283631.jpg?plan=h160	\N	2625	35.6926000	139.7036000	0101000020E6100000E6AE25E483766140D49AE61DA7D84140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:38.834314
1183	215425	rb4nvyda1	\N	呉阪急ホテル	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb4nvyda1-1735185378597.jpg?plan=h160	\N	2660	34.2447000	132.5589000	0101000020E610000080B74082E291604065AA6054521F4140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:39.244368
1184	215425	j5ghfzzhj	\N	東京羽田空港	https://image.anitabi.cn/user/1065/bangumi/215425/points/j5ghfzzhj-1729909344394.jpg?plan=h160	\N	2953	35.5506000	139.7885000	0101000020E6100000AC1C5A643B796140BC96900F7AC64140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:39.503371
1185	215425	rb50bhrc6	\N	東京羽田空港 展望台入口通道	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb50bhrc6-1735186117729.jpg?plan=h160	\N	3146	35.5523000	139.7880000	0101000020E6100000F0A7C64B3779614058CA32C4B1C64140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:39.85786
1186	215425	mmmlw7759	\N	東京羽田空港 展望台	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmmlw7759-1729909469321.jpg?plan=h160	\N	3196	35.5524000	139.7879000	0101000020E610000097900F7A36796140BB270F0BB5C64140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:40.165061
1187	215425	mmmgbu7ms	\N	元祖寿司	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmmgbu7ms-1729909501397.jpg?plan=h160	\N	3504	35.5502000	139.7891000	0101000020E6100000C1A8A44E407961402D211FF46CC64140	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:40.47304
1188	215425	rb5320n4y	\N	札幌大通公园	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb5320n4y-1735186281003.jpg?plan=h160	\N	3255	43.0606000	141.3527000	0101000020E610000093A9825149AB61409D11A5BDC1874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:40.599857
1189	215425	j8kgqt2mo	\N	札幌大通公园夜景	https://image.anitabi.cn/user/1065/bangumi/215425/points/j8kgqt2mo-1729909617543.jpg?plan=h160	\N	3742	43.0606000	141.3527000	0101000020E610000093A9825149AB61409D11A5BDC1874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:40.883617
1190	215425	mnwk8dzxt	\N	大通4丁目北	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnwk8dzxt-1722080917408.jpg?plan=h160	\N	3263	43.0608000	141.3519000	0101000020E6100000CCEEC9C342AB614064CC5D4BC8874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:41.189621
1191	215425	jeqxz388w	\N	札幌市時計台	https://image.anitabi.cn/user/1065/bangumi/215425/points/jeqxz388w-1729909650774.jpg?plan=h160	\N	3266	43.0623000	141.3533000	0101000020E6100000A835CD3B4EAB614039454772F9874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:41.384217
1224	215425	mmbtnn990	\N	Monastero Santa Rosa Hotel & Spa	https://image.anitabi.cn/user/1065/bangumi/215425/points/mmbtnn990-1729910990833.jpg?plan=h160	\N	5096	40.6207000	14.5771000	0101000020E61000000F0BB5A679272D404850FC18734F4440	Anitabi	https://anitabi.cn/	2026-05-31 23:04:45.915141
1192	215425	j5qa6dkg8	\N	札幌駅南口駅前広場	https://image.anitabi.cn/user/1065/bangumi/215425/points/j5qa6dkg8-1729909677274.jpg?plan=h160	\N	3274	43.0670000	141.3504000	0101000020E610000097900F7A36AB61407F6ABC7493884540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:41.705127
1225	215425	mnvu05rhg	\N	Vine Beach 	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnvu05rhg-1729911010681.jpg?plan=h160	\N	5098	40.6186000	14.5774000	0101000020E6100000BA6B09F9A0272D401EA7E8482E4F4440	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:46.007143
590	152091	kq6xzysxl	\N	大吉山展望台 远眺宇治 黄昏	https://image.anitabi.cn/points/152091/kq6xzysxl_1716618019142.jpg?plan=h160	1	2393	34.8924000	135.8123000	0101000020E61000004ED1915CFEF96040A779C7293A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:12.81075
1193	215425	j8134svgq	札幌站南口站前广场的警告牌	札幌駅南口駅前広場の警告札	https://image.anitabi.cn/user/1065/bangumi/215425/points/j8134svgq-1729910064817.jpg?plan=h160	\N	3479	43.0669000	141.3504000	0101000020E610000097900F7A36AB61401B0DE02D90884540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:41.970426
1194	215425	j8khvl40z	\N	札幌駅南口駅前広場夜景	https://image.anitabi.cn/user/1065/bangumi/215425/points/j8khvl40z-1729909852969.jpg?plan=h160	\N	3748	43.0673000	141.3504000	0101000020E610000097900F7A36AB6140AA8251499D884540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:42.268971
1430	186515	b419f513	\N	早稲田大学インキュベーションセンター付近	https://image.anitabi.cn/points/186515/b419f513_1722414030082.jpg?plan=h160	11	757	35.7121000	139.7173000	0101000020E6100000772D211FF4766140A5BDC11726DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.712181%2C139.717383&z=17	2026-06-09 19:30:15.360546
1195	215425	j80zcznka	求婚地（误）	札幌駅南口駅前広場	https://image.anitabi.cn/user/1065/bangumi/215425/points/j80zcznka-1729909989736.jpg?plan=h160	\N	3464	43.0669000	141.3504000	0101000020E610000097900F7A36AB61401B0DE02D90884540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:42.404962
1196	215425	mnwwrey5m	\N	札幌駅	https://image.anitabi.cn/user/1065/bangumi/215425/points/mnwwrey5m-1722081675122.jpg?plan=h160	\N	3900	43.0686000	141.3508000	0101000020E6100000FAEDEBC039AB6140B84082E2C7884540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:42.521161
1197	215425	j81mb071r	狸小路商店街	狸小路商店街	https://image.anitabi.cn/user/1065/bangumi/215425/points/j81mb071r-1729910096240.jpg?plan=h160	\N	3544	43.0572000	141.3530000	0101000020E61000009EEFA7C64BAB614065AA605452874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:42.828813
1441	186515	d0789b31	\N	豊橋	https://image.anitabi.cn/points/186515/d0789b31_1722414056837.jpg?plan=h160	5	564	35.7124000	139.7194000	0101000020E6100000C217265305776140D0D556EC2FDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.712474%2C139.719453&z=17	2026-06-09 19:30:21.394473
1198	215425	rb5cy5cba	\N	路面电车（内景）	https://image.anitabi.cn/user/1065/bangumi/215425/points/rb5cy5cba-1735186877149.jpg?plan=h160	\N	3549	43.0572000	141.3529000	0101000020E610000045D8F0F44AAB614065AA605452874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:43.136763
1199	215425	j987cij7o	\N	菊水旭山公園通	https://image.anitabi.cn/user/1065/bangumi/215425/points/j987cij7o-1729910205289.jpg?plan=h160	\N	3567	43.0486000	141.3537000	0101000020E61000000C93A98251AB6140F54A598638864540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:43.325436
1200	215425	j821gta8t	南大桥	南大橋	https://image.anitabi.cn/user/1065/bangumi/215425/points/j821gta8t-1729910591332.jpg?plan=h160	\N	3603	43.0487000	141.3607000	0101000020E61000005AF5B9DA8AAB614058A835CD3B864540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:43.420436
1201	215425	j827hm2nz	\N	南大橋	https://image.anitabi.cn/user/1065/bangumi/215425/points/j827hm2nz-1729910566408.jpg?plan=h160	\N	3617	43.0486000	141.3620000	0101000020E6100000DD24068195AB6140F54A598638864540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:43.574806
1061	328609	cs7d4n	\N	ローソン 金沢八景駅前店	https://image.anitabi.cn/points/328609/cs7d4n_1747783322591.jpg?plan=h160	6	819	35.3310000	139.6207000	0101000020E610000012143FC6DC736140EE7C3F355EAA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:21.692829
1202	215425	j82570arf	\N	南大橋の東側	https://image.anitabi.cn/user/1065/bangumi/215425/points/j82570arf-1729910611775.jpg?plan=h160	\N	3626	43.0486000	141.3621000	0101000020E6100000363CBD5296AB6140F54A598638864540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:43.772601
1444	186515	4673813e	\N	胸突坂	https://image.anitabi.cn/points/186515/4673813e_1722414063846.jpg?plan=h160	2	278	35.7125000	139.7235000	0101000020E6100000FED478E9267761403333333333DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.71258%2C139.723541&z=17	2026-06-09 19:30:22.693873
1203	215425	jftq9bglc	\N	中島公園	https://image.anitabi.cn/user/1065/bangumi/215425/points/jftq9bglc-1729910678606.jpg?plan=h160	\N	3665	43.0476000	141.3550000	0101000020E61000008FC2F5285CAB614012A5BDC117864540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:43.954356
1204	215425	p9p2emu8k	\N	辛味噌ラーメン札幌海老秀 狸小路二丁目店	https://image.anitabi.cn/user/1065/bangumi/215425/points/p9p2emu8k-1729430873263.jpg?plan=h160	\N	3752	43.0579000	141.3558000	0101000020E6100000567DAEB662AB61401D38674469874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.090743
1205	215425	p9ptpi7g6	\N	狸小路 GARAKU	https://image.anitabi.cn/user/1065/bangumi/215425/points/p9ptpi7g6-1729432540247.jpg?plan=h160	\N	3761	43.0581000	141.3550000	0101000020E61000008FC2F5285CAB6140E5F21FD26F874540	Anitabi@真手凛	https://anitabi.cn/	2026-05-31 23:04:44.173627
1429	262939	rnfd1z9k2	\N	ロイヤルパークホテルザ汐留	https://image.anitabi.cn/user/2148/bangumi/262939/points/rnfd1z9k2-1736149049492.jpg?plan=h160	\N	\N	35.6640000	139.7604000	0101000020E61000001C7C613255786140A245B6F3FDD44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:15.076815
679	283643	jyw3i3zjz	\N	宇治神社	https://image.anitabi.cn/points/283643/jyw3i3zjz_1714478581422.jpg?plan=h160	2	49	34.8906000	135.8098000	0101000020E6100000A089B0E1E9F96040A7E8482EFF714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:17.937068
687	283643	jyrzs0o0c	\N	みんな​のき​木幡​こども園	https://image.anitabi.cn/points/283643/jyrzs0o0c_1714469664188.jpg?plan=h160	2	584	34.9225000	135.7960000	0101000020E6100000B6F3FDD478F96040AE47E17A14764140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:22.582391
707	283643	kpy1x3l1i	京都音乐厅	京都​コンサート​ホール	https://image.anitabi.cn/points/283643/kpy1x3l1i_1716598667772.jpg?plan=h160	7	100	35.0504000	135.7671000	0101000020E61000005F984C158CF86040F5DBD78173864140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:35.95885
891	246429	umk0blzw1	Liquid room	リキッドルーム	https://image.anitabi.cn/points/186515/695f57ef_1722413933374.jpg?plan=h160	2	717	35.6491000	139.7105000	0101000020E6100000DBF97E6ABC766140B3EA73B515D34140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.649113%2C139.710564&z=17	2026-05-24 11:02:54.593103
1448	186515	3f005619	\N	大滝橋	https://image.anitabi.cn/points/186515/3f005619_1722414074827.jpg?plan=h160	11	914	35.7104000	139.7260000	0101000020E6100000AC1C5A643B776140098A1F63EEDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.710437%2C139.72607&z=17	2026-06-09 19:30:24.973642
1105	328609	cnty9n	\N	クロサワ楽器 お茶の水駅前店	https://image.anitabi.cn/points/328609/cnty9n_1747775978149.jpg?plan=h160	12	1156	35.6992000	139.7631000	0101000020E61000007CF2B0506B7861407DAEB6627FD94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:33.422428
613	152091	kq9aq1gci	\N	アクトパル宇治 宿泊棟 洗手间（未确定）	https://image.anitabi.cn/points/152091/kq9aq1gci_1716623148618.jpg?plan=h160	3	775	34.9346000	135.8547000	0101000020E6100000857CD0B359FB6040BA6B09F9A0774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:27.552987
888	246429	rewzvb	文京区关口1丁目40·神田川南岸	文京区关口1丁目40·神田川南岸	https://image.anitabi.cn/user/0/bangumi/246429/points/rewzvb-1748668006697.jpg?plan=h160	1	729	35.7119000	139.7228000	0101000020E61000009031772D21776140DE02098A1FDB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.40041
1231	98371	oyeqj77hn	\N	富士多摩ビル	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyeqj77hn-1728546367900.jpg?plan=h160	1	160	35.6221000	139.4197000	0101000020E610000033C4B12E6E6D6140BA6B09F9A0CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.835488
429	428735	re0ra4dy5	\N	鬼子母神前停留場	https://image.anitabi.cn/points/428735/re0ra4dy5_1735411953055.jpg?plan=h160	3	453	35.7200000	139.7147000	0101000020E610000070CE88D2DE7661405C8FC2F528DC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.675838
1246	51928	l08ijapkq	星巴克 吉祥寺东急百货店	スターバックスコーヒー吉祥寺東急店	https://image.anitabi.cn/user/1099/bangumi/2585/points/l08ijapkq-1717405709101.jpg?plan=h160	4	570	35.7052000	139.5774000	0101000020E6100000BC96900F7A726140D1915CFE43DA4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.291432
1232	98371	oye4l5kg2	\N	新宿センタービル 水の広場	https://image.anitabi.cn/user/1099/bangumi/98371/points/oye4l5kg2-1728545040797.jpg?plan=h160	1	169	35.6913000	139.6954000	0101000020E61000006E3480B740766140C6DCB5847CD84140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.967462
1438	186515	5360f912	\N	富士見坂上	https://image.anitabi.cn/points/186515/5360f912_1722414050058.jpg?plan=h160	9	1091	35.7165000	139.7176000	0101000020E610000082734694F6766140C1CAA145B6DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.716506%2C139.717634&z=17	2026-06-09 19:30:20.071774
1233	98371	oydwdclgu	\N	西新宿自転车保管塌所	https://image.anitabi.cn/user/1099/bangumi/98371/points/oydwdclgu-1728544515633.jpg?plan=h160	1	172	35.6912000	139.6931000	0101000020E6100000711B0DE02D766140637FD93D79D84140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:36.068231
1437	186515	ca6ae733	\N	宿坂通り（南蔵院前）	https://image.anitabi.cn/points/186515/ca6ae733_1722414048439.jpg?plan=h160	4	399	35.7149000	139.7147000	0101000020E610000070CE88D2DE76614088F4DBD781DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.714955%2C139.714752&z=17	2026-06-09 19:30:19.488617
1226	98371	oyf2wdlfx	\N	Shoo La Rue	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyf2wdlfx-1728547181300.jpg?plan=h160	1	13	35.6228000	139.4244000	0101000020E6100000840D4FAF946D614072F90FE9B7CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.265896
1234	98371	oyesg33h3	\N	シューラルー ココリア多摩センター	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyesg33h3-1728546551833.jpg?plan=h160	1	173	35.6228000	139.4244000	0101000020E6100000840D4FAF946D614072F90FE9B7CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:36.156388
1235	98371	oyfbrkvvm	\N	ファミリーマート多摩センター駅南店	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyfbrkvvm-1728547972758.jpg?plan=h160	1	428	35.6221000	139.4211000	0101000020E61000000F0BB5A6796D6140BA6B09F9A0CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:36.254964
1227	98371	oycwvyi08	\N	新宿住友ビル 三角広場	https://image.anitabi.cn/user/1099/bangumi/98371/points/oycwvyi08-1728542665493.jpg?plan=h160	1	135	35.6912000	139.6921000	0101000020E6100000F931E6AE25766140637FD93D79D84140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.407675
1236	98371	oyg5x4dtz	\N	立川 タカシマヤ	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyg5x4dtz-1728549453982.jpg?plan=h160	1	857	35.6987000	139.4129000	0101000020E610000097900F7A366D61408CDB68006FD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:36.365458
1228	98371	oyeduyjop	\N	多摩センター三角広場 旁	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyeduyjop-1728545573537.jpg?plan=h160	1	140	35.6226000	139.4241000	0101000020E61000007AC7293A926D6140AB3E575BB1CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.509146
1452	186515	f98f5672	\N	東京メトロ早稲田駅	https://image.anitabi.cn/points/186515/f98f5672_1722418417528.jpg?plan=h160	1	655	35.7058000	139.7208000	0101000020E61000009E5E29CB1077614027C286A757DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.705894%2C139.720827&z=17	2026-06-09 19:30:26.996735
918	246429	umk0blzfp	\N	ホテルアペルト	https://image.anitabi.cn/points/186515/7cbaf33f_1722418420314.jpg?plan=h160	8	262	35.7317000	139.7300000	0101000020E61000008FC2F5285C776140D93D7958A8DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.731742%2C139.730036&z=17	2026-05-24 11:02:56.517982
1475	186515	6ffe9a56	\N	早大通り	https://image.anitabi.cn/points/186515/6ffe9a56_1722414091460.jpg?plan=h160	\N	\N	35.7074000	139.7285000	0101000020E61000005A643BDF4F7761405F984C158CDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.707448%2C139.728594&z=17	2026-06-09 19:30:37.388335
1229	98371	oyds42m5l	\N	四季の路	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyds42m5l-1728544298237.jpg?plan=h160	1	143	35.6933000	139.7039000	0101000020E6100000F1F44A59867661408D28ED0DBED84140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.63788
1237	98371	oyghtb7vk	\N	小金井公園 江戸東京たてもの園 子宝湯	https://image.anitabi.cn/user/1099/bangumi/98371/points/oyghtb7vk-1728550230007.jpg?plan=h160	1	915	35.7166000	139.5150000	0101000020E610000014AE47E17A70614024287E8CB9DB4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:36.456559
1230	98371	oyftgjjow	\N	JR立川駅 北口	https://image.anitabi.cn/user/1099/bangumi/51928/points/oyftgjjow-1728548693731.jpg?plan=h160	1	146	35.6987000	139.4129000	0101000020E610000097900F7A366D61408CDB68006FD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-05 20:30:35.740872
533	152091	kq9z46d0e	\N	宇治公园附近 夜晚 夏	https://image.anitabi.cn/points/152091/kq9z46d0e_1716624622833.jpg?plan=h160	4	263	34.8879000	135.8088000	0101000020E610000027A089B0E1F96040280F0BB5A6714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:29.5001
618	152091	kq92lbcep	\N	アクトパル宇治 遮阳棚（未确定）	https://image.anitabi.cn/points/152091/kq92lbcep_1716622662298.jpg?plan=h160	3	125	34.9357000	135.8548000	0101000020E6100000DE9387855AFB6040006F8104C5774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:30.732318
1106	328609	coa94i	\N	クロサワウインド お茶の水店	https://image.anitabi.cn/points/328609/coa94i_1747776739251.jpg?plan=h160	12	1184	35.6994000	139.7632000	0101000020E6100000D50968226C78614044696FF085D94140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:33.680724
1445	186515	d4ee98ef	\N	永青文庫	https://image.anitabi.cn/points/186515/d4ee98ef_1722414068970.jpg?plan=h160	9	362	35.7132000	139.7232000	0101000020E6100000F38E537424776140ECC039234ADB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.713208%2C139.723274&z=17	2026-06-09 19:30:23.670786
538	152091	kq7egvkrq	\N	喜撰桥 东	https://image.anitabi.cn/points/152091/kq7egvkrq_1716619065477.jpg?plan=h160	1	2517	34.8883000	135.8099000	0101000020E6100000F9A067B3EAF96040B6847CD0B3714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:32.671298
642	152091	s8nkqj3gy	堀井七茗園前	あがた通り 堀井七茗園	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8nkqj3gy-1737812554496.jpg?plan=h160	6	898	34.8887000	135.8055000	0101000020E6100000B29DEFA7C6F9604044FAEDEBC0714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:46.397623
914	246429	rj965a5qw	大冢站北入口	大塚駅北口	https://image.anitabi.cn/user/0/bangumi/246429/points/rj965a5qw-1735822095306.jpg?plan=h160	7	1084	35.7317000	139.7287000	0101000020E61000000C93A98251776140D93D7958A8DD4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.243057
1434	186515	22967403	\N	学習院下駅２	https://image.anitabi.cn/points/186515/22967403_1722414041681.jpg?plan=h160	8	939	35.7163000	139.7125000	0101000020E6100000CDCCCCCCCC766140F90FE9B7AFDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.716321%2C139.712516&z=17	2026-06-09 19:30:17.402749
1079	328609	uqfhq4kmf	\N	江島神社 大鳥居	https://image.anitabi.cn/points/328609/uqfhq4kmf_1744847757825.jpg?plan=h160	9	789	35.3007000	139.4803000	0101000020E61000009A081B9E5E6F61401FF46C567DA64140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:26.825034
553	152091	kqfj4sw7r	\N	莵道高 中庭	https://image.anitabi.cn/points/152091/kqfj4sw7r_1716636711292.jpg?plan=h160	4	638	34.9095000	135.8165000	0101000020E6100000E3A59BC420FA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:43.217232
1436	186515	0575d016	\N	宿坂通り	https://image.anitabi.cn/points/186515/0575d016_1722414045756.jpg?plan=h160	4	378	35.7147000	139.7144000	0101000020E61000006688635DDC766140C139234A7BDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.714711%2C139.714479&z=17	2026-06-09 19:30:18.97581
661	152091	9xalsd1	水管桥附近	水管桥附近	https://image.anitabi.cn/user/0/bangumi/152091/points/9xalsd1-1768614616215.jpg?plan=h160	9	\N	34.9001000	135.8016000	0101000020E6100000280F0BB5A6F9604097900F7A36734140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:59.7193
794	1424	s9mfm68ka	\N	豊郷小学校2F	https://image.anitabi.cn/points/1424/s9mfm68ka_1737888424410.jpg?plan=h160	\N	\N	35.2035000	136.2330000	0101000020E6100000FA7E6ABC74076140355EBA490C9A4140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.90457
652	152091	kq46fn70z	\N	大吉山展望台	https://image.anitabi.cn/points/152091/kq46fn70z_1716612028332.jpg?plan=h160	1	\N	34.8925000	135.8122000	0101000020E6100000F5B9DA8AFDF960400AD7A3703D724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:52.648369
571	152091	kqa23go0m	\N	莵道高 教学楼 三四楼 （未确定）	https://image.anitabi.cn/points/152091/kqa23go0m_1716624799651.jpg?plan=h160	4	451	34.9097000	135.8163000	0101000020E610000032772D211FFA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:54.892035
1471	186515	3dff776c	\N	マリオンクレープ	https://image.anitabi.cn/points/186515/3dff776c_1722414013218.jpg?plan=h160	\N	\N	35.6712000	139.7048000	0101000020E610000011C7BAB88D766140A089B0E1E9D54140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.671275%2C139.704883&z=17	2026-06-09 19:30:36.459814
1021	328609	cl27l5	\N	金沢シーサイドライン下広場	https://image.anitabi.cn/points/328609/cl27l5_1747771330293.jpg?plan=h160	1	241	35.3303000	139.6231000	0101000020E61000006744696FF073614035EF384547AA4140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:15.329705
629	152091	p9rfqw0mx	\N	センチュリーホール ホワイエ 上階	https://image.anitabi.cn/user/0/bangumi/152091/points/p9rfqw0mx-1729436025995.jpg?plan=h160	12	696	35.1324000	136.8986000	0101000020E6100000F085C954C11C6140C5FEB27BF2904140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:37.591746
1468	186515	kbqz2z	神田川桜並木·路口	神田川桜並木·路口	https://image.anitabi.cn/user/0/bangumi/186515/points/kbqz2z-1748239412845.jpg?plan=h160	1	772	35.7126000	139.7221000	0101000020E6100000228E75711B77614097900F7A36DB4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:35.103492
1051	328609	4xynj6q6m	\N	下北線路街 空き地	https://image.anitabi.cn/user/1000/bangumi/328609/points/4xynj6q6m.jpg?plan=h160	5	357	35.6630000	139.6695000	0101000020E61000008195438B6C756140BE9F1A2FDDD44140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-31 22:40:18.941621
1463	186515	u3wbdky6m	飞鸟山步行桥	Asukayama Koen Hodo Bridge 飛鳥山公園歩道橋	https://image.anitabi.cn/user/0/bangumi/186515/points/u3wbdky6m-1743082369070.jpg?plan=h160	11	8	35.7511000	139.7371000	0101000020E6100000363CBD52967761404703780B24E04140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:33.063824
531	152091	kq61a7s69	\N	宇治公园附近	https://image.anitabi.cn/points/152091/kq61a7s69_1716616055079.jpg?plan=h160	1	775	34.8880000	135.8088000	0101000020E610000027A089B0E1F960408B6CE7FBA9714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:28.065637
356	55113	31pe137	\N	十字路を北へ30mほど	https://image.anitabi.cn/points/55113/31pe137_1724031427045.jpg?plan=h160	1	1201	35.0305000	135.7685000	0101000020E61000003BDF4F8D97F8604096438B6CE7834140	エンドス	\N	2026-05-04 16:22:33.874255
612	152091	kq95wgkao	\N	アクトパル宇治 宿泊棟 汤（未确定）	https://image.anitabi.cn/points/152091/kq95wgkao_1716622851064.jpg?plan=h160	3	403	34.9346000	135.8547000	0101000020E6100000857CD0B359FB6040BA6B09F9A0774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:26.945235
1466	186515	kbd9ji	江戸川公園・秋千	江戸川公園・秋千	https://image.anitabi.cn/user/0/bangumi/186515/points/kbd9ji-1748238780826.jpg?plan=h160	12	225	35.7107000	139.7261000	0101000020E6100000053411363C77614034A2B437F8DA4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:34.435672
1443	186515	a6e8e3e1	\N	駒塚橋	https://image.anitabi.cn/points/186515/a6e8e3e1_1722414061175.jpg?plan=h160	5	622	35.7120000	139.7232000	0101000020E6100000F38E5374247761404260E5D022DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.712007%2C139.723261&z=17	2026-06-09 19:30:22.528435
1088	328609	50slhsccy	\N	江の島シーキャンドル	https://image.anitabi.cn/points/328609/50slhsccy_1672311114163.jpg?plan=h160	9	984	35.2997000	139.4784000	0101000020E6100000014D840D4F6F61403C4ED1915CA64140	林宏	\N	2026-05-31 22:40:28.967867
1440	186515	17299332	金泉汤澡堂	金泉湯	https://image.anitabi.cn/points/186515/17299332_1722414054438.jpg?plan=h160	10	555	35.7099000	139.7124000	0101000020E610000074B515FBCB76614017B7D100DEDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.709964%2C139.712405&z=17	2026-06-09 19:30:21.000086
650	152091	kq40czq6d	\N	久美子椅 对岸 远眺 樱花期	https://image.anitabi.cn/points/152091/kq40czq6d_1716611658228.jpg?plan=h160	1	\N	34.8898000	135.8086000	0101000020E610000076711B0DE0F960408BFD65F7E4714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:51.31086
898	246429	sp65rr	宿坂通り·路口	宿坂通り·路口	https://image.anitabi.cn/user/0/bangumi/246429/points/sp65rr-1748745686566.jpg?plan=h160	4	388	35.7147000	139.7144000	0101000020E61000006688635DDC766140C139234A7BDB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:55.07992
1425	262939	rne3rr4cz	\N	噴水・彫刻「泉」	https://image.anitabi.cn/user/2148/bangumi/262939/points/rne3rr4cz-1736146430633.jpg?plan=h160	\N	\N	35.6605000	139.7591000	0101000020E6100000984C158C4A786140068195438BD44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:13.700319
824	262940	o4jywwhce	\N	京王プラザホテル 多摩	https://image.anitabi.cn/user/1099/bangumi/262940/points/o4jywwhce-1726206915781.jpg?plan=h160	1	873	35.6233000	139.4250000	0101000020E61000009A999999996D614064CC5D4BC8CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.157265
1464	186515	aa6bws	胸突坂 石凳前	胸突坂	https://image.anitabi.cn/user/0/bangumi/186515/points/aa6bws-1747632132222.jpg?plan=h160	11	920	35.7124000	139.7234000	0101000020E6100000A5BDC11726776140D0D556EC2FDB4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:33.351245
1442	186515	95ff4037	\N	神田川桜並木	https://image.anitabi.cn/points/186515/95ff4037_1722414058383.jpg?plan=h160	1	779	35.7125000	139.7220000	0101000020E6100000C976BE9F1A7761403333333333DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.712586%2C139.722087&z=17	2026-06-09 19:30:21.953442
1456	186515	eae9a5b7	\N	サンモール大塚商店街振興組合	https://image.anitabi.cn/points/186515/eae9a5b7_1722418421194.jpg?plan=h160	10	20	35.7301000	139.7280000	0101000020E61000009EEFA7C64B776140A167B3EA73DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.730179%2C139.728015&z=17	2026-06-09 19:30:29.954565
1253	51928	id8ogkgtx	丸子桥	丸子桥	https://image.anitabi.cn/user/0/bangumi/2585/points/id8ogkgtx-1709961093020.jpg?plan=h160	14	568	35.5850000	139.6683000	0101000020E6100000567DAEB6627561407B14AE47E1CA4140	Anitabi	https://anitabi.cn/	2026-06-07 11:13:56.782598
1098	328609	couqrq	\N	日本武道館	https://image.anitabi.cn/points/328609/couqrq_1747777693736.jpg?plan=h160	11	1114	35.6931000	139.7493000	0101000020E6100000925CFE43FA776140C66D3480B7D84140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:31.529339
1446	186515	a18f817a	\N	目白台三丁目交差点	https://image.anitabi.cn/points/186515/a18f817a_1722414071859.jpg?plan=h160	1	814	35.7151000	139.7247000	0101000020E610000029ED0DBE307761404FAF946588DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.71511%2C139.72471&z=17	2026-06-09 19:30:24.320028
1470	186515	32d934b2	\N	渋谷スターラウンジ	https://image.anitabi.cn/points/186515/32d934b2_1722414007271.jpg?plan=h160	\N	\N	35.6623000	139.6978000	0101000020E6100000C364AA60547661400612143FC6D44140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.662399%2C139.697875&z=17	2026-06-09 19:30:35.956106
1451	186515	fac740b8	\N	鶴巻南公園	https://image.anitabi.cn/points/186515/fac740b8_1722418416424.jpg?plan=h160	6	757	35.7061000	139.7240000	0101000020E6100000BA490C022B77614051DA1B7C61DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.706156%2C139.724088&z=17	2026-06-09 19:30:26.755845
1457	186515	a7b97b33	\N	豊島区立南大塚公園	https://image.anitabi.cn/points/186515/a7b97b33_1722418422021.jpg?plan=h160	3	465	35.7276000	139.7312000	0101000020E6100000BADA8AFD65776140E9482EFF21DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.727681%2C139.731241&z=17	2026-06-09 19:30:30.526875
1459	186515	88856017	\N	飛鳥山交差点	https://image.anitabi.cn/points/186515/88856017_1722418423786.jpg?plan=h160	1	143	35.7508000	139.7373000	0101000020E6100000E86A2BF6977761401CEBE2361AE04140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.750842%2C139.737374&z=17	2026-06-09 19:30:31.608809
393	216372	kqh8kway4	\N	京坂六地藏站	https://image.anitabi.cn/points/216372/kqh8kway4_1716640435737.jpg?plan=h160	\N	1056	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.720022
394	216372	kqhsouzti	\N	京坂六地藏站前	https://image.anitabi.cn/points/216372/kqhsouzti_1716641656332.jpg?plan=h160	\N	2729	34.9319000	135.7940000	0101000020E6100000C520B07268F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.751278
776	1424	5d9wjqb	\N	ノースコート	https://image.anitabi.cn/user/0/bangumi/1424/points/5d9wjqb-1758696965066.jpg?plan=h160	9	84	35.0440000	135.7919000	0101000020E61000007A36AB3E57F960401283C0CAA1854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.724825
1426	186515	182c5348	\N	サウンドスタジオノア駒沢店	https://image.anitabi.cn/points/186515/182c5348_1722414026093.jpg?plan=h160	5	354	35.6345000	139.6628000	0101000020E61000003E7958A835756140F0A7C64B37D14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.63452%2C139.662889&z=17	2026-06-09 19:30:14.25009
664	152091	k6mkxvg9a	\N	京都駅	https://image.anitabi.cn/points/115908/k6mkxvg9a_1715084784883.jpg?plan=h160	\N	\N	34.9856000	135.7581000	0101000020E61000002063EE5A42F8604003780B24287E4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:02.884291
924	246429	un19ur	飛鳥山停留場·三之轮桥方向	飛鳥山停留場·三之轮桥方向	https://image.anitabi.cn/user/0/bangumi/246429/points/un19ur-1748863096900.jpg?plan=h160	11	647	35.7502000	139.7374000	0101000020E61000004182E2C798776140C7BAB88D06E04140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:56.952076
1268	51928	r80t2kz8x	\N	立川駅前	https://image.anitabi.cn/user/1099/bangumi/51928/points/r80t2kz8x-1734941924506.jpg?plan=h160	18	984	35.7003000	139.4117000	0101000020E61000006C787AA52C6D6140C4B12E6EA3D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.836062
1272	51928	uxgy4p1vd	\N	多摩モノレール通り	https://image.anitabi.cn/points/51928/uxgy4p1vd_1745399463019.jpg?plan=h160	5	722	35.6223000	139.4223000	0101000020E61000003A234A7B836D61408126C286A7CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:58.116988
1454	186515	49ceff45	\N	大塚駅	https://image.anitabi.cn/points/186515/49ceff45_1722418419375.jpg?plan=h160	7	610	35.7316000	139.7295000	0101000020E6100000D34D62105877614076E09C11A5DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.731666%2C139.729504&z=17	2026-06-09 19:30:28.551585
1273	51928	5zdusbe	\N	JTB トラベルゲート立川	https://image.anitabi.cn/user/0/bangumi/51928/points/5zdusbe-1760033990780.jpg?plan=h160	13	1321	35.6990000	139.4128000	0101000020E61000003E7958A8356D6140B6F3FDD478D94140	Anitabi	https://anitabi.cn/	2026-06-07 11:13:58.193432
1453	186515	5a778d27	都电杂司谷站	都電雑司が谷駅	https://image.anitabi.cn/points/186515/5a778d27_1722418418487.jpg?plan=h160	4	684	35.7241000	139.7178000	0101000020E610000034A2B437F87661404D840D4FAFDC4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.724151%2C139.717801&z=17	2026-06-09 19:30:27.573321
1270	51928	uxgcwxvfy	\N	パルテノン大通リ	https://image.anitabi.cn/user/1099/bangumi/51928/points/uxgcwxvfy-1745398436731.jpg?plan=h160	13	1213	35.6236000	139.4248000	0101000020E6100000E86A2BF6976D61408FE4F21FD2CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.976855
1275	51928	5zhn0fa	\N	东京地方裁判所立川支部北侧人行道	https://image.anitabi.cn/user/0/bangumi/51928/points/5zhn0fa-1760040357897.jpg?plan=h160	18	323	35.7127000	139.4106000	0101000020E61000009A779CA2236D6140FAEDEBC039DB4140	Anitabi	https://anitabi.cn/	2026-06-07 11:13:58.332258
1274	51928	5zh17pn	\N	東京都赤十字血液センター 立川事業所	https://image.anitabi.cn/user/0/bangumi/51928/points/5zh17pn-1760039355353.jpg?plan=h160	11	1117	35.7071000	139.4080000	0101000020E6100000931804560E6D61403480B74082DA4140	Anitabi	https://anitabi.cn/	2026-06-07 11:13:58.262915
1276	51928	uxfx89bff	\N	Shoo La Rue	https://image.anitabi.cn/user/1099/bangumi/51928/points/uxfx89bff-1745397248751.jpg?plan=h160	\N	\N	35.6228000	139.4244000	0101000020E6100000840D4FAF946D614072F90FE9B7CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:58.399695
1427	262939	rneaeltkx	\N	Wireless City Planning Inc.	https://image.anitabi.cn/user/2148/bangumi/262939/points/rneaeltkx-1736146734371.jpg?plan=h160	\N	\N	35.6617000	139.7593000	0101000020E61000004A7B832F4C786140B1E1E995B2D44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:14.419487
584	152091	kq4z5rwem	\N	京坂六地藏站 内 入站楼梯出口前	https://image.anitabi.cn/points/152091/kq4z5rwem_1716613737477.jpg?plan=h160	1	614	34.9319000	135.7934000	0101000020E6100000AF94658863F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:08.926644
1267	51928	r7zlp6flw	\N	三菱UFJ信託銀行 立川支店	https://image.anitabi.cn/user/1099/bangumi/51928/points/r7zlp6flw-1734939274313.jpg?plan=h160	17	832	35.7003000	139.4136000	0101000020E6100000053411363C6D6140C4B12E6EA3D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.774166
1271	51928	uxgmqr1ui	\N	ゆうゆう桥	https://image.anitabi.cn/user/1099/bangumi/51928/points/uxgmqr1ui-1745398768836.jpg?plan=h160	5	709	35.6223000	139.4223000	0101000020E61000003A234A7B836D61408126C286A7CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:58.047288
1269	51928	te4s1ya0w	\N	ゆうゆう橋	https://image.anitabi.cn/user/0/bangumi/51928/points/te4s1ya0w-1741062980360.jpg?plan=h160	5	640	35.6222000	139.4223000	0101000020E61000003A234A7B836D61401DC9E53FA4CF4140	Anitabi	https://anitabi.cn/	2026-06-07 11:13:57.906919
1266	51928	pvf5ayyoq	\N	ジョナサン向ヶ丘​遊園​店	https://image.anitabi.cn/user/1099/bangumi/51928/points/pvf5ayyoq-1731133256577.jpg?plan=h160	6	1151	35.6165000	139.5635000	0101000020E610000079E9263108726140F4FDD478E9CE4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.700953
702	283643	kc6he63mj	\N	浅草寺雷门	https://image.anitabi.cn/user/0/bangumi/283643/points/kc6he63mj-1715519939253.jpg?plan=h160	6	130	35.7111000	139.7963000	0101000020E6100000C139234A7B796140C217265305DB4140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:32.889299
1263	51928	pre88tfau	\N	銀座コージーコーナー 武蔵小山店	https://image.anitabi.cn/user/1099/bangumi/51928/points/pre88tfau-1730818058380.jpg?plan=h160	4	991	35.6199000	139.7039000	0101000020E6100000F1F44A59867661402C6519E258CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.481267
1239	51928	o51ez4x9t	\N	立川駅	https://image.anitabi.cn/user/1099/bangumi/51928/points/o51ez4x9t-1726244784716.jpg?plan=h160	1	152	35.6988000	139.4127000	0101000020E6100000E561A1D6346D6140EF38454772D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:55.798178
1477	293049	106ft7vg23	涉谷站忠犬八公雕塑	渋谷駅ハチ公口	https://image.anitabi.cn/user/0/bangumi/293049/points/51i51ugl0-1753782214356.jpg?plan=h160	2	411	35.6589000	139.7005000	0101000020E610000023DBF97E6A766140CEAACFD556D44140	Google Maps	https://www.google.com/maps/d/viewer?mid=1ZhGSZXEZkJn9JOJxG3pgd70zfD5dEH3w&ll=35.65899%2C139.700591&z=17	2026-06-11 14:48:17.694661
1030	328609	4yd2vzb5s	\N	下北沢駅前	https://image.anitabi.cn/points/328609/4yd2vzb5s.jpg?plan=h160	1	626	35.6617000	139.6674000	0101000020E610000036AB3E575B756140B1E1E995B2D44140	林宏	\N	2026-05-31 22:40:16.295039
1242	51928	odvr0mnkj	\N	「背中あわせの円」①フェリーチェ·ヴァリーニ	https://image.anitabi.cn/user/1099/bangumi/51928/points/odvr0mnkj-1726937826686.jpg?plan=h160	1	158	35.7014000	139.4136000	0101000020E6100000053411363C6D61400BB5A679C7D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.001007
1240	51928	odvxh0zc2	\N	Cinema One 立川	https://image.anitabi.cn/user/1099/bangumi/51928/points/odvxh0zc2-1726938114877.jpg?plan=h160	1	153	35.7003000	139.4138000	0101000020E6100000B7627FD93D6D6140C4B12E6EA3D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:55.866761
1244	51928	pqc424nkz	星巴克吉祥寺東急店	Starbucks Coffee - Kichijoji Tokyu	https://image.anitabi.cn/user/1099/bangumi/51928/points/pqc424nkz-1730734913880.jpg?plan=h160	4	478	35.7053000	139.5775000	0101000020E610000014AE47E17A72614035EF384547DA4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.142244
1478	604826	ack4iu6	\N	コーポ東峰	https://image.anitabi.cn/user/0/bangumi/604826/points/ack4iu6-1769537586152.jpg?plan=h160	\N	178	35.6933000	139.4134000	0101000020E61000005305A3923A6D61408D28ED0DBED84140	Anitabi	https://anitabi.cn/	2026-06-11 14:48:46.653364
1259	51928	prc8gvz0l	\N	りんごLabo多摩センター店	https://image.anitabi.cn/user/1099/bangumi/51928/points/prc8gvz0l-1730813459884.jpg?plan=h160	2	1354	35.6254000	139.4228000	0101000020E6100000F697DD93876D61408E75711B0DD04140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.203793
1243	51928	pqcij7j1e	\N	ドン・キホーテ秋葉原店	https://image.anitabi.cn/user/1099/bangumi/51928/points/pqcij7j1e-1730735769836.jpg?plan=h160	3	495	35.7005000	139.7713000	0101000020E6100000F46C567DAE7861408B6CE7FBA9D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.071833
455	428735	reku42rio	东口五差路	東口五差路交差点	https://image.anitabi.cn/points/428735/reku42rio_1735455724758.jpg?plan=h160	6	947	35.7295000	139.7141000	0101000020E61000005B423EE8D97661404C37894160DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.554645
1247	51928	odw1uth94	\N	伊勢丹立川店	https://image.anitabi.cn/user/1099/bangumi/51928/points/odw1uth94-1726938396012.jpg?plan=h160	4	1079	35.6990000	139.4128000	0101000020E61000003E7958A8356D6140B6F3FDD478D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.35768
1255	51928	o4mjj4adh	\N	中央大学前	https://image.anitabi.cn/user/1099/bangumi/262940/points/o4mjj4adh-1726213122311.jpg?plan=h160	24	93	35.6391000	139.4038000	0101000020E6100000FE43FAEDEB6C6140D26F5F07CED14140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.928408
1264	51928	prernyyej	\N	Town Housing Tama Center Shop	https://image.anitabi.cn/user/1099/bangumi/51928/points/prernyyej-1730819489517.jpg?plan=h160	4	1143	35.6231000	139.4224000	0101000020E6100000933A014D846D61409D11A5BDC1CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.551759
1260	51928	prcycw5te	\N	ART RUSH Rebs Su	https://image.anitabi.cn/user/1099/bangumi/51928/points/prcycw5te-1730815034788.jpg?plan=h160	4	667	35.6223000	139.4222000	0101000020E6100000E10B93A9826D61408126C286A7CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.272245
1254	51928	odx85yeuy	\N	専修大学生田キャンパス	https://image.anitabi.cn/user/1099/bangumi/51928/points/odx85yeuy-1726940956540.jpg?plan=h160	24	62	35.6112000	139.5536000	0101000020E610000019E25817B771614058A835CD3BCE4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.855059
1251	51928	odwcl22mm	罗森 立川南口大通店	Lawson Tachikawa Minamiguchi-odori	https://image.anitabi.cn/user/1099/bangumi/51928/points/odwcl22mm-1726939069069.jpg?plan=h160	12	625	35.6946000	139.4116000	0101000020E61000001361C3D32B6D61409BE61DA7E8D84140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.641825
1249	51928	o3v8q6xi6	Cocolia多摩中心	Cocolia Tama Center	https://image.anitabi.cn/user/1099/bangumi/51928/points/o3v8q6xi6-1726153103160.jpg?plan=h160	6	724	35.6226000	139.4243000	0101000020E61000002BF697DD936D6140AB3E575BB1CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.492213
1257	51928	o4le8nhse	\N	中央大学多摩キャンパス	https://image.anitabi.cn/user/1099/bangumi/51928/points/o4le8nhse-1726210550899.jpg?plan=h160	24	491	35.6400000	139.4031000	0101000020E610000090A0F831E66C614052B81E85EBD14140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.066985
1261	51928	prdasw1rt	\N	立川北駅 	https://image.anitabi.cn/user/1099/bangumi/51928/points/prdasw1rt-1730815900020.jpg?plan=h160	4	664	35.6990000	139.4125000	0101000020E610000033333333336D6140B6F3FDD478D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.341166
1431	262939	rnfnbbbjs	\N	汐留住友ビル横	https://image.anitabi.cn/user/2148/bangumi/262939/points/rnfnbbbjs-1736149666536.jpg?plan=h160	\N	\N	35.6621000	139.7602000	0101000020E61000006A4DF38E537861403F575BB1BFD44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:15.628382
1252	51928	odw9hft9i	\N	立川北駅前	https://image.anitabi.cn/user/1099/bangumi/51928/points/odw9hft9i-1726938853118.jpg?plan=h160	12	868	35.7001000	139.4118000	0101000020E6100000C58F31772D6D6140FDF675E09CD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.711765
1265	51928	pvefpd6ve	\N	立川南駅	https://image.anitabi.cn/user/1099/bangumi/51928/points/pvefpd6ve-1731131763950.jpg?plan=h160	5	775	35.6957000	139.4121000	0101000020E6100000D0D556EC2F6D6140E2E995B20CD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.617498
1262	51928	prdwrc2fc	\N	セブン-イレブン 武蔵野境２丁目店	https://image.anitabi.cn/user/1099/bangumi/51928/points/prdwrc2fc-1730817373131.jpg?plan=h160	4	725	35.7026000	139.5420000	0101000020E6100000D34D621058716140B515FBCBEED94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.416329
1455	186515	7cbaf33f	\N	ホテルアペルト	https://image.anitabi.cn/points/186515/7cbaf33f_1722418420314.jpg?plan=h160	8	262	35.7317000	139.7300000	0101000020E61000008FC2F5285C776140D93D7958A8DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.731742%2C139.730036&z=17	2026-06-09 19:30:29.355152
1248	51928	o8z9gyplu	\N	多摩センター駅前	https://image.anitabi.cn/user/1099/bangumi/51928/points/o8z9gyplu-1726553687793.jpg?plan=h160	6	137	35.6245000	139.4245000	0101000020E6100000DD240681956D61400E2DB29DEFCF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.426988
1258	51928	pqcz0gecw	\N	警視庁 多摩中央警察署 前	https://image.anitabi.cn/user/1099/bangumi/51928/points/pqcz0gecw-1730736731429.jpg?plan=h160	1	211	35.6233000	139.4216000	0101000020E6100000CC7F48BF7D6D614064CC5D4BC8CF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:57.133179
1277	347140	bnh1bhg	目黑天空庭園	目黒​区立​目黒​天空​庭園	https://image.anitabi.cn/user/0/bangumi/347140/points/bnh1bhg-1772374332208.jpg?plan=h160	\N	\N	35.6504000	139.6879000	0101000020E6100000645DDC4603766140C1A8A44E40D34140	Anitabi	https://anitabi.cn/	2026-06-07 15:09:25.112084
1278	242216	ab857wyni	福莱甘兹罗斯岛	Folegandros	https://image.anitabi.cn/user/0/bangumi/242216/points/ab857wyni-1687234430335.jpg?plan=h160	\N	\N	36.6275000	24.9016000	0101000020E6100000D712F241CFE63840B81E85EB51504240	Anitabi@月即别	https://anitabi.cn/	2026-06-08 19:47:56.251924
1279	242216	mhh4h4h2o	圣十字圣保罗医院	Hospital de la Santa Creu i Sant Pau	https://image.anitabi.cn/points/242216/mhh4h4h2o_1721577136784.jpg?plan=h160	\N	\N	41.4127000	2.1740000	0101000020E61000003108AC1C5A6401409487855AD3B44440	Anitabi@樱桃纳米粉	https://anitabi.cn/	2026-06-08 19:47:57.685609
1435	186515	78e0cd5e	\N	明治通り	https://image.anitabi.cn/points/186515/78e0cd5e_1722414043756.jpg?plan=h160	3	1063	35.7180000	139.7130000	0101000020E6100000894160E5D076614096438B6CE7DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.718%2C139.71301&z=17	2026-06-09 19:30:18.262783
1280	242216	307nh5h	圣十字圣保罗医院大门前	Edifici d'Administració	https://image.anitabi.cn/points/242216/307nh5h_1753553633089.jpg?plan=h160	\N	\N	41.4108000	2.1743000	0101000020E6100000DB8AFD65F764014031992A1895B44440	Anitabi@月即别	https://anitabi.cn/	2026-06-08 19:48:00.042445
1479	604826	a6pxmdx	\N	たましん美術館	https://image.anitabi.cn/points/604826/a6pxmdx_1769184573751.jpg?plan=h160	\N	193	35.7021000	139.4123000	0101000020E61000008104C58F316D6140C442AD69DED94140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:46.709811
1428	186515	0f0e0e1e	\N	都電早稲田駅	https://image.anitabi.cn/points/186515/0f0e0e1e_1722414028329.jpg?plan=h160	1	159	35.7118000	139.7190000	0101000020E61000005EBA490C027761407AA52C431CDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.711826%2C139.719062&z=17	2026-06-09 19:30:14.899736
828	262940	l6r0lb7lc	东京多摩地区业务接管支援中心	東京都多摩地域事業引継ぎ支援センター	https://image.anitabi.cn/user/1099/bangumi/2585/points/l6r0lb7lc-1717915654428.jpg?plan=h160	2	1325	35.7013000	139.4138000	0101000020E6100000B7627FD93D6D6140A857CA32C4D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.584234
604	152091	kq7mem9lw	\N	县神社 第一鸟居	https://image.anitabi.cn/points/152091/kq7mem9lw_1716619538474.jpg?plan=h160	1	2670	34.8921000	135.8056000	0101000020E61000000BB5A679C7F960407C61325530724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:21.624429
1480	604826	ah2lumn	\N	錦中央通	https://image.anitabi.cn/points/604826/ah2lumn_1769810482590.jpg?plan=h160	\N	273	35.6957000	139.4158000	0101000020E6100000A835CD3B4E6D6140E2E995B20CD94140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:46.768126
539	152091	kq7cawy74	\N	菊桥 西	https://image.anitabi.cn/points/152091/kq7cawy74_1716618884531.jpg?plan=h160	1	2511	34.8901000	135.8080000	0101000020E610000060E5D022DBF96040B515FBCBEE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:33.29369
1481	604826	a6qvi2t	\N	西松屋	https://image.anitabi.cn/points/604826/a6qvi2t_1769186131089.jpg?plan=h160	\N	536	35.7210000	139.4120000	0101000020E610000077BE9F1A2F6D61403F355EBA49DC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:46.82704
572	152091	kq6e10jlu	\N	莵道高 屋顶远眺	https://image.anitabi.cn/points/152091/kq6e10jlu_1716616814299.jpg?plan=h160	1	1786	34.9099000	135.8167000	0101000020E610000095D4096822FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:55.505814
599	152091	kq6ou3xgg	麦当劳宇治木幡店	マクドナルド\n宇治​木幡​店	https://image.anitabi.cn/points/152091/kq6ou3xgg_1716617475711.jpg?plan=h160	1	1838	34.9265000	135.7998000	0101000020E6100000E86A2BF697F960403BDF4F8D97764140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:18.45001
1450	186515	07fd64f7	\N	地蔵通り商店街	https://image.anitabi.cn/points/186515/07fd64f7_1722414093737.jpg?plan=h160	8	318	35.7082000	139.7325000	0101000020E61000003D0AD7A3707761407B832F4CA6DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.708263%2C139.732516&z=17	2026-06-09 19:30:26.047886
1482	604826	bmujxeg	\N	青柳新道	https://image.anitabi.cn/user/0/bangumi/604826/points/bmujxeg-1772336906426.jpg?plan=h160	\N	551	35.7170000	139.4103000	0101000020E61000009031772D216D6140B29DEFA7C6DB4140	Anitabi	https://anitabi.cn/	2026-06-11 14:48:46.880634
1483	604826	a6siqnw	\N	東京都立國分寺高等學校	https://image.anitabi.cn/points/604826/a6siqnw_1769188877648.jpg?plan=h160	\N	1036	35.7126000	139.4473000	0101000020E610000007F01648506E614097900F7A36DB4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:46.930815
1460	186515	b7a25e74	\N	飛鳥山公園	https://image.anitabi.cn/points/186515/b7a25e74_1722418424640.jpg?plan=h160	11	672	35.7503000	139.7388000	0101000020E61000001DC9E53FA47761402B1895D409E04140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.750357%2C139.738858&z=17	2026-06-09 19:30:31.981846
1109	328609	e5w6g50	\N	奥多摩工業氷川工場	https://image.anitabi.cn/points/328609/e5w6g50_1777841706447.jpg?plan=h160	\N	\N	35.8106000	139.0956000	0101000020E6100000EC2FBB270F6361409D11A5BDC1E74140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-31 22:40:34.500841
1449	186515	7477ca0b	\N	江戸川公園・東屋	https://image.anitabi.cn/points/186515/7477ca0b_1722414079736.jpg?plan=h160	3	1027	35.7104000	139.7288000	0101000020E610000065AA605452776140098A1F63EEDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.710434%2C139.728847&z=17	2026-06-09 19:30:25.493128
488	386195	ksq0m69d7	宇治桥	宇治橋	https://image.anitabi.cn/points/386195/ksq0m69d7_1716816275392.jpg?plan=h160	\N	2786	34.8926000	135.8059000	0101000020E610000016FBCBEEC9F960406E3480B740724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.421466
489	386195	ksq10eit5	橘橋	10	https://image.anitabi.cn/points/386195/ksq10eit5_1716816300509.jpg?plan=h160	\N	2795	34.8906000	135.8079000	0101000020E610000007CE1951DAF96040A7E8482EFF714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.477729
1484	604826	a5htto6	\N	サンサンロード	https://image.anitabi.cn/points/604826/a5htto6_1769110461235.jpg?plan=h160	\N	1086	35.7011000	139.4124000	0101000020E6100000DA1B7C61326D6140E09C11A5BDD94140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:46.980905
1485	604826	a5hheqb	\N	Cinema Two	https://image.anitabi.cn/points/604826/a5hheqb_1769110499587.jpg?plan=h160	\N	1092	35.7014000	139.4124000	0101000020E6100000DA1B7C61326D61400BB5A679C7D94140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.030939
1486	604826	a5hztx8	\N	立川ステージガーデン	https://image.anitabi.cn/points/604826/a5hztx8_1769110759521.jpg?plan=h160	\N	1115	35.7038000	139.4117000	0101000020E61000006C787AA52C6D614060764F1E16DA4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.082143
1487	604826	avygcct	\N	MEN YARD FIGHT	https://image.anitabi.cn/points/604826/avygcct_1770710634248.jpg?plan=h160	\N	2448	35.4758000	139.6267000	0101000020E6100000E78C28ED0D746140E9B7AF03E7BC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.134277
1488	604826	a6sujke	\N	片瀬東浜海水浴場	https://image.anitabi.cn/points/604826/a6sujke_1769189589183.jpg?plan=h160	\N	2503	35.3078000	139.4892000	0101000020E61000008126C286A76F6140BADA8AFD65A74140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.184768
1489	604826	afsvm0f	\N	东京站前广场	https://image.anitabi.cn/points/604826/afsvm0f_1779981867027_c16v9.jpg?plan=h160	\N	2774	35.6815000	139.7651000	0101000020E61000006DC5FEB27B786140AC1C5A643BD74140	Anitabi@采钦佩	https://anitabi.cn/	2026-06-11 14:48:47.234324
1465	186515	aacf7v	大滝橋 北岸	大滝橋	https://image.anitabi.cn/user/0/bangumi/186515/points/aacf7v-1747632393457.jpg?plan=h160	11	925	35.7105000	139.7261000	0101000020E6100000053411363C7761406DE7FBA9F1DA4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:33.954944
1490	604826	a6nzjv6	\N	関根ビル	https://image.anitabi.cn/points/604826/a6nzjv6_1769181405856.jpg?plan=h160	\N	2846	35.7278000	139.4180000	0101000020E61000004C378941606D6140B003E78C28DD4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.285059
1238	51928	o516ekmxe	\N	多摩センター三角広場	https://image.anitabi.cn/user/1099/bangumi/51928/points/o516ekmxe-1726244264380.jpg?plan=h160	1	59	35.6224000	139.4235000	0101000020E6100000643BDF4F8D6D6140E4839ECDAACF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:55.70448
1432	186515	838b4ff5	\N	高戸橋交差点	https://image.anitabi.cn/points/186515/838b4ff5_1722414036731.jpg?plan=h160	4	613	35.7143000	139.7114000	0101000020E6100000FBCBEEC9C376614033C4B12E6EDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.714387%2C139.711472&z=17	2026-06-09 19:30:16.208924
1491	604826	a6pnqdk	\N	有限会社一心ハウジング	https://image.anitabi.cn/points/604826/a6pnqdk_1769184072644.jpg?plan=h160	\N	2852	35.7217000	139.4180000	0101000020E61000004C378941606D6140F8C264AA60DC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.332759
1256	51928	odxdfzdiv	味之素体育场	味の素​スタジアム	https://image.anitabi.cn/user/1099/bangumi/51928/points/odxdfzdiv-1726941679055.jpg?plan=h160	24	295	35.6641000	139.5270000	0101000020E6100000BE9F1A2FDD70614005A3923A01D54140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.992657
1492	604826	a6ra96s	\N	立川タクロス	https://image.anitabi.cn/points/604826/a6ra96s_1769187019477.jpg?plan=h160	\N	4523	35.6987000	139.4128000	0101000020E61000003E7958A8356D61408CDB68006FD94140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.382973
1462	186515	ssqsygyf4	江户川公园 滑梯	江戸川公園	https://image.anitabi.cn/user/0/bangumi/186515/points/ssqsygyf4-1739387008450.jpg?plan=h160	11	989	35.7104000	139.7265000	0101000020E61000006891ED7C3F776140098A1F63EEDA4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:32.614758
1493	604826	e7uqfui	\N	東急ストア 立川駅南口店	https://image.anitabi.cn/points/604826/e7uqfui_1777960200530.jpg?plan=h160	\N	4572	35.6960000	139.4130000	0101000020E6100000F0A7C64B376D61400C022B8716D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-11 14:48:47.432753
1494	604826	a6rv8wb	\N	南口ビル	https://image.anitabi.cn/points/604826/a6rv8wb_1769187830034.jpg?plan=h160	\N	5370	35.6972000	139.4122000	0101000020E610000029ED0DBE306D6140B7627FD93DD94140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.480864
1495	604826	a5kljae	\N	武藏野线	https://image.anitabi.cn/points/604826/a5kljae_1769115191640.jpg?plan=h160	\N	5382	35.8450000	139.8856000	0101000020E6100000CEAACFD5567C61405C8FC2F528EC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.528771
1474	186515	74fcadef	\N	山吹高校裏	https://image.anitabi.cn/points/186515/74fcadef_1722414081853.jpg?plan=h160	\N	\N	35.7063000	139.7283000	0101000020E6100000A835CD3B4E7761401895D40968DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.706302%2C139.728344&z=17	2026-06-09 19:30:37.191956
1496	604826	a5kiq1x	\N	三郷駅前	https://image.anitabi.cn/points/604826/a5kiq1x_1769114984040.jpg?plan=h160	\N	5387	35.8454000	139.8866000	0101000020E61000004694F6065F7C6140EA04341136EC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.577427
1497	604826	a5l1awr	\N	江戸川堤	https://image.anitabi.cn/points/604826/a5l1awr_1769115853781.jpg?plan=h160	\N	5394	35.8484000	139.8883000	0101000020E61000002D211FF46C7C614094F6065F98EC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.62814
1469	186515	u297pc	早大通り·山吹高校前路口	早大通り·山吹高校前路口	https://image.anitabi.cn/user/0/bangumi/186515/points/u297pc-1748828130687.jpg?plan=h160	11	1377	35.7073000	139.7287000	0101000020E61000000C93A98251776140FB3A70CE88DA4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:35.546712
1498	604826	a5l3e6u	\N	武蔵野線 江戸川橋梁	https://image.anitabi.cn/points/604826/a5l3e6u_1769115945355.jpg?plan=h160	\N	5397	35.8445000	139.8899000	0101000020E6100000BC96900F7A7C61406ABC749318EC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.681208
517	216228	4ui7mhga5	\N	台湾料理「第一亭」	https://image.anitabi.cn/points/216228/4ui7mhga5.jpg?plan=h160	\N	\N	35.4455000	139.6280000	0101000020E61000006ABC7493187461401B2FDD2406B94140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.445505%2C139.628007&z=17	2026-05-10 10:50:10.981487
1499	604826	a5kuekq	\N	江戸川三郷幸手自転車道線	https://image.anitabi.cn/points/604826/a5kuekq_1769115571565.jpg?plan=h160	\N	5402	35.8483000	139.8885000	0101000020E6100000DF4F8D976E7C614031992A1895EC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.734044
1500	604826	a5l6v9r	\N	江戸川運動公園	https://image.anitabi.cn/points/604826/a5l6v9r_1769116126093.jpg?plan=h160	\N	5416	35.8491000	139.8890000	0101000020E61000009CC420B0727C61404D840D4FAFEC4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.782468
1501	604826	a5nlqqy	\N	柴崎町三丁目	https://image.anitabi.cn/points/604826/a5nlqqy_1769120161840.jpg?plan=h160	\N	5699	35.6922000	139.4104000	0101000020E6100000E9482EFF216D6140462575029AD84140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.831642
1502	604826	a6s6z3x	\N	国分寺高校入口（バス）	https://image.anitabi.cn/points/604826/a6s6z3x_1769188388791.jpg?plan=h160	\N	6617	35.7143000	139.4477000	0101000020E61000006A4DF38E536E614033C4B12E6EDB4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.882291
1503	604826	ah291cc	\N	赤坂みすじ通り	https://image.anitabi.cn/points/604826/ah291cc_1769809893671.jpg?plan=h160	\N	6944	35.6718000	139.7384000	0101000020E6100000BA6B09F9A0776140F5B9DA8AFDD54140	Anitabi	https://anitabi.cn/	2026-06-11 14:48:47.931224
1504	604826	a5m3ly5	\N	東京ドーム	https://image.anitabi.cn/points/604826/a5m3ly5_1769117649369.jpg?plan=h160	\N	7773	35.7044000	139.7527000	0101000020E610000060764F1E16786140B5A679C729DA4140	Anitabi@澄蔦	https://anitabi.cn/	2026-06-11 14:48:47.981079
1439	186515	0ab72061	目白台二丁目，都道8号与都道437号交叉口	目白台二丁目（目白通り）	https://image.anitabi.cn/points/186515/0ab72061_1722414051792.jpg?plan=h160	9	1127	35.7167000	139.7182000	0101000020E610000097FF907EFB76614088855AD3BCDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.716781%2C139.718266&z=17	2026-06-09 19:30:20.598993
636	152091	s8m6n95va	\N	槇島町大島地蔵尊前	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8m6n95va-1737809542355.jpg?plan=h160	9	1350	34.8994000	135.8023000	0101000020E610000096B20C71ACF96040DE02098A1F734140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:42.10061
926	246429	unfnvl	飞鸟山公园·喷泉	飞鸟山公园·喷泉	https://image.anitabi.cn/user/0/bangumi/246429/points/unfnvl-1748863726973.jpg?plan=h160	11	680	35.7507000	139.7378000	0101000020E6100000A4DFBE0E9C776140B98D06F016E04140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:57.097759
1476	152091	emth9gw	\N	平等院表門西側	https://image.anitabi.cn/user/0/bangumi/152091/points/emth9gw-1778865075067.jpg?plan=h160	8	286	34.8901000	135.8066000	0101000020E6100000849ECDAACFF96040B515FBCBEE714140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:47.076993
1245	51928	pqbyisx27	星巴克 吉祥寺東急店	Starbucks Coffee - Kichijoji Tokyu	https://image.anitabi.cn/user/1099/bangumi/51928/points/pqbyisx27-1730734537478.jpg?plan=h160	4	519	35.7053000	139.5775000	0101000020E610000014AE47E17A72614035EF384547DA4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.211526
640	152091	s8naucehu	宇治公园前停车场	宇治公園	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8naucehu-1737811951482.jpg?plan=h160	6	1148	34.8881000	135.8087000	0101000020E6100000CE88D2DEE0F96040EFC9C342AD714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:44.759539
543	152091	kq4vhc59n	\N	莵道高 小舞台前	https://image.anitabi.cn/points/152091/kq4vhc59n_1716613525285.jpg?plan=h160	1	342	34.9098000	135.8162000	0101000020E6100000D95F764F1EFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:36.047368
1433	186515	de7606b6	\N	学習院下駅	https://image.anitabi.cn/points/186515/de7606b6_1722414039593.jpg?plan=h160	8	934	35.7166000	139.7126000	0101000020E610000026E4839ECD76614024287E8CB9DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.7166%2C139.712607&z=17	2026-06-09 19:30:16.633121
1461	186515	cae584a5	\N	武道館	https://image.anitabi.cn/points/186515/cae584a5_1722418426144.jpg?plan=h160	13	153	35.6930000	139.7492000	0101000020E610000039454772F977614062105839B4D84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.693043%2C139.749237&z=17	2026-06-09 19:30:32.338161
1241	51928	odvnwr45h	\N	昭和記念公園	https://image.anitabi.cn/user/1099/bangumi/51928/points/odvnwr45h-1726937564312.jpg?plan=h160	1	157	35.7029000	139.4023000	0101000020E6100000C9E53FA4DF6C6140E02D90A0F8D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:55.932307
1281	160209	al3yeri	\N	マンション桂	https://image.anitabi.cn/points/160209/al3yeri_1770054618536.jpg?plan=h160	1	291	35.6816000	139.7255000	0101000020E6100000F0A7C64B37776140107A36AB3ED74140	宇宇欣	\N	2026-06-08 19:55:47.452055
1282	160209	3ik9kj0e	\N	信濃町歩道橋	https://image.anitabi.cn/points/160209/3ik9kj0e.jpg?plan=h160	\N	145	35.6796000	139.7195000	0101000020E61000001B2FDD2406776140492EFF21FDD64140	@nekoumi	\N	2026-06-08 19:55:48.972737
1283	160209	3ik9kjew	\N	LABI新宿東口館前	https://image.anitabi.cn/points/160209/3ik9kjew.jpg?plan=h160	\N	197	35.6936000	139.7009000	0101000020E61000008638D6C56D766140B84082E2C7D84140	@nekoumi	\N	2026-06-08 19:55:50.20134
1284	160209	3ik9kjfp	\N	蜷川家具店	https://image.anitabi.cn/points/160209/3ik9kjfp.jpg?plan=h160	\N	448	35.8885000	140.4990000	0101000020E61000008716D9CEF78F61407D3F355EBAF14140	@nekoumi	\N	2026-06-08 19:55:51.906263
1285	160209	mlw8dfms1	糸守镇	立石公園	https://image.anitabi.cn/user/0/bangumi/160209/points/mlw8dfms1-1721923541791.jpg?plan=h160	\N	\N	36.0541000	138.1226000	0101000020E6100000ABCFD556EC436140575BB1BFEC064240	Anitabi	https://anitabi.cn/	2026-06-08 19:55:53.665645
1286	160209	3ik9kji0	\N	藤ノ木橋	https://image.anitabi.cn/points/160209/3ik9kji0.jpg?plan=h160	\N	462	35.5201000	137.8863000	0101000020E61000003C4ED1915C3C6140265305A392C24140	@nekoumi	\N	2026-06-08 19:55:54.864396
1287	160209	3ik9kjdk	\N	アイSHOP 石堂店	https://image.anitabi.cn/points/160209/3ik9kjdk.jpg?plan=h160	\N	660	30.5466000	130.9708000	0101000020E61000009E5E29CB105F60405DFE43FAED8B3E40	@nekoumi	\N	2026-06-08 19:55:56.281441
1288	160209	3ik9kj7v	\N	新海三社神社 神楽殿	https://image.anitabi.cn/points/160209/3ik9kj7v.jpg?plan=h160	\N	872	36.1959000	138.5121000	0101000020E610000003098A1F63506140A9A44E4013194240	@nekoumi	\N	2026-06-08 19:55:57.515002
1289	160209	3ik9kj50	\N	新宿駅南口	https://image.anitabi.cn/points/160209/3ik9kj50.jpg?plan=h160	\N	1201	35.6892000	139.7006000	0101000020E61000007CF2B0506B7661409C33A2B437D84140	@nekoumi	\N	2026-06-08 19:55:59.485353
1290	160209	3ik9kj6d	\N	新宿駅南口歩道橋	https://image.anitabi.cn/points/160209/3ik9kj6d.jpg?plan=h160	\N	1205	35.6890000	139.6999000	0101000020E61000000E4FAF9465766140D578E92631D84140	@nekoumi	\N	2026-06-08 19:56:01.129767
1291	160209	3ik9kiwd	\N	YUNIKA VISION	https://image.anitabi.cn/points/160209/3ik9kiwd.jpg?plan=h160	\N	1215	35.6938000	139.7002000	0101000020E61000001895D409687661407FFB3A70CED84140	@nekoumi	\N	2026-06-08 19:56:02.990699
1292	160209	3ik9kjf5	\N	Ladurée新宿店前	https://image.anitabi.cn/points/160209/3ik9kjf5.jpg?plan=h160	\N	1222	35.6893000	139.7008000	0101000020E61000002D211FF46C76614000917EFB3AD84140	@nekoumi	\N	2026-06-08 19:56:04.6914
1293	160209	3ik9kjmm	\N	基町高校	https://image.anitabi.cn/points/160209/3ik9kjmm.jpg?plan=h160	\N	1271	34.4040000	132.4597000	0101000020E6100000143FC6DCB58E6040C1CAA145B6334140	@nekoumi	\N	2026-06-08 19:56:06.863508
1294	160209	3ik9kjly	\N	Café La Boheme新宿御苑	https://image.anitabi.cn/points/160209/3ik9kjly.jpg?plan=h160	\N	1378	35.6874000	139.7127000	0101000020E61000007FFB3A70CE7661409CA223B9FCD74140	@nekoumi	\N	2026-06-08 19:56:09.214776
1295	160209	igqhj1y2x	\N	日枝神社	https://image.anitabi.cn/user/0/bangumi/160209/points/igqhj1y2x-1710234703037.jpg?plan=h160	\N	1794	36.1331000	137.2613000	0101000020E61000003C4ED1915C2861407E8CB96B09114240	Anitabi	https://anitabi.cn/	2026-06-08 19:56:10.945634
1296	160209	3ik9kj20	\N	新宿警察署裏交差点	https://image.anitabi.cn/points/160209/3ik9kj20.jpg?plan=h160	\N	1801	35.6926000	139.6939000	0101000020E610000039D6C56D34766140D49AE61DA7D84140	@nekoumi	\N	2026-06-08 19:56:13.197579
1297	160209	3ik9kjkg	\N	瀧の自宅付近	https://image.anitabi.cn/points/160209/3ik9kjkg.jpg?plan=h160	\N	1827	35.6816000	139.7259000	0101000020E61000005305A3923A776140107A36AB3ED74140	@nekoumi	\N	2026-06-08 19:56:16.476812
1298	160209	3ik9kjlm	\N	四ツ谷駅赤坂口広場前	https://image.anitabi.cn/points/160209/3ik9kjlm.jpg?plan=h160	\N	1831	35.6853000	139.7297000	0101000020E6100000857CD0B35977614072F90FE9B7D74140	@nekoumi	\N	2026-06-08 19:56:18.216192
1299	160209	3ik9kjfc	\N	Starbucks SHIBUYA TSUTAYA店	https://image.anitabi.cn/points/160209/3ik9kjfc.jpg?plan=h160	\N	1935	35.6597000	139.7004000	0101000020E6100000CAC342AD69766140EA95B20C71D44140	@nekoumi	\N	2026-06-08 19:56:20.414087
1300	160209	3ik9kjek	\N	四ツ谷駅遠景	https://image.anitabi.cn/points/160209/3ik9kjek.jpg?plan=h160	\N	2296	35.6810000	139.7317000	0101000020E6100000764F1E166A776140BA490C022BD74140	@nekoumi	\N	2026-06-08 19:56:21.669217
1301	160209	3ik9kj3z	\N	四ツ谷駅赤坂口	https://image.anitabi.cn/points/160209/3ik9kj3z.jpg?plan=h160	\N	2308	35.6853000	139.7301000	0101000020E6100000E8D9ACFA5C77614072F90FE9B7D74140	@nekoumi	\N	2026-06-08 19:56:22.871234
1302	160209	3ik9kj7l	\N	六本木ヒルズ展望台	https://image.anitabi.cn/points/160209/3ik9kj7l.jpg?plan=h160	\N	2353	35.6604000	139.7292000	0101000020E6100000C8073D9B55776140A323B9FC87D44140	@nekoumi	\N	2026-06-08 19:56:25.199943
1303	160209	3ik9kjcj	\N	国立新美術館	https://image.anitabi.cn/points/160209/3ik9kjcj.jpg?plan=h160	\N	2360	35.6652000	139.7262000	0101000020E61000005E4BC8073D7761404CA60A4625D54140	@nekoumi	\N	2026-06-08 19:56:26.513956
1304	160209	3ik9kjbk	\N	六本木ヒルズ	https://image.anitabi.cn/points/160209/3ik9kjbk.jpg?plan=h160	\N	2429	35.6628000	139.7304000	0101000020E6100000F31FD26F5F776140F7E461A1D6D44140	@nekoumi	\N	2026-06-08 19:56:27.935672
1305	160209	3ik9kj7p	\N	道路標識案内板	https://image.anitabi.cn/points/160209/3ik9kj7p.jpg?plan=h160	\N	2440	35.6795000	139.7197000	0101000020E6100000CC5D4BC807776140E5D022DBF9D64140	@nekoumi	\N	2026-06-08 19:56:29.129133
1306	160209	3ik9kjh1	\N	首都高出口信号機	https://image.anitabi.cn/points/160209/3ik9kjh1.jpg?plan=h160	\N	2475	35.6788000	139.7199000	0101000020E61000007E8CB96B097761402D431CEBE2D64140	@nekoumi	\N	2026-06-08 19:56:30.7952
1307	160209	3ik9kizz	\N	信濃町歩道橋からの遠景	https://image.anitabi.cn/points/160209/3ik9kizz.jpg?plan=h160	\N	2477	35.6794000	139.7197000	0101000020E6100000CC5D4BC80777614082734694F6D64140	@nekoumi	\N	2026-06-08 19:56:33.067905
1308	160209	3ik9kjeo	\N	信濃町駅前ドコモタワー遠景	https://image.anitabi.cn/points/160209/3ik9kjeo.jpg?plan=h160	\N	2479	35.6797000	139.7197000	0101000020E6100000CC5D4BC807776140AC8BDB6800D74140	@nekoumi	\N	2026-06-08 19:56:34.832048
1309	160209	3ik9kj5n	\N	明治神宮外苑	https://image.anitabi.cn/points/160209/3ik9kj5n.jpg?plan=h160	\N	2725	35.6750000	139.7195000	0101000020E61000001B2FDD24067761406666666666D64140	@nekoumi	\N	2026-06-08 19:56:36.523847
1310	160209	3ik9kixn	\N	渋谷駅西口歩道橋	https://image.anitabi.cn/points/160209/3ik9kixn.jpg?plan=h160	\N	2729	35.6571000	139.7006000	0101000020E61000007CF2B0506B766140CE1951DA1BD44140	@nekoumi	\N	2026-06-08 19:56:37.804361
1311	160209	3ik9kjlq	\N	東京駅	https://image.anitabi.cn/points/160209/3ik9kjlq.jpg?plan=h160	\N	2770	35.6810000	139.7641000	0101000020E6100000F5DBD78173786140BA490C022BD74140	@nekoumi	\N	2026-06-08 19:56:38.992302
1312	160209	3ik9kja4	\N	名古屋駅北通路 10·11番線入口	https://image.anitabi.cn/points/160209/3ik9kja4.jpg?plan=h160	\N	2834	35.1708000	136.8815000	0101000020E610000091ED7C3F351C614012143FC6DC954140	@nekoumi	\N	2026-06-08 19:56:40.19811
1313	160209	3ik9kjb0	\N	名古屋駅11番線	https://image.anitabi.cn/points/160209/3ik9kjb0.jpg?plan=h160	\N	2837	35.1711000	136.8814000	0101000020E610000039D6C56D341C61403D2CD49AE6954140	@nekoumi	\N	2026-06-08 19:56:41.341521
1314	160209	3ik9kjfi	\N	飛騨古川駅西北側跨線橋	https://image.anitabi.cn/points/160209/3ik9kjfi.jpg?plan=h160	\N	2850	36.2372000	137.1889000	0101000020E6100000DC4603780B2661403C4ED1915C1E4240	@nekoumi	\N	2026-06-08 19:56:43.102243
1315	160209	3ik9kjaa	\N	飛騨古川駅構内跨線橋	https://image.anitabi.cn/points/160209/3ik9kjaa.jpg?plan=h160	\N	2855	36.2367000	137.1898000	0101000020E6100000FC1873D7122661404A7B832F4C1E4240	@nekoumi	\N	2026-06-08 19:56:44.942048
1316	160209	3ik9kjli	\N	飛騨古川駅	https://image.anitabi.cn/points/160209/3ik9kjli.jpg?plan=h160	\N	2863	36.2366000	137.1896000	0101000020E61000004BEA043411266140E71DA7E8481E4240	@nekoumi	\N	2026-06-08 19:56:46.230958
1317	160209	3ik9kj2o	\N	飛騨古川駅タクシーロータリー	https://image.anitabi.cn/points/160209/3ik9kj2o.jpg?plan=h160	\N	2871	36.2367000	137.1893000	0101000020E610000040A4DFBE0E2661404A7B832F4C1E4240	@nekoumi	\N	2026-06-08 19:56:48.166222
1458	186515	2e4b0543	\N	飛鳥山駅	https://image.anitabi.cn/points/186515/2e4b0543_1722418422888.jpg?plan=h160	1	149	35.7502000	139.7373000	0101000020E6100000E86A2BF697776140C7BAB88D06E04140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.750206%2C139.737385&z=17	2026-06-09 19:30:31.124861
602	152091	kq7969m89	\N	朝雾桥	https://image.anitabi.cn/points/152091/kq7969m89_1716618706165.jpg?plan=h160	1	2432	34.8902000	135.8095000	0101000020E610000096438B6CE7F960401973D712F2714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:20.387399
610	152091	kq8wlwpqg	\N	アクトパル宇治 宿泊棟	https://image.anitabi.cn/points/152091/kq8wlwpqg_1716622288771.jpg?plan=h160	2	1125	34.9344000	135.8551000	0101000020E6100000E8D9ACFA5CFB6040F2B0506B9A774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:25.716368
1472	186515	4932b2c4	\N	面影橋駅	https://image.anitabi.cn/points/186515/4932b2c4_1722414034312.jpg?plan=h160	\N	\N	35.7130000	139.7141000	0101000020E61000005B423EE8D97661402506819543DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.713023%2C139.714174&z=17	2026-06-09 19:30:36.737616
1318	160209	3ik9kiyj	\N	氣多若宮神社参道	https://image.anitabi.cn/points/160209/3ik9kiyj.jpg?plan=h160	\N	2754	36.2391000	137.1960000	0101000020E610000083C0CAA1452661409F3C2CD49A1E4240	@nekoumi	\N	2026-06-08 19:56:49.532485
1319	160209	6dniv2e2d	车站地图	JR龍瑠駅	https://image.anitabi.cn/points/160209/6dniv2e2d_1726826529321_c16v9.jpg?plan=h160	\N	2860	36.1410000	137.2513000	0101000020E6100000832F4CA60A286140355EBA490C124240	Anitabi	https://anitabi.cn/	2026-06-08 19:56:51.511112
1320	160209	3ik9kjbn	\N	古川町	https://image.anitabi.cn/points/160209/3ik9kjbn.jpg?plan=h160	\N	2876	36.2378000	137.1969000	0101000020E6100000A3923A014D266140917EFB3A701E4240	@nekoumi	\N	2026-06-08 19:56:54.875226
1321	160209	3ik9kj9r	\N	味処古川	https://image.anitabi.cn/points/160209/3ik9kj9r.jpg?plan=h160	\N	2885	36.2357000	137.1852000	0101000020E610000004E78C28ED25614067D5E76A2B1E4240	@nekoumi	\N	2026-06-08 19:56:56.205811
1322	160209	3ik9kjic	\N	宮川落合のバス停	https://image.anitabi.cn/points/160209/3ik9kjic.jpg?plan=h160	\N	2898	36.3034000	137.1124000	0101000020E61000004182E2C7982361409FCDAACFD5264240	@nekoumi	\N	2026-06-08 19:56:57.902667
1323	160209	3ik9kize	\N	飛騨市図書館	https://image.anitabi.cn/points/160209/3ik9kize.jpg?plan=h160	\N	3102	36.2376000	137.1857000	0101000020E6100000C05B2041F1256140CAC342AD691E4240	@nekoumi	\N	2026-06-08 19:56:59.196379
1324	160209	oyotcvqsl	飞驒市图书馆	飞驒市图书馆	https://image.anitabi.cn/user/2111/bangumi/160209/points/oyotcvqsl-1728568419973.jpg?plan=h160	\N	3119	36.2380000	137.1855000	0101000020E61000000E2DB29DEF2561405839B4C8761E4240	Anitabi@双叶理央	https://anitabi.cn/	2026-06-08 19:57:01.00444
1325	160209	3ik9kjid	\N	民宿奥大井	https://image.anitabi.cn/points/160209/3ik9kjid.jpg?plan=h160	\N	3181	35.1516000	138.1462000	0101000020E61000009B559FABAD4461406C09F9A067934140	@nekoumi	\N	2026-06-08 19:57:02.931103
1326	160209	3ik9kjnm	\N	前田南駅	https://image.anitabi.cn/points/160209/3ik9kjnm.jpg?plan=h160	\N	4364	40.0506000	140.4024000	0101000020E610000022FDF675E08C6140BC96900F7A064440	@nekoumi	\N	2026-06-08 19:57:05.382922
1327	160209	3ik9kiwz	\N	表参道	https://image.anitabi.cn/points/160209/3ik9kiwz.jpg?plan=h160	\N	4418	35.6656000	139.7119000	0101000020E6100000B84082E2C7766140DA1B7C6132D54140	@nekoumi	\N	2026-06-08 19:57:07.87948
1328	160209	3ik9kj0a	\N	須賀神社男坂	https://image.anitabi.cn/points/160209/3ik9kj0a.jpg?plan=h160	\N	4447	35.6851000	139.7233000	0101000020E61000004CA60A4625776140AB3E575BB1D74140	@nekoumi	\N	2026-06-08 19:57:09.927687
1329	160209	3ik9kiw5	\N	代々木駅 三葉ベンチ	https://image.anitabi.cn/points/160209/3ik9kiw5.jpg?plan=h160	\N	4462	35.6849000	139.7019000	0101000020E6100000FF21FDF675766140E4839ECDAAD74140	@nekoumi	\N	2026-06-08 19:57:12.294061
1330	160209	7ayn8m5	\N	代々木駅	https://image.anitabi.cn/user/1065/bangumi/160209/points/7ayn8m5-1762910683656.jpg?plan=h160	\N	4465	35.6848000	139.7019000	0101000020E6100000FF21FDF6757661408126C286A7D74140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:57:14.740151
1331	160209	3ik9kjbs	\N	朝日橋	https://image.anitabi.cn/points/160209/3ik9kjbs.jpg?plan=h160	\N	4554	35.6815000	139.7261000	0101000020E6100000053411363C776140AC1C5A643BD74140	@nekoumi	\N	2026-06-08 19:57:16.072015
1332	160209	3ik9kj9a	\N	四ツ谷駅	https://image.anitabi.cn/points/160209/3ik9kj9a.jpg?plan=h160	\N	4566	35.6866000	139.7311000	0101000020E610000061C3D32B6577614080B74082E2D74140	@nekoumi	\N	2026-06-08 19:57:17.813429
1333	160209	3ik9kiwl	\N	かつらぎ町役場	https://image.anitabi.cn/points/160209/3ik9kiwl.jpg?plan=h160	\N	5074	34.2967000	135.5036000	0101000020E61000008048BF7D1DF06040925CFE43FA254140	@nekoumi	\N	2026-06-08 19:57:19.349011
1334	160209	3ik9kjg2	\N	新宿大ガード西	https://image.anitabi.cn/points/160209/3ik9kjg2.jpg?plan=h160	\N	5297	35.6938000	139.6991000	0101000020E61000004694F6065F7661407FFB3A70CED84140	@nekoumi	\N	2026-06-08 19:57:21.397273
1335	160209	3ik9kjei	\N	弁慶橋	https://image.anitabi.cn/points/160209/3ik9kjei.jpg?plan=h160	\N	5670	35.6790000	139.7363000	0101000020E61000006F8104C58F776140F4FDD478E9D64140	@nekoumi	\N	2026-06-08 19:57:23.239687
1336	160209	3ik9kj8y	\N	赤坂見附交差点北	https://image.anitabi.cn/points/160209/3ik9kj8y.jpg?plan=h160	\N	5675	35.6786000	139.7364000	0101000020E6100000C898BB96907761406688635DDCD64140	@nekoumi	\N	2026-06-08 19:57:24.570654
1337	160209	3ik9kjbc	\N	東急プラザ赤坂前歩道橋	https://image.anitabi.cn/points/160209/3ik9kjbc.jpg?plan=h160	\N	5682	35.6776000	139.7370000	0101000020E6100000DD2406819577614082E2C798BBD64140	@nekoumi	\N	2026-06-08 19:57:26.324304
1338	160209	3ik9kj3i	\N	東急プラザ赤坂前	https://image.anitabi.cn/points/160209/3ik9kj3i.jpg?plan=h160	\N	5684	35.6779000	139.7370000	0101000020E6100000DD24068195776140ADFA5C6DC5D64140	@nekoumi	\N	2026-06-08 19:57:28.094275
1339	160209	3ik9kjn5	\N	首都高高架下	https://image.anitabi.cn/points/160209/3ik9kjn5.jpg?plan=h160	\N	5687	35.6793000	139.7327000	0101000020E6100000EF384547727761401E166A4DF3D64140	@nekoumi	\N	2026-06-08 19:57:29.794543
1340	160209	3ik9kjgm	\N	弁慶橋からの遠景	https://image.anitabi.cn/points/160209/3ik9kjgm.jpg?plan=h160	\N	5710	35.6788000	139.7361000	0101000020E6100000BD5296218E7761402D431CEBE2D64140	@nekoumi	\N	2026-06-08 19:57:31.019371
1341	160209	3ik9kj0l	\N	紀之国坂交差点	https://image.anitabi.cn/points/160209/3ik9kj0l.jpg?plan=h160	\N	5720	35.6808000	139.7315000	0101000020E6100000C520B07268776140F38E537424D74140	@nekoumi	\N	2026-06-08 19:57:32.719027
1342	160209	3ik9kj25	\N	Starbucks新宿サザンテラス店 前	https://image.anitabi.cn/points/160209/3ik9kj25.jpg?plan=h160	\N	5786	35.6882000	139.7002000	0101000020E61000001895D40968766140B98D06F016D84140	@nekoumi	\N	2026-06-08 19:57:33.889682
1343	160209	3ik9kjgi	\N	新都心歩道橋遠景	https://image.anitabi.cn/points/160209/3ik9kjgi.jpg?plan=h160	\N	5826	35.6936000	139.6977000	0101000020E61000006A4DF38E53766140B84082E2C7D84140	@nekoumi	\N	2026-06-08 19:57:35.285939
1344	160209	3ik9kjix	\N	新都心歩道橋	https://image.anitabi.cn/points/160209/3ik9kjix.jpg?plan=h160	\N	5840	35.6933000	139.6973000	0101000020E610000007F01648507661408D28ED0DBED84140	@nekoumi	\N	2026-06-08 19:57:37.576119
1345	160209	3ik9kjb8	\N	北参道駅	https://image.anitabi.cn/points/160209/3ik9kjb8.jpg?plan=h160	\N	5944	35.6789000	139.7050000	0101000020E6100000C3F5285C8F76614090A0F831E6D64140	@nekoumi	\N	2026-06-08 19:57:38.804438
1346	160209	3ik9kj5p	\N	千駄ヶ谷駅	https://image.anitabi.cn/points/160209/3ik9kj5p.jpg?plan=h160	\N	5972	35.6809000	139.7110000	0101000020E6100000986E1283C076614057EC2FBB27D74140	@nekoumi	\N	2026-06-08 19:57:40.240649
1347	160209	3ik9kjcb	\N	新宿LUMINE2前	https://image.anitabi.cn/points/160209/3ik9kjcb.jpg?plan=h160	\N	5975	35.6893000	139.7011000	0101000020E6100000386744696F76614000917EFB3AD84140	@nekoumi	\N	2026-06-08 19:57:41.54905
1348	160209	3ik9kjj8	\N	信濃町駅前交差点	https://image.anitabi.cn/points/160209/3ik9kjj8.jpg?plan=h160	\N	5979	35.6802000	139.7194000	0101000020E6100000C2172653057761409E5E29CB10D74140	@nekoumi	\N	2026-06-08 19:57:45.404748
1349	160209	3ik9kjai	\N	円通寺坂	https://image.anitabi.cn/points/160209/3ik9kjai.jpg?plan=h160	\N	5982	35.6873000	139.7227000	0101000020E6100000371AC05B2077614039454772F9D74140	@nekoumi	\N	2026-06-08 19:57:47.181329
1350	160209	3ik9kiyi	\N	須賀神社入口	https://image.anitabi.cn/points/160209/3ik9kiyi.jpg?plan=h160	\N	5984	35.6857000	139.7238000	0101000020E6100000091B9E5E29776140006F8104C5D74140	@nekoumi	\N	2026-06-08 19:57:48.520187
1351	160209	3ik9kiws	\N	四谷二丁目交差点南	https://image.anitabi.cn/points/160209/3ik9kiws.jpg?plan=h160	\N	5988	35.6872000	139.7248000	0101000020E61000008104C58F31776140D5E76A2BF6D74140	@nekoumi	\N	2026-06-08 19:57:50.210388
1352	160209	3ik9kjl1	\N	円通寺坂ポスト	https://image.anitabi.cn/points/160209/3ik9kjl1.jpg?plan=h160	\N	5988	35.6865000	139.7225000	0101000020E610000085EB51B81E7761401D5A643BDFD74140	@nekoumi	\N	2026-06-08 19:57:51.889267
638	152091	s8mrlpoo9	幸荣堂三室户店	幸栄堂 三室戸店	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8mrlpoo9-1737810999799.jpg?plan=h160	9	732	34.8979000	135.8076000	0101000020E6100000FD87F4DBD7F96040098A1F63EE724140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:43.429619
1353	160209	3ik9kj2f	\N	東福院坂	https://image.anitabi.cn/points/160209/3ik9kj2f.jpg?plan=h160	\N	5989	35.6860000	139.7240000	0101000020E6100000BA490C022B7761402B8716D9CED74140	@nekoumi	\N	2026-06-08 19:57:53.054575
675	283643	jyqu17je3	\N	宇治橋東詰	https://image.anitabi.cn/points/283643/jyqu17je3_1714467129942.jpg?plan=h160	1	136	34.8934000	135.8070000	0101000020E6100000E7FBA9F1D2F960408A1F63EE5A724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:15.377173
1354	160209	3ik9kj2l	\N	四谷見附橋	https://image.anitabi.cn/points/160209/3ik9kj2l.jpg?plan=h160	\N	5988	35.6855000	139.7304000	0101000020E6100000F31FD26F5F77614039B4C876BED74140	@nekoumi	\N	2026-06-08 19:57:54.694481
588	152091	kq79znyru	\N	久美子椅 对岸 远眺 回忆 黄昏	https://image.anitabi.cn/points/152091/kq79znyru_1716618756333.jpg?plan=h160	1	2469	34.8898000	135.8087000	0101000020E6100000CE88D2DEE0F960408BFD65F7E4714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:11.480018
1355	160209	3ik9kjax	\N	四谷四丁目交差点	https://image.anitabi.cn/points/160209/3ik9kjax.jpg?plan=h160	\N	5990	35.6877000	139.7159000	0101000020E61000009BE61DA7E8766140C7BAB88D06D84140	@nekoumi	\N	2026-06-08 19:57:56.434577
1356	160209	7b6sp0r	\N	タワーレコード 渋谷店	https://image.anitabi.cn/user/1065/bangumi/160209/points/7b6sp0r-1762924380529.jpg?plan=h160	\N	142	35.6618000	139.7011000	0101000020E6100000386744696F766140143FC6DCB5D44140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:57:58.162132
1357	160209	7b6h2pw	\N	新宿センタービル	https://image.anitabi.cn/user/1065/bangumi/160209/points/7b6h2pw-1762923840053.jpg?plan=h160	\N	144	35.6909000	139.6964000	0101000020E6100000E71DA7E848766140386744696FD84140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:58:00.045849
1473	186515	bbb617ac	\N	江戸川公園・遊具付近	https://image.anitabi.cn/points/186515/bbb617ac_1722414077428.jpg?plan=h160	\N	\N	35.7104000	139.7265000	0101000020E61000006891ED7C3F776140098A1F63EEDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.710495%2C139.726522&z=17	2026-06-09 19:30:36.943616
1358	160209	2wza4k3	泷 的家	離宮ハイム	https://image.anitabi.cn/user/0/bangumi/160209/points/2wza4k3-1753358199451.jpg?plan=h160	\N	1161	35.6819000	139.7260000	0101000020E6100000AC1C5A643B7761403A92CB7F48D74140	Anitabi	https://anitabi.cn/	2026-06-08 19:58:02.36047
620	152091	kq93wmho6	\N	アクトパル宇治（未确定）	https://image.anitabi.cn/points/152091/kq93wmho6_1716622735636.jpg?plan=h160	3	127	34.9341000	135.8559000	0101000020E6100000AF94658863FB6040C898BB9690774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:31.958318
1359	160209	7b0zia7	\N	新宿駅 远景	https://image.anitabi.cn/user/1065/bangumi/160209/points/7b0zia7-1762914636500.jpg?plan=h160	\N	1210	35.6923000	139.6997000	0101000020E61000005C2041F163766140AA8251499DD84140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:58:03.694634
1360	160209	7b191rb	\N	東京駅 新干线站台	https://image.anitabi.cn/user/1065/bangumi/160209/points/7b191rb-1762915095799.jpg?plan=h160	\N	2786	35.6791000	139.7671000	0101000020E61000005F984C158C786140575BB1BFECD64140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:58:04.857807
1361	160209	3ik9kjf9	\N	松原湖、大月湖	https://image.anitabi.cn/user/0/bangumi/160209/points/3ik9kjf9-1727713899280.jpg?plan=h160	\N	5510	36.0524000	138.4557000	0101000020E610000031992A18954E6140BB270F0BB5064240	@nekoumi	\N	2026-06-08 19:58:06.248156
1362	160209	35breqh	\N	首都高速4号新宿線高架下	https://image.anitabi.cn/user/0/bangumi/160209/points/35breqh-1753862798742.jpg?plan=h160	\N	5691	35.6792000	139.7328000	0101000020E61000004850FC1873776140BBB88D06F0D64140	ckrito	\N	2026-06-08 19:58:10.036267
1363	160209	7ay12gr	\N	惠比寿花园广场展望台	https://image.anitabi.cn/user/1065/bangumi/160209/points/7ay12gr-1762909948632.jpg?plan=h160	\N	5899	35.6420000	139.7134000	0101000020E6100000ED9E3C2CD47661401904560E2DD24140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:58:12.289202
637	152091	4xv3m4i	京阪三室户站	三室戸駅	https://image.anitabi.cn/points/152091/4xv3m4i_1757765102569.jpg?plan=h160	10	122	34.8986000	135.8064000	0101000020E6100000D26F5F07CEF96040C217265305734140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:42.714949
1364	160209	7b307zt	\N	新宿駅南口券壳機横	https://image.anitabi.cn/user/1065/bangumi/160209/points/7b307zt-1762918013147.jpg?plan=h160	\N	5971	35.6893000	139.7003000	0101000020E610000071AC8BDB6876614000917EFB3AD84140	Anitabi@真手凛	https://anitabi.cn/	2026-06-08 19:58:13.929504
1365	160209	3ik9kj22	\N	須賀神社男坂上	https://image.anitabi.cn/points/160209/3ik9kj22.jpg?plan=h160	\N	6018	35.6850000	139.7233000	0101000020E61000004CA60A462577614048E17A14AED74140	@nekoumi	\N	2026-06-08 19:58:15.361254
1366	160209	s2ov98ga7	NTT都科摩代代木大厦	NTT​ドコモ​代々木​ビル	https://image.anitabi.cn/user/0/bangumi/160209/points/s2ov98ga7-1737345398222.jpg?plan=h160	\N	\N	35.6843000	139.7031000	0101000020E61000002A3A92CB7F7661408F53742497D74140	Anitabi	https://anitabi.cn/	2026-06-08 19:58:16.590723
1367	160209	oswv2pmim	上諏訪変電所	上諏訪変電所	https://image.anitabi.cn/user/0/bangumi/160209/points/oswv2pmim-1728115790646.jpg?plan=h160	\N	\N	36.0476000	138.1203000	0101000020E6100000AEB6627FD943614012A5BDC117064240	Anitabi	https://anitabi.cn/	2026-06-08 19:58:19.314021
1368	160209	p400zwhda	有与真实世界位置关联的糸守湖圆心	36°20'43.3"N 137°15'08.0"E	https://image.anitabi.cn/user/0/bangumi/160209/points/p400zwhda-1728984672718.jpg?plan=h160	\N	\N	36.3443000	137.2522000	0101000020E6100000A301BC0512286140A301BC05122C4240	Anitabi	https://anitabi.cn/	2026-06-08 19:58:20.993977
1369	160209	9ywpt3w	須賀神社	須賀神社男坂上	https://image.anitabi.cn/user/0/bangumi/160209/points/9ywpt3w-1768712213389.jpg?plan=h160	\N	\N	35.6850000	139.7232000	0101000020E6100000F38E53742477614048E17A14AED74140	Anitabi	https://anitabi.cn/	2026-06-08 19:58:23.246143
1370	160209	ck8niwg	Nitori	ニトリ	https://image.anitabi.cn/user/0/bangumi/160209/points/ck8niwg-1774355612822.jpg?plan=h160	\N	5605	35.6859000	139.7024000	0101000020E6100000BC96900F7A766140C7293A92CBD74140	Anitabi	https://anitabi.cn/	2026-06-08 19:58:24.475821
1371	160209	ck8rzyc	\N	新青山東急ビル	https://image.anitabi.cn/user/0/bangumi/160209/points/ck8rzyc-1774355811039.jpg?plan=h160	\N	160	35.6662000	139.7140000	0101000020E6100000022B8716D9766140304CA60A46D54140	Anitabi	https://anitabi.cn/	2026-06-08 19:58:25.703704
605	152091	kq81par0h	\N	山城综合运动公园	https://image.anitabi.cn/points/152091/kq81par0h_1716620438057.jpg?plan=h160	2	210	34.8695000	135.8046000	0101000020E610000092CB7F48BFF960409EEFA7C64B6F4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:22.334489
708	283643	l2m6i6jwg	宇治市综合野外活动中心·Actpal宇治	アクトパル宇治	https://image.anitabi.cn/points/283643/l2m6i6jwg_1717591566716.jpg?plan=h160	9	184	34.9336000	135.8562000	0101000020E6100000BADA8AFD65FB6040D6C56D3480774140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:36.573231
721	283643	p9ml3d6z9	\N	アコウの木	https://image.anitabi.cn/user/0/bangumi/283643/points/p9ml3d6z9-1729425563085.jpg?plan=h160	13	1053	35.1303000	136.8990000	0101000020E610000054E3A59BC41C61409B559FABAD904140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:44.458728
1376	326895	5plrhtvx	\N	レンガ倉庫付近②	https://image.anitabi.cn/points/326895/5plrhtvx.jpg?plan=h160	3	478	34.2742000	135.0729000	0101000020E61000001C7C613255E26040174850FC18234140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.274266%2C135.072916&z=17	2026-06-08 20:01:02.274434
1389	326895	tmcmebsqd	\N	キシモト商店付近	https://image.anitabi.cn/user/0/bangumi/326895/points/tmcmebsqd-1741706924335.jpg?plan=h160	3	1015	34.2754000	135.0745000	0101000020E6100000AAF1D24D62E26040C1A8A44E40234140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:25.884276
1383	326895	5plrhv7c	\N	男木港①	https://image.anitabi.cn/points/326895/5plrhv7c.jpg?plan=h160	1	162	34.4220000	134.0539000	0101000020E610000024287E8CB9C16040BC74931804364140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.422068%2C134.05393&z=17	2026-06-08 20:01:14.357932
1374	326895	5plrht8v	\N	第４砲台跡	https://image.anitabi.cn/points/326895/5plrht8v.jpg?plan=h160	6	1185	34.2842000	135.0147000	0101000020E61000000A68226C78E06040F8C264AA60244140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.284275%2C135.014708&z=17	2026-06-08 20:00:58.094976
1382	326895	5plrhu4w	\N	田野の集落　俯瞰	https://image.anitabi.cn/points/326895/5plrhu4w.jpg?plan=h160	1	996	34.1861000	135.1535000	0101000020E6100000F4FDD478E9E460408FE4F21FD2174140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.186164%2C135.153503&z=17	2026-06-08 20:01:12.514214
1372	326895	5plrht1r	\N	第２砲台跡	https://image.anitabi.cn/points/326895/5plrht1r.jpg?plan=h160	1	1287	34.2822000	135.0005000	0101000020E6100000BC74931804E0604032772D211F244140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.282216%2C135.000508&z=17	2026-06-08 20:00:54.86457
1385	326895	svrfqp568	\N	Y字路	https://image.anitabi.cn/user/0/bangumi/326895/points/svrfqp568-1739623379504.jpg?plan=h160	1	1120	34.2743000	135.0704000	0101000020E61000006E3480B740E260407AA52C431C234140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:18.453663
1373	326895	5plrht7x	\N	砲台跡へ続く道	https://image.anitabi.cn/points/326895/5plrht7x.jpg?plan=h160	2	962	34.2839000	135.0033000	0101000020E610000075029A081BE06040CEAACFD556244140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.28395%2C135.003306&z=17	2026-06-08 20:00:56.646308
1378	326895	5plrhuin	\N	民宿なかむら	https://image.anitabi.cn/points/326895/5plrhuin.jpg?plan=h160	3	509	34.2757000	135.0732000	0101000020E610000027C286A757E26040ECC039234A234140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.275726%2C135.073289&z=17	2026-06-08 20:01:05.872243
1387	326895	svs35635c	和歌山市站3站台	和歌山市駅三のりば	https://image.anitabi.cn/user/0/bangumi/326895/points/svs35635c-1739624796422.jpg?plan=h160	2	165	34.2366000	135.1667000	0101000020E6100000C8073D9B55E56040E71DA7E8481E4140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:21.713384
1375	326895	5plrhu2q	\N	レンガ倉庫付近①	https://image.anitabi.cn/points/326895/5plrhu2q.jpg?plan=h160	3	137	34.2743000	135.0727000	0101000020E61000006A4DF38E53E260407AA52C431C234140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.27433%2C135.07271&z=17	2026-06-08 20:01:00.431005
1377	326895	5plrhu26	\N	加太小学校前	https://image.anitabi.cn/points/326895/5plrhu26.jpg?plan=h160	3	853	34.2736000	135.0762000	0101000020E6100000917EFB3A70E26040C217265305234140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.273697%2C135.076205&z=17	2026-06-08 20:01:03.716668
1390	326895	3qxt7gf	观光处	觀光案內所	https://image.anitabi.cn/user/0/bangumi/326895/points/3qxt7gf-1755169658605.jpg?plan=h160	\N	\N	34.2748000	135.0795000	0101000020E6100000068195438BE260406C787AA52C234140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:28.080621
1381	326895	5plrhuhh	\N	田ノ浦漁港	https://image.anitabi.cn/points/326895/5plrhuhh.jpg?plan=h160	7	1085	34.1837000	135.1513000	0101000020E610000050FC1873D7E460403A234A7B83174140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.18373%2C135.151353&z=17	2026-06-08 20:01:11.08105
1379	326895	5plrhuka	\N	奥和歌大橋	https://image.anitabi.cn/points/326895/5plrhuka.jpg?plan=h160	5	572	34.1867000	135.1482000	0101000020E61000008D28ED0DBEE46040E4141DC9E5174140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.186751%2C135.148292&z=17	2026-06-08 20:01:07.343798
1388	326895	svs8ogoci	小嶋一商店	小嶋一商店	https://image.anitabi.cn/user/0/bangumi/326895/points/svs8ogoci-1739625233850.jpg?plan=h160	3	143	34.2744000	135.0707000	0101000020E6100000787AA52C43E26040DE02098A1F234140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:24.095134
1384	326895	5plrhvat	\N	和歌山市駅前	https://image.anitabi.cn/points/326895/5plrhvat.jpg?plan=h160	2	148	34.2360000	135.1675000	0101000020E61000008FC2F5285CE5604091ED7C3F351E4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.236026%2C135.167572&z=17	2026-06-08 20:01:16.97596
1380	326895	5plrhubh	\N	雑賀崎漁港	https://image.anitabi.cn/points/326895/5plrhubh.jpg?plan=h160	2	501	34.1890000	135.1476000	0101000020E6100000789CA223B9E46040D578E92631184140	Google Maps	https://www.google.com/maps/d/viewer?mid=1XJHh2X0aDTmINhAjRwX1fDvlzUURlbIE&ll=34.189073%2C135.147667&z=17	2026-06-08 20:01:09.583281
1386	326895	svrs3mipi	和歌山市站5站台	和歌山市駅5のりば	https://image.anitabi.cn/user/0/bangumi/326895/points/svrs3mipi-1739624115863.jpg?plan=h160	2	167	34.2364000	135.1661000	0101000020E6100000B37BF2B050E560402063EE5A421E4140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:19.856016
1391	328674	lllwwvnoy	\N	兵庫縣立美術館	https://image.anitabi.cn/points/328674/lllwwvnoy_1719079903840.jpg?plan=h160	\N	847	34.6986000	135.2186000	0101000020E6100000FB5C6DC5FEE66040287E8CB96B594140	Anitabi@AmaiAya	https://anitabi.cn/	2026-06-08 20:01:53.490888
1392	328674	oh714daj1	加古川市道新加古川左岸线	加古川市道新加古川左岸線	https://image.anitabi.cn/user/0/bangumi/328674/points/oh714daj1-1727197402850.jpg?plan=h160	\N	\N	34.7809000	134.8506000	0101000020E610000048BF7D1D38DB604024B9FC87F4634140	Anitabi	https://anitabi.cn/	2026-06-08 20:01:55.471998
641	152091	s8ngdtqtf	\N	京都宇治茶 丸宗 入江本店	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8ngdtqtf-1737812420879.jpg?plan=h160	6	1044	34.8890000	135.8055000	0101000020E6100000B29DEFA7C6F960406F1283C0CA714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:45.590262
724	283643	jywvy0frv	宇治市综合野外活动中心		https://image.anitabi.cn/points/283643/jywvy0frv_1714480302981.jpg?plan=h160	\N	76	34.9369000	135.8535000	0101000020E61000005A643BDF4FFB6040ABCFD556EC774140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:46.301769
649	152091	kq3s2s58i	\N	莵道高 小广场 芳文跳 OP	https://image.anitabi.cn/points/152091/kq3s2s58i_1716611146133.jpg?plan=h160	1	\N	34.9090000	135.8159000	0101000020E6100000CE1951DA1BFA60403108AC1C5A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:50.699137
668	152091	s8o6nenvt	\N	幸栄堂本店/飛び出し注意看板（铠冢霙）	https://image.anitabi.cn/user/0/bangumi/152091/points/s8o6nenvt-1753928261081.jpg?plan=h160	\N	\N	34.9050000	135.8077000	0101000020E6100000569FABADD8F96040A4703D0AD7734140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:06.684919
728	90880	m2lgs2bdn	\N	出町商店街 动画中玉子家望向大鲸鱼	https://image.anitabi.cn/points/90880/m2lgs2bdn_1720411147994.jpg?plan=h160	\N	375	35.0305000	135.7685000	0101000020E61000003BDF4F8D97F8604096438B6CE7834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:24.917156
729	90880	m2lfpts1e	\N	出町商店街 大鲸鱼 广角	https://image.anitabi.cn/points/90880/m2lfpts1e_1720411058079.jpg?plan=h160	\N	1092	35.0302000	135.7685000	0101000020E61000003BDF4F8D97F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:28.331281
730	90880	m2lexgtk9	\N	出町商店街 动画中玉子家前	https://image.anitabi.cn/points/90880/m2lexgtk9_1720411015814.jpg?plan=h160	\N	2092	35.0306000	135.7685000	0101000020E61000003BDF4F8D97F86040F9A067B3EA834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:29.462163
731	90880	m2lw41bqt	\N	出町商店街 反方向望向玉子家	https://image.anitabi.cn/points/90880/m2lw41bqt_1720412037318.jpg?plan=h160	\N	2927	35.0302000	135.7685000	0101000020E61000003BDF4F8D97F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:30.079984
1447	186515	f9f055d9	\N	ホテル椿山荘東京 石焼料理「木春堂」	https://image.anitabi.cn/points/186515/f9f055d9_1722414074049.jpg?plan=h160	11	914	35.7113000	139.7240000	0101000020E6100000BA490C022B77614089D2DEE00BDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.71139%2C139.72403&z=17	2026-06-09 19:30:24.776703
1393	1905	2rp7txh	\N	上田城跡公園	https://image.anitabi.cn/points/1905/2rp7txh_1745592223001.jpg?plan=h160	\N	\N	36.4037000	138.2444000	0101000020E61000008FE4F21FD247614096B20C71AC334240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.403797%2C138.244437&z=17	2026-06-08 20:02:33.000908
1394	1905	2rp7tz1	\N	上田駅	https://image.anitabi.cn/points/1905/2rp7tz1_1745592505992.jpg?plan=h160	\N	\N	36.3964000	138.2497000	0101000020E6100000F5B9DA8AFD4761403411363CBD324240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.396498%2C138.249736&z=17	2026-06-08 20:02:34.333051
1424	186515	acc3efa4	\N	サウンドスタジオノア三軒茶屋店	https://image.anitabi.cn/points/186515/acc3efa4_1722414024541.jpg?plan=h160	5	562	35.6402000	139.6748000	0101000020E6100000E86A2BF6977561401973D712F2D14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.640297%2C139.67481&z=17	2026-06-09 19:30:13.553749
1395	1905	2rp7tzy	\N	別所温泉	https://image.anitabi.cn/points/1905/2rp7tzy_1745592527833.jpg?plan=h160	\N	\N	36.3529000	138.1617000	0101000020E61000006C787AA52C4561401361C3D32B2D4240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.352966%2C138.161788&z=17	2026-06-08 20:02:36.792787
1396	1905	2rp7tzf	\N	伊勢山バス停	https://image.anitabi.cn/points/1905/2rp7tzf_1745592419409.jpg?plan=h160	\N	\N	36.4173000	138.2952000	0101000020E6100000EF38454772496140764F1E166A354240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.417311%2C138.295201&z=17	2026-06-08 20:02:38.018584
1397	1905	2rp7tyl	\N	砥石米山城跡	https://image.anitabi.cn/points/1905/2rp7tyl_1745592432164.jpg?plan=h160	\N	\N	36.4222000	138.2901000	0101000020E61000003A92CB7F48496140832F4CA60A364240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.422256%2C138.29016&z=17	2026-06-08 20:02:40.491257
1398	1905	2rp7txp	\N	海野町商店街	https://image.anitabi.cn/points/1905/2rp7txp_1745592408048.jpg?plan=h160	\N	\N	36.4001000	138.2540000	0101000020E6100000E3A59BC42048614097900F7A36334240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.400111%2C138.254002&z=17	2026-06-08 20:02:42.31939
1399	1905	2rp7ty5	\N	上田市役所	https://image.anitabi.cn/points/1905/2rp7ty5_1745592240809.jpg?plan=h160	\N	\N	36.4018000	138.2490000	0101000020E61000008716D9CEF747614033C4B12E6E334240	Google Maps	https://www.google.com/maps/d/viewer?mid=10xl98ZsURqEHQV_tsBnXvR0ptB8&ll=36.401865%2C138.249048&z=17	2026-06-08 20:02:47.234986
715	283643	llbiazdaq	纳屋町通	纳屋町通	https://image.anitabi.cn/points/283643/llbiazdaq_1720452364911.jpg?plan=h160	11	425	34.9317000	135.7598000	0101000020E610000007F0164850F8604073D712F241774140	Anitabi@MIKAI	https://anitabi.cn/	2026-05-10 11:22:40.667473
676	283643	jyw4abri7	\N	喜撰橋	https://image.anitabi.cn/points/283643/jyw4abri7_1714478625714.jpg?plan=h160	2	50	34.8880000	135.8098000	0101000020E6100000A089B0E1E9F960408B6CE7FBA9714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:15.994559
725	283643	ndgomevp8	\N	JR宇治駅	https://image.anitabi.cn/points/283643/ndgomevp8_1724083829797.jpg?plan=h160	\N	\N	34.8903000	135.8011000	0101000020E61000006B9A779CA2F960407DD0B359F5714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:47.015867
754	90880	m2ni467n6	\N	聖母女学院 门前	https://image.anitabi.cn/points/90880/m2ni467n6_1720415562495.jpg?plan=h160	\N	573	34.9585000	135.7711000	0101000020E6100000423EE8D9ACF86040A69BC420B07A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:56.468415
755	90880	m2nj3fv9t	\N	聖母女学院本館	https://image.anitabi.cn/points/90880/m2nj3fv9t_1720415610342.jpg?plan=h160	\N	2500	34.9588000	135.7720000	0101000020E610000062105839B4F86040D0B359F5B97A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:57.787258
756	90880	m2njiqp56	\N	京都站前	https://image.anitabi.cn/points/90880/m2njiqp56_1720415831649.jpg?plan=h160	\N	4625	34.9868000	135.7593000	0101000020E61000004A7B832F4CF86040AED85F764F7E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:59.104417
495	216228	4ui7mhgea	\N	居酒屋/焼き鳥屋「庄助」	https://image.anitabi.cn/points/216228/4ui7mhgea.jpg?plan=h160	\N	\N	35.6710000	139.7963000	0101000020E6100000C139234A7B796140D9CEF753E3D54140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.671068%2C139.796384&z=17	2026-05-10 10:49:56.847143
678	283643	kffmz640b	平等院前宇治停车场	平等院前宇治驻车場	https://image.anitabi.cn/points/283643/kffmz640b_1715774941274.jpg?plan=h160	5	1374	34.8880000	135.8088000	0101000020E610000027A089B0E1F960408B6CE7FBA9714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:17.239906
1417	186515	ea2950b8	\N	新宿駅東口 NewDays前	https://image.anitabi.cn/points/186515/ea2950b8_1722414016760.jpg?plan=h160	1	92	35.6915000	139.7011000	0101000020E6100000386744696F7661408D976E1283D84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.691555%2C139.701146&z=17	2026-06-09 19:30:09.101395
796	1424	25idmc2	\N	フレスコ修学院店	https://image.anitabi.cn/points/1424/25idmc2.jpg?plan=h160	\N	\N	35.0505000	135.7903000	0101000020E6100000ECC039234AF960405839B4C876864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.047466
1418	262939	rm4y7mg61	\N	マルエツプチ 汐留シオサイト店	https://image.anitabi.cn/user/2148/bangumi/262939/points/rm4y7mg61-1736048000785.jpg?plan=h160	\N	\N	35.6578000	139.7583000	0101000020E6100000D1915CFE4378614087A757CA32D44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:09.731378
526	152091	atdmu5ot3	\N	京坂六地藏前 リバティビル	https://image.anitabi.cn/user/1000/bangumi/152091/points/atdmu5ot3-1688656590089.jpg?plan=h160	9	154	34.9322000	135.7932000	0101000020E6100000FE65F7E461F9604065AA605452774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:24.382611
763	1424	s9cnrj5kf	\N	豊郷小学校3F	https://image.anitabi.cn/points/1424/s9cnrj5kf_1737867150212.jpg?plan=h160	20	1310	35.2034000	136.2328000	0101000020E61000004850FC1873076140D200DE02099A4140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:09.85561
1408	329906	51i52hww9	腓特烈大街	フリードリッヒ通り	https://image.anitabi.cn/points/329906/51i52hww9_1723709039219_half.jpg?plan=h160	\N	\N	52.5196000	13.3884000	0101000020E61000006688635DDCC62A403480B74082424A40	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=52.519698%2C13.388477&z=17	2026-06-09 19:30:07.707999
1420	262939	rm58q5ey7	东京帕克酒店	パークホテル 東京	https://image.anitabi.cn/user/2148/bangumi/262939/points/rm58q5ey7-1736048636991.jpg?plan=h160	\N	\N	35.6629000	139.7593000	0101000020E61000004A7B832F4C7861405B423EE8D9D44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:10.954528
1401	262939	rll9u54e7	\N	1 Chome 东新桥	https://image.anitabi.cn/user/2148/bangumi/262939/points/rll9u54e7-1736005249528.jpg?plan=h160	\N	\N	35.6644000	139.7609000	0101000020E6100000D8F0F44A5978614030BB270F0BD54140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:06.525593
1403	329906	51i52hx58	柏林中央车站	ベルリン中央駅	https://image.anitabi.cn/points/329906/51i52hx58_1723709046308_half.jpg?plan=h160	1	140	52.5250000	13.3694000	0101000020E6100000E9482EFF21BD2A403333333333434A40	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=52.525084%2C13.369402&z=17	2026-06-09 19:30:07.383385
781	1424	s9skh5d28	\N	石垣	https://image.anitabi.cn/points/1424/s9skh5d28_1737901779986.jpg?plan=h160	13	\N	35.0477000	135.7920000	0101000020E6100000D34D621058F9604075029A081B864140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.050416
1405	329906	51i52hxax	\N	SIS MI6	https://image.anitabi.cn/points/329906/51i52hxax_1723709056824_half.jpg?plan=h160	5	0	51.4872000	-0.1244000	0101000020E61000009B559FABADD8BFBF3C4ED1915CBE4940	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=51.487274%2C-0.12439&z=17	2026-06-09 19:30:07.539111
1400	329906	51i52hwh1	伊顿公学	イートン校	https://image.anitabi.cn/points/329906/51i52hwh1_1723709062293_half.jpg?plan=h160	4	136	51.4957000	-0.6045000	0101000020E6100000F2D24D621058E3BF4850FC1873BF4940	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=51.495736%2C-0.60444&z=17	2026-06-09 19:30:06.204152
1250	51928	odw5g59q2	\N	立川北駅	https://image.anitabi.cn/user/1099/bangumi/51928/points/odw5g59q2-1726938608548.jpg?plan=h160	11	889	35.7003000	139.4126000	0101000020E61000008C4AEA04346D6140C4B12E6EA3D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-06-07 11:13:56.565076
885	246429	rdxxu1	\N	学习院下停留场	https://image.anitabi.cn/user/0/bangumi/246429/points/rdxxu1-1748666365893.jpg?plan=h160	1	261	35.7159000	139.7123000	0101000020E61000001B9E5E29CB7661406B9A779CA2DB4140	Anitabi	https://anitabi.cn/	2026-05-24 11:02:54.19271
847	226540	n81fe4jkk	\N	多摩モノレール立川北駅下	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81fe4jkk-1723658805735.jpg?plan=h160	11	113	35.6990000	139.4134000	0101000020E61000005305A3923A6D6140B6F3FDD478D94140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.423841
861	2585	o3ujzi0u4	\N	朝日生命保険相互会社	https://image.anitabi.cn/user/1099/bangumi/2585/points/o3ujzi0u4-1726151487868.jpg?plan=h160	1	849	35.6229000	139.4223000	0101000020E61000003A234A7B836D6140D656EC2FBBCF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:31:47.427193
1402	329906	51i52hx8a	卢浮宫美术馆	ルーヴル美術館	https://image.anitabi.cn/points/329906/51i52hx8a_1723709052783_half.jpg?plan=h160	3	707	48.8606000	2.3376000	0101000020E61000006C09F9A067B3024003780B24286E4840	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=48.860611%2C2.337644&z=17	2026-06-09 19:30:06.825977
836	262940	l0n06yamn	三菱UFJ银行 立川支行	三菱UFJモルガン・スタンレー証券(株)立川支店	https://image.anitabi.cn/user/1099/bangumi/2585/points/l0n06yamn-1717436776657.jpg?plan=h160	15	1346	35.7011000	139.4140000	0101000020E61000006891ED7C3F6D6140E09C11A5BDD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:28.529039
850	226540	n81mq99d8	\N	立川駅北口	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81mq99d8-1723659236290.jpg?plan=h160	1	1016	35.6989000	139.4132000	0101000020E6100000A1D634EF386D61405396218E75D94140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.646981
1406	186515	8546c476	\N	旬八青果店 五反田店（トライアル店舗）	https://image.anitabi.cn/points/186515/8546c476_1722413929613.jpg?plan=h160	6	932	35.6247000	139.7196000	0101000020E6100000744694F606776140D5E76A2BF6CF4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.62476%2C139.719654&z=17	2026-06-09 19:30:07.539111
672	283643	jyx0b5vb2	羽戸山第三儿童公园	羽戸山第三児童公園	https://image.anitabi.cn/points/283643/jyx0b5vb2_1714480561878.jpg?plan=h160	1	170	34.9084000	135.8147000	0101000020E6100000A301BC0512FA6040DCD7817346744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:13.431591
1412	262939	rm4l4b78n	環二通り 步行道	環二通り 	https://image.anitabi.cn/user/2148/bangumi/262939/points/rm4l4b78n-1736047201588.jpg?plan=h160	\N	\N	35.6633000	139.7606000	0101000020E6100000CEAACFD556786140E9B7AF03E7D44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:08.215892
1413	329906	51i52hx16	霍亨索伦城堡	ホーエンツォレルン城	https://image.anitabi.cn/points/329906/51i52hx16_1723709024766_half.jpg?plan=h160	\N	\N	48.3235000	8.9674000	0101000020E6100000014D840D4FEF2140C520B07268294840	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=48.323559%2C8.967404&z=17	2026-06-09 19:30:08.595553
883	246429	umk0blzr5	新宿站东口 NewDays前	新宿駅東口 NewDays前	https://image.anitabi.cn/points/186515/ea2950b8_1722414016760.jpg?plan=h160	1	91	35.6915000	139.7011000	0101000020E6100000386744696F7661408D976E1283D84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.691555%2C139.701146&z=17	2026-05-24 11:02:54.044313
869	2585	5zexhd6	\N	立川站南外的人行天桥	https://image.anitabi.cn/user/0/bangumi/2585/points/5zexhd6-1760035742419.jpg?plan=h160	4	545	35.6969000	139.4130000	0101000020E6100000F0A7C64B376D61408C4AEA0434D94140	Anitabi	https://anitabi.cn/	2026-05-17 10:31:47.982644
787	1424	kvbg27gdv	\N	西木屋町通	https://image.anitabi.cn/user/1083/bangumi/1424/points/kvbg27gdv-1717019671718.jpg?plan=h160	14	\N	35.0081000	135.7703000	0101000020E61000007B832F4CA6F860407E8CB96B09814140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.445182
1	400602	mlgnltjx4	\N	苍月草花海	https://image.anitabi.cn/user/1108/bangumi/400602/points/mlgnltjx4-1721890034274.jpg?plan=h160	\N	\N	36.4038000	140.6003000	0101000020E61000003E7958A835936140F90FE9B7AF334240	Anitabi@鸟之诗	https://anitabi.cn/	2026-04-26 11:25:26.992731
2	548818	bjy4gks	\N	愛・地球博記念公園 アイススケート場	https://image.anitabi.cn/user/1073/bangumi/548818/points/bjy4gks-1772161568376.jpg?plan=h160	5	906	35.1749000	137.0888000	0101000020E610000050FC1873D722614003098A1F63964140	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:47.828153
3	548818	bjyx2ma	\N	愛・地球博記念公園 アイススケート場　ゲート	https://image.anitabi.cn/user/1073/bangumi/548818/points/bjyx2ma-1772162519382.jpg?plan=h160	5	990	35.1740000	137.0889000	0101000020E6100000A913D044D822614083C0CAA145964140	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:47.947135
4	548818	bjyz5xg	\N	愛・​地球​博​記念​公園​アイス​スケート場　場内	https://image.anitabi.cn/user/1073/bangumi/548818/points/bjyz5xg-1772162568916.jpg?plan=h160	5	1287	35.1743000	137.0885000	0101000020E610000046B6F3FDD4226140AED85F764F964140	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:48.058415
5	548818	bycjajy	\N	諏訪湖SA 上り	https://image.anitabi.cn/user/1073/bangumi/548818/points/bycjajy-1773031876573.jpg?plan=h160	7	965	36.0265000	138.0775000	0101000020E610000014AE47E17A42614008AC1C5A64034240	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:48.179077
6	548818	bydcbvn	\N	諏訪湖SA 展望ウッドデッキ	https://image.anitabi.cn/user/1073/bangumi/548818/points/bydcbvn-1773033250671.jpg?plan=h160	7	1267	36.0271000	138.0776000	0101000020E61000006DC5FEB27B4261405DDC460378034240	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:48.306175
7	548818	ckecmt4	\N	屏風山 パーキングエリア (上り)	https://image.anitabi.cn/user/1073/bangumi/548818/points/ckecmt4-1774365243761.jpg?plan=h160	7	820	35.3970000	137.2755000	0101000020E6100000894160E5D0286140894160E5D0B24140	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:48.395831
8	548818	cketbu6	Flat八户	フラット八戸	https://image.anitabi.cn/user/1073/bangumi/548818/points/cketbu6-1774365952294.jpg?plan=h160	9	834	40.5116000	141.4279000	0101000020E6100000AB3E575BB1AD61401A51DA1B7C414440	Anitabi@月即别	https://anitabi.cn/	2026-04-26 11:25:48.502532
11	115908	7eyih3xg	\N	莵道高	https://image.anitabi.cn/points/115908/7eyih3xg.jpg?plan=h160	1	147	34.9089000	135.8157000	0101000020E61000001CEBE2361AFA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:20.789311
12	115908	7jni2zmz	\N	莵道高 正门 拂晓	https://image.anitabi.cn/points/115908/7jni2zmz.jpg?plan=h160	5	764	34.9089000	135.8157000	0101000020E61000001CEBE2361AFA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:21.697274
13	115908	7p4c142r	\N	莵道高 正门 清晨 雨	https://image.anitabi.cn/points/115908/7p4c142r.jpg?plan=h160	8	447	34.9089000	135.8156000	0101000020E6100000C3D32B6519FA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:22.319822
14	115908	kq10bkhew	\N	莵道高 正门 清晨 夏 更近	https://image.anitabi.cn/points/115908/kq10bkhew_1716605106659.jpg?plan=h160	11	553	34.9089000	135.8157000	0101000020E61000001CEBE2361AFA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:24.270925
15	115908	kq229b8cb	\N	莵道高 正门 清晨 夏	https://image.anitabi.cn/points/115908/kq229b8cb_1716607394132.jpg?plan=h160	12	553	34.9089000	135.8156000	0101000020E6100000C3D32B6519FA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:26.634485
16	115908	kq29r2enh	\N	莵道高 正门 早晨 夏	https://image.anitabi.cn/points/115908/kq29r2enh_1716607845853.jpg?plan=h160	12	739	34.9087000	135.8156000	0101000020E6100000C3D32B6519FA604007F0164850744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:27.241024
17	115908	kq2q99z04	\N	莵道高 正门 深夜	https://image.anitabi.cn/points/115908/kq2q99z04_1716608849669.jpg?plan=h160	12	1151	34.9087000	135.8156000	0101000020E6100000C3D32B6519FA604007F0164850744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:27.849547
18	115908	kq2tp6ejv	\N	莵道高 校门最近教学楼 入口 深夜	https://image.anitabi.cn/points/115908/kq2tp6ejv_1716609097495.jpg?plan=h160	12	1234	34.9093000	135.8161000	0101000020E61000008048BF7D1DFA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:28.465204
19	115908	7i05ja7x	\N	莵道高 正门外	https://image.anitabi.cn/points/115908/7i05ja7x.jpg?plan=h160	3	1172	34.9092000	135.8151000	0101000020E6100000075F984C15FA6040F8C264AA60744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:29.046008
20	115908	7f0igtsh	\N	莵道高 台阶	https://image.anitabi.cn/points/115908/7f0igtsh.jpg?plan=h160	1	164	34.9092000	135.8160000	0101000020E6100000273108AC1CFA6040F8C264AA60744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:32.728089
21	115908	kq1k32k44	\N	莵道高 （不确定位置）	https://image.anitabi.cn/points/115908/kq1k32k44_1716606294987.jpg?plan=h160	12	255	34.9101000	135.8167000	0101000020E610000095D4096822FA6040780B24287E744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:33.278505
877	246430	umk0bm2ak	明治大街	明治通り	https://image.anitabi.cn/points/186515/78e0cd5e_1722414043756.jpg?plan=h160	3	1063	35.7180000	139.7130000	0101000020E6100000894160E5D076614096438B6CE7DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.718%2C139.71301&z=17	2026-05-17 11:24:48.600541
22	115908	7i403165	\N	莵道高 花藤架	https://image.anitabi.cn/points/115908/7i403165.jpg?plan=h160	3	1231	34.9087000	135.8171000	0101000020E6100000F931E6AE25FA604007F0164850744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:34.300641
23	115908	7hbtnehw	\N	莵道高 楼梯	https://image.anitabi.cn/points/115908/7hbtnehw.jpg?plan=h160	2	1283	34.9092000	135.8160000	0101000020E6100000273108AC1CFA6040F8C264AA60744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:35.940576
24	115908	7hccn0f6	\N	莵道高 洗手台 特写	https://image.anitabi.cn/points/115908/7hccn0f6.jpg?plan=h160	2	1284	34.9099000	135.8163000	0101000020E610000032772D211FFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:36.863533
25	115908	7hcpx6v9	\N	莵道高 洗手台	https://image.anitabi.cn/points/115908/7hcpx6v9.jpg?plan=h160	2	1286	34.9099000	135.8163000	0101000020E610000032772D211FFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:37.480228
26	115908	7nr5owr4	\N	莵道高 走廊	https://image.anitabi.cn/points/115908/7nr5owr4.jpg?plan=h160	6	1085	34.9100000	135.8167000	0101000020E610000095D4096822FA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:38.400522
27	115908	7f16cujr	\N	莵道高 飞鸽雕塑 清晨	https://image.anitabi.cn/points/115908/7f16cujr.jpg?plan=h160	1	203	34.9093000	135.8160000	0101000020E6100000273108AC1CFA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:38.982674
28	115908	7i50ub7g	\N	莵道高 飞鸽雕塑 蓝调	https://image.anitabi.cn/points/115908/7i50ub7g.jpg?plan=h160	3	1258	34.9093000	135.8160000	0101000020E6100000273108AC1CFA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:40.042911
29	115908	7i6dcbzu	\N	莵道高 远眺南方	https://image.anitabi.cn/points/115908/7i6dcbzu.jpg?plan=h160	3	1279	34.9093000	135.8160000	0101000020E6100000273108AC1CFA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:40.656208
30	115908	7i33puko	\N	莵道高 网球场	https://image.anitabi.cn/points/115908/7i33puko.jpg?plan=h160	3	1200	34.9079000	135.8160000	0101000020E6100000273108AC1CFA6040EA04341136744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:41.575855
31	115908	7j6uhakv	\N	莵道高 操场	https://image.anitabi.cn/points/115908/7j6uhakv.jpg?plan=h160	5	309	34.9084000	135.8161000	0101000020E61000008048BF7D1DFA6040DCD7817346744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:42.803118
32	115908	7j9akckm	\N	莵道高 校外	https://image.anitabi.cn/points/115908/7j9akckm.jpg?plan=h160	5	500	34.9088000	135.8156000	0101000020E6100000C3D32B6519FA60406A4DF38E53744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:43.42357
33	115908	7j9raktu	\N	莵道高 操场 全景	https://image.anitabi.cn/points/115908/7j9raktu.jpg?plan=h160	5	518	34.9087000	135.8168000	0101000020E6100000EEEBC03923FA604007F0164850744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:44.443429
34	115908	7ja52vsc	\N	莵道高 操场 远眺 黄昏	https://image.anitabi.cn/points/115908/7ja52vsc.jpg?plan=h160	5	520	34.9086000	135.8169000	0101000020E61000004703780B24FA6040A3923A014D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:45.568942
35	115908	7jb364n5	\N	莵道高 校门旁 远眺	https://image.anitabi.cn/points/115908/7jb364n5.jpg?plan=h160	5	583	34.9089000	135.8158000	0101000020E610000075029A081BFA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:46.695436
38	115908	7f64bx84	\N	莵道高 远眺高速路 无人机视角	https://image.anitabi.cn/points/115908/7f64bx84.jpg?plan=h160	1	253	34.9101000	135.8166000	0101000020E61000003CBD529621FA6040780B24287E744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:49.628619
39	115908	7f8pdbfl	\N	莵道高 洗手间	https://image.anitabi.cn/points/115908/7f8pdbfl.jpg?plan=h160	1	299	34.9096000	135.8165000	0101000020E6100000E3A59BC420FA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:50.587259
40	115908	7fkyq9xx	\N	莵道高 小号练习教室	https://image.anitabi.cn/points/115908/7fkyq9xx.jpg?plan=h160	1	783	34.9099000	135.8164000	0101000020E61000008A8EE4F21FFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:51.202954
41	115908	7floa5xe	\N	莵道高 低音练习教室	https://image.anitabi.cn/points/115908/7floa5xe.jpg?plan=h160	1	798	34.9095000	135.8158000	0101000020E610000075029A081BFA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:52.841501
42	115908	7flb4yu3	\N	莵道高 长号练习教室	https://image.anitabi.cn/points/115908/7flb4yu3.jpg?plan=h160	1	786	34.9099000	135.8165000	0101000020E6100000E3A59BC420FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:54.478511
43	115908	7fm1cuv8	\N	莵道高 双簧管练习教室	https://image.anitabi.cn/points/115908/7fm1cuv8.jpg?plan=h160	1	803	34.9099000	135.8166000	0101000020E61000003CBD529621FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:55.097764
44	115908	7heyc82a	\N	莵道高 楼角	https://image.anitabi.cn/points/115908/7heyc82a.jpg?plan=h160	3	108	34.9098000	135.8167000	0101000020E610000095D4096822FA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:55.707106
45	115908	7oen6hn4	\N	莵道高 楼角 雨	https://image.anitabi.cn/points/115908/7oen6hn4.jpg?plan=h160	7	760	34.9097000	135.8168000	0101000020E6100000EEEBC03923FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:56.231238
46	115908	7oth2wb8	\N	莵道高 楼角 清晨	https://image.anitabi.cn/points/115908/7oth2wb8.jpg?plan=h160	7	1232	34.9097000	135.8167000	0101000020E610000095D4096822FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:56.836392
47	115908	7o47637e	\N	莵道高 (不确定)	https://image.anitabi.cn/points/115908/7o47637e.jpg?plan=h160	7	111	34.9098000	135.8167000	0101000020E610000095D4096822FA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:57.719613
48	115908	7o4fzer7	\N	莵道高 音乐室门口洗手台	https://image.anitabi.cn/points/115908/7o4fzer7.jpg?plan=h160	7	112	34.9099000	135.8166000	0101000020E61000003CBD529621FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:59.355999
49	115908	7f8jmztt	\N	莵道高 1-3	https://image.anitabi.cn/points/115908/7f8jmztt.jpg?plan=h160	1	302	34.9096000	135.8164000	0101000020E61000008A8EE4F21FFA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:00.007583
50	115908	7fap6ym8	\N	莵道高 1-3 久美子座位	https://image.anitabi.cn/points/115908/7fap6ym8.jpg?plan=h160	1	308	34.9096000	135.8164000	0101000020E61000008A8EE4F21FFA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:00.6203
51	115908	7fbvxi1i	\N	莵道高 1-3 走廊	https://image.anitabi.cn/points/115908/7fbvxi1i.jpg?plan=h160	1	461	34.9096000	135.8164000	0101000020E61000008A8EE4F21FFA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:01.238214
52	115908	7glezyf7	\N	莵道高 连接桥 全景 清晨	https://image.anitabi.cn/points/115908/7glezyf7.jpg?plan=h160	2	106	34.9097000	135.8166000	0101000020E61000003CBD529621FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:02.779586
53	115908	7fd2iokr	\N	莵道高 音乐室	https://image.anitabi.cn/points/115908/7fd2iokr.jpg?plan=h160	1	576	34.9099000	135.8167000	0101000020E610000095D4096822FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:03.742201
54	115908	7gmvruqk	\N	莵道高 连接桥	https://image.anitabi.cn/points/115908/7gmvruqk.jpg?plan=h160	2	136	34.9098000	135.8165000	0101000020E6100000E3A59BC420FA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:04.799813
55	115908	7hptln4p	\N	莵道高 3-3 远眺 视点	https://image.anitabi.cn/points/115908/7hptln4p.jpg?plan=h160	3	679	34.9098000	135.8160000	0101000020E6100000273108AC1CFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:06.150666
56	115908	7hfv718p	\N	莵道高 3-3	https://image.anitabi.cn/points/115908/7hfv718p.jpg?plan=h160	3	197	34.9099000	135.8159000	0101000020E6100000CE1951DA1BFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:06.765125
57	115908	7nslpz43	\N	莵道高 3-3 黄昏	https://image.anitabi.cn/points/115908/7nslpz43.jpg?plan=h160	6	1179	34.9095000	135.8158000	0101000020E610000075029A081BFA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:07.383128
58	115908	kq2g913lv	\N	莵道高 乐器仓库（不确定）	https://image.anitabi.cn/points/115908/kq2g913lv_1716608251462.jpg?plan=h160	12	913	34.9103000	135.8164000	0101000020E61000008A8EE4F21FFA60403FC6DCB584744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:08.300598
59	115908	kq2qrnplg	\N	莵道高 办公室（不确定）	https://image.anitabi.cn/points/115908/kq2qrnplg_1716608875105.jpg?plan=h160	12	4803	34.9102000	135.8164000	0101000020E61000008A8EE4F21FFA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:09.194644
60	115908	kq2r7bz4p	\N	莵道高 走廊（不确定）	https://image.anitabi.cn/points/115908/kq2r7bz4p_1716608908584.jpg?plan=h160	12	1175	34.9102000	135.8164000	0101000020E61000008A8EE4F21FFA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:09.810596
61	115908	7nx6ur0a	\N	莵道高 黄昏（不确定）	https://image.anitabi.cn/points/115908/7nx6ur0a.jpg?plan=h160	6	1202	34.9095000	135.8162000	0101000020E6100000D95F764F1EFA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:10.45538
62	115908	7hgdfxx4	\N	莵道高 腹吸练习	https://image.anitabi.cn/points/115908/7hgdfxx4.jpg?plan=h160	3	221	34.9094000	135.8164000	0101000020E61000008A8EE4F21FFA6040BF7D1D3867744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:11.072975
63	115908	7j44s9n3	\N	莵道高 连接桥下	https://image.anitabi.cn/points/115908/7j44s9n3.jpg?plan=h160	5	179	34.9094000	135.8164000	0101000020E61000008A8EE4F21FFA6040BF7D1D3867744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:11.684125
64	115908	7jp3sh35	\N	莵道高 停车场	https://image.anitabi.cn/points/115908/7jp3sh35.jpg?plan=h160	5	828	34.9097000	135.8153000	0101000020E6100000B98D06F016FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:12.60435
65	115908	7jpefc06	\N	莵道高 停车场 远眺	https://image.anitabi.cn/points/115908/7jpefc06.jpg?plan=h160	5	831	34.9099000	135.8153000	0101000020E6100000B98D06F016FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:13.494574
66	115908	kq0pfzaay	\N	莵道高 操场旁亭子	https://image.anitabi.cn/points/115908/kq0pfzaay_1716604493921.jpg?plan=h160	11	201	34.9095000	135.8166000	0101000020E61000003CBD529621FA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:14.142769
67	115908	7gwmulpx	\N	莵道高 小广场全景	https://image.anitabi.cn/points/115908/7gwmulpx.jpg?plan=h160	2	859	34.9092000	135.8162000	0101000020E6100000D95F764F1EFA6040F8C264AA60744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:15.062547
68	115908	7gorzc4a	\N	莵道高 楼梯（不确定位置）	https://image.anitabi.cn/points/115908/7gorzc4a.jpg?plan=h160	2	247	34.9097000	135.8164000	0101000020E61000008A8EE4F21FFA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:15.675074
69	115908	7ilrxqbw	\N	莵道高 3-3 远眺停车场	https://image.anitabi.cn/points/115908/7ilrxqbw.jpg?plan=h160	4	424	34.9096000	135.8158000	0101000020E610000075029A081BFA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:16.530146
70	115908	7in6cv0a	\N	莵道高 小天使练习场（未确定）	https://image.anitabi.cn/points/115908/7in6cv0a.jpg?plan=h160	4	462	34.9095000	135.8156000	0101000020E6100000C3D32B6519FA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:17.211887
71	115908	7iyi2p6q	\N	莵道高 垃圾处理场	https://image.anitabi.cn/points/115908/7iyi2p6q.jpg?plan=h160	4	823	34.9100000	135.8164000	0101000020E61000008A8EE4F21FFA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:17.793685
74	115908	kq1rhvi6y	\N	莵道高 保健室（还没找到位置）	https://image.anitabi.cn/points/115908/kq1rhvi6y_1716606751404.jpg?plan=h160	12	341	34.9103000	135.8163000	0101000020E610000032772D211FFA60403FC6DCB584744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:19.667935
75	115908	kq1sya82x	\N	莵道高 空中远眺 黄昏 无人机视角	https://image.anitabi.cn/points/115908/kq1sya82x_1716606844622.jpg?plan=h160	12	401	34.9098000	135.8165000	0101000020E6100000E3A59BC420FA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:20.286243
76	115908	7n3eixmf	\N	莵道高 校门前	https://image.anitabi.cn/points/115908/7n3eixmf.jpg?plan=h160	6	249	34.9085000	135.8155000	0101000020E61000006ABC749318FA60403F355EBA49744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:20.897855
77	115908	7ofiwtmf	\N	莵道高 校门前 雨	https://image.anitabi.cn/points/115908/7ofiwtmf.jpg?plan=h160	7	928	34.9084000	135.8154000	0101000020E610000012A5BDC117FA6040DCD7817346744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:21.514031
78	115908	7n4xovtl	\N	莵道高 远眺	https://image.anitabi.cn/points/115908/7n4xovtl.jpg?plan=h160	6	297	34.9091000	135.8165000	0101000020E6100000E3A59BC420FA6040956588635D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:22.433895
79	115908	7nct67gy	\N	莵道高 连接桥下 高坂同学的风格呢	https://image.anitabi.cn/points/115908/7nct67gy.jpg?plan=h160	6	670	34.9098000	135.8161000	0101000020E61000008048BF7D1DFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:23.104355
80	115908	7nc3wh7z	\N	莵道高 连接桥下 俯视	https://image.anitabi.cn/points/115908/7nc3wh7z.jpg?plan=h160	6	655	34.9098000	135.8161000	0101000020E61000008048BF7D1DFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:24.08481
81	115908	kq0rzbftj	\N	莵道高 学校角落	https://image.anitabi.cn/points/115908/kq0rzbftj_1716604610432.jpg?plan=h160	11	350	34.9100000	135.8155000	0101000020E61000006ABC749318FA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:25.30173
83	115908	kq1gsa1el	\N	莵道高 四楼 角落的储藏间（不确定位置）	https://image.anitabi.cn/points/115908/kq1gsa1el_1716606116244.jpg?plan=h160	12	116	34.9099000	135.8158000	0101000020E610000075029A081BFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:26.533686
84	115908	qys7i1	\N	宇治橋西詰交差点	https://image.anitabi.cn/points/115908/qys7i1.jpg?plan=h160	1	242	34.8922000	135.8054000	0101000020E6100000598638D6C5F96040E0BE0E9C33724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.892285%2C135.805459&z=17	2026-05-03 22:35:27.557539
85	115908	qys7j5	\N	京坂六地藏	https://image.anitabi.cn/points/115908/qys7j5.jpg?plan=h160	1	742	34.9321000	135.7935000	0101000020E610000008AC1C5A64F96040014D840D4F774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.932133%2C135.793505&z=17	2026-05-03 22:35:28.47349
86	115908	7fi3vpl3	\N	京坂六地藏站前	https://image.anitabi.cn/points/115908/7fi3vpl3.jpg?plan=h160	1	746	34.9321000	135.7935000	0101000020E610000008AC1C5A64F96040014D840D4F774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:29.497752
87	115908	7fioa3zs	\N	京坂六地藏站前 人行道按钮	https://image.anitabi.cn/points/115908/7fioa3zs.jpg?plan=h160	1	763	34.9321000	135.7935000	0101000020E610000008AC1C5A64F96040014D840D4F774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:30.112009
88	115908	7fpu1g7g	\N	京坂六地蔵駅前 红绿灯 红	https://image.anitabi.cn/points/115908/7fpu1g7g.jpg?plan=h160	1	835	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:30.728455
89	115908	7fpwn22b	\N	京坂六地蔵駅前 红绿灯 绿	https://image.anitabi.cn/points/115908/7fpwn22b.jpg?plan=h160	1	839	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:31.342342
90	115908	7fq15whf	\N	京坂六地蔵駅 入站闸机 特写	https://image.anitabi.cn/points/115908/7fq15whf.jpg?plan=h160	1	840	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:31.967339
91	115908	7fqa7g4j	\N	京坂六地蔵駅 入站口 半身	https://image.anitabi.cn/points/115908/7fqa7g4j.jpg?plan=h160	1	842	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:32.531082
92	115908	7fr565vh	\N	京坂六地蔵駅 入站口 特写 诶？我？	https://image.anitabi.cn/points/115908/7fr565vh.jpg?plan=h160	1	847	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:33.710576
93	115908	7frjw8ze	\N	京坂六地蔵駅 入站口 特写 稍微考虑考虑	https://image.anitabi.cn/points/115908/7frjw8ze.jpg?plan=h160	1	853	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:34.823465
94	115908	7frzk0tk	\N	京坂六地蔵駅 入站口 全景	https://image.anitabi.cn/points/115908/7frzk0tk.jpg?plan=h160	1	854	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:35.747434
95	115908	7ftaufky	\N	京坂六地蔵駅 提示屏 电车来咯 	https://image.anitabi.cn/points/115908/7ftaufky.jpg?plan=h160	1	862	34.9318000	135.7936000	0101000020E610000061C3D32B65F96040D734EF3845774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:36.359959
96	115908	7h6la6af	\N	京坂六地藏 宇治方向 小天使	https://image.anitabi.cn/points/115908/7h6la6af.jpg?plan=h160	2	1221	34.9319000	135.7935000	0101000020E610000008AC1C5A64F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:37.39112
97	115908	7hl44ppt	\N	京坂六地藏 宇治方向 黄昏	https://image.anitabi.cn/points/115908/7hl44ppt.jpg?plan=h160	3	519	34.9319000	135.7935000	0101000020E610000008AC1C5A64F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:37.932519
98	115908	7hm4ti8s	\N	京坂六地藏 宇治方向 黄昏 全景	https://image.anitabi.cn/points/115908/7hm4ti8s.jpg?plan=h160	3	558	34.9318000	135.7934000	0101000020E6100000AF94658863F96040D734EF3845774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:38.915464
99	115908	7hu4keiz	\N	京坂六地藏 站外 黄昏	https://image.anitabi.cn/points/115908/7hu4keiz.jpg?plan=h160	3	990	34.9318000	135.7940000	0101000020E6100000C520B07268F96040D734EF3845774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:39.428359
100	115908	7hv1mt3c	\N	京坂六地藏 闸机口	https://image.anitabi.cn/points/115908/7hv1mt3c.jpg?plan=h160	3	999	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:40.197052
101	115908	7hvf6m3j	\N	京坂六地藏 证件写真	https://image.anitabi.cn/points/115908/7hvf6m3j.jpg?plan=h160	3	1005	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:41.067894
102	115908	7jcgsq8v	\N	京坂六地藏前 入夜 红绿灯 红	https://image.anitabi.cn/points/115908/7jcgsq8v.jpg?plan=h160	5	588	34.9321000	135.7934000	0101000020E6100000AF94658863F96040014D840D4F774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:41.680226
103	115908	7jcrhte1	\N	京坂六地藏前 入夜 红绿灯 绿	https://image.anitabi.cn/points/115908/7jcrhte1.jpg?plan=h160	5	589	34.9321000	135.7934000	0101000020E6100000AF94658863F96040014D840D4F774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:42.194916
104	115908	7jcukxci	\N	京坂六地藏前 入夜	https://image.anitabi.cn/points/115908/7jcukxci.jpg?plan=h160	5	592	34.9321000	135.7934000	0101000020E6100000AF94658863F96040014D840D4F774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:42.719751
105	115908	j2s7fwl5b	京阪六地藏 闸机	京阪六地蔵　改札口	https://image.anitabi.cn/user/0/bangumi/115908/points/j2s7fwl5b-1711962527431.jpg?plan=h160	5	261	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	\N	\N	2026-05-03 22:35:44.573538
106	115908	7g011kn7	\N	久美子椅	https://image.anitabi.cn/points/115908/7g011kn7.jpg?plan=h160	1	881	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:47.531631
109	115908	7g2mvmyx	\N	久美子椅 仰视	https://image.anitabi.cn/points/115908/7g2mvmyx.jpg?plan=h160	1	906	34.8896000	135.8083000	0101000020E61000006B2BF697DDF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:49.974622
110	115908	7g3bhjns	\N	久美子椅 望远视角	https://image.anitabi.cn/points/115908/7g3bhjns.jpg?plan=h160	1	914	34.8898000	135.8087000	0101000020E6100000CE88D2DEE0F960408BFD65F7E4714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:52.533917
111	115908	7g5xll6t	\N	久美子椅 不参加吹部么？	https://image.anitabi.cn/points/115908/7g5xll6t.jpg?plan=h160	1	957	34.8897000	135.8084000	0101000020E6100000C442AD69DEF9604027A089B0E1714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:53.154899
112	115908	7g8iw1eq	\N	久美子椅 啥跟啥呀	https://image.anitabi.cn/points/115908/7g8iw1eq.jpg?plan=h160	1	983	34.8896000	135.8083000	0101000020E61000006B2BF697DDF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:54.174517
113	115908	7g48swom	\N	久美子椅 是的呢	https://image.anitabi.cn/points/115908/7g48swom.jpg?plan=h160	1	922	34.8896000	135.8084000	0101000020E6100000C442AD69DEF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:55.550818
114	115908	7g4kojoi	\N	久美子椅 你的反应怎么这么迟钝	https://image.anitabi.cn/points/115908/7g4kojoi.jpg?plan=h160	1	929	34.8896000	135.8083000	0101000020E61000006B2BF697DDF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:56.425685
115	115908	7g50b421	\N	久美子椅 别跟我说话 丑八怪	https://image.anitabi.cn/points/115908/7g50b421.jpg?plan=h160	1	936	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:56.925603
116	115908	7g7oskwy	\N	久美子椅 地面视角	https://image.anitabi.cn/points/115908/7g7oskwy.jpg?plan=h160	1	973	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:58.065004
118	115908	7h1hfw57	\N	久美子椅 朝雾桥 望远 黄昏	https://image.anitabi.cn/points/115908/7h1hfw57.jpg?plan=h160	2	1141	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:00.624841
119	115908	7h0rape2	\N	久美子椅 望远 黄昏	https://image.anitabi.cn/points/115908/7h0rape2.jpg?plan=h160	2	1124	34.8897000	135.8087000	0101000020E6100000CE88D2DEE0F9604027A089B0E1714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:01.556057
120	115908	7has3mt9	\N	久美子椅 望远 黄昏 葵	https://image.anitabi.cn/points/115908/7has3mt9.jpg?plan=h160	2	1254	34.8896000	135.8086000	0101000020E610000076711B0DE0F96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:02.894949
121	115908	7hb4d54n	\N	久美子椅 望远 黄昏 三年一转眼	https://image.anitabi.cn/points/115908/7hb4d54n.jpg?plan=h160	2	1267	34.8895000	135.8084000	0101000020E6100000C442AD69DEF9604060E5D022DB714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:03.489978
122	115908	kq1ts7nrp	\N	久美子椅 望远 蓝调	https://image.anitabi.cn/points/115908/kq1ts7nrp_1716606883857.jpg?plan=h160	12	404	34.8896000	135.8088000	0101000020E610000027A089B0E1F96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:03.983075
123	115908	kq1u9qy8t	\N	久美子椅 中景 蓝调	https://image.anitabi.cn/points/115908/kq1u9qy8t_1716606915969.jpg?plan=h160	12	424	34.8896000	135.8083000	0101000020E61000006B2BF697DDF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:05.195655
124	115908	kq1uvz17m	\N	久美子椅 长焦望远 蓝调 窥视视角	https://image.anitabi.cn/points/115908/kq1uvz17m_1716606948038.jpg?plan=h160	12	428	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:05.71558
125	115908	kq1vm088g	\N	久美子椅 长焦望远 蓝调 中景特写	https://image.anitabi.cn/points/115908/kq1vm088g_1716606991234.jpg?plan=h160	12	433	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:06.373287
126	115908	kq1vnvphe	\N	久美子椅 长焦望远 蓝调 全景	https://image.anitabi.cn/points/115908/kq1vnvphe_1716606997330.jpg?plan=h160	12	437	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:08.817788
127	115908	kq1wg6e2b	\N	宇治桥望向JR铁路桥 蓝调 夏	https://image.anitabi.cn/points/115908/kq1wg6e2b_1716607069889.jpg?plan=h160	12	440	34.8930000	135.8061000	0101000020E6100000C7293A92CBF96040FCA9F1D24D724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:09.33946
128	115908	7h2yxcif	\N	久美子椅 黄昏 井用机下视点	https://image.anitabi.cn/points/115908/7h2yxcif.jpg?plan=h160	2	1150	34.8895000	135.8085000	0101000020E61000001D5A643BDFF9604060E5D022DB714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:09.945229
129	115908	7h510kyh	\N	久美子椅 黄昏 半身	https://image.anitabi.cn/points/115908/7h510kyh.jpg?plan=h160	2	1169	34.8896000	135.8084000	0101000020E6100000C442AD69DEF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:10.96651
130	115908	7h5gmfoh	\N	久美子椅 黄昏	https://image.anitabi.cn/points/115908/7h5gmfoh.jpg?plan=h160	2	1206	34.8896000	135.8083000	0101000020E61000006B2BF697DDF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:11.993199
131	115908	7o0kil8x	\N	久美子椅 蓝调	https://image.anitabi.cn/points/115908/7o0kil8x.jpg?plan=h160	6	1296	34.8897000	135.8084000	0101000020E6100000C442AD69DEF9604027A089B0E1714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:12.51265
132	115908	qys7ht	\N	喜撰橋	https://image.anitabi.cn/points/115908/qys7ht.jpg?plan=h160	2	1198	34.8881000	135.8099000	0101000020E6100000F9A067B3EAF96040EFC9C342AD714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.888186%2C135.809936&z=17	2026-05-03 22:36:13.097477
133	115908	7ghhgxql	\N	府立宇治公園前交差点	https://image.anitabi.cn/points/115908/7ghhgxql.jpg?plan=h160	1	1201	34.8879000	135.8089000	0101000020E610000080B74082E2F96040280F0BB5A6714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:13.996451
134	115908	7p3t3y79	\N	府立宇治公園前交差点 清晨 雨	https://image.anitabi.cn/points/115908/7p3t3y79.jpg?plan=h160	8	437	34.8879000	135.8089000	0101000020E610000080B74082E2F96040280F0BB5A6714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:14.576867
135	115908	7jmkf3n5	\N	府立宇治公園前交差点 清晨	https://image.anitabi.cn/points/115908/7jmkf3n5.jpg?plan=h160	5	747	34.8879000	135.8089000	0101000020E610000080B74082E2F96040280F0BB5A6714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:15.175401
136	115908	qys7ki	\N	府立宇治公園前交差点 午后 久美子家的一半	https://image.anitabi.cn/points/115908/qys7ki.jpg?plan=h160	1	985	34.8879000	135.8089000	0101000020E610000080B74082E2F96040280F0BB5A6714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.887973%2C135.808901&z=17	2026-05-03 22:36:16.116118
137	115908	7hnepi50	\N	府立宇治公園前交差点 入夜	https://image.anitabi.cn/points/115908/7hnepi50.jpg?plan=h160	3	581	34.8879000	135.8089000	0101000020E610000080B74082E2F96040280F0BB5A6714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:17.392516
138	115908	qys7ii	\N	宇治神社	https://image.anitabi.cn/points/115908/qys7ii.jpg?plan=h160	1	1076	34.8905000	135.8099000	0101000020E6100000F9A067B3EAF96040448B6CE7FB714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.890577%2C135.809906&z=17	2026-05-03 22:36:18.304598
139	115908	7o7eieb4	\N	水原桐	https://image.anitabi.cn/points/115908/7o7eieb4.jpg?plan=h160	7	313	34.8907000	135.8101000	0101000020E6100000ABCFD556ECF960400B46257502724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:19.175848
140	115908	7o7qogij	\N	桐原水	https://image.anitabi.cn/points/115908/7o7qogij.jpg?plan=h160	7	315	34.8907000	135.8101000	0101000020E6100000ABCFD556ECF960400B46257502724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:20.095616
175	115908	7fuovj36	\N	电车内 很烂你是说的是吹部	https://image.anitabi.cn/points/115908/7fuovj36.jpg?plan=h160	1	872	34.9318000	135.7935000	0101000020E610000008AC1C5A64F96040D734EF3845774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:50.766689
143	115908	7gia835k	\N	京阪宇治闸机	https://image.anitabi.cn/points/115908/7gia835k.jpg?plan=h160	1	1212	34.8944000	135.8063000	0101000020E61000007958A835CDF960406DC5FEB27B724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:22.746391
144	115908	7jhnw9ev	\N	京阪宇治外	https://image.anitabi.cn/points/115908/7jhnw9ev.jpg?plan=h160	5	649	34.8941000	135.8067000	0101000020E6100000DDB5847CD0F9604043AD69DE71724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:24.133109
145	115908	kq2zn2110	\N	京阪宇治外 现案内所前	https://image.anitabi.cn/points/115908/kq2zn2110_1716609420491.jpg?plan=h160	12	1295	34.8942000	135.8067000	0101000020E6100000DDB5847CD0F96040A60A462575724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:25.050903
146	115908	7ipvee45	\N	京阪宇治站内	https://image.anitabi.cn/points/115908/7ipvee45.jpg?plan=h160	4	677	34.8943000	135.8064000	0101000020E6100000D26F5F07CEF960400A68226C78724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:25.510068
147	115908	7giv34em	\N	京阪宇治站台	https://image.anitabi.cn/points/115908/7giv34em.jpg?plan=h160	1	1214	34.8947000	135.8062000	0101000020E61000002041F163CCF9604098DD938785724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:26.318991
148	115908	7gj772ap	\N	电车内	https://image.anitabi.cn/points/115908/7gj772ap.jpg?plan=h160	1	1216	34.8949000	135.8062000	0101000020E61000002041F163CCF960405F984C158C724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:27.117361
149	115908	7jj2ywzo	\N	宇治桥东	https://image.anitabi.cn/points/115908/7jj2ywzo.jpg?plan=h160	5	679	34.8934000	135.8068000	0101000020E610000036CD3B4ED1F960408A1F63EE5A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:27.565416
150	115908	7jjozvi3	\N	宇治桥东信号灯 红	https://image.anitabi.cn/points/115908/7jjozvi3.jpg?plan=h160	5	691	34.8933000	135.8068000	0101000020E610000036CD3B4ED1F9604027C286A757724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:28.222091
151	115908	7jk6jjwn	\N	宇治桥东信号灯 绿	https://image.anitabi.cn/points/115908/7jk6jjwn.jpg?plan=h160	5	691	34.8933000	135.8068000	0101000020E610000036CD3B4ED1F9604027C286A757724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:28.888616
152	115908	7jkd6mt2	\N	宇治桥东 人行道	https://image.anitabi.cn/points/115908/7jkd6mt2.jpg?plan=h160	5	693	34.8932000	135.8068000	0101000020E610000036CD3B4ED1F96040C364AA6054724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:29.765506
153	115908	kq2i3c3fv	\N	宇治桥东 不甘心	https://image.anitabi.cn/points/115908/kq2i3c3fv_1716608350078.jpg?plan=h160	12	970	34.8936000	135.8068000	0101000020E610000036CD3B4ED1F9604051DA1B7C61724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:30.627778
154	115908	7ipo0s0t	\N	京阪宇治站台 黄昏	https://image.anitabi.cn/points/115908/7ipo0s0t.jpg?plan=h160	4	672	34.8946000	135.8062000	0101000020E61000002041F163CCF960403480B74082724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:31.24285
156	115908	qys7jx	\N	名古屋国際会議場センチュリーホール	https://image.anitabi.cn/points/115908/qys7jx.jpg?plan=h160	1	288	35.1315000	136.8988000	0101000020E6100000A2B437F8C21C614046B6F3FDD4904140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=35.131588%2C136.898886&z=17	2026-05-03 22:36:35.347469
157	115908	7f3s0088	\N	宇治橋西	https://image.anitabi.cn/points/115908/7f3s0088.jpg?plan=h160	1	245	34.8925000	135.8057000	0101000020E610000064CC5D4BC8F960400AD7A3703D724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:36.263537
158	115908	7gu3e7rw	\N	宇治橋西詰	https://image.anitabi.cn/points/115908/7gu3e7rw.jpg?plan=h160	2	835	34.8924000	135.8056000	0101000020E61000000BB5A679C7F96040A779C7293A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:36.990369
159	115908	7guqr1t0	\N	宇治橋西詰 萨莉亚方向	https://image.anitabi.cn/points/115908/7guqr1t0.jpg?plan=h160	2	851	34.8924000	135.8053000	0101000020E6100000006F8104C5F96040A779C7293A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:37.898682
160	115908	7gs3o1mm	宇治桥	宇治橋	https://image.anitabi.cn/points/115908/7gs3o1mm.jpg?plan=h160	2	809	34.8929000	135.8065000	0101000020E61000002B8716D9CEF96040984C158C4A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:38.382866
161	115908	7jn2zoll	\N	宇治桥 清晨	https://image.anitabi.cn/points/115908/7jn2zoll.jpg?plan=h160	5	761	34.8928000	135.8062000	0101000020E61000002041F163CCF9604035EF384547724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:39.148024
162	115908	qys7jp	\N	JR奈良線鉄橋	https://image.anitabi.cn/points/115908/qys7jp.jpg?plan=h160	2	829	34.8932000	135.8068000	0101000020E610000036CD3B4ED1F96040C364AA6054724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.893233%2C135.806805&z=17	2026-05-03 22:36:39.643862
163	115908	qys7kd	\N	宇治御蔵山郵便局付近坂道	https://image.anitabi.cn/points/115908/qys7kd.jpg?plan=h160	2	1094	34.9325000	135.8049000	0101000020E61000009D11A5BDC1F960408FC2F5285C774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.932588%2C135.80496&z=17	2026-05-03 22:36:40.17131
164	115908	qys7kj	\N	3D茶田	https://image.anitabi.cn/points/115908/qys7kj.jpg?plan=h160	2	1105	34.9325000	135.8039000	0101000020E610000024287E8CB9F960408FC2F5285C774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.932586%2C135.803952&z=17	2026-05-03 22:36:41.584039
165	115908	qys7kc	\N	711宇治黄檗公园店	https://image.anitabi.cn/points/115908/qys7kc.jpg?plan=h160	2	1233	34.9082000	135.8096000	0101000020E6100000EE5A423EE8F96040151DC9E53F744140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.908269%2C135.809662&z=17	2026-05-03 22:36:42.063746
166	115908	7hhmmioa	\N	711宇治黄檗公园店 看板特写	https://image.anitabi.cn/points/115908/7hhmmioa.jpg?plan=h160	3	481	34.9083000	135.8094000	0101000020E61000003D2CD49AE6F96040787AA52C43744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:42.631235
167	115908	7hi0jj88	\N	711宇治黄檗公园店 黄昏	https://image.anitabi.cn/points/115908/7hi0jj88.jpg?plan=h160	3	484	34.9082000	135.8096000	0101000020E6100000EE5A423EE8F96040151DC9E53F744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:43.454705
168	115908	7hieeza6	\N	711宇治黄檗公园店 扭蛋机	https://image.anitabi.cn/points/115908/7hieeza6.jpg?plan=h160	3	487	34.9082000	135.8096000	0101000020E6100000EE5A423EE8F96040151DC9E53F744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:45.032789
169	115908	kq2xpnyje	\N	羽戸山緑地 附近	https://image.anitabi.cn/points/115908/kq2xpnyje_1716609353431.jpg?plan=h160	12	1259	34.9068000	135.8114000	0101000020E61000002EFF21FDF6F96040A301BC0512744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:45.933093
170	115908	qys7jm	\N	羽戸山緑地付近	https://image.anitabi.cn/points/115908/qys7jm.jpg?plan=h160	1	259	34.9071000	135.8111000	0101000020E610000024B9FC87F4F96040CE1951DA1B744140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.907145%2C135.811159&z=17	2026-05-03 22:36:46.822989
171	115908	qys7hz	\N	マクドナルド宇治木幡店	https://image.anitabi.cn/points/115908/qys7hz.jpg?plan=h160	3	1018	34.9264000	135.7997000	0101000020E61000008F53742497F96040D881734694764140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.92643%2C135.799795&z=17	2026-05-03 22:36:47.658723
172	115908	qys7k7	\N	朝霧橋東詰	https://image.anitabi.cn/points/115908/qys7k7.jpg?plan=h160	4	754	34.8906000	135.8098000	0101000020E6100000A089B0E1E9F96040A7E8482EFF714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.890634%2C135.809891&z=17	2026-05-03 22:36:48.627943
173	115908	qys7in	\N	京阪六地蔵付近鉄橋	https://image.anitabi.cn/points/115908/qys7in.jpg?plan=h160	5	599	34.9316000	135.7941000	0101000020E61000001D38674469F96040107A36AB3E774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.93163%2C135.794148&z=17	2026-05-03 22:36:49.396008
174	115908	7fue6vtd	\N	电车内 我知道了	https://image.anitabi.cn/points/115908/7fue6vtd.jpg?plan=h160	1	871	34.9319000	135.7935000	0101000020E610000008AC1C5A64F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:49.980862
179	115908	7jelvkrx	\N	京阪黄檗站 电车内	https://image.anitabi.cn/points/115908/7jelvkrx.jpg?plan=h160	5	609	34.9143000	135.8026000	0101000020E6100000A1F831E6AEF96040CC5D4BC807754140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:54.17959
180	115908	7je0enrl	\N	京阪黄檗站内	https://image.anitabi.cn/points/115908/7je0enrl.jpg?plan=h160	5	602	34.9143000	135.8027000	0101000020E6100000F90FE9B7AFF96040CC5D4BC807754140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:55.121126
181	115908	7jqkh010	\N	山城総合運動公園・陸上競技場	https://image.anitabi.cn/points/115908/7jqkh010.jpg?plan=h160	5	865	34.8714000	135.8054000	0101000020E6100000598638D6C5F9604001DE02098A6F4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:55.630863
182	115908	qys7ka	\N	成基学園・東進衛星予備校	https://image.anitabi.cn/points/115908/9838c543b1e9e29833de087c61a4a39a.jpeg?plan=h160	1	30	34.8895000	135.7998000	0101000020E6100000E86A2BF697F9604060E5D022DB714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.889596%2C135.799843&z=17	2026-05-03 22:36:56.225321
183	115908	qys7i8	\N	セブンイレブンJR宇治駅前店	https://image.anitabi.cn/points/115908/2f447201b1333025a6fe67f90d761257.png?plan=h160	7	389	34.8898000	135.8004000	0101000020E6100000FDF675E09CF960408BFD65F7E4714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.889871%2C135.800438&z=17	2026-05-03 22:36:58.174769
184	115908	7oun8aol	\N	萨莉亚宇治里尻店前	https://image.anitabi.cn/points/115908/7oun8aol.jpg?plan=h160	7	1267	34.8925000	135.8049000	0101000020E61000009D11A5BDC1F960400AD7A3703D724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:58.761047
185	115908	7ouww87p	\N	萨莉亚宇治里尻店	https://image.anitabi.cn/points/115908/7ouww87p.jpg?plan=h160	7	1274	34.8925000	135.8048000	0101000020E610000044FAEDEBC0F960400AD7A3703D724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:36:59.70796
186	115908	qys7hs	\N	あがた通り鳥居	https://image.anitabi.cn/user/0/bangumi/115908/points/qys7hs-1713076111795.jpg?plan=h160	8	657	34.8919000	135.8056000	0101000020E61000000BB5A679C7F96040B5A679C729724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.891968%2C135.805687&z=17	2026-05-03 22:37:00.612996
187	115908	qys7il	\N	JR宇治駅	https://image.anitabi.cn/user/0/bangumi/115908/points/qys7il-1720438003834.jpg?plan=h160	8	451	34.8904000	135.8006000	0101000020E6100000AF25E4839EF96040E02D90A0F8714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.890402%2C135.800607&z=17	2026-05-03 22:37:03.825002
188	115908	qys7kb	\N	さわらびの道	https://image.anitabi.cn/points/115908/81e7047af3f319289f6df5bcdcc6945c.png?plan=h160	8	808	34.8911000	135.8104000	0101000020E6100000B515FBCBEEF9604099BB96900F724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.89111%2C135.810419&z=17	2026-05-03 22:37:04.627136
190	115908	qys7ia	\N	大吉山（仏徳山）登山口	https://image.anitabi.cn/user/0/bangumi/115908/points/qys7ia-1697123425329.jpg?plan=h160	8	863	34.8928000	135.8107000	0101000020E6100000C05B2041F1F9604035EF384547724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.892848%2C135.810794&z=17	2026-05-03 22:37:06.46692
191	115908	qys7ix	\N	縣神社	https://image.anitabi.cn/points/115908/75cc58c61b40fdd8a8e64bd8b9bacd0c.png?plan=h160	8	919	34.8884000	135.8058000	0101000020E6100000BDE3141DC9F9604019E25817B7714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.888488%2C135.80587&z=17	2026-05-03 22:37:07.901121
192	115908	qys7k4	\N	大吉山展望台 蓝调	https://image.anitabi.cn/user/0/bangumi/115908/points/qys7k4-1715518655607.jpg?plan=h160	8	1131	34.8926000	135.8125000	0101000020E61000000000000000FA60406E3480B740724140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.892674%2C135.81259&z=17	2026-05-03 22:37:08.924695
193	115908	7eumiie0	\N	大吉山展望台远眺中岛 清晨	https://image.anitabi.cn/points/115908/7eumiie0.jpg?plan=h160	1	126	34.8926000	135.8122000	0101000020E6100000F5B9DA8AFDF960406E3480B740724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:09.49838
194	115908	qys7i7	\N	中路ベーカリー	https://image.anitabi.cn/points/115908/dea46940f39cda9b2297f3ad2eac6812.png?plan=h160	9	489	34.9142000	135.8022000	0101000020E61000003D9B559FABF9604069006F8104754140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.914245%2C135.802267&z=17	2026-05-03 22:37:10.076129
195	115908	qys7hu	\N	宇治文化中心	https://image.anitabi.cn/points/115908/qys7hu_1716605169430.jpg?plan=h160	11	700	34.8796000	135.8039000	0101000020E610000024287E8CB9F96040E3C798BB96704140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.87962%2C135.803991&z=17	2026-05-03 22:37:10.770853
196	115908	kq11wpcnn	\N	宇治文化中心 大厅	https://image.anitabi.cn/points/115908/kq11wpcnn_1716605196172.jpg?plan=h160	11	692	34.8796000	135.8045000	0101000020E610000039B4C876BEF96040E3C798BB96704140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:11.382489
197	115908	kq124wsec	宇治文化中心 室内	宇治文化中心 室内	https://image.anitabi.cn/points/115908/kq124wsec_1716605209846.jpg?plan=h160	11	718	34.8797000	135.8045000	0101000020E610000039B4C876BEF96040462575029A704140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:12.722707
198	115908	kq139nn9m	\N	宇治文化中心 走廊	https://image.anitabi.cn/points/115908/kq139nn9m_1716605277475.jpg?plan=h160	11	802	34.8796000	135.8042000	0101000020E61000002F6EA301BCF96040E3C798BB96704140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:13.228177
199	115908	kq12ro0yo	\N	宇治文化中心 停车场	https://image.anitabi.cn/points/115908/kq12ro0yo_1716605258706.jpg?plan=h160	11	769	34.8799000	135.8046000	0101000020E610000092CB7F48BFF960400DE02D90A0704140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:13.738426
200	115908	qys7k6	\N	京阪伏見稲荷駅	https://image.anitabi.cn/points/115908/75877ba95f223e54af4e0b48d29f55fc.png?plan=h160	13	115	34.9687000	135.7693000	0101000020E6100000029A081B9EF860404ED1915CFE7B4140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.968775%2C135.769322&z=17	2026-05-03 22:37:14.660417
201	115908	qys7jg	\N	宇治御蔵山郵便局付近	https://image.anitabi.cn/points/115908/cd3f7ce69b5af0f9e7429d6870ba81ea.png?plan=h160	14	1144	34.9325000	135.8051000	0101000020E61000004F401361C3F960408FC2F5285C774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.93254%2C135.805127&z=17	2026-05-03 22:37:15.583015
202	115908	qys7jl	\N	ゆう薬局六地蔵店	https://image.anitabi.cn/points/115908/a14b5b3abfd7d230bce899b16e5e71ff.png?plan=h160	14	1213	34.9334000	135.7995000	0101000020E6100000DD24068195F960400F0BB5A679774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.933455%2C135.799529&z=17	2026-05-03 22:37:16.198309
203	115908	qys7i6	\N	天理教京東分教会付近	https://image.anitabi.cn/points/115908/b4780d9e8da0b153376ac269b3df1e1c.png?plan=h160	14	1216	34.9366000	135.8043000	0101000020E610000088855AD3BCF9604080B74082E2774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.93661%2C135.804329&z=17	2026-05-03 22:37:17.42468
204	115908	qys7kh	\N	東洋パーク付近	https://image.anitabi.cn/points/115908/e08701eb8c24a098143b219486fa3402.png?plan=h160	14	1215	34.9351000	135.8020000	0101000020E61000008B6CE7FBA9F96040AB3E575BB1774140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.935175%2C135.802065&z=17	2026-05-03 22:37:18.099035
207	115908	7onw90h5	\N	电车内 薯条吃太多了	https://image.anitabi.cn/points/115908/7onw90h5.jpg?plan=h160	7	1132	34.9046000	135.8060000	0101000020E61000006F1283C0CAF9604016FBCBEEC9734140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:20.400186
208	115908	qys7ih	\N	観流橋	https://image.anitabi.cn/points/115908/e6aaf61c11de9ca6ed2ba772c48c1708.png?plan=h160	11	797	34.8889000	135.8112000	0101000020E61000007DD0B359F5F960400BB5A679C7714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.888923%2C135.811299&z=17	2026-05-03 22:37:20.910287
210	115908	7ir4s726	\N	観流橋西	https://image.anitabi.cn/points/115908/7ir4s726.jpg?plan=h160	4	696	34.8906000	135.8096000	0101000020E6100000EE5A423EE8F96040A7E8482EFF714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:23.160967
211	115908	kq0w5ii2h	\N	観流橋西 朝日烧店铺前	https://image.anitabi.cn/points/115908/kq0w5ii2h_1716604900230.jpg?plan=h160	11	533	34.8908000	135.8096000	0101000020E6100000EE5A423EE8F960406EA301BC05724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:23.687998
212	115908	7hwewb4e	麦当劳宇治木幡店	マクドナルド\n宇治​木幡​店	https://image.anitabi.cn/points/115908/7hwewb4e.jpg?plan=h160	3	1020	34.9265000	135.7999000	0101000020E61000004182E2C798F960403BDF4F8D97764140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:24.923154
213	115908	7nzsmxui	\N	京坂木幡站	https://image.anitabi.cn/points/115908/7nzsmxui.jpg?plan=h160	6	1293	34.9139000	135.8028000	0101000020E61000005227A089B0F960403EE8D9ACFA744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:25.545542
214	115908	qys7ic	\N	羽戸山第三児童公園	https://image.anitabi.cn/points/115908/qys7ic.jpg?plan=h160	3	1072	34.9078000	135.8148000	0101000020E6100000FC1873D712FA604087A757CA32744140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.907808%2C135.814824&z=17	2026-05-03 22:37:26.131608
215	115908	7hyfeeyp	\N	羽戸山第三児童公園 前	https://image.anitabi.cn/points/115908/7hyfeeyp.jpg?plan=h160	3	1099	34.9078000	135.8147000	0101000020E6100000A301BC0512FA604087A757CA32744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:27.257995
216	115908	t24t6v4jm	\N	饮水池	https://image.anitabi.cn/points/115908/t24t6v4jm_1740122625966.jpg?plan=h160	9	304	34.9078000	135.8147000	0101000020E6100000A301BC0512FA604087A757CA32744140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-03 22:37:27.837159
217	115908	hsi1kiyqq	\N	宇治桥 不甘心	https://image.anitabi.cn/points/115908/kq2i9iegc_1716608362043.jpg?plan=h160	12	987	34.8935000	135.8068000	0101000020E610000036CD3B4ED1F96040EE7C3F355E724140	Anitabi@Chimes	https://anitabi.cn/	2026-05-03 22:37:28.871157
218	115908	kq2n46rlq	\N	宇治桥 不甘心 全景	https://image.anitabi.cn/points/115908/kq2n46rlq_1716608654473.jpg?plan=h160	12	1061	34.8926000	135.8057000	0101000020E610000064CC5D4BC8F960406E3480B740724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:29.615295
219	115908	kq2pjf2la	\N	宇治桥 不甘心 全景2	https://image.anitabi.cn/points/115908/kq2pjf2la_1716608808006.jpg?plan=h160	12	1082	34.8923000	135.8079000	0101000020E610000007CE1951DAF96040431CEBE236724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:30.234953
220	115908	j2sjku1v4	宇治桥西	宇治橋西	https://image.anitabi.cn/points/115908/j2sjku1v4_1737823169775_c16v9.jpg?plan=h160	8	685	34.8925000	135.8057000	0101000020E610000064CC5D4BC8F960400AD7A3703D724140	\N	\N	2026-05-03 22:37:30.743964
221	115908	34e10am	\N	河原町通	https://image.anitabi.cn/user/0/bangumi/115908/points/34e10am-1753806211120.jpg?plan=h160	14	659	35.0075000	135.7690000	0101000020E6100000F853E3A59BF86040295C8FC2F5804140	\N	\N	2026-05-03 22:37:31.822852
222	115908	3plnxvy	JR宇治站	JR宇治駅	https://image.anitabi.cn/user/0/bangumi/115908/points/3plnxvy-1755088794974.jpg?plan=h160	8	713	34.8903000	135.8009000	0101000020E6100000BA6B09F9A0F960407DD0B359F5714140	\N	\N	2026-05-03 22:37:32.777992
223	115908	4qkomh3	\N	京阪宇治站车辆入站	https://image.anitabi.cn/user/1000/bangumi/115908/points/4qkomh3-1757324347454.jpg?plan=h160	9	645	34.8955000	135.8063000	0101000020E61000007958A835CDF96040B4C876BE9F724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:33.671794
224	115908	7mt52rr	大吉山展望台	大吉山展望台	https://image.anitabi.cn/user/0/bangumi/115908/points/7mt52rr-1763627079224.jpg?plan=h160	8	1197	34.8927000	135.8120000	0101000020E6100000448B6CE7FBF96040D1915CFE43724140	\N	\N	2026-05-03 22:37:34.328566
225	115908	4x2po29	\N	羽戸山第三児童公園 秋千	https://image.anitabi.cn/points/115908/4x2po29_1757717440313.jpg?plan=h160	9	\N	34.9076000	135.8148000	0101000020E6100000FC1873D712FA6040C0EC9E3C2C744140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-03 22:37:35.258072
226	115908	kq272rarh	\N	莵道高 音乐室 外景	https://image.anitabi.cn/points/115908/kq272rarh_1716607684475.jpg?plan=h160	\N	4492	34.9098000	135.8167000	0101000020E610000095D4096822FA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:36.92418
227	115908	kq27uuph4	\N	莵道高 垃圾处理厂上空	https://image.anitabi.cn/points/115908/kq27uuph4_1716607731861.jpg?plan=h160	\N	4533	34.9100000	135.8166000	0101000020E61000003CBD529621FA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:37:37.604816
228	115908	s8p6o00ko	飛び出し注意看板（黄前久美子）	飛び出し注意看板（黄前久美子）	https://image.anitabi.cn/user/0/bangumi/115908/points/s8p6o00ko-1746833044431.jpg?plan=h160	\N	\N	34.8905000	135.8040000	0101000020E61000007D3F355EBAF96040448B6CE7FB714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-03 22:37:38.533195
229	115908	s8pbk9tst	飛び出し注意看板（中川夏紀）	飛び出し注意看板（中川夏紀）	https://image.anitabi.cn/user/0/bangumi/115908/points/s8pbk9tst-1746832160753.jpg?plan=h160	\N	\N	34.8890000	135.8002000	0101000020E61000004BC8073D9BF960406F1283C0CA714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-03 22:37:39.135137
230	115908	s8pg4fqk8	\N	飛び出し注意看板（加藤葉月）	https://image.anitabi.cn/user/0/bangumi/115908/points/s8pg4fqk8-1753927734210.jpg?plan=h160	\N	\N	34.8899000	135.8021000	0101000020E6100000E4839ECDAAF96040EE5A423EE8714140	\N	\N	2026-05-03 22:37:40.007363
231	115908	sffrvo228	\N	飛び出し注意看板（高坂麗奈）	https://image.anitabi.cn/user/0/bangumi/115908/points/sffrvo228-1753927805805.jpg?plan=h160	\N	\N	34.9338000	135.8558000	0101000020E6100000567DAEB662FB60409D8026C286774140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-03 22:37:41.182336
232	115908	4euxlo	飛び出し注意看板（吉川优子）	Arm	https://image.anitabi.cn/user/0/bangumi/115908/points/4euxlo-1747277350257.jpg?plan=h160	\N	\N	34.8912000	135.8040000	0101000020E61000007D3F355EBAF96040FC1873D712724140	\N	\N	2026-05-03 22:37:42.161184
233	115908	4f7oj3	飛び出し注意看板（川岛绿辉）	真柴豆腐店	https://image.anitabi.cn/user/0/bangumi/115908/points/4f7oj3-1747277870749.jpg?plan=h160	\N	\N	34.9115000	135.8055000	0101000020E6100000B29DEFA7C6F96040E9263108AC744140	\N	\N	2026-05-03 22:37:42.639295
234	115908	2pbfrhy	羽户山绿地 附近	羽戸山緑地 附近	https://image.anitabi.cn/user/0/bangumi/115908/points/2pbfrhy-1752894807824.jpg?plan=h160	\N	\N	34.9064000	135.8113000	0101000020E6100000D5E76A2BF6F96040158C4AEA04744140	\N	\N	2026-05-03 22:37:44.093157
36	115908	kq1dm4izb	\N	莵道高 去往花藤架的上坡路	https://image.anitabi.cn/points/115908/kq1dm4izb_1716605906797.jpg?plan=h160	12	114	34.9088000	135.8169000	0101000020E61000004703780B24FA60406A4DF38E53744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:34:47.310856
72	115908	kq1mz9ylc	\N	莵道高 久美子练号处	https://image.anitabi.cn/points/115908/kq1mz9ylc_1716606486520.jpg?plan=h160	12	258	34.9100000	135.8162000	0101000020E6100000D95F764F1EFA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-03 22:35:18.411601
705	283643	kjugide5k	\N	京都市勧业馆（みやこめっせ）	https://image.anitabi.cn/user/0/bangumi/283643/points/kjugide5k-1716120678895.jpg?plan=h160	7	684	35.0134000	135.7812000	0101000020E610000054742497FFF8604019E25817B7814140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:34.730052
205	115908	qys7jz	\N	メンズヘアーサロンスズキ付近	https://image.anitabi.cn/points/115908/45d88e47c8ac8fd35031e39d2019aa0f.png?plan=h160	14	1218	34.9409000	135.8100000	0101000020E610000052B81E85EBF96040386744696F784140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.940963%2C135.810098&z=17	2026-05-03 22:37:18.659419
1415	262939	rm4plyxhl	\N	港区, 东京都 都道481号	https://image.anitabi.cn/user/2148/bangumi/262939/points/rm4plyxhl-1736047510627.jpg?plan=h160	\N	\N	35.6636000	139.7593000	0101000020E61000004A7B832F4C78614014D044D8F0D44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:08.975818
770	1424	25idmds	\N	北山通	https://image.anitabi.cn/points/1424/25idmds.jpg?plan=h160	15	198	35.0521000	135.7863000	0101000020E6100000091B9E5E29F96040910F7A36AB864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.325526
1404	262939	rlmhot44o	\N	ゆうゆう橋	https://image.anitabi.cn/user/2148/bangumi/2585/points/rlmhot44o-1736008002694.jpg?plan=h160	\N	\N	35.6222000	139.4224000	0101000020E6100000933A014D846D61401DC9E53FA4CF4140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:07.405318
1416	329906	51i52hx0s	巴伐利亚国立歌剧院	バイエルン国立歌劇場	https://image.anitabi.cn/points/329906/51i52hx0s_1723709072074_cut.jpg?plan=h160	\N	\N	48.1393000	11.5792000	0101000020E6100000B8AF03E78C282740992A1895D4114840	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=48.139389%2C11.579277&z=17	2026-06-09 19:30:09.086803
821	262940	l02wh8yxw	\N	Patisserie Tsunagu	https://image.anitabi.cn/user/1099/bangumi/2585/points/l02wh8yxw-1717393673539.jpg?plan=h160	1	767	35.7042000	139.4180000	0101000020E61000004C378941606D6140EEEBC03923DA4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:26.395457
1410	186515	695f57ef	\N	リキッドルーム	https://image.anitabi.cn/points/186515/695f57ef_1722413933374.jpg?plan=h160	2	717	35.6491000	139.7105000	0101000020E6100000DBF97E6ABC766140B3EA73B515D34140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.649113%2C139.710564&z=17	2026-06-09 19:30:07.83252
619	152091	kq93150vb	\N	アクトパル宇治 希美练习（未确定）	https://image.anitabi.cn/points/152091/kq93150vb_1716622681161.jpg?plan=h160	3	126	34.9347000	135.8560000	0101000020E610000008AC1C5A64FB60401DC9E53FA4774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:31.341575
1419	186515	8fbb9b1c	\N	新宿アルタ前	https://image.anitabi.cn/points/186515/8fbb9b1c_1722414018711.jpg?plan=h160	1	113	35.6922000	139.7011000	0101000020E6100000386744696F766140462575029AD84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.692269%2C139.7011&z=17	2026-06-09 19:30:10.091772
1467	186515	kbia4c	神田川桜並木（自行车·步行者专用道路）路口	神田川桜並木（自行车·步行者专用道路）路口	https://image.anitabi.cn/user/0/bangumi/186515/points/kbia4c-1748239012561.jpg?plan=h160	1	752	35.7125000	139.7221000	0101000020E6100000228E75711B7761403333333333DB4140	Anitabi	https://anitabi.cn/	2026-06-09 19:30:34.775443
1421	186515	8dea6856	\N	大久保通り	https://image.anitabi.cn/points/186515/8dea6856_1722414020795.jpg?plan=h160	9	764	35.7013000	139.7082000	0101000020E6100000DFE00B93A9766140A857CA32C4D94140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.701393%2C139.708219&z=17	2026-06-09 19:30:11.068655
1407	262939	rm45nj7dz	汐留十字路口	汐留交差点	https://image.anitabi.cn/user/2148/bangumi/262939/points/rm45nj7dz-1736046318980.jpg?plan=h160	\N	\N	35.6633000	139.7601000	0101000020E610000011363CBD52786140E9B7AF03E7D44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:07.581323
497	216228	4ui7mhgff	\N	中華料理屋「中国家庭料理 楊 2号店」	https://image.anitabi.cn/points/216228/4ui7mhgff.jpg?plan=h160	\N	\N	35.7300000	139.7072000	0101000020E610000066F7E461A17661403D0AD7A370DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.730059%2C139.707256&z=17	2026-05-10 10:49:58.180284
546	152091	kq4w2z8qf	\N	莵道高 乐器仓库（未确定）	https://image.anitabi.cn/points/152091/kq4w2z8qf_1716613558756.jpg?plan=h160	1	379	34.9102000	135.8162000	0101000020E6100000D95F764F1EFA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:38.50731
542	152091	kqezk8m6o	\N	莵道高 正门 清晨 回忆 樱花	https://image.anitabi.cn/points/152091/kqezk8m6o_1716635815947.jpg?plan=h160	2	978	34.9089000	135.8156000	0101000020E6100000C3D32B6519FA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:35.435059
884	246429	umk0bm03f	新宿alta前	新宿アルタ前	https://image.anitabi.cn/points/186515/8fbb9b1c_1722414018711.jpg?plan=h160	1	113	35.6922000	139.7011000	0101000020E6100000386744696F766140462575029AD84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.692269%2C139.7011&z=17	2026-05-24 11:02:54.128369
535	152091	kq6prakfb	\N	京坂黄檗站 内	https://image.anitabi.cn/points/152091/kq6prakfb_1716617521881.jpg?plan=h160	1	1888	34.9143000	135.8026000	0101000020E6100000A1F831E6AEF96040CC5D4BC807754140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:30.8273
790	1424	s9o99xc7u	\N	JEUGIA三条本店	https://image.anitabi.cn/points/1424/s9o99xc7u_1737892396531.jpg?plan=h160	2	\N	35.0087000	135.7677000	0101000020E6100000742497FF90F86040D3BCE3141D814140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.639979
549	152091	kqa3x6uwd	\N	莵道高 连接桥	https://image.anitabi.cn/points/152091/kqa3x6uwd_1716624908012.jpg?plan=h160	4	463	34.9098000	135.8163000	0101000020E610000032772D211FFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:40.789795
647	152091	d0ogcof	大吉山离别树	大吉山离别树	https://image.anitabi.cn/user/0/bangumi/152091/points/d0ogcof-1775349639769.jpg?plan=h160	11	476	34.8924000	135.8122000	0101000020E6100000F5B9DA8AFDF96040A779C7293A724140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:49.466754
866	2585	odv838rg1	\N	立川駅北口	https://image.anitabi.cn/user/1099/bangumi/2585/points/odv838rg1-1726936594474.jpg?plan=h160	17	79	35.6987000	139.4142000	0101000020E61000001AC05B20416D61408CDB68006FD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:31:47.778349
1052	328609	cmok9d	\N	下北沢プラッツ 自販機	https://image.anitabi.cn/points/328609/cmok9d_1747774046198.jpg?plan=h160	5	736	35.6616000	139.6692000	0101000020E6100000764F1E166A7561404D840D4FAFD44140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:19.248718
1409	262939	rm4igvz9v	\N	環二通り	https://image.anitabi.cn/user/2148/bangumi/262939/points/rm4igvz9v-1736047059201.jpg?plan=h160	\N	\N	35.6634000	139.7612000	0101000020E6100000E3361AC05B7861404D158C4AEAD44140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:07.76404
1414	186515	f2a228ef	\N	忠犬ハチ公像（渋谷区）	https://image.anitabi.cn/points/186515/f2a228ef_1722413992934.jpg?plan=h160	2	818	35.6590000	139.7005000	0101000020E610000023DBF97E6A7661403108AC1C5AD44140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.659056%2C139.700581&z=17	2026-06-09 19:30:08.499856
670	152091	s8uab5cln	蹴上インクライン	381	https://image.anitabi.cn/points/152091/s8uab5cln_1737827156318.jpg?plan=h160	\N	\N	35.0105000	135.7888000	0101000020E6100000B7627FD93DF96040D34D621058814140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:08.526728
1089	328609	pygefa1bf	江之岛展望灯塔	江の島​シーキャンドル	https://image.anitabi.cn/user/1139/bangumi/328609/points/pygefa1bf-1731371079245.jpg?plan=h160	9	987	35.2997000	139.4784000	0101000020E6100000014D840D4F6F61403C4ED1915CA64140	Anitabi@柒宇	https://anitabi.cn/	2026-05-31 22:40:29.063049
323	55113	31pe111	豆大福（出町ふたば）	豆大福（出町ふたば）	https://image.anitabi.cn/points/55113/31pe111_1724030450735.jpg?plan=h160	12	962	35.0300000	135.7696000	0101000020E61000000DE02D90A0F86040A4703D0AD7834140	エンドス	\N	2026-05-04 16:22:32.751348
324	55113	31pe112	\N	京阪電車藤森駅東改札口付近	https://image.anitabi.cn/points/55113/31pe112_1724030228647.jpg?plan=h160	1	1	34.9569000	135.7704000	0101000020E6100000D49AE61DA7F860406DC5FEB27B7A4140	エンドス	\N	2026-05-04 16:22:32.79804
1035	328609	csv0pl	\N	片瀬東浜海水浴場	https://image.anitabi.cn/points/328609/csv0pl_1747784424083.jpg?plan=h160	2	339	35.3067000	139.4850000	0101000020E6100000EC51B81E856F614073D712F241A74140	Anitabi@Lilin	https://anitabi.cn/	2026-05-31 22:40:16.772087
325	55113	nct13xkw9	\N	藤森駅北改札口	https://image.anitabi.cn/points/55113/nct13xkw9_1724032334388.jpg?plan=h160	3	704	34.9569000	135.7703000	0101000020E61000007B832F4CA6F860406DC5FEB27B7A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:32.838856
326	55113	nct1k43xn	\N	第二軍道の師団橋	https://image.anitabi.cn/points/55113/nct1k43xn_1724032354780.jpg?plan=h160	3	916	34.9583000	135.7704000	0101000020E6100000D49AE61DA7F86040DFE00B93A97A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:32.875063
327	55113	nct3qlqsb	\N	キトロ橋	https://image.anitabi.cn/points/55113/nct3qlqsb_1724032486764.jpg?plan=h160	6	528	34.9578000	135.7706000	0101000020E610000086C954C1A8F86040ED0DBE30997A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:32.911033
328	55113	nct45qulq	堀田橋	堀田橋	https://image.anitabi.cn/points/55113/nct45qulq_1724032512098.jpg?plan=h160	8	1080	34.9568000	135.7704000	0101000020E6100000D49AE61DA7F860400A68226C787A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:32.949239
329	55113	nct59ktih	\N	師団橋付近	https://image.anitabi.cn/points/55113/nct59ktih_1724032578896.jpg?plan=h160	9	386	34.9589000	135.7704000	0101000020E6100000D49AE61DA7F860403411363CBD7A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:32.98551
330	55113	nctxy45l1	\N	ユズキ君の家付近	https://image.anitabi.cn/points/55113/nctxy45l1_1724034313439.jpg?plan=h160	9	1070	34.9612000	135.7716000	0101000020E6100000FFB27BF2B0F860402575029A087B4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.022047
331	55113	ncu2egft4	\N	深草商店街	https://image.anitabi.cn/points/55113/ncu2egft4_1724034583215.jpg?plan=h160	3	57	34.9577000	135.7712000	0101000020E61000009B559FABADF860408AB0E1E9957A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.057221
332	55113	ncu3zryzc	\N	聖母女学院对面	https://image.anitabi.cn/points/55113/ncu3zryzc_1724034680706.jpg?plan=h160	3	343	34.9584000	135.7712000	0101000020E61000009B559FABADF86040423EE8D9AC7A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.089883
333	55113	ncu6vk59j	\N	名神高速道路の南側	https://image.anitabi.cn/points/55113/ncu6vk59j_1724034855007.jpg?plan=h160	3	393	34.9558000	135.7712000	0101000020E61000009B559FABADF8604027C286A7577A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.125943
334	55113	ncu9fz19z	\N	深草小学校	https://image.anitabi.cn/points/55113/ncu9fz19z_1724035009780.jpg?plan=h160	3	400	34.9560000	135.7712000	0101000020E61000009B559FABADF86040EE7C3F355E7A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.162913
335	55113	ncu4hvj84	\N	聖母女学院北向	https://image.anitabi.cn/points/55113/ncu4hvj84_1724034713143.jpg?plan=h160	3	845	34.9588000	135.7711000	0101000020E6100000423EE8D9ACF86040D0B359F5B97A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.197173
336	55113	31pe11m	\N	琵琶湖疏水沿い	https://image.anitabi.cn/points/55113/31pe11m_1724031861037.jpg?plan=h160	1	13	34.9575000	135.7704000	0101000020E6100000D49AE61DA7F86040C3F5285C8F7A4140	エンドス	\N	2026-05-04 16:22:33.22926
337	55113	31pe11n	\N	鲸鱼下	https://image.anitabi.cn/user/0/bangumi/55113/points/31pe11n-1710241883762.jpg?plan=h160	2	858	35.0302000	135.7684000	0101000020E6100000E3C798BB96F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.261434
338	55113	31pe116	\N	さが喜	https://image.anitabi.cn/points/55113/31pe116_1724031047776.jpg?plan=h160	1	587	35.0302000	135.7680000	0101000020E61000007F6ABC7493F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.292174
339	55113	31pe11f	\N	いづもや	https://image.anitabi.cn/points/55113/31pe11f_1724030726042.jpg?plan=h160	1	66	35.0302000	135.7682000	0101000020E610000031992A1895F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.326815
340	55113	31pe126	\N	野口屋精肉店	https://image.anitabi.cn/points/55113/31pe126_1724030619635.jpg?plan=h160	1	70	35.0303000	135.7685000	0101000020E61000003BDF4F8D97F86040CE88D2DEE0834140	エンドス	\N	2026-05-04 16:22:33.359248
341	55113	31pe11d	\N	イカワトーイ	https://image.anitabi.cn/points/55113/31pe11d_1724030751272.jpg?plan=h160	1	79	35.0302000	135.7687000	0101000020E6100000ED0DBE3099F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.391672
342	55113	31pe11c	\N	リビングショップ まつむら 前	https://image.anitabi.cn/points/55113/31pe11c_1724030761505.jpg?plan=h160	1	88	35.0302000	135.7686000	0101000020E610000094F6065F98F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.427746
343	55113	31pe12b	\N	鯖のオブジェのある十字路あたり	https://image.anitabi.cn/points/55113/31pe12b_1724030775188.jpg?plan=h160	2	74	35.0302000	135.7685000	0101000020E61000003BDF4F8D97F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.462346
345	55113	31pe12l	\N	ブックスヤスモト 前	https://image.anitabi.cn/points/55113/31pe12l_1724030808082.jpg?plan=h160	2	105	35.0302000	135.7696000	0101000020E61000000DE02D90A0F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.527211
346	55113	31pe114	\N	京漬物 出町なかにし 前	https://image.anitabi.cn/points/55113/31pe114_1724030822447.jpg?plan=h160	2	133	35.0302000	135.7689000	0101000020E61000009F3C2CD49AF860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.558822
347	55113	31pe11v	\N	花の春風	https://image.anitabi.cn/points/55113/31pe11v_1724030855873.jpg?plan=h160	1	230	35.0302000	135.7683000	0101000020E61000008AB0E1E995F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.591471
348	55113	31pe121	\N	ちびから本舗	https://image.anitabi.cn/points/55113/31pe121_1724030874815.jpg?plan=h160	1	302	35.0302000	135.7684000	0101000020E6100000E3C798BB96F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.62345
349	55113	31pe13m	\N	十字路を北へ10mほど	https://image.anitabi.cn/points/55113/31pe13m_1724030884474.jpg?plan=h160	1	313	35.0303000	135.7685000	0101000020E61000003BDF4F8D97F86040CE88D2DEE0834140	エンドス	\N	2026-05-04 16:22:33.655117
350	55113	31pe118	\N	地酒地焼酎 八百屋（Yaoya）	https://image.anitabi.cn/points/55113/31pe118_1724030999309.jpg?plan=h160	1	340	35.0306000	135.7684000	0101000020E6100000E3C798BB96F86040F9A067B3EA834140	エンドス	\N	2026-05-04 16:22:33.687966
351	55113	ncsgtiyxh	\N	錦湯	https://image.anitabi.cn/points/55113/ncsgtiyxh_1724031100565.jpg?plan=h160	1	603	35.0047000	135.7632000	0101000020E6100000D50968226CF86040462575029A804140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.717248
352	55113	ncsij52de	\N	錦湯の脱衣場	https://image.anitabi.cn/points/55113/ncsij52de_1724031207761.jpg?plan=h160	1	741	35.0048000	135.7633000	0101000020E61000002D211FF46CF86040AA8251499D804140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.749483
353	55113	31pe122	\N	京漬物 野呂本店	https://image.anitabi.cn/points/55113/31pe122_1724031105709.jpg?plan=h160	1	609	35.0308000	135.7678000	0101000020E6100000CD3B4ED191F86040C05B2041F1834140	エンドス	\N	2026-05-04 16:22:33.78053
354	55113	ncsict5q3	\N	寺町通	https://image.anitabi.cn/points/55113/ncsict5q3_1724031193740.jpg?plan=h160	1	634	35.0306000	135.7678000	0101000020E6100000CD3B4ED191F86040F9A067B3EA834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.812987
355	55113	31pe127	\N	喫茶華波＆BAR華波様楽	https://image.anitabi.cn/points/55113/31pe127_1724031387926.jpg?plan=h160	1	914	35.0301000	135.7683000	0101000020E61000008AB0E1E995F8604007CE1951DA834140	エンドス	\N	2026-05-04 16:22:33.843758
357	55113	31pe13l	\N	ふじや鰹節店（東向き）	https://image.anitabi.cn/points/55113/31pe13l_1724030552200.jpg?plan=h160	1	277	35.0303000	135.7681000	0101000020E6100000D881734694F86040CE88D2DEE0834140	エンドス	\N	2026-05-04 16:22:33.912896
358	55113	31pe11w	出町桝形商店街	出町桝形商店街	https://image.anitabi.cn/user/0/bangumi/55113/points/31pe11w-1721282857697.jpg?plan=h160	1	43	35.0302000	135.7679000	0101000020E6100000265305A392F860406B2BF697DD834140	エンドス	\N	2026-05-04 16:22:33.94888
359	55113	ncs54km1j	\N	出町桝形商店街西口	https://image.anitabi.cn/points/55113/ncs54km1j_1724030399024.jpg?plan=h160	1	27	35.0303000	135.7678000	0101000020E6100000CD3B4ED191F86040CE88D2DEE0834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:33.982767
360	55113	ncs5k7ztt	\N	出町桝形商店街西口から寺町通上ル（南向き）	https://image.anitabi.cn/points/55113/ncs5k7ztt_1724030429754.jpg?plan=h160	2	1502	35.0302000	135.7679000	0101000020E6100000265305A392F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:34.014166
361	55113	31pe12z	\N	鯖のオブジェの十字路の北	https://image.anitabi.cn/points/55113/31pe12z_1724030968158.jpg?plan=h160	2	535	35.0303000	135.7685000	0101000020E61000003BDF4F8D97F86040CE88D2DEE0834140	エンドス	\N	2026-05-04 16:22:34.047104
362	55113	31pe139	\N	圣母学院	https://image.anitabi.cn/user/0/bangumi/55113/points/31pe139-1723990583533.jpg?plan=h160	2	317	34.9585000	135.7712000	0101000020E61000009B559FABADF86040A69BC420B07A4140	エンドス	\N	2026-05-04 16:22:34.088362
363	55113	ncsksngu4	\N	圣母学院 体育館	https://image.anitabi.cn/points/55113/ncsksngu4_1724031342965.jpg?plan=h160	1	815	34.9575000	135.7717000	0101000020E610000058CA32C4B1F86040C3F5285C8F7A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:34.121696
364	55113	ncsozwpmn	\N	JR京都伊势丹远眺五重塔	https://image.anitabi.cn/points/55113/ncsozwpmn_1724031596528.jpg?plan=h160	\N	3351	34.9858000	135.7575000	0101000020E61000000AD7A3703DF86040CA32C4B12E7E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:22:34.153935
365	55113	3jx379m	\N	出町ふたば	https://image.anitabi.cn/user/0/bangumi/55113/points/3jx379m-1754745146774.jpg?plan=h160	\N	\N	35.0300000	135.7696000	0101000020E61000000DE02D90A0F86040A4703D0AD7834140	\N	\N	2026-05-04 16:22:34.186181
367	216372	hsfz2u84q	喜撰茶屋	喜撰茶屋	https://image.anitabi.cn/points/216372/hsfz2u84q_1716641920345.jpg?plan=h160	\N	2890	34.8880000	135.8097000	0101000020E61000004772F90FE9F960408B6CE7FBA9714140	Anitabi	https://anitabi.cn/	2026-05-04 16:26:14.821338
368	216372	kqg6kaya1	\N	喜撰桥	https://image.anitabi.cn/points/216372/kqg6kaya1_1716638132855.jpg?plan=h160	\N	57	34.8880000	135.8097000	0101000020E61000004772F90FE9F960408B6CE7FBA9714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:14.855794
369	216372	kqhylwcti	\N	宇治神社 第一鸟居	https://image.anitabi.cn/points/216372/kqhylwcti_1716642010670.jpg?plan=h160	\N	2950	34.8904000	135.8099000	0101000020E6100000F9A067B3EAF96040E02D90A0F8714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:14.892134
370	216372	kqhz650z3	\N	大吉山展望台	https://image.anitabi.cn/points/216372/kqhz650z3_1716642041909.jpg?plan=h160	\N	2982	34.8925000	135.8121000	0101000020E61000009CA223B9FCF960400AD7A3703D724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:14.928008
371	216372	kqi06wpdm	\N	大吉山展望台 远眺宇治	https://image.anitabi.cn/points/216372/kqi06wpdm_1716642096526.jpg?plan=h160	\N	3018	34.8924000	135.8120000	0101000020E6100000448B6CE7FBF96040A779C7293A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:14.959759
372	216372	kqi28iqbf	\N	宇治橋西詰	https://image.anitabi.cn/points/216372/kqi28iqbf_1716642222223.jpg?plan=h160	\N	3087	34.8922000	135.8058000	0101000020E6100000BDE3141DC9F96040E0BE0E9C33724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:14.993024
373	216372	kqgcxao2m	\N	羽户山东南步行道	https://image.anitabi.cn/points/216372/kqgcxao2m_1716638540124.jpg?plan=h160	\N	121	34.9063000	135.8146000	0101000020E61000004BEA043411FA6040B22E6EA301744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.029357
374	216372	kqgeuztmt	\N	莵道高	https://image.anitabi.cn/points/216372/kqgeuztmt_1716638634832.jpg?plan=h160	\N	130	34.9090000	135.8157000	0101000020E61000001CEBE2361AFA60403108AC1C5A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.063654
375	216372	kqgixh282	\N	莵道高 小广场	https://image.anitabi.cn/points/216372/kqgixh282_1716638882684.jpg?plan=h160	\N	134	34.9091000	135.8160000	0101000020E6100000273108AC1CFA6040956588635D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.099461
376	216372	kqgtqv6s9	\N	莵道高 音乐室前	https://image.anitabi.cn/points/216372/kqgtqv6s9_1716639546322.jpg?plan=h160	\N	223	34.9096000	135.8165000	0101000020E6100000E3A59BC420FA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.140507
377	216372	kqhdzk793	\N	莵道高 3-4楼	https://image.anitabi.cn/points/216372/kqhdzk793_1716640763277.jpg?plan=h160	\N	1427	34.9096000	135.8163000	0101000020E610000032772D211FFA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.174388
378	216372	kqhenf5tq	\N	莵道高 中庭	https://image.anitabi.cn/points/216372/kqhenf5tq_1716640797442.jpg?plan=h160	\N	1565	34.9094000	135.8166000	0101000020E61000003CBD529621FA6040BF7D1D3867744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.207854
379	216372	kqhf96pwx	\N	莵道高 操场	https://image.anitabi.cn/points/216372/kqhf96pwx_1716640833256.jpg?plan=h160	\N	1627	34.9086000	135.8163000	0101000020E610000032772D211FFA6040A3923A014D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.24107
380	216372	kqhgo5i1r	\N	莵道高 藤架远眺京滋高速	https://image.anitabi.cn/points/216372/kqhgo5i1r_1716641113511.jpg?plan=h160	\N	1733	34.9081000	135.8172000	0101000020E610000052499D8026FA6040B1BFEC9E3C744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.274696
381	216372	kqhktv0sr	\N	莵道高 操场 树下	https://image.anitabi.cn/points/216372/kqhktv0sr_1716641173351.jpg?plan=h160	\N	1779	34.9086000	135.8157000	0101000020E61000001CEBE2361AFA6040A3923A014D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.309111
382	216372	kqh5i9qsk	\N	莵道高 音乐室	https://image.anitabi.cn/points/216372/kqh5i9qsk_1716640242332.jpg?plan=h160	\N	618	34.9096000	135.8167000	0101000020E610000095D4096822FA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.341848
383	216372	kqh5uls2d	\N	莵道高 边缘 房顶 全景	https://image.anitabi.cn/points/216372/kqh5uls2d_1716640277247.jpg?plan=h160	\N	672	34.9097000	135.8166000	0101000020E61000003CBD529621FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.375142
384	216372	kqib5bd2y	\N	莵道高 边缘 房顶 全景 阴天	https://image.anitabi.cn/points/216372/kqib5bd2y_1716642759365.jpg?plan=h160	\N	3499	34.9097000	135.8166000	0101000020E61000003CBD529621FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.406776
386	216372	kqighg23i	\N	莵道高 垃圾处理处	https://image.anitabi.cn/points/216372/kqighg23i_1716643096181.jpg?plan=h160	\N	3641	34.9100000	135.8164000	0101000020E61000008A8EE4F21FFA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.475748
387	216372	kqii0msb3	\N	莵道高 边缘	https://image.anitabi.cn/points/216372/kqii0msb3_1716643178161.jpg?plan=h160	\N	3820	34.9095000	135.8168000	0101000020E6100000EEEBC03923FA604023DBF97E6A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.510865
388	216372	kqikchdfm	\N	莵道高 藤架	https://image.anitabi.cn/points/216372/kqikchdfm_1716643323754.jpg?plan=h160	\N	4018	34.9093000	135.8168000	0101000020E6100000EEEBC03923FA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.543878
389	216372	kqgv70n0e	\N	莵道高 连接桥远眺另一处连接桥	https://image.anitabi.cn/points/216372/kqgv70n0e_1716639618949.jpg?plan=h160	\N	284	34.9098000	135.8163000	0101000020E610000032772D211FFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.577189
390	216372	kqgvoojf1	\N	莵道高 乐器仓库	https://image.anitabi.cn/points/216372/kqgvoojf1_1716639657653.jpg?plan=h160	\N	307	34.9105000	135.8163000	0101000020E610000032772D211FFA6040068195438B744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.612739
391	216372	kqgz3hrio	\N	宇治桥 三之间	https://image.anitabi.cn/points/216372/kqgz3hrio_1716639866211.jpg?plan=h160	\N	453	34.8927000	135.8061000	0101000020E6100000C7293A92CBF96040D1915CFE43724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.650379
395	216372	kqhus0a0j	\N	久美子椅	https://image.anitabi.cn/points/216372/kqhus0a0j_1716641768952.jpg?plan=h160	\N	2782	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.784675
396	216372	kqhbxzyru	\N	莵道高 洗手台	https://image.anitabi.cn/points/216372/kqhbxzyru_1716640637833.jpg?plan=h160	\N	1323	34.9099000	135.8163000	0101000020E610000032772D211FFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.817746
397	216372	kqi39ehxn	\N	莵道高 久美子练习处	https://image.anitabi.cn/points/216372/kqi39ehxn_1716645465562.jpg?plan=h160	\N	3347	34.9100000	135.8161000	0101000020E61000008048BF7D1DFA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.852955
398	216372	kqhcz231a	\N	莵道高 3-3	https://image.anitabi.cn/points/216372/kqhcz231a_1716640695586.jpg?plan=h160	\N	1365	34.9093000	135.8156000	0101000020E6100000C3D32B6519FA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.886574
399	216372	kqhd85i8u	\N	莵道高 远眺小广场 广角	https://image.anitabi.cn/points/216372/kqhd85i8u_1716640708036.jpg?plan=h160	\N	1369	34.9091000	135.8163000	0101000020E610000032772D211FFA6040956588635D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.918778
400	216372	kqhbg05yp	\N	府立宇治公园	https://image.anitabi.cn/points/216372/kqhbg05yp_1716640602534.jpg?plan=h160	\N	1154	34.8879000	135.8089000	0101000020E610000080B74082E2F96040280F0BB5A6714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.951441
401	216372	kqhvrma8p	\N	府立宇治公园 虚拟的久美子家位置	https://image.anitabi.cn/points/216372/kqhvrma8p_1716641840936.jpg?plan=h160	\N	2813	34.8874000	135.8090000	0101000020E6100000D9CEF753E3F96040363CBD5296714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.984695
403	216372	kqhqxrpju	山城综合运动公园太阳丘球技场	太陽ヶ丘球技場	https://image.anitabi.cn/points/216372/kqhqxrpju_1716641540666.jpg?plan=h160	\N	2363	34.8723000	135.8042000	0101000020E61000002F6EA301BCF960408126C286A76F4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.051601
404	216372	kqi7kxgtc	萨莉亚宇治里尻店 前	サイゼリヤ宇治​里​尻​店 前	https://image.anitabi.cn/points/216372/kqi7kxgtc_1716642543713.jpg?plan=h160	\N	3442	34.8924000	135.8047000	0101000020E6100000EBE2361AC0F96040A779C7293A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.086642
405	216372	kqiq2cs78	\N	宇治市​羽戸山​集会​所	https://image.anitabi.cn/points/216372/kqiq2cs78_1716643682236.jpg?plan=h160	\N	4158	34.9074000	135.8132000	0101000020E61000006EA301BC05FA6040F931E6AE25744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.119071
406	216372	kqiqpzy93	\N	第三儿童公园	https://image.anitabi.cn/points/216372/kqiqpzy93_1716643710071.jpg?plan=h160	\N	4159	34.9077000	135.8147000	0101000020E6100000A301BC0512FA6040234A7B832F744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.159248
407	216372	kqis6t099	\N	水管桥	https://image.anitabi.cn/points/216372/kqis6t099_1716643789759.jpg?plan=h160	\N	4273	34.9004000	135.8014000	0101000020E610000076E09C11A5F96040C1A8A44E40734140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.191637
408	216372	kqitevhc7	\N	府​立​山城​総合​運動​公園	https://image.anitabi.cn/points/216372/kqitevhc7_1716643872219.jpg?plan=h160	\N	4306	34.8682000	135.8053000	0101000020E6100000006F8104C5F960409031772D216F4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.228434
409	216372	kqj05rom9	\N	Actpal宇治	https://image.anitabi.cn/points/216372/kqj05rom9_1716644275376.jpg?plan=h160	\N	4325	34.9334000	135.8564000	0101000020E61000006C09F9A067FB60400F0BB5A679774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.261889
410	216372	k6mekik7h	京都会馆	ローム​シアター​京都	https://image.anitabi.cn/points/115908/k6mekik7h_1715084397561.jpg?plan=h160	\N	5572	35.0148000	135.7802000	0101000020E6100000DB8AFD65F7F860408BFD65F7E4814140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-04 16:26:16.298211
411	216372	e2890hr	电影前售券特典背景图	近江​舞子​中浜​水泳場	https://image.anitabi.cn/user/0/bangumi/216372/points/e2890hr-1777620121445.jpg?plan=h160	\N	\N	35.2307000	135.9626000	0101000020E610000026E4839ECDFE6040F697DD93879D4140	Anitabi	https://anitabi.cn/	2026-05-04 16:26:16.329498
412	428735	rdwqeevw4	\N	池袋駅東口交差点	https://image.anitabi.cn/points/428735/rdwqeevw4_1735403291084.jpg?plan=h160	1	3	35.7303000	139.7129000	0101000020E6100000302AA913D076614068226C787ADD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:54.874276
413	428735	rdw5s76mw	\N	サウンドスタジオノア池袋店	https://image.anitabi.cn/points/428735/rdw5s76mw_1735403639907.jpg?plan=h160	1	15	35.7336000	139.7170000	0101000020E61000006DE7FBA9F17661403D2CD49AE6DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:54.90647
414	428735	rdx1nx1ss	\N	サウンドスタジオノア池袋店前	https://image.anitabi.cn/points/428735/rdx1nx1ss_1735404150258.jpg?plan=h160	1	164	35.7338000	139.7169000	0101000020E610000014D044D8F076614004E78C28EDDD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:54.970149
415	428735	rdxn45u3w	希思罗机场路标	Heathrow Airport	https://image.anitabi.cn/points/428735/rdxn45u3w_1735405172960.jpg?plan=h160	1	182	51.4708000	-0.4889000	0101000020E6100000EEEBC039234ADFBF787AA52C43BC4940	Rubiscoo	\N	2026-05-04 16:30:55.201047
416	428735	ipq4b0s7c	希思罗机场T5航站楼	Heathrow Airport Terminal 5	https://image.anitabi.cn/points/428735/ipq4b0s7c_1735404239637.jpg?plan=h160	1	184	51.4693000	-0.4879000	0101000020E610000044FAEDEBC039DFBFA301BC0512BC4940	\N	\N	2026-05-04 16:30:55.232641
417	428735	rdx9ykshp	希思罗机场T5航站楼 D区	Heathrow Airport Terminal 5 Zone D	https://image.anitabi.cn/points/428735/rdx9ykshp_1735404408216.jpg?plan=h160	1	189	51.4718000	-0.4895000	0101000020E61000008716D9CEF753DFBF5C2041F163BC4940	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.280231
418	428735	idmkglyvy	\N	日本女子大学	https://image.anitabi.cn/points/428735/idmkglyvy_1735404704285.jpg?plan=h160	1	206	35.7174000	139.7205000	0101000020E6100000931804560E776140401361C3D3DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.717477%2C139.720534&z=17	2026-05-04 16:30:55.312002
419	428735	idmkglyv3	\N	学习院大学	https://image.anitabi.cn/points/428735/idmkglyv3_1735405268994.jpg?plan=h160	1	956	35.7186000	139.7093000	0101000020E6100000B1E1E995B2766140EB73B515FBDB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.71868%2C139.709305&z=17	2026-05-04 16:30:55.343731
420	428735	jq6yl4gxx	\N	カラオケ​館​池袋​東口​本店	https://image.anitabi.cn/points/428735/jq6yl4gxx_1735405300124.jpg?plan=h160	1	1079	35.7297000	139.7141000	0101000020E61000005B423EE8D976614013F241CF66DD4140	\N	\N	2026-05-04 16:30:55.383242
421	428735	rdxwnfne1	\N	Mixalive TOKYO	https://image.anitabi.cn/points/428735/rdxwnfne1_1735405808441.jpg?plan=h160	1	1238	35.7297000	139.7147000	0101000020E610000070CE88D2DE76614013F241CF66DD4140	\N	\N	2026-05-04 16:30:55.407471
422	428735	re418ivae	优衣库 池袋Sunshine60通店	ユニクロ 池袋サンシャイン６０通り店	https://image.anitabi.cn/points/428735/rdxwnfne1_1735405808441.jpg?plan=h160	1	1238	35.7299000	139.7153000	0101000020E6100000865AD3BCE3766140DAACFA5C6DDD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.43915
423	428735	rdy0mlquv	\N	サンシャイン前交差点	https://image.anitabi.cn/points/428735/rdy0mlquv_1735406013639.jpg?plan=h160	1	1313	35.7294000	139.7167000	0101000020E610000062A1D634EF766140E8D9ACFA5CDD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.470448
424	428735	idmkglzbq	\N	東池袋四丁目停留場	https://image.anitabi.cn/points/428735/idmkglzbq_1735409096430.jpg?plan=h160	2	49	35.7252000	139.7201000	0101000020E610000030BB270F0B7761409487855AD3DC4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.725283%2C139.720159&z=17	2026-05-04 16:30:55.502156
425	428735	rdzm5zqa9	柯尼卡美能达星象仪馆「满天」	コニカミノルタ プラネタリウム満天 in Sunshine City	https://image.anitabi.cn/points/428735/rdzm5zqa9_1735409622031.jpg?plan=h160	2	1233	35.7288000	139.7197000	0101000020E6100000CC5D4BC80777614093A9825149DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.533621
426	428735	rdzztl79q	Sunshine City西北台阶	サンシャインシティ	https://image.anitabi.cn/points/428735/rdzztl79q_1735410406822.jpg?plan=h160	2	1266	35.7298000	139.7179000	0101000020E61000008CB96B09F9766140764F1E166ADD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.578246
427	428735	nb7djwe3v	千登世小桥	千登世小橋	https://image.anitabi.cn/points/428735/nb7djwe3v_1735410914080.jpg?plan=h160	3	232	35.7187000	139.7137000	0101000020E6100000F7E461A1D67661404ED1915CFEDB4140	\N	\N	2026-05-04 16:30:55.596995
428	428735	re0kjl66x	大谷美术馆（旧古河邸）	大谷美術館（旧古河邸）	https://image.anitabi.cn/points/428735/re0kjl66x_1735411683968.jpg?plan=h160	3	320	35.7428000	139.7457000	0101000020E610000012143FC6DC77614002BC051214DF4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.644353
430	428735	idmkglyvd	\N	on the Corner	https://image.anitabi.cn/points/428735/idmkglyvd_1735411758439.jpg?plan=h160	3	495	35.7079000	139.7346000	0101000020E610000088F4DBD781776140516B9A779CDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.707904%2C139.734614&z=17	2026-05-04 16:30:55.719286
431	428735	jq6dt1nvm	\N	マメココロ​@​江戸川​橋	https://image.anitabi.cn/points/428735/jq6dt1nvm_1735411764248.jpg?plan=h160	3	495	35.7082000	139.7324000	0101000020E6100000E5F21FD26F7761407B832F4CA6DA4140	\N	\N	2026-05-04 16:30:55.751156
432	428735	idmkglz9m	千登世歩道橋	千登世步道桥	https://image.anitabi.cn/points/428735/idmkglz9m_1735412049583.jpg?plan=h160	3	726	35.7208000	139.7128000	0101000020E6100000D712F241CF766140787AA52C43DC4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.720835%2C139.712836&z=17	2026-05-04 16:30:55.782908
433	428735	re0rntu6g	千登世步道桥	千登世歩道橋	https://image.anitabi.cn/points/428735/re0rntu6g_1735411976160.jpg?plan=h160	3	732	35.7208000	139.7128000	0101000020E6100000D712F241CF766140787AA52C43DC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.81693
434	428735	re1p9ket8	千登世小桥南	千登世小橋南	https://image.anitabi.cn/points/428735/re1p9ket8_1735414017938.jpg?plan=h160	4	227	35.7186000	139.7136000	0101000020E61000009FCDAACFD5766140EB73B515FBDB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.846562
435	428735	re1smyo8x	\N	都電荒川線	https://image.anitabi.cn/points/428735/re1smyo8x_1735414217458.jpg?plan=h160	4	231	35.7184000	139.7135000	0101000020E610000046B6F3FDD476614024B9FC87F4DB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.877853
436	428735	re1wemt70	\N	富士見坂	https://image.anitabi.cn/points/428735/re1wemt70_1735414690851.jpg?plan=h160	4	398	35.7166000	139.7177000	0101000020E6100000DB8AFD65F776614024287E8CB9DB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.912075
437	428735	re2ha75og	\N	オーク東池袋ビル	https://image.anitabi.cn/points/428735/re2ha75og_1735415771428.jpg?plan=h160	4	1078	35.7297000	139.7147000	0101000020E610000070CE88D2DE76614013F241CF66DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:55.941978
438	428735	idmkglzf0	Sunshine60通	サンシャイン60通り	https://image.anitabi.cn/points/428735/idmkglzf0_1713214515341.jpg?plan=h160	4	1110	35.7298000	139.7152000	0101000020E61000002D431CEBE2766140764F1E166ADD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.72984%2C139.715294&z=17	2026-05-04 16:30:55.973687
439	428735	re2wo1uw1	\N	鬼子母神前踏切	https://image.anitabi.cn/points/428735/re2wo1uw1_1735416845868.jpg?plan=h160	4	1110	35.7202000	139.7150000	0101000020E61000007B14AE47E1766140234A7B832FDC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.00588
440	428735	re2sgkhvj	\N	西参道薬局	https://image.anitabi.cn/points/428735/re2sgkhvj_1735416385092.jpg?plan=h160	4	1119	35.7203000	139.7147000	0101000020E610000070CE88D2DE76614087A757CA32DC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.037564
441	428735	re3a9md4c	千登世桥附近	千登世橋北	https://image.anitabi.cn/points/428735/re3a9md4c_1735417476197.jpg?plan=h160	4	1123	35.7191000	139.7132000	0101000020E61000003B70CE88D2766140DC4603780BDC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.069687
442	428735	re3esdnfe	\N	高松灯家	https://image.anitabi.cn/points/428735/re3d6ihag_1735417647271.jpg?plan=h160	4	1170	35.7211000	139.7127000	0101000020E61000007FFB3A70CE766140A3923A014DDC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.101996
443	428735	idmkglz99	Sunshine City西侧	サンシャインシティ前	https://image.anitabi.cn/points/428735/idmkglz99_1735410226253.jpg?plan=h160	5	740	35.7300000	139.7179000	0101000020E61000008CB96B09F97661403D0AD7A370DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.730086%2C139.717925&z=17	2026-05-04 16:30:56.133907
444	428735	retadkfeu	Sunshine City	サンシャインシティ	https://image.anitabi.cn/points/428735/retadkfeu_1735474065491.jpg?plan=h160	5	751	35.7298000	139.7181000	0101000020E61000003EE8D9ACFA766140764F1E166ADD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.181731
445	428735	idmkglytn	丰岛区立东池袋中央公园	豊島区立東池袋中央公園	https://image.anitabi.cn/points/428735/idmkglytn_1735420211331.jpg?plan=h160	5	885	35.7301000	139.7186000	0101000020E6100000FB5C6DC5FE766140A167B3EA73DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.73012%2C139.718609&z=17	2026-05-04 16:30:56.217819
446	428735	idmkglyzw	Sunshine水族馆	サンシャイン​水族館	https://image.anitabi.cn/points/428735/idmkglyzw_1735420712105.jpg?plan=h160	5	946	35.7289000	139.7201000	0101000020E610000030BB270F0B776140F7065F984CDD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.728925%2C139.720157&z=17	2026-05-04 16:30:56.250923
447	428735	jqav45ypf	成田国际机场T2航站楼 航班信息显示系统	成田国際空港第2ターミナル フライトインフォメーションシステム	https://image.anitabi.cn/points/428735/jqav45ypf_1735421262128.jpg?plan=h160	5	1069	35.7736000	140.3886000	0101000020E6100000386744696F8C6140C217265305E34140	\N	\N	2026-05-04 16:30:56.283537
448	428735	rejioe3iy	成田国际机场T1航站楼 南翼 国际线出发值机柜台A	成田国際空港第1ターミナル チェックインカウンターA	https://image.anitabi.cn/points/428735/rejioe3iy_1735453115228.jpg?plan=h160	5	1072	35.7646000	140.3840000	0101000020E61000003F355EBA498C6140C442AD69DEE14140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.314717
449	428735	re5wsowfi	卡尔福德学校	Culford School	https://image.anitabi.cn/points/428735/re5wsowfi_1735423245574.jpg?plan=h160	5	1079	52.3015000	0.6848000	0101000020E610000027A089B0E1E9E53F3BDF4F8D97264A40	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.347651
450	428735	ii4jrgqq2	威斯敏斯特大桥	Westminster Bridge	https://image.anitabi.cn/points/428735/ii4jrgqq2_1735421286731.jpg?plan=h160	5	1151	51.5014000	-0.1222000	0101000020E61000002A3A92CB7F48BFBF711B0DE02DC04940	\N	\N	2026-05-04 16:30:56.380512
451	428735	idmkglz2c	面影桥	面影橋	https://image.anitabi.cn/points/428735/idmkglz2c_1735453846179.jpg?plan=h160	6	275	35.7131000	139.7142000	0101000020E6100000B459F5B9DA76614088635DDC46DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.713136%2C139.714256&z=17	2026-05-04 16:30:56.424444
452	428735	rek85hr29	\N	日本女子大前バス停	https://image.anitabi.cn/points/428735/rek85hr29_1735454364539.jpg?plan=h160	6	319	35.7161000	139.7201000	0101000020E610000030BB270F0B7761403255302AA9DB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.457731
453	428735	rekf5fvg0	\N	面影橋	https://image.anitabi.cn/points/428735/rekf5fvg0_1735454765007.jpg?plan=h160	6	781	35.7132000	139.7142000	0101000020E6100000B459F5B9DA766140ECC039234ADB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.490911
454	428735	idmkglz3p	\N	立希家	https://image.anitabi.cn/points/428735/idmkglz3p_1735454860885.jpg?plan=h160	6	784	35.7135000	139.7143000	0101000020E61000000D71AC8BDB76614017D9CEF753DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.713508%2C139.714316&z=17	2026-05-04 16:30:56.507759
456	428735	rekmumkuf	\N	ロッテリア 池袋東口店	https://image.anitabi.cn/points/428735/rekmumkuf_1735455221379.jpg?plan=h160	6	948	35.7295000	139.7141000	0101000020E61000005B423EE8D97661404C37894160DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.586265
457	428735	rel2pwter	\N	早稻田22号踏切	https://image.anitabi.cn/points/428735/rel2pwter_1735456307694.jpg?plan=h160	6	966	35.7228000	139.7169000	0101000020E610000014D044D8F07661403FC6DCB584DC4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.618253
458	428735	idmkglzh5	\N	東京都立新宿山吹高等学校	https://image.anitabi.cn/points/428735/idmkglzh5_1735457047238.jpg?plan=h160	6	1150	35.7072000	139.7281000	0101000020E6100000F7065F984C77614098DD938785DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.707254%2C139.728157&z=17	2026-05-04 16:30:56.65017
459	428735	reljglfe9	\N	Mixalive TOKYO前	https://image.anitabi.cn/points/428735/reljglfe9_1735457203557.jpg?plan=h160	7	1124	35.7297000	139.7147000	0101000020E610000070CE88D2DE76614013F241CF66DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.695234
460	428735	jq6rj0gje	\N	GIGO 総本店	https://image.anitabi.cn/points/428735/jq6rj0gje_1735457377117.jpg?plan=h160	7	1369	35.7296000	139.7147000	0101000020E610000070CE88D2DE766140AF94658863DD4140	\N	\N	2026-05-04 16:30:56.719265
461	428735	relsc7kez	\N	ラグーンビル池袋前	https://image.anitabi.cn/points/428735/relsc7kez_1735457835789.jpg?plan=h160	7	1402	35.7300000	139.7158000	0101000020E610000042CF66D5E77661403D0AD7A370DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.758907
462	428735	relyqzbah	西武池袋空中庭园	食と緑の空中庭園	https://image.anitabi.cn/points/428735/relyqzbah_1735458152012.jpg?plan=h160	8	552	35.7297000	139.7118000	0101000020E61000005F29CB10C776614013F241CF66DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.785678
463	428735	idmkglz1j	\N	飛鳥山停留場	https://image.anitabi.cn/points/428735/idmkglz1j_1735458521119.jpg?plan=h160	8	996	35.7502000	139.7374000	0101000020E61000004182E2C798776140C7BAB88D06E04140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.750295%2C139.737436&z=17	2026-05-04 16:30:56.817442
464	428735	lqg1szumg	本乡大道	本郷通り	https://image.anitabi.cn/points/428735/lqg1szumg_1735458694240.jpg?plan=h160	8	1005	35.7505000	139.7376000	0101000020E6100000F2B0506B9A776140F2D24D6210E04140	\N	\N	2026-05-04 16:30:56.851097
465	428735	remb1exoh	\N	飛鳥山公園	https://image.anitabi.cn/points/428735/remb1exoh_1735458906736.jpg?plan=h160	8	1025	35.7505000	139.7380000	0101000020E6100000560E2DB29D776140F2D24D6210E04140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.881123
466	428735	remrvrxk1	\N	素世家	https://image.anitabi.cn/points/428735/remrvrxk1_1735459888825.jpg?plan=h160	9	24	35.6594000	139.7277000	0101000020E610000093A9825149776140BF7D1D3867D44140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:56.912866
467	428735	mp20on0xq	都电荒川线 大塚站前踏切	大塚駅前踏切	https://image.anitabi.cn/points/428735/mp20on0xq_1735460471618.jpg?plan=h160	9	536	35.7311000	139.7291000	0101000020E61000006FF085C954776140840D4FAF94DD4140	\N	\N	2026-05-04 16:30:56.944428
468	428735	idmkglz2q	\N	早稲田停留場	https://image.anitabi.cn/points/428735/idmkglz2q_1735461424802.jpg?plan=h160	9	772	35.7117000	139.7193000	0101000020E610000069006F8104776140174850FC18DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.711776%2C139.719329&z=17	2026-05-04 16:30:56.976772
469	428735	renx1cu1b	稻荷坂 反光镜	稲荷坂 交通ミラー	https://image.anitabi.cn/points/428735/renx1cu1b_1735462420944.jpg?plan=h160	10	43	35.7157000	139.7169000	0101000020E610000014D044D8F0766140A4DFBE0E9CDB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.00882
470	428735	reo1s9qzr	富士见坂	富士見坂	https://image.anitabi.cn/points/428735/reo1s9qzr_1735462667782.jpg?plan=h160	10	47	35.7158000	139.7171000	0101000020E6100000C5FEB27BF2766140083D9B559FDB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.056806
471	428735	reo4bpn1g	目白台二丁目路口	目白台二丁目交差点	https://image.anitabi.cn/points/428735/reo4bpn1g_1735462854462.jpg?plan=h160	10	55	35.7167000	139.7182000	0101000020E610000097FF907EFB76614088855AD3BCDB4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.088759
472	428735	reosjjr33	\N	サンシャインシティ アネックス	https://image.anitabi.cn/points/428735/reosjjr33_1735464363800.jpg?plan=h160	10	252	35.7297000	139.7185000	0101000020E6100000A245B6F3FD76614013F241CF66DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.120844
473	428735	jq79uvaqd	JR目白站 1·2号线（山手线）站台	JR目白駅 1・2番線（山手線）ホーム	https://image.anitabi.cn/points/428735/jq79uvaqd_1735464803842.jpg?plan=h160	10	904	35.7196000	139.7059000	0101000020E6100000E3C798BB96766140CE1951DA1BDC4140	\N	\N	2026-05-04 16:30:57.153498
474	428735	rep1zlnjm	都营大江户线六本木站	都営大江戸線六本木駅	https://image.anitabi.cn/points/428735/rep1zlnjm_1735465059632.jpg?plan=h160	10	906	35.6636000	139.7317000	0101000020E6100000764F1E166A77614014D044D8F0D44140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.187401
475	428735	repam5rw9	\N	池袋駅東口前	https://image.anitabi.cn/points/428735/repam5rw9_1735465488007.jpg?plan=h160	11	621	35.7298000	139.7132000	0101000020E61000003B70CE88D2766140764F1E166ADD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.233183
476	428735	repfk0con	\N	池袋駅35番出入口	https://image.anitabi.cn/points/428735/repfk0con_1735465676437.jpg?plan=h160	11	641	35.7298000	139.7131000	0101000020E6100000E25817B7D1766140764F1E166ADD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.265659
477	428735	reppv6ikj	\N	西川口Live House Hearts	https://image.anitabi.cn/points/428735/reppv6ikj_1735466294950.jpg?plan=h160	11	680	35.8159000	139.7079000	0101000020E6100000D49AE61DA7766140386744696FE84140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.309274
478	428735	req0gx7eh	\N	東口五差路交差点	https://image.anitabi.cn/points/428735/req0gx7eh_1735466946107.jpg?plan=h160	12	1110	35.7296000	139.7139000	0101000020E6100000A913D044D8766140AF94658863DD4140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.338895
479	428735	req85sgf4	东京文华东方酒店	マンダリンオリエンタル東京	https://image.anitabi.cn/points/428735/req85sgf4_1735467635497.jpg?plan=h160	12	1160	35.6876000	139.7734000	0101000020E61000003F575BB1BF786140645DDC4603D84140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.366944
480	428735	idmkglza7	\N	成城学園前駅	https://image.anitabi.cn/points/428735/idmkglza7_1713214506334.jpg?plan=h160	13	18	35.6405000	139.5989000	0101000020E6100000613255302A736140448B6CE7FBD14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.640581%2C139.598931&z=17	2026-05-04 16:30:57.399316
481	428735	idmkglz0h	赤羽站西口	赤羽駅西口	https://image.anitabi.cn/points/428735/idmkglz0h_1735469461568.jpg?plan=h160	13	1396	35.7781000	139.7199000	0101000020E61000007E8CB96B097761404182E2C798E34140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.778144%2C139.719989&z=17	2026-05-04 16:30:57.43192
482	428735	rer9kfk32	\N	新幹線の高架下	https://image.anitabi.cn/points/428735/rer9kfk32_1735469670006.jpg?plan=h160	13	1401	35.7799000	139.7189000	0101000020E610000005A3923A01776140401361C3D3E34140	Anitabi@AmaiAya	https://anitabi.cn/	2026-05-04 16:30:57.465266
483	428735	td2hzw03n	若叶睦的豪宅	若叶睦的豪宅	https://image.anitabi.cn/points/428735/td2hzw03n_1740979602115.jpg?plan=h160	13	25	35.1407000	136.9476000	0101000020E610000011363CBD521E61400B46257502924140	Anitabi@ꦿ ひとり࿐	https://anitabi.cn/	2026-05-04 16:30:57.509554
484	428735	idmkglz1i	Symbol Tower	シンボルタワー	https://image.anitabi.cn/points/428735/idmkglz1i_1735467656703.jpg?plan=h160	13	0	35.6825000	139.7016000	0101000020E6100000F5DBD781737661408FC2F5285CD74140	Google Maps	https://www.google.com/maps/d/viewer?mid=1Bx4IeQCQlmRdjJCSQ5vLfxQ8DyhBLYE&ll=35.68259%2C139.701601&z=17	2026-05-04 16:30:57.542754
486	386195	kspxu21iu	羽户山绿地	羽戸山緑地	https://image.anitabi.cn/points/386195/kspxu21iu_1716816170420.jpg?plan=h160	\N	1037	34.9068000	135.8112000	0101000020E61000007DD0B359F5F96040A301BC0512744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.272872
490	386195	ksq1pzdpf	\N	京坂六地蔵駅 内	https://image.anitabi.cn/points/386195/ksq1pzdpf_1716816339760.jpg?plan=h160	\N	1141	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.526637
491	386195	l4pr3xhte	\N	京坂六地蔵駅 前	https://image.anitabi.cn/points/386195/l4pr3xhte_1717756063082.jpg?plan=h160	\N	1060	34.9320000	135.7934000	0101000020E6100000AF94658863F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 08:38:53.578389
493	386195	ksq2pihhp	Rohm剧院京都	ローム​シアター​京都	https://image.anitabi.cn/points/386195/ksq2pihhp_1716816395048.jpg?plan=h160	\N	74	35.0139000	135.7809000	0101000020E6100000492EFF21FDF860400BB5A679C7814140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.704997
494	386195	ksq3nyebc	莵道高中	莵道高	https://image.anitabi.cn/points/386195/ksq3nyebc_1716816452973.jpg?plan=h160	\N	1203	34.9090000	135.8161000	0101000020E61000008048BF7D1DFA60403108AC1C5A744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.748697
514	216228	4ui7mhfy0	\N	居酒屋・田や	https://image.anitabi.cn/points/216228/4ui7mhfy0.jpg?plan=h160	\N	\N	35.7617000	139.7227000	0101000020E6100000371AC05B207761407DAEB6627FE14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.761742%2C139.722767&z=17	2026-05-10 10:50:09.031537
503	216228	4ui7mhfq9	\N	広島のお好み焼 鉄板焼 HIROKI	https://image.anitabi.cn/points/216228/4ui7mhfq9.jpg?plan=h160	\N	\N	35.6600000	139.6677000	0101000020E610000041F163CC5D75614014AE47E17AD44140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.660046%2C139.667793&z=17	2026-05-10 10:50:01.965852
508	216228	4ui7mhfq3	\N	天ぷら「中山」	https://image.anitabi.cn/points/216228/4ui7mhfq3.jpg?plan=h160	\N	\N	35.6841000	139.7826000	0101000020E610000030BB270F0B796140C898BB9690D74140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.684108%2C139.782666&z=17	2026-05-10 10:50:05.345646
511	216228	4ui7mhg7f	\N	つちや食堂	https://image.anitabi.cn/points/216228/4ui7mhg7f.jpg?plan=h160	\N	\N	35.7025000	140.7063000	0101000020E6100000462575029A96614052B81E85EBD94140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.702562%2C140.706309&z=17	2026-05-10 10:50:07.189847
509	216228	4ui7mhg3v	\N	焼き肉「平和苑」	https://image.anitabi.cn/points/216228/4ui7mhg3v.jpg?plan=h160	\N	\N	35.7185000	139.6600000	0101000020E610000085EB51B81E7561408716D9CEF7DB4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.718586%2C139.660085&z=17	2026-05-10 10:50:05.959341
496	216228	4ui7mhg47	\N	食堂「和食亭」	https://image.anitabi.cn/points/216228/4ui7mhg47.jpg?plan=h160	\N	\N	35.7370000	139.7499000	0101000020E6100000A7E8482EFF7761407593180456DE4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.737045%2C139.749947&z=17	2026-05-10 10:49:57.572104
498	216228	4ui7mhfxp	\N	カフェ「Loco dish」	https://image.anitabi.cn/points/216228/4ui7mhfxp.jpg?plan=h160	\N	\N	35.6398000	139.9287000	0101000020E610000072F90FE9B77D61408BFD65F7E4D14140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.639851%2C139.928721&z=17	2026-05-10 10:49:58.899344
502	216228	4ui7mhfw7	\N	焼肉屋「つるや」	https://image.anitabi.cn/points/216228/4ui7mhfw7.jpg?plan=h160	\N	\N	35.5249000	139.6948000	0101000020E610000058A835CD3B766140D0D556EC2FC34140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.524915%2C139.694824&z=17	2026-05-10 10:50:01.357268
500	216228	4ui7mhg23	\N	とんかつ　みやこや	https://image.anitabi.cn/points/216228/4ui7mhg23.jpg?plan=h160	\N	\N	35.7236000	139.6387000	0101000020E6100000917EFB3A707461405BB1BFEC9EDC4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.723627%2C139.638795&z=17	2026-05-10 10:50:00.121001
499	216228	4ui7mhfw4	\N	釣り堀武蔵野園の食堂	https://image.anitabi.cn/points/216228/4ui7mhfw4.jpg?plan=h160	\N	\N	35.6858000	139.6396000	0101000020E6100000B1506B9A7774614064CC5D4BC8D74140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.685876%2C139.63966&z=17	2026-05-10 10:49:59.507905
513	216228	4ui7mhg25	\N	珈琲道場 侍	https://image.anitabi.cn/points/216228/4ui7mhg25.jpg?plan=h160	\N	\N	35.6985000	139.8308000	0101000020E61000008AB0E1E9957A6140C520B07268D94140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.698571%2C139.830865&z=17	2026-05-10 10:50:08.418032
506	216228	4ui7mhfr2	\N	草花木果	https://image.anitabi.cn/points/216228/4ui7mhfr2.jpg?plan=h160	\N	\N	35.6428000	139.6992000	0101000020E61000009FABADD85F76614035EF384547D24140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.642821%2C139.699243&z=17	2026-05-10 10:50:04.11812
501	216228	4ui7mhgag	\N	食事処/居酒屋「カヤシマ」	https://image.anitabi.cn/points/216228/4ui7mhgag.jpg?plan=h160	\N	\N	35.7060000	139.5789000	0101000020E6100000F1F44A5986726140EE7C3F355EDA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.706014%2C139.578948&z=17	2026-05-10 10:50:00.736852
510	216228	4ui7mhfp0	\N	キッチン友	https://image.anitabi.cn/points/216228/4ui7mhfp0.jpg?plan=h160	\N	\N	35.4890000	139.6267000	0101000020E6100000E78C28ED0D7461403BDF4F8D97BE4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.489008%2C139.6267&z=17	2026-05-10 10:50:06.57386
512	216228	4ui7mhfph	\N	割烹ちゃんこ「大内」	https://image.anitabi.cn/points/216228/4ui7mhfph.jpg?plan=h160	\N	\N	35.6935000	139.7930000	0101000020E61000004C3789416079614054E3A59BC4D84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.693596%2C139.793093&z=17	2026-05-10 10:50:07.764104
507	216228	4ui7mhg3z	\N	三ちゃん食堂	https://image.anitabi.cn/points/216228/4ui7mhg3z.jpg?plan=h160	\N	\N	35.5810000	139.6610000	0101000020E6100000FED478E926756140EE7C3F355ECA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.58102%2C139.661097&z=17	2026-05-10 10:50:04.728903
505	216228	4ui7mhg4r	\N	文京区の居酒屋「すみれ」	https://image.anitabi.cn/points/216228/4ui7mhg4r.jpg?plan=h160	\N	\N	35.7198000	139.7650000	0101000020E610000014AE47E17A78614095D4096822DC4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.719856%2C139.765002&z=17	2026-05-10 10:50:03.197609
659	152091	s8o3oavvc	\N	宇治国道踏切	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8o3oavvc-1737813719394.jpg?plan=h160	7	\N	34.8970000	135.8065000	0101000020E61000002B8716D9CEF96040894160E5D0724140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:57.566219
536	152091	kq63rnutq	\N	京坂黄檗站前踏切	https://image.anitabi.cn/points/152091/kq63rnutq_1716616209734.jpg?plan=h160	1	863	34.9072000	135.8053000	0101000020E6100000006F8104C5F9604032772D211F744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:31.441484
537	152091	kq7g1lkro	\N	喜撰桥 西	https://image.anitabi.cn/points/152091/kq7g1lkro_1716619112218.jpg?plan=h160	1	2519	34.8881000	135.8098000	0101000020E6100000A089B0E1E9F96040EFC9C342AD714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:32.056009
530	152091	kq5y9d6d9	\N	菊桥 远眺宇治桥	https://image.anitabi.cn/points/152091/kq5y9d6d9_1716615878186.jpg?plan=h160	1	768	34.8906000	135.8079000	0101000020E610000007CE1951DAF96040A7E8482EFF714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:27.447736
534	152091	kq57b68zu	\N	京坂黄檗站 前	https://image.anitabi.cn/points/152091/kq57b68zu_1716614239240.jpg?plan=h160	1	685	34.9142000	135.8022000	0101000020E61000003D9B559FABF9604069006F8104754140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:30.206349
669	152091	s8on30c2x	飛び出し注意看板（傘木希美）	お肉ダイニングきく	https://image.anitabi.cn/user/0/bangumi/152091/points/s8on30c2x-1753927880893.jpg?plan=h160	\N	\N	34.8915000	135.8056000	0101000020E61000000BB5A679C7F96040273108AC1C724140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:07.59874
525	211089	jyq9lfxe3	水管桥	水管橋	https://image.anitabi.cn/points/211089/jyq9lfxe3_1714465899645.jpg?plan=h160	\N	755	34.8992000	135.8023000	0101000020E610000096B20C71ACF96040174850FC18734140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:14:50.552502
485	386195	jzipmdpex	东隼上儿童公园	東​隼​上り​児童​公園	https://image.anitabi.cn/points/283643/jzipmdpex_1714527837706.jpg?plan=h160	\N	\N	34.9062000	135.8098000	0101000020E6100000A089B0E1E9F960404ED1915CFE734140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.216075
487	386195	kspzugpcs	羽户山第三儿童公园	8	https://image.anitabi.cn/points/386195/kspzugpcs_1716816234929.jpg?plan=h160	\N	1012	34.9078000	135.8146000	0101000020E61000004BEA043411FA604087A757CA32744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.341569
492	386195	ksq245cmm	Seven Eleven 宇治黄檗公园店	セブン​イレブン\n宇治​黄檗​公園​店	https://image.anitabi.cn/points/386195/ksq245cmm_1716816361068.jpg?plan=h160	\N	1040	34.9080000	135.8094000	0101000020E61000003D2CD49AE6F960404E62105839744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 08:38:53.658602
658	152091	s8ny3z4j3	塔見茶屋前	塔見茶屋	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8ny3z4j3-1737813358857.jpg?plan=h160	6	\N	34.8879000	135.8090000	0101000020E6100000D9CEF753E3F96040280F0BB5A6714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:56.334559
819	262940	l0m0ef68x	曙陆桥	曙陸橋	https://image.anitabi.cn/user/1099/bangumi/2585/points/l0m0ef68x-1717434763775.jpg?plan=h160	1	66	35.6987000	139.4181000	0101000020E6100000A54E4013616D61408CDB68006FD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:25.718914
1422	186515	e6b78c18	\N	三軒茶屋駅	https://image.anitabi.cn/points/186515/e6b78c18_1722414022709.jpg?plan=h160	5	316	35.6436000	139.6713000	0101000020E6100000C139234A7B75614051DA1B7C61D24140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.64364%2C139.671327&z=17	2026-06-09 19:30:12.201736
518	216228	4ui7mhga2	\N	魚谷	https://image.anitabi.cn/points/216228/4ui7mhga2.jpg?plan=h160	\N	\N	35.7081000	139.7334000	0101000020E61000005DDC46037877614018265305A3DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.708114%2C139.733457&z=17	2026-05-10 10:50:11.596777
529	152091	kq6qqpdzb	\N	宇治桥西	https://image.anitabi.cn/points/152091/kq6qqpdzb_1716617585537.jpg?plan=h160	1	1973	34.8926000	135.8055000	0101000020E6100000B29DEFA7C6F960406E3480B740724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:26.843158
523	216228	4ui7mhg3j	\N	どん平	https://image.anitabi.cn/points/216228/4ui7mhg3j.jpg?plan=h160	\N	\N	35.7489000	139.7652000	0101000020E6100000C6DCB5847C786140B9FC87F4DBDF4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.748994%2C139.765225&z=17	2026-05-10 10:50:14.870258
522	216228	4ui7mhfxh	\N	まちのパーラー	https://image.anitabi.cn/points/216228/4ui7mhfxh.jpg?plan=h160	\N	\N	35.7435000	139.6753000	0101000020E6100000A4DFBE0E9C756140BA490C022BDF4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.743531%2C139.675366&z=17	2026-05-10 10:50:14.256899
674	283643	l2mh8tcko	Seven Eleven便利店宇治三室户店	セブン​イレブン\n宇治​三室戸​店	https://image.anitabi.cn/points/283643/l2mh8tcko_1717592212934.jpg?plan=h160	9	1336	34.8983000	135.8110000	0101000020E6100000CBA145B6F3F9604097FF907EFB724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:14.764336
520	216228	4ui7mhg0k	\N	山源	https://image.anitabi.cn/points/216228/4ui7mhg0k.jpg?plan=h160	\N	\N	35.7473000	139.7187000	0101000020E610000054742497FF7661408126C286A7DF4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.747305%2C139.71879&z=17	2026-05-10 10:50:12.929246
516	216228	4ui7mhg1g	\N	川栄	https://image.anitabi.cn/points/216228/4ui7mhg1g.jpg?plan=h160	\N	\N	35.7801000	139.7201000	0101000020E610000030BB270F0B77614007CE1951DAE34140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.7801%2C139.720131&z=17	2026-05-10 10:50:10.262863
515	216228	4ui7mhfwj	\N	お食事 樹	https://image.anitabi.cn/points/216228/4ui7mhfwj.jpg?plan=h160	\N	\N	35.7001000	139.5588000	0101000020E610000027A089B0E1716140FDF675E09CD94140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.700108%2C139.558845&z=17	2026-05-10 10:50:09.642772
521	216228	4ui7mhfqc	\N	ボラーチョ	https://image.anitabi.cn/points/216228/4ui7mhfqc.jpg?plan=h160	\N	\N	35.6552000	139.6889000	0101000020E6100000DC4603780B7661406B2BF697DDD34140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.655266%2C139.68893&z=17	2026-05-10 10:50:13.640816
519	216228	4ui7mhgbe	\N	包 パオキャラヴァンサライ	https://image.anitabi.cn/points/216228/4ui7mhgbe.jpg?plan=h160	\N	\N	35.7057000	139.6823000	0101000020E6100000F241CF66D5756140C364AA6054DA4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.705799%2C139.68234&z=17	2026-05-10 10:50:12.307217
528	152091	kq5h19o6l	\N	宇治桥东	https://image.anitabi.cn/points/152091/kq5h19o6l_1716614824979.jpg?plan=h160	1	746	34.8934000	135.8068000	0101000020E610000036CD3B4ED1F960408A1F63EE5A724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:26.116674
527	152091	kq5gkb5y5	\N	京阪宇治站 前	https://image.anitabi.cn/points/152091/kq5gkb5y5_1716614800422.jpg?plan=h160	1	742	34.8939000	135.8065000	0101000020E61000002B8716D9CEF960407CF2B0506B724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:25.056725
548	152091	kqa3fqdn4	\N	莵道高 边缘	https://image.anitabi.cn/points/152091/kqa3fqdn4_1716624878597.jpg?plan=h160	4	459	34.9100000	135.8169000	0101000020E61000004703780B24FA604014AE47E17A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:39.735165
558	152091	kq3crkboi	\N	莵道高 小广场	https://image.anitabi.cn/user/1000/bangumi/152091/points/kq3crkboi-1716610244904.jpg?plan=h160	1	28	34.9092000	135.8158000	0101000020E610000075029A081BFA6040F8C264AA60744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:46.392218
565	152091	kq64lrxz9	\N	莵道高 教学楼入口	https://image.anitabi.cn/points/152091/kq64lrxz9_1716616251639.jpg?plan=h160	1	874	34.9091000	135.8164000	0101000020E61000008A8EE4F21FFA6040956588635D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:50.795726
551	152091	kq6wufb0f	\N	莵道高 连接桥 丽奈练习处 希美	https://image.anitabi.cn/points/152091/kq6wufb0f_1716617955100.jpg?plan=h160	1	2314	34.9097000	135.8163000	0101000020E610000032772D211FFA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:41.985768
540	152091	kq4v0iuzs	\N	莵道高 正门	https://image.anitabi.cn/points/152091/kq4v0iuzs_1716613499668.jpg?plan=h160	1	341	34.9089000	135.8156000	0101000020E6100000C3D32B6519FA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:33.904514
541	152091	kq6qzvqqh	\N	莵道高 正门 清晨	https://image.anitabi.cn/points/152091/kq6qzvqqh_1716617596247.jpg?plan=h160	1	1975	34.9089000	135.8156000	0101000020E6100000C3D32B6519FA6040CEAACFD556744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:34.514576
545	152091	kq9znj9hn	\N	莵道高 操场 远眺教学楼	https://image.anitabi.cn/points/152091/kq9znj9hn_1716624661570.jpg?plan=h160	4	286	34.9076000	135.8165000	0101000020E6100000E3A59BC420FA6040C0EC9E3C2C744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:37.896425
552	152091	kq691bmb7	\N	莵道高 连接桥 屋顶远眺	https://image.anitabi.cn/points/152091/kq691bmb7_1716616511126.jpg?plan=h160	1	1059	34.9097000	135.8166000	0101000020E61000003CBD529621FA6040EA95B20C71744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:42.602805
561	152091	kq6rb8j5b	\N	莵道高 一楼 连廊	https://image.anitabi.cn/points/152091/kq6rb8j5b_1716617625514.jpg?plan=h160	1	1977	34.9094000	135.8163000	0101000020E610000032772D211FFA6040BF7D1D3867744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:48.235114
563	152091	kqfl38qiv	\N	莵道高 3-3	https://image.anitabi.cn/points/152091/kqfl38qiv_1716636829700.jpg?plan=h160	4	1223	34.9094000	135.8156000	0101000020E6100000C3D32B6519FA6040BF7D1D3867744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:49.463407
554	152091	kqfjgz559	\N	莵道高 实验室	https://image.anitabi.cn/points/152091/kqfjgz559_1716636734863.jpg?plan=h160	4	641	34.9093000	135.8165000	0101000020E6100000E3A59BC420FA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:43.833605
560	152091	kq9xa0gz7	\N	莵道高 小广场 全景	https://image.anitabi.cn/points/152091/kq9xa0gz7_1716624507007.jpg?plan=h160	4	194	34.9092000	135.8159000	0101000020E6100000CE1951DA1BFA6040F8C264AA60744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:47.620428
556	152091	kq6s46lrd	\N	莵道高 办公室 外	https://image.anitabi.cn/points/152091/kq6s46lrd_1716617663476.jpg?plan=h160	1	2003	34.9102000	135.8167000	0101000020E610000095D4096822FA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:45.0613
547	152091	kqa041ybr	\N	莵道高 久美子练习处	https://image.anitabi.cn/points/152091/kqa041ybr_1716624683547.jpg?plan=h160	4	323	34.9101000	135.8163000	0101000020E610000032772D211FFA6040780B24287E744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:39.118653
550	152091	kq685xgk3	\N	莵道高 连接桥 丽奈练习处	https://image.anitabi.cn/points/152091/kq685xgk3_1716616457260.jpg?plan=h160	1	1043	34.9098000	135.8163000	0101000020E610000032772D211FFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:41.373102
566	152091	kq652cqo4	\N	莵道高 连廊 （未确定）	https://image.anitabi.cn/points/152091/kq652cqo4_1716616278584.jpg?plan=h160	1	878	34.9102000	135.8168000	0101000020E6100000EEEBC03923FA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:51.40883
570	152091	kqffxdzti	\N	莵道高 洗手台 （不确定）	https://image.anitabi.cn/points/152091/kqffxdzti_1716636531855.jpg?plan=h160	4	496	34.9099000	135.8163000	0101000020E610000032772D211FFA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:54.174656
555	152091	kq4wi6esb	\N	莵道高 办公室	https://image.anitabi.cn/points/152091/kq4wi6esb_1716613578593.jpg?plan=h160	1	381	34.9102000	135.8166000	0101000020E61000003CBD529621FA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:44.44591
562	152091	kq6vy5a58	\N	莵道高 教学楼 三四楼阶梯	https://image.anitabi.cn/points/152091/kq6vy5a58_1716617899880.jpg?plan=h160	1	2263	34.9093000	135.8164000	0101000020E61000008A8EE4F21FFA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:48.850638
559	152091	kq6b29rf5	\N	莵道高 小广场 全景 黄昏	https://image.anitabi.cn/points/152091/kq6b29rf5_1716616632171.jpg?plan=h160	1	1630	34.9090000	135.8160000	0101000020E6100000273108AC1CFA60403108AC1C5A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:47.006825
567	152091	kq4ww3r0q	\N	莵道高 音乐室	https://image.anitabi.cn/points/152091/kq4ww3r0q_1716613599526.jpg?plan=h160	1	404	34.9096000	135.8167000	0101000020E610000095D4096822FA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:52.127219
569	152091	kq679tr6z	\N	莵道高 房顶视角	https://image.anitabi.cn/points/152091/kq679tr6z_1716616402927.jpg?plan=h160	1	947	34.9096000	135.8161000	0101000020E61000008048BF7D1DFA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:53.457024
557	152091	kq65ko3g5	\N	莵道高 楼梯 （未确定）	https://image.anitabi.cn/points/152091/kq65ko3g5_1716616317134.jpg?plan=h160	1	933	34.9102000	135.8169000	0101000020E61000004703780B24FA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:45.777153
568	152091	kq69j5ies	\N	莵道高 音乐室外 洗手台	https://image.anitabi.cn/points/152091/kq69j5ies_1716616543633.jpg?plan=h160	1	1119	34.9096000	135.8166000	0101000020E61000003CBD529621FA60408638D6C56D744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:52.842872
564	152091	kqflzt56t	\N	莵道高 3-3 远眺宇治	https://image.anitabi.cn/points/152091/kqflzt56t_1716636898171.jpg?plan=h160	4	1285	34.9093000	135.8156000	0101000020E6100000C3D32B6519FA60405C2041F163744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:50.082226
601	152091	kq72ewk7h	\N	宇治神社第一鸟居	https://image.anitabi.cn/points/152091/kq72ewk7h_1716618539445.jpg?plan=h160	1	2400	34.8904000	135.8098000	0101000020E6100000A089B0E1E9F96040E02D90A0F8714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:19.672614
587	152091	kq4zk9s64	\N	京坂六地藏站 内 远眺 黄昏	https://image.anitabi.cn/points/152091/kq4zk9s64_1716613760665.jpg?plan=h160	1	621	34.9320000	135.7929000	0101000020E6100000F31FD26F5FF960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:10.865944
586	152091	kq52g1he3	\N	京坂六地藏站 内 入站楼梯出口前 全景	https://image.anitabi.cn/points/152091/kq52g1he3_1716613934510.jpg?plan=h160	1	673	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:10.148092
583	152091	kq51828ln	\N	京坂六地藏站 内 LED屏	https://image.anitabi.cn/points/152091/kq51828ln_1716613861261.jpg?plan=h160	1	668	34.9319000	135.7934000	0101000020E6100000AF94658863F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:08.176722
593	152091	kq4kclz3m	\N	京都音乐厅 正门前	https://image.anitabi.cn/points/152091/kq4kclz3m_1716612844050.jpg?plan=h160	1	180	35.0502000	135.7662000	0101000020E61000003FC6DCB584F860402D211FF46C864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:14.650276
580	152091	kq50i4b5p	\N	京坂六地藏站 内 广告牌 中景	https://image.anitabi.cn/points/152091/kq50i4b5p_1716613821511.jpg?plan=h160	1	636	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:06.257839
594	152091	kq4lf4gwu	\N	京都音乐厅 正门前 眺望 全景	https://image.anitabi.cn/points/152091/kq4lf4gwu_1716612906048.jpg?plan=h160	1	183	35.0501000	135.7663000	0101000020E610000098DD938785F86040CAC342AD69864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:15.268345
600	152091	kq71t00pp	Cosmo石油宇治新町	コスモ​石油\n宇治新​町	https://image.anitabi.cn/points/152091/kq71t00pp_1716618252827.jpg?plan=h160	1	2396	34.8872000	135.7990000	0101000020E610000021B0726891F960406F8104C58F714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:19.057206
596	152091	kq4tg8kw7	\N	京都音乐厅 正门前 合影处	https://image.anitabi.cn/points/152091/kq4tg8kw7_1716613391412.jpg?plan=h160	1	251	35.0502000	135.7662000	0101000020E61000003FC6DCB584F860402D211FF46C864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:16.44532
598	152091	kq6gb0mgb	\N	711黄檗公园店	https://image.anitabi.cn/points/152091/kq6gb0mgb_1716616956912.jpg?plan=h160	1	1791	34.9082000	135.8096000	0101000020E6100000EE5A423EE8F96040151DC9E53F744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:17.628509
595	152091	kq4sxoyyq	\N	京都音乐厅 正门前 合影处（不确定）	https://image.anitabi.cn/points/152091/kq4sxoyyq_1716613379086.jpg?plan=h160	1	230	35.0502000	135.7662000	0101000020E61000003FC6DCB584F860402D211FF46C864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:15.879319
581	152091	kq50n8ggr	\N	京坂六地藏站 内 广告牌 特写 小绿	https://image.anitabi.cn/points/152091/kq50n8ggr_1716613825619.jpg?plan=h160	1	654	34.9319000	135.7934000	0101000020E6100000AF94658863F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:06.872127
579	152091	kq50bjycu	\N	京坂六地藏站 内 广告牌 特写	https://image.anitabi.cn/points/152091/kq50bjycu_1716613805721.jpg?plan=h160	1	633	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:05.570507
578	152091	kq4zwsbni	\N	京坂六地藏站 内 广告牌	https://image.anitabi.cn/points/152091/kq4zwsbni_1716613785055.jpg?plan=h160	1	623	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:04.311707
585	152091	kq52af646	\N	京坂六地藏站 内 入站楼梯出口前 小绿特写	https://image.anitabi.cn/points/152091/kq52af646_1716613925262.jpg?plan=h160	1	671	34.9319000	135.7933000	0101000020E6100000567DAEB662F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:09.53504
575	152091	kq6bvjsej	\N	莵道高 小天使练习处（未找到）	https://image.anitabi.cn/points/152091/kq6bvjsej_1716616681597.jpg?plan=h160	1	1682	34.9102000	135.8164000	0101000020E61000008A8EE4F21FFA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:57.450532
582	152091	kq50x3w5x	\N	京坂六地藏站 内 广告牌 特写 叶月	https://image.anitabi.cn/points/152091/kq50x3w5x_1716613842230.jpg?plan=h160	1	664	34.9319000	135.7934000	0101000020E6100000AF94658863F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:07.590251
589	152091	sfexqbi3k	\N	水管桥	https://image.anitabi.cn/points/216372/sfexqbi3k_1738342292024.jpg?plan=h160	9	1394	34.9005000	135.8014000	0101000020E610000076E09C11A5F960402506819543734140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:12.097656
592	152091	kq4hfpzmu	\N	京都音乐厅 外	https://image.anitabi.cn/points/152091/kq4hfpzmu_1716612665978.jpg?plan=h160	1	171	35.0503000	135.7663000	0101000020E610000098DD938785F86040917EFB3A70864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:14.039735
591	152091	kq4fpoiul	\N	京都音乐厅	https://image.anitabi.cn/points/152091/kq4fpoiul_1716612568968.jpg?plan=h160	1	175	35.0502000	135.7664000	0101000020E6100000F1F44A5986F860402D211FF46C864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:13.424801
597	152091	kq4ubbcw9	\N	京都音乐厅 正门前 伞	https://image.anitabi.cn/points/152091/kq4ubbcw9_1716613442911.jpg?plan=h160	1	332	35.0502000	135.7663000	0101000020E610000098DD938785F860402D211FF46C864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:17.009536
573	152091	kq9ycga5u	\N	莵道高 远眺 连接廊	https://image.anitabi.cn/points/152091/kq9ycga5u_1716624570737.jpg?plan=h160	4	249	34.9099000	135.8166000	0101000020E61000003CBD529621FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:56.222734
574	152091	kq6sp0h6u	\N	莵道高 四楼 远眺 全景	https://image.anitabi.cn/points/152091/kq6sp0h6u_1716617709507.jpg?plan=h160	1	2016	34.9098000	135.8158000	0101000020E610000075029A081BFA60404DF38E5374744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:56.838061
615	152091	kq9itt875	\N	アクトパル宇治 宿泊棟 远眺（未确定）	https://image.anitabi.cn/points/152091/kq9itt875_1716623637268.jpg?plan=h160	3	1224	34.9347000	135.8548000	0101000020E6100000DE9387855AFB60401DC9E53FA4774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:28.888414
624	152091	4x30jwi	\N	​羽戸山​西侧长台阶附近	https://image.anitabi.cn/points/152091/4x30jwi_1757717942867.jpg?plan=h160	9	733	34.9073000	135.8104000	0101000020E6100000B515FBCBEEF9604095D4096822744140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:34.519905
606	152091	kq8fcosqk	\N	アクトパル宇治	https://image.anitabi.cn/points/152091/kq8fcosqk_1716621284686.jpg?plan=h160	2	738	34.9336000	135.8562000	0101000020E6100000BADA8AFD65FB6040D6C56D3480774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:22.947192
630	152091	p9th5vriy	\N	中庭の大階段	https://image.anitabi.cn/user/0/bangumi/152091/points/p9th5vriy-1729440453338.jpg?plan=h160	12	938	35.1313000	136.8985000	0101000020E6100000986E1283C01C61407FFB3A70CE904140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:38.205909
621	152091	k6m5xw8hu	\N	尼崎市総合文化センター	https://image.anitabi.cn/points/115908/k6m5xw8hu_1715083879211.jpg?plan=h160	5	739	34.7211000	135.4200000	0101000020E61000003D0AD7A370ED6040A3923A014D5C4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:21:32.569525
603	152091	kq7bug0r0	\N	朝雾桥 远眺京阪宇治站 黄昏	https://image.anitabi.cn/points/152091/kq7bug0r0_1716618861529.jpg?plan=h160	1	2504	34.8900000	135.8089000	0101000020E610000080B74082E2F9604052B81E85EB714140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:21.006498
623	152091	k6m1juzao	名古屋国际会议中心	名古屋国际会议中心	https://image.anitabi.cn/points/115908/k6m1juzao_1715083679091.jpg?plan=h160	12	1334	35.1326000	136.8965000	0101000020E6100000A69BC420B01C61408CB96B09F9904140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:21:33.753082
622	152091	qys7jh	\N	喜撰橋前郵便ポスト	https://image.anitabi.cn/user/0/bangumi/115908/points/qys7jh-1697124519592.jpg?plan=h160	13	492	34.8881000	135.8097000	0101000020E61000004772F90FE9F96040EFC9C342AD714140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=34.888149%2C135.809744&z=17	2026-05-10 11:21:33.191825
608	152091	kq95gm1cd	\N	宇治市​総合​野外​活動​センター（未确定）	https://image.anitabi.cn/points/152091/kq95gm1cd_1716622830907.jpg?plan=h160	3	392	34.9339000	135.8556000	0101000020E6100000A54E401361FB604001DE02098A774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:24.173657
628	152091	p9ra6zd93	\N	センチュリーホール ホワイエ	https://image.anitabi.cn/user/0/bangumi/152091/points/p9ra6zd93-1729435682971.jpg?plan=h160	12	706	35.1326000	136.8983000	0101000020E6100000E63FA4DFBE1C61408CB96B09F9904140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:36.977086
627	152091	p9lzb9vbq	\N	日比野駅	https://image.anitabi.cn/user/0/bangumi/152091/points/p9lzb9vbq-1729424142036.jpg?plan=h160	12	431	35.1331000	136.8940000	0101000020E6100000F853E3A59B1C61407E8CB96B09914140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:36.364944
632	152091	ptcrup9aq	\N	宇治市天之濑墓地公园 小径	https://image.anitabi.cn/user/0/bangumi/152091/points/ptcrup9aq-1730971461948.jpg?plan=h160	11	1208	34.8772000	135.8220000	0101000020E6100000FCA9F1D24DFA60408E06F01648704140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:39.636505
616	152091	kq9mofobb	\N	Actpal宇治 前步行路	https://image.anitabi.cn/points/152091/kq9mofobb_1716623865596.jpg?plan=h160	3	1228	34.9344000	135.8556000	0101000020E6100000A54E401361FB6040F2B0506B9A774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:29.502214
635	152091	4xv25qy	\N	車田児童遊園	https://image.anitabi.cn/points/152091/4xv25qy_1757765033463.jpg?plan=h160	1	2718	34.8997000	135.8023000	0101000020E610000096B20C71ACF96040091B9E5E29734140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:41.480023
614	152091	kq98amjeh	\N	アクトパル宇治 宿泊棟 二年（未确定）	https://image.anitabi.cn/points/152091/kq98amjeh_1716622995325.jpg?plan=h160	3	564	34.9347000	135.8547000	0101000020E6100000857CD0B359FB60401DC9E53FA4774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:28.272739
625	152091	ogyq99976	京都站大阶梯	京都​駅​ビル​大階段	https://image.anitabi.cn/user/0/bangumi/152091/points/ogyq99976-1727179347579.jpg?plan=h160	7	1150	34.9857000	135.7564000	0101000020E610000039D6C56D34F8604067D5E76A2B7E4140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:35.130528
626	152091	p1vy8ihzo	名古屋国际会议场	名古屋国際会議場	https://image.anitabi.cn/points/152091/p1vy8ihzo_1728818907518.jpg?plan=h160	12	388	35.1316000	136.8983000	0101000020E6100000E63FA4DFBE1C6140A913D044D8904140	Anitabi@LovelySummer Channel	https://anitabi.cn/	2026-05-10 11:21:35.748112
633	152091	ptcyjg16v	\N	千寻的墓	https://image.anitabi.cn/user/0/bangumi/152091/points/ptcyjg16v-1730971777403.jpg?plan=h160	11	2024	34.8772000	135.8220000	0101000020E6100000FCA9F1D24DFA60408E06F01648704140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:40.25398
646	152091	304k893	\N	京都车站 乌丸小路广场	https://image.anitabi.cn/user/0/bangumi/152091/points/304k893-1753548487401.jpg?plan=h160	7	1031	34.9856000	135.7561000	0101000020E61000002E90A0F831F8604003780B24287E4140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:48.857629
665	152091	s35wgc3tp	京都站	京都站	https://image.anitabi.cn/user/0/bangumi/152091/points/s35wgc3tp-1737382269278.jpg?plan=h160	\N	\N	34.9857000	135.7564000	0101000020E610000039D6C56D34F8604067D5E76A2B7E4140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:04.010281
657	152091	s8nvhalyd	\N	本町通り	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8nvhalyd-1737813239942.jpg?plan=h160	6	\N	34.8879000	135.8045000	0101000020E610000039B4C876BEF96040280F0BB5A6714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:55.719638
639	152091	s8n7xn1da	\N	宇治日の出園	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8n7xn1da-1737811777486.jpg?plan=h160	6	1147	34.8880000	135.8086000	0101000020E610000076711B0DE0F960408B6CE7FBA9714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:44.04426
644	152091	t24r480zx	\N	羽户山集会所前	https://image.anitabi.cn/points/152091/t24r480zx_1740122500054.jpg?plan=h160	9	659	34.9075000	135.8131000	0101000020E6100000158C4AEA04FA60405C8FC2F528744140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:47.637915
645	152091	2106zs5	茶与宇治之街历史公园	お茶と宇治のまち歴史公園	https://image.anitabi.cn/user/0/bangumi/152091/points/2106zs5-1751424749757.jpg?plan=h160	9	1396	34.8956000	135.8047000	0101000020E6100000EBE2361AC0F9604018265305A3724140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:48.243947
655	152091	s8nntkq40	\N	コーポラス三光園	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8nntkq40-1737812741032.jpg?plan=h160	6	\N	34.8888000	135.8053000	0101000020E6100000006F8104C5F96040A857CA32C4714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:54.492432
648	152091	kq3fgyt1k	\N	莵道高 小广场 香织 OP	https://image.anitabi.cn/points/152091/kq3fgyt1k_1716610371334.jpg?plan=h160	1	\N	34.9090000	135.8159000	0101000020E6100000CE1951DA1BFA60403108AC1C5A744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:50.091824
654	152091	s8n19fbyj	\N	宇治モータース販売	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8n19fbyj-1737811466674.jpg?plan=h160	6	\N	34.8880000	135.8054000	0101000020E6100000598638D6C5F960408B6CE7FBA9714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:53.873842
662	152091	k6mdssvgm	\N	ローム​シアター​京都	https://image.anitabi.cn/points/115908/k6mdssvgm_1715084354047.jpg?plan=h160	\N	\N	35.0127000	135.7800000	0101000020E6100000295C8FC2F5F8604061545227A0814140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:00.836216
666	152091	s8mi4z9jp	京阪宇治站西侧	宇治駅	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8mi4z9jp-1737810221567.jpg?plan=h160	\N	\N	34.8944000	135.8060000	0101000020E61000006F1283C0CAF960406DC5FEB27B724140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:04.929077
656	152091	s8npch266	松阪屋嘉八本店	あがた通り 松阪屋嘉八 本店	https://image.anitabi.cn/user/2168/bangumi/152091/points/s8npch266-1737812829460.jpg?plan=h160	6	\N	34.8881000	135.8054000	0101000020E6100000598638D6C5F96040EFC9C342AD714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:55.101684
663	152091	k6mjl3l5v	京都站前	京都​駅​前	https://image.anitabi.cn/points/115908/k6mjl3l5v_1715084706169.jpg?plan=h160	\N	\N	34.9865000	135.7605000	0101000020E61000007593180456F8604083C0CAA1457E4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:01.762412
651	152091	kq417mb3n	\N	水管桥 OP	https://image.anitabi.cn/user/0/bangumi/152091/points/kq417mb3n-1721808377557.jpg?plan=h160	1	\N	34.9004000	135.8014000	0101000020E610000076E09C11A5F96040C1A8A44E40734140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:52.031283
653	152091	t256hmvkl	\N	名古屋國際會議場	https://image.anitabi.cn/points/152091/t256hmvkl_1740123428741.jpg?plan=h160	12	\N	35.1320000	136.8979000	0101000020E610000082E2C798BB1C614037894160E5904140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:21:53.261677
667	152091	sff2b89ni	\N	飛び出し注意看板（中世古香織）	https://image.anitabi.cn/user/0/bangumi/152091/points/sff2b89ni-1753927767883.jpg?plan=h160	\N	\N	34.8980000	135.8076000	0101000020E6100000FD87F4DBD7F960406DE7FBA9F1724140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:05.954817
700	283643	k6n5yemmn	名古屋国际会议场	名古屋​国際​会議場	https://image.anitabi.cn/user/1058/bangumi/283643/points/k6n5yemmn-1715086052701.jpg?plan=h160	3	92	35.1321000	136.8982000	0101000020E61000008D28ED0DBE1C61409BE61DA7E8904140	Anitabi@Eureka	https://anitabi.cn/	2026-05-10 11:22:31.567961
677	283643	jyrbcu62b	\N	井川用水機場	https://image.anitabi.cn/points/283643/jyrbcu62b_1714468174687.jpg?plan=h160	1	131	34.8896000	135.8082000	0101000020E610000012143FC6DCF96040C442AD69DE714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:16.620882
684	283643	jywbxnhwb	\N	京都府立菟道高校（校内）	https://image.anitabi.cn/points/283643/jywbxnhwb_1714479089640.jpg?plan=h160	1	792	34.9090000	135.8161000	0101000020E61000008048BF7D1DFA60403108AC1C5A744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:20.907734
683	283643	jyrtawlki	\N	京都府立菟道高校（校外）	https://image.anitabi.cn/points/283643/jyrtawlki_1714469255621.jpg?plan=h160	1	790	34.9089000	135.8156000	0101000020E6100000C3D32B6519FA6040CEAACFD556744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:20.288943
673	283643	jyrgrhwa6	\N	六地藏駅	https://image.anitabi.cn/points/283643/jyrgrhwa6_1714468534868.jpg?plan=h160	1	161	34.9319000	135.7935000	0101000020E610000008AC1C5A64F960403A92CB7F48774140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:14.15409
681	283643	jys1r0y4v	\N	京阪電車 宇治駅	https://image.anitabi.cn/points/283643/jys1r0y4v_1714469767087.jpg?plan=h160	2	637	34.8942000	135.8066000	0101000020E6100000849ECDAACFF96040A60A462575724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:19.162687
686	283643	jyw7l32o0	\N	羽户山绿地	https://image.anitabi.cn/points/283643/jyw7l32o0_1714478842854.jpg?plan=h160	2	36	34.9073000	135.8105000	0101000020E61000000E2DB29DEFF9604095D4096822744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:22.065288
688	283643	jyx68ib21	\N	京阪宇治ビル	https://image.anitabi.cn/points/283643/jyx68ib21_1714480920065.jpg?plan=h160	2	683	34.8941000	135.8066000	0101000020E6100000849ECDAACFF9604043AD69DE71724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:23.176946
691	283643	jyqqfkxxr	\N	宇治橋西詰	https://image.anitabi.cn/points/283643/jyqqfkxxr_1714466990385.jpg?plan=h160	1	136	34.8925000	135.8054000	0101000020E6100000598638D6C5F960400AD7A3703D724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:25.617916
689	283643	jyxc31f60	\N	宇治公园	https://image.anitabi.cn/points/283643/jyxc31f60_1714481274870.jpg?plan=h160	2	1221	34.8898000	135.8087000	0101000020E6100000CE88D2DEE0F960408BFD65F7E4714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:23.983012
680	283643	l97o7hnpz	\N	宇治神社前	https://image.anitabi.cn/points/283643/l97o7hnpz_1718108527678.jpg?plan=h160	10	455	34.8907000	135.8095000	0101000020E610000096438B6CE7F960400B46257502724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:18.559227
685	283643	l2m47z99d	\N	朝雾橋	https://image.anitabi.cn/points/283643/l2m47z99d_1717591455093.jpg?plan=h160	9	1193	34.8902000	135.8094000	0101000020E61000003D2CD49AE6F960401973D712F2714140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:21.525114
698	283643	kc5fvh7sk	宇治市源氏物语博物馆	源氏​物語​ミュージアム	https://image.anitabi.cn/user/0/bangumi/283643/points/kc5fvh7sk-1715517820209.jpg?plan=h160	5	948	34.8942000	135.8108000	0101000020E61000001973D712F2F96040A60A462575724140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:30.233468
696	283643	l2n29rq3q	山城综合运动公园	山城​総合​運動​公園	https://image.anitabi.cn/points/283643/l2n29rq3q_1717593480737.jpg?plan=h160	7	1223	34.8694000	135.8045000	0101000020E610000039B4C876BEF960403A92CB7F486F4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:28.996782
697	283643	kpy6uawrr	\N	山城​総合​運動​公園	https://image.anitabi.cn/points/283643/kpy6uawrr_1716598967863.jpg?plan=h160	7	1216	34.8694000	135.8045000	0101000020E610000039B4C876BEF960403A92CB7F486F4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:29.616988
694	283643	jzhkb394u	许波多神社	許波多神社	https://image.anitabi.cn/points/283643/jzhkb394u_1714525329267.jpg?plan=h160	2	1402	34.9163000	135.7939000	0101000020E61000006C09F9A067F9604093A9825149754140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:27.767353
692	283643	jyxrnlmjo	东隼上儿童公园	東​隼​上り​児童​公園	https://image.anitabi.cn/points/283643/jyxrnlmjo_1714482216377.jpg?plan=h160	3	1322	34.9064000	135.8095000	0101000020E610000096438B6CE7F96040158C4AEA04744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:26.548064
695	283643	jt3mbshtu	许波多神社 本殿	許波多神社 本殿	https://image.anitabi.cn/user/0/bangumi/115908/points/jt3mbshtu-1714024831284.jpg?plan=h160	3	110	34.9170000	135.7940000	0101000020E6100000C520B07268F960404C37894160754140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:28.382004
693	283643	jyxsfaxzh	京都府立山城综合运动公园田径赛场	府​立​山城​総合​運動​公園\n陸上​競技場	https://image.anitabi.cn/points/283643/jyxsfaxzh_1714482306157.jpg?plan=h160	3	1396	34.8705000	135.8060000	0101000020E61000006F1283C0CAF960408195438B6C6F4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:27.165785
699	283643	kbkunv117	隐元桥	隠元橋	https://image.anitabi.cn/points/283643/kbkunv117_1715472866422.jpg?plan=h160	3	838	34.9162000	135.7941000	0101000020E61000001D38674469F96040304CA60A46754140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:30.942518
682	283643	jyw6wk2tl	\N	水管橋	https://image.anitabi.cn/points/283643/jyw6wk2tl_1714478784553.jpg?plan=h160	2	40	34.9004000	135.8015000	0101000020E6100000CFF753E3A5F96040C1A8A44E40734140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:19.780357
690	283643	khsc8hvyx	宇治桥	宇治橋	https://image.anitabi.cn/points/283643/khsc8hvyx_1715959322437.jpg?plan=h160	6	484	34.8930000	135.8062000	0101000020E61000002041F163CCF96040FCA9F1D24D724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:24.823014
607	152091	kq8ge35q3	\N	宇治市​総合​野外​活動​センター	https://image.anitabi.cn/points/152091/kq8ge35q3_1716621308453.jpg?plan=h160	2	743	34.9337000	135.8557000	0101000020E6100000FE65F7E461FB60403A234A7B83774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:23.566922
609	152091	kq8hqhod6	\N	Actpal宇治	https://image.anitabi.cn/points/152091/kq8hqhod6_1716621390211.jpg?plan=h160	2	874	34.9341000	135.8558000	0101000020E6100000567DAEB662FB6040C898BB9690774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:25.023284
504	216228	4ui7mhfoo	\N	せきざわ食堂	https://image.anitabi.cn/points/216228/4ui7mhfoo.jpg?plan=h160	\N	\N	35.7310000	139.6846000	0101000020E6100000EE5A423EE875614021B0726891DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1YSLKYDtt8UJkLHlnB54pPE4ezJg&ll=35.731082%2C139.68463&z=17	2026-05-10 10:50:02.580187
717	283643	llbm2657d	北野白梅町站	北野白梅町駅	https://image.anitabi.cn/points/283643/llbm2657d_1722329835473.jpg?plan=h160	11	1023	35.0273000	135.7312000	0101000020E6100000BADA8AFD65F760402497FF907E834140	Anitabi@MIKAI	https://anitabi.cn/	2026-05-10 11:22:41.89903
671	283643	jyqodrnkz	羽户山第三儿童公园	羽戸山第三児童公園	https://image.anitabi.cn/points/283643/jyqodrnkz_1714466789521.jpg?plan=h160	1	175	34.9078000	135.8148000	0101000020E6100000FC1873D712FA604087A757CA32744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:12.717766
706	283643	kknzwym08	\N	Cafe Rose あるぺんローズ	https://image.anitabi.cn/user/1083/bangumi/283643/points/kknzwym08-1716185280724.jpg?plan=h160	7	726	35.0091000	135.7818000	0101000020E610000069006F8104F96040613255302A814140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:35.345299
709	283643	l9j3s3qiw	出町柳站	出町柳	https://image.anitabi.cn/points/283643/l9j3s3qiw_1718133415167.jpg?plan=h160	10	596	35.0305000	135.7730000	0101000020E6100000DBF97E6ABCF8604096438B6CE7834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:22:37.113689
726	283643	s8pk5gwap	\N	​Bar Kaguya	https://image.anitabi.cn/user/0/bangumi/283643/points/s8pk5gwap-1767670222984.jpg?plan=h160	\N	\N	34.8906000	135.8042000	0101000020E61000002F6EA301BCF96040A7E8482EFF714140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-10 11:22:47.63339
719	283643	lork6qql8	\N	さわらびの道	https://image.anitabi.cn/points/283643/lork6qql8_1719327284204.jpg?plan=h160	12	1300	34.8928000	135.8108000	0101000020E61000001973D712F2F9604035EF384547724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:43.052719
713	283643	l978f5bbe	和歌山县民文化会馆	210	https://image.anitabi.cn/points/283643/l978f5bbe_1718107577445.jpg?plan=h160	10	1057	34.2252000	135.1678000	0101000020E61000009A081B9E5EE560409487855AD31C4140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:39.440648
710	283643	l9j9qcrdj	\N	出町橋	https://image.anitabi.cn/points/283643/l9j9qcrdj_1718133772463.jpg?plan=h160	10	600	35.0304000	135.7712000	0101000020E61000009B559FABADF8604032E6AE25E4834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:22:37.630595
701	283643	kc67f2axp	国立国会图书馆	国立国会図書館	https://image.anitabi.cn/user/0/bangumi/283643/points/kc67f2axp-1715519538134.jpg?plan=h160	6	129	35.6778000	139.7442000	0101000020E6100000DDB5847CD0776140499D8026C2D64140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:32.173875
703	283643	l2mlbn7sw	Seven Eleven便利店宇治黄檗公园店	セブン​イレブン\n宇治​黄檗​公園​店	https://image.anitabi.cn/points/283643/l2mlbn7sw_1717592459030.jpg?plan=h160	9	1044	34.9081000	135.8096000	0101000020E6100000EE5A423EE8F96040B1BFEC9E3C744140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:33.501046
722	283643	p9sc7x9ov	\N	イベントホール	https://image.anitabi.cn/user/0/bangumi/283643/points/p9sc7x9ov-1729438029572.jpg?plan=h160	13	324	35.1322000	136.8975000	0101000020E61000001F85EB51B81C6140FE43FAEDEB904140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:45.074273
712	283643	l97mxo072	河合桥	河合桥	https://image.anitabi.cn/points/283643/l97mxo072_1718108468219.jpg?plan=h160	10	1019	35.0303000	135.7724000	0101000020E6100000C66D3480B7F86040CE88D2DEE0834140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:38.826513
723	283643	lemznpl54	前田大厅	前田ホール	https://image.anitabi.cn/user/0/bangumi/283643/points/lemznpl54-1718533713775.jpg?plan=h160	11	\N	35.5936000	139.6152000	0101000020E6100000F90FE9B7AF736140EB73B515FBCB4140	Anitabi	https://anitabi.cn/	2026-05-10 11:22:45.687764
711	283643	l7vnqeuhs	\N	出町商店街	https://image.anitabi.cn/points/283643/l7vnqeuhs_1718133230101.jpg?plan=h160	10	604	35.0302000	135.7696000	0101000020E61000000DE02D90A0F860406B2BF697DD834140	Anitabi@MIKAI	https://anitabi.cn/	2026-05-10 11:22:38.212049
718	283643	lor0m1wwc	宇治市文化中心	宇治市​文化​センター	https://image.anitabi.cn/points/283643/lor0m1wwc_1719326101110.jpg?plan=h160	12	396	34.8797000	135.8035000	0101000020E6100000C1CAA145B6F96040462575029A704140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:42.515181
714	283643	ll0l14rq1	\N	哲学の道	https://image.anitabi.cn/user/1073/bangumi/283643/points/ll0l14rq1-1719033513624.jpg?plan=h160	11	356	35.0171000	135.7960000	0101000020E6100000B6F3FDD478F960407C61325530824140	Anitabi@月即别	https://anitabi.cn/	2026-05-10 11:22:40.054749
727	152091	kq4y1a2zr	\N	京坂六地藏站	https://image.anitabi.cn/points/152091/kq4y1a2zr_1716613685444.jpg?plan=h160	1	605	34.9320000	135.7933000	0101000020E6100000567DAEB662F960409EEFA7C64B774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:52:03.53894
576	152091	kq6c78ssy	\N	莵道高 小天使练习处 旁（未找到）	https://image.anitabi.cn/points/152091/kq6c78ssy_1716616701181.jpg?plan=h160	1	1732	34.9102000	135.8165000	0101000020E6100000E3A59BC420FA6040DC68006F81744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:58.066605
720	283643	lorkw4bmm	大吉山风致公园	大吉山風致公園	https://image.anitabi.cn/points/283643/lorkw4bmm_1719327324147.jpg?plan=h160	12	1303	34.8927000	135.8118000	0101000020E6100000925CFE43FAF96040D1915CFE43724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:43.64819
716	283643	ll13keo0f	\N	北野白梅町駅	https://image.anitabi.cn/user/1073/bangumi/283643/points/ll13keo0f-1719034592926.jpg?plan=h160	11	1016	35.0273000	135.7310000	0101000020E610000008AC1C5A64F760402497FF907E834140	Anitabi@月即别	https://anitabi.cn/	2026-05-10 11:22:41.286021
773	1424	25idmig	勃兰登堡门 Brandenburuger Tor	ブランデンブルク門	https://image.anitabi.cn/user/0/bangumi/1424/points/25idmig-1720632231036.jpg?plan=h160	7	393	52.5162000	13.3781000	0101000020E6100000363CBD5296C12A40FC1873D712424A40	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.525236
803	1424	25idmgo	\N	一乗寺下り松町バス停#2	https://image.anitabi.cn/points/1424/25idmgo.jpg?plan=h160	\N	\N	35.0430000	135.7919000	0101000020E61000007A36AB3E57F960402FDD240681854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.509827
704	283643	kffgg2gnd	\N	宇治駅	https://image.anitabi.cn/points/283643/kffgg2gnd_1715774546372.jpg?plan=h160	5	226	34.8945000	135.8063000	0101000020E61000007958A835CDF96040D122DBF97E724140	Anitabi@玖石澪	https://anitabi.cn/	2026-05-10 11:22:34.116437
366	216372	lv897yopa	萨莉亚宇治里尻店	サイゼリヤ\n宇治​里​尻​店	https://image.anitabi.cn/user/0/bangumi/152091/points/lv897yopa-1719833820242.jpg?plan=h160	1	3368	34.8925000	135.8048000	0101000020E610000044FAEDEBC0F960400AD7A3703D724140	Anitabi	https://anitabi.cn/	2026-05-04 16:26:14.767721
392	216372	kqh410cqx	\N	川东公园	https://image.anitabi.cn/points/216372/kqh410cqx_1716640159244.jpg?plan=h160	\N	447	34.8939000	135.8106000	0101000020E61000006744696FF0F960407CF2B0506B724140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.68566
385	216372	kqibc7gj3	\N	莵道高 小天使练习处（未确定）	https://image.anitabi.cn/points/216372/kqibc7gj3_1716642785165.jpg?plan=h160	\N	3501	34.9099000	135.8165000	0101000020E6100000E3A59BC420FA6040B1506B9A77744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:15.443178
732	90880	m2lyskatr	玉子市场	出町商店街 鲸鱼下	https://image.anitabi.cn/points/90880/m2lyskatr_1720412216747.jpg?plan=h160	\N	3463	35.0302000	135.7684000	0101000020E6100000E3C798BB96F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:30.788326
733	90880	m2m0bkd7a	\N	出町商店街 鲸鱼下	https://image.anitabi.cn/points/90880/m2m0bkd7a_1720412292574.jpg?plan=h160	\N	2910	35.0302000	135.7684000	0101000020E6100000E3C798BB96F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:31.392489
734	90880	m2liexflu	\N	出町商店街 西门 广角	https://image.anitabi.cn/points/90880/m2liexflu_1720411221197.jpg?plan=h160	\N	979	35.0302000	135.7678000	0101000020E6100000CD3B4ED191F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:31.976636
735	90880	m2m0rmyfs	\N	出町商店街 虚拟佟司家	https://image.anitabi.cn/points/90880/m2m0rmyfs_1720412347879.jpg?plan=h160	\N	2730	35.0303000	135.7685000	0101000020E61000003BDF4F8D97F86040CE88D2DEE0834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:32.593103
736	90880	m2m21z23e	\N	出町商店街 虚拟佟司家边	https://image.anitabi.cn/points/90880/m2m21z23e_1720412427083.jpg?plan=h160	\N	2730	35.0303000	135.7685000	0101000020E61000003BDF4F8D97F86040CE88D2DEE0834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:33.554508
737	90880	m2lk0r5qy	\N	出町商店街 西门	https://image.anitabi.cn/points/90880/m2lk0r5qy_1720411309336.jpg?plan=h160	\N	982	35.0303000	135.7679000	0101000020E6100000265305A392F86040CE88D2DEE0834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:34.281235
738	90880	m2lnqs86g	DAISO京都出町店	ダイソー​京都​出町​店	https://image.anitabi.cn/points/90880/m2lnqs86g_1720411563913.jpg?plan=h160	\N	1016	35.0304000	135.7682000	0101000020E610000031992A1895F8604032E6AE25E4834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:35.929345
739	90880	m2lqdfl2n	DAISO京都出町店 门口	ダイソー​京都​出町​店 门口	https://image.anitabi.cn/points/90880/m2lqdfl2n_1720411698914.jpg?plan=h160	\N	1020	35.0302000	135.7682000	0101000020E610000031992A1895F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:36.564129
740	90880	m2lze0i5p	DAISO京都出町店 对面花店 门口	ダイソー​京都​出町​店 对面花店 门口	https://image.anitabi.cn/points/90880/m2lze0i5p_1720412253704.jpg?plan=h160	\N	2894	35.0302000	135.7682000	0101000020E610000031992A1895F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:37.584118
741	90880	l14exbyf0	鸭川三角洲	鴨川デルタ	https://image.anitabi.cn/points/90880/l14exbyf0_1720412583938.jpg?plan=h160	\N	1850	35.0298000	135.7717000	0101000020E610000058CA32C4B1F86040DDB5847CD0834140	\N	\N	2026-05-11 19:54:38.21595
742	90880	m2m8vzm1k	\N	鸭川三角洲 东侧	https://image.anitabi.cn/points/90880/m2m8vzm1k_1720412861136.jpg?plan=h160	\N	1772	35.0295000	135.7722000	0101000020E6100000143FC6DCB5F86040B29DEFA7C6834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:39.612791
743	90880	m2mktkhus	\N	鸭川三角洲 东侧 回忆	https://image.anitabi.cn/points/90880/m2mktkhus_1720413531914.jpg?plan=h160	\N	1819	35.0295000	135.7722000	0101000020E6100000143FC6DCB5F86040B29DEFA7C6834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:40.870473
744	90880	m2mjqp0a9	\N	鸭川三角洲 东侧 入夜	https://image.anitabi.cn/points/90880/m2mjqp0a9_1720413467224.jpg?plan=h160	\N	3539	35.0298000	135.7721000	0101000020E6100000BB270F0BB5F86040DDB5847CD0834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:42.782269
745	90880	m2mdbod1y	\N	河内桥上 远眺鸭川三角洲东	https://image.anitabi.cn/points/90880/m2mdbod1y_1720413082806.jpg?plan=h160	\N	1850	35.0305000	135.7720000	0101000020E610000062105839B4F8604096438B6CE7834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:44.583653
746	90880	m2mgna0dm	\N	河内桥下 远眺鸭川三角洲东	https://image.anitabi.cn/points/90880/m2mgna0dm_1720413285763.jpg?plan=h160	\N	1959	35.0302000	135.7720000	0101000020E610000062105839B4F860406B2BF697DD834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:46.431716
747	90880	m2mh4mrhm	\N	鸭川三角洲 望向东侧	https://image.anitabi.cn/points/90880/m2mh4mrhm_1720413319642.jpg?plan=h160	\N	2061	35.0295000	135.7717000	0101000020E610000058CA32C4B1F86040B29DEFA7C6834140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:47.187003
748	90880	m2mx5vsu5	\N	JR藤森 前	https://image.anitabi.cn/points/90880/m2mx5vsu5_1720414290777.jpg?plan=h160	\N	559	34.9573000	135.7704000	0101000020E6100000D49AE61DA7F86040FB3A70CE887A4140	\N	\N	2026-05-11 19:54:47.989258
749	90880	m2mxtx8on	\N	JR藤森 前 对岸	https://image.anitabi.cn/points/90880/m2mxtx8on_1720414351220.jpg?plan=h160	\N	561	34.9573000	135.7706000	0101000020E610000086C954C1A8F86040FB3A70CE887A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:48.654394
750	90880	m2mz9delb	\N	JR藤森 前 铁桥	https://image.anitabi.cn/points/90880/m2mz9delb_1720414427247.jpg?plan=h160	\N	899	34.9568000	135.7705000	0101000020E61000002DB29DEFA7F860400A68226C787A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:49.312183
751	90880	m2n5gdwwr	\N	JR藤森入口前	https://image.anitabi.cn/points/90880/m2n5gdwwr_1720414779467.jpg?plan=h160	\N	944	34.9569000	135.7704000	0101000020E6100000D49AE61DA7F860406DC5FEB27B7A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:50.710664
752	90880	m2n6yk58v	\N	JR藤森 北侧第二座桥东侧	https://image.anitabi.cn/points/90880/m2n6yk58v_1720414869479.jpg?plan=h160	\N	960	34.9578000	135.7706000	0101000020E610000086C954C1A8F86040ED0DBE30997A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:52.606255
753	90880	m2na4u09k	\N	師団橋	https://image.anitabi.cn/points/90880/m2na4u09k_1720415064741.jpg?plan=h160	\N	965	34.9591000	135.7705000	0101000020E61000002DB29DEFA7F86040FBCBEEC9C37A4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:54:54.365491
757	90880	m2nqbeg1v	\N	京都站 正门旗杆前	https://image.anitabi.cn/points/90880/m2nqbeg1v_1720416051868.jpg?plan=h160	\N	4633	34.9861000	135.7588000	0101000020E61000008E06F01648F86040F54A5986387E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:55:02.07704
758	90880	m2nsj9l7x	\N	京都站 正门	https://image.anitabi.cn/points/90880/m2nsj9l7x_1720416182994.jpg?plan=h160	\N	4647	34.9861000	135.7588000	0101000020E61000008E06F01648F86040F54A5986387E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:55:03.888086
1041	328609	4yd2vzc6j	\N	柳川ビル 小巷	https://image.anitabi.cn/points/328609/4yd2vzc6j.jpg?plan=h160	4	611	35.6631000	139.6691000	0101000020E61000001D3867446975614022FDF675E0D44140	林宏	\N	2026-05-31 22:40:17.33003
759	90880	m2nsr3abh	\N	京都站 转盘	https://image.anitabi.cn/points/90880/m2nsr3abh_1720416190623.jpg?plan=h160	\N	4652	34.9860000	135.7588000	0101000020E61000008E06F01648F8604091ED7C3F357E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:55:06.726657
760	90880	m2nu65omh	\N	京都站 正门西侧扶梯	https://image.anitabi.cn/points/90880/m2nu65omh_1720417427487.jpg?plan=h160	\N	7051	34.9861000	135.7591000	0101000020E6100000984C158C4AF86040F54A5986387E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:55:07.621213
761	90880	m2o7cxy52	\N	中央新干线	https://image.anitabi.cn/points/90880/m2o7cxy52_1720417075480.jpg?plan=h160	\N	4681	34.9844000	135.7584000	0101000020E61000002AA913D044F860405917B7D1007E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:55:08.474073
762	90880	m2o97lk7o	\N	中央新干线改札口	https://image.anitabi.cn/points/90880/m2o97lk7o_1720417183998.jpg?plan=h160	\N	4682	34.9844000	135.7583000	0101000020E6100000D1915CFE43F860405917B7D1007E4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-11 19:55:09.200917
344	55113	31pe12e	\N	セルフ岸本屋・ダイソー	https://image.anitabi.cn/points/55113/31pe12e_1724030784137.jpg?plan=h160	6	112	35.0303000	135.7682000	0101000020E610000031992A1895F86040CE88D2DEE0834140	エンドス	\N	2026-05-04 16:22:33.49427
9	115908	qys7fu	京都音乐厅	京都コンサートホール	https://image.anitabi.cn/points/115908/qys7fu.jpg?plan=h160	1	1	35.0503000	135.7664000	0101000020E6100000F1F44A5986F86040917EFB3A70864140	Google Maps	https://www.google.com/maps/d/viewer?mid=13mgdlajJV0HxpqKf6ri2NnEHFBc&ll=35.05038%2C135.766468&z=17	2026-05-03 22:34:18.596851
767	1424	25idmen	\N	白川通北山路口附近	https://image.anitabi.cn/points/1424/25idmen.jpg?plan=h160	19	816	35.0502000	135.7911000	0101000020E6100000B37BF2B050F960402D211FF46C864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.125161
788	1424	s9nijut9a	\N	豊郷小学校（室外）	https://image.anitabi.cn/points/1424/s9nijut9a_1737890780649.jpg?plan=h160	1	\N	35.2038000	136.2320000	0101000020E61000008195438B6C07614060764F1E169A4140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.50972
777	1424	5p6aalz	\N	木屋町長浜ラーメン前	https://image.anitabi.cn/user/0/bangumi/1424/points/5p6aalz-1759416526321.jpg?plan=h160	14	987	35.0086000	135.7704000	0101000020E6100000D49AE61DA7F86040705F07CE19814140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.789801
764	1424	25idmdc	\N	第10話アバン(1)	https://image.anitabi.cn/points/1424/25idmdc.jpg?plan=h160	10	1	35.0511000	135.7894000	0101000020E6100000CCEEC9C342F96040AD69DE718A864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:09.930104
775	1424	s9tijzj57	\N	松ヶ﨑橋	https://image.anitabi.cn/points/3774/s9tijzj57_1737903841686.jpg?plan=h160	3	222	35.0512000	135.7889000	0101000020E6100000107A36AB3EF9604011C7BAB88D864140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:10.655834
783	1424	s9nzg7sl6	\N	宝ヶ池	https://image.anitabi.cn/points/1424/s9nzg7sl6_1737891800736.jpg?plan=h160	9	\N	35.0578000	135.7780000	0101000020E610000037894160E5F86040BADA8AFD65874140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.179802
766	1424	4yfwf2soj	\N	修学院駅	https://image.anitabi.cn/points/1424/4yfwf2soj.jpg?plan=h160	1	122	35.0505000	135.7904000	0101000020E610000045D8F0F44AF960405839B4C876864140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-17 10:28:10.060273
768	1424	25idmfv	\N	第13話Aパート(2)	https://image.anitabi.cn/user/0/bangumi/1424/points/25idmfv-1729326170762.jpg?plan=h160	13	428	35.0417000	135.7919000	0101000020E61000007A36AB3E57F96040211FF46C56854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.190704
782	1424	s9soypxoe	\N	白川通	https://image.anitabi.cn/points/1424/s9soypxoe_1737902108112.jpg?plan=h160	13	\N	35.0496000	135.7920000	0101000020E6100000D34D621058F96040D8F0F44A59864140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.115095
778	1424	auicpi3	\N	京都丹後鉄道 由良川橋	https://image.anitabi.cn/user/0/bangumi/1424/points/auicpi3-1770623101014.jpg?plan=h160	4	475	35.5108000	135.2880000	0101000020E6100000F0A7C64B37E96040FE65F7E461C14140	Anitabi@月即别	https://anitabi.cn/	2026-05-17 10:28:10.854847
789	1424	s9nxzig8j	\N	カフェ さらさ西陣	https://image.anitabi.cn/points/1424/s9nxzig8j_1737891718097.jpg?plan=h160	11	\N	35.0375000	135.7468000	0101000020E6100000E4141DC9E5F76040CDCCCCCCCC844140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.574603
772	1424	s9oa99ttk	\N	时钟（三条通）	https://image.anitabi.cn/points/1424/s9oa99ttk_1737892454017.jpg?plan=h160	10	636	35.0087000	135.7674000	0101000020E61000006ADE718A8EF86040D3BCE3141D814140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:10.460115
769	1424	dsb0ih5on	\N	平沢邸	https://image.anitabi.cn/user/1029/bangumi/1424/points/dsb0ih5on-1697035863601.jpg?plan=h160	1	60	35.0521000	135.7861000	0101000020E610000057EC2FBB27F96040910F7A36AB864140	Anitabi@Breeze	https://anitabi.cn/	2026-05-17 10:28:10.258839
774	1424	28bsith	\N	セブン-イレブン 京都修学院駅前店	https://image.anitabi.cn/user/0/bangumi/3774/points/28bsith-1751867613702.jpg?plan=h160	9	82	35.0504000	135.7906000	0101000020E6100000F7065F984CF96040F5DBD78173864140	Anitabi@suichan1oshi	https://anitabi.cn/	2026-05-17 10:28:10.591794
784	1424	s9o0xjq7x	\N	宝池観光(株)	https://image.anitabi.cn/points/1424/s9o0xjq7x_1737891889997.jpg?plan=h160	9	\N	35.0583000	135.7789000	0101000020E6100000575BB1BFECF86040ACADD85F76874140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.24457
779	1424	25idmg2	\N	修学院站附近	https://image.anitabi.cn/user/0/bangumi/1424/points/25idmg2-1751863725579.jpg?plan=h160	3	\N	35.0502000	135.7909000	0101000020E6100000014D840D4FF960402D211FF46C864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.921897
785	1424	kvb5nqb2s	宝池公园停车场附近小路	宝ヶ池	https://image.anitabi.cn/user/1083/bangumi/1424/points/kvb5nqb2s-1717019155584.jpg?plan=h160	9	\N	35.0581000	135.7785000	0101000020E6100000F4FDD478E9F86040E5F21FD26F874140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.313913
771	1424	25idmby	\N	北山通（レトロビーバー）	https://image.anitabi.cn/points/1424/25idmby.jpg?plan=h160	7	173	35.0518000	135.7880000	0101000020E6100000F0A7C64B37F9604066F7E461A1864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:10.395707
765	1424	25idmeo	\N	セブンイレブン修学院前2	https://image.anitabi.cn/user/0/bangumi/1424/points/25idmeo-1747572891665.jpg?plan=h160	10	28	35.0503000	135.7907000	0101000020E61000004F1E166A4DF96040917EFB3A70864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:09.994258
786	1424	s9nwatcwn	\N	船岡山公園	https://image.anitabi.cn/points/1424/s9nwatcwn_1737891611070.jpg?plan=h160	14	\N	35.0392000	135.7417000	0101000020E61000002F6EA301BCF7604069006F8104854140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.38029
1070	328609	4xyyi1p1j	\N	こけら	https://image.anitabi.cn/user/1000/bangumi/328609/points/4xyyi1p1j.jpg?plan=h160	8	596	35.6598000	139.6685000	0101000020E610000008AC1C5A647561404DF38E5374D44140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-31 22:40:24.059606
816	1424	s9n50zvht	\N	豊郷小学校商店	https://image.anitabi.cn/points/1424/s9n50zvht_1737889962657.jpg?plan=h160	\N	\N	35.2039000	136.2329000	0101000020E6100000A167B3EA73076140C3D32B65199A4140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.390166
815	1424	s9mxenmbz	豊郷小学校礼堂	豊郷小学校1F	https://image.anitabi.cn/points/1424/s9mxenmbz_1737889500139.jpg?plan=h160	\N	\N	35.2031000	136.2321000	0101000020E6100000DAACFA5C6D076140A7E8482EFF994140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.315616
818	1424	s9odkihkv	\N	牛カツ京都勝牛 河原町店前	https://image.anitabi.cn/points/1424/s9odkihkv_1737892655961.jpg?plan=h160	\N	\N	35.0058000	135.7683000	0101000020E61000008AB0E1E995F860408D28ED0DBE804140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.520162
817	1424	s9o3rs5zv	\N	鸭川三角洲	https://image.anitabi.cn/points/1424/s9o3rs5zv_1737892062850.jpg?plan=h160	\N	\N	35.0294000	135.7717000	0101000020E610000058CA32C4B1F860404F401361C3834140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.455713
822	262940	l03evks1o	\N	レジス​立川​高松町	https://image.anitabi.cn/user/1099/bangumi/2585/points/l03evks1o-1717394151825.jpg?plan=h160	1	776	35.7042000	139.4182000	0101000020E6100000FE65F7E4616D6140EEEBC03923DA4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:26.844008
792	1424	s9seqyz21	\N	河原町通	https://image.anitabi.cn/points/1424/s9seqyz21_1737901435993.jpg?plan=h160	2	\N	35.0037000	135.7692000	0101000020E6100000AA8251499DF86040637FD93D79804140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.7747
820	262940	nhgzxscqt	\N	”The Conversation” ニキ・ド・サンファル「会話」	https://image.anitabi.cn/user/1099/bangumi/2585/points/nhgzxscqt-1724398120315.jpg?plan=h160	1	211	35.7013000	139.4132000	0101000020E6100000A1D634EF386D6140A857CA32C4D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:26.323535
823	262940	o4jc3861p	\N	パルテノン大通リ	https://image.anitabi.cn/user/1099/bangumi/262940/points/o4jc3861p-1726206483830.jpg?plan=h160	1	873	35.6234000	139.4250000	0101000020E61000009A999999996D6140C7293A92CBCF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.082189
797	1424	25idmfm	\N	プラザ修学院	https://image.anitabi.cn/points/1424/25idmfm.jpg?plan=h160	\N	\N	35.0504000	135.7910000	0101000020E61000005A643BDF4FF96040F5DBD78173864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.110198
802	1424	25idmh4	\N	12話走る唯(5)	https://image.anitabi.cn/points/1424/25idmh4.jpg?plan=h160	\N	\N	35.0436000	135.7919000	0101000020E61000007A36AB3E57F96040840D4FAF94854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.446134
793	1424	s9sbviwgz	\N	Kyoto MOJO	https://image.anitabi.cn/points/1424/s9sbviwgz_1737901260598.jpg?plan=h160	9	\N	35.0038000	135.7569000	0101000020E6100000F54A598638F86040C6DCB5847C804140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.840024
808	1424	s9u1gloj0	\N	松ヶ崎大黒天（鸟居）	https://image.anitabi.cn/points/1424/s9u1gloj0_1737904982970.jpg?plan=h160	\N	\N	35.0522000	135.7862000	0101000020E6100000B003E78C28F96040F46C567DAE864140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:12.840024
807	1424	25idmhj	\N	木津川サイクリングロード	https://image.anitabi.cn/user/1073/bangumi/1424/points/25idmhj-1720708999820.jpg?plan=h160	\N	79	34.8824000	135.7102000	0101000020E6100000D0B359F5B9F66040C5FEB27BF2704140	Anitabi@月即别	https://anitabi.cn/	2026-05-17 10:28:12.769662
804	1424	25idmhq	\N	白川通（ローソン付近）#劇場版	https://image.anitabi.cn/user/0/bangumi/1424/points/25idmhq-1720634180238.jpg?plan=h160	\N	5535	35.0450000	135.7919000	0101000020E61000007A36AB3E57F96040F6285C8FC2854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.574908
795	1424	s9mp0exu4	\N	豊郷小学校1F	https://image.anitabi.cn/points/1424/s9mp0exu4_1737888993733.jpg?plan=h160	\N	\N	35.2034000	136.2327000	0101000020E6100000EF38454772076140D200DE02099A4140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.974599
806	1424	25idmg4	\N	田井中家周辺	https://image.anitabi.cn/points/1424/25idmg4.jpg?plan=h160	\N	\N	35.0619000	135.7863000	0101000020E6100000091B9E5E29F96040ABCFD556EC874140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.705569
812	1424	s8tq98eyy	\N	白川疏水通（北侧）	https://image.anitabi.cn/points/1424/s8tq98eyy_1737825943780.jpg?plan=h160	\N	\N	35.0276000	135.7939000	0101000020E61000006C09F9A067F960404FAF946588834140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.110263
799	1424	25idmeq	\N	京都中央信用金庫修学院店	https://image.anitabi.cn/points/1424/25idmeq.jpg?plan=h160	\N	\N	35.0493000	135.7919000	0101000020E61000007A36AB3E57F96040AED85F764F864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.242352
800	1424	25idmf6	\N	白川曼朱院道交差点	https://image.anitabi.cn/points/1424/25idmf6.jpg?plan=h160	\N	\N	35.0436000	135.7918000	0101000020E6100000211FF46C56F96040840D4FAF94854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.305464
801	1424	25idmh3	\N	第12話走る唯(4)	https://image.anitabi.cn/points/1424/25idmh3.jpg?plan=h160	\N	\N	35.0436000	135.7917000	0101000020E6100000C8073D9B55F96040840D4FAF94854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.370059
814	1424	s9mwh98te	\N	豊郷小学校	https://image.anitabi.cn/points/1424/s9mwh98te_1737889444498.jpg?plan=h160	\N	\N	35.2031000	136.2332000	0101000020E6100000ACADD85F76076140A7E8482EFF994140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.249196
813	1424	s8u3tu8lm	今宫神社	今宮神社	https://image.anitabi.cn/points/1424/s8u3tu8lm_1737826791498.jpg?plan=h160	\N	\N	35.0458000	135.7420000	0101000020E610000039B4C876BEF7604012143FC6DC854140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.179572
811	1424	s8tqyqp5l	\N	白川疏水通（南侧）	https://image.anitabi.cn/points/1424/s8tqyqp5l_1737825985898.jpg?plan=h160	\N	\N	35.0275000	135.7937000	0101000020E6100000BADA8AFD65F96040EC51B81E85834140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:13.040758
805	1424	25idmgx	\N	マクドナルド北白川台店	https://image.anitabi.cn/points/1424/25idmgx.jpg?plan=h160	\N	\N	35.0419000	135.7916000	0101000020E61000006FF085C954F96040E8D9ACFA5C854140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.639524
810	1424	25idmgr	\N	哲学の道	https://image.anitabi.cn/points/1424/25idmgr.jpg?plan=h160	\N	\N	35.0274000	135.7939000	0101000020E61000006C09F9A067F9604088F4DBD781834140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.975156
798	1424	25idmfh	\N	プラザ修学院2#2	https://image.anitabi.cn/points/1424/25idmfh.jpg?plan=h160	\N	\N	35.0504000	135.7918000	0101000020E6100000211FF46C56F96040F5DBD78173864140	Anitabi	https://anitabi.cn/	2026-05-17 10:28:12.174824
1043	328609	4yd2vzc3d	\N	サウナ＆カプセルミナミ 下北沢店	https://image.anitabi.cn/points/328609/4yd2vzc3d.jpg?plan=h160	4	616	35.6601000	139.6689000	0101000020E61000006C09F9A067756140780B24287ED44140	林宏	\N	2026-05-31 22:40:17.510907
825	262940	l01sm9mge	\N	Sakurano 桜乃	https://image.anitabi.cn/user/1099/bangumi/2585/points/l01sm9mge-1717390482120.jpg?plan=h160	1	1077	35.7015000	139.4124000	0101000020E6100000DA1B7C61326D61406F1283C0CAD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.237584
848	226540	n81hayxlv	\N	パレスホテル立川付近	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81hayxlv-1723658911603.jpg?plan=h160	11	36	35.7019000	139.4129000	0101000020E610000097900F7A366D6140FD87F4DBD7D94140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.499514
1411	329906	51i52hx4d	法兰克福罗马广场	レーマー広場	https://image.anitabi.cn/points/329906/51i52hx4d_1723709033439_half.jpg?plan=h160	\N	\N	50.1102000	8.6821000	0101000020E6100000053411363C5D214075029A081B0E4940	Google Maps	https://www.google.com/maps/d/viewer?mid=1CB4tTlfD8L9kSuZosr5Q_NoyJaoGRu0&ll=50.110288%2C8.682155&z=17	2026-06-09 19:30:07.977505
829	262940	psgenjzar	\N	浮くかたち－赤 / 垂	https://image.anitabi.cn/user/1099/bangumi/262940/points/psgenjzar-1730900901165.jpg?plan=h160	2	1326	35.7013000	139.4135000	0101000020E6100000AC1C5A643B6D6140A857CA32C4D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.648249
830	262940	pshbzvet2	\N	中央労働金庫 立川支店	https://image.anitabi.cn/points/262940/pshbzvet2_1730902986310.jpg?plan=h160	2	1330	35.7012000	139.4138000	0101000020E6100000B7627FD93D6D614044FAEDEBC0D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.759602
827	262940	psi27ocf1	\N	株式会社　藤和ハウス　立川店	https://image.anitabi.cn/user/1099/bangumi/262940/points/psi27ocf1-1730904575825.jpg?plan=h160	2	1322	35.7017000	139.4138000	0101000020E6100000B7627FD93D6D614036CD3B4ED1D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.510162
844	262940	rm31jfjsw	\N	曙陸橋	https://image.anitabi.cn/user/2148/bangumi/262940/points/rm31jfjsw-1736043875497.jpg?plan=h160	1	7	35.6987000	139.4181000	0101000020E6100000A54E4013616D61408CDB68006FD94140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-05-17 10:30:29.517044
833	262940	l16brmhrp	\N	「オープンカフェテラス」ジャン·ピエール·レイノー	https://image.anitabi.cn/user/1099/bangumi/2585/points/l16brmhrp-1717478959437.jpg?plan=h160	2	1351	35.7013000	139.4132000	0101000020E6100000A1D634EF386D6140A857CA32C4D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:28.082106
845	262940	5zgecex	\N	昭和纪念公园入口的梦广场	https://image.anitabi.cn/user/0/bangumi/262940/points/5zgecex-1760038238370.jpg?plan=h160	17	531	35.7025000	139.4094000	0101000020E6100000705F07CE196D614052B81E85EBD94140	Anitabi	https://anitabi.cn/	2026-05-17 10:30:29.588387
832	262940	o51kpvlkq	\N	立川駅 赤川政由 / 風に向かって	https://image.anitabi.cn/user/1099/bangumi/262940/points/o51kpvlkq-1726245240804.jpg?plan=h160	2	1349	35.6989000	139.4126000	0101000020E61000008C4AEA04346D61405396218E75D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.964545
826	262940	l171nckph	中央劳动银行立川分行	中央労働金庫立川支店	https://image.anitabi.cn/user/1099/bangumi/2585/points/l171nckph-1717480444079.jpg?plan=h160	2	1320	35.7011000	139.4143000	0101000020E610000073D712F2416D6140E09C11A5BDD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.434259
839	262940	ptlidj1j6	\N	「背中あわせの円」②フェリーチェ·ヴァリーニ	https://image.anitabi.cn/user/1099/bangumi/262940/points/ptlidj1j6-1730990374359.jpg?plan=h160	1	29	35.7012000	139.4136000	0101000020E6100000053411363C6D614044FAEDEBC0D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:28.984229
841	262940	pupo7u0d3	\N	バーミヤン 立川駅北口店	https://image.anitabi.cn/user/1099/bangumi/262940/points/pupo7u0d3-1731077811097.jpg?plan=h160	5	84	35.7019000	139.4109000	0101000020E6100000A5BDC117266D6140FD87F4DBD7D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:29.293489
838	262940	oxqpeolgu	圣保罗医院	Recinte Modernista de Sant Pau	https://image.anitabi.cn/user/0/bangumi/262940/points/oxqpeolgu-1728494279779.jpg?plan=h160	16	1400	41.4129000	2.1744000	0101000020E61000001361C3D32B6501405B423EE8D9B44440	Anitabi	https://anitabi.cn/	2026-05-17 10:30:28.893853
837	262940	oxr0gnwcc	\N	Recinte Modernista de Sant Pau	https://image.anitabi.cn/user/0/bangumi/262940/points/oxr0gnwcc-1728494819004.jpg?plan=h160	16	1332	41.4119000	2.1743000	0101000020E6100000DB8AFD65F7640140789CA223B9B44440	Anitabi	https://anitabi.cn/	2026-05-17 10:30:28.665259
846	262940	5zglh88	\N	昭和纪念公园西大道的人行道	https://image.anitabi.cn/user/0/bangumi/262940/points/5zglh88-1760038560685.jpg?plan=h160	3	1331	35.7028000	139.4109000	0101000020E6100000A5BDC117266D61407DD0B359F5D94140	Anitabi	https://anitabi.cn/	2026-05-17 10:30:30.869996
835	262940	o8ynfq2uu	\N	日立橋南	https://image.anitabi.cn/user/1099/bangumi/262940/points/o8ynfq2uu-1726552265821.jpg?plan=h160	15	28	35.6813000	139.4057000	0101000020E610000097FF907EFB6C6140E561A1D634D74140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:28.453403
840	262940	puoh14j35	\N	Regis Tachikawa高松町	https://image.anitabi.cn/user/1099/bangumi/262940/points/puoh14j35-1731075185177.jpg?plan=h160	1	754	35.7043000	139.4180000	0101000020E61000004C378941606D614052499D8026DA4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:29.219008
842	262940	puq9o8c7e	\N	国営昭和記念公園 総合案内所 旁	https://image.anitabi.cn/user/1099/bangumi/262940/points/puq9o8c7e-1731079093581.jpg?plan=h160	4	1229	35.7021000	139.4106000	0101000020E61000009A779CA2236D6140C442AD69DED94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:29.374276
843	262940	puqd2g0gq	\N	国営昭和記念公園  （东南入口）	https://image.anitabi.cn/user/1099/bangumi/262940/points/puqd2g0gq-1731079356911.jpg?plan=h160	4	1225	35.7020000	139.4107000	0101000020E6100000F38E5374246D614060E5D022DBD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:29.448973
791	1424	s9sd540bs	\N	新京極商店街	https://image.anitabi.cn/points/1424/s9sd540bs_1737901335695.jpg?plan=h160	2	\N	35.0037000	135.7667000	0101000020E6100000FB3A70CE88F86040637FD93D79804140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:11.704513
831	262940	ldu7wpirn	昭和天皇纪念馆	昭和天皇記念館	https://image.anitabi.cn/user/1099/bangumi/2585/points/ldu7wpirn-1718471062834.jpg?plan=h160	2	1332	35.7021000	139.4109000	0101000020E6100000A5BDC117266D6140C442AD69DED94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:27.895134
834	262940	pshupeifj	\N	三菱ＵＦＪモルガン・スタンレー証券（株） 立川支店	https://image.anitabi.cn/user/1099/bangumi/262940/points/pshupeifj-1730904050059.jpg?plan=h160	11	1334	35.7014000	139.4142000	0101000020E61000001AC05B20416D61400BB5A679C7D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:30:28.382946
849	226540	n81k6t7gw	\N	中組公園	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81k6t7gw-1723659084108.jpg?plan=h160	1	1057	35.6218000	139.4170000	0101000020E6100000D34D6210586D61408F53742497CF4140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.570619
863	2585	pu97csmbt	\N	桃菜 多摩センター駅前店	https://image.anitabi.cn/user/1099/bangumi/2585/points/pu97csmbt-1731041967611.jpg?plan=h160	8	691	35.6245000	139.4225000	0101000020E6100000EC51B81E856D61400E2DB29DEFCF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:31:47.572501
864	2585	odvdblwek	\N	中組公園	https://image.anitabi.cn/user/1099/bangumi/2585/points/odvdblwek-1726936905062.jpg?plan=h160	9	428	35.6220000	139.4170000	0101000020E6100000D34D6210586D6140560E2DB29DCF4140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:31:47.642375
867	2585	odviett43	\N	井の頭公園	https://image.anitabi.cn/user/1099/bangumi/2585/points/odviett43-1726937206047.jpg?plan=h160	21	670	35.6989000	139.5786000	0101000020E6100000E6AE25E4837261405396218E75D94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:31:47.842004
855	226540	n823w8w8v	\N	東京ビッグサイト(西)	https://image.anitabi.cn/user/1181/bangumi/226540/points/n823w8w8v-1723660276667.jpg?plan=h160	1	485	35.6296000	139.7940000	0101000020E6100000C520B07268796140E3C798BB96D04140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.99842
871	246430	riacv5t90	JR安房鸭川站	安房鴨川	https://image.anitabi.cn/points/246430/riacv5t90_1742808830139.jpg?plan=h160	11	141	35.1076000	140.1037000	0101000020E61000000C93A98251836140598638D6C58D4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:47.873782
872	246430	rhwxbtxm6	鸭川市立鸭川中学	鴨川市立鴨川中學	https://image.anitabi.cn/points/246430/rhwxbtxm6_1742808976724.jpg?plan=h160	11	172	35.1173000	140.0994000	0101000020E61000001EA7E8482E83614010E9B7AF038F4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:48.018259
873	246430	rhw4htsnt	加茂川海桥	かもがわマリーンブリッジ	https://image.anitabi.cn/user/0/bangumi/246430/points/rhw4htsnt-1735715599534.jpg?plan=h160	11	223	35.0970000	140.1053000	0101000020E61000009A081B9E5E83614023DBF97E6A8C4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:48.106098
874	246430	rhwims0qu	笹生土木有限会社	笹生土木（有）	https://image.anitabi.cn/points/246430/rhwims0qu_1742809252153.jpg?plan=h160	11	238	35.0938000	140.1065000	0101000020E6100000C520B07268836140B22E6EA3018C4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:48.264812
875	246430	rhw0f6lkk	鴨川漁港前原港区内观景平台	フィッシャリーナ鴨川 クラブハウス海太郎	https://image.anitabi.cn/points/246430/rhw0f6lkk_1742809710536.jpg?plan=h160	11	298	35.0986000	140.1084000	0101000020E61000005DDC4603788361405BB1BFEC9E8C4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:48.386533
876	246430	krltr748i	安房鸭川	安房鴨川	https://image.anitabi.cn/user/0/bangumi/186515/points/krltr748i-1716728915600.jpg?plan=h160	11	721	35.1076000	140.1038000	0101000020E610000065AA605452836140598638D6C58D4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:48.49857
878	246430	umk0bm31n	大久保大街	大久保通り	https://image.anitabi.cn/points/186515/8dea6856_1722414020795.jpg?plan=h160	9	754	35.7013000	139.7082000	0101000020E6100000DFE00B93A9766140A857CA32C4D94140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.701393%2C139.708219&z=17	2026-05-17 11:24:48.752997
780	1424	s9sluhn3d	\N	OBJ京都本店	https://image.anitabi.cn/points/1424/s9sluhn3d_1737901919728.jpg?plan=h160	13	\N	35.0408000	135.7918000	0101000020E6100000211FF46C56F96040A1D634EF38854140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:10.985251
1423	262939	rndpigwjh	汐留北1丁目十字路口	1 Chome 东新桥	https://image.anitabi.cn/user/2148/bangumi/262939/points/rndpigwjh-1736145545717.jpg?plan=h160	\N	\N	35.6646000	139.7610000	0101000020E61000003108AC1C5A786140F775E09C11D54140	Anitabi@耿耿-げん	https://anitabi.cn/	2026-06-09 19:30:12.479775
858	226540	nnxh4klhf	伯里克·特威德皇家边境大桥	Royal Border Bridge	https://image.anitabi.cn/user/0/bangumi/226540/points/nnxh4klhf-1724904085006.jpg?plan=h160	13	5	55.7722000	-2.0135000	0101000020E6100000CFF753E3A51B00C050FC1873D7E24B40	Anitabi	https://anitabi.cn/	2026-05-17 10:30:48.198202
868	2585	5z449e1	\N	立川站北口北侧路口	https://image.anitabi.cn/user/0/bangumi/2585/points/5z449e1-1760017632621.jpg?plan=h160	18	170	35.6989000	139.4134000	0101000020E61000005305A3923A6D61405396218E75D94140	Anitabi	https://anitabi.cn/	2026-05-17 10:31:47.912072
856	226540	nnx308aem	伦敦塔	Tower of London	https://image.anitabi.cn/user/0/bangumi/226540/points/nnx308aem-1724903172861.jpg?plan=h160	2	1	51.5053000	-0.0794000	0101000020E6100000166A4DF38E53B4BF9B559FABADC04940	Anitabi	https://anitabi.cn/	2026-05-17 10:30:48.067624
865	2585	5cbt8zi	\N	筑波大学附属病院	https://image.anitabi.cn/points/2585/5cbt8zi_1758814005331.jpg?plan=h160	10	730	36.0922000	140.1015000	0101000020E61000006891ED7C3F8361407958A835CD0B4240	Anitabi@Elm	https://anitabi.cn/	2026-05-17 10:31:47.71204
854	226540	n820icu2w	\N	イタリア公園	https://image.anitabi.cn/user/1181/bangumi/226540/points/n820icu2w-1723660071260.jpg?plan=h160	1	793	35.6593000	139.7589000	0101000020E6100000E71DA7E8487861405C2041F163D44140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.934581
853	226540	n81zgasmr	\N	汐留北交差点	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81zgasmr-1723660006019.jpg?plan=h160	1	675	35.6642000	139.7615000	0101000020E6100000EE7C3F355E78614069006F8104D54140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.868082
852	226540	n81sun1ow	\N	汐留シティセンター横	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81sun1ow-1723659610299.jpg?plan=h160	1	723	35.6651000	139.7615000	0101000020E6100000EE7C3F355E786140E9482EFF21D54140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.798346
870	2585	5zi4mca	\N	玉川上水站南口出口的芋窪街道	https://image.anitabi.cn/user/0/bangumi/2585/points/5zi4mca-1760041078045.jpg?plan=h160	11	261	35.7311000	139.4179000	0101000020E6100000F31FD26F5F6D6140840D4FAF94DD4140	Anitabi	https://anitabi.cn/	2026-05-17 10:31:48.04746
851	226540	n81qyzxd4	\N	立川駅北改札	https://image.anitabi.cn/user/1181/bangumi/226540/points/n81qyzxd4-1723659487832.jpg?plan=h160	1	189	35.6983000	139.4139000	0101000020E6100000107A36AB3E6D6140FE65F7E461D94140	Anitabi@Zyglisfer	https://anitabi.cn/	2026-05-17 10:30:47.728433
859	226540	nnx8tcwrs	白金汉宫	Buckingham Palace	https://image.anitabi.cn/user/0/bangumi/226540/points/nnx8tcwrs-1724903522110.jpg?plan=h160	10	51	51.5008000	-0.1429000	0101000020E61000005F984C158C4AC2BF1CEBE2361AC04940	Anitabi	https://anitabi.cn/	2026-05-17 10:30:48.288357
1049	328609	4yd2vzcag	\N	合照点 タイムズカー タイムズ下北沢第８	https://image.anitabi.cn/points/328609/4yd2vzcag.jpg?plan=h160	4	740	35.6624000	139.6690000	0101000020E6100000C520B07268756140696FF085C9D44140	林宏	\N	2026-05-31 22:40:18.422241
857	226540	nnx62tehv	教皇宫	Palais des Papes	https://image.anitabi.cn/user/0/bangumi/226540/points/nnx62tehv-1724903377567.jpg?plan=h160	3	377	43.9507000	4.8075000	0101000020E61000007B14AE47E13A13405227A089B0F94540	Anitabi	https://anitabi.cn/	2026-05-17 10:30:48.133166
862	2585	pup8nz454	\N	モスバーガー立川南口店	https://image.anitabi.cn/user/1099/bangumi/2585/points/pup8nz454-1731076868361.jpg?plan=h160	4	266	35.6962000	139.4153000	0101000020E6100000ECC039234A6D6140D3BCE3141DD94140	Anitabi@Xmなのだ	https://anitabi.cn/	2026-05-17 10:31:47.503308
809	1424	s8qpjgquv	\N	飛び出し注意看板（中野梓）	https://image.anitabi.cn/user/0/bangumi/1424/points/s8qpjgquv-1758700886827.jpg?plan=h160	\N	\N	35.1976000	136.2305000	0101000020E61000004C3789416007614045D8F0F44A994140	Anitabi@甜食伯爵	https://anitabi.cn/	2026-05-17 10:28:12.906663
879	246430	umk0bm30m	sunmall大塚商店街振興組合	サンモール大塚商店街振興組合	https://image.anitabi.cn/points/186515/eae9a5b7_1722418421194.jpg?plan=h160	10	20	35.7301000	139.7280000	0101000020E61000009EEFA7C64B776140A167B3EA73DD4140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.730179%2C139.728015&z=17	2026-05-17 11:24:48.875827
880	246430	u0eb5o6q5	\N	東京​ゲート​ブリッジ	https://image.anitabi.cn/points/246430/u0eb5o6q5_1742807694068.jpg?plan=h160	10	1278	35.6126000	139.8297000	0101000020E6100000B8AF03E78C7A6140CAC342AD69CE4140	Anitabi@月即别	https://anitabi.cn/	2026-05-17 11:24:48.999648
881	246430	umk0bm2rq	武道馆	武道館	https://image.anitabi.cn/points/186515/cae584a5_1722418426144.jpg?plan=h160	13	153	35.6930000	139.7492000	0101000020E610000039454772F977614062105839B4D84140	Google Maps	https://www.google.com/maps/d/viewer?mid=1J0K2QKstx1fjyCXMh2ZgWzgA5287_ZCt&ll=35.693043%2C139.749237&z=17	2026-05-17 11:24:49.136078
882	246430	2eotrk9	江户川公园	文京区立江戸川公園	https://image.anitabi.cn/user/0/bangumi/246430/points/2eotrk9-1752252242038.jpg?plan=h160	5	655	35.7105000	139.7263000	0101000020E6100000B7627FD93D7761406DE7FBA9F1DA4140	Anitabi	https://anitabi.cn/	2026-05-17 11:24:49.260993
402	216372	kqhngenoc	京都府立山城综合运动公园田径赛场	府​立​山城​総合​運動​公園\n陸上​競技場	https://image.anitabi.cn/points/216372/kqhngenoc_1716641343736.jpg?plan=h160	\N	1961	34.8716000	135.8052000	0101000020E6100000A857CA32C4F96040C898BB96906F4140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-04 16:26:16.016333
631	152091	ptcjor2a3	关西电力 天之濑发电所	関西電力 天ケ瀬発電所	https://image.anitabi.cn/user/0/bangumi/152091/points/ptcjor2a3-1730970986370.jpg?plan=h160	11	1203	34.8812000	135.8255000	0101000020E610000023DBF97E6AFA60401B9E5E29CB704140	Anitabi	https://anitabi.cn/	2026-05-10 11:21:39.025137
577	152091	kq4ygav9u	\N	京坂六地藏站 内 广告牌前	https://image.anitabi.cn/points/152091/kq4ygav9u_1716613693417.jpg?plan=h160	1	609	34.9319000	135.7934000	0101000020E6100000AF94658863F960403A92CB7F48774140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:21:03.699869
544	152091	kq6unr2ks	\N	莵道高 校门最近教学楼正门 远眺	https://image.anitabi.cn/points/152091/kq6unr2ks_1716617843996.jpg?plan=h160	1	2250	34.9094000	135.8161000	0101000020E61000008048BF7D1DFA6040BF7D1D3867744140	Anitabi@卜卜口	https://anitabi.cn/	2026-05-10 11:20:36.872386
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, username, phone, email, password_hash, avatar_url, created_at, updated_at, nickname, bio) FROM stdin;
1	testuser	\N	\N	$2a$10$KwXPSlBgWRpRHw9heEWBqOkjqkGuuBN/.p8Sh3ppm7vEjzT7v27dy	\N	2026-04-19 11:00:36.841127	2026-04-19 11:00:36.841144	测试用户	\N
3	test11	\N	\N	$2a$10$nvdmejHawNt4bdfcC/RArO/a/Wrihnp9UFx9jHlcNB1Qup8Zf9aI6	\N	2026-05-09 21:13:12.950316	2026-05-09 21:13:12.950316	测试用户	\N
4	JMshepherd	\N	\N	$2a$10$g8rG7DLTaJj4d/9Uu5tg1uSUTqSv3xbWeyM8BWOoNyO03ms7IOaI2	\N	2026-05-10 21:46:17.844317	2026-05-10 21:46:17.844317	JMshepherd	\N
5	memberE_test	\N	\N	$2a$10$kr33aA5r5VVYOBwc/P1GPerpU0ujkK27LtU7YHbSs6eGyYNPKHIRe	\N	2026-05-15 14:39:51.894623	2026-05-15 14:39:51.894623	测试用户E	\N
6	lym	\N	\N	$2a$10$FJAAdFiV84pUUB2UohWxhOnhU.Yo6RfeJE8Bt2crzlG5R8d1l4D1G	\N	2026-05-17 11:25:49.112041	2026-05-17 11:25:49.112041	再睡五分钟	\N
7	18298538692	18298538692	\N	$2a$10$ycdrW7/k8UFOTUe86FrpE.cvSWwKs54p2miqSwOn1PfMYj.GldUFW	\N	2026-05-17 11:38:33.199493	2026-05-17 11:38:33.199493	18298538692	\N
8	testuser020	\N	\N	$2a$10$9sjYR3RX6ARtvEIm2FYITuTFdPLjg2vg8lZy0gWQqfMrrdut/tZh6	\N	2026-05-17 11:42:32.180428	2026-05-17 11:42:32.180428	测试用户020	\N
9	testuse	\N	\N	$2a$10$YQ5llYQWfkCewsU92gP3DONYYCIaY72e60Ncc0DxnICtDOBddqu4q	\N	2026-06-05 21:55:57.779204	2026-06-05 21:55:57.779204	测试用户020	\N
10	testuser_postman	\N	\N	$2a$10$E8BhaOEZAPk34dpXVVtbWe9GTx239Zj.BF14hUp0rnHCegkDgbsuG	\N	2026-06-05 23:02:46.348581	2026-06-05 23:24:16.229746	新昵称	个人简介测试
11	hsw	\N	\N	$2a$10$LJbpb2FonJynpSe80N2t2uPoHki4szhPTBV7yz80oGUjvg4ahpeP6	\N	2026-06-07 10:47:48.752183	2026-06-07 10:47:48.752183	hsw	\N
12	user_15352186146	15352186146	\N	$2a$10$v4UZeTappsShF6DrLjQPDe6ay1H6EqR6nL1GNMWkAaY.ChTG2l8P.	\N	2026-06-07 11:13:21.518804	2026-06-07 11:13:21.518822	Misaka	\N
13	user_18813127123	18813127123	\N	$2a$10$Ng1DlLQUA1ZEGS8wldGPOugN/bWoPQgET.34Es1MLqxwwSPncHBRu	\N	2026-06-07 13:04:14.478613	2026-06-07 13:04:14.478613	hsw	\N
2	Misaka	\N	\N	$2a$10$gejx8dT8TzuJ6zCEeAuhuu9TTv5J5ARAsU9Rf3qgkdCEA/h1AuxrG	\N	2026-04-19 11:17:28.214814	2026-06-07 15:08:58.70216	Misaka16483	懒
14	perftest1	\N	\N	$2a$10$UFb0ljA0oKjmsdCmm/cwieRt2JrGxAOFm9i3CTzIpmeMX0CzHDZhy	\N	2026-06-09 20:27:57.569088	2026-06-09 20:27:57.569088	压测用户1	\N
15	perftest2	\N	\N	$2a$10$72fb48RFstdHea7LIszdtOl55F1NsoXga4a38AV1o2AcftNa9wcvK	\N	2026-06-09 20:27:58.103578	2026-06-09 20:27:58.103578	压测用户2	\N
16	perftest3	\N	\N	$2a$10$6X36OSuQ4rKSkxpnUxgeV.lKDL//KZF37sle/KjGRgzU0..X8nuQW	\N	2026-06-09 20:27:58.319719	2026-06-09 20:27:58.319719	压测用户3	\N
17	perftest4	\N	\N	$2a$10$0r.5rWh3GWUpuYhekgsz.udM4GiOJnQTWxsFIfR2HwZIVP6EQr/yG	\N	2026-06-09 20:27:58.534716	2026-06-09 20:27:58.534716	压测用户4	\N
18	perftest5	\N	\N	$2a$10$4thvvqB4esb/7C5z2vTS0e4vDUPUXWWv6oq6YDIBOj6dYLeqLFhLW	\N	2026-06-09 20:27:58.775111	2026-06-09 20:27:58.775111	压测用户5	\N
19	perftest6	\N	\N	$2a$10$Mn2iZo35xoYE2VS8Ct/M6OJJZ7r4IAjumPVHKLFcpdGweY/pFSfWi	\N	2026-06-09 20:27:58.961604	2026-06-09 20:27:58.961604	压测用户6	\N
20	perftest7	\N	\N	$2a$10$28.1nYIUWyUMfbZFXCrjNOqftO8qmj4es9Q.Pu5W4mU1ldfYznona	\N	2026-06-09 20:27:59.180132	2026-06-09 20:27:59.180132	压测用户7	\N
21	perftest8	\N	\N	$2a$10$93hSJEth59hnWOBduZIg9OK3H4P3rYBEe0yG0Qmyt/Ni2AO8VaTqC	\N	2026-06-09 20:27:59.356321	2026-06-09 20:27:59.356321	压测用户8	\N
22	perftest9	\N	\N	$2a$10$5dembgyyPu2zIGrg162wfuaRLCZxKiyvfaucDqX1p500W8YgIORiq	\N	2026-06-09 20:27:59.559443	2026-06-09 20:27:59.559443	压测用户9	\N
23	perftest10	\N	\N	$2a$10$swHTSWpKFjubNnj2NF6nOOnFpzeiUTKwtCL4K.AP1/uYlZEEo0g/u	\N	2026-06-09 20:27:59.893743	2026-06-09 20:27:59.893743	压测用户10	\N
24	perftest11	\N	\N	$2a$10$Ym4.Sc.yLyr2yk92YXhcqegU8ffMgIwP8pRbKr.fd8Nn342je.aK2	\N	2026-06-09 20:28:00.205866	2026-06-09 20:28:00.205866	压测用户11	\N
25	perftest12	\N	\N	$2a$10$7K25eojPa3CR8JGcowVmJO.5.W5WVSaNkHyhviB7gdXVfWzyuGmmy	\N	2026-06-09 20:28:00.563427	2026-06-09 20:28:00.563427	压测用户12	\N
26	perftest13	\N	\N	$2a$10$0y/sUaTtA9x/IhMmVeFMUueyHT9y3HUWv9CkjBJNs0TjqMXhmv6zW	\N	2026-06-09 20:28:00.9319	2026-06-09 20:28:00.93345	压测用户13	\N
27	perftest14	\N	\N	$2a$10$OzMD0sgXNrqXJIWDhERVJu4sfDWfeA4jXKaimyjL7qOzvC5WSqpKO	\N	2026-06-09 20:28:01.311514	2026-06-09 20:28:01.311514	压测用户14	\N
28	perftest15	\N	\N	$2a$10$JUrsTYDURLqdabDzvhyZxuTvaf9kpkiQdgWzPAVmi5JhxIeRS.ZRu	\N	2026-06-09 20:28:01.657225	2026-06-09 20:28:01.657225	压测用户15	\N
29	perftest16	\N	\N	$2a$10$eMO5aaKqy6qhrvtZasxAMum15p4tdp.EhqJqzWw6lbLalwXDQBApy	\N	2026-06-09 20:28:01.991988	2026-06-09 20:28:01.991988	压测用户16	\N
30	perftest17	\N	\N	$2a$10$qtI4Q8z3xOgKYKz6RLkE1ekihMtzmLWWBtf3dL04aI43wEee1dKaK	\N	2026-06-09 20:28:02.324334	2026-06-09 20:28:02.324334	压测用户17	\N
31	perftest18	\N	\N	$2a$10$5WAwQfB645bz.cnufzFD1e5y1HXPGASeBHVucuFjylBLnWJQXHjmu	\N	2026-06-09 20:28:02.678729	2026-06-09 20:28:02.678729	压测用户18	\N
32	perftest19	\N	\N	$2a$10$2RFAJlvBWIAFOBG76VxLMuL60MV3gcszVXz9SC49jUFoi.PskWLoa	\N	2026-06-09 20:28:03.034804	2026-06-09 20:28:03.034804	压测用户19	\N
33	perftest20	\N	\N	$2a$10$PiPrvxVkGCu/DNdp32lDte7LTwjxIJU8M0TNN7.V6UeECzPe2sSEC	\N	2026-06-09 20:28:03.379124	2026-06-09 20:28:03.379124	压测用户20	\N
34	perftest21	\N	\N	$2a$10$chDBjwpvTHL6qvEb/iBMQ.E6VxvUCWczB32E3.CntV/m7cwO62Rdm	\N	2026-06-09 20:28:03.710174	2026-06-09 20:28:03.710174	压测用户21	\N
35	perftest22	\N	\N	$2a$10$N54vJ1N9wEQwetBLfd9Lg.U5GXnwVDZt5IX2fMocVLsw9hdQxC.3i	\N	2026-06-09 20:28:04.110267	2026-06-09 20:28:04.110267	压测用户22	\N
36	perftest23	\N	\N	$2a$10$VVDKzz86lyDURXJagKPv0uHAXQxPtRQEtP52252hMY4H9eHpKP3TW	\N	2026-06-09 20:28:04.554183	2026-06-09 20:28:04.554183	压测用户23	\N
37	perftest24	\N	\N	$2a$10$0O4dxOwfQDRvDnkAUbIhV.0LFd3dYbA5RdnANOUkCWdmAXyWhBQO2	\N	2026-06-09 20:28:04.910126	2026-06-09 20:28:04.910126	压测用户24	\N
38	perftest25	\N	\N	$2a$10$oKDSGebghqLJbv0XH/wUPe9EVbxciHZGh3roFebCNZKr/5HwUuAzq	\N	2026-06-09 20:28:05.271003	2026-06-09 20:28:05.271003	压测用户25	\N
39	perftest26	\N	\N	$2a$10$Q4Owgv73S7bUHFRAU4R3vOvCorV8UiM7m2Ec2pt42MMnHUVwPFfZq	\N	2026-06-09 20:28:05.595835	2026-06-09 20:28:05.595835	压测用户26	\N
40	perftest27	\N	\N	$2a$10$UUdXsCtwR8vrPDsQaRxGuuglNPOZ6w/Njz8Xot4jfGTJaJaF6zysK	\N	2026-06-09 20:28:06.001515	2026-06-09 20:28:06.001515	压测用户27	\N
41	perftest28	\N	\N	$2a$10$AM316EKLsfKZeDglVrvSvu9ZY4tkWgrHrL2QjTr1fnCY9GUURv37y	\N	2026-06-09 20:28:06.382058	2026-06-09 20:28:06.382058	压测用户28	\N
42	perftest29	\N	\N	$2a$10$ABb4KiKauRnRdfcAoCIYv.x00rpBVAHJJc4XIrZX7f4jJ.q2nBrby	\N	2026-06-09 20:28:06.751666	2026-06-09 20:28:06.751666	压测用户29	\N
43	perftest30	\N	\N	$2a$10$2qdTE2veJULe8TroclDVzOS6yro4IHJzZMk2BdTPP7f1n57GnVTfG	\N	2026-06-09 20:28:07.096159	2026-06-09 20:28:07.096159	压测用户30	\N
44	perftest31	\N	\N	$2a$10$ifgs54HiYEguMjVw7PK0f.kQwbwBcqJJUqzt2BdFwXpNOlhGuNT1K	\N	2026-06-09 20:28:07.448586	2026-06-09 20:28:07.448586	压测用户31	\N
45	perftest32	\N	\N	$2a$10$1ACqTWPLbK5jHK2HU2SF3e2WUQcl/HuIhph79yqvO5TQ2dUHzL3O2	\N	2026-06-09 20:28:07.78493	2026-06-09 20:28:07.78493	压测用户32	\N
46	perftest33	\N	\N	$2a$10$U2vYQbB3nd86O6brnIrZFumahYTlHgbnWkdy.ASbNh3PJS9H.20sC	\N	2026-06-09 20:28:08.10409	2026-06-09 20:28:08.10409	压测用户33	\N
47	perftest34	\N	\N	$2a$10$dKX/uEf/hsSGXSlfhCQSI.qaMwiHhwnyCrQA223hknA7bcblhlmq6	\N	2026-06-09 20:28:08.460482	2026-06-09 20:28:08.460482	压测用户34	\N
48	perftest35	\N	\N	$2a$10$lUEdoEWfG6z5Ql5dXyeW7uNc15uM1joH8Xv.MzegoLBsiEu46W.Cm	\N	2026-06-09 20:28:08.832148	2026-06-09 20:28:08.832148	压测用户35	\N
49	perftest36	\N	\N	$2a$10$FmZPXXpHAGS4gC9G/S/lfeDxWtTsQYgYTjhqXdG84hGqI3yzAtlXS	\N	2026-06-09 20:28:09.157086	2026-06-09 20:28:09.157086	压测用户36	\N
50	perftest37	\N	\N	$2a$10$Db9cQ/LMOer7zQXQx4BMeeIIrAE1miFcmvME8Xb.oSGcfC8Ujf7I2	\N	2026-06-09 20:28:09.495782	2026-06-09 20:28:09.495782	压测用户37	\N
51	perftest38	\N	\N	$2a$10$2JvoE5rnHpTRFReT5IeHfumHNxA1Kem7I24gKDVBgL5lk..a8xp/6	\N	2026-06-09 20:28:09.806973	2026-06-09 20:28:09.806973	压测用户38	\N
54	perftest41	\N	\N	$2a$10$nKySSd4Tn/odbzW8S/H7ZOQnH3vwpNZsrxZKfxWpldgv3vTXIMyA6	\N	2026-06-09 20:28:10.77823	2026-06-09 20:28:10.77823	压测用户41	\N
57	perftest44	\N	\N	$2a$10$8v0fSQJitrGfSdzQpmRKHeSzUM8MD0HPdsgLxUhDiLhTDROt2OMkC	\N	2026-06-09 20:28:11.765202	2026-06-09 20:28:11.765202	压测用户44	\N
59	perftest46	\N	\N	$2a$10$L4SH6Ppx/Tesk55vwk2adOHPAF3D7qs6ty81QE5kfkUPjquf36oC6	\N	2026-06-09 20:28:12.383149	2026-06-09 20:28:12.383149	压测用户46	\N
61	perftest48	\N	\N	$2a$10$IIWSrtCahm4SqtR4paOKDeT811JIWIJ2jec3ECXoyp2JVXqzOAfAe	\N	2026-06-09 20:28:12.990897	2026-06-09 20:28:12.990897	压测用户48	\N
64	perftest51	\N	\N	$2a$10$cqM0AZBaDrzLUJIT0Da2bu9pooMcgBYNxMbVyjVq96KA/bULTCVtq	\N	2026-06-09 20:28:14.214127	2026-06-09 20:28:14.214127	压测用户51	\N
52	perftest39	\N	\N	$2a$10$vbJoH4R7xXj1WUFYvzgRouf8mBiW/E5xdZk87MnVaFMMlnM2sJOaW	\N	2026-06-09 20:28:10.131804	2026-06-09 20:28:10.131804	压测用户39	\N
62	perftest49	\N	\N	$2a$10$EiM8e5IE3XYZmSSHiMyMsuKclEfnstfLUfGVnvXcUY9J2/L6ATcfe	\N	2026-06-09 20:28:13.315133	2026-06-09 20:28:13.315133	压测用户49	\N
53	perftest40	\N	\N	$2a$10$UlZfYOo894aSGWBUYpw.0eQ4oxHOzhVLO5reiWvjs8DydcU.anpvy	\N	2026-06-09 20:28:10.450108	2026-06-09 20:28:10.450108	压测用户40	\N
63	perftest50	\N	\N	$2a$10$xvMSoKt3sjJ4w2OTEaCjhemcb93cJKbsWBdNSnOyWNyrTh8LXjiWm	\N	2026-06-09 20:28:13.635174	2026-06-09 20:28:13.635174	压测用户50	\N
55	perftest42	\N	\N	$2a$10$W9XlIKxxsemxyPn22wyCAeh7i152Jc1IGdiRUa090UV7zbtvPpFnS	\N	2026-06-09 20:28:11.110294	2026-06-09 20:28:11.110294	压测用户42	\N
56	perftest43	\N	\N	$2a$10$Cz4LrONMTGP.e8FSKiht3ujB8tnzrBYgKUgVPA3e4vlZSZ2fLWGTm	\N	2026-06-09 20:28:11.432733	2026-06-09 20:28:11.432733	压测用户43	\N
58	perftest45	\N	\N	$2a$10$MfpVQM9lIOC8eJ7BG9eSJeWoAL4IpaPC7iPPOsXOjcVDLIXNJzA6G	\N	2026-06-09 20:28:12.086299	2026-06-09 20:28:12.086299	压测用户45	\N
60	perftest47	\N	\N	$2a$10$CIE1e0tiFlWh56Wa0ErCNeCsl4ie117NHG/QvbvsfKSVFILu1UY2K	\N	2026-06-09 20:28:12.698716	2026-06-09 20:28:12.698716	压测用户47	\N
65	perftest52	\N	\N	$2a$10$FS6ncEpVKQ3O.hXjGJ8WXeOAsknLHZ9CPeFuUm4.d8xXCD5Gfj4Z6	\N	2026-06-09 20:28:14.536125	2026-06-09 20:28:14.536125	压测用户52	\N
66	perftest53	\N	\N	$2a$10$VNWmK7z3NKWbUI1LElRlT.GI1V4gRiy6jBJ4LqugmMAcR1sJLvsz.	\N	2026-06-09 20:28:14.858912	2026-06-09 20:28:14.858912	压测用户53	\N
67	perftest54	\N	\N	$2a$10$aiU/V4nRE4RAAv6ExsHmOerxL1Gr.1x0rBaS6sAAP0BzxzeXkq04i	\N	2026-06-09 20:28:15.208402	2026-06-09 20:28:15.208402	压测用户54	\N
68	perftest55	\N	\N	$2a$10$I0EOrbk43EdDo.MBwLP6N.GJouJyUGQ9YV1k5SIi6OHn3dZ7P4gJi	\N	2026-06-09 20:28:15.53073	2026-06-09 20:28:15.53073	压测用户55	\N
69	perftest56	\N	\N	$2a$10$xp.B6qtV9sp9Q0NpDxStcerP8O1On38JFaXitOBoDjTOiE8sKqqci	\N	2026-06-09 20:28:15.830261	2026-06-09 20:28:15.830261	压测用户56	\N
70	perftest57	\N	\N	$2a$10$zmQk2eLkZXDAAahuiS3Bce6Plt5h8Q0NXk473RYh4ul2iFNT/z9lO	\N	2026-06-09 20:28:16.178353	2026-06-09 20:28:16.178353	压测用户57	\N
71	perftest58	\N	\N	$2a$10$cQP5fqkyikF63G/AhGXlkeoRkbN2zKGA65K.Am0Qj9q6ejJJrFHoC	\N	2026-06-09 20:28:16.482571	2026-06-09 20:28:16.482571	压测用户58	\N
72	perftest59	\N	\N	$2a$10$XNmI9vg9GYxR49pCC.wnZeu0rX0JIH2kK20nOdRMLHb/k9ISOoFE6	\N	2026-06-09 20:28:16.811683	2026-06-09 20:28:16.811683	压测用户59	\N
73	perftest60	\N	\N	$2a$10$QMN1Bn2scAhDZbYEO4mcLeZAwNqUGiUkN1r13bM6bP4cX.cw63.Ji	\N	2026-06-09 20:28:17.162126	2026-06-09 20:28:17.162126	压测用户60	\N
74	perftest61	\N	\N	$2a$10$E69qUToXoePWOI26w5G7.OKEvEdb/S5kDBF7TjDbstw9U6Kx/E0wC	\N	2026-06-09 20:28:17.515221	2026-06-09 20:28:17.515221	压测用户61	\N
75	perftest62	\N	\N	$2a$10$JOw4neGwduFKXofQu7S1Vuz74xaR70SbLcrg3LnDMIjvRTRycFanC	\N	2026-06-09 20:28:17.932336	2026-06-09 20:28:17.932336	压测用户62	\N
76	perftest63	\N	\N	$2a$10$bRMCiqc/ItFq3HieeVBlwOxt3hBhgW.cLhCH3qB8Ww.fgCO9Wt.O2	\N	2026-06-09 20:28:18.2692	2026-06-09 20:28:18.2692	压测用户63	\N
77	perftest64	\N	\N	$2a$10$drpAhidairWHuU1s8C01HOdYaUqMmOoFmDXrUlo25kd3Fk2Ca6QkS	\N	2026-06-09 20:28:18.622026	2026-06-09 20:28:18.622026	压测用户64	\N
78	perftest65	\N	\N	$2a$10$ZVnF.k0zIWUDOVpRWWP3A.GrmUd171lktt1iWaXfVpJ8guljmgrgq	\N	2026-06-09 20:28:18.932576	2026-06-09 20:28:18.932576	压测用户65	\N
79	perftest66	\N	\N	$2a$10$I10UBsQVVZTAex5B0z6SSuXMCynD5oebJCQ.ETB/Q3NbSO.ZjzW4K	\N	2026-06-09 20:28:19.198157	2026-06-09 20:28:19.198157	压测用户66	\N
80	perftest67	\N	\N	$2a$10$k4RSjis4SCaih4KAz4uzr.OVbjEEDmJOTyuMi/tK649WTijDmbjF2	\N	2026-06-09 20:28:19.398016	2026-06-09 20:28:19.398016	压测用户67	\N
81	perftest68	\N	\N	$2a$10$IU7wHCijRwdr9eIuD/32d.j8wuBdu1SS1agYp2rDHG/sS5/M4lxIe	\N	2026-06-09 20:28:19.583815	2026-06-09 20:28:19.583815	压测用户68	\N
82	perftest69	\N	\N	$2a$10$i2rBy2WRZDvhuj9OyKot5.15wLKTVQKE8EDmDkOmsq0V9gL2yoDdy	\N	2026-06-09 20:28:19.772956	2026-06-09 20:28:19.772956	压测用户69	\N
83	perftest70	\N	\N	$2a$10$lhGzAZb1qxZbxnUy791L1OZNBMGeS7xtSqaouE7Ppr0SLSV8HlJXu	\N	2026-06-09 20:28:19.964008	2026-06-09 20:28:19.964008	压测用户70	\N
84	perftest71	\N	\N	$2a$10$XgRSpnzYNiCIYUzxiKCnoeV3JZ.DuoVSF3KXldU1Y70XGJgED73cu	\N	2026-06-09 20:28:20.134299	2026-06-09 20:28:20.134299	压测用户71	\N
85	perftest72	\N	\N	$2a$10$T9t4ZxnncufEn4.AEGTZ2uW.FfX8emwTsI1HReHLsZ5Q0dE6AM8o.	\N	2026-06-09 20:28:20.321412	2026-06-09 20:28:20.321412	压测用户72	\N
86	perftest73	\N	\N	$2a$10$OUl6avBBaGzegxGcTN5IieDthATG/6CRJCLOLSgbNIOZQTRBgiG0e	\N	2026-06-09 20:28:20.519804	2026-06-09 20:28:20.519804	压测用户73	\N
87	perftest74	\N	\N	$2a$10$PJ7sLpORICha4q6zU3SMfe3W8Zw85Nc9BLSw0GaVCHc5BIIsTZWNq	\N	2026-06-09 20:28:20.692999	2026-06-09 20:28:20.692999	压测用户74	\N
88	perftest75	\N	\N	$2a$10$YqhFK/.vAC.OxbWCedTE1eWJS.lKM9.fTg3dHnKP2EZD0hsle/TeO	\N	2026-06-09 20:28:20.875203	2026-06-09 20:28:20.875203	压测用户75	\N
89	perftest76	\N	\N	$2a$10$7KkPcJ5HyuMEGTj4mZEo0ercpulRAzMnWdw/u0tWicEtpzUfb/ASS	\N	2026-06-09 20:28:21.040417	2026-06-09 20:28:21.040417	压测用户76	\N
90	perftest77	\N	\N	$2a$10$30dEyS9QC0miiRrs0sOcHexudbcHmVt0I6.ZD4kCP3CIkL24R0ewi	\N	2026-06-09 20:28:21.276352	2026-06-09 20:28:21.276352	压测用户77	\N
91	perftest78	\N	\N	$2a$10$KX83u.M93m6HBc/yOeH9VOIj6nJKOC98nloGP54y3JX0K7Nl.bi1O	\N	2026-06-09 20:28:21.458279	2026-06-09 20:28:21.458279	压测用户78	\N
92	perftest79	\N	\N	$2a$10$Ugzin3Vsmv16sin0y8UleeX9T9mHEnJN4JxXcJVCNyQpg2phdimyW	\N	2026-06-09 20:28:21.651975	2026-06-09 20:28:21.651975	压测用户79	\N
93	perftest80	\N	\N	$2a$10$8F9W7YFdekqgJ6A6n6TFFerjU0T5IWRTwJ6Nj/q9i.0N0T0OndXmm	\N	2026-06-09 20:28:21.840228	2026-06-09 20:28:21.840228	压测用户80	\N
94	perftest81	\N	\N	$2a$10$rXYAZ9PU21Uucy7yskynrO1tWi3UYwX6y4N9AEgVBhGMPL7rPX2ae	\N	2026-06-09 20:28:22.020882	2026-06-09 20:28:22.020882	压测用户81	\N
95	perftest82	\N	\N	$2a$10$rN7r1j0qJwjy11ppFtbblOdR5/VO1jW11Uteya66qPKluOJI.XEmq	\N	2026-06-09 20:28:22.200861	2026-06-09 20:28:22.200861	压测用户82	\N
96	perftest83	\N	\N	$2a$10$NTp9oUTGqORmiuW.0mW.qesVZIx.M4f0kF9Ll5TAHaQD0qEP09lWO	\N	2026-06-09 20:28:22.405312	2026-06-09 20:28:22.405312	压测用户83	\N
97	perftest84	\N	\N	$2a$10$U/r09D0yRqaJS2b1goSIUeaJW/cG3b.LhZRoav9Jv5Xj/iQxOWDQq	\N	2026-06-09 20:28:22.571809	2026-06-09 20:28:22.571809	压测用户84	\N
98	perftest85	\N	\N	$2a$10$73t49Qwi6Fm4gKqg9GRdP.gW2Y/pBCHOfqawfpvi3TQkAiOO39i3C	\N	2026-06-09 20:28:22.752268	2026-06-09 20:28:22.752268	压测用户85	\N
99	perftest86	\N	\N	$2a$10$OFG5KMb/NddeDpuqtTkeb.n6VG6Od20QUdy5Nt3U3LVdiS6yH7iaa	\N	2026-06-09 20:28:22.919032	2026-06-09 20:28:22.919032	压测用户86	\N
100	perftest87	\N	\N	$2a$10$eqUBJl4eFRlRCepP0SGiKehyYUrla65b94z9zTxSVADqdAeggc5RS	\N	2026-06-09 20:28:23.102789	2026-06-09 20:28:23.102789	压测用户87	\N
101	perftest88	\N	\N	$2a$10$WlGywLXwn9vdEX64HzRb1O8AMfGXHqGm5jSN4Js2y16QVXWm8/vAu	\N	2026-06-09 20:28:23.269972	2026-06-09 20:28:23.269972	压测用户88	\N
102	perftest89	\N	\N	$2a$10$VKcYA1hCudn6HEe5vUyjDef32UFBax69KFZ6Yf5H6SEOxizo5bbzO	\N	2026-06-09 20:28:23.550997	2026-06-09 20:28:23.550997	压测用户89	\N
103	perftest90	\N	\N	$2a$10$cbqM9y4oq.0pczV6EhG5yOSaXIl/WwzBgN3B6if7T1eCUV6vNfBYK	\N	2026-06-09 20:28:23.847459	2026-06-09 20:28:23.847459	压测用户90	\N
104	perftest91	\N	\N	$2a$10$PuTvdrXXPEWEBivYsP2ssO6LfU3MwAG5OCr0iyAa7aEPw34LTFcdK	\N	2026-06-09 20:28:24.167527	2026-06-09 20:28:24.167527	压测用户91	\N
105	perftest92	\N	\N	$2a$10$5FDl6eN90/7cak3JVLu4IeWnYIv9elme5JlJc44nAe1PROX0vLswe	\N	2026-06-09 20:28:24.485498	2026-06-09 20:28:24.485498	压测用户92	\N
106	perftest93	\N	\N	$2a$10$4T0J2UqL6EfIeu9EatJLNOFnX11DmsENiz5yufSRKSzacqqVMuupi	\N	2026-06-09 20:28:24.805123	2026-06-09 20:28:24.805123	压测用户93	\N
107	perftest94	\N	\N	$2a$10$iaYFTxVsr24gmp/s.kh0tu1OeIeGIOClhoqEOaj6ooqkTORfdK3Jm	\N	2026-06-09 20:28:25.140811	2026-06-09 20:28:25.140811	压测用户94	\N
108	perftest95	\N	\N	$2a$10$rToyF9KZkr3S3dUwaC0lg.l6jud5NpdPwHyzYWdtxjfowiUfkWTkW	\N	2026-06-09 20:28:25.448173	2026-06-09 20:28:25.448173	压测用户95	\N
109	perftest96	\N	\N	$2a$10$09jgNRGq.0J.WLIBJnhitel.Qyqg2YXLPMY1KODN6sK3fVlxtJjDG	\N	2026-06-09 20:28:25.770229	2026-06-09 20:28:25.770229	压测用户96	\N
110	perftest97	\N	\N	$2a$10$EKohCr0YNMUKwtKCrlAb7u7EolaEV7/CMFigHaVl3bswxnF1nWPqS	\N	2026-06-09 20:28:26.132049	2026-06-09 20:28:26.132049	压测用户97	\N
111	perftest98	\N	\N	$2a$10$1ewO2zansBNPLZbz3U/uLeNX9k4QKEqJjpFRPSQyL/gCLzAyGfTL6	\N	2026-06-09 20:28:26.440501	2026-06-09 20:28:26.440501	压测用户98	\N
112	perftest99	\N	\N	$2a$10$7IfwomTjvVMDsed8126OVuhxpupq5MOnJlXNGOIXTHTmoLvLFldBK	\N	2026-06-09 20:28:26.790814	2026-06-09 20:28:26.790814	压测用户99	\N
113	perftest100	\N	\N	$2a$10$uI43m.9Xc1xeoGPChiv91uItabWBZmFCoY4dLZyqZlGkqXPET49X6	\N	2026-06-09 20:28:27.120206	2026-06-09 20:28:27.120206	压测用户100	\N
116	test_user1	\N	\N	$2a$10$URADdAd3WhCMQzHqBrkAw.2p.ag2VVTNqhFF8s56zvH0HZ5ihfiVa	\N	2026-06-11 17:36:29.933092	2026-06-11 17:36:30.834388	?????	????
117	再睡五分钟	\N	\N	$2a$10$ZytGx.JHL.cwjOGZk1GwveTaZgqdb4akk1tQrjMo.6285VsX9pUg6	\N	2026-06-26 00:19:21.152213	2026-06-26 00:19:21.152213	再睡五分钟	\N
\.


--
-- Data for Name: user_achievement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_achievement (id, user_id, achievement_id, achieved_at) FROM stdin;
\.


--
-- Data for Name: waypoint; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.waypoint (id, route_id, spot_id, sequence, latitude, longitude, photo_url, instruction, waypoint_type) FROM stdin;
1	3	\N	0	35.6854323	139.7572584			photo
2	3	\N	1	35.6896453	139.7552346			photo
3	4	\N	0	35.6850533	139.7607174	https://xunli-go.oss-cn-beijing.aliyuncs.com/waypoints/2/5b50915a-2d01-4133-a2f1-1ce6566766eb.jpeg	test	photo
\.


--
-- Name: achievement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.achievement_id_seq', 1, false);


--
-- Name: check_in_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.check_in_id_seq', 37, true);


--
-- Name: checkin_like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.checkin_like_id_seq', 37, true);


--
-- Name: membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.membership_id_seq', 1, false);


--
-- Name: pilgrimage_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pilgrimage_record_id_seq', 1, false);


--
-- Name: route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.route_id_seq', 11, true);


--
-- Name: route_point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.route_point_id_seq', 361, true);


--
-- Name: route_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.route_rating_id_seq', 1, true);


--
-- Name: route_spot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.route_spot_id_seq', 4, true);


--
-- Name: spot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.spot_id_seq', 1504, true);


--
-- Name: user_achievement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_achievement_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 117, true);


--
-- Name: waypoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.waypoint_id_seq', 3, true);


--
-- Name: achievement achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_pkey PRIMARY KEY (id);


--
-- Name: anime anime_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anime
    ADD CONSTRAINT anime_pkey PRIMARY KEY (bangumi_id);


--
-- Name: check_in check_in_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in
    ADD CONSTRAINT check_in_pkey PRIMARY KEY (id);


--
-- Name: checkin_like checkin_like_check_in_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkin_like
    ADD CONSTRAINT checkin_like_check_in_id_user_id_key UNIQUE (check_in_id, user_id);


--
-- Name: checkin_like checkin_like_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkin_like
    ADD CONSTRAINT checkin_like_pkey PRIMARY KEY (id);


--
-- Name: membership membership_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_pkey PRIMARY KEY (id);


--
-- Name: pilgrimage_record pilgrimage_record_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilgrimage_record
    ADD CONSTRAINT pilgrimage_record_pkey PRIMARY KEY (id);


--
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- Name: route_point route_point_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_point
    ADD CONSTRAINT route_point_pkey PRIMARY KEY (id);


--
-- Name: route_rating route_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_rating
    ADD CONSTRAINT route_rating_pkey PRIMARY KEY (id);


--
-- Name: route_rating route_rating_route_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_rating
    ADD CONSTRAINT route_rating_route_id_user_id_key UNIQUE (route_id, user_id);


--
-- Name: route_spot route_spot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_spot
    ADD CONSTRAINT route_spot_pkey PRIMARY KEY (id);


--
-- Name: route_spot route_spot_route_id_spot_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_spot
    ADD CONSTRAINT route_spot_route_id_spot_id_key UNIQUE (route_id, spot_id);


--
-- Name: route_spot route_spot_route_id_visit_order_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_spot
    ADD CONSTRAINT route_spot_route_id_visit_order_key UNIQUE (route_id, visit_order);


--
-- Name: spot spot_anitabi_point_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spot
    ADD CONSTRAINT spot_anitabi_point_id_key UNIQUE (anitabi_point_id);


--
-- Name: spot spot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spot
    ADD CONSTRAINT spot_pkey PRIMARY KEY (id);


--
-- Name: user_achievement user_achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement
    ADD CONSTRAINT user_achievement_pkey PRIMARY KEY (id);


--
-- Name: user_achievement user_achievement_user_id_achievement_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement
    ADD CONSTRAINT user_achievement_user_id_achievement_id_key UNIQUE (user_id, achievement_id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_phone_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_phone_key UNIQUE (phone);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: waypoint waypoint_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waypoint
    ADD CONSTRAINT waypoint_pkey PRIMARY KEY (id);


--
-- Name: idx_check_in_spot_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_check_in_spot_id ON public.check_in USING btree (spot_id);


--
-- Name: idx_check_in_status_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_check_in_status_created_at ON public.check_in USING btree (status, created_at DESC);


--
-- Name: idx_check_in_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_check_in_user_id ON public.check_in USING btree (user_id);


--
-- Name: idx_checkin_like_check_in_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_checkin_like_check_in_id ON public.checkin_like USING btree (check_in_id);


--
-- Name: idx_checkin_like_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_checkin_like_user_id ON public.checkin_like USING btree (user_id);


--
-- Name: idx_membership_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_membership_user_id ON public.membership USING btree (user_id);


--
-- Name: idx_pilgrimage_record_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pilgrimage_record_user_id ON public.pilgrimage_record USING btree (user_id);


--
-- Name: idx_route_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_route_anime_id ON public.route USING btree (anime_id);


--
-- Name: idx_route_point_route_seq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_route_point_route_seq ON public.route_point USING btree (route_id, sequence);


--
-- Name: idx_route_status_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_route_status_created_at ON public.route USING btree (status, created_at DESC);


--
-- Name: idx_route_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_route_user_id ON public.route USING btree (user_id);


--
-- Name: idx_spot_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_spot_anime_id ON public.spot USING btree (anime_id);


--
-- Name: idx_spot_anime_id_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_spot_anime_id_id ON public.spot USING btree (anime_id, id);


--
-- Name: idx_spot_location; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_spot_location ON public.spot USING gist (location);


--
-- Name: idx_waypoint_route_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_waypoint_route_id ON public.waypoint USING btree (route_id);


--
-- Name: check_in check_in_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in
    ADD CONSTRAINT check_in_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(id);


--
-- Name: check_in check_in_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in
    ADD CONSTRAINT check_in_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spot(id);


--
-- Name: check_in check_in_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.check_in
    ADD CONSTRAINT check_in_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: checkin_like checkin_like_check_in_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkin_like
    ADD CONSTRAINT checkin_like_check_in_id_fkey FOREIGN KEY (check_in_id) REFERENCES public.check_in(id);


--
-- Name: checkin_like checkin_like_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.checkin_like
    ADD CONSTRAINT checkin_like_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: membership membership_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.membership
    ADD CONSTRAINT membership_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: pilgrimage_record pilgrimage_record_anime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilgrimage_record
    ADD CONSTRAINT pilgrimage_record_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.anime(bangumi_id);


--
-- Name: pilgrimage_record pilgrimage_record_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilgrimage_record
    ADD CONSTRAINT pilgrimage_record_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(id);


--
-- Name: pilgrimage_record pilgrimage_record_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pilgrimage_record
    ADD CONSTRAINT pilgrimage_record_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: route route_anime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.anime(bangumi_id);


--
-- Name: route_point route_point_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_point
    ADD CONSTRAINT route_point_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(id);


--
-- Name: route_rating route_rating_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_rating
    ADD CONSTRAINT route_rating_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(id);


--
-- Name: route_rating route_rating_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_rating
    ADD CONSTRAINT route_rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: route_spot route_spot_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_spot
    ADD CONSTRAINT route_spot_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(id);


--
-- Name: route_spot route_spot_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_spot
    ADD CONSTRAINT route_spot_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spot(id);


--
-- Name: route route_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: spot spot_anime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spot
    ADD CONSTRAINT spot_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.anime(bangumi_id);


--
-- Name: user_achievement user_achievement_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement
    ADD CONSTRAINT user_achievement_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievement(id);


--
-- Name: user_achievement user_achievement_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement
    ADD CONSTRAINT user_achievement_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: waypoint waypoint_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waypoint
    ADD CONSTRAINT waypoint_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(id);


--
-- Name: waypoint waypoint_spot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waypoint
    ADD CONSTRAINT waypoint_spot_id_fkey FOREIGN KEY (spot_id) REFERENCES public.spot(id);


--
-- PostgreSQL database dump complete
--

\unrestrict yb4FonfIre1GFt1xBs0lCGFX2waeJPfwiCSrkdxiVNZDOjadgeci0RZFkjiKwHb

