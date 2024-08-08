-- Table: public.dim_author

-- DROP TABLE IF EXISTS public.dim_author;

CREATE TABLE IF NOT EXISTS public.dim_author
(
    id integer NOT NULL DEFAULT nextval('dim_author_id_seq'::regclass),
    author character varying(50) COLLATE pg_catalog."default",
    author_type character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_author_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_author
    OWNER to postgres;

-- Table: public.dim_comment_level

-- DROP TABLE IF EXISTS public.dim_comment_level;

CREATE TABLE IF NOT EXISTS public.dim_comment_level
(
    id integer NOT NULL DEFAULT nextval('dim_comment_level_id_seq'::regclass),
    comment_level character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_comment_level_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_comment_level
    OWNER to postgres;

-- Table: public.dim_duration_level

-- DROP TABLE IF EXISTS public.dim_duration_level;

CREATE TABLE IF NOT EXISTS public.dim_duration_level
(
    id integer NOT NULL DEFAULT nextval('dim_duration_level_id_seq'::regclass),
    duration_level character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_duration_level_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_duration_level
    OWNER to postgres;

-- Table: public.dim_like_level

-- DROP TABLE IF EXISTS public.dim_like_level;

CREATE TABLE IF NOT EXISTS public.dim_like_level
(
    id integer NOT NULL DEFAULT nextval('dim_like_level_id_seq'::regclass),
    like_level character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_like_level_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_like_level
    OWNER to postgres;

-- Table: public.dim_topic

-- DROP TABLE IF EXISTS public.dim_topic;

CREATE TABLE IF NOT EXISTS public.dim_topic
(
    id integer NOT NULL DEFAULT nextval('dim_topic_id_seq'::regclass),
    topic character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_topic_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_topic
    OWNER to postgres;

-- Table: public.dim_view_level

-- DROP TABLE IF EXISTS public.dim_view_level;

CREATE TABLE IF NOT EXISTS public.dim_view_level
(
    id integer NOT NULL DEFAULT nextval('dim_view_level_id_seq'::regclass),
    view_level character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_view_level_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.dim_view_level
    OWNER to postgres;

-- Table: public.fact_spiderum_youtube

-- DROP TABLE IF EXISTS public.fact_spiderum_youtube;

CREATE TABLE IF NOT EXISTS public.fact_spiderum_youtube
(
    id integer NOT NULL,
    id_view_level integer,
    id_like_level integer,
    id_comment_level integer,
    id_author integer,
    id_topic integer,
    id_duration integer,
    create_at date,
    title character varying(500) COLLATE pg_catalog."default",
    view_count integer,
    like_count integer,
    comment_count integer,
    CONSTRAINT fact_spiderum_youtube_pkey PRIMARY KEY (id),
    CONSTRAINT fk_id_author FOREIGN KEY (id_author)
        REFERENCES public.dim_author (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_id_comment FOREIGN KEY (id_comment_level)
        REFERENCES public.dim_comment_level (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_id_duration FOREIGN KEY (id_duration)
        REFERENCES public.dim_duration_level (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_id_like FOREIGN KEY (id_like_level)
        REFERENCES public.dim_like_level (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_id_topic FOREIGN KEY (id_topic)
        REFERENCES public.dim_topic (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_id_view FOREIGN KEY (id_view_level)
        REFERENCES public.dim_view_level (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fact_spiderum_youtube
    OWNER to postgres;

-- Table: public.test

-- DROP TABLE IF EXISTS public.test;

CREATE TABLE IF NOT EXISTS public.test
(
    video_id character varying(50) COLLATE pg_catalog."default",
    title character varying(500) COLLATE pg_catalog."default",
    published_at date,
    duration character varying(20) COLLATE pg_catalog."default",
    dimension character varying(10) COLLATE pg_catalog."default",
    definition character varying(10) COLLATE pg_catalog."default",
    view_count integer,
    like_count integer,
    "dislikeCount" text COLLATE pg_catalog."default",
    favorite_count integer,
    commnent_count integer,
    tags text COLLATE pg_catalog."default",
    date_extract date,
    playlist_title character varying(100) COLLATE pg_catalog."default",
    author character varying(100) COLLATE pg_catalog."default",
    split_array text[] COLLATE pg_catalog."default",
    title_lower character varying(500) COLLATE pg_catalog."default",
    duration_seconds integer,
    id_view_level integer,
    id_like_level integer,
    id_comment_level integer,
    id_author integer,
    id_topic integer,
    id_duration integer,
    id integer NOT NULL DEFAULT nextval('test_id_seq'::regclass),
    CONSTRAINT test_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.test
    OWNER to postgres;