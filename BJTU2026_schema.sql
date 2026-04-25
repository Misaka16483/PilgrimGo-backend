--
-- PostgreSQL database dump
--

\restrict R9VgaS7tXPMzEyAihop2XThZCrzzj7aax2eEq6Xuhg37Tm8VimyZTThIBvwpswF

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 18.3 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

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
    created_at timestamp without time zone DEFAULT now() NOT NULL
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
    status character varying(20) DEFAULT 'pending'::character varying,
    recorded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
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
    nickname character varying(50),
    bio text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
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
-- Name: idx_check_in_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_check_in_user_id ON public.check_in USING btree (user_id);


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
-- Name: idx_route_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_route_user_id ON public.route USING btree (user_id);


--
-- Name: idx_spot_anime_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_spot_anime_id ON public.spot USING btree (anime_id);


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

\unrestrict R9VgaS7tXPMzEyAihop2XThZCrzzj7aax2eEq6Xuhg37Tm8VimyZTThIBvwpswF

