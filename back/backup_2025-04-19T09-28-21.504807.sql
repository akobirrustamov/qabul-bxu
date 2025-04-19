--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.4 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: abuturient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abuturient (
    appeal_type_id integer,
    contract_number integer,
    education_field_id integer,
    get_contract boolean,
    is_active boolean,
    language boolean,
    status integer,
    created_at timestamp(6) without time zone,
    enrolled_at timestamp(6) without time zone,
    agent_id uuid,
    id uuid NOT NULL,
    additional_phone character varying(255),
    ball character varying(255),
    father_name character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    passport_number character varying(255),
    passport_pin character varying(255),
    phone character varying(255) NOT NULL
);


ALTER TABLE public.abuturient OWNER TO postgres;

--
-- Name: administrator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrator (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    login character varying(255),
    name character varying(255),
    password character varying(255)
);


ALTER TABLE public.administrator OWNER TO postgres;

--
-- Name: administrator_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administrator_id_seq OWNER TO postgres;

--
-- Name: administrator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrator_id_seq OWNED BY public.administrator.id;


--
-- Name: agent_path; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agent_path (
    agent_number integer,
    id integer NOT NULL,
    agent_id uuid
);


ALTER TABLE public.agent_path OWNER TO postgres;

--
-- Name: agent_path_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agent_path_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agent_path_id_seq OWNER TO postgres;

--
-- Name: agent_path_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agent_path_id_seq OWNED BY public.agent_path.id;


--
-- Name: appeal_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appeal_type (
    id integer NOT NULL,
    is_active boolean,
    created_at timestamp(6) without time zone,
    name character varying(255)
);


ALTER TABLE public.appeal_type OWNER TO postgres;

--
-- Name: appeal_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appeal_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appeal_type_id_seq OWNER TO postgres;

--
-- Name: appeal_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appeal_type_id_seq OWNED BY public.appeal_type.id;


--
-- Name: attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachment (
    id uuid NOT NULL,
    name character varying(255),
    prefix character varying(255)
);


ALTER TABLE public.attachment OWNER TO postgres;

--
-- Name: certificate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificate (
    id integer NOT NULL,
    abuturient_id uuid,
    attachment_id uuid
);


ALTER TABLE public.certificate OWNER TO postgres;

--
-- Name: certificate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certificate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.certificate_id_seq OWNER TO postgres;

--
-- Name: certificate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certificate_id_seq OWNED BY public.certificate.id;


--
-- Name: command; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.command (
    ball integer,
    command_staff_id integer,
    id integer NOT NULL,
    message_send boolean,
    number integer,
    staff_id integer,
    status integer,
    created_at timestamp(6) without time zone,
    response_time timestamp(6) without time zone,
    time_limit timestamp(6) without time zone,
    file_id uuid,
    response_file_id uuid,
    description character varying(1000),
    response_description character varying(1000),
    response_text character varying(255),
    text character varying(255)
);


ALTER TABLE public.command OWNER TO postgres;

--
-- Name: command_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.command_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.command_id_seq OWNER TO postgres;

--
-- Name: command_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.command_id_seq OWNED BY public.command.id;


--
-- Name: command_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.command_message (
    command_id integer,
    history_id integer,
    id integer NOT NULL,
    status integer,
    status_command integer,
    created_at timestamp(6) without time zone,
    file_id uuid,
    message character varying(255)
);


ALTER TABLE public.command_message OWNER TO postgres;

--
-- Name: command_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.command_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.command_message_id_seq OWNER TO postgres;

--
-- Name: command_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.command_message_id_seq OWNED BY public.command_message.id;


--
-- Name: command_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.command_rating (
    command_id integer,
    id integer NOT NULL,
    rating integer
);


ALTER TABLE public.command_rating OWNER TO postgres;

--
-- Name: command_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.command_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.command_rating_id_seq OWNER TO postgres;

--
-- Name: command_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.command_rating_id_seq OWNED BY public.command_rating.id;


--
-- Name: commander; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commander (
    id integer NOT NULL,
    rank_id integer,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.commander OWNER TO postgres;

--
-- Name: commander_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commander_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commander_id_seq OWNER TO postgres;

--
-- Name: commander_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commander_id_seq OWNED BY public.commander.id;


--
-- Name: commander_ranks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commander_ranks (
    commander_id integer NOT NULL,
    ranks_id integer NOT NULL
);


ALTER TABLE public.commander_ranks OWNER TO postgres;

--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    id integer NOT NULL,
    region_id integer,
    vacancy integer,
    vacancy_name_id integer,
    email character varying(255),
    login character varying(255),
    name character varying(255),
    owner character varying(255),
    password character varying(255),
    support_phone character varying(255)
);


ALTER TABLE public.company OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_id_seq OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_id_seq OWNED BY public.company.id;


--
-- Name: daily_control; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_control (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    description character varying(255),
    name character varying(255)
);


ALTER TABLE public.daily_control OWNER TO postgres;

--
-- Name: daily_control_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_control_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_control_id_seq OWNER TO postgres;

--
-- Name: daily_control_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_control_id_seq OWNED BY public.daily_control.id;


--
-- Name: daily_control_sub_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_control_sub_folder (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    description character varying(255),
    name character varying(255),
    daily_control_id integer,
    staff_id integer
);


ALTER TABLE public.daily_control_sub_folder OWNER TO postgres;

--
-- Name: daily_control_sub_folder_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_control_sub_folder_content (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    description character varying(255),
    link_to_file character varying(255),
    name character varying(255),
    attachment_id uuid,
    daily_control_sub_folder_id integer,
    staff_id integer
);


ALTER TABLE public.daily_control_sub_folder_content OWNER TO postgres;

--
-- Name: daily_control_sub_folder_content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_control_sub_folder_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_control_sub_folder_content_id_seq OWNER TO postgres;

--
-- Name: daily_control_sub_folder_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_control_sub_folder_content_id_seq OWNED BY public.daily_control_sub_folder_content.id;


--
-- Name: daily_control_sub_folder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_control_sub_folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_control_sub_folder_id_seq OWNER TO postgres;

--
-- Name: daily_control_sub_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_control_sub_folder_id_seq OWNED BY public.daily_control_sub_folder.id;


--
-- Name: duty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.duty (
    id integer NOT NULL,
    rank_id integer,
    staff_id integer,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.duty OWNER TO postgres;

--
-- Name: duty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.duty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.duty_id_seq OWNER TO postgres;

--
-- Name: duty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.duty_id_seq OWNED BY public.duty.id;


--
-- Name: education_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_field (
    education_duration integer,
    education_form_id integer,
    id integer NOT NULL,
    ijodiy boolean,
    is_active boolean,
    test_education_field_id integer,
    created_at timestamp(6) without time zone,
    name character varying(255),
    price character varying(255)
);


ALTER TABLE public.education_field OWNER TO postgres;

--
-- Name: education_field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_field_id_seq OWNER TO postgres;

--
-- Name: education_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_field_id_seq OWNED BY public.education_field.id;


--
-- Name: education_form; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_form (
    education_type_id integer,
    id integer NOT NULL,
    is_active boolean,
    created_at timestamp(6) without time zone,
    name character varying(255)
);


ALTER TABLE public.education_form OWNER TO postgres;

--
-- Name: education_form_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_form_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_form_id_seq OWNER TO postgres;

--
-- Name: education_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_form_id_seq OWNED BY public.education_form.id;


--
-- Name: education_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_type (
    id integer NOT NULL,
    is_active boolean,
    created_at timestamp(6) without time zone,
    name character varying(255)
);


ALTER TABLE public.education_type OWNER TO postgres;

--
-- Name: education_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_type_id_seq OWNER TO postgres;

--
-- Name: education_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_type_id_seq OWNED BY public.education_type.id;


--
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    id integer NOT NULL,
    title character varying(255)
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- Name: faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_id_seq OWNER TO postgres;

--
-- Name: faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_id_seq OWNED BY public.faculty.id;


--
-- Name: gallery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gallery (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    main_photo_id uuid
);


ALTER TABLE public.gallery OWNER TO postgres;

--
-- Name: gallery_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gallery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gallery_id_seq OWNER TO postgres;

--
-- Name: gallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gallery_id_seq OWNED BY public.gallery.id;


--
-- Name: history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history (
    command_id integer,
    from_status integer,
    id integer NOT NULL,
    to_status integer,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.history OWNER TO postgres;

--
-- Name: history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.history_id_seq OWNER TO postgres;

--
-- Name: history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;


--
-- Name: kitoblar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kitoblar (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    main_photo_id uuid,
    description character varying(255),
    title character varying(255)
);


ALTER TABLE public.kitoblar OWNER TO postgres;

--
-- Name: kitoblar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kitoblar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kitoblar_id_seq OWNER TO postgres;

--
-- Name: kitoblar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kitoblar_id_seq OWNED BY public.kitoblar.id;


--
-- Name: kitoblar_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kitoblar_photos (
    book_id integer NOT NULL,
    photos_id uuid NOT NULL
);


ALTER TABLE public.kitoblar_photos OWNER TO postgres;

--
-- Name: language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.language (
    id integer NOT NULL,
    is_active boolean,
    created_at timestamp(6) without time zone,
    name character varying(255)
);


ALTER TABLE public.language OWNER TO postgres;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.language_id_seq OWNER TO postgres;

--
-- Name: language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.language_id_seq OWNED BY public.language.id;


--
-- Name: memorandum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.memorandum (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    main_photo_id uuid,
    description character varying(255),
    title character varying(255)
);


ALTER TABLE public.memorandum OWNER TO postgres;

--
-- Name: memorandum_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.memorandum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.memorandum_id_seq OWNER TO postgres;

--
-- Name: memorandum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.memorandum_id_seq OWNED BY public.memorandum.id;


--
-- Name: memorandum_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.memorandum_photos (
    memorandum_id integer NOT NULL,
    photos_id uuid NOT NULL
);


ALTER TABLE public.memorandum_photos OWNER TO postgres;

--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id integer NOT NULL,
    date timestamp(6) without time zone,
    message character varying(255),
    name character varying(255),
    phone character varying(255)
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_id_seq OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- Name: my_test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.my_test (
    id integer NOT NULL,
    test_subject_id integer,
    answer character varying(1000),
    question character varying(1000),
    wrong_answer1 character varying(1000),
    wrong_answer2 character varying(1000),
    wrong_answer3 character varying(1000)
);


ALTER TABLE public.my_test OWNER TO postgres;

--
-- Name: my_test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.my_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.my_test_id_seq OWNER TO postgres;

--
-- Name: my_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.my_test_id_seq OWNED BY public.my_test.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    main_photo_id uuid,
    description character varying(10000),
    title character varying(255)
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_id_seq OWNER TO postgres;

--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: news_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_photos (
    news_id integer NOT NULL,
    photos_id uuid NOT NULL
);


ALTER TABLE public.news_photos OWNER TO postgres;

--
-- Name: newspaper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.newspaper (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    main_photo_id uuid,
    description character varying(255),
    title character varying(255)
);


ALTER TABLE public.newspaper OWNER TO postgres;

--
-- Name: newspaper_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newspaper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.newspaper_id_seq OWNER TO postgres;

--
-- Name: newspaper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newspaper_id_seq OWNED BY public.newspaper.id;


--
-- Name: newspaper_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.newspaper_photos (
    newspaper_id integer NOT NULL,
    photos_id uuid NOT NULL
);


ALTER TABLE public.newspaper_photos OWNER TO postgres;

--
-- Name: nomenklatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nomenklatura (
    id integer NOT NULL,
    number_packages integer,
    user_id integer,
    created_at timestamp(6) without time zone,
    code character varying(255),
    name character varying(255)
);


ALTER TABLE public.nomenklatura OWNER TO postgres;

--
-- Name: nomenklatura_file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nomenklatura_file (
    folder integer,
    id integer NOT NULL,
    nomenklatura_id integer,
    created_at timestamp(6) without time zone,
    file_id uuid,
    description character varying(255)
);


ALTER TABLE public.nomenklatura_file OWNER TO postgres;

--
-- Name: nomenklatura_file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nomenklatura_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nomenklatura_file_id_seq OWNER TO postgres;

--
-- Name: nomenklatura_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nomenklatura_file_id_seq OWNED BY public.nomenklatura_file.id;


--
-- Name: nomenklatura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nomenklatura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nomenklatura_id_seq OWNER TO postgres;

--
-- Name: nomenklatura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nomenklatura_id_seq OWNED BY public.nomenklatura.id;


--
-- Name: rank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rank (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    name character varying(255)
);


ALTER TABLE public.rank OWNER TO postgres;

--
-- Name: rank_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rank_id_seq OWNER TO postgres;

--
-- Name: rank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rank_id_seq OWNED BY public.rank.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.region_id_seq OWNER TO postgres;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    CONSTRAINT role_name_check CHECK (((name)::text = ANY ((ARRAY['ROLE_ADMIN'::character varying, 'ROLE_STUDENT'::character varying, 'ROLE_GENERATOR'::character varying, 'ROLE_USER'::character varying, 'ROLE_COMPANY'::character varying, 'ROLE_TEACHER'::character varying, 'ROLE_ADMINISTRATOR'::character varying, 'ROLE_RECTOR'::character varying])::text[])))
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    score integer,
    created_at timestamp(6) without time zone,
    file_id uuid,
    fcm_token character varying(255),
    name character varying(255),
    passport_number character varying(255),
    passport_pin character varying(255),
    password character varying(255),
    phone character varying(255),
    telegram_id character varying(255)
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    updated_at timestamp(6) without time zone,
    id uuid NOT NULL,
    address character varying(255),
    education_form character varying(255),
    education_type character varying(255),
    faculty character varying(255),
    first_name character varying(255),
    gender character varying(255),
    group_name character varying(255),
    image character varying(255),
    level character varying(255),
    passport_number character varying(255),
    passport_pin character varying(255),
    payment_form character varying(255),
    phone character varying(255),
    province character varying(255),
    second_name character varying(255),
    semester character varying(255),
    specialty character varying(255),
    student_status character varying(255),
    third_name character varying(255)
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    faculty_id integer,
    id integer NOT NULL,
    place integer,
    created_at timestamp(6) without time zone,
    main_photo_id uuid,
    description character varying(3000),
    title character varying(255)
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_id_seq OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: test_education_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_education_field (
    id integer NOT NULL,
    test1_id integer,
    test2_id integer,
    test3_id integer,
    test4_id integer,
    test5_id integer
);


ALTER TABLE public.test_education_field OWNER TO postgres;

--
-- Name: test_education_field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_education_field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_education_field_id_seq OWNER TO postgres;

--
-- Name: test_education_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_education_field_id_seq OWNED BY public.test_education_field.id;


--
-- Name: test_score; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_score (
    id integer NOT NULL,
    status integer,
    "time" timestamp(6) without time zone,
    abuturient_id uuid,
    right_score character varying(255),
    score character varying(255)
);


ALTER TABLE public.test_score OWNER TO postgres;

--
-- Name: test_score_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_score_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_score_id_seq OWNER TO postgres;

--
-- Name: test_score_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_score_id_seq OWNED BY public.test_score.id;


--
-- Name: test_subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_subject (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    description character varying(255),
    name character varying(255) NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE public.test_subject OWNER TO postgres;

--
-- Name: test_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_subject_id_seq OWNER TO postgres;

--
-- Name: test_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_subject_id_seq OWNED BY public.test_subject.id;


--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    name character varying(255)
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.token_id_seq OWNER TO postgres;

--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_id_seq OWNED BY public.token.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    password character varying(255),
    phone character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_roles (
    roles_id integer NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.users_roles OWNER TO postgres;

--
-- Name: vacancy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vacancy (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.vacancy OWNER TO postgres;

--
-- Name: vacancy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vacancy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vacancy_id_seq OWNER TO postgres;

--
-- Name: vacancy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vacancy_id_seq OWNED BY public.vacancy.id;


--
-- Name: youtube; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.youtube (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    iframe character varying(500),
    hash_tag character varying(255),
    title character varying(255)
);


ALTER TABLE public.youtube OWNER TO postgres;

--
-- Name: youtube_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.youtube_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.youtube_id_seq OWNER TO postgres;

--
-- Name: youtube_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.youtube_id_seq OWNED BY public.youtube.id;


--
-- Name: administrator id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator ALTER COLUMN id SET DEFAULT nextval('public.administrator_id_seq'::regclass);


--
-- Name: agent_path id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent_path ALTER COLUMN id SET DEFAULT nextval('public.agent_path_id_seq'::regclass);


--
-- Name: appeal_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appeal_type ALTER COLUMN id SET DEFAULT nextval('public.appeal_type_id_seq'::regclass);


--
-- Name: certificate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificate ALTER COLUMN id SET DEFAULT nextval('public.certificate_id_seq'::regclass);


--
-- Name: command id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command ALTER COLUMN id SET DEFAULT nextval('public.command_id_seq'::regclass);


--
-- Name: command_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_message ALTER COLUMN id SET DEFAULT nextval('public.command_message_id_seq'::regclass);


--
-- Name: command_rating id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_rating ALTER COLUMN id SET DEFAULT nextval('public.command_rating_id_seq'::regclass);


--
-- Name: commander id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commander ALTER COLUMN id SET DEFAULT nextval('public.commander_id_seq'::regclass);


--
-- Name: company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN id SET DEFAULT nextval('public.company_id_seq'::regclass);


--
-- Name: daily_control id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control ALTER COLUMN id SET DEFAULT nextval('public.daily_control_id_seq'::regclass);


--
-- Name: daily_control_sub_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder ALTER COLUMN id SET DEFAULT nextval('public.daily_control_sub_folder_id_seq'::regclass);


--
-- Name: daily_control_sub_folder_content id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder_content ALTER COLUMN id SET DEFAULT nextval('public.daily_control_sub_folder_content_id_seq'::regclass);


--
-- Name: duty id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duty ALTER COLUMN id SET DEFAULT nextval('public.duty_id_seq'::regclass);


--
-- Name: education_field id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_field ALTER COLUMN id SET DEFAULT nextval('public.education_field_id_seq'::regclass);


--
-- Name: education_form id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_form ALTER COLUMN id SET DEFAULT nextval('public.education_form_id_seq'::regclass);


--
-- Name: education_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_type ALTER COLUMN id SET DEFAULT nextval('public.education_type_id_seq'::regclass);


--
-- Name: faculty id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty ALTER COLUMN id SET DEFAULT nextval('public.faculty_id_seq'::regclass);


--
-- Name: gallery id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery ALTER COLUMN id SET DEFAULT nextval('public.gallery_id_seq'::regclass);


--
-- Name: history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);


--
-- Name: kitoblar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar ALTER COLUMN id SET DEFAULT nextval('public.kitoblar_id_seq'::regclass);


--
-- Name: language id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language ALTER COLUMN id SET DEFAULT nextval('public.language_id_seq'::regclass);


--
-- Name: memorandum id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum ALTER COLUMN id SET DEFAULT nextval('public.memorandum_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- Name: my_test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_test ALTER COLUMN id SET DEFAULT nextval('public.my_test_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: newspaper id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper ALTER COLUMN id SET DEFAULT nextval('public.newspaper_id_seq'::regclass);


--
-- Name: nomenklatura id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura ALTER COLUMN id SET DEFAULT nextval('public.nomenklatura_id_seq'::regclass);


--
-- Name: nomenklatura_file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura_file ALTER COLUMN id SET DEFAULT nextval('public.nomenklatura_file_id_seq'::regclass);


--
-- Name: rank id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rank ALTER COLUMN id SET DEFAULT nextval('public.rank_id_seq'::regclass);


--
-- Name: region id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Name: test_education_field id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field ALTER COLUMN id SET DEFAULT nextval('public.test_education_field_id_seq'::regclass);


--
-- Name: test_score id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_score ALTER COLUMN id SET DEFAULT nextval('public.test_score_id_seq'::regclass);


--
-- Name: test_subject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_subject ALTER COLUMN id SET DEFAULT nextval('public.test_subject_id_seq'::regclass);


--
-- Name: token id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token ALTER COLUMN id SET DEFAULT nextval('public.token_id_seq'::regclass);


--
-- Name: vacancy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vacancy ALTER COLUMN id SET DEFAULT nextval('public.vacancy_id_seq'::regclass);


--
-- Name: youtube id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youtube ALTER COLUMN id SET DEFAULT nextval('public.youtube_id_seq'::regclass);


--
-- Data for Name: abuturient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.abuturient (appeal_type_id, contract_number, education_field_id, get_contract, is_active, language, status, created_at, enrolled_at, agent_id, id, additional_phone, ball, father_name, first_name, last_name, passport_number, passport_pin, phone) FROM stdin;
\N	43082	\N	\N	\N	\N	0	2025-02-12 08:33:21.548758	\N	\N	733c2946-e079-4059-a2ab-6e3c13372dae	\N	\N	\N	\N	\N	\N	\N	+998934893489
\N	57497	\N	\N	\N	\N	0	2025-02-12 08:33:25.744217	\N	\N	36fa16ca-be03-4fb1-9568-dd0a4b9c51ed	\N	\N	\N	\N	\N	\N	\N	+998349349090
\N	25023	\N	\N	\N	\N	0	2025-02-12 08:33:29.40255	\N	\N	f1b36dd0-d2b1-4c2f-b9e0-1d3fc4520308	\N	\N	\N	\N	\N	\N	\N	+998239020939
1	38109	8	\N	\N	\N	1	2025-02-12 10:38:36.347365	2025-02-12 10:38:59.030218	\N	82e56b9c-5bb1-4b83-8009-844fe3103298	\N	\N		qqqqq	wwwww	\N	\N	+998430925904
1	80801	9	\N	\N	\N	1	2025-02-12 10:39:06.111889	2025-02-12 10:39:16.52639	\N	bf6719f3-5cd6-4fd4-abb4-98b19bb1b8bc	\N	\N		eeee	rrrr	\N	\N	+998345434565
1	89743	18	\N	\N	\N	1	2025-02-12 10:39:22.404975	2025-02-12 10:39:32.869683	\N	694bebcc-6e7a-4679-9975-034bb1b70902	\N	\N		ttttt	yyyyy	\N	\N	+998456676767
1	64989	8	t	\N	\N	2	2025-02-19 16:58:07.449502	2025-02-19 16:58:16.771946	\N	e8f3ef13-5136-42c5-8491-a4eaf2b2bfec	\N	36.4		sadsacxsdc	cadscdsc	\N	\N	+998232332232
1	46945	14	t	\N	\N	4	2025-02-18 14:47:50.592121	2025-02-18 14:48:02.664524	\N	b696fa54-a3f8-4827-9e87-6f28163b7e4c	\N	75.7	sdvsdv	sjdhbcshjdv	sdvsdvv	\N	\N	+998834834843
1	54600	8	\N	\N	\N	4	2025-02-12 08:33:01.276948	2025-02-12 08:33:10.747311	\N	22fc4052-f732-4bdb-821e-df58b692fdc5	\N	\N		salads	sdada	\N	\N	+998232233232
1	28510	8	\N	\N	\N	1	2025-02-19 16:00:01.284276	2025-02-19 16:00:11.603187	\N	9364a867-ef23-4e74-9aba-118a6151b092	\N	\N		hjhj	buh	\N	\N	+998888989898
1	79357	8	t	\N	\N	2	2025-02-19 17:32:18.998408	2025-02-19 17:32:28.491008	\N	bac68774-87fb-481d-92c7-e309131686b2	\N	23.6		zncjksndjcscd	sncdjknsjkcnjsdc	\N	\N	+998734783477
1	84168	8	\N	\N	\N	4	2025-02-10 09:45:33.444114	2025-02-10 09:45:44.331112	\N	61e0d025-7004-4189-a5ef-04f056237218	\N	\N		sods	asd	\N	\N	+998123123123
1	88971	11	t	\N	\N	4	2025-02-19 16:00:39.275809	2025-02-19 16:00:58.83724	\N	7b4ced50-900f-46b7-9171-6385f46d0f12	\N	77.7		j	n	\N	\N	+998898098098
1	82945	11	t	\N	\N	3	2025-02-19 16:07:36.2207	2025-02-19 16:07:47.402813	\N	530c54aa-af69-4aa1-936f-4a4851e91c4f	\N	0		343434	344343	\N	\N	+998433434343
1	34291	7	f	\N	\N	3	2025-02-20 17:40:52.3673	2025-02-20 17:41:01.512918	\N	d9389314-5e6e-46b2-9d47-69f66100e329	\N	23.6		scud	cdssdc	\N	\N	+998434344334
1	34108	11	t	\N	\N	3	2025-02-19 16:17:51.243867	2025-02-19 16:18:06.85209	\N	2c192c98-a782-43c1-a3c9-ca2879903057	\N	0		dad	salsa	\N	\N	+998234324234
1	24925	11	t	\N	\N	3	2025-02-19 16:22:55.394983	2025-02-19 16:23:12.501159	\N	c6802796-2941-4a10-a313-0e78dcbb8c87	\N	72		saas	sasa	\N	\N	+998376243275
1	55861	11	\N	\N	\N	1	2025-02-19 16:25:19.872357	2025-02-19 16:25:34.571113	\N	3fe0c841-a06e-4b8d-8094-47f656682b7b	\N	\N		eded	edede	\N	\N	+998254352143
1	61602	52	\N	\N	\N	1	2025-02-20 17:42:00.882625	2025-02-20 17:42:10.000799	\N	e94c98bd-1ff7-41fc-b1b6-b5208fd5b451	\N	\N		sdvsdfv	dfvsdv	\N	\N	+998432344234
1	19585	8	t	\N	\N	3	2025-02-19 16:34:38.846597	2025-02-19 16:34:48.462492	\N	21c1657a-7232-4d29-a6cd-6515e5791c8d	\N	89		hasdjasdj	ashduashd	\N	\N	+998243892347
1	12177	8	\N	\N	\N	1	2025-02-19 16:55:41.410411	2025-02-19 16:55:50.960144	\N	c25d2a79-b63d-48bf-a240-395c167343ce	\N	\N		dssdfcdsc	dccdc	\N	\N	+998548458548
1	20780	11	t	\N	\N	4	2025-02-19 16:01:25.61128	2025-02-19 16:04:53.478569	\N	303e5ad4-1635-42e9-946d-127554579b49	\N	0		kljkljkkj	nm	\N	\N	+998889898989
1	12686	8	\N	\N	\N	2	2025-02-20 17:42:32.961331	2025-02-20 17:42:41.432538	\N	5d3017ca-5477-48af-8aa2-6f30e55c6077	\N	\N		sdcsdsdc	sdcsdcsdc	\N	\N	+998934943934
1	85711	8	t	\N	\N	3	2025-02-19 17:13:33.865966	2025-02-19 17:13:42.2526	\N	c2e906b3-340b-4ee7-ada6-4df7c570a907	\N	51.2		asda	ads	\N	\N	+998889786543
1	27783	8	t	\N	\N	3	2025-02-19 17:15:58.255948	2025-02-19 17:16:07.973832	\N	19005c92-bf2a-497c-8071-9f57d805dd94	\N	95		sfdsdfs	sdfsf	\N	\N	+998545544554
1	16265	8	t	\N	\N	3	2025-02-20 17:53:57.684337	2025-02-20 17:54:08.630397	\N	1ae97a44-8528-4b4b-8de9-7ec8358f24d2	\N	60		vsfdvsdf	dfvsdfvsd	\N	\N	+998543453545
1	86432	8	\N	\N	\N	2	2025-02-20 18:12:20.125104	2025-02-20 18:48:26.433385	\N	d46e1c6f-e682-48e5-832c-90a0bc9f2d9f	\N	\N		sdfsdf	sdfsdf	\N	\N	+998990009990
\.


--
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrator (id, created_at, login, name, password) FROM stdin;
\.


--
-- Data for Name: agent_path; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agent_path (agent_number, id, agent_id) FROM stdin;
9801	1	34db682a-4707-4b31-8aa8-f8580a6653ce
7341	2	7deb2d52-cdd9-4e09-ae4b-70154e9e2c9b
\.


--
-- Data for Name: appeal_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appeal_type (id, is_active, created_at, name) FROM stdin;
1	t	2025-02-10 09:44:42.84494	O'qishga topshirish
2	t	2025-02-10 09:44:42.846586	O'qishni ko'chirish
\.


--
-- Data for Name: attachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachment (id, name, prefix) FROM stdin;
8db35b57-822b-47d4-8ffe-aa418d1342c2	8db35b57-822b-47d4-8ffe-aa418d1342c2_IOR2024sirtqi.zip	/command/QAYUMOVA NIGORA MUXTOR KIZI
9f1f8e25-71ab-42ce-a104-3aba01003160	9f1f8e25-71ab-42ce-a104-3aba01003160_IOR2024sirtqi.zip	/command/QAYUMOVA NIGORA MUXTOR KIZI
b071cd09-8832-47e3-ba36-634fea70debe	b071cd09-8832-47e3-ba36-634fea70debe_IOR2024sirtqi.rar	/command/QAYUMOVA NIGORA MUXTOR KIZI
f04e2ee8-92e5-45be-9056-0749ba7db314	f04e2ee8-92e5-45be-9056-0749ba7db314_IOR2024sirtqi.zip	/command/QAYUMOVA NIGORA MUXTOR KIZI
ae598dfb-9e28-436f-9bbb-ee62bbf6eae2	ae598dfb-9e28-436f-9bbb-ee62bbf6eae2_IOR2024sirtqi.rar	/command/QAYUMOVA NIGORA MUXTOR KIZI
fc3ea807-7c7f-450e-850f-71427fb8a415	fc3ea807-7c7f-450e-850f-71427fb8a415_fayl.zip	/command/QAYUMOVA NIGORA MUXTOR KIZI
43953378-70a8-4133-9ced-5cc45634d532	43953378-70a8-4133-9ced-5cc45634d532_IOR2024sirtqi.rar	/command/QAYUMOVA NIGORA MUXTOR KIZI
190b9224-e453-4625-abc5-e875334eec46	190b9224-e453-4625-abc5-e875334eec46_IOR2024sirtqi.zip	/command/QAYUMOVA NIGORA MUXTOR KIZI
5f20ae28-796d-4f0a-ae39-2a4846abb329	5f20ae28-796d-4f0a-ae39-2a4846abb329_IOR2024sirtqi.zip	/command/QAYUMOVA NIGORA MUXTOR KIZI
319bc4ad-decc-4454-900e-da1286d61cc4	319bc4ad-decc-4454-900e-da1286d61cc4_IOR2024sirtqi.rar	/command/QAYUMOVA NIGORA MUXTOR KIZI
1747068b-0da0-4fe7-ae38-e1eb0666f495	1747068b-0da0-4fe7-ae38-e1eb0666f495_OnaTili_0-2.docx	/command/QURBONOVA O‘LMAS USMONOVNA
30e02fc4-799c-48eb-8337-664a0811f34d	30e02fc4-799c-48eb-8337-664a0811f34d_OnaTili_0-2.docx	/command/QURBONOVA O‘LMAS USMONOVNA
36481356-f84e-4274-bb65-63ab60d106de	36481356-f84e-4274-bb65-63ab60d106de_OnaTili_0-2.docx	/command/QAYUMOVA NIGORA MUXTOR KIZI
3f42aac0-9837-4be4-8bf3-46c3bbe29bd1	3f42aac0-9837-4be4-8bf3-46c3bbe29bd1_OnaTili_0.docx	/command/QURBONOVA O‘LMAS USMONOVNA
749a89b7-dfd3-47de-9709-a31ceb7fa8e6	749a89b7-dfd3-47de-9709-a31ceb7fa8e6_OnaTili_0.docx	/command/BAROTOV SHUXRAT SHARIPOVICH
688d9c9e-c36b-47e7-a1e3-9d330b6321a5	688d9c9e-c36b-47e7-a1e3-9d330b6321a5_OnaTili_0-2.docx	/command/QURBONOVA O‘LMAS USMONOVNA
b8180bb8-ab73-4a39-a2bd-0cd359836c26	b8180bb8-ab73-4a39-a2bd-0cd359836c26_OnaTili_0-2.docx	/command/QURBONOVA O‘LMAS USMONOVNA
6cf09b9e-576e-47b5-b6c4-8683644b5b46	6cf09b9e-576e-47b5-b6c4-8683644b5b46_BXU-Litsenziya.pdf	book
8d2912e9-20a4-4e79-9a36-460fdc1d9b44	8d2912e9-20a4-4e79-9a36-460fdc1d9b44_Screenshot 2025-03-28 at 10.58.07.png	book
e6799327-46f9-435c-9d3d-388c350f57e9	e6799327-46f9-435c-9d3d-388c350f57e9_Doktorantura.pdf	book
ad491ef1-3685-47d5-8fac-48b9744f1d13	ad491ef1-3685-47d5-8fac-48b9744f1d13_ILMIY AXBOROTNOMASI_№1_2025_FINAL.pdf	book
cc631b0b-3e35-43a1-a493-c09cafb79199	cc631b0b-3e35-43a1-a493-c09cafb79199_image_2024-12-05_17-55-40.png	book
5f140345-e89f-40f8-9569-42dc7a9faac1	5f140345-e89f-40f8-9569-42dc7a9faac1_img.png	/command/staff
4fb869ef-1a60-4fc6-9198-f22bc63a04ab	4fb869ef-1a60-4fc6-9198-f22bc63a04ab_Screenshot 2025-03-28 at 12.00.51.png	/command/staff
ff5128cc-4f31-4a72-95cd-78e6f43f5b5a	ff5128cc-4f31-4a72-95cd-78e6f43f5b5a_Screenshot 2025-03-28 at 12.01.06.png	/command/staff
60bca433-8c48-4f9f-940a-6b2c466b66f7	60bca433-8c48-4f9f-940a-6b2c466b66f7_Screenshot 2025-03-28 at 12.00.51.png	subfolder-content
f670525f-5df8-41c3-baa3-e482d018b9d5	f670525f-5df8-41c3-baa3-e482d018b9d5_Screenshot 2025-03-28 at 12.00.51.png	subfolder-content
784f56f7-b5a4-4089-9522-4f70fd5289eb	784f56f7-b5a4-4089-9522-4f70fd5289eb_Жадвал.docx	subfolder-content
3b188d51-35c0-4940-b58d-fc956f2af633	3b188d51-35c0-4940-b58d-fc956f2af633_Screenshot 2025-03-28 at 12.00.10.png	subfolder-content
6b551641-1630-4f41-aa50-1855ff307adc	6b551641-1630-4f41-aa50-1855ff307adc_Screenshot 2025-03-28 at 12.01.06.png	main
35499acd-0adb-4961-b1d7-8072c8129132	35499acd-0adb-4961-b1d7-8072c8129132_Screenshot 2025-04-02 at 22.31.30.png	additional
43ba74cb-f93e-40e4-a790-7450b3d18ea6	43ba74cb-f93e-40e4-a790-7450b3d18ea6_Screenshot 2025-04-02 at 21.49.56.png	additional
bac0e936-1827-4d99-8681-8143b54e8b02	bac0e936-1827-4d99-8681-8143b54e8b02_Screenshot 2025-04-02 at 21.48.34.png	additional
f829e1af-ff16-4929-956b-0edbcf76b629	f829e1af-ff16-4929-956b-0edbcf76b629_plas.jpg	main
ecea52f8-01fc-440f-8ee4-5c8167c36cff	ecea52f8-01fc-440f-8ee4-5c8167c36cff_image_2024-12-05_17-55-40.png	additional
c68bdd59-4ef8-4ca3-9ce5-2a196d726990	c68bdd59-4ef8-4ca3-9ce5-2a196d726990_835330255.jpg	additional
7dd11b24-c7c5-4cc1-81d3-3c64ae405c2c	7dd11b24-c7c5-4cc1-81d3-3c64ae405c2c_ins.png	main
21449789-7a3a-4d2f-bf50-d3d5b8ad5b91	21449789-7a3a-4d2f-bf50-d3d5b8ad5b91_ser.png	additional
613cb110-068a-4c4d-abb3-7a5463ff9015	613cb110-068a-4c4d-abb3-7a5463ff9015_logo.png	additional
3d786312-b4f7-44c8-99e0-0f0a2a1a3483	3d786312-b4f7-44c8-99e0-0f0a2a1a3483_ser1.png	additional
d2f80f9a-8807-4a20-b00d-b4046e3f344a	d2f80f9a-8807-4a20-b00d-b4046e3f344a_library2.jpg	main
ad471c61-c8ea-4f01-ada2-a3ee3347e087	ad471c61-c8ea-4f01-ada2-a3ee3347e087_library1.jpg	additional
fc4499f3-2b25-431f-9163-f64fa397bf20	fc4499f3-2b25-431f-9163-f64fa397bf20_library3.jpg	additional
82c19a8f-38c6-4e9f-ba1a-f7b305c11339	82c19a8f-38c6-4e9f-ba1a-f7b305c11339_library3.jpg	gallery
59c54860-835e-4820-8904-6b0e96c2e30d	59c54860-835e-4820-8904-6b0e96c2e30d_library2.jpg	gallery
8c8fdc89-496d-41a1-96f5-c5dcb846d181	8c8fdc89-496d-41a1-96f5-c5dcb846d181_image_2024-12-05_17-55-40.png	gallery
cc90c4af-0582-4bda-867a-7cc9a691bf41	cc90c4af-0582-4bda-867a-7cc9a691bf41_Screenshot 2025-03-28 at 12.01.06.png	gallery
61f9c744-40bc-4517-b29a-f1c1a5ef92d9	61f9c744-40bc-4517-b29a-f1c1a5ef92d9_Screenshot 2025-03-28 at 12.00.10.png	gallery
\.


--
-- Data for Name: certificate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.certificate (id, abuturient_id, attachment_id) FROM stdin;
\.


--
-- Data for Name: command; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.command (ball, command_staff_id, id, message_send, number, staff_id, status, created_at, response_time, time_limit, file_id, response_file_id, description, response_description, response_text, text) FROM stdin;
0	1	8	f	8	170	2	2025-02-22 14:57:38.079794	\N	2025-02-26 17:25:00	190b9224-e453-4625-abc5-e875334eec46	\N	200hdfgh	\N	\N	hgdh
0	1	10	f	10	170	2	2025-02-22 15:06:26.51188	\N	2025-02-28 15:06:00	5f20ae28-796d-4f0a-ae39-2a4846abb329	\N	dfvsdfv	\N	\N	vsdfvsdv
0	2	12	f	12	1	1	2025-02-24 10:08:25.451256	\N	2025-02-25 11:08:16	\N	\N	cfefrcerf	\N	\N	Ferv
0	1	15	f	15	2	2	2025-02-26 17:30:37.030615	\N	2025-02-28 18:30:22	36481356-f84e-4274-bb65-63ab60d106de	\N	njkn	\N	\N	Kink
0	1	3	f	3	2	4	2025-02-22 13:59:44.612455	2025-02-26 17:31:27.519489	2025-02-25 13:59:00	b071cd09-8832-47e3-ba36-634fea70debe	3f42aac0-9837-4be4-8bf3-46c3bbe29bd1	rdedr	\N	jhbjhbhjb	der
0	1	4	f	4	2	4	2025-02-22 14:08:38.790361	2025-02-26 06:04:03.8921	2025-02-26 14:08:00	f04e2ee8-92e5-45be-9056-0749ba7db314	\N	adjkandjkad	\N	hv	sdakdnad
0	155	17	f	17	1	1	2025-03-05 09:42:17.404674	\N	2025-03-06 10:42:05	749a89b7-dfd3-47de-9709-a31ceb7fa8e6	\N	sdcsdc	\N	\N	Top shirt
0	1	7	f	7	2	3	2025-02-22 14:57:38.073926	2025-03-05 10:26:47.692566	2025-02-26 17:25:00	190b9224-e453-4625-abc5-e875334eec46	\N	200hdfgh	\N	Jhbjhbj	hgdh
0	1	1	f	1	2	3	2025-02-22 13:44:47.561042	2025-03-05 10:27:41.163565	2025-02-26 13:44:00	8db35b57-822b-47d4-8ffe-aa418d1342c2	688d9c9e-c36b-47e7-a1e3-9d330b6321a5	f3r4r4f	\N	Jkjknkjnkjn	rfr43f
0	2	18	f	18	1	1	2025-03-05 10:28:05.226267	\N	2025-03-06 11:27:57	b8180bb8-ab73-4a39-a2bd-0cd359836c26	\N	John	\N	\N	Kin
0	1	2	f	2	2	2	2025-02-22 13:59:20.549455	\N	2025-02-25 13:58:00	9f1f8e25-71ab-42ce-a104-3aba01003160	\N	der	\N	\N	ederd
0	1	6	f	6	2	3	2025-02-22 14:30:31.126683	2025-02-26 06:03:56.631244	2025-02-28 14:30:00	43953378-70a8-4133-9ced-5cc45634d532	\N	lbbjhqbdq	\N	h	dbqweb
0	1	5	f	5	2	3	2025-02-22 14:18:53.991838	2025-02-26 06:04:09.492886	2025-02-25 14:18:00	ae598dfb-9e28-436f-9bbb-ee62bbf6eae2	\N	ajdasdjad	\N	v	dbasjdb ad
0	1	11	f	11	2	4	2025-02-22 15:06:52.384165	2025-02-25 16:31:05.465142	2025-02-26 15:06:00	319bc4ad-decc-4454-900e-da1286d61cc4	\N	sdfvsdv	\N	Dwedqwedw	fvsdfv
0	1	9	f	9	2	4	2025-02-22 15:06:26.505207	2025-02-25 17:09:42.502234	2025-02-28 15:06:00	5f20ae28-796d-4f0a-ae39-2a4846abb329	1747068b-0da0-4fe7-ae38-e1eb0666f495	dfvsdfv	\N	efrwerfw	vsdfvsdv
0	2	13	f	13	1	1	2025-02-26 17:25:11.720534	\N	2025-03-01 18:24:58	30e02fc4-799c-48eb-8337-664a0811f34d	\N	regrerg	\N	\N	Ergeger
0	1	14	f	14	1	1	2025-02-26 17:30:37.028415	\N	2025-02-28 18:30:22	36481356-f84e-4274-bb65-63ab60d106de	\N	njkn	\N	\N	Kink
0	1	16	f	16	170	1	2025-02-26 17:30:37.031805	\N	2025-02-28 18:30:22	36481356-f84e-4274-bb65-63ab60d106de	\N	njkn	\N	\N	Kink
\.


--
-- Data for Name: command_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.command_message (command_id, history_id, id, status, status_command, created_at, file_id, message) FROM stdin;
1	14	1	1	3	2025-02-25 16:27:09.054334	\N	dfwqf
3	15	2	1	3	2025-02-25 16:27:18.577326	\N	fwerfwerf
7	35	3	1	3	2025-02-26 06:15:11.435049	\N	Wedwed
7	40	4	1	3	2025-02-26 17:32:33.531548	\N	 n mkjnkjn
\.


--
-- Data for Name: command_rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.command_rating (command_id, id, rating) FROM stdin;
11	1	5
9	2	5
3	3	5
4	4	5
\.


--
-- Data for Name: commander; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commander (id, rank_id, created_at) FROM stdin;
1	1	2025-02-22 12:09:46.87305
2	2	2025-02-22 12:09:46.881554
3	3	2025-02-22 12:09:46.887356
4	4	2025-02-22 12:09:46.893692
5	13	2025-02-22 12:09:46.89862
6	10	2025-02-22 12:09:46.90105
7	11	2025-02-22 12:09:46.904187
8	14	2025-02-22 12:09:46.907127
9	16	2025-02-22 12:09:46.910294
10	18	2025-02-22 12:09:46.913507
11	31	2025-02-22 14:49:49.011546
\.


--
-- Data for Name: commander_ranks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commander_ranks (commander_id, ranks_id) FROM stdin;
2	3
2	4
2	5
2	6
2	7
2	8
2	9
2	10
2	11
2	12
2	13
2	14
2	15
2	16
2	17
2	18
2	19
3	4
3	5
3	6
3	7
3	8
3	9
3	10
3	11
3	12
3	13
3	14
3	15
3	16
3	17
3	18
3	19
3	20
3	21
3	22
3	23
3	24
3	25
3	26
3	27
3	28
3	29
3	30
4	10
4	11
4	13
4	14
4	15
4	16
4	17
4	18
4	19
4	20
4	21
4	22
4	23
4	24
4	25
4	26
4	27
4	28
4	29
4	30
5	14
5	15
5	16
5	17
5	18
5	19
5	23
5	24
5	25
5	26
6	14
6	15
6	16
6	17
6	18
6	19
6	27
6	28
6	29
6	30
7	14
7	15
7	16
7	17
7	18
7	19
7	21
7	22
8	15
8	21
8	22
8	23
8	24
8	25
8	26
8	27
8	28
8	29
8	30
9	17
9	21
9	22
9	23
9	24
9	25
9	26
9	27
9	28
9	29
9	30
10	19
10	21
10	22
10	23
10	24
10	25
10	26
10	27
10	28
10	29
10	30
1	2
1	3
1	4
1	5
1	6
1	7
1	8
1	9
1	10
1	11
1	12
1	13
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	23
1	24
1	25
1	26
1	27
1	28
1	29
1	30
1	31
11	2
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (id, region_id, vacancy, vacancy_name_id, email, login, name, owner, password, support_phone) FROM stdin;
\.


--
-- Data for Name: daily_control; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.daily_control (id, created_at, description, name) FROM stdin;
4	\N	Taʼlim yunalishlaridagi fanlar va semestrlar buyicha	Qarzdorliklarrr
5	2025-04-02 10:10:38.770303	ergrg	yang
\.


--
-- Data for Name: daily_control_sub_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.daily_control_sub_folder (id, created_at, description, name, daily_control_id, staff_id) FROM stdin;
10	\N	Kunduzgi taʼlim yo'nalishlaridagi fanlar va semestrlar bo'yicha	Kunduzgoo	\N	\N
11	\N	Sirtqi taʼlim yunalishlaridagi fanlar va semestrlar buyicha	Sirtqiii	\N	\N
12	\N	Magistratura taʼlim yo'nalishlaridagi fanlar va semestrlar bo'yicha	Magistratura	4	170
14	2025-04-02 10:10:46.191551		3rfr	5	170
15	2025-04-02 10:30:46.325593	verve	fevrfv	5	170
16	\N	qisqacha izou	Baklava	4	170
\.


--
-- Data for Name: daily_control_sub_folder_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.daily_control_sub_folder_content (id, created_at, description, link_to_file, name, attachment_id, daily_control_sub_folder_id, staff_id) FROM stdin;
1	2025-04-02 16:58:04.952902	few	https://chatgpt.com/c/67ed1d0f-82ac-800d-b7c6-383972798fea	wet	\N	14	170
2	2025-04-02 17:03:12.100224	dfgdfg	https://chatgpt.com/c/67ed1d0f-82ac-800d-b7c6-383972798fea	dfgdfg	\N	14	170
3	2025-04-02 17:05:56.082932	qwejfqwef	https://qabul-new.buxpxti.uz/9488	qwefjqwjef	\N	14	170
4	2025-04-02 17:55:53.834168	asdcnjaksndc	https://meet.google.com/bon-fkeg-jei	jhdscbjashd	\N	16	170
\.


--
-- Data for Name: duty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.duty (id, rank_id, staff_id, created_at) FROM stdin;
2	2	2	2025-02-22 13:42:09.026467
4	1	1	2025-02-22 14:18:25.61865
5	4	1	2025-02-22 14:18:25.624104
6	31	170	2025-02-22 14:50:09.944795
7	2	155	2025-03-05 09:37:44.179884
\.


--
-- Data for Name: education_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_field (education_duration, education_form_id, id, ijodiy, is_active, test_education_field_id, created_at, name, price) FROM stdin;
4	1	1	f	t	\N	2025-02-10 09:44:42.800016	60310300 - Psixologiya	15000000
4	1	2	f	t	\N	2025-02-10 09:44:42.800599	60110900 - Xorijiy til va adabiyoti (tillar bo'yicha)	15000000
4	1	3	f	t	\N	2025-02-10 09:44:42.801072	60112600 - Maktabgacha va boshlangich talimda xorijiy til)	15000000
4	1	4	f	t	\N	2025-02-10 09:44:42.801563	60410100 - Iqtisodiyot	15000000
4	1	5	f	t	\N	2025-02-10 09:44:42.802052	60110700 - Uzbek tili va adabiyoti	15000000
4	1	6	f	t	\N	2025-02-10 09:44:42.802993	60220300 - Tarix	15000000
4	1	9	f	t	\N	2025-02-10 09:44:42.804387	60110400 - Boshlangich talim	15000000
3	1	10	f	t	\N	2025-02-10 09:44:42.804935	60111200 - Jismoniy madaniyat	15000000
4	1	12	f	t	\N	2025-02-10 09:44:42.805865	60610100 - Axborot tizimlari va texnologiyalari	15000000
4	1	13	f	t	\N	2025-02-10 09:44:42.806358	61010100 - Turizm va mehmondo'stlik	15000000
4	1	14	f	t	\N	2025-02-10 09:44:42.806748	60110300 - Maxsus pedagogika (Logopediya)	15000000
4	1	15	f	t	\N	2025-02-10 09:44:42.807145	60310903 - Amaliy psixologiya	15000000
4	1	16	f	t	\N	2025-02-10 09:44:42.807602	61010400 - Logistika	15000000
4	1	17	f	t	\N	2025-02-10 09:44:42.808054	60540100 - Matematika	15000000
4	1	18	f	t	\N	2025-02-10 09:44:42.808473	60110800 - Ona tili va adabiyoti (Rus tili)	15000000
5	2	19	f	t	\N	2025-02-10 09:44:42.80894	60310300 - Psixologiya	12000000
5	2	20	f	t	\N	2025-02-10 09:44:42.80934	60110200 - Maktabgacha talim	12000000
5	2	21	f	t	\N	2025-02-10 09:44:42.809807	60410100 - Iqtisodiyot	12000000
5	2	22	f	t	\N	2025-02-10 09:44:42.810252	60220300 - Tarix	12000000
5	2	23	f	t	\N	2025-02-10 09:44:42.810707	60110400 - Boshlangich talim	12000000
5	2	25	f	t	\N	2025-02-10 09:44:42.811587	60111200 - Jismoniy madaniyat	12000000
5	2	26	f	t	\N	2025-02-10 09:44:42.812075	60111100 - Milly g'oya, ma'naviyat asoslari va huquq ta'limi	12000000
5	2	27	f	t	\N	2025-02-10 09:44:42.812804	60610100 - Axborot tizimlari va texnologiyalari	12000000
5	2	28	f	t	\N	2025-02-10 09:44:42.813307	61010100 - Turizm va mehmondo'stlik	12000000
5	2	29	f	t	\N	2025-02-10 09:44:42.813688	60111400 - Uzbek tili va adabiyoti	12000000
5	2	30	f	t	\N	2025-02-10 09:44:42.814022	60310903-  Amaliy psixologiya	12000000
5	2	31	f	t	\N	2025-02-10 09:44:42.814407	61010400 - Logistika	12000000
5	4	32	f	t	\N	2025-02-10 09:44:42.814846	60110400 - Boshlangich talim	12000000
5	4	33	t	t	\N	2025-02-10 09:44:42.815255	60110600 - Musiqa talimi	12000000
5	4	34	f	t	\N	2025-02-10 09:44:42.815597	60110700 - Uzbek tili va adabiyoti	12000000
5	4	35	f	t	\N	2025-02-10 09:44:42.816028	60111200 - Jismoniy madaniyat	12000000
5	4	36	f	t	\N	2025-02-10 09:44:42.816418	60110300 - Maxsus pedagogika (Logopediya)	12000000
4	4	37	f	t	\N	2025-02-10 09:44:42.816799	60110900 - Xorijiy til va adabiyoti (tillar bo'yicha)	12000000
4	3	38	f	t	\N	2025-02-10 09:44:42.817182	60310300 - Psixologiya	10000000
4	3	39	f	t	\N	2025-02-10 09:44:42.817541	60410100 - Iqtisodiyot	10000000
4	3	40	f	t	\N	2025-02-10 09:44:42.818035	60110700 - Uzbek tili va adabiyoti	10000000
3	3	41	f	t	\N	2025-02-10 09:44:42.81866	60110200 - Maktabgacha talim	10000000
5	3	42	f	t	\N	2025-02-10 09:44:42.819067	60110400 - Boshlangich talim	10000000
4	3	44	f	t	\N	2025-02-10 09:44:42.820058	61010400 - Logistika	10000000
4	3	45	f	t	\N	2025-02-10 09:44:42.820423	60540100 - Matematika	10000000
4	3	46	f	t	\N	2025-02-10 09:44:42.820846	60110800 - Ona tili va adabiyoti (Rus tili)	10000000
2	5	47	f	t	\N	2025-02-10 09:44:42.821262	70310301 - Psixologiya	18000000
2	5	48	f	t	\N	2025-02-10 09:44:42.821721	70410102 - Iqtisodiyot	18000000
2	5	49	f	t	\N	2025-02-10 09:44:42.82206	70110401 - Ta'lim va tarbiya nazariyasi va metodikasi (boshlang'ich ta'lim)	18000000
2	5	50	t	t	\N	2025-02-10 09:44:42.822472	70110601 - Musiqa ta'limi va san'at	18000000
2	5	51	f	t	\N	2025-02-10 09:44:42.822922	70111201 - Jismoniy tarbiya va sport mashg'ulotlari nazariyasi va metodikasi	18000000
2	5	52	f	t	\N	2025-02-10 09:44:42.823295	70110101 - Pedagogika nazariyasi va tarixi	18000000
2	5	53	f	t	\N	2025-02-10 09:44:42.823642	70110701 - O'zbek tili va adabiyoti	18000000
2	5	54	f	t	\N	2025-02-10 09:44:42.824056	70230101 - Lingvistika (tillar bo'yicha)	18000000
4	3	43	f	t	1	2025-02-10 09:44:42.819625	60111100 - Milly g'oya, ma'naviyat asoslari va huquq ta'limi	10000000
4	1	11	f	t	2	2025-02-10 09:44:42.805438	60111100 - Milly g'oya, ma'naviyat asoslari va huquq ta'limi	15000000
3	1	8	f	t	3	2025-02-10 09:44:42.80393	60110200 - Maktabgacha talim	15000000
3	1	7	t	t	4	2025-02-10 09:44:42.803514	60110600 - Musiqa talimi	15000000
5	2	24	t	t	5	2025-02-10 09:44:42.811107	60110600 - Musiqa talimi	12000000
\.


--
-- Data for Name: education_form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_form (education_type_id, id, is_active, created_at, name) FROM stdin;
1	1	t	2025-02-10 09:44:42.789704	Kunduzgi
1	2	t	2025-02-10 09:44:42.790242	Sirtqi
1	3	t	2025-02-10 09:44:42.790677	Masofaviy
1	4	t	2025-02-10 09:44:42.791319	Kechgi
2	5	t	2025-02-10 09:44:42.7918	Kunduzgi
\.


--
-- Data for Name: education_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_type (id, is_active, created_at, name) FROM stdin;
1	t	2025-02-10 09:44:42.782376	Bakalavr
2	t	2025-02-10 09:44:42.782389	Magistr
\.


--
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty (id, title) FROM stdin;
1	Psixologiya kafedrasi
2	Filologiya kafedrasi
3	Pedagogika va umumiy fanlar kafedrasi
\.


--
-- Data for Name: gallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gallery (id, created_at, main_photo_id) FROM stdin;
1	2025-04-03 14:18:42.059455	82c19a8f-38c6-4e9f-ba1a-f7b305c11339
2	2025-04-03 14:18:47.35148	59c54860-835e-4820-8904-6b0e96c2e30d
3	2025-04-03 14:18:56.935528	8c8fdc89-496d-41a1-96f5-c5dcb846d181
4	2025-04-03 14:19:06.699054	cc90c4af-0582-4bda-867a-7cc9a691bf41
5	2025-04-03 14:19:24.763974	61f9c744-40bc-4517-b29a-f1c1a5ef92d9
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.history (command_id, from_status, id, to_status, created_at) FROM stdin;
1	1	1	2	2025-02-22 13:51:27.739451
8	1	2	2	2025-02-22 15:08:27.331738
10	1	3	2	2025-02-22 15:08:27.343316
2	1	4	2	2025-02-25 15:53:36.075402
3	1	5	2	2025-02-25 15:53:36.10928
4	1	6	2	2025-02-25 15:53:36.111376
5	1	7	2	2025-02-25 15:53:36.112989
6	1	8	2	2025-02-25 15:53:36.114341
7	1	9	2	2025-02-25 15:53:36.116222
9	1	10	2	2025-02-25 15:53:36.117803
11	1	11	2	2025-02-25 15:53:36.11942
1	2	12	3	2025-02-25 15:55:29.046374
3	2	13	3	2025-02-25 15:55:36.70455
1	3	14	1	2025-02-25 16:27:09.043646
3	3	15	1	2025-02-25 16:27:18.574133
1	1	16	2	2025-02-25 16:28:33.397942
3	1	17	2	2025-02-25 16:28:33.400624
9	1	18	2	2025-02-25 16:30:59.293752
11	1	19	2	2025-02-25 16:30:59.297866
7	1	20	2	2025-02-25 16:30:59.300039
6	1	21	2	2025-02-25 16:30:59.303102
4	1	22	2	2025-02-25 16:30:59.305509
5	1	23	2	2025-02-25 16:30:59.307419
3	1	24	2	2025-02-25 16:30:59.309752
1	1	25	2	2025-02-25 16:30:59.313617
2	1	26	2	2025-02-25 16:30:59.315547
11	2	27	3	2025-02-25 16:31:05.465431
9	2	28	3	2025-02-25 17:09:42.502623
7	2	29	3	2025-02-26 06:03:50.061666
6	2	30	3	2025-02-26 06:03:56.631522
4	2	31	3	2025-02-26 06:04:03.892573
5	2	32	3	2025-02-26 06:04:09.493291
11	3	33	4	2025-02-26 06:14:19.135676
9	3	34	4	2025-02-26 06:15:04.329334
7	3	35	1	2025-02-26 06:15:11.432429
7	1	36	2	2025-02-26 17:31:02.77701
15	1	37	2	2025-02-26 17:31:02.782644
7	2	38	3	2025-02-26 17:31:07.50274
3	2	39	3	2025-02-26 17:31:27.519667
7	3	40	1	2025-02-26 17:32:33.527655
3	3	41	4	2025-02-26 17:33:16.945527
4	3	42	4	2025-02-26 17:33:20.61999
7	1	43	2	2025-03-05 10:26:25.674307
7	2	44	3	2025-03-05 10:26:47.692806
1	2	45	3	2025-03-05 10:27:41.163741
\.


--
-- Data for Name: kitoblar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kitoblar (id, created_at, main_photo_id, description, title) FROM stdin;
\.


--
-- Data for Name: kitoblar_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kitoblar_photos (book_id, photos_id) FROM stdin;
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.language (id, is_active, created_at, name) FROM stdin;
1	t	2025-02-10 09:44:42.776065	O'zbek
2	t	2025-02-10 09:44:42.77608	RUS
\.


--
-- Data for Name: memorandum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.memorandum (id, created_at, main_photo_id, description, title) FROM stdin;
\.


--
-- Data for Name: memorandum_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.memorandum_photos (memorandum_id, photos_id) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, date, message, name, phone) FROM stdin;
\.


--
-- Data for Name: my_test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.my_test (id, test_subject_id, answer, question, wrong_answer1, wrong_answer2, wrong_answer3) FROM stdin;
1	2	 Mezolit davri oxirida	Qaysi davrda Old Osiyoda xo‘jalikning yangi tarmoqlari - ibtidoiy ziroatchilik va chorvachilik vujudga keldi?	 Mezolit davri boshida  	 Neolit davri oxirida	 Neolit davri boshida    
2	2	 Temir davri boshida	Qachon O‘rta Osiyo aholisi to‘rt guruhga bo‘linadi?	 Bronza davri oxirida	 Temir davri oxirida	 Temir davri o‘rtalarida
3	2	 Mil. avv. IX -VIII asrlar 	O‘rta Osiyodan topilgan ilk temirdan yasalgan buyumlar nechanchi asrlarga oid?	 Mil. avv. VIII-VII asrlar	 Mil. avv. VI-V asrlar	 Mil. avv. VII-VI asrlar    
4	2	 Mil. avv. VII asrlarda    	Qadimgi Baqtriya davlati qachon tashkil topgan? 	 Mil. avv. VIII asrlarda	 Mil. avv. VI asrlarda	 Mil. avv. IX asrlarda     
5	2	 Qashqadaryo	Yerqo'rg'on va Uzunqir shaharlari qaysi viloyatda joylashgan? 	 Surxandaryo  	 Samarqand                 	 Xorazm                              
6	2	 Anaxita      	Zardushtiylik dinida hosildorlik va suv ilohasi? 	 Mitra                  	 Ahriman	 Ahuramazda    
7	2	 Mil. avv. III asr	Zardusht va'zlari matnlarining hammasi qachon 21 kitobga jamlangan?  	 Mil. avv. IV asr     	 Mil. avv. IX-VIII asrlarda    	 Mil. avv. II asr     
8	2	 dehqon           	Ilk o`rta asrlarda mulkdor tabaqani anglatuvchi atama berilgan javobni toping.	 kadivar  	 koshavarz       	 chokar
9	2	 shod 	Turk xоqоnligida o`n ming qo`shin qo`mоndоni qanday atalgan?	 jabg`u  	 tumanboshi	 yabg`u  
10	2	 Farg`ona	Quyidagi mahalliy hokimliklardan qaysi biri qo`shni mamlakatlarga bo‘yoq, rangli shisha buyumlar va dori-darmonlar chiqargan?	 Ixshid 	 Samarqand   	 Toxariston    
11	2	 buddaviylik	O`rta Оsiyoda haykaltarоshlik rivоjiga qaysi din kuchli ta`sir ko`rsatgan?	 qam(shomonlik) 	 moniylik        	 zardushtiylik  
12	2	 g`oziy  	Haq din uchun kurashuvchi jangchi ma`nosini anglatuvchi atamani aniqlang 	 najjor  	 saffoh	 saffor  
13	2	 XI asrda	Qachondan boshlab yerdan foydalanishda iqto tartiboti juda keng yoyiladi? 	 IX asrda	 XII asrda	 X asrda
14	2	 Qutbiddin Muhammad   	Kimning davrida «Xorazmshoh» unvonini qayta tiklangan? 	 Anushtegin   	 Elarslon	 Otsiz             
15	2	 «Ravzat us-safo	Quyidagi asarlardan Mirxond qalamiga mansub asarni aniqlang. 	 «al-Komil¬fit-tarix» («Tarix haqida mukammal kitob»)	 «Siyrat as¬sulton Jalol ad¬Din Mengburni»	 «Tarixi jahonkushoy» («Jahon fotihi tarixi»)
16	2	 Ibn Xaldun 	Kimning ta`kidlashicha Amir Temur turk, arab, fors xalqlari tarixini chuqur o`rgangan, diniy, dunyoviy va falsafiy bilimlarning eng murak kab jihatlarigacha yaxshi o`zlashtira olgan zot ekan?	 Ibn  Arabshoh  	 An-Nasaviy	 Ishtaxriy            
17	2	 Ahmad al-Farg`oniy    	«Samoviy harakatlar va umumiy ilmi nujum»asarining muallifi berilgan javobni aniqlang .	 Al-Xorazmiy           	 Al-Buxoriy	 Abu Nasr Farobiy    
18	2	 Abulxayrxon        	1451-yilda katta qo`shin bilan Abu Said yordami va ishtirokida Toshkent, Chinoz va Jizzax orqali Samarqandga Mirzo Abdulloga qarshi yurish qilgan shaxsni aniqlang	 Ubaydullaxon 	 Shohbudoq	 Shayboniyxon      
19	2	 Abu Nasr Farobiy     	«Fozil odamlar shahri» asarining muallifini aniqlang.        	 Abu Rayhon Beruniy	 Abu Ali ibn Sino 	 Muhammad ibn Muso al-Xorazmiy    
20	2	 1533-1536-yillarda	Qaysi yillarda Ubaydullaxon Mir Arabga bag'ishlab Buxoroda uning nomi bilan mashhur madrasa qurdirgan? 	 1536-1539-yillarda	 1530-1536-yillarda    	 1533-1539-yillarda     
21	2	 Andijon va Axsi    	Bobur Mirzoning yoshlik yillari qaysi shaharlarda o`tgan. ?	 Axsi va Namangan  	 Andijon va Samarqand	 O`sh va Toshkent  
22	2	 Anushaxon   	Buxoro xonligida ashtarxoniy Subxonqulixon hukmronligi davrida qaysi Xiva xoniga Samarqandda xutba o`qilib, uning nomidan tanga pullar zarb etildi? 	 Elabrsxon                        	 Abulg`oziyxon	 Muhammad Aminxon     
23	2	 Badaxshonot va Kobulga	Og‘ir va nochor ahvolga tushib qolgan Bobur Mirzo Samarqandni tark etib, ko‘p mashaqqatlarni boshdan kechirib, o‘zga yurtlarga ketishga majbur bo‘ldi. Bobur Mirzoning qizi Gulbadanbegim o‘zining ,,Humoyunnoma“ asarida bu haqda quyidagilarni yozgan edi: „Xudoga tavakkal qilib ….  va …. yuzlandilar“. 	 Badaxshonot va Andijonga	 Balx va Hirotga       	 Buxorova Kobulga    
24	2	 Ubaydullaxon II    	Quyidagi qaysi hukmdor yirik yer egalari hamda Jo‘ybor shayxlarining soliq to‘lamaslik imtiyozidan mahrum etdi?	 Abulfayzxon  	 Nodir Muhammad	 Subhonqulixon      
25	2	 dodxoh 	Buxoro xonligida Shayboniylar sulolasi humkronligi  davrida mamlakatda adolat mezonlariga amal qilinishini quyidagi qaysi lavozim egasi nazorat qilgan? 	 otaliq   	 ko`kaldosh	 parvonachi          
26	2	 suyurg’ol	Yer egaligining qaysi shakli dastlab xonga uning egalarini itoatda tutib turishning kuchli vositasi bo'lib xizmat qildi? 	 tanho	 mulk	 mamlakai sulton
27	2	 Pyotr I	Buxoroni siyosiy jihatdan Rossiyaga teng emas, deb unga tazyiq o’tkaza boshlagan Rossiya hukmdorini aniqlang. 	 Aleksandr I	 Nikolay II	 Mixail Romanov
28	2	 Chanoh	Shayboniylar davrida  ... qo‘shinning o‘ng va chap qanotlarini qo‘riqlovchi maxsus qism edi.    	 Katta va kichik g'ullar  	 hirovul	 Sarkarda   
29	2	 Bedil   	«To`rt unsur» asari muallifni aniqlang ? 	 Sayido Nasafiy      	 Abdurhmon Tole	 Turdi Farog`iy       
30	2	 1821-yil 	Qachon Miyonqolda Buxoro amirligiga qarshi qo`zg`alon bo`lib o`tdi?  	 1819-yil 	 1826-yil	 1824-yil 
31	2	 Marza                 	Buxoro amirligida 300 tanob va undan kam yeri bo‘lgan hudud, aholi yashasa-yashamasa, qanday atalardi?          	 Qoriya	 Hazora	 Qishloq obikori   
32	2	 Bosh inoq    	Qaysi lavozimga tayinlangan amaldor amirning buyruqlarini quyi lavozimda ishlayotgan davlat xizmatchilariga yetkazish, mazkur buyruqlarning bajarilishini va kelgusida davlat mansablariga tayinlanishi mumkin bo'lgan xizmatchilarning faoliyatini tashkil etish bilan shug‘ullangan?	 Mehtar	 Kichik inoq	 to'qsoba       
33	2	 Qo’sh puli	Uning miqdori yer haydashga yaroqli har juft ho`kiz hisobidan kelib chiqib belgilangan. Gap qaysi soliq haqida ketmoqda? 	 Tanobona   	 Tutun haqi	 Zakot            
34	2	 Shug'ovul	Buxoro amirligida qaysi lavozimdagi kishi chet mamlakatlar elchilarining qabul qilinishini tashkil etuvchi hisoblangan? 	 Qutvol	 Mehtar      	 Ko'kaldosh   
35	2	 To’pchiboshi   	Amir davlat boshlig‘i sifatida amirlik qo‘shinining oliy bosh qo'mondoni edi. Undan keyingi o‘rinda vaziri harb (harbiy vazir) turgan. U qo‘shinning Bosh qo‘mondoni sanalgan va yana qanday nom bilan atalgan? 	 To’pchilashkar	 Mingboshi	 Amirlashkar    
36	2	 Mirzo Shams Buxoriy     	«Bayoni ba`zi havodisoti Buxoro, Ho`qand va Qoshg`ar» asari muallifini aniqlang ?	 Muhammad Hakimxon   	 Mahmud  At-Tabariy	 Mir Olim Buxoriy   
158	5	   How  many                    	____languages  do  you  know?	  How  much	  Where	  Whose
37	2	 Alouddin Otamalik Juvayniy            	“Tarixi Jahonkushoy” asari kimga tegishli? 	 Abu rayhon Beruniy   	 Mahmud  At-Tabariy	 Muallifi nomalum
38	2	 Niyozbek   	Quyidagi qaysi qo’rg’on Toshkent darvozasi deb nom olgan? 	 Turkiston     	 Chimkent	 Oqmachit   
39	2	 1847-1865-yillar   	Rossiya tomonidan O’rta Osiyoning bosib olinishining I-bosqichi qachon bo’lib o’tdi?	 1865-1868-yillar   	 1880-1885-yillar	 1873-1879-yillar   
40	2	 Turdi Ali              	Qo’qon xonilidagi eng mashhur xattot kim edi? 	 Shirin Murodov	 Mirzo Mahmud	 Nurmuhammad    
41	2	 A.Fitrat     	“Tarix millatning o’tmishi taraqqiyoti hamda tanazzuli sabablarini o’rganaturg’on ilmdir” ushbu so’zlar muallifini aniqlang? 	 M.Behbudiy	 Q.Niyoziy	 M.Qori
42	2	 1917-yil 7-aprelda / 9-kishi       	Turkiston o’lkasini boshqarish uchun Komitet qachon tuzildi va uning tarkibi necha kishidan iborat edi? 	 1918-yil 7-aprelda / 8-kishi	 1919-yil 27-aprelda / 9-kishi	 1917-yil 17-aprelda / 9-kishi     
43	2	 Islom Sulton Shoahmedov  	Turkiston Muxtoriyatining bosh vazir o’rinbosari etib kim tayinlanganligini aniqlang?	 Hidoyatbek Yurug’li Agayev	 Abdurahmon O’razayev	 Solomon Gersfeld  
44	2	 Bobooxun Salimov	1917-yil 8-aprelda mamlakatni boshqarish uchun Xivada xon huzurida kim boshchilikida Majlis tashkil etiladi?   	 Husaynbek devonbegi Matmurodov	 Mirbadalov	 Polvonniyoz Yusupov
45	2	 Buxoro, Karmana va Nurota	Mulla Abdulqahhor rahbarligida qaysi viloyatlarda o‘nlab qo‘rboshi guruhlari faoliyat  ko‘rsatdi ?	 Samarqand, Xiva va Karmana	 Buxoro va Nurota	 Buxoro, Xiva va Karmana
46	2	 1990-yil 20-iyun	... kuni O‘zbekiston SSR Oliy Kengashining II sessiyasida O‘zbekiston SSRning Mustaqillik Deklaratsiyasi qabul qilindi. 	 1991-yil 20-mart	 1991-yil 13-iyun	 1990-yil 23-aprel
47	2	 Abdulhoshim Mutalov	O‘zbekistonda Bosh vazir lavozimida 1992–1995-yillarda kim faoliyat ko’rsatgan?	 Oʻtkir Sultonov  	 Shavkat Mirziyoyev	 Shukrullo Mirsaidov 
48	2	 1992-yil	..…da O‘zbekiston Respublikasi Prezidentining farmoni bilan Milliy xavfsizlik xizmati tasarruf da Chegara qo‘shinlari boshqarmasi tashkil etildi.	 1993-yil 	 1991-yil	 1994-yil 
49	2	 25 yosh  	Necha yoshga to’lgan fuqarolar Oliy Majlisga saylanishi mumkin?	 35 yosh	 18 yosh	 21 yosh
50	2	 101-moddasida	O’zbekiston Konstitutsiyasining nechanchi moddasida hokimlar vakolati haqida ma’lumot berilgan?	 100-moddasida	 103-moddasida	105-moddasida
51	2	Avesto	O’rta  Osiyo tarixiga oid eng muhim manba qaysi?                                                                          	Rigveda 	Marhumlar kitobi	Bibilya
52	2	1,2,3   	Behistun yozuvlarida Orta Osiyodagi qaysi davlatlar sanab o’tilgan haqida yozilgan ? 1.Xorazm      2.Baqtriya    3.So’g’d    4.Qang’                       	2,3,4    	1,3,4  	2.4
53	2	2014-yilning 15–16-may kunlari Samarqandda	Buyuk   alloma   va   mutafakkirlarning   ilmiy   merosi   va uning zamonaviy sivilizatsiya tarixida tutgan o‘rni va roliga bag‘ishlanib  qachon  va  qayerda xalqaro konferensiya o‘tkazildi?                                              	2013-yilning 15–16-may kunlari Toshkentda   	2015-yilning           15–16-may kunlari Buxoroda 	2016-yilning 15–16-may kunlari Xivada                                                                                      
54	2	O’zlashtiruvchi xo’jalik   	Qadimgi odamlarning dastlabki mashg’ulotlari bo’lgan termachilik va ovchilik   nima deb atalgan ?                                                                                                                                          	Mehnat  xo’jaligi                                                                           	Dehqon xo’jaligi                           	Mehnat  jamoasi 
55	2	tosh asriga mansub 8-9 yashar bolaning suyak qoldiqlari	Teshiktosh g’oridan qazib olingan eng mashxur topilma nima ? 	hayvon va qush suyaklari    	tosh qurollar               	gulxan qoldiqlar
56	2	Zarafshon	Dehqonlarning qadimgi manzilgohlaridan biri bo’lgan Zamonbobo ko’li yaqinidan topilgan qadimiy manzilgoh qaysi daryo havzasidan topilgan?	Sirdaryo	Amudaryo	Qashqadaryo
57	2	1,3,4	Ilk o’rta asrlarda qaysi yangi tabaqalar shakllandi?                1. dehqon, 2.muzoriy, 3.kadivar, 4.kashovarz, 5.iktodor, 6.guvokor, 7.vagnpat                                                                                                                  	1,2,5   	3,4,6,7    	2,3,4,6   
58	2	552-yilda   	Bumin qachon  “xoqon” deb e’lon qilindi?                                                                                        	550-yilda	556-yilda  	563-yilda                                                                                                                                                      
59	2	paxta va sholi	Farg‘ona yerlari juda hosildor bo‘lib, aholisi dehqonchilik bilan kun kechirgan, va asosan qanday ekinlar  ekkanlar?   	sholi va bug’doy	bug’doy va arpa   	sholi va javdar         
60	2	Rabot	Shaharning tashqi mavzeyi nima deb atalgan?                                                                                 	Ko‘handiz  	Shahriston	Handaq
61	3	exinokokk, askarida 	Ayirish sistemasi bir uchi berk naychalardan iborat organizmlarni toping	midiya, bitiniya dengiz	ko`p tuklisi, nereida	omar, langust
62	3	Dumg’aza, bo’yin va ko’krak umurtqalari	Qovurg’alar soniga teng bo’lgan suyaklar berilgan qatorni aniqlang.	Bilak, tirsak, katta va kichik boldir suyaklari, soxta qovurg’alar	Dumg’aza, ko’krak umurtqalari va bilak, tirsak suyaklari.	Bo’yin, dumg’aza, bel umurtqalari va yetim qovurg’alar
63	3	O’mrov va kaftusti suyaklari	Ko’krak qafasiga mansub bo’lmagan g’ovak suyaklar keltirilgan qatorni aniqlang.	To’sh va qovurg’alar	To’sh va ko’krak umurtqalari	Ko’krak umurtqalari va qovurg’alar
64	3	Ensa va yuz suyaklari  	Bosh suyagiga mansub bo’lgan yassi suyaklar keltirilgan qatorni aniqlang.	Kurak va chakka suyaklari	Chanoq va tepa suyaklari	Yuqori jag’ va kurak suyaklari
65	3	a-ninabaliqning suv o’tiga o’xshashligi;                           b-oynasimon kapalakning ariga o’xshashligi    	Ideoadaptatsiya (a) va mimikriyaga (b) mos keluvchi javoblarni toping. 	a-dengiz masxarabozining dengiz o’simliklariga o’xshashligi; b-chupchikning qurigan somonga o’xshashligi	a-kallimaning barg naqshlariga o’xshashligi; b-qora kalamushning 38 va 42 xromosomali turlarining o’xshashligi	a-odam va shimpanze gemoglobinidagi aminokislatalarning o’xshashligi; b-xaltali krotning oddiy krotga o’xshashligi
66	3	1-karrak; 2-churrak             	Organizmlarni produtsent (1) va konsument (2) ga ajrating.	1-ayiqtovon; 2-bo’ritaroq	1-jumagul; 2-sallagul	1-gulqandala; 2-gulsafsar
67	3	1-agava; 2-agama       	Organizmlarni produtsent (1) va konsument (2) ga ajrating.	1-qichitqio’t kapalagi; 2-qoqio’t 	1-tukan; 2-itsigak	1-suqsun; 2-sarsazan
68	3	a-2; b-7        	Quyidagi organizmlar nechta sinf (a) , nechta turkum (b) ga tegishli ekanligini aniqlang.  1) temirchak; 2) podalariy;  3) chirildoq;  4) iskabtopar;   5) suluv ninachi;   6) trixogramma;  7) gabrobrakon;  8) sariq falanga; 9) biy; 10) bo’ka	a-2; b-9	a-2; b-8	a-2; b-6
69	3	sovuq kunda ishchi arilar erkaklarini quvib chiqaradi    	Asalari oilasi uchun to’g’ri berilgan javobni toping.	urug’langan tuxumlardan erkak arilar chiqadi	ularning ko’zi ultrabinafsha ranglarni yaxshi ko’rmaydi	yuqori jag’ va lab o’zgarib harakat a`zosini hosil qiladi
70	3	rus oq tovug’i, leggorn     	Tuxum yo’nalishida boqiladigan tovuqlarni aniqlang.	kornuel, plimutrok	Zagorsk, Pervomaysk	Nyugempshir, Pekin
71	3	qorin bo’limi ingichka bel	Chumoli oilasi uchun to’g’ri berilgan javobni toping. 	orqali ko’krakka qo’shiladi       	urg’ochisida nishtari bor	chala o’zgarish bilan rivojlanadi ko’zi oddiy ko’rsatadi
72	3	jamoa bo’lib yashaydi    	Termit oilasi uchun to’g’ri berilgan javobni toping.	to’liq o’zgarish bilan rivojlanadi	ko’zi oddiy ko’radi	bir nechta ona individdan iborat
73	3	tyin, nutriya       	Qoziq tishli bo’maydigan hayvonlarni ajrating.	yo’lbars, arslon	ilvirs, korsak	bo’ri, chiyabo’ri
74	3	ularning ko’zi ultrabinafsha nurlarni yaxshi ko’radi     	Asalari oilasi uchun to’g’ri berilgan javobni toping.	urug’langan tuxumlardan erkak arilar chiqadi	ishchi arilar voyaga yetgan arilar	yuqori jag’ va lab o’zgarib hartum hosil qiladi
75	3	a-gazanda;                      b-oqquray;        c-qumrio’t         	Novdada barglari qarama – qarshi (a); navbat bilan (b); halqasimon (c) joylashgan o’simliklar to’g’ri berilgan javobni toping.	a-yalpiz;         b-chinnigul;      c-qumrio’t	a-marmarak;                       b-ligustrum;                          c-qirqbo’g’im	a-dalachoy; b-atirgul;               c-kiyko’t 
76	3	a-qoqidosh;             b-ra’nodosh;                   c-burchoqdosh       	Topinambur (a); tobulg’i (b); tuxumak (c) qaysi oila vakillari hisoblanadi?	a-qoqidosh;                 b-burchoqdosh;                      c-ra’nodosh	a-qoqidosh;                       b-ra’nodosh;                       c-bug’doydosh	a-qoqidosh;                             b-gulxayridosh;                                 c-burchoqdosh
77	3	a-chumchuqsimonlar; b-g’o’zasimonlar;                                      c- kaptarsimonlar     	Churg’uchuq (a); churrak (b); musicha (c) qaysi turkum vakillari hisoblanadi?-	a-churg’uchuqsimonlar; b-g’ozasimonlar;                          c-kaptarsimonlar	a-chumchuqsimonlar; b-o’rdaksimonlar; c-kaptarsimonlar	a-chumchuqsimonlar;  b-g’ozasimonlar; c-musichasimonlar
78	3	boychechak, nargis, xolamon       	Gul formulasi Og3+3Ch3+3U(3) bo’lgan oilaga mansub o’simliklarni aniqlang.	ola , olg’i, qora jusan	tak – tak, olg’i, boychechak	karrak, boychechak, nargis
79	3	baobab, kanop, g’o’za   	Gul formulasi Gk(3)+(5)Gt5Ch(∞)U(∞) bo’lgan oilaga mansub o’simliklarni aniqlang.	tugmachagul, topinambur, go’za	baobab, bo’ymadoron, topinambur	kanop, g’oza, tuxumak
80	3	javdar, g’umay, ajriq         	Gul formulasi Og(2)+2Ch3,6U1  bo’lgan oilaga mansub o’simliklarni aniqlang.	makkajo’xori, kungaboqar,sholi 	xarduma, xolmon, oqjo’xpri	bug’doy, arpa, matur
81	3	bangidevona, baqlajon, tamaki      	Gul formulasi Gk(5)Gt(5)Ch5U1 bo’lgan oilaga mansub o’simliklarni aniqlang.	tamaki, turp, kartoshka	mingdevona, lavlagi, kartoshka 	garimdori, pomidor, bodirng
82	3	gledichiya, yasmiq            	Gul formulasi Gk(5)Gt1+2+(2)Ch(9)+1U1 bo’lgan oilaga mansub o’simliklarni aniqlang.	tugunak, tobulg’i, shinmiya	astragul, isirg’o’t, ituzum	dastargul, astargul, tangao’t
83	3	3,6,4 	Vladimir zoti uchun mos keluvchi xususiyatlarni aniqlang. 1) yengil yuk tortadigan hayvon zoti;            2) jayron bilan bir turkumga mansub;   3) faqat uchinchi barmog’i kuchli rivojlangan;   4) oshqozon bo’lmalarga bo’linmagan;    5) Afrika yovvoyi eshagidan kelib chiqqan;   6) ko’richak o’simtasi juda uzun	1,5,6	2,4,5	1,3,4
84	3	80	No’xatning o’simligida poya uzunligi, gulini qizil rangi va oddiy dukkagi to’liq dominant belgi hisoblanadi. Trigeterozigota formali o’simliklar o’zaro chatishtirilganda 1280 ta o’simlik hosil bo’ldi. Kalta  poyali o’simliklarning nechtasi bo’g’imli dukkakli bo’lishini aniqlang?	60	320	240
85	3	7200	O’n molekula sut kislotaning aerob parchalanishi tufayli ATF molekulalariga bog’langan energiyaning miqdorini toping.	3600	5760	8640
86	3	1,2,3               	Dengiz bo’shliqichlilariga mos keluvchi tushunchalarni aniqlang. 1-paypaslagichlar;   2-kolonial hayot;  3-lichinka;    4-kiprikchalar;  5-nerv to’qimalari;   6-anal teshigi;   7-otiluvchi tola;    8-chig’anoq	2,4,6	3,5,6	1,5,8
87	3	4,1,5,6,2,3,7               	Yomg’ir chuvolchangining ovqat hazm qilish organlari sistemasini to’g’ri ketma-ketlikda ko’rsating. 1) xalqum;   2) oshqozon;   3) ichak;    4) o’g’iz teshigi;  5) qizilo’ngach;    6) jig’ildon;   7) anal teshigi;    8) katta oshqozon;     9) kichik oshqozon    10) jigar;    11) lablar	11,1,5,6,8,3,10,7	4,1,5,8,9,3,10,7 	4,1,6,8,9,3,7
88	3	a-1.2 b-3.6  	Algologiya (a) va lixenologiya (b) fanlari o’rganuvchi organizmlarni to’g’ri juftlang. 1) ulva 2) ulotriks 3) batsidiya 4) batsilla 5) nemalion 6) parmeliya 7) laminariya	a-1.5 b-6.7	a-2.7 b-4.6	a-5.7 b-3.4
89	3	exinokokk, planariya                       	Ayirish sistemasi bir uchi berk naychalardan iborat organizmlarni toping	midiya, bitiniya	dengiz ko`p tuklisi, nereida	omar, langust
90	3	Tikan daraxt tuxumak deb ham ataladi                 	Qaysi ma’lumotlarda xatolik mavjud?	Baobab gulxayridoshlar oilasiga kiradi	Nor piyoz, Suvorov piyoz, Gul piyozi xushmanzara tur hisoblanadi	Topinambur moychechakdoshlar oilachasiga kiradi
91	3	qizil kongo bo`yog`i yordamida hazm   vakuolasi o`rganiladi       	Tufelka haqidagi to`g`ri javobni toping.	metil bo`yog`I hazm vakuolasini yashil rangga bo`yaydi	sirka kislota ta`sir ettirilganda  otuvchi hujayra orqali himoyalanadi	pichan ivitmasiga osh tuzi tushirilsa refleks orqali javob qaytaradi
92	3	santa gertruda, gereford             	Go’shtdor qoramol zotlarini belgilang.	shortgorn, Yaroslavl	qizil dasht, Kostroma	gereford, Bushuyev
93	3	Simmental, Kostroma                        	Sersut-go’shtdor qoramol zotlarini belgilang.	Santa-gertruda, Yaroslavl	Qizil dasht, Shvits	Kostroma, Bushuyev
94	3	kavsh qaytaruvchi juft tuyoqli     	Nuqtalar o‘rniga mos javobni tanlang. Ohu ... hayvon.	oshqozoni ikki bo‘lmali	kavsh qaytarmaydigan juft tuyoqli	toq tuyoqli
95	3	a - qoqio‘tdosh;                    b - sho‘radosh;                   c - bug‘doydosh                	Shuvoq (a), sho‘rak (b), chayir ajriq (c) qaysi oila vakillari hisoblanadi?	a - qoqio‘tdosh;                   b - sho‘radosh;                   c - burchoqdosh	a - qovoqdosh;                  b - sho‘radosh;                  c - bug‘doydosh	a - qoqio‘tdosh;                 b - karamdosh;                    c - bug‘doydosh
96	3	genom mutatsiyasi                 	Nuqtalar o‘rniga mos javobni tanlang. G‘o‘za avlodida 52 xromosomali turning paydo bo‘lishi ... hisoblanadi.	xromosoma mutatsiyasi	gen mutatsiyasi	nuqtali mutatsiya
97	3	a - Aristotel;                 b - J.B.Lamark;                c - Ch.Darvin	"Hayvonlarning paydo bo‘lishi" (a),"Zoologiyaga kirish" (b), "Turlarning paydo bo‘lishi" (c) asari mualliflari to‘g‘ri juftlangan javobni toping.	a - Ch.Darvin;                   b - I.P.Pavlov;               c - J.B.Lamark	a - J.B.Lamark;                b - N.Gryu;                            c - K.Linney	a - Ch.Darvin;                b - N.Gryu;                                 c - K.Linney
98	3	qon aylanish sistemasi yopiq            	Nuqtalar o‘rniga mos javobni tanlang. Siklop soxta kurakburun singari ... .	skeleti suyakdan iborat	jabra orqali nafas oladi	nerv sistemasi bosh va orqa miyadan iborat
99	3	nitrifikator bakteriya, yapon laminariyasi                    	Avtotrof organizmlarni aniqlang?	riniya, keta	kabarga, xlorella	suvyig‘ar, tripanosoma
100	3	c, d      	Naysimon suyaklar berilgan javobni aniqlang. a) qovurg‘a; b) umurtqa; c) yelka; d) son	a, b	a, d	b, c
101	3	1, 4	Nam sharoitda o‘sadigan o‘simliklarga mos keluvchi ma’lumotlar to‘g‘ri ko‘rsatilgan javobni aniqlang. 1) gigrofitlar deb ataladi; 2) gidrofitlar deb ataladi; 3) ularga elodeya, nilufar misol bo‘ladi; 4) ularga qo‘g‘a, qamish, ro‘vak o‘simliklari misol bo‘la oladi.	1, 3	2, 4	2, 3
102	3	barg yaprog‘i parallel yoki yoysimon tomirlangan, gulqo‘rg‘oni oddiy bo‘ladi                 	Piyozdoshlarga xos xususiyatlarni aniqlang.	unayotgan o‘simlikda urug‘pallabargi yer ostida qoladi, gulqo‘rg‘oni murakkab bo‘ladi	asosiy ildiz tezda nobud bo‘ladi, unayotgan o‘simlik tuproqdan ikkita urug‘pallabarg bilan chiqadi	gulqo‘rg‘oni oddiy, o‘q ildizi rivojlangan bo‘ladi
103	3	a - qizil chuvalchang;                 b - zog‘cha               	Sovuq qonli (a) va issiq qonli (b) hayvonlarni aniqlang.	a - tasqara;                    b - ko‘rshapalak	a - gavial;                         b - tilyapiya	a - baqachanoq;                     b - krevetka
104	3	4.5	.,,Dengiz karami’’ ga xos bo’lgan ma’lumotlarni aniqlang?                                                                                           1)hujayrasi selleluza qobig’iga ega  2)vegetativ organga ega  3)fotosintez jarayoni xlorofil ishtirokida sodir bo’ladi  4)spora orqali jinsiz ko’payadi  5)tuban o’simlik  6)urug’ orqali jinsiy ko’payadi	2.5	3.6	1.2
105	3	a-5; b-1, 3, 6              	Yuragi ikki kamerali yurak bo’lmachasida venoz qon bo’lgan (a) va yuragi ikki kamerali yurak bo’lmachasida arterial qon bo’lgan (b) hayvonlarni aniqlang.1)tridakna; 2)itbaliq; 3)bitiniya; 4)qisqichbaqa; 5)zog’ora baliq; 6)kichik suv shilling’i	a-5; b-2, 3, 4, 6	-2, 4, 5; b-3, 6	a-3, 6; b-2,
106	3	a-mitseliydan;                   b-zigotadan       	Mog’or zamburug’i jinssiz (a) va jinsiy (b) ko’payganda sporangiy nimadan hosil bo’ladi?	a-sporadan;                  b-zigotadan	-mitseliydan;                    b-sporadan	a-sporadan;                                   b-gametalardan
107	3	peshona, tepa, chakka, ensa          	Bosh qutisining qaysi suyaklari bola o‘sgan sari chok yordamida birikadi?	peshona, tepa, ensa, ponasimon	g‘alvirsimon, ponasimon, chakka, tepa	ensa, yanoq, chakka, tepa
108	3	taloq, jigar          	Qonning shaklli elementlari qaysi organlarda parchalanadi?	jigar, oshqozon osti bezi	buyrak, jigar	taloq, buyrak
109	3	1, 3, 4 	III qon guruhli rezus musbat odamlarda eritrotsit tarkibida qanday oqsillar bo‘ladi?1) gemoglobin; 2) agglyutinogen A; 3) agglyutinogen B; 4) rezus omil; 5) agglyutinin α, β	1, 3	1, 2, 3, 4	1, 2, 4, 5
110	3	1, 4             	Qonning yopishqoqligi nimaga bog‘liq?1) oqsillar miqdoriga; 2) yog‘lar turi va miqdoriga; 3) uglevodlar turi va miqdoriga; 4) eritrotsitlar miqdoriga	1, 3, 4	2, 3, 4	1, 2, 4
111	3	g‘ozsimon                       	Churrak, suqsunlar qaysi turkumga mansub?	tovuqsimon	laylaksimon	chumchuqsimon
112	3	baliqlar va yirik qisqichbaqasimonlar         	Pingvinlar nima bilan oziqlanadi?	faqat boshoyoqli molluskalar	fito- va zooplanktonlar	suvo‘tlar, baliqlar, molluskalar
113	3	1, 4, 5, 6              	Ikki bo‘lmali oshqozonga ega bo‘lgan hayvonlarni ko‘rsating.1) eshakqurt; 2) biy; 3) falanga; 4) langust; 5) tuvaloq; 6) kaptar	1,2,3              	2, 3, 4, 6	5, 6
114	3	Bo‘r davrining o‘rtalariga kelib               	..... yopiq urug‘li o‘simliklarning bir pallali, ikki pallali sinflarining ko‘p oilalari paydo bo‘lgan.	To‘rtlamchi davrda	Trias davrining boshlariga kelib	Uchlamchi davr boshida
115	3	Exinokokk	Yassi chuvalchanglar tipi, tasmasimon chuvalchanglar sinfiga mansub parazit chuvalchangni belgilang.	odam askaridasi	jigar qurti	oq planariya
116	3	jinssiz va jinsiy            	Yapon laminariyasi qaysi yo‘l bilan ko‘payadi?	kurtaklanib	faqat jinssiz	jinsiy va kurtaklanib
117	3	d, e, f                	Xushmanzarali piyoz turlarini aniqlang. a) pskom piyozi; b) Oshanin; c) qum piyozi; d) Suvorov; e) norpiyoz; f) qo‘shbarg piyoz.	a, b, c	b, c, e	a, d, f
118	3	ninachi  	Voyaga yetgan vakillari, hamda lichinkasi yirtqichlik bilan hayot kechiradigan hasharotni aniqlang.	bo‘ka	so‘na	temirchak
119	3	vertitsiliumning gifalari    	Vilt bilan kasallangan g‘o‘za poyasining yog‘och qismida nima ko‘rinadi?	gommozning gifalari	gommozning sporalari va gifalari	vertitsiliumning urug‘lari va sporalari
120	3	a-eukariot;                   b-konument;                      c-umurtqali    	G’umay(a), podoliya (b), tulki (c) uchun mos keluvchi belgilarni toping.	a-produtsent;                  b-yirtqich;                     c-xemotrof	a-eukariot;                    b-produtsent;                    c-redusent	a-autotrof;                            b-geterotrof;                   c-fototrof
121	4	46 kJ      	Massasi 1 kg bo‘lgan temir jism 10℃ dan 410℃ gacha qizdirilganda qancha issiqlik miqdori oladi? c = 460 J/(kg°C).	 45 kJ         	 47 kJ            	 48 kJ
122	4	 5 kg             	Oyda kosmonavt qo‘lida yuk osilgan dinamometr bilan turibdi. Dinamometr 8 N ni ko‘rsatmoqda. Yukning massasi qancha bo‘lgan? Oy sirti uchun  g=1.6 N/kg	 3 kg             	 4 kg                        	 8 kg
123	4	 350 Pa                   	Belkurakning tig‘li qismining eni 20 cm va qalinligi 1 mm ga teng bo‘lib, odam belkurakka 70 N kuch bilan bossa, yerga qanday bosim beradi?	 400 Pa           	 300 kPa               	 250 kPa
124	4	    250 N               	Stol ustidagi savatga massasi 25  kg bo‘lgan meva solingan. Savatga ta’sir etayotgan og‘irlik kuchini toping. g = 10 m/s2.	 40 N           	 45 N              	 49 N
125	4	 0,50 kg           	Qancha massadagi tabiiy gaz butunlay yonganda 22 MJ issiqlik miqdori ajralib chiqadi? Tabiiy gazning solishtirma yonish issiqligi q = 44∙106 J deb oling.	 1,50 kg             	 1,55 kg     	 0,55 kg
126	4	  16 Pa                    	Og‘irligi 80 N bo‘lgan brusok yerda turibdi. Brusokning pastki qismining yuzi 5 m^2  ga teng. Brusokning yerga berayotgan bosimi qacha? 	 18 Pa                       	 14 Pa                         	 12 Pa
127	4	 3,308 MJ                      	Temperaturasi 20 ℃ va massasi 3 kg bo‘lgan suv dastlab qaynadi, keyin to‘la bug‘ga aylandi. Bu jarayonlarda suv qancha issiqlik miqdori olgan? Suv uchun c = 4200 J/(kg∙°C) va r = 2,3∙106 J/kg) 	 7,708 MJ              	 2,208 kJ                        	 5,508 kJ
128	4	   Mexanik ish                          	Jismning kuch ta’sirida ma’lum bir masofaga ko‘chishi nima deb ataladi? 	 Energiya  	 Mexanik energiya                	  Kuch
129	4	   990 kJ               	220 V kuchlanishli tarmoqqa ulangan elektr isitgichdan 5 A tok o‘tmoqda. Tok 0,25 soat davomida qanday ish bajaradi?	 9900 kJ          	2200 kJ       	220
130	4		Massasi 2 t bo‘lgan avtomobilning g‘ildiraklari bilan asfalt orasida hosil bo‘ladigan dumalanish ishqalanish kuchini toping. G‘ildirak diametrini 1 m, rezina bilan asfalt orasidagi dumalanish ishqalanish koeffitsiyentini 2 mm, g = 10 m/s2   deb oling. 			
131	4	  60 N          	220 V kuchlanishli tarmoqqa ulangan elektr dvigateli zanjiridagi tok kuchi 3 A teng. Agar dvigatelning foydali ish koeffitsiyenti 80% bo‘lsa, dvigatel 1 soatda qancha foydali ish bajaradi?	 40 N            	 30 N                	 80 N
132	4	  Birinchi kosmik tezlik 	Jism Yer shari atrofida aylana bo‘ylab harakatlanishi uchun yetarli bo‘lgan tezlik qanday ataladi? 	 Ikkinchi kosmik tezlik           	 Vertikal tezlik                 	 Gorizontal tezlik            
133	4	  380 V              	Elektr dvigatelining quvvati 7,6 kW, undagi tok kuchi 20 A. U qanday kuchlanishli tarmoqqa ulangan? 	 220 V            	  400 V       	 350 V
134	4	  8,64 MJ 	Qarshiligi 60 Ω bo‘lgan sim spiraldan 8 A tok o‘tmoqda. Shu spiraldan 0,5 soat davomida qancha issiqlik miqdori ajralib chiqadi?	 86,4 MJ        	 0,864 MJ         	 18 MJ          
135	4	   q = 54 nC           	Sig‘imi 6 nF bo‘lgan kondensator qoplamalariga tok manbaidan 9 V kuchlanish berildi. Kondensatorning har bir qoplamasi qanday zaryad oladi?	 q = 45 nC            	 q = 81 nC             	 q = 81 nC
136	4	 220 V          	Xonadonlardagi elektr zanjir odatda qanday kuchlanishli umumiy elektr tarmoqqa ulangan bo‘ladi?                                                 	 100 V      	 200 V           	 120 V
137	4	 26.          	Vertolyot 24 m/s tezlik bilan shimol tomon uchmoqda. G‘arb tomondan 10 m/s tezlik bilan shamol essa, vertolyot qanday (m/s) tezlik bilan uchadi? 	 14.             	 24.          	 28.             
138	4	 1,5.            	Suzuvchining suvga nisbatan tezligi 0,9 m/s ga teng va qirg‘oqqa tik yo‘nalgan, suvning oqish tezligi esa 1,2 m/s ga teng. Suzuvchining qirg‘oqqa nisbatan tezligi qanday (m/s)? 	 0,9.            	 1,2.         	 0,3.            
139	4	 5.1.             	Motorli qayiq suv oqimiga perpendikulyar yo‘nalishda 18 km/soat tezlik bilan harakatlanyapti. Daryo suvining oqimi tezligi 1 m/s bo‘lsa, qayiq qirg‘oqqa nisbatan qanday tezlik bilan harakatlanadi (m/s)? 	 6.           	 17.         	 10.           
140	4	 2,5.            	Qayiqning suvga nisbatan tezligi 2 m/s va qirg‘oqqa tik yo‘nalgan. Suvning oqish tezligi esa 1,5 m/s. Qayiqning qirg‘oqqa nisbatan tezligi qanday (m/s)? 	 3,5.            	 2.            	 1,5.              
141	4	  6.        	Jism yo‘lning birinchi yarmini 9 m/s tezlik bilan, ikkinchi yarmini esa 2 marta sekinroq o‘tgan bo‘lsa, uning butun yo‘l davomidagi o‘rtacha tezligi qanday (m/s)?	 4.              	 5.               	 2.            
142	4	 34,3.           	Avtomobil A bekatdan B bekatgacha 40 km/h, qaytishda esa 30 km/h tezlik bilan harakatlandi. Reys davomidagi o‘rtacha tezlikni toping (km/h). 	 34.          	 33,5.              	 35.          
143	4	 36.         	 Poezd yo‘lning ikkinchi yarmini birinchi yarmiga nisbatan 1,5 marta katta tezlik bilan o‘tdi. Poezdning butun yo‘l davomidagi o‘rtacha tezligi 43,2 km/h ga teng bo‘lsa, yo‘lning birinchi yarmidagi tezligi qanday (km/h) bo‘lgan? 	 9.       	 14.          	 28.              
144	4	22,5.          	Poezd yo‘lning birinchi yarmini ikkinchi yarmiga qaraganda 2 marta katta tezlik bilan bosib o‘tdi. Uning butun yo‘l davomidagi o‘rtacha tezligi 54 km/h bo‘lsa, yo‘lning birinchi yarmidagi tezligi qanday (m/s) bo‘lgan? 	20.           	 22.           	 21.         
145	4	22,5.          	Avtomobil yo‘lning birinchi yarmini ikkinchi yarmiga nisbatan 8 marta katta tezlikda o‘tdi. Agar avtomobilning butun yo‘l davomidagi o‘rtacha tezligi 32 km/h bo‘lsa, yo‘lning ikkinchi yarmidagi tezligi necha km/h bo‘lgan? 	20.           	 22.           	 21.         
146	4	  2,5.               	Jism 10 m/s tezlik bilan yuqoriga tik otildi. Necha metr balandlikda uning potensial va kinetik energiyalari tenglashadi? 	1.           	 3,5.         	 4.            
147	4	 3,6.              	Jism 12 m/s tezlik bilan vertikal ravishda yuqoriga otildi. Necha metr balandlikda uning kinetik energiyasi potensial energiyasiga teng bo‘ladi? 	 7,2.             	 3,8.           	 4.             
148	4	 kovaklar soni.                    	Yarimo‘tkazgichlarda akseptor aralashmasi bo‘lganda, ... ortadi. Mazkur jumladagi nuqtalar o‘rnini to‘ldiring. 	 erkin elektronlar soni.     	erkin protonlar soni.               	 erkin pozitronlar soni.             
149	4	 akseptor aralashma.               	Yarimo‘tkazgich asosan teshikli o‘tkazuvchanlikka ega. Kristallda qanday aralashma bor? 	 asosan teshikli o‘tkazuvchanlikka ega yarimo‘tkazgich bo‘lmaydi. 	 aralashmalar yo‘q. 	 donor aralashma.                   
150	4	 donor aralashma.              	Yarimo‘tkazgich asosan elektron o‘tkazuvchanlikka ega. Kristallda qanday aralashma bor? 	 akseptor aralashma.              	 aralashmalar yo‘q. 	 donor va akseptorlarning konsentratsiyalari teng.    
151	5	Was/is                     	Our  homework______ very   difficult  yesterday,but  today  It _____easy.	Were/is	Will/like	 Was/was
152	5	    Where                   	______was  she  born?    She  was  born  in  Uzbekistan.	   When	  What	 Who
153	5	     Is/was                  	The  weather____nice  today,  but  it  _____nasty  yesterday.	  Are/was	 Isn’t/were	 Was/was
154	5	   are                    	The  students________very  tired  today.	 Was	Were  being	Is
155	5	  Were/was/am                     	How  old _________you  in1990?   I  _______10,but  now  I  _____25	Was/was/am	Are/was/is	Were/were/am
156	5	    Were/were                   	Where____they  born?           They_____born in  1999	   Was/were	  Was/am	  Was/was
157	5	  What/were                     	_______could  you  do  when  you ____seven.	  Where/was	  What/was	 Were/was
159	5	   bought                    	He_____some  new  shoes  last  month.	  Were   bought	  Were  boughting	   Buy
160	5	  She  had  a  new  car                      	Past  simple  zamoniga  oid  gapni  aniqlang.	  She  has  anew  car	  She  have  anew  car	  She  has  had  a  new  car
161	5	 did                      	____  she  meet  her  friend?	Do	Were	While  done
162	5	  saw                     	Last  year  I ___my  teacher.	 Seen	See	Sees
163	5	 Were/was                      	Where____you  last  week? I_____in  Alabama	Was/was	Are/was	Were/were
164	5	  are                     	Where_____you  now?	Were	Was	Isn’t
165	5	  can                     	Everybody____drive  a  car  in  my  family	 Will	 Does	 Did
166	5	    Is  working                   	Tom _____in  the  garden  at  the   moment.	 Are  working	 Were  working	Was  working
167	5	    Have/done                   	I______just_____my    homework.	    Had/did	  Has/done	Do/did
168	5	 Came/was  sleeping                      	When  I_____, my  mum _____in  the  house.	Come/were  sleeping	Is/is  going	Are/are  doing
169	5	     Present  Perfect   Tense                  	Have  you  finished  your  work?  Ushbu  gap  qaysi  zamonga  tegishli?	    Past  Perfect  Tense	  Present  Perfect  Continuous	 Past  Simple
170	5	  yet                     	Has   she  done  her  homework _____?	Already	Just	At  the  moment
171	5	   Am  going                     	I________to  the   cinema   tomorrow?	Is  going	Will  going	 Being
172	5	 1960s                      	Internet  was  founded  in_______	1991s	1948s	1968s
173	5	  wants                     	Ann ______to  be  an  artist.	 Likes	Would	Likeness
174	5	 had                      	Last  summer  I______a  good  holiday	Have	Has  had	Has
175	5	  Am  going                       	I_________to  London  next  year	 Is  going	 Was  going	Were  going
176	5	  tastes                     	This  soap______good	 Tasty	 Tastness	Is  tasting
177	5	    are                   	My  favourite  sports  _______volleyball,football  and  tennis	  Is	Was	Is  going  to
178	5	     On/by                  	I  go  to  school ____foot,but  my  sister  goes  to  school______bus	  To/by	To/to	On/on
179	5	  in                     	I  was  born  _____May	On	At	Of
180	5	  Used  to/lives                     	Lucy’s  mum  _______live  in  Japan,but  now  she  _______in  Uzbekistan.	  Didn’t/lived	  Is  going to/wants  to living	  Don’t/did
181	5	     at                  	_____5  o’clock  I  have  a   lunch	  To	  On	  In
182	5	   gone                    	Bob’s  not  here.He’s  ______to  work.	  Went	  Go	 Going
183	5	  Ever  been                     	Have  you ___________  to  China?	Never  been	Ever  seen	Just  gone
184	5	   Look  after/grow  up                    	Nurses  ______  ill  people, and  gardeners  ______flowers  &  plants.	  Looks  after/grow  up	  Grow   up/look  after	  Looking  after/is  growing 
185	5	   would                    	I  _____like  to  eat  some  cheese.	  Want	  Wants	 Look
186	5	  salary                     	Translate into  English  “maosh’’	 Money	 Nothing	 Working  money
187	5	 when                      	I have  seen  him, ____  he  was  young	Where	Whose	What
188	5	 went                      	Last  year  I______to   America	Go	Is  going	Gone
189	5	  should                     	I ______tidy  up  my  room	Be	Willing	Would  to  not
190	5	  when                     	My  parents   moved  back  to  England ______I  was   five	 Ago	 For	Since
191	5	 for                      	We  lived  inBristol  ______three  years	Since	By	Last
192	5	  ago                     	I  left  college  three  years______	For	Since	Far
193	5	    at                   	I  usually  go  home______the  weekend	To	For	On
194	5	  last                     	I  didn`t  go  home______weekend,because  my  friends  came  to  stay	For	since	at
195	5	 At/in                      	They  arrived______three  o`clock______the  afternoon	In/in	In/at	In/on
196	5	   Last                    	________Saturday  evening  we  went  out  to  a  concert	In	For 	On
197	5	   on                    	We  got  up  late______Sunday  morning	In	At	Inside
198	5	  many                     	How  _____flowers  are  there?	Much	Less	More
199	5	      was / was   	  My mother …. Reading a  book  ,   I  ….  Watching  TV.	  were / was        	was /were	  Were
200	5	    Am  going           	I… to Iearn French next year.    	    was  going        	  is  going         	 has  going
201	5	       r,a,k,e,       	 Put  the letter.  Exe.Cises.Re.ch.Nowl.dge. 	       a,r,k,e,         	       e,k,a,r;	      e,a,r,k
202	5	 eager                     	 Choose     the   correct    word.    I’m eager /proper to  learn  English.	      Proper       	    I’m  eager	   English
203	5	      A  written  list of personal  details, education,job              	 What  is  curriculum  vitae?	     duty                            	      Good  points  about  person	     Knowledge  or  skill
204	5	12	  Uzbekistan  is  divided  into … regions.	10	9	14
205	5	      in                    	 He lives … London.	     about          	     Of	    After
206	5	       till             	. I’ll  stay  here … Monday.	       of         	       Too	     Still
207	5	       to        	. He  went … the cinema.	      at     	   Off	   With
208	5	      from /till             	 I shall work … nine … ten.	      frow / to       	     to / from	     till/from
209	5	   Knowledge and  skill that  is  gained through  time    spend  doing  a job  or  activity.                	 Find  this  word’s  definition.   Experience	    Having  a  duty  to  deal  with          	    A  written  form  of asking  for  a  job	   Still
210	5	  practical               	.. Find  this  word’s  definition. Hands  on   	   A  first  year  student          	  auditory	 kinesthetic
211	5	Mashhura  can’t   walk   and  her  leg is in  plaster.She  has  broken.                	. Find  present  perfect sentence.	  Thi s     morning  I  was  expecting.	  Paris  is  the  most  beautiful  city.	 The  temperature  was  20  degrees  above. Now  it  is  only 12.
212	5	   Education        	.   Translate  info  Uzbek   “ta’lim”?	  Educated	 Simple	 Lately
213	5	 Furthest     	 Find the antonym.The moon is the  nearest  sattellite to the earth.	 Nearest	 Coolest	Nothing
214	5	Salary        	   Translate into Uzbek “maosh”	Money	Coin	Lit bntle
215	5	Visual,auditory,kinesthetic      	How  many  types  of  learners  do  you  know?	Confusion,listen  to,heard	Talk  through,communication	Listening  activity
216	5	 ago                 	I  bought  a  car  a  few  weeks______	last	For	At
217	5	 Did  you  cut                 	How   _______your  finger?	Are  you  cutting	Were  you  cutting	You  cut
218	5	  saw                	I _____a  very  good  program  on  TV  last  night	see	seen	Will  see
219	5	  richest                	Who  is the ______man  in  the  world?	  rich	 More  rich	 richer
220	5	   Have  you  ever  been               	_______to  a rock  concert?	Had  you  saw	Do  you  ever  go	Have  ever  go
221	5	 saw                 	I_____the  champion  last  week	see	seen	Was  seeing
222	5	  When                	‘’_____did  the   first  man  walk  on  the  moon?’’      ‘’in  1969’’	 Where	What	Which
223	5	  Who                	‘’______did  she  marry?’’      ‘’She  married  to  John’’	When	Where	What
224	5	  big                	A______dog	Biggest	Bigger	More  big
225	5	  quickly                	He  run _______	 quicker	quickest	 quick
226	5	  fastest                	He  drives  too______	 fastly	 faster	 fast
227	5	 about                 	What  is  the  story _____	In	On	At
228	5	   at               	What  happened  _____the  end  of  the story?	In	On	from
229	5	    How  much              	______did  you  pay?  $  1000	  How  many	Which  one	 How
230	5	  When                	‘’______did  you  go?’’       ‘’This  morning.’’	  Where	  Which	  Who
231	5	   what               	‘’_______did  you  buy?’’     ‘’A  new  jacket’’	   when	 who	which
232	5	    Where              	‘’_______did  you  buy  a  new  jacket?’’     ‘’At  supermarket’’	    When	  Who	  Which
233	5	  Older  than                	You are ______me	 old	 oldest	 older
234	5	  Have/got                	How  many  children_____they____?	Has/got	 Have/get	Does/got
235	5	     work             	Sue  and  Goeff______a  shop	     Study	     Run	     Runs
236	5	    Is  called              	his  kind  of  shop_____a  milk  bar	Is  calling	Were  calling	Are  called
237	5	  closes                	Most  days  the  shop_____at  10.00 p.m.	 Opened	Selfs	Run
238	5	   go               	hey  ____camping  any  more	 went	 gone	going
239	5	  has                 	Ursula____four  brothers  and  two  sisters	Have	Haven`t	Having
240	5	  Takes/walk                	It_____her  fifteen  minutes______to  school	 Tooks/walking	Took/go	Has  taken/going
241	5	      has            	She  _____ travelled  to  most  parts  of  the  world.	     Does	     have	     did
242	5	   Have/been               	_____you  ever ___in  a  car  accident?	  Has/been	   Have/be	  Have/was
243	5	    left              	I ______last  night.	    leave	   Had  left	   leaved
244	5	   went            	She ____  to  Russia  two  years  ago	  Goes	Gone	Go
245	5	  Was/was                	I_____in  a  crash  when  I _______10	 Were/was	Am/was	 Do/was
246	5	to                  	Julie  is  married  ______Sam	With	In	At
247	5	 of                 	This  book  is  full____pictures.	On	In	At
248	5	  with                	I  don`t  agree____him.	To	In	At
249	5	at                  	He  isn`t  good ____French	In	On	To
250	5	  in                	My  brother  is  interested  ______math.	On	At	To
251	5	   at               	Look ___those  birds!	To	In	On
252	5	 of                 	Are  you  afraid  _____flying?	To	At	On
253	5	  for                	Wait ______me   in  the  street.	  To	 At	In
254	5	   for               	Bill  is  looking_______ his  keys   but  he  can`t  find  them.	   At	   To	   On
255	5	    for              	Please  ask ______  help  if  you  want.	    To	    At	    On
256	5	   for               	Do  you  work  ______someone  special?	To	At	On
257	5	  with                	Can  I  speak_______ you  for  a  minute?	   To	  At	On
258	5	     To  become             	Barbara  hopes____a  lawyer.	     Become	     Is  becoming	     Becoming
259	5	 To go                 	I’d  love ______with  you.	Going	To  going	 Go
260	5	 watching                 	She  enjoys _____  the  news  on  TV.	  Watched	   To  watch	   Watch
261	5	To  having                  	I’m  looking  forward_____more  free  time.	 To  have	 Of  having	Having
262	5	  To  try                	Do  you  want ______it  again?	To  trying	Trying	Try
263	5	  as                	He  isn`t  as  intelligent  ______his  sister.	Than	Then	Nothing
264	5	   harder               	This  is______ than  I  expected.	   Hardest	   More  hard	   Hard
265	5	  Was/is                     	Our  homework______ very   difficult  yesterday,but  today  It _____easy.	Were/is	Will/like	 Was/was
266	5	    Where                   	______was  she  born?       She  was  born  in  Uzbekistan.	   When	  What	 Who
267	5	     Is/was                  	The  weather____nice  today,  but  it  _____nasty  yesterday.	  Are/was	 Isn’t/were	 Was/was
268	5	   are                    	The  students________very  tired  today.	 was	Were  being	is
269	5	  Were/was/am                     	How  old _________you  in1990?      I  _______10,but  now  I  _____25	Was/was/am	Are/was/is	Were/were/am
270	5	    Were/were                   	Where____they  born?     They_____born in  1999	   Was/were	  Was/am	  Was/was
271	5	  What/were                     	_______could  you  do  when  you ____seven.	  Where/was	  What/was	 Were/was
272	5	   How  many                    	____languages  do  you  know?	  How  much	  where	  whose
273	5	   bought                    	He_____some  new  shoes  last  month.	  Were   bought	  Were  boughting	   buy
274	5	  She  had  a  new  car                      	Past  simple  zamoniga  oid  gapni  aniqlang.	  She  has  anew  car	  She  have  anew  car	  She  has  had  a  new  car
275	5	 did                      	____  she  meet  her  friend?	do	were	While  done
276	5	  saw                     	Last  year  I ___my  teacher.	 seen	see	sees
277	5	 Were/was                      	Where____you  last  week?                I_____in  Alabama	Was/was	Are/was	Were/were
278	5	  are                     	Where_____you  now?	were	was	Isn’t
279	5	  can                     	Everybody____drive  a  car  in  my  family	 will	 does	 did
280	5	    Is  working                   	Tom _____in  the  garden  at  the   moment.	 Are  working	 Were  working	Was  working
281	5	    Have/done                   	I______just_____my    homework.	    Had/did	  Has/done	Do/did
282	5	 Came/was  sleeping                      	When  I_____, my  mum _____in  the  house.	Come/were  sleeping	Is/is  going	Are/are  doing
283	5	     Present  Perfect   Tense                  	Have  you  finished  your  work?  Ushbu  gap  qaysi  zamonga  tegishli?	    Past  Perfect  Tense	  Present  Perfect  Continuous	 Past  Simple
284	5	  yet                     	Has   she  done  her  homework _____?	already	just	At  the  moment
285	5	   Am  going                     	I________to  the   cinema   tomorrow?	Is  going	Will  going	 being
286	5	 1960s                      	Internet  was  founded  in_______	1991s	1948s	1968s
287	5	  wants                     	Ann ______to  be  an  artist.	 likes	would	likeness
288	5	 had                      	Last  summer  I______a  good  holiday	have	Has  had	has
289	5	  Am  going                       	I_________to  London  next  year	 Is  going	 Was  going	Were  going
290	5	  tastes                     	This  soap______good	 tasty	 tastness	Is  tasting
291	5	    are                   	My  favourite  sports  _______volleyball,football  and  tennis	  is	was	Is  going  to
292	5	     On/by                  	I  go  to  school ____foot,but  my  sister  goes  to  school______bus	  To/by	To/to	On/on
293	5	  in                     	I  was  born  _____May	on	at	of
294	5	  Used  to/lives                     	Lucy’s  mum  _______live  in  Japan,but  now  she  _______in  Uzbekistan.	  Didn’t/lived	  Is  going to/wants  to living	  Don’t/did
295	5	     at                  	_____5  o’clock  I  have  a   lunch	  To	  On	  In
296	5	   gone                    	Bob’s  not  here.He’s  ______to  work.	  went	  go	 going
297	5	  Ever  been                     	Have  you ___________  to  China?	Never  been	Ever  seen	Just  gone
298	5	   Look  after/grow  up                    	Nurses  ______  ill  people, and  gardeners  ______flowers  &  plants.	  Looks  after/grow  up	  Grow   up/look  after	  Looking  after/is  growing 
299	5	   would                    	I  _____like  to  eat  some  cheese.	  want	  wants	 look
300	5	  salary                     	Translate into  English  “maosh’’	 money	 nothing	 Working  money
301	5	 when                      	I have  seen  him, ____  he  was  young	where	whose	what
302	5	 went                      	Last  year  I______to   America	go	Is  going	gone
303	5	  should                     	I ______tidy  up  my  room	be	Willing	Would  to  not
304	5	  when                     	My  parents   moved  back  to  England ______I  was   five	 Ago	 For	Since
305	5	 for                      	We  lived  inBristol  ______three  years	Since	By	Last
306	5	  ago                     	I  left  college  three  years______	For	Since	Far
307	5	    at                   	I  usually  go  home______the  weekend	To	For	On
308	5	  last                     	I  didn`t  go  home______weekend,because  my  friends  came  to  stay	For	Since	At
309	5	 At/in                      	They  arrived______three  o`clock______the  afternoon	In/in	In/at	In/on
310	5	   Last                    	________Saturday  evening  we  went  out  to  a  concert	In	For 	On
311	5	   on                    	We  got  up  late______Sunday  morning	In	At	Inside
312	5	  many                     	How  _____flowers  are  there?	Much	Less	More
313	5	  Was/is                     	Our  homework______ very   difficult  yesterday,but  today  It _____easy.	Were/is	Will/like	 Was/was
314	5	    Where                   	______was  she  born?    She  was  born  in  Uzbekistan.	   When	  What	 Who
315	5	     Is/was                  	The  weather____nice  today,  but  it  _____nasty  yesterday.	  Are/was	 Isn’t/were	 Was/was
316	5	   are                    	The  students________very  tired  today.	 Was	Were  being	Is
317	5	  Were/was/am                     	How  old _________you  in1990?    I  _______10,but  now  I  _____25	Was/was/am	Are/was/is	Were/were/am
318	5	    Were/were                   	Where____they  born?     They_____born in  1999	   Was/were	  Was/am	  Was/was
319	5	  What/were                     	_______could  you  do  when  you ____seven.	  Where/was	  What/was	 Were/was
320	5	   How  many                    	____languages  do  you  know?	  How  much	  Where	  Whose
321	5	   bought                    	He_____some  new  shoes  last  month.	  Were   bought	  Were  boughting	   Buy
322	5	  She  had  a  new  car                      	Past  simple  zamoniga  oid  gapni  aniqlang.	  She  has  anew  car	  She  have  anew  car	  She  has  had  a  new  car
323	5	 did                      	____  she  meet  her  friend?	Do	Were	While  done
324	5	  saw                     	Last  year  I ___my  teacher.	 Seen	See	Sees
325	5	 Were/was                      	Where____you  last  week?     I_____in  Alabama	Was/was	Are/was	Were/were
326	5	  are                     	Where_____you  now?	Were	Was	Isn’t
327	5	  can                     	Everybody____drive  a  car  in  my  family	 Will	 Does	 Did
328	5	    Is  working                   	Tom _____in  the  garden  at  the   moment.	 Are  working	 Were  working	Was  working
329	5	    Have/done                   	I______just_____my    homework.	    Had/did	  Has/done	Do/did
330	5	 Came/was  sleeping                      	When  I_____, my  mum _____in  the  house.	Come/were  sleeping	Is/is  going	Are/are  doing
331	5	     Present  Perfect   Tense                  	Have  you  finished  your  work?  Ushbu  gap  qaysi  zamonga  tegishli?	    Past  Perfect  Tense	  Present  Perfect  Continuous	 Past  Simple
332	5	  yet                     	Has   she  done  her  homework _____?	Already	Just	At  the  moment
333	5	   Am  going                     	I________to  the   cinema   tomorrow?	Is  going	Will  going	 Being
334	5	 1960s                      	Internet  was  founded  in_______	1991s	1948s	1968s
335	5	  wants                     	Ann ______to  be  an  artist.	 Likes	Would	Likeness
336	5	 had                      	Last  summer  I______a  good  holiday	Have	Has  had	Has
337	5	  Am  going                       	I_________to  London  next  year	 Is  going	 Was  going	Were  going
338	5	  tastes                     	This  soap______good	 Tasty	 Tastness	Is  tasting
339	5	    are                   	My  favourite  sports  _______volleyball,football  and  tennis	  Is	Was	Is  going  to
340	5	     On/by                  	I  go  to  school ____foot,but  my  sister  goes  to  school______bus	  To/by	To/to	On/on
341	5	  in                     	I  was  born  _____May	On	At	Of
342	5	  Used  to/lives                     	Lucy’s  mum  _______live  in  Japan,but  now  she  _______in  Uzbekistan.	  Didn’t/lived	  Is  going to/wants  to living	  Don’t/did
343	5	     at                  	_____5  o’clock  I  have  a   lunch	  To	  On	  In
344	5	   gone                    	Bob’s  not  here.He’s  ______to  work.	  Went	  Go	 Going
345	6	6	   Bosib o’tilgan yo’lni topish formulasidan foydalanib, t- vaqtni toping.S=72 km, V =12 km/h .	3	12	4
346	6	 270 va 810          	  Ikki to’pda  1080 m gazmol bor.Birinchi to’pda ikkinchisiga qaraganda 3 marta ko’p gazmol bor.Har bir to’pda qanchadan gazmol bor?	  150 va 750          	 80 va1000	  200 va 880              
347	6	184	  Tenglamani yeching: 3x+5x+96=1568 	201	107	148
348	6	1032	   Ifodaning qiymatini toping: 72a+32b , bunda a = 9 va b = 12	1000	604	528
349	6	27	  Hisoblang : EKUB(81;54) 	9	12	16
350	6	48	  Hisoblang : EKUK(16;6)  	25	32	36
351	6	-60	  Hisoblang : -15+(-15)+(-15)+(-15) 	60	-30	40
352	6	5421	  Hisoblang:  542,1:0,1  	5264	5242	5246
353	6	  -2a-2.5	  Ifodani soddalashtiring: a-3a+4,7-7,2 	  -3+2a         	   2.4+2a             	 32-2a            
354	6	 -12+2m             	  Ko’phad va birhad ko’paytmasini toping: -2(6-m)	  -3+6m         	  -2m+6	   -12+4m         
355	6	36	  Algebraik ifodaning qiymatini toping: 3(8a+7)-9(3a-1) , bunda a= -2 	42	25	18
356	6	99	  Tasma 8:3 kabi nisbatda ikki bo’lakka bo’lindi .Katta tasmaning  uzunligi 72 sm . Berilgan tasmaning uzunligini toping.	90	33	10
357	6	  28,8 t	 Bug’doy sepish me’yori 1 gektarga 0,24 tonnani tashkil qiladi. 1:10 000 masshtabli tarhda bo’yi 12sm va eni 10sm li bo’lgan to’g’ri to’rtburchak shaklidagi maydonga sepish uchun  necha tonna  bug’doy kerak bo’ladi.	  288 t	   0,28 t	   28 t
358	6	 cheksiz ko’p yechim	 Tenglamani yeching  .   3x+2=5(x+1) - 2x- 3	   bo’sh to’plam	5	-3
359	6	180	  Sonlarning  eng  kichik  umumiy  bo’linuvchisini  toping.   ( 45 , 90 , 180 )	45	300	5
360	6	58.12	 Teploxod ko’lda 27 km/h  tezlik  bilan 3 soat , so’ngra bu ko’lga quyiladigan daryoda oqimga qarshi 4 soat suzdi . Agar daryo oqimining tezligi 3 km/ h bo’lsa , teploxod shu 7 h da bosib o’tgan masofani toping.	55	55.12	58.21
361	6	   6ta	 3,6,7,9 raqamlari yordamida ularni takrorlamasdan nechta to’rt xonali 4ga karrali  son tuzish mumkin .	   32 ta	   12 ta	 48 ta
362	6	  	 Hisoblang:    	729	3	27
363	6		 			
364	6	-20	  Hisoblang. ((1-3)+(5-7) +(9-11) + …. + (97-99)) :5	500	20	-18
365	6	6	   Bosib o’tilgan yo’lni topish formulasidan foydalanib, t- vaqtni toping.S=72 km, V =12 km/h .	3	12	4
366	6	 270 va 810          	  Ikki to’pda  1080 m gazmol bor.Birinchi to’pda ikkinchisiga qaraganda 3 marta ko’p gazmol bor.Har bir to’pda qanchadan gazmol bor?	  150 va 750          	 80 va1000	  200 va 880              
367	6	184	  Tenglamani yeching: 3x+5x+96=1568 	201	107	148
368	6	1032	   Ifodaning qiymatini toping: 72a+32b , bunda a = 9 va b = 12	1000	604	528
369	6	27	  Hisoblang : EKUB(81;54) 	9	12	16
370	6	48	  Hisoblang : EKUK(16;6)  	25	32	36
371	6	-60	  Hisoblang : -15+(-15)+(-15)+(-15) 	60	-30	40
372	6	5421	  Hisoblang:  542,1:0,1  	5264	5242	5246
373	6	  -2a-2.5	  Ifodani soddalashtiring: a-3a+4,7-7,2 	  -3+2a         	   2.4+2a             	 32-2a            
374	6	 -12+2m             	  Ko’phad va birhad ko’paytmasini toping: -2(6-m)	  -3+6m         	  -2m+6	   -12+4m         
375	6	36	  Algebraik ifodaning qiymatini toping: 3(8a+7)-9(3a-1) , bunda a= -2 	42	25	18
376	6	99	  Tasma 8:3 kabi nisbatda ikki bo’lakka bo’lindi .Katta tasmaning  uzunligi 72 sm . Berilgan tasmaning uzunligini toping.	90	33	10
377	6	  28,8 t	 Bug’doy sepish me’yori 1 gektarga 0,24 tonnani tashkil qiladi. 1:10 000 masshtabli tarhda bo’yi 12sm va eni 10sm li bo’lgan to’g’ri to’rtburchak shaklidagi maydonga sepish uchun  necha tonna  bug’doy kerak bo’ladi.	  288 t	   0,28 t	   28 t
378	6	 cheksiz ko’p yechim	 Tenglamani yeching  .   3x+2=5(x+1) - 2x- 3	   bo’sh to’plam	5	-3
379	6	180	  Sonlarning  eng  kichik  umumiy  bo’linuvchisini  toping.   ( 45 , 90 , 180 )	45	300	5
380	6	58.12	 Teploxod ko’lda 27 km/h  tezlik  bilan 3 soat , so’ngra bu ko’lga quyiladigan daryoda oqimga qarshi 4 soat suzdi . Agar daryo oqimining tezligi 3 km/ h bo’lsa , teploxod shu 7 h da bosib o’tgan masofani toping.	55	55.12	58.21
381	6	   6ta	 3,6,7,9 raqamlari yordamida ularni takrorlamasdan nechta to’rt xonali 4ga karrali  son tuzish mumkin .	   32 ta	   12 ta	 48 ta
382	6	-20	  Hisoblang. ((1-3)+(5-7) +(9-11) + …. + (97-99)) :5	500	20	-18
383	6	150	  Soat mili 30 minutda necha gradusga buriladi	1800	600	300
384	7	55 kg                       	  Ikki kunda 220 kg qulupnay terildi.Ikkinchi kun birinchi kunga qaraganda 3 marta ko`p qulupnay terildi.Birinchi kun qancha qulupnay terilgan?	50 kg   	175 kg 	65  k
385	7	25 ta                                  	  Kulol birinchi kun 15 ta ko`za yasadi.Ikkinchi kunda esa birinchi kunga qaraganda 5 ta ko`za kam yasadi.Ikki kunda kulol nechta ko`za yasagan?	45 ta	56 ta	78 ta
386	7	7ta	  Berilgan sonlar ichida nechta tub sonlar mavjud:7,45,17,18,19,313,419,409,373,363	8 ta	9 ta	6 ta
387	7	15/40, 32/40                                     	  3/8 va 4/5 kasrlarni umumiy maxrajga keltiring.	8/13, 12/13	30/80, 65/80	3/40, 4/40
388	7	90	  Abdurashid kitobning 36 betini o`qidi .Bu esa kitobning 2/5 qismini tashkil qiladi.Shu kitob necha betli?	89	34	78
389	7	0.25	  73 sm ning 2.92 metr ga nisbatini toping.	0.35	0.75	1.25
390	7	30400	  3 metr mato uchun 11400 so`m to`landi.Shu matoning 8 metiri necha so`m turadi?	31400	30500	31400
391	7	860	  920 probali  180 gram oltin 752 probali 100 gram oltin bilan qo`shib eritildi.Natijada qanday probali qotishma hosil bo`ldi?	680	760	890
392	7	55 kg                       	  Ikki kunda 220 kg qulupnay terildi.Ikkinchi kun birinchi kunga qaraganda 3 marta ko`p qulupnay terildi.Birinchi kun qancha qulupnay terilgan?	50 kg   	175 kg 	65  k
393	7	25 ta                                  	  Kulol birinchi kun 15 ta ko`za yasadi.Ikkinchi kunda esa birinchi kunga qaraganda 5 ta ko`za kam yasadi.Ikki kunda kulol nechta ko`za yasagan?	45 ta	56 ta	78 ta
394	7	7ta	  Berilgan sonlar ichida nechta tub sonlar mavjud:7,45,17,18,19,313,419,409,373,363	8 ta	9 ta	6 ta
395	7	15/40, 32/40                                     	  3/8 va 4/5 kasrlarni umumiy maxrajga keltiring.	8/13, 12/13	30/80, 65/80	3/40, 4/40
396	7	90	  Abdurashid kitobning 36 betini o`qidi .Bu esa kitobning 2/5 qismini tashkil qiladi.Shu kitob necha betli?	89	34	78
397	7	0.25	  73 sm ning 2.92 metr ga nisbatini toping.	0.35	0.75	1.25
398	7	30400	  3 metr mato uchun 11400 so`m to`landi.Shu matoning 8 metiri necha so`m turadi?	31400	30500	31400
399	7	860	  920 probali  180 gram oltin 752 probali 100 gram oltin bilan qo`shib eritildi.Natijada qanday probali qotishma hosil bo`ldi?	680	760	890
400	7	55 kg                       	  Ikki kunda 220 kg qulupnay terildi.Ikkinchi kun birinchi kunga qaraganda 3 marta ko`p qulupnay terildi.Birinchi kun qancha qulupnay terilgan?	50 kg   	175 kg 	65  k
401	7	25 ta                                  	  Kulol birinchi kun 15 ta ko`za yasadi.Ikkinchi kunda esa birinchi kunga qaraganda 5 ta ko`za kam yasadi.Ikki kunda kulol nechta ko`za yasagan?	45 ta	56 ta	78 ta
402	7	7ta	  Berilgan sonlar ichida nechta tub sonlar mavjud:7,45,17,18,19,313,419,409,373,363	8 ta	9 ta	6 ta
403	7	15/40, 32/40                                     	  3/8 va 4/5 kasrlarni umumiy maxrajga keltiring.	8/13, 12/13	30/80, 65/80	3/40, 4/40
404	7	90	  Abdurashid kitobning 36 betini o`qidi .Bu esa kitobning 2/5 qismini tashkil qiladi.Shu kitob necha betli?	89	34	78
405	7	0.25	  73 sm ning 2.92 metr ga nisbatini toping.	0.35	0.75	1.25
406	7	30400	  3 metr mato uchun 11400 so`m to`landi.Shu matoning 8 metiri necha so`m turadi?	31400	30500	31400
407	7	860	  920 probali  180 gram oltin 752 probali 100 gram oltin bilan qo`shib eritildi.Natijada qanday probali qotishma hosil bo`ldi?	680	760	890
408	8	Sintaksis	Gap Va Gapda So’zlarningbog’lanishi Bilan Shug’ullanuvchi Tilshunoslik Bo’limi - ……	Grafika	Orfografiya	Fonetika
409	8	24 Ta 	Tilimizda Nechta Nutq Tovushi Bor?	22 Ta	26 TA	23 Ta
410	8	Dori-Darmon 	Preparat So’zining Ma’nosi?	Yurak Shifosi	Hujum, Hamla	Qiyoslash
411	8	Dori-Darmon	Muqoyasa So’zining Ma’nosi?	Qiyoslash, Solishtirish	Xuriy	Bag’ishlov
412	8	Ibora Urg’usi	“Urg’u Ikki Xil Bo’ladi: So’z Urg’usi Va ……..” . Nuqtalar O’rnini To’ldiring.	So’z Birikmasi Urg’usi	Matn Urg’usi	Gap Urg’usi
413	8	Muhaddis	 “Hadis Biluvchi”, “Hadis Aytuvchi” Ma’nosini Anglatuvchi So’zni Toping.	Vahiy	Nosahih	Sahih
414	8	Yulduzlar	Kavokib So’zining Ma’nosi?	Chuqur	Dengi	Uzoq
415	8	Kelishik Shakllari	Ot, Olmosh Va Otlashgan So’zlarga Qo’shilib, Ularni Boshqa So’zlarga Bog’lash Uchun Xizmat Qiluvchi Grammatik Shakllar Tizimi Nima Deyiladi?	Egalik Shakllari	Shaxs-Son Shakllari	Ko’plik Shakllari
416	8	Tiklanadi	Qaratqich Va Qaralmish O’rtasida Boshqa So’z Qo’llanilsa, Qaratqich Qo’shimchasi………...Gapni Davom Ettiring.	Tiklanmaydi	Qisqarmaydi	Qisqaradi
417	8	Yordamchi So’zlar	Atash Ma’nosiga Ega Bo’lmagan, Ma’lum So’roqqa Javob Bo’lmaydigan, Gap Bo’lagi Vazifasida Kelmaydigan So’zlar Nima Deyiladi?	Ravish	Olmosh	Son
418	8	Ko’makchilar 	Ot, Olmosh, Harakat Nomi Va Sifatdoshlardan Keyin Kelib, Ularni Hokim So’zga Bog’lash Uchun Xizmat Qiluvchi Bilan, Uchun, Kabi,Singari,Sayin Kabi So’zlar Nimalar Deyiladi?	Bog’lovchilar	Olmosh	Yuklamalar
419	8	 Kitob	Oq Qog‘Ozda Qora Chiziqlar - Harflardan Bo‘Lak Hech Nima Yo‘Q. Rang Ham, Ovoz Ham, Raqqosaning Harakatlari    Ham... Ushbu Parcha Qaysi So'zining Ta'rifi Hisoblanadi?	 San'at	 Iroda	 Tabiat
420	8	 Ilmiy Uslub	 Qaysi Uslubda Maxsus Terminlar Yordamida Fanga Doir Fikrlami Bayon Etishga Mo‘Ljallangan. Bu Uslubda Bo‘Yoqdor  So‘Z Va Qo‘Shimchalar, Iboralar, Maqol Va Matallar Qatnashmaydi.	 Badiiy Uslub	 Rasmiy Uslub	 Publitsistik Uslub
421	8	 Stenografiya	Og‘Zaki Nutqni Yozuvda Qayd Etishni Maksimal Darajada Tezlashtirish Maqsadida Yaratilgan Maxsus Yozuv Sistemasi Nima Deb Ataladi?	 Etnografiya	 Hind Yozuvi	 Defektologiya
422	8	 Esse	Adabiy, Falsafiy, Ijtimoiy, Publitsistik Va Boshqa Mavzularda Yozilgan, Muammolar Tizimli, Ilmiy Tarzda Emas, Balki Erkin Shaklda Talqin Qilinadigan Nasriy Asar Nima Deb Ataladi?	 Ocherk	 Masal	 Hikoya
423	8	 Evfemizm	Madaniy  Nutq  Sohibi  O‘Z  Fikrini  Chiroyli  Va  Kishi  Ko‘Ngliga  Og‘Ir  Botmaydigan  Qilib Ifoda  Etadi.  Fikrni  Og‘Ir  Botmaydigan, Tinglovchiga Malol  Kelmaydigan  Qilib  Ifodalash  Vositalari  Nima   Deb Ataladi?	 Disfemizm	 Modernism	 To'g'ri Javob Berilmagan
424	8	 Maqol	Xalq Og‘Zaki Ijodi Janri, Shu Bilan Birga,  Til Birligi Ham. U – Ixcham, Mazmuniy Va Ta’sirchanlik Ko‘Lami Baland Ifoda. Ushbu Ta'rifga Mos Keladigan So'zni Belgilang.	 Masal	 Maqom	 Matal
425	8	 Tasviriy Ifoda	Narsalar Nomining Bo‘Yoqdor Muqobili Bo‘Lgan Birikma. U Uslubiy Chegaralangan, Ko‘Proq Publitsistikaga Xos. Ushbu Ta'rifga Mos Keladigan So'zni Belgilang.	 Ibora	 Maqol	 So'z Birikmasi
426	8	3	Matn Turlari Nechiga Bo'linadi?	1	2	5
427	8	 Hikoya Matni	“G’afur Akaning O’zi O’sha Buyuk Ustozlar Izidan Borishga Intilardi.Shuning Uchun Ham U Tariximizni Mukammal Bilar, Rasmlar Chizar Edi… ”–Bu Qaysi Matn Turiga Kiradi?	 Tasviriy Matn	 Aralash	 Muhokama Matni
428	8	 Gulobi, Obinavvot,Asadi	Bir To’plamga Kiruvchi Narsalar Nomini Ayting?	 Huseni,Charos,Umrboqi	 Olma,Anor, Turp	 “Kurash”, “Qushim Boshi”, Ko’kcha
429	8	 O’zlik N	  Ammo Kampirning Dodiga Odam Tez To’pla…..Di.– Nuqtalar O’rniga Qaysi Nisbar Qoshimchasi Qo’yiladi?	 Ortirma N	 Aniq N	 Birgalik N
430	8	 1- O’tgan Z., 2-Kelasi Z., 3- Hozirgi Z.	 1-Hayqirar Edi,2 -Yig’lamoqchi,3- Qichqirmoqda  Fe’l Zamonlarini Ketma-Ketlikda Ko’rsating?	 1- Kelasi Z., 2-O’tgan  Z., 3- O’tgan Z.	 1- O’tgan Z., 2- Kelasi Z., 3- Kelasi Z.	1- Hozirgi Z.2-Kelasi Z.,3- O’tgan Z.
431	8	2	So’z Birikmasi Hokim So’zning Qaysi Turkumga Oid So’z Bilan Ifodalanishiga Ko’ra Necha Guruhga Bo’linadi?	8	4	3
432	8	Ravishdosh	“Ishning Boshi- Boshlanguncha “. Ushbu Gapda Kesim Ifodalanishiga Ko’ra Qaysi Turi Berilgan?	Fe’l Kesim	Kesim Kesim	Ot Kesim
433	8	Bosh Gap	Barcha Zarur Bo’laklari Mavjud Gap Qanday Gap?	To’liq Gap	 Oddiy gap	To’liqsiz Gap
434	8	tadqiq etmoq, orzum 	  To’g’ri yozilgan so’zlar qatorini toping.	estalik, saxna	kelayapti, naqarot             	uydan-uyga, tadbiq etmoq 
435	8	baobro’, beobro’, obro’siz	  Asosdosh so’zlar qatorini toping.	guruhdosh, sinfdosh, aka-uka	tengqur, yo’ldosh, hamteng	birmakon, birzamon, yo’ldoshli
436	8	4	  Ona kabi o’z bolasiga mehribon mavjudot bormi sizlarda? Gapda lug’aviy ma`noga ega bo’lmagan nechta so`z mavjud?	2	1	3
437	8	mardlarcha, jim   	  Quyidagi qaysi javobda holat ravishlari berilgan?	jo`rttaga, arang	qasddan, zo`rg`a  	noiloj, ataylab
438	8	7-sinf, 2001-yil, 2-guruh	  Qaysi qatorda tartib sonlar to‘g‘ri yozilgan?	yettinchi sinf, 2001 yil, 2 guruh	7-sinf, 2002 yil,        2-guruh	II sinf,            2001-yil,           2-guruh
439	8	ganch – boylik	  Qaysi qatordagi juftliklar o`zaro sinonim (ma`nodosh) hisoblanmaydi?	ma`tal – muntazir	tal`at – chehra	dom – tuzoq     
440	8	bro-ker,ta-aj-jub,kel-di-ngiz	  Qaysi so‘zlar qatori bo‘g‘inga to‘g‘ri ajratilgan?	min-nat-dor, mu-ro-ja-at, shta-nga	ta-raq-qiy-ot, ta-al-luq-li, yon-gan	or-fog-ra-fi-ya, ko-mis-si-ya, kon-trakt
441	8	Yurtimizning xalqaro miqyosdagi obro‘yi kundan-kunga oshib bormoqda.	  Qaysi javobda imloviy xatolik kuzatilgan?	Xalqimizning tilagi bitta – tinchlik.	Fevral oyiga kelib, sovuqning shashti biroz pasaydi.	Sportchilarning olimpiada o‘yinlaridagi ishtiroki hammamizni quvontirdi.
442	8	Bilan, kabi, singari, uchun, sari, sayin, bo‘ylab	  Bosh kelishik shaklidagi ismlarga qo‘shiladigan ko‘makchilar berilgan qatorni aniqlang?	Ko‘ra, qaramay, yarasha, asosan, doir, muvofiq.	Keyin, bo‘lak, boshqa, o‘zga, tashqari, buyon, oldin, boshlab, avva	Old, ost, ust, tomon.
443	9	Sintaksis	Gap Va Gapda So’zlarningbog’lanishi Bilan Shug’ullanuvchi Tilshunoslik Bo’limi - ……	Grafika	Orfografiya	Fonetika
444	9	24 Ta 	Tilimizda Nechta Nutq Tovushi Bor?	22 Ta	26 TA	23 Ta
445	9	Dori-Darmon 	Preparat So’zining Ma’nosi?	Yurak Shifosi	Hujum, Hamla	Qiyoslash
446	9	Dori-Darmon	Muqoyasa So’zining Ma’nosi?	Qiyoslash, Solishtirish	Xuriy	Bag’ishlov
447	9	Ibora Urg’usi	“Urg’u Ikki Xil Bo’ladi: So’z Urg’usi Va ……..” . Nuqtalar O’rnini To’ldiring.	So’z Birikmasi Urg’usi	Matn Urg’usi	Gap Urg’usi
448	9	A. Navoiy	”Olam Ahli Bilingizkim, Ish Emas Dushmanlig’,  Yor O’lung Bir-Biringizki Erur Yorlug’ Ish”. Parcha  Muallifini Toping.	Z.M. Bobur	Ogahiy	Lutfiy
449	9	Homer 	“Odisseya” Asarining Muallifini Toping.	Gyote	Pushkin	Gerodot
450	9	Muhaddis	“Hadis Biluvchi”, “Hadis Aytuvchi” Ma’nosini Anglatuvchi So’zni Toping.	Vahiy	Nosahih	Sahih
451	9	Oybek	“Qutlug’ Qon” Romanining Muallifini Aniqlang.	Odil Yoqubov	Mirkarim Osim	O’tkir Hoshimov
452	9	Muso	“Ariq Labidan Bir Parcha Loy Olib “Poq-Poq” O’ynab Turgan Qahramon “ Nomini Aniqlang.	A’zam	Qosim	Ahmad
453	9	Rauf Parfi	“Tong Otmoqda. Tong O’qlar Otar,         Tong Otmoqda, Quyosh-Zambarak.                     Yaralangan Yer Shari Yotar   Boshlarida Yashil Chambarak.”    Ushbu Parcha Kimga Tegishli?	Cho’lpon	Erkin Vohidov	Abdulla Oripov
454	9	Cho’lpon	Kimning She’rida Bolsheviklar Qirg’ini, Sho’ro Mustamlakachilari Tomonidan O’lkamizning Vayronaga, O’likxonaga Aylantirilgani Haqida Aytilgan?	Hamza Hakimzoda Niyoziy	Fitrat	Shuhrat
455	9	Saida Zunnunova	“Andijon Shahrida Xizmatchi Oilasida Dunyoga Kelgan, Ilk She’ri “Salom Senga” “Paxta Fronti” Gazetasida Bosilgan”. Ushbu Ma’lumotlar Kimning Hayotidan?	Rasul Hamzatov	Halima Xudoyberdiyeva	Shuhrat
456	9	Shuhrat	“Garchand Frontda Muntazam Ijod Etolmagan Bo’lsam Ham, Qachonlardir Bu Sevimli Hunarimga Qaytish Ishtiyoqi Bir Lahza Ham Xayolimdan Ketgani Yo’q. Ba’zan Zavq-Shavqimni Yoki Dushmanga Nafratimni Qog’ozga Tushirib Qo’yar Edim”, - Deb Yozgan Ijodkor Kim?	Xayriddin Saloh	Mirmuhsin	Chingiz Aytmatov
457	9	Daryolar Tutashgan Joyda	“Hamshaharlarim”, “99 Miniatura”, “Karvon Qo’ng’irog’i”, “Quyosh Belanchagi”, “Sizga Aytar So’zim” Singari She’riy Kitoblar Muallifining Birinchi Qissasi Qaysi?	Chinor	Po’lat Quyuvchi	Opa-Singillar
458	9	Asqad Muxtor	“Ruhim Bilan Yo’lda Ekanman,       Umrimning Ham Nihoyasi Yo’q”.  Ushbu Misralar Muallifi Kim?	Zulfiya	Hamid Olimjon	Rasul Hamzatov
459	9	Erkin Vohidov 	“Qubbon Sohilida Qomating Bukib,                 Oltin Barglaringni Ko’l Uzra To’kib,                      Nimalar Haqida Surasan Xayol,                   So’yla, Majnuntol?”   Ushbu Misralar Muallifi Kim?	Zulfiya	Xayriddin Saloh	Mirtemir
460	9	Abdurahmon	Abdulla Qodiriyning “Mehrobdan Chayon” Romanida Hindilarning Savdogariga O’xshatilgan Qiyofa Egasi Kim?	Anvar	Shahodat Mufti	Kalonshoh Mirzo
461	9	Nusrat	Zavqiyning “Hajv Ahli Rasta” She’ridan  “….Bila Oshnolig’im Bor, Tentakkina Shatrama-Shatra”. Nuqtalar O’rnini To’ldiring.	Oxundjon	Ahmadjon	Umarjon
462	9	Yulduzlar	Kavokib So’zining Ma’nosi?	Chuqur	Dengi	Uzoq
463	9	Kelishik Shakllari	Ot, Olmosh Va Otlashgan So’zlarga Qo’shilib, Ularni Boshqa So’zlarga Bog’lash Uchun Xizmat Qiluvchi Grammatik Shakllar Tizimi Nima Deyiladi?	Egalik Shakllari	Shaxs-Son Shakllari	Ko’plik Shakllari
464	9	O’rin-Payt, Qaratqich, Bosh Kelishiklari	“Hovli….. Shabada Bilan O’ynashgan Daraxtlar…. Yengil Kuyidan Boshqa Sado Yo’q. Shoir …O’yga Toldi.”   Nuqtalar O’rniga Kelishiklarni To’g’ri Joylashtiring.	Chiqish, Qaratqich, Tushum Kelishiklari	O’rin-Payt, Tushum, Bosh Kelishiklari	Tushum, O’rin-Payt, Tushum Kelishiklri
465	9	Tiklanadi	Qaratqich Va Qaralmish O’rtasida Boshqa So’z Qo’llanilsa, Qaratqich Qo’shimchasi…..               Gapni Davom Ettiring.	Tiklanmaydi	Qisqarmaydi	Qisqaradi
466	9	Yordamchi So’zlar	Atash Ma’nosiga Ega Bo’lmagan, Ma’lum So’roqqa Javob Bo’lmaydigan, Gap Bo’lagi Vazifasida Kelmaydigan So’zlar Nima Deyiladi?	Ravish	Olmosh	Son
502	9	7-sinf, 2001-yil, 2-guruh	Qaysi qatorda tartib sonlar to‘g‘ri yozilgan?	yettinchi sinf, 2001 yil, 2 guruh	7-sinf, 2002 yil,        2-guruh	II sinf,            2001-yil,           2-guruh
467	9	Ko’makchilar 	Ot, Olmosh, Harakat Nomi Va Sifatdoshlardan Keyin Kelib, Ularni Hokim So’zga Bog’lash Uchun Xizmat Qiluvchi Bilan, Uchun, Kabi,Singari,Sayin Kabi So’zlar Nimalar Deyiladi?	Bog’lovchilar	Olmosh	Yuklamalar
468	9	 Kitob	Oq Qog‘Ozda Qora Chiziqlar - Harflardan Bo‘Lak Hech Nima Yo‘Q. Rang Ham, Ovoz Ham, Raqqosaning Harakatlari Ham... Ushbu Parcha Qaysi So'zining Ta'rifi Hisoblanadi?	 San'at	 Iroda	 Tabiat
469	9	 Ilmiy Uslub	Qaysi Uslubda Maxsus Terminlar Yordamida Fanga Doir Fikrlami Bayon Etishga Mo‘Ljallangan. Bu Uslubda Bo‘Yoqdor So‘Z Va Qo‘Shimchalar, Iboralar, Maqol Va Matallar Qatnashmaydi.	 Badiiy Uslub	 Rasmiy Uslub	 Publitsistik Uslub
470	9	 Stenografiya	Og‘Zaki Nutqni Yozuvda Qayd Etishni Maksimal Darajada Tezlashtirish Maqsadida Yaratilgan Maxsus Yozuv Sistemasi Nima Deb Ataladi?	 Etnografiya	 Hind Yozuvi	 Defektologiya
471	9	 Esse	Adabiy, Falsafiy, Ijtimoiy, Publitsistik Va Boshqa Mavzularda Yozilgan, Muammolar Tizimli, Ilmiy Tarzda Emas, Balki Erkin Shaklda Talqin Qilinadigan Nasriy Asar Nima Deb Ataladi?	 Ocherk	 Masal	 Hikoya
472	9	 Erkin Vohidov	Mening Yurtim Bugun Endi Jahon Birlan Tutashgandir,Tutash Taqdir, Tutash Ruhdir,Tutash Jondir, Tutash Qondir.                 Ushbu She'riy Parcha Kimga Tegishli?	 To'ra Sulaymon	 A. Oripov	 Turob To'la
473	9	 Evfemizm	Madaniy  Nutq  Sohibi  O‘Z  Fikrini  Chiroyli  Va  Kishi  Ko‘Ngliga  Og‘Ir  Botmaydigan  Qilib Ifoda  Etadi.  Fikrni  Og‘Ir  Botmaydigan, Tinglovchiga Malol  Kelmaydigan  Qilib  Ifodalash  Vositalari  Nima Deb Ataladi?	 Disfemizm	 Modernism	 To'g'ri Javob Berilmagan
474	9	 Shamshod Safar	Seni Deb Yashayman Ikki Dunyoda, Faqat Sen Yashaysan Mitti Yurakda.Baxtimga              Doimo Bo‘Lgin Deb Omon,Men Seni Yo‘Qotgim Kelmas Hech Qachon.                                  Kabi Misralar Misralar Muallifini Toping?	 Zafar Sobitov	 To'g'ri Javob Ko'rsatilmagan	 Rauf Parfi
475	9	 Maqol	Xalq Og‘Zaki Ijodi Janri, Shu Bilan Birga,  Til Birligi Ham. U – Ixcham, Mazmuniy Va Ta’sirchanlik Ko‘Lami Baland Ifoda. Ushbu Ta'rifga Mos Keladigan So'zni Belgilang.	 Masal	 Maqom	 Matal
476	9	 Tasviriy Ifoda	Narsalar Nomining Bo‘Yoqdor Muqobili Bo‘Lgan Birikma. U Uslubiy Chegaralangan, Ko‘Proq Publitsistikaga Xos. Ushbu Ta'rifga Mos Keladigan So'zni Belgilang.	 Ibora	 Maqol	 So'z Birikmasi
477	9	3	Matn Turlari Nechiga Bo'linadi?	1	2	5
478	9	 Hikoya Matni	“G’afur Akaning O’zi O’sha Buyuk Ustozlar Izidan Borishga Intilardi.Shuning Uchun Ham U Tariximizni Mukammal Bilar, Rasmlar Chizar Edi… ”–Bu Qaysi Matn Turiga Kiradi?	 Tasviriy Matn	 Aralash	 Muhokama Matni
479	9	 Gulobi, Obinavvot,Asadi	Bir To’plamga Kiruvchi Narsalar Nomini Ayting?	 Huseni,Charos,Umrboqi	 Olma,Anor, Turp	 “Kurash”, “Qushim Boshi”, Ko’kcha
480	9	 O’zlik N	Ammo Kampirning Dodiga Odam Tez To’pla…..Di.– Nuqtalar O’rniga Qaysi Nisbar Qoshimchasi Qo’yiladi?	 Ortirma N	 Aniq N	 Birgalik N
481	9	 1- O’tgan Z., 2-Kelasi Z., 3- Hozirgi Z.	1-Hayqirar Edi,2 -Yig’lamoqchi,3- Qichqirmoqda  Fe’l Zamonlarini Ketma-Ketlikda Ko’rsating?	 1- Kelasi Z., 2-O’tgan  Z., 3- O’tgan Z.	 1- O’tgan Z., 2- Kelasi Z., 3- Kelasi Z.	1- Hozirgi Z.2-Kelasi Z.,3- O’tgan Z.
482	9	 “Sehrli Nog’ora ”, “Ayyor Buratino” ,”Sahrodagi Uy”	J.Rodarining “”Uchtadan Oxiri Bor Ertaklar”To’plamiga Kiruvchi Ertaklarni Toping?	”Milanda Yo’g’gan Shilyapa Yomg’iri”, “Ayyor Buratino” ,”Shahzoda Plombir”	”Hellados”, “Sehrli Nog’ora ”, “Ayyor Buratino”	 ”Milanda Yo’g’gan Shilyapa Yomg’iri’’,”Kichkina Shahzoda”
483	9	12	”Tanobchilar”Da Har Necha Oyda Bir Tanob Keltirishi Aytilgan?	10	11	9
484	9	 Chigit Po’choq Kunjara Bilan Abdug’aniboy	”Bemor  ”Hikoyasida Sotiboldining Xo’jayini Nima Bilan Savdo Qiladi Va Uning Ismi?	Savat Sotib Olish Bilan Abdug’aniboy	 Chigit Po’choq Kunjara Bilan Xursanali	 Katta Yer Egasi  Xyrsanali
485	9	Urushning So’ngi Qurboni–Shoikrom	Suv Qalqisa Loyqasi Yuqoriga Chiqqanday, Zamon Qalqigandan Buyon Yomon Ko’paydi.Erta Bohorda Ularning Tug’ay Deb Turgan Sigirini O’g’irlab Ketishdi.–Kimning Sigirini O’g’irlashgan Va Qaysi Asardan?	Tanobchilar–Hakimjon	 Urushning So’ngi Qurboni–Shone’mat	Bemor–Sotiboldi
486	9	Hikoyani Aytayotgan Bolaning O’zi	”Muzqaymoq” Hikoyasida Kim Grafinni Sindirib Qo’ydi?	 Otasi Ataylab Sindirdi	Onasi	Opasi
487	9	Go’ro’g’li	Dushman  Bilan  Bo‘Ldim  Taraf,                      Arzim  Aytay  Senga  Qarab,                  Otim  G‘Irot,  Jonim  G‘Irot,                 Yeming  Kishmish,  To‘Rvang  Banot,                     Tezgir  Bo‘Lgin,  Keldi  Arab!                      Jumlalari “Go’ro’g’lining Tug’ulishi” Asarida Kim Tomonidan Aytilgan?	Ravshan	 G’irko’k	Odilxon
488	9	O‘Gdulmish	“Qutadg’u Bilik” Asaridagi Eng Faol Qahramon Kim?	Kuntug‘Di	O‘Zg‘Urmish	Oyto‘Ldi 
489	9	Saidkomil Umarov	“ Navoiy”  Videofilmida  Navoiy  Rolini Kim Ijro Etgan?	Erkin Komilov	T.J.Y	Mirzo Azizov
490	9	Farqi Qarolar	«Risolayi  Falsafayi  Siyohon» («Qarolar  Falsafasi  Risolasi»)Ning 2-Faslida Nima Haqida Fikr Yuritilgan?	Baxti Qarolar	Qora Zulmat	Barcha Qarolar
491	9	Tanosub	Boburning “Xazon  Yaprog‘I  Yanglig‘  Gul  Yuzung  Hajrida  Sarg‘Ardim…” G’azalida Qaysi San’atdan Foydalanilgan?	Tarse	Istiora	Tashmeh
492	9	2	So’z Birikmasi Hokim So’zning Qaysi Turkumga Oid So’z Bilan Ifodalanishiga Ko’ra Necha Guruhga Bo’linadi?	8	4	3
493	9	Ravishdosh	“Ishning Boshi- Boshlanguncha “. Ushbu Gapda Kesim Ifodalanishiga Ko’ra Qaysi Turi Berilgan?	Fe’l Kesim	Kesim Kesim	Ot Kesim
494	9	Bosh Gap	Barcha Zarur Bo’laklari Mavjud Gap Qanday Gap?	To’liq Gap	 Oddiy gap	To’liqsiz Gap
495	9	5 Ta	Lutfiyning Irsoli Masal Janrida Yozgan Asarida Nechta Maqoldan Foydalangan?	4 Ta	6 Ta	3 Ta
496	9	A. Navoiy   	Nasr Va Nazm Aralash Tarzda Bitilgan Asar Muallifi?	Nodira	Bobur	Lutfiy
497	9	Kuntug’mish (Xolbeka)  	“Har Kim Meni Olaman Deb Kelsa, Oldiga Nard O’yinini Qo’yaman, O’ynayman, Utsa Tegaman, Utdirsa So’yaman”- Qaysi Dostondan Parcha Va Kimning So’zi?	Alpomish (Barchinoy)	Kuntug’mish (Bahragul)	Go’ro’g’li (Zulxumor)
498	9	tadqiq etmoq, orzum 	To’g’ri yozilgan so’zlar qatorini toping.	estalik, saxna	kelayapti, naqarot             	uydan-uyga, tadbiq etmoq 
499	9	baobro’, beobro’, obro’siz	Asosdosh so’zlar qatorini toping.	guruhdosh, sinfdosh, aka-uka	tengqur, yo’ldosh, hamteng	birmakon, birzamon, yo’ldoshli
500	9	4	Ona kabi o’z bolasiga mehribon mavjudot bormi sizlarda? Gapda lug’aviy ma`noga ega bo’lmagan nechta so`z mavjud?	2	1	3
501	9	mardlarcha, jim   	Quyidagi qaysi javobda holat ravishlari berilgan?	jo`rttaga, arang	qasddan, zo`rg`a  	noiloj, ataylab
503	9	ganch – boylik	Qaysi qatordagi juftliklar o`zaro sinonim (ma`nodosh) hisoblanmaydi?	ma`tal – muntazir	tal`at – chehra	dom – tuzoq     
504	9	bro-ker,ta-aj-jub,kel-di-ngiz	Qaysi so‘zlar qatori bo‘g‘inga to‘g‘ri ajratilgan?	min-nat-dor, mu-ro-ja-at, shta-nga	ta-raq-qiy-ot, ta-al-luq-li, yon-gan	or-fog-ra-fi-ya, ko-mis-si-ya, kon-trakt
505	9	Yurtimizning xalqaro miqyosdagi obro‘yi kundan-kunga oshib bormoqda.	Qaysi javobda imloviy xatolik kuzatilgan?	Xalqimizning tilagi bitta – tinchlik.	Fevral oyiga kelib, sovuqning shashti biroz pasaydi.	Sportchilarning olimpiada o‘yinlaridagi ishtiroki hammamizni quvontirdi.
506	9	Bilan, kabi, singari, uchun, sari, sayin, bo‘ylab	Bosh kelishik shaklidagi ismlarga qo‘shiladigan ko‘makchilar berilgan qatorni aniqlang?	Ko‘ra, qaramay, yarasha, asosan, doir, muvofiq.	Keyin, bo‘lak, boshqa, o‘zga, tashqari, buyon, oldin, boshlab, avva	Old, ost, ust, tomon.
507	9	1937 yilda Fozil Yo’ldosh o’g’lidan Xodi Zarif tomonidan 	“Rustamxon “ dostoni qachon ,kimdan kim tomonidan yozib olingan ?	1939 yilda Fozil Yo’ldosh o’g’lidan Xodi Zarif tomonidan 	1937 yilda Fozil Yo’ldosh o’g’lidan Mahmud Zaripov  tomonidan	1937 yilda Fozil Yo’ldosh o’g’lidan Hamid Olimjon
508	9	Sultonxon	“Rustamxon “ dostonida Rustam va Huroyimning tirikligini eshitib ,ularni qalandar qiyofasida qidiradi ?	Momogul maston 	Huroyimning  ikki kundoshi 	Qizil dev  
509	9	14 yil, Qurudim 	“Rustamxon” dostonida Sultonxon necha yilda qaytaman deb qayerga safarga otlanadi ?	10 yil ,Qo’ng’irot	13 yil ,Oqtosh	12 yil ,Bujul 
510	9	Momogul maston	«Rustamxon» dostonida: «Botmon nosvoyni to'rt bo'lib otar edi, yurish-turishi odamlarga xatar edi, ne er yigitlami uch pulga olmay, qayerda yomonlik bo'lsa, izlab yetar edi», - deya ta'riflangan qahramon?	Surxayl	ajdar	Cho’ntoq jallod
511	9	Ximcha	Rustamxon «...tlllari bulbulcha, kimki yaxshi desa, shuncha, ikki yuzi ochllgan gulcha, bellari xipcha, o'zi suluv oyimcha, - deya ta'riflangan qahramon kim?	Huroyim	Oftoboy	Momogul maston
512	9	Qozikalon	Rustamxon” dostonida Rustamxonga Qurudimga ketish oldidan mamalakatni Huroyimga topshirishni kim maslahat beradi?	vaziri	Huroyim	xotinlari
513	9	"To’nyuquq bitiktoshi"da	"Tabg’achga taslim bo’ganligi uchun tangri o’l degan shekilli turk xalqi o’ldi, yo’q bo’ldi tugadi - Turk sir xalqi yeridan birorta urug’ qolmadi" Ushbu so’zlar qaysi adabiy yodgorlikda qayd etilgan?	"Kultegin bitiktoshi"da   	"Bilga hoqon" bitiktoshida	"Dcvoni lug’atit turk"da  
514	9	"O’rxun enasoy yodgorliklari"   	Rus xizmatchisi Remezov, sheved zobiti logann Stralenberg, olim Misser Shmidtlar topib, ilm ahliga ma'lum qilingan yodnoma nomi qaysi javobda to’g’ri korsatilgan?	Qutatg’u bilig"                	"Orxun Enasoy obidalari"	"Avesto"               
515	9	To'nyuquq	“...bitiktoshi 2 ta ustunga yozilgan. Ularning biri 170, ikkinchisi 160 sm. dan iborat. Bitiktosh Ulan-Bator dan 66 km. janubi-sharqdagi Bain-Sokto manzilidan topilgan va hozir ham shu yerda saqlanmoqda”. Ushbu ma’lumotlar qaysi bitiktoshga tegishli?	Kul Tigin	Bilga xoqon	Eltarish xoqon
516	9	Yetti yuz kishilik qo‘shin sarkardasi	“Shad” qanday unvon edi?	Olti yuz kishilik qo‘shin sarkardasi	To‘rt yuz kishilik qo‘shin sarkardasi	Uch yuz kishilik qo‘shin sarkardasi
517	9	Buxoroda Yusuf Hamadoniy qo`lida	Yassaviy kimdan tahsil oladi?	Bag'dodda Junaid Bag'dodiy qo’lida	Eronda Boyazid Bistomiy qo‘lida	Samarqandda Fazlulloh Abul layz qo`lida
518	9	“Madinada Muhammad, Turkistonda Xoja Ahmad”	Yassaviy tasawuf ilmini chuqur egallagani uchun xalq orasida qanday naql paydo boigan?	“Eronda Bistomiy, Turstonda Ahmadiy”	“Buxoroda Hamadoniy, Turkistonda Xo‘ja Ahmad”	Turkistonda Qul Xo‘ja, Bag‘dodda Bag‘dodiy”
519	9	Yassaviy merosini jamlagan asar. Asarda 240 ga yaqin she’r bor 	“Hikmatlar” qanday asar va uning tarkibida nechta she’r mavjud?	Yassaviy merosini jamlagan asar. Asarda 190 ta she’r bor	Yassaviy merosini jamlagan asar. Asarda 169 ga yaqin she’r bor	Yassaviy merosini jamlagan asar. Asarda 250 ta she’r bor
520	9	“Devoni hikmat”	“Hikmatlar” xalq orasida qanday nom bilan mashhur bo’lgan?	“Yassaviyning aytganlari”	“Otalar so‘zi”	“0‘g‘itlar”
521	9	Nafsga	Ahmad Yassaviy har doim nimaga insonning kamolotiga xalaqit  beradigan yovuz va yaramas kuch sifatida baho beradi va unga «shum» sifatini beradi?	axloqsizlikka  	nodonlikka 	ilmsizlikka
522	9	260	Atoyining bizgacha yetib kclgan she'riy devoniga nechta g’azal kiritilgan?	250	400	300
523	9	Ulug’bek Mirzo    	Atoyi qaysi temuriy hukmdor saroyida xizmat qilgan?	Umarshayx Mirzo                          	Shohruh Mirzo 	Abu Said Mirzo                             
524	9	Jamoling vasfini ... "  	Atoyi qaysi g’azalida qofiya uchun "chamanda", "baytul xazanda", "anda", "banda" so’zlarini kcltir»an  edi?"	"Qon bo’ldi ko’ngul..."                 	"Ko’ngil olding ,."                        	"Ul sanamki..."
525	9	Zahiriddin Muhammad Bobur     	Alisher Navoiy haqidagi quyidagi fikrlar muallifi kim?             «Alisherbek naziriyo'q kishi erdi. Turkiy til bila to she'r aytibturlar, hech kim oncha ko'p va xo'b aytqon emas».	Abdurahmon Jomiy	Mavlono Lutfiy	Muhammad Solih
526	9	Xondamir	Quyidagi fikrlar muallifi kim? «Bu aziz kitob hazrati xoqon Shohruh mirzo podshohligi davridan boshlab, shu zamonga qadar yer yuzini ravshan vujudlari bilan bezagan va bezab turgan olim va shoirlardan ko'plarining ba'zi sifatlaridan va ahvollaridan bayon qiladi».	Mirxond	Bobur	Bayoniy
527	9	Taft shahrida	Mashhur tarixchi olim Sharafiddin Ali Yazdiy yashaydigan qaysi shaharda olimning yosh Alisher bilan tanishuvi yuz beradi?	Balx shahrida	Hirot shahrida	Samarqand shahrida
528	9	Hakimshoh  Qazviniy	Alisher Navoiy haqida bildirilgan quyidagi fikrlar muallifi kim?       «Hech kim turkiy she'rni undan yaxshiroq ayta olmagan va nazm durlarini undan yaxshiroq socha olmagan».	Abdurahmon Jomiy	Xondamir	Rashidiy
529	9	«Munshaot»	Alisher Navoiyning turli  kishilarga yozilgan maktublardan tuzilgan kitobini   toping.	«Vaqfiya»	«Xamsat ul-mutahayyirin»	«Arba'in»
530	9	«Vaqoyi'»    	Pirimqul Qodirov, Bobur haqida bildirgan fikrlarida, «Boburnoma»ning dastlabki nomi qanday ekanligini aytib o'tadi?	«Boburnoma»	«Xatti Boburiy»	«Mubayyin»
531	9	«Mubayyin»   	Bobur musulmon axloqiga oid qaysi masnaviyni yaratgan?	«Muxtasar»   	«Boburnoma»	«Harb ishi»
532	9	1913-yilda kitob holida nashr qilingan	“Padarkush “ dramasining ilk bor nashri ko’rsatilgan javobni belgilang	1912 –yilda “Oyna “jurnalida nashr etilgan	1912 –yilda “Turon “gazetasida e’lon qilingan 	1913 –yilda “Samarqand “ gazetasida chop etilgan
570	10	 1930 yilda 	1929 -1933 yillarda bo’lib o’tgan jahon iqtisodiy inqirozi Fransiyada qachon boshlangan ?	  1931 yilda  	  1932 yilda   	  1933 yilda
533	9	Pivaxona manzarasi: boyvacha ila uch nafar o'lturar.	Behbudiyning “Padarkush yohud o‘qimagan bolaning holi” fojiasining ikkinchi pardasida qanday manzara bayon qilinadi?	Boy mehmonxonada olturar Xayrulla ila manzarasi.	Boy yotar karavot ustig'a Toshmurodning kelishi manzarasi	Boy va xotini suhbati  manzarasi.
534	9	Boy Ziyoliga 	M. Behbudiyning “Padarkush yoxud o‘qimagan bolaning holi” fojiasida “qordan qutulub, vog‘murga uchraymiz”. Ushbu maqolni, kim-kimga aytadi?	Toshmurod boyga 	Domla Artunga 	Pristuf boyvachchaga
535	9	Frans	«So'nggi saboq» hikoyasi qaysi qahramon tilidan hikoya qilinadi?	Amel	Vaxter 	Xauzer
536	9	ziyoli	«Padarkush» dramasida: «Bu shaharda boylarg'a amri ma’ruf qilaturgan mullo bor ekan, xudoga shukur. Ul janob haqqoniy domlani topib zlyorat qilmak kerak, boy afandim - deb boyga kim aytgan?	domla	mirza	hokim
537	10	  Neolit    	Paxsa imoratlar  qurish qaysi  davrdan  boshlandi ?   	  Eneolit      	  Mezolit     	  So’ngi paleolit
538	10	   metalurgiya        	Nimaning rivoji kishilarning moddiy va ma’naviy madaniyatiga katta to’sir ko’rsatdi? 	    dehqonchilik            	    savdo-sotiq            	    hunarmandchilik
539	10	 Chjou	Xitoyda qaysi sulola davrida butun shimoliy Xitoy uning tarkibiga kirgan ?    	   Sya 	  Shan    	   Xan
540	10	 kassiylar va elamiylar  	Егоn hududida qadim  zamonlarda…… singari turli qabilalar yashab kelgan ? 	 eroniylar va sosoniylar  	  giksoslar va subariylar    	  shaklar va durroniylar
541	10	 Midiya podsholigini	Qaysi davlatni bo'ysundurganidan so'ngra Кir II ulkan lashkar tuzdi vа bosqinchilik yurishlarini davom ettirdi?	  Ossuriya podsholigini  	  Xett davlatini  	  Воbil davlatini      
542	10	 Hindiston	Qaysi davlatda ilm – fan xususan , astranomiya  va matematika sohasi yuksak darajaga erishgan ?	  Xitoy 	  Eron  	  Baqtriya    
543	10	 Chandragupta 	Yunon- makedon qo’shinlariga qarshi kurashga  mashhur  hind sarkardasi kim boshchilik qilgan ?	   Ashoka   	  Lyu – Ban  	  U- Di
544	10	 xalq tribuni  	Rim respublikasida qaysi lavozim majlislarda barcha fuqarolarning teng va yashirin ovozi bilan saylanar edi?	  konsul    	  diktator    	   senator
545	10	  podsho hokimiyatining ag’darilishi         	Rim respublikasi asosini yaratgan omilni toping ?  	   xalq majlisining vujudga kelishi    	 aholining patrisiy va plebeylarga bo’linishi	   senatning vujudga kelishi             
546	10	 Pompey va Krass 	Spartak qo’zg’oloni bostirilib, tor-mor etilgandan keyin kimlar hokimiyat uchun ancha vaqt kurash  olib bordilar ?   	  Sezar va Pompey  	  Sezar va Brutt   	   Oktavian va Antoniy   
547	10	 XI asrda 	Novgorod nechanchi asrda vujudga kelgan  ?      	    XII asrda 	   XIV asrda 	   XIII asrda
548	10	 Florensiya 	Salyutati  qaysi  shaharda  yashagan  va  yuqori  lavozimlarga  ishlagan  ?	   Nieapol  	    Rim 	   Palermo 
549	10	 O’rxon   	Usmoniylarda kimning humronligi davrida vazir lavozimi ta’sis etiladi   ? 	  Boyazid         	   Usmon      	   Mexmet II
550	10	  50 ta    	Botuxon bosqini arafasida rusda nechta mustaqil knyazlik bor edi ?   	   20 ta     	   70 ta    	    30 ta
551	10	 XII – asr   o‘rtalarida  Shimoliy   Fransiyada 	Gotika  uslubi  qachon  va  qayerda   yuzaga  keldi  ?    	  XI – asr   oxirlarida  Janubiy  Fransiyada      	  XIII – asr   boshlarida  Shimoliy  Italiyada     	  X – asr  oxirlarida Italiyada
552	10	 aholi soninig ko’payishi   	Milodiy asr boshlaridan germanlar xo’jaligida dehqonchilikning ahamiyatini oshirgan omilni toping  ?	   ikki dalali almashlab ekish 	 temir plugdan foydalanish	  yerning xususiy mulkka aylanishi
553	10	 IV asrda  	Germanlarda  qachondan  boshlab  bahorgi  va  kuzgi  bug’doy  o’rnida  dukkakli  ekinlar  ekish  boshlangan  ?	  III  asrda 	  V asrda 	   VI asrda
554	10	 Kоnstаntinоpоl , Аlеksаndriya , Аntiохiya , Edеssа          	VI аsrdа Sharqiy Rim imperiyasida qaysi shaharlаr yirik savdo va hunarmandchilik markazlari sifatida    gullаb-yashnаgаn?	 Rim , Parij , London , Florensiya , Afina                   	 Konstantinopol , Bag‘dod , Qohira , Ederna , Rim           	   Damashq , Izmir , Afina , Sarayvo , Anqara
555	10	 534 – yil       	Yustinian I qachon   sarkarda   Velisariyni    ShimoliyAfrikadagi vandallarga   qarshi   yuboradi   ?	  561 – yil    	  530 – yil     	  527 – yil
556	10	 Otton III 	Kim butun xristian dunyosi Rim imperatori hukmida birlashishi  lozim deb hisoblagan  ?	  Buyuk Alfred   	   Otton I  	  Amvrosiy Avrelian
557	10	 Nishtadt   	Qaysi  shartnomaga  ko’ra Rossiya  Boltiq  dengiziga  chiqish  huquqiga  ega  bo’lgan  ?	  Kuchukqaynarji       	   Parij   	  London 
558	10	 Turkiya  	1683 - yili  Germaniya  knyazliklari  qaysi  davlat  bosqiniga  qarshi  kurashish  uchun  tarixda  birinchi  marta  yakdil  qaror  qabul  qildilar  va  milliy - ozodlik  qo‘shinini  tuzdilar  ? 	  Fransiya   	  Angliya     	   Rossiya 
559	10	 besh  kishi   	Fransiyada  Ijro  hokimiyati  Oqsoqollar  kengashi  tayinlaydigan  necha   kishidan  iborat  Direktoriyaga  topshirildi  ?  	  uch  kishi    	  to’rt  kishi    	  olti  kishi 
560	10	 Gabriel  de  Mirabo 	Quyidagi tarixiy  shaxslardan qaysi biri  Fransiya  yakobinchilarining   a’zosi  bo’lmagan  ?	  Robespyer   	  Marat   	   Danton   
561	10	 Misr   	1798 - yili  qayerga  qilingan  yurish  Napoleonni  siyosiy  hokimiyatni  egallashga  chorladi  ?	  Italiya  	  Turkiya 	   Rossiya 
562	10	 Taxmasp  I     	Humoyunga  1540 - yili  Hindiston  taxtdan  ag'darilgandan  so’ng  qaysi  Eron  hukmdori  saroyidan  panoh  topgan  ?	  Toxmasp II   	   Shoh  Ismoil  	   Mirzo  Husayn
563	10	 Yaponiya 	Qaysi  davlat  Xitoydan  ko’p  yangiliklarni  : yozuv  tizimini , moddiy  madaniyatning  ancha  qismini  qabul  qildi  ?	   Koreya   	  Vetnam  	   Hindiston 
564	10	 XVIII asr 	Qaysi  asr  Yevropa  tarixida  “ Marifat  asri “ nomi  bilan  kirgan  ?	   XVI asr   	  XVII asr   	  XV asr
565	10	 Xitoy  	Qaysi davlatda  XVI asr  davomida  xususiy  yerlar  kamayib  borgan  ?	  Yaponiya   	  Hindiston   	  Fransiya 
566	10	  Xitoy 	Qaysi davlatda  XVI – XVII asrlarda  Tasviriy   san’at  akademiyasi  qayta  tiklangan  ?	   Yaponiya   	  Hindiston  	   Fransiya 
567	10	 Pyer  Laval 	“ Xalq  frontidan ko’ra Gitler maqul “ – deya bayonot bergan  Fransiyadagi o’nglar yetakchisini belgilang ?	    E. Dalad’e  	  L . Blyum 	   Puankare  
568	10	 1928 yilda  	Tarixda ilk bor harakatlanuvchi tasvirni elektron – nurli trubka yordamida  masofaga uzatishni ixtirochilar  Boris Grabovskiy va  Ivan  Belyanskiy  qachon amalga oshirganlar ? 	  1924 yilda 	   1926 yilda 	   1927 yilda  
569	10	 30 –yillar oxiriga 	Qachonga  kelib rivojlangan davlatlar sanoatining  katta qismi elektrlashtirildi ?  	   80 – yillar  oxiriga  	  40 –yillar oxiriga  	   50 –yillar oxirlariga
571	10	 Chexoslovakiya 	1938 –yilda imzolangan Myunxen shartnomasi  Fransiyaning  qaysi davlatga nisbatan xiyonati edi ?	  SSSR   	  Buyuk Britaniya  	   Polsha 
572	10	 Kareliyani  Viborg  shahri bilan birga	1939 -1940- yillarda  sovet- fin  urushi bo’lib o’tdi va SSSR  juda katta yo’qotishlar bilan  qayerlarni  tarkibiga    qo’shib oldi ?	    Nishtad hududlarini                             	 Xelsinki hududlarini                            	    Fillandiyaning shimoliy qismini
573	10	 Minsk 	1991 –yil  8- dekabrda  qaysi shaharda  Mustaqil Davlatlar Hamdo’stligi tuzilganligi  e’lon qilindi  ?	  Kiyev 	   Moskva 	   Toshkent 
574	10	   1975 –yil   	Qachon Yevropada  Xavfsizlik va hamkorlik kengashining   Yakunlovchi akti imzolandi . Bu hujjat shartnoma emasdi , ammo katta axloqiy – siyosiy  ahamiyatga  ega bo’ldi , zotan u xalqaro  munosabatlarda  yangi taraaqiyparvar  normalarni o’rnatdi ?   	   1972 –yil    	  1974 –yil   	  1971 –yil   
575	10	 Jeneva  va  Reykyavik     	SSSR va AQSH o’rtasidagi keslinlikni yumshatish uchun  SSSR va AQSH liderlari  M .S . Gorbachev va  R.Reyganning  1980 yillarda qayerlarda uchrashuv  o’tkazganlar ? 	  Moskva va Minsk  	  London va  Parij     	   London va Vashington
576	10	 1933 - yil 	Germaniyada  qachon  A. Gitlar boshchiligida  natsional – sotsialistik  ishchi partiyasi hokimiyat  tepasiga keldi ?	   1931 –yil  	  1932 –yil   	  1935 –yil   
577	10	  1999 – yil 	Qachon  Nato qo’shinlari  Yugoslaviyani bombardimon qilgan ?   	  2000 – yil 	   2001 - yil 	  2002 – yil
578	10	 Moldova 	Quyidagi davlatlardan qaysi biri  1991 – yil 27 - avgustda  o’z mustaqilligini  e’lon qilgan  ?	   Belarus  Respublikasi   	  Ukraina   	   Ruminiya
579	10	 1991 – yil  mart oyida   	Rossiyada qachon  Federativ  shartnoma  imzolanib ,  Tatariston va Chechenistondan  tashqari  barcha subyektlar tomonidan  imzolandi ?	  1992 – yil mart  oyida  	   1992 – yil fevral oyida  	   1992 – yil avgust oyida
580	10	 2009 – yilda   	AQSH prezidenti  Barak  Obamaga  Nobel tinchlik  mukofoti qachon  berilgan   ?   	  2008 – yil   	  2010 – yil   	  2007 – yil  
581	10	  1987 – yili  	Qachon  Yevropa Iqtisodiy  Hamkorlik tashkilotini  YIga  aylantirish bilan  u “ ichki chegarasiz  makon “ bo’lib   qoldi ?   	   1988 – yili  	   1989 – yil   	  1990 – yili
582	10	 2004 – yilda   	Boltiqbo’yi  davlatlari  NATOga va  YIga a’zo bo’lgan  yilni belgilang ?  	   2005 –  yilda    	   2007 – yil    	  2008 – yilda
583	10	 Tojikiston   	Qaysi davlatda  1994 – yil  6 – noyabrda    konstitutsiya qabul qilingan va  prezident saylangan ?	  Qozog’iston   	  Qirg’iziston  	  Turkiya
584	10	  A . Sipras   	2015 – yilgi saylovlarda  Gretsiyada  hokimiyat  tepasiga  kelgan qaysi shaxs  boshchiligidagi  so’llar  hukumati  mamlakatning qarzini kreditorlar  qo’ygan shartlar  bo’yicha uza olmasligini  e’lon qildi ?  	    A. Merkil  	    S. Alnas   	    D. Sapart
585	10	   Bratislava   	2016 – yil  sentabrda  qaysi shaharda  bo’lib o’tgan  YI rahbarlari  yig’ilishida  ilk bor  Buyuk  Britaniya  bosh vaziri  qatnashmadi ?  	  Parij  	   Lissabon    	   Kopengagen
586	10	 B. Klinton  	AQShning  qaysi prezidenti  “ yangi  iqtisodiy  falsafa “ deb nomlangan  dasturni ilgari surgan ?	   J. Bush   	   B. Obama 	  D. Tramp
587	10	 Mezolit davri oxirida	Qaysi davrda Old Osiyoda xo‘jalikning yangi tarmoqlari - ibtidoiy ziroatchilik va chorvachilik vujudga keldi?	 Mezolit davri boshida  	 Neolit davri oxirida	 Neolit davri boshida    
588	10	 Temir davri boshida	Qachon O‘rta Osiyo aholisi to‘rt guruhga bo‘linadi? 	 Bronza davri oxirida	 Temir davri oxirida	 Temir davri o‘rtalarida
589	10	 Mil. avv. IX -VIII asrlar 	O‘rta Osiyodan topilgan ilk temirdan yasalgan buyumlar nechanchi asrlarga oid? 	 Mil. avv. VIII-VII asrlar	 Mil. avv. VI-V asrlar	 Mil. avv. VII-VI asrlar    
590	10	 Mil. avv. VII asrlarda    	Qadimgi Baqtriya davlati qachon tashkil topgan?  	 Mil. avv. VIII asrlarda	 Mil. avv. VI asrlarda	 Mil. avv. IX asrlarda     
591	10	 Qashqadaryo	Yerqo'rg'on va Uzunqir shaharlari qaysi viloyatda joylashgan?  	 Surxandaryo  	 Samarqand                 	 Xorazm                              
592	10	 Anaxita      	Zardushtiylik dinida hosildorlik va suv ilohasi?  	 Mitra                  	 Ahriman	 Ahuramazda    
593	10	 Mil. avv. III asr	Zardusht va'zlari matnlarining hammasi qachon 21 kitobga jamlangan?   	 Mil. avv. IV asr     	 Mil. avv. IX-VIII asrlarda    	 Mil. avv. II asr     
594	10	 dehqon           	Ilk o`rta asrlarda mulkdor tabaqani anglatuvchi atama berilgan javobni toping.	 kadivar  	 koshavarz       	 chokar
595	10	 shod 	Turk xоqоnligida o`n ming qo`shin qo`mоndоni qanday atalgan? 	 jabg`u  	 tumanboshi	 yabg`u  
596	10	 Farg`ona	Quyidagi mahalliy hokimliklardan qaysi biri qo`shni mamlakatlarga bo‘yoq, rangli shisha buyumlar va dori-darmonlar chiqargan? 	 Ixshid 	 Samarqand   	 Toxariston    
597	10	 buddaviylik	O`rta Оsiyoda haykaltarоshlik rivоjiga qaysi din kuchli ta`sir ko`rsatgan? 	 qam(shomonlik) 	 moniylik        	 zardushtiylik  
598	10	 g`oziy  	Haq din uchun kurashuvchi jangchi ma`nosini anglatuvchi atamani aniqlang  	 najjor  	 saffoh	 saffor  
599	10	 XI asrda	Qachondan boshlab yerdan foydalanishda iqto tartiboti juda keng yoyiladi?  	 IX asrda	 XII asrda	 X asrda
600	10	 Qutbiddin Muhammad   	Kimning davrida «Xorazmshoh» unvonini qayta tiklangan?  	 Anushtegin   	 Elarslon	 Otsiz             
601	10	 «Ravzat us-safo	Quyidagi asarlardan Mirxond qalamiga mansub asarni aniqlang.  	 «al-Komil¬fit-tarix» («Tarix haqida mukammal kitob»)	 «Siyrat as¬sulton Jalol ad¬Din Mengburni»	 «Tarixi jahonkushoy» («Jahon fotihi tarixi»)
602	10	 Ibn Xaldun 	Kimning ta`kidlashicha Amir Temur turk, arab, fors xalqlari tarixini chuqur o`rgangan, diniy, dunyoviy va falsafiy bilimlarning eng murak kab jihatlarigacha yaxshi o`zlashtira olgan zot ekan?	 Ibn  Arabshoh  	 An-Nasaviy	 Ishtaxriy            
603	10	 Ahmad al-Farg`oniy    	«Samoviy harakatlar va umumiy ilmi nujum»asarining muallifi berilgan javobni aniqlang .	 Al-Xorazmiy           	 Al-Buxoriy	 Abu Nasr Farobiy    
604	10	 Abulxayrxon        	1451-yilda katta qo`shin bilan Abu Said yordami va ishtirokida Toshkent, Chinoz va Jizzax orqali Samarqandga Mirzo Abdulloga qarshi yurish qilgan shaxsni aniqlang 	 Ubaydullaxon 	 Shohbudoq	 Shayboniyxon      
605	10	 Abu Nasr Farobiy     	«Fozil odamlar shahri» asarining muallifini aniqlang.         	 Abu Rayhon Beruniy	 Abu Ali ibn Sino 	 Muhammad ibn Muso al-Xorazmiy    
606	10	 1533-1536-yillarda	Qaysi yillarda Ubaydullaxon Mir Arabga bag'ishlab Buxoroda uning nomi bilan mashhur madrasa qurdirgan?  	 1536-1539-yillarda	 1530-1536-yillarda    	 1533-1539-yillarda     
607	10	 Andijon va Axsi    	Bobur Mirzoning yoshlik yillari qaysi shaharlarda o`tgan. ? 	 Axsi va Namangan  	 Andijon va Samarqand	 O`sh va Toshkent  
608	10	 Anushaxon   	Buxoro xonligida ashtarxoniy Subxonqulixon hukmronligi davrida qaysi Xiva xoniga Samarqandda xutba o`qilib, uning nomidan tanga pullar zarb etildi?  	 Elabrsxon                        	 Abulg`oziyxon	 Muhammad Aminxon     
609	10	 Badaxshonot va Kobulga	Og‘ir va nochor ahvolga tushib qolgan Bobur Mirzo Samarqandni tark etib, ko‘p mashaqqatlarni boshdan kechirib, o‘zga yurtlarga ketishga majbur bo‘ldi. Bobur Mirzoning qizi Gulbadanbegim o‘zining ,,Humoyunnoma“ asarida bu haqda quyidagilarni yozgan edi: „Xudoga tavakkal qilib ….  va …. yuzlandilar“.  	 Badaxshonot va Andijonga	 Balx va Hirotga       	 Buxorova Kobulga    
610	10	 Ubaydullaxon II    	Quyidagi qaysi hukmdor yirik yer egalari hamda Jo‘ybor shayxlarining soliq to‘lamaslik imtiyozidan mahrum etdi? 	 Abulfayzxon  	 Nodir Muhammad	 Subhonqulixon      
611	10	 dodxoh 	Buxoro xonligida Shayboniylar sulolasi humkronligi  davrida mamlakatda adolat mezonlariga amal qilinishini quyidagi qaysi lavozim egasi nazorat qilgan?  	 otaliq   	 ko`kaldosh	 parvonachi          
612	10	 suyurg’ol	Yer egaligining qaysi shakli dastlab xonga uning egalarini itoatda tutib turishning kuchli vositasi bo'lib xizmat qildi?  	 tanho	 mulk	 mamlakai sulton
613	10	 Pyotr I	Buxoroni siyosiy jihatdan Rossiyaga teng emas, deb unga tazyiq o’tkaza boshlagan Rossiya hukmdorini aniqlang.  	 Aleksandr I	 Nikolay II	 Mixail Romanov
614	10	 Chanoh	Shayboniylar davrida  ... qo‘shinning o‘ng va chap qanotlarini qo‘riqlovchi maxsus qism edi.     	 Katta va kichik g'ullar  	 hirovul	 Sarkarda   
615	10	 Bedil   	«To`rt unsur» asari muallifni aniqlang ?  	 Sayido Nasafiy      	 Abdurhmon Tole	 Turdi Farog`iy       
616	10	 1821-yil 	Qachon Miyonqolda Buxoro amirligiga qarshi qo`zg`alon bo`lib o`tdi?   	 1819-yil 	 1826-yil	 1824-yil 
617	10	 Marza                 	Buxoro amirligida 300 tanob va undan kam yeri bo‘lgan hudud, aholi yashasa-yashamasa, qanday atalardi?           	 Qoriya	 Hazora	 Qishloq obikori   
618	10	 Bosh inoq    	Qaysi lavozimga tayinlangan amaldor amirning buyruqlarini quyi lavozimda ishlayotgan davlat xizmatchilariga yetkazish, mazkur buyruqlarning bajarilishini va kelgusida davlat mansablariga tayinlanishi mumkin bo'lgan xizmatchilarning faoliyatini tashkil etish bilan shug‘ullangan?	 Mehtar	 Kichik inoq	 to'qsoba       
619	10	 Qo’sh puli	Uning miqdori yer haydashga yaroqli har juft ho`kiz hisobidan kelib chiqib belgilangan. Gap qaysi soliq haqida ketmoqda?  	 Tanobona   	 Tutun haqi	 Zakot            
620	10	 Shug'ovul	Buxoro amirligida qaysi lavozimdagi kishi chet mamlakatlar elchilarining qabul qilinishini tashkil etuvchi hisoblangan?  	 Qutvol	 Mehtar      	 Ko'kaldosh   
621	10	 To’pchiboshi   	Amir davlat boshlig‘i sifatida amirlik qo‘shinining oliy bosh qo'mondoni edi. Undan keyingi o‘rinda vaziri harb (harbiy vazir) turgan. U qo‘shinning Bosh qo‘mondoni sanalgan va yana qanday nom bilan atalgan?  	 To’pchilashkar	 Mingboshi	 Amirlashkar    
622	10	 Mirzo Shams Buxoriy     	«Bayoni ba`zi havodisoti Buxoro, Ho`qand va Qoshg`ar» asari muallifini aniqlang ?	 Muhammad Hakimxon   	 Mahmud  At-Tabariy	 Mir Olim Buxoriy   
623	10	 Alouddin Otamalik Juvayniy            	“Tarixi Jahonkushoy” asari kimga tegishli?  	 Abu rayhon Beruniy   	 Mahmud  At-Tabariy	 Muallifi nomalum
624	10	 Niyozbek   	Quyidagi qaysi qo’rg’on Toshkent darvozasi deb nom olgan?  	 Turkiston     	 Chimkent	 Oqmachit   
625	10	 1847-1865-yillar   	Rossiya tomonidan O’rta Osiyoning bosib olinishining I-bosqichi qachon bo’lib o’tdi?	 1865-1868-yillar   	 1880-1885-yillar	 1873-1879-yillar   
626	10	 Turdi Ali              	Qo’qon xonilidagi eng mashhur xattot kim edi?  	 Shirin Murodov	 Mirzo Mahmud	 Nurmuhammad    
627	10	 A.Fitrat     	“Tarix millatning o’tmishi taraqqiyoti hamda tanazzuli sabablarini o’rganaturg’on ilmdir” ushbu so’zlar muallifini aniqlang?  	 M.Behbudiy	 Q.Niyoziy	 M.Qori
628	10	 1917-yil 7-aprelda / 9-kishi       	Turkiston o’lkasini boshqarish uchun Komitet qachon tuzildi va uning tarkibi necha kishidan iborat edi?  	 1918-yil 7-aprelda / 8-kishi	 1919-yil 27-aprelda / 9-kishi	 1917-yil 17-aprelda / 9-kishi     
629	10	 Islom Sulton Shoahmedov  	Turkiston Muxtoriyatining bosh vazir o’rinbosari etib kim tayinlanganligini aniqlang? 	 Hidoyatbek Yurug’li Agayev	 Abdurahmon O’razayev	 Solomon Gersfeld  
630	10	 Bobooxun Salimov	1917-yil 8-aprelda mamlakatni boshqarish uchun Xivada xon huzurida kim boshchilikida Majlis tashkil etiladi?    	 Husaynbek devonbegi Matmurodov	 Mirbadalov	 Polvonniyoz Yusupov
631	10	 Buxoro, Karmana va Nurota	Mulla Abdulqahhor rahbarligida qaysi viloyatlarda o‘nlab qo‘rboshi guruhlari faoliyat  ko‘rsatdi ?	 Samarqand, Xiva va Karmana	 Buxoro va Nurota	 Buxoro, Xiva va Karmana
632	10	 1990-yil 20-iyun	... kuni O‘zbekiston SSR Oliy Kengashining II sessiyasida O‘zbekiston SSRning Mustaqillik Deklaratsiyasi qabul qilindi.  	 1991-yil 20-mart	 1991-yil 13-iyun	 1990-yil 23-aprel
633	10	 Abdulhoshim Mutalov	O‘zbekistonda Bosh vazir lavozimida 1992–1995-yillarda kim faoliyat ko’rsatgan?	 Oʻtkir Sultonov  	 Shavkat Mirziyoyev	 Shukrullo Mirsaidov 
634	10	 1992-yil	..…da O‘zbekiston Respublikasi Prezidentining farmoni bilan Milliy xavfsizlik xizmati tasarruf da Chegara qo‘shinlari boshqarmasi tashkil etildi. 	 1993-yil 	 1991-yil	 1994-yil 
635	10	 25 yosh  	Necha yoshga to’lgan fuqarolar Oliy Majlisga saylanishi mumkin?	 35 yosh	 18 yosh	 21 yosh
636	10	 101-moddasida	O’zbekiston Konstitutsiyasining nechanchi moddasida hokimlar vakolati haqida ma’lumot berilgan?	 100-moddasida	 103-moddasida	105-moddasida
637	10	Avesto	O’rta  Osiyo tarixiga oid eng muhim manba qaysi?                                                                           	Rigveda 	Marhumlar kitobi	Bibilya
638	10	1,2,3   	Behistun yozuvlarida Orta Osiyodagi qaysi davlatlar sanab o’tilgan haqida yozilgan ? 1.Xorazm      2.Baqtriya    3.So’g’d    4.Qang’                        	2,3,4    	1,3,4  	2.4
639	10	2014-yilning 15–16-may kunlari Samarqandda	Buyuk   alloma   va   mutafakkirlarning   ilmiy   merosi   va uning zamonaviy sivilizatsiya tarixida tutgan o‘rni va roliga bag‘ishlanib  qachon  va  qayerda xalqaro konferensiya o‘tkazildi?                                               	2013-yilning 15–16-may kunlari Toshkentda   	2015-yilning           15–16-may kunlari Buxoroda 	2016-yilning 15–16-may kunlari Xivada                                                                                      
640	10	O’zlashtiruvchi xo’jalik   	Qadimgi odamlarning dastlabki mashg’ulotlari bo’lgan termachilik va ovchilik   nima deb atalgan ?                                                                                                                                           	Mehnat  xo’jaligi                                                                           	Dehqon xo’jaligi                           	Mehnat  jamoasi 
641	10	tosh asriga mansub 8-9 yashar bolaning suyak qoldiqlari	Teshiktosh g’oridan qazib olingan eng mashxur topilma nima ?  	hayvon va qush suyaklari    	tosh qurollar               	gulxan qoldiqlar
642	10	Zarafshon	Dehqonlarning qadimgi manzilgohlaridan biri bo’lgan Zamonbobo ko’li yaqinidan topilgan qadimiy manzilgoh qaysi daryo havzasidan topilgan?	Sirdaryo	Amudaryo	Qashqadaryo
643	10	1,3,4	Ilk o’rta asrlarda qaysi yangi tabaqalar shakllandi?                1. dehqon, 2.muzoriy, 3.kadivar, 4.kashovarz, 5.iktodor, 6.guvokor, 7.vagnpat                                                                                                                   	1,2,5   	3,4,6,7    	2,3,4,6   
644	10	552-yilda   	Bumin qachon  “xoqon” deb e’lon qilindi?                                                                                         	550-yilda	556-yilda  	563-yilda                                                                                                                                                      
645	10	paxta va sholi	Farg‘ona yerlari juda hosildor bo‘lib, aholisi dehqonchilik bilan kun kechirgan, va asosan qanday ekinlar  ekkanlar?    	sholi va bug’doy	bug’doy va arpa   	sholi va javdar         
646	10	Rabot	Shaharning tashqi mavzeyi nima deb atalgan?                                                                                  	Ko‘handiz  	Shahriston	Handaq
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (id, created_at, main_photo_id, description, title) FROM stdin;
1	2025-04-03 12:23:28.830866	6b551641-1630-4f41-aa50-1855ff307adc	May this pious day brings you immense joy, happiness, peace and prosperity.\n\nWishing you a very Happy Eid al-Fitr!	🌙Eid al-Fitr Mubarak!
2	2025-04-03 12:46:53.801692	f829e1af-ff16-4929-956b-0edbcf76b629	You can choose one of three directions:\n✅Artificial intelligence\n🤖Robotics\n💎Cybersecurity\n\nRector’s Cup-2025 is a great opportunity to prove yourself and improve your skills in artificial intelligence, robotics, and cybersecurity. This is also a chance to win valuable prizes from our sponsors⭐️\n\nRules:\n✅Each team must consist of no more than 3 people\n✅ Pre-registration with team information is required.\n\n🗓Date: April 19-21, 2025.\n📍Location: Inha University in Tashkent\n➡️Registration deadline: April 13th\n\nHurry up and register: //forms.gle/7vUvB8hkNtywaLMZ6\n\nFollow our updates, soon we will tell you more about this hackathon ▫️\n\nAny questions?\nWrite to us: careercenter@inha.uz.	We are pleased to invite Inha students to participate in the Rector’s Cup-2025 hackathon!
5	2025-04-03 13:25:49.765742	7dd11b24-c7c5-4cc1-81d3-3c64ae405c2c	20-mart kuni INHA & IT Park CUP Hackathon 2025 finali bo‘lib o‘tdi! Uch kunlik qizg‘in mehnat, g‘oyalar yaratish va innovatsion yechimlarni ishlab chiqish ishtirokchilarni uzoq kutilgan lahzaga – eng yaxshi jamoalarni taqdirlashga olib keldi.\n\n   \nINHA & IT Park CUP Hackathon 2025 shunchaki musobaqa emas, balki IT sohasida yosh iste’dodlarni rivojlantirish uchun haqiqiy platformaga aylandi. Ishtirokchilar mamlakatning raqamli kelajagini o‘zgartira oladigan yechimlarni yaratishga qodir ekanliklarini isbotladilar!\n\n   \nG‘oliblarni tabriklaymiz va barcha ishtirokchilarga tirishqoqligi, jasorati va innovatsiyalarga intilishi uchun minnatdorchilik bildiramiz! 💙	🏆 INHA & IT Park CUP Hackathon 2025 finali:
6	2025-04-03 13:34:43.002566	d2f80f9a-8807-4a20-b00d-b4046e3f344a	Google, Microsoft, Samsung kompaniyalarida karyera qurmoqchimisiz yoki o‘z startapingizni yaratmoqchimisiz? Toshkent shahridagi Inha universitetida biz nafaqat ta’lim beramiz, balki sizning IT sohasidagi kelajagingizni yaratamiz.\n\nKompyuter va dasturiy injiniring yo‘nalishi (SOCIE) – muvaffaqiyatli karyera sari birinchi qadam\nSOCIE fakultetida o‘qish orqali siz nafaqat Kompyuter va dasturiy injiniring sohasidagi fundamental bilimlarga, balki raqobatchilar orasida ajralib turishga yordam beradigan bebaho amaliy tajribaga ham ega bo‘lasiz.\n\nO‘qish davomida sizni nimalar kutmoqda?\n🔽 Ta’lim berishda jahon darajasi – yirik IT-kompaniyalarda haqiqiy ish tajribasiga ega bo‘lgan xorijiy va mamlakatimiz mutaxassislari\n🔽 Eng so‘nggi texnologiyalardan foydalanish imkoniyati\n🔽Hamkor kompaniyalardan loyihalar, amaliyotlar, real IT-keyslarda ishtirok etish\n🔽O‘z g‘oyalaringizni ro‘yobga chiqarish – startaplar yaratish, xakatonlar va akseleratsiya dasturlarida ishtirok etish imkoniyati\n✓ Yorqin talabalik hayoti – sport turnirlari, musiqa festivallari, kibersport musobaqalari va boshqalar\n\n🔹Yuqori texnologiyalar olamiga eshik ochayotgan Inha universitetiga qo‘shiling!\n\n🖱 Ro‘yxatdan o‘tish boshlandi: admissions.inha.uz\n🗂 Qabul tartibi: //inha.uz/prospective-students/admissions/application-guideline/\n✈️Murojaat uchun telefon: 71 289 99 94 @askinhabot	IT SOHASIDAGI KELAJAGINGIZ IUT BILAN BOSHLANADI!
\.


--
-- Data for Name: news_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_photos (news_id, photos_id) FROM stdin;
1	35499acd-0adb-4961-b1d7-8072c8129132
1	43ba74cb-f93e-40e4-a790-7450b3d18ea6
1	bac0e936-1827-4d99-8681-8143b54e8b02
2	ecea52f8-01fc-440f-8ee4-5c8167c36cff
2	c68bdd59-4ef8-4ca3-9ce5-2a196d726990
5	21449789-7a3a-4d2f-bf50-d3d5b8ad5b91
5	613cb110-068a-4c4d-abb3-7a5463ff9015
5	3d786312-b4f7-44c8-99e0-0f0a2a1a3483
6	ad471c61-c8ea-4f01-ada2-a3ee3347e087
6	fc4499f3-2b25-431f-9163-f64fa397bf20
\.


--
-- Data for Name: newspaper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newspaper (id, created_at, main_photo_id, description, title) FROM stdin;
3	2025-03-28 11:55:00.87564	ad491ef1-3685-47d5-8fac-48b9744f1d13	2025-03-12	erferf kitob
\.


--
-- Data for Name: newspaper_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newspaper_photos (newspaper_id, photos_id) FROM stdin;
3	cc631b0b-3e35-43a1-a493-c09cafb79199
\.


--
-- Data for Name: nomenklatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nomenklatura (id, number_packages, user_id, created_at, code, name) FROM stdin;
1	2	170	2025-04-01 10:33:39.590784	01	hhjhjh
\.


--
-- Data for Name: nomenklatura_file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nomenklatura_file (folder, id, nomenklatura_id, created_at, file_id, description) FROM stdin;
\.


--
-- Data for Name: rank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rank (id, created_at, name) FROM stdin;
1	2025-02-22 12:09:46.852654	Rektor
2	2025-02-22 12:09:46.854048	Ish boshqaruvchi
3	2025-02-22 12:09:46.854595	Buxgalteriya
4	2025-02-22 12:09:46.855112	Registrator ofisi
5	2025-02-22 12:09:46.855623	Yoshlar masalalari, ma'naviyat va ma'rifat ishlari bo'yicha birinchi prorektor
6	2025-02-22 12:09:46.856214	O'quv ishlari va ilmiy innovatsiyalar bo'yicha prorektor
7	2025-02-22 12:09:46.856671	Kadrlar bo'limi
8	2025-02-22 12:09:46.857096	Yoshlar bilan ishlash, ma'naviyat va ma'rifat bo'limi
9	2025-02-22 12:09:46.857553	Doktorantura bo'limi
10	2025-02-22 12:09:46.857945	Sirtqi bo'lim boshlig'i
11	2025-02-22 12:09:46.858333	O'quv ishlari va magistratura bo'lim boshlig'i
12	2025-02-22 12:09:46.85883	Axborot-resurs markazi
13	2025-02-22 12:09:46.859299	Psixologiya va xorijiy tillar fakulteti dekani
14	2025-02-22 12:09:46.85973	Psixologiya kafedrasi mudiri
15	2025-02-22 12:09:46.860143	Psixologiya kafedrasi professor-o'qituvchilari
16	2025-02-22 12:09:46.860591	Filologiya kafedrasi mudiri
17	2025-02-22 12:09:46.861063	Filologiya kafedrasi professor-o'qituvchilari
18	2025-02-22 12:09:46.861542	Pedagogika va umumiy fanlar kafedrasi mudiri
19	2025-02-22 12:09:46.862034	Pedagogika va umumiy fanlar kafedrasi professor-o'qituvchilari
20	2025-02-22 12:09:46.862497	Doktorantlar
21	2025-02-22 12:09:46.862963	1 - kurs Magistrlar
22	2025-02-22 12:09:46.86358	2 - kurs Magistrlar
23	2025-02-22 12:09:46.864074	1 - kurs Bakalavr (kunduzgi)
24	2025-02-22 12:09:46.864554	2 - kurs Bakalavr (kunduzgi)
25	2025-02-22 12:09:46.865004	3 - kurs Bakalavr (kunduzgi)
26	2025-02-22 12:09:46.866026	4 - kurs Bakalavr (kunduzgi)
27	2025-02-22 12:09:46.866481	1 - kurs Bakalavr (Sirtqi)
28	2025-02-22 12:09:46.866945	2 - kurs Bakalavr (Sirtqi)
29	2025-02-22 12:09:46.867394	3 - kurs Bakalavr (Sirtqi)
30	2025-02-22 12:09:46.867842	4 - kurs Bakalavr (Sirtqi)
31	2025-02-22 14:49:31.893607	Admin
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region (id, name) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name) FROM stdin;
1	ROLE_ADMIN
2	ROLE_STUDENT
3	ROLE_COMPANY
4	ROLE_USER
5	ROLE_TEACHER
6	ROLE_ADMINISTRATOR
7	ROLE_RECTOR
8	ROLE_GENERATOR
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (id, score, created_at, file_id, fcm_token, name, passport_number, passport_pin, password, phone, telegram_id) FROM stdin;
3	100	2025-02-22 12:21:30.820371	\N	\N	AKRAMOVA SURAYO RENATOVNA	AB3895817	43003841070112	$2a$10$hTDmmHY5oEVWqR4tr6e/8OPlJQLr/g5fUTL/klPwlgkdRaTc3on7C	43003841070112	0
4	100	2025-02-22 12:21:30.882071	\N	\N	SOBIROVA DILAFRUZ ABDUROZIQOVNA	AD3288319	41401761050043	$2a$10$x8jOSEyw/.QhOPWU92bv5uIC0zUX0bWRpizLrh35yQD2t1MnfWNyq	41401761050043	0
5	100	2025-02-22 12:21:30.943641	\N	\N	HAYDAROVA NODIRABEGIM AHTAMJON QIZI	AB1179860	41509911050045	$2a$10$1.E0F0tBz.ZHMDR163RdzOSUY.ZoCcmcneKxsPVQCBQQaM3qB8b5a	41509911050045	0
6	100	2025-02-22 12:21:31.005136	\N	\N	KARIMOV JAMSHID TO‘LQIN O‘G‘LI	AD4501896	32201965350037	$2a$10$9O7Psppj2njOGQXIvYnIz.dAdPZvo2nm7.BMQtZniTDDViC9GxkoW	32201965350037	0
7	100	2025-02-22 12:21:31.066256	\N	\N	JUMAYEVA MEHRIBO ABDUVOHITOVNA	AB1960741	41803841070013	$2a$10$zorIdYo06pliXb65T575COawrAquS3JSO2JirRb800GEStbih.LV6	41803841070013	0
8	100	2025-02-22 12:21:31.132114	\N	\N	KAXAROVA DILDORA SIDIKOVNA	AD3779802	40606790930019	$2a$10$KlAn8k45OFOvly8uB27Xpu23NKrCsOZAY6zvlPMSmar3BjDNiVpBe	40606790930019	0
9	100	2025-02-22 12:21:31.195127	\N	\N	UMAROVA ZEBINISO NIZOM QIZI	AD1165198	40602975300013	$2a$10$78gO5R7.ztqWW.c3Bi7Ak.G5R9lu58.leNnUeYvZySnERvynoHghi	40602975300013	0
10	100	2025-02-22 12:21:31.25781	\N	\N	ALIMOV A’ZAM ANVAROVICH	AD0674209	31907851080013	$2a$10$vC4u8oWknKAXeCnKOHcHnOg/nFCUUxvr7VxcWq34GsJkvgNTZwV2i	31907851080013	0
11	100	2025-02-22 12:21:31.320707	\N	\N	NURULLAYEV BOBIRSHOX GAYBULLAYEVICH	AD8057750	30205780920028	$2a$10$iGXAqQlG3YdnTH9zFM5L3OWtxNbEBfLv2ZPkzcjdDogxJDLFHsipm	30205780920028	0
12	100	2025-02-22 12:21:31.38319	\N	\N	RAHIMOV OLIM HAMITOVICH	AD1144297	30112750970012	$2a$10$0TRir/1luzk2Gzol9NCXh.OyKxOlW.2xXn/CBvtsIdIA7sfpPr8Mm	30112750970012	0
13	100	2025-02-22 12:21:31.446617	\N	\N	TASHOV XUDOYNAZAR RAMAZONOVICH	AD1150058	31711601050012	$2a$10$KZjClhOfLm8w9GECBq.nn.puO55oGhSB1/8muW/Do67MYsqa1wYfa	31711601050012	0
14	100	2025-02-22 12:21:31.512131	\N	\N	SOBIROV ABDULAZIZ ABDUROZIQOVICH	AC2731120	31303861050011	$2a$10$qksCnvWW4fi9IkP3EvRYl.YzOQhr8Ay2J7knrHGpRp8lmxNR5NwtK	31303861050011	0
15	100	2025-02-22 12:21:31.573837	\N	\N	QO‘YLIYEV ULUG‘BEK RAVSHANOVICH	AA5463549	31811931010019	$2a$10$SVRpoNCeQgrUMjHUGDzifuCKrQn9HcVh3dRFp7Oy/lYkP8mhyfDDe	31811931010019	0
16	100	2025-02-22 12:21:31.633822	\N	\N	YARASHOV MARDON JOBIR O‘G‘LI	AB5682085	32611911110017	$2a$10$Dj41lhMI5IjYDHbOzXBP0.9mDmVdbtilMDKrlWVg5Qtq10dapy8Py	32611911110017	0
17	100	2025-02-22 12:21:31.695464	\N	\N	BOBOMURODOV RAXMON QO‘ZIYEVICH	AB1405914	30701721050017	$2a$10$mWcjBMcFyc/lYkzNxvg6v.aFAP38rExDOj0QcKZyJ1bqtwgKWhX7C	30701721050017	0
18	100	2025-02-22 12:21:31.755739	\N	\N	BOLTAYEV SHAVKAT SHARIPOVICH	AB9120168	32608800920015	$2a$10$ObNiJtWnbKh7XRHxj9LSs.Eu5mWROzHF7MztlTeEXvS41PNPmT52m	32608800920015	0
19	100	2025-02-22 12:21:31.817256	\N	\N	ELOV ZIYODULLO SATTOROVICH	AD4220172	32509871120011	$2a$10$ijEGJSdttxDpcph86yv8Ke62qlzJUlaZiNvm3rc3DJOkLlTAW9KoK	32509871120011	0
20	100	2025-02-22 12:21:31.878786	\N	\N	OLIMOV LAZIZ YARASHOVICH	AB1420179	32801825310036	$2a$10$iEjREgjymJ5.6iQwPKX6kOEBw4EWc1ftPd3QNDBR5BTMUT3NneC1C	32801825310036	0
21	100	2025-02-22 12:21:31.940598	\N	\N	BOBOYOROV SHERZOD SHUXRATOVICH	AA1809774	32408941050055	$2a$10$4wqGe0f3/5z9gnEndFnfmOkQNdqkp8Jm84IhNhKpXhC.IPnBUEFVe	32408941050055	0
22	100	2025-02-22 12:21:32.004273	\N	\N	GULOMOVA ZEBINISO XAMIDOVNA	AA9222262	41806815260018	$2a$10$EqWarsEJ5S.V3ZTc3Khyde0DL1suAMB4l5I1a./akm3f9H7jWdgA2	41806815260018	0
23	100	2025-02-22 12:21:32.067923	\N	\N	AXMEDOV JAHONGIRBEK G‘ANIJON O‘G‘LI	AD7019125	31309921070030	$2a$10$.g.A8hnQwQWYSuix7jetpuNDpHKhj9Bq9oEZKjyzjLeyiPzBUi.bG	31309921070030	0
24	100	2025-02-22 12:21:32.130497	\N	\N	KLICHEVA MARXABO ABDIRAXMANOVNA	AB2208149	43005720940017	$2a$10$YWE7sb1brwhYPX9APbjD8Ov5cfGd7AdLjvz4zFIDPvD73qMmScPly	43005720940017	0
25	100	2025-02-22 12:21:32.192161	\N	\N	NARZULLAYEVA GULCHEHRA SALIMOVNA	AA7551721	40110820960016	$2a$10$9Nm7KQJEa1GcnFGPyo5Emu9pYApSY6LzAC7eMp8uaTiaj3QlBcs3m	40110820960016	0
26	100	2025-02-22 12:21:32.253295	\N	\N	SHIRINOV ANVAR QANOATOVICH	AB2363187	32601791060032	$2a$10$CdHuP4G1wdfta//9G1k2LOo/1M3Sx9sWJhIRgce9bhA9IVFV0Sa16	32601791060032	0
27	100	2025-02-22 12:21:32.314796	\N	\N	OTAMURODOVA MAXSUNA ESHMURODOVNA	AB5160226	41405781080064	$2a$10$rtJg07zZdWEmkBNAPpxlDu2PWwWwC5We9GqA15o4BuyM.8huIeGty	41405781080064	0
28	100	2025-02-22 12:21:32.375966	\N	\N	MUXTOROV MUROD XXX	AD2419288	30705576590010	$2a$10$0JWz0qROpzupOIKh0HAV4..fsQtNK.Eni2/yXjqV/kh2l9NUnDpvi	30705576590010	0
29	100	2025-02-22 12:21:32.435883	\N	\N	SHONIYAZOVA IRODA MURADULLAYEVNA	AD3944563	41610883920017	$2a$10$3MMNV9HITJhR4ZURinl99.yKRmu7tHyIoiGNOkI3nf9T23hr6runq	41610883920017	0
31	100	2025-02-22 12:21:32.556837	\N	\N	HASANOVA ZEBO DAVLATOVNA	AB1338066	42401741050059	$2a$10$sSW.rEbMBCEAjdU2iF6skOGeL3RZUPaMXXCQy5zCth6ehpreLXQHC	42401741050059	0
32	100	2025-02-22 12:21:32.617892	\N	\N	SULTONOVA MEHRINISO SULAYMONOVNA	AD3488811	40504871140080	$2a$10$jyUBT.DnvxpktjurX2UJ4..8Sx29Yrbr6PUCbbWoqgAdUpAd0zvDe	40504871140080	0
33	100	2025-02-22 12:21:32.679476	\N	\N	RO‘ZIMURODOVA ZARIFA G‘AFUROVNA	AB0411632	42006901050030	$2a$10$3Cn4tkDpOgTDqLzoAoOVg.nXFlkNLaBpArBzJ3VRXsthHmu1v.JmG	42006901050030	0
34	100	2025-02-22 12:21:32.739632	\N	\N	LATIPOVA CHINNIGUL NASRIDDINOVNA	AB4748402	41705911050014	$2a$10$nDEK9mgYWLGVATUsllxSuufj9JUGFocBkMTK9BJLXiYFFn29AxikG	41705911050014	0
35	100	2025-02-22 12:21:32.800412	\N	\N	NAZAROV AKMAL MARDONOVICH	AD1039164	30207891000084	$2a$10$CZ4O.IKw3YHpcwDrdmpLQ.UyoBaAVb8ZjC80/.BJr3E4fEsqoWcLq	30207891000084	0
36	100	2025-02-22 12:21:32.861138	\N	\N	QOBILOVA NARGISABEGIM SULAYMONBEK QIZI	AD0821190	42809770920015	$2a$10$Go/HqXOyyE3QTHLLrix0jOmJA.UJwpCdsIdJzmkqp4nmGzG8OnPMO	42809770920015	0
37	100	2025-02-22 12:21:32.921783	\N	\N	RAJABOVA ZEBINISO AHMADOVNA	AB9752352	43012831110017	$2a$10$f24zXCWHDLeps2nT0NuABuRVIk2Oak8tpm67lmA2.DT8EQjqh4.1W	43012831110017	0
38	100	2025-02-22 12:21:32.982359	\N	\N	SHAROPOV JAMSHID DILMURODOVICH	AA6934940	31905891140049	$2a$10$Cfz3OaCHNwaSTRnvv9JY8O96akl5MOaRHjEQEcIi5xZLwsEEMWqaq	31905891140049	0
39	100	2025-02-22 12:21:33.043351	\N	\N	LATIPOV HAYOT RAMAZONOVICH	AD3002042	30504721120021	$2a$10$Vgxs4a1ocwNeFh5IzcMwE.tRn8Vtb1SKfMdO3.aD5DiaUkH9tK3Bm	30504721120021	0
40	100	2025-02-22 12:21:33.103971	\N	\N	FAYZULLOYEV OTABEK MUXAMADOVICH	AD3293853	32603770990017	$2a$10$n5tOhWrUACKT1RptyKNRNOddOn3RyzCf/gb3iIdQnoW.c9TwJWBji	32603770990017	0
41	100	2025-02-22 12:21:33.164988	\N	\N	KOBILOVA FERUZA TOLIBOVNA	AA8627481	41904810940011	$2a$10$ZmY1ShuHO05qMKqY0NLPq.ra7gb4kSwqAJ5jp/pUjRGyjq/cTDNtq	41904810940011	0
42	100	2025-02-22 12:21:33.227158	\N	\N	ABDULLAYEV AMRULLA NASULLAYEVICH	AD3346030	31102831120046	$2a$10$j60hNyLMrVor9jqF/0tU3OItjKWGObduozUUy3VFuPG74UAicFfkC	31102831120046	0
43	100	2025-02-22 12:21:33.289712	\N	\N	USMONOVA MARJONA ULUG‘BEK QIZI	AB5838018	62807005260099	$2a$10$NYSh3M/nPy8YFV1OK7gEd.NQARkGzOswPR800zKE.4Gzm8Ges1SZq	62807005260099	0
30	100	2025-02-22 12:21:32.496014	\N	\N	BARATOV SHARIF RAMAZANOVICH	AD3909779	32203600970019	$2a$10$M8znBzw75in9m5b6fKt5UuTSPEJ0yBWg/K6uui16vGxziSYOApslO	32203600970019	+998900900022
2	100	2025-02-22 12:21:30.758785	\N	\N	QURBONOVA O‘LMAS USMONOVNA	AD3471864	41811805350017	$2a$10$bFs9g0x0EEgriH7jp2ptE.UEfur9Xqo8848962ikyRvhndBPhOEr2	2222	+998323232233
44	100	2025-02-22 12:21:33.35281	\N	\N	XALILOV BEKZOD JOBIR O‘G‘LI	AC0556761	50104025250011	$2a$10$Cf66QATCjaWb4XpPiqG3b.v4D/Iyar1NLIDlqiV0Rxtze.a7DhrIy	50104025250011	0
45	100	2025-02-22 12:21:33.41756	\N	\N	AKMURODOVA DILNAVOZ TAG‘ANOVNA	AD3232063	43003715280010	$2a$10$z4SUrv1wbQWMnLpMGj88j.mX0IOitGmKP2GfmJTo7hdaA4FfSTbmG	43003715280010	0
46	100	2025-02-22 12:21:33.481622	\N	\N	BAROTOVA NIGINA SHAROFOVNA	AA3051879	41207901140029	$2a$10$HxYoGVH.rClkcXxlwq8c6OZLYtIb768QnqqnBUfto1BNea3w0JJ02	41207901140029	0
47	100	2025-02-22 12:21:33.543218	\N	\N	RAVSHANOV MUXRIDDIN RASUL O‘G‘LI	AA7035032	30511975780019	$2a$10$Omfr0tIuHGgI6bOxk5VdEeZOngHbGEZ6QIn4EJYNtgfxZGq91eBha	30511975780019	0
48	100	2025-02-22 12:21:33.605468	\N	\N	MURODOV GAYRAT XXX	AB0115462	30303561160013	$2a$10$q18nODQW/3eNdwjuPGPS2.Mph8JdKkd0T0K9/HaZBx.t/KruMog3m	30303561160013	0
49	100	2025-02-22 12:21:33.666482	\N	\N	HAMROYEVA SABINA G‘ANIYEVNA	AD3851682	42012881110026	$2a$10$M3d9uWiFnx0zP97guAB3u.OVaBus3sg7Sm0taekgWfwvlCeCh7BWW	42012881110026	0
50	100	2025-02-22 12:21:33.728	\N	\N	IKRAMOVA MALIKABONU AZIZOVNA	AA4386383	40609975260046	$2a$10$5clY.ac4DZoFomfrSzuD3er0a20O3hi7tMgyKj8RROt.kstqyGlK6	40609975260046	0
51	100	2025-02-22 12:21:33.789039	\N	\N	KASIMOV FAYZULLO MUXAMADOVICH	AD4819911	30604570940017	$2a$10$ZhgqE7B3rNgs.V7ozuc0qu.GvXrka/nyWmm/FBLK.6FfrMzCDaB42	30604570940017	0
52	100	2025-02-22 12:21:33.850344	\N	\N	MIRZOYEVA YULDUZ YUSUP QIZI	AA4191136	41910975290012	$2a$10$mYBO5GlBsKK58UpQBy8cGOKEvPbXQIEgp6OvzFiICGG0KXEP1GCZC	41910975290012	0
53	100	2025-02-22 12:21:33.91122	\N	\N	AXMEDOVA DILSORA MUXSINOVNA	AB6511959	40704861130019	$2a$10$r8DN3I3bxhAwzBc58XzheOJghfnX7FWgabOhTvmIqQHQk6jsQWubG	40704861130019	0
54	100	2025-02-22 12:21:33.972069	\N	\N	RAXMATOV NURBEK ERKINOVICH	AB9653270	30802861160032	$2a$10$D/m/cJMvcP2.TzHKqy1QiuNS5Nc9XJIyJH20kNW39U6TPdHOAQvKy	30802861160032	0
55	100	2025-02-22 12:21:34.033511	\N	\N	KUSHAYEV AXTAM XXX	AB6409894	32112410950013	$2a$10$61WM8GWCTxa2z6lwfHkgf.a5Y42a3Wh8v2sd37ZP7GPmjpPkBaBgm	32112410950013	0
56	100	2025-02-22 12:21:34.097697	\N	\N	QODIROV ABBOS AHROR  O‘G‘LI	AD6199796	32707931100016	$2a$10$l.AsiH1HDsCJtMsXN2ZMxuJ9uSET9ppNMTl1vfa4B3p.puv476buC	32707931100016	0
57	100	2025-02-22 12:21:34.161666	\N	\N	TO‘XTAYEVA FARIDA ISMATULLAYEVNA	AD4405952	41608881140014	$2a$10$SXpuCFysfm1hHnrNGvnOheEeL3e4DN.vpL5pI.U.mVCXHeEgMh9oe	41608881140014	0
58	100	2025-02-22 12:21:34.224322	\N	\N	PARMONOV HAMID FAXRIDDIN O‘G‘LI	AD4245993	31711931080048	$2a$10$MOl0u8lMd/0WSQ0H8rOKgu2eJmWMvJaFZP.3x25UN9Sm2G4PNKnMW	31711931080048	0
59	100	2025-02-22 12:21:34.286519	\N	\N	RUSTAMOV SHAVKAT SHUXRAT O‘G‘LI	AB7647074	32306931010015	$2a$10$EOkyVukiBz0quDR8DU8DPuVmI.VEw5mYLDe3aSlgj7Yerr.cNecx.	32306931010015	0
60	100	2025-02-22 12:21:34.348728	\N	\N	XODJAYEV BOLTA KURBANOVICH	AD7178827	31011470920017	$2a$10$MEGL9i.IkDQRClglEVgn3eyNckIoiOmRFPPEsURtWEQm6plyk3Wtm	31011470920017	0
61	100	2025-02-22 12:21:34.409903	\N	\N	JUMAYEV ERKIN BOLTAYEVICH	AB3406939	31501811000017	$2a$10$7YxD8fDMFd25kHR6uyD97ecgXSTLL43/8PtdY6qv4ZttBNNszK2i6	31501811000017	0
62	100	2025-02-22 12:21:34.471218	\N	\N	BAKAYEVA MOXIRA AXRAROVNA	AD3362530	43005770930015	$2a$10$hlr6FDOAWN24xtlsTlc/Nec/qNjSKrM85jCNFsl3twtf7bIbY13/K	43005770930015	0
63	100	2025-02-22 12:21:34.53137	\N	\N	JO‘RAYEV SHUHRAT ISROILOVICH	AB2562831	31010791120092	$2a$10$HB7TYJX/XPgLe38O2GhLVuz1pWYL1OPc2DzA5bJE1VhcPwJXTRKpK	31010791120092	0
64	100	2025-02-22 12:21:34.592015	\N	\N	AMINOVA GULNOZA NASRITDINOVNA	AD4424976	40210772390067	$2a$10$/LDsUO/RSrNng9A7AqY7a.lcwvFTlDvAWxrpqNZl7dNr4IXwrOaRG	40210772390067	0
65	100	2025-02-22 12:21:34.65255	\N	\N	XOLIKOV KOMILJON BURONOVICH	AA1158064	32503682420014	$2a$10$6/vE/jZO./f74laUyTaKEe.Ox4f3QiKJfPqfXoQIHUlRRsyDJOWL2	32503682420014	0
66	100	2025-02-22 12:21:34.713187	\N	\N	IBRAGIMOV MANUCHEXR BAXTIYOROVICH	AB7441749	30401871160025	$2a$10$eBYbvJ./7800A9GYvfWJjuHxcxYbVc.y7eGwWx8/MAwaXbmea/Z3C	30401871160025	0
67	100	2025-02-22 12:21:34.774592	\N	\N	O‘KTAMOVA MEHRIGIYO A’ZAMOVNA	AA7723033	41705975260055	$2a$10$l/KfjCP5Qx0mvZCzeQu36ul/BcCGFPHAbfjp3gEowleOju.G6pCNa	41705975260055	0
68	100	2025-02-22 12:21:34.83532	\N	\N	TOG‘AYEVA UMIDA SHAVQI QIZI	AD3857638	42609931170118	$2a$10$CZg2wtZtuucQXQCOrRXEKuqxQxQO2iSOpoAVTMw0rc9FtxyOIPuaS	42609931170118	0
69	100	2025-02-22 12:21:34.89607	\N	\N	MANSUROV TOLIBJON ZIYODULLO O‘G‘LI	AA7494420	32108975350041	$2a$10$j0VhjZ4SIVpW7C2snLW2CeDpv4uzdbkfIMvGJVr/i/4SmgU9khQe.	32108975350041	0
70	100	2025-02-22 12:21:34.956876	\N	\N	YORIYEVA DILAFRO‘Z OLTINOVNA	AA7666341	41104765280013	$2a$10$kZF4/VZah31sFuzxNBifp.2hqAZu7D9FwxUMTqxjoy9.5UAHy1UnG	41104765280013	0
71	100	2025-02-22 12:21:35.017368	\N	\N	DAVRONOV ISMOIL ERGASHEVICH	AD3662977	31008611090045	$2a$10$RMMFewl7iS4CzuUaZPONJe.7cTfoPHNIYSUop6sTWC93dpKDPTnbK	31008611090045	0
72	100	2025-02-22 12:21:35.078219	\N	\N	XALILOVA RUXSORA RAUPOVNA	AB4969450	40503821050040	$2a$10$n9o5XN/uDD80Rp.E9gaBZOyW5UcbOmpR98ZTUCFV5SWN2.ZmV/iiy	40503821050040	0
73	100	2025-02-22 12:21:35.139402	\N	\N	QODIROV UMARALI DO‘STQOBILOVICH	AD1735038	31610740240071	$2a$10$Efmo3EAgTuJfQmPdDzTBYukbF42R7ImtTP3ZsDUXCcaVRHBSrurSW	31610740240071	0
74	100	2025-02-22 12:21:35.200405	\N	\N	NIYOZOV ODIL ADIZOVICH	AD3609270	32905681070012	$2a$10$5mPJCvxq0InhQvSghNvhNezf4ppMaUljHHfrjyDmRQOJz134EzGNO	32905681070012	0
75	100	2025-02-22 12:21:35.261267	\N	\N	RAMAZONOV JAHONGIR DJALOLOVICH	AB2373412	30207911060012	$2a$10$1YkVJQHXYPN/AeIozRH7peB8IsvA0FplVwjkzK8OhivtQnMsUBKTK	30207911060012	0
76	100	2025-02-22 12:21:35.321605	\N	\N	SAIDOV XAYRULLA SHAVKATOVICH	AD6502883	32103851000065	$2a$10$99/M81SfxpTmG4G9Ca7nGeFrflsAa/UYO58qI2YoW6u/zohto8moC	32103851000065	0
77	100	2025-02-22 12:21:35.383145	\N	\N	RAXMATOVA MEHRINISO MUSINOVNA	AB6395759	41607795260014	$2a$10$a.wmm4b9SR0mdNqejfzOwO3kidAvLqz8eKlO.FNEc2G9e.lufv2ma	41607795260014	0
78	100	2025-02-22 12:21:35.444506	\N	\N	HAYDAROV SHAHRIYOR SHUXRAT O‘G‘LI	AD3555210	32211931050021	$2a$10$NU0a.0kGZM64/97g/MxJI.Ogi2bLoFAw4gMYUKUovEp.0pJqZobXm	32211931050021	0
79	100	2025-02-22 12:21:35.505936	\N	\N	TO‘XTAYEVA MUNIRA OMONOVNA	AB3556279	41504831040015	$2a$10$1bd7v12GNcXa6mQv5NVzpOvXfLQW3as2N1o91UkNbE/WgjfssBElm	41504831040015	0
80	100	2025-02-22 12:21:35.567848	\N	\N	GAFUROV ABDURAUF XXX	AB4579626	31607515260026	$2a$10$58A92O6Gkjhlq75QpdF2D.qBzCrEa06jnwFPz0qQWv4agqhx0IGxC	31607515260026	0
81	100	2025-02-22 12:21:35.629912	\N	\N	OLLOQOVA O‘G‘ILJON MAMANAZAROVNA	AD3983298	42009931040064	$2a$10$N3kuXSWrUmnmvPZ2fLMHeOBEMq.5eRv88bCXGUtGFms.ZwYGkA9im	42009931040064	0
82	100	2025-02-22 12:21:35.692123	\N	\N	AXTAMOV ISLOM ILXOM O‘G‘LI	AB3896206	31307921000136	$2a$10$d/Mz.0fK7YacW4KevR.89uUVKE9x0Hc2etucFasi0x6lvVacyV5m6	31307921000136	0
83	100	2025-02-22 12:21:35.754986	\N	\N	TURSUNOV MIRZO MAXMUDOVICH	AD5039577	32309810930026	$2a$10$yp372tUjzqkEB8hAK.ofPeaum5L60cAXqczje6jc0TXR.dNEACxa.	32309810930026	0
84	100	2025-02-22 12:21:35.816779	\N	\N	FATTULLAYEVA MAHZUNA MAQSUD QIZI	AB0642762	40609975360023	$2a$10$I5lfCY8PdlXYzRrAxS1w7erddv6We05z2sfOJsIhh8zT8/gxtHpUy	40609975360023	0
85	100	2025-02-22 12:21:35.877932	\N	\N	BAROTOV XUMOYIN SHARIFOVICH	AB5617007	30112921000032	$2a$10$qt6NiDWSp3aUkrj3td9HreKvorGbatqZIh6eAMG7LEcyZ48t9.yA2	30112921000032	0
86	100	2025-02-22 12:21:35.939232	\N	\N	HAMROYEVA DILFUZA RAXMATULLAYEVNA	AA9970678	40101901100081	$2a$10$/GJXeym.1C.UHcoiERRFbuOIV60USJaLrp2YdhpW8/zNyeVp5esbi	40101901100081	0
87	100	2025-02-22 12:21:35.99965	\N	\N	NUROVA HILOLA NORMURODOVNA	AA9138399	41609861160031	$2a$10$pHkjatOcvKpPzSi0OSHJ1OJ3SFLJ738d4aIEfyZFSED3RdHjAqY/y	41609861160031	0
88	100	2025-02-22 12:21:36.06141	\N	\N	SHAROPOVA ZARNIGOR TOLIB QIZI	AD3278376	41006931060011	$2a$10$HX7aS0io0LPaoZ2/zJpyS.sHFJibtQ7V.z/UTDBnKUmOenpOhe2ki	41006931060011	0
89	100	2025-02-22 12:21:36.123602	\N	\N	TOSHEVA DILDORA ISKANDAROVNA	AB3022796	41809821160011	$2a$10$vilpQDTu20PiXia2N8FHCOar73X1MP8FWv4RJPNjhDvK5jVaSW7.a	41809821160011	0
90	100	2025-02-22 12:21:36.185903	\N	\N	O‘RINOV BAXTIYOR XAYRILLOYEVICH	AB2598260	30201672690075	$2a$10$bgFzNiFdIyqD.2Usr9v93etBNsHqxe.gVQ8BlQtYOMUtSCopH3bDq	30201672690075	0
91	100	2025-02-22 12:21:36.248124	\N	\N	TURAYEVA OYGUL SIROJ QIZI	AD8239703	42404921140029	$2a$10$VqR5n636CPPMTdTH5qQ0Me5ZeeoSbgT0tZ..PphBoSncKjR8xRDai	42404921140029	0
92	100	2025-02-22 12:21:36.309185	\N	\N	XUDOYQULOV TO‘YMUROD BEKMURODOVICH	AB6085003	32302921090012	$2a$10$1D3M8qqufVr.se2CNDKr4eumtuxbtidmJ4tyACVq00DzZTaW73rg2	32302921090012	0
93	100	2025-02-22 12:21:36.37	\N	\N	HIMOYEVA SARVARBEGIM JAMILOVNA	AD3939112	41705941060050	$2a$10$NrmC5Ma3vv3b0hRnrUBZBOnO6D64R1nKcmlGXJx77Sf4ArRrB/syi	41705941060050	0
94	100	2025-02-22 12:21:36.430927	\N	\N	QURBONOV O‘KTAM RADJABOVICH	AD3306461	32801695340010	$2a$10$SQJrBflnRETRTPqranecvuJvfjm9/91FkBfvou.JJgSs2Tj6hC3d2	32801695340010	0
95	100	2025-02-22 12:21:36.492194	\N	\N	RAXMONOVA SOJIDA MUXAMMADOVNA	AD4462137	42711821060053	$2a$10$idA6x.APZgcBy4wifXgQX.W8UM5BJt/n0RW3vkPqw1DGQ6K4w1cw2	42711821060053	0
96	100	2025-02-22 12:21:36.553143	\N	\N	NASIMOVA NASIBA QURBON QIZI	AB4192946	40705911120073	$2a$10$rqZYn6IGAjsJkQsjIE2Li.wkrn8irrw98ka2Tnd9JEfC9GHOaSbqy	40705911120073	0
97	100	2025-02-22 12:21:36.614415	\N	\N	BARATOVA DILAFRUZ SHARIFOVNA	AB3893738	40203831140031	$2a$10$thWjqJDBsLROWJSxV9QCweAgUINcbrqipvkYaHF24dUC9195.AuOS	40203831140031	0
98	100	2025-02-22 12:21:36.676015	\N	\N	ABDULLAYEVA UMIDA KAHRAMONOVNA	AA9904157	41505705260014	$2a$10$ABzRDKoXl8JPLsSd5ogSLORwIfjUbZOt.FT6AXXzV8SOlP4w.xH/u	41505705260014	0
99	100	2025-02-22 12:21:36.737549	\N	\N	RUSTAMOV NARZILLO RAXMON O‘G‘LI	AA8935910	32305985300046	$2a$10$KS4zJAcqin7gwovByj/AQeAcaSqJRilcOLHriTaNpxcMxVEbQj30q	32305985300046	0
100	100	2025-02-22 12:21:36.79916	\N	\N	AVEZOV OLMOS RAVSHANOVICH	AD2714659	32304851100047	$2a$10$EqOGPad74aMNI7ruW/2BH.CSQX5I7Vp1hr3XPGJnDKyz.PCBJWCQK	32304851100047	0
101	100	2025-02-22 12:21:36.860828	\N	\N	ATAMURADOV RUSTAM ELMURODOVICH	AA8846933	31706671050019	$2a$10$Q7SAeVdE5R1WFdHXbvjFpuXz01e8sMb/ZvMbvvawHJ3Z53BG0AI/i	31706671050019	0
102	100	2025-02-22 12:21:36.92216	\N	\N	SHADMANOV QURBON XXX	AB0291187	31210496610032	$2a$10$mjL0cMbVjxsUzhcZIpYhy.CIVcijvV9f9zDbapPwqxhG/.T7h6mXq	31210496610032	0
103	100	2025-02-22 12:21:36.983252	\N	\N	ORZIYEV HAYOTBEK HASAN O‘G‘LI	AA4807299	31708941110027	$2a$10$kdNCE1bkDqRIPE1ICmlGZuF4zpnfsjLesfcGpOyghP8peykCTEJru	31708941110027	0
104	100	2025-02-22 12:21:37.04453	\N	\N	XAITOVA NODIRA BAFOYEVNA	AD4315519	40102975360027	$2a$10$Ln8Abiftf25WJhqE2aYtmeYvfiy/O2W/lchmAj//IK7Xv37iAr2SG	40102975360027	0
105	100	2025-02-22 12:21:37.105276	\N	\N	QURBONOV ABDUJALIL MAXMUTOVICH	AB0672412	30608705260021	$2a$10$6UiJxIINlbuACZPMtGRmX.qdrzGoO6oX4vc5M4zNCByx0wf06If6O	30608705260021	0
106	100	2025-02-22 12:21:37.166473	\N	\N	ROZIQOVA MAYSARA RUSTAMOVNA	AA3251542	40906795350015	$2a$10$.lFEol0kXFCEMbKqCOfJiukN1Cqq0v.3xx4KqqfoMvsctqex.ZcTC	40906795350015	0
107	100	2025-02-22 12:21:37.227746	\N	\N	KADIROVA GUZAL GULYAMOVNA	AD4315007	43103865250016	$2a$10$wubO.a1DrKxLL79PJ5t8ieNskOZk23S0BBmw6d0DLu5vN8F8uwtxu	43103865250016	0
108	100	2025-02-22 12:21:37.288695	\N	\N	KURBANOV BAXODIR SAMATOVICH	AC0924476	31701760970018	$2a$10$hPfhfbEhWbyFXIUhqR5Hl.fdk6a/..dUH.Nv53vTwNkWnA2GQEIuO	31701760970018	0
109	100	2025-02-22 12:21:37.350532	\N	\N	XOLIQOV LAZIZJON MAXMUD O‘G‘LI	AD7301618	31203975360034	$2a$10$ESyrKFbh5h0/ecYc5m6V5.23pKExwEYGbXdqhxDIdpBcwx90xuxRC	31203975360034	0
110	100	2025-02-22 12:21:37.412556	\N	\N	RUZAYEV UKTAM RAXIMOVICH	AA5477813	30503635250011	$2a$10$N5rfoeHg/Afk2hLiqkCUPe1ZEAaaH5GuU25u6wuz3oSPpN5uaz/cO	30503635250011	0
111	100	2025-02-22 12:21:37.475047	\N	\N	ABDULLOYEV ASLIDDIN JUNAYDULLOYEVICH	AB1952962	31602761070021	$2a$10$CHIaZl9dYZDfSSOgNQfgOOodf.GEblhVV8YD31gmnf1G7r.ngFWm.	31602761070021	0
112	100	2025-02-22 12:21:37.537449	\N	\N	SAMADOV G‘OLIBJON ZAYNIDINOVICH	AD3213530	30905911140065	$2a$10$7j50/cJG4bX7d.OPLj6YPuKBbreUOATNE3r.XCfTo2Key9PGz1NHy	30905911140065	0
113	100	2025-02-22 12:21:37.59961	\N	\N	TOYIROVA DILRABO SATTOROVNA	AA3454629	40901891140072	$2a$10$v2LR3DJ6ucSoXlBNU18CiuVndoV1HYJ91P1gJHTD1XMGWxPfpW1g6	40901891140072	0
114	100	2025-02-22 12:21:37.66192	\N	\N	RASULOV ZUBAYDULLO IZOMOVICH	AA4491167	31107750970013	$2a$10$hhuZpcsWUOun7BTK/cr.T.tYHYt/LSiKjSU0ls.Qttc8bSOVmD1SW	31107750970013	0
115	100	2025-02-22 12:21:37.723084	\N	\N	HAYDAROV LATIFJON RUSTAMOVICH	AA1502886	31303825320017	$2a$10$iUjhhMJh8geaSYt1jSBmUONcuQ4gXmkaODKrTT1KqvweyLrFwbM0u	31303825320017	0
116	100	2025-02-22 12:21:37.783474	\N	\N	BAROTOVA MUXIBA ORIFOVNA	AB1940914	42211921000026	$2a$10$ZaH2mLmrRjkCMW8m8XORUeVOCyU.R/HOOqbe55A0AmUw5BgzCKL6W	42211921000026	0
117	100	2025-02-22 12:21:37.845309	\N	\N	BABAYEVA VASILA TOSHPULATOVNA	AA7246513	42204705260011	$2a$10$rhUzyexBVT8UZfL6LTcS0uKVrvmi/Yvb.vDWkrphc5QMVxXYGjciG	42204705260011	0
118	100	2025-02-22 12:21:37.906114	\N	\N	RAXIMOV MUZAFFAR MURADOVICH	AB0074132	33101851050012	$2a$10$3h0jgzs./HzmR/CGhP7cN.ZfA288F75n9z7.5bhuWDioHcGNmkU2e	33101851050012	0
119	100	2025-02-22 12:21:37.967188	\N	\N	MURTAZOYEV OTABEK NUSRAT O‘G‘LI	AB4604863	32511995260034	$2a$10$ygAENrxaKCKUZHjl/gVrHuel6O3q.bJnNP61kBc2YDrxYG7QktXLG	32511995260034	0
120	100	2025-02-22 12:21:38.029073	\N	\N	NABIYEVA MADINABONU MIRZO QIZI	AD3345015	41709931010029	$2a$10$5dDz6lwxv6rggo7co5xFru4qWoKd87KfszgHlCUkkkOUs8uDwDkXi	41709931010029	0
121	100	2025-02-22 12:21:38.090748	\N	\N	XIDIROV ASKAR ACHILOVICH	AA2498003	30711470260043	$2a$10$pJPrYwTMAiMnEx2wxNZI.eKkFo2aCuEnyf0uh07PVsJ.1kcFh9izm	30711470260043	0
122	100	2025-02-22 12:21:38.151067	\N	\N	BOBOHUSENOV AKMAL ASHUROVICH	AA8758017	31505961050027	$2a$10$JV/nb0L2kUXN5qR7UxW65OQRDoNLqgEHe0iRth7z9gqn2uVfatxbW	31505961050027	0
123	100	2025-02-22 12:21:38.212006	\N	\N	TESHAYEV AZIZBEK TO‘YNOR O‘G‘LI	AD2765731	32006955360016	$2a$10$IIhq8IvVPjq4ze/q9JGP9u0nBEUQvzBmQUnFeiVFzC6k5ec/5vT8m	32006955360016	0
124	100	2025-02-22 12:21:38.272883	\N	\N	RASULOV XAYDAR RAUPOVICH	AB5095702	30103710090015	$2a$10$0F/x3K81S6jBE7r4Xm5XiePYqA4AYZqP8HWRwGFrhS9/pjGXw9lji	30103710090015	0
125	100	2025-02-22 12:21:38.333468	\N	\N	XUDAYAROV SA’NAT SAMADOVICH	AB4721219	32009832330072	$2a$10$MaPkD0bhejvuo7M1uf88re4wwoGcS8qlC7.9LhZd/p8ZkJN/6nO3u	32009832330072	0
126	100	2025-02-22 12:21:38.394537	\N	\N	SAMIYEVA MAHLIYO JALOLOVNA	AA2932596	42707965280020	$2a$10$SPR8bChKlx9kew/6Tw0o4eoBlsypSpSJG4L5ghyAEp.RILxxof2cG	42707965280020	0
127	100	2025-02-22 12:21:38.455585	\N	\N	BOLTAYEVA SITORA FAYZULLOYEVNA	AD5557395	42011955330014	$2a$10$m1Mcylecq3S/EGbkcJjfbeVJEyuDS4yG9qUGmR/aMP6ACfH99KyMW	42011955330014	0
128	100	2025-02-22 12:21:38.517225	\N	\N	MAJIDOV JURABEK JALILOVICH	AD3818499	32712871090048	$2a$10$libt47dzCgBnis80NH0BuO86e8hW/58n1kmtSMtZKdhOlHCC.XrwG	32712871090048	0
129	100	2025-02-22 12:21:38.578471	\N	\N	TO‘RAYEV SUNNATILLO AMRILLOYEVICH	AA9913368	30311961000053	$2a$10$yBEcQSeVsnakeKHy0.RKWOP1JivQlEMfJMEW8VODlQpAoC9AsbW1a	30311961000053	0
130	100	2025-02-22 12:21:38.639515	\N	\N	JALOLOV TURSUNBEK SADRIDDINOVICH	AA8227448	32703941170027	$2a$10$LeoPIUOfLbGc9YvB5dOyQOz71QjyaUCQXH2LmUiLBMXxIo9lIleuC	32703941170027	0
132	100	2025-02-22 12:21:38.766618	\N	\N	ADIZOVA ZUHRO MA’RUF QIZI	AC2069696	42312965310099	$2a$10$PbzwHxoy4OanBAh9gEndieqfcyqA.oycjndNA2V91i6HrqoQmoHmC	42312965310099	0
133	100	2025-02-22 12:21:38.82874	\N	\N	RAMAZONOVA FERUZA XUDOYNAZAROVNA	AB0834974	41507921050015	$2a$10$SIJBFwLFEuOoasQIOvzFO..EYV.pb7o.7b9QvJO8GFFYJpfxmGlnq	41507921050015	0
134	100	2025-02-22 12:21:38.889958	\N	\N	BEKOVA NAZORA JO‘RAYEVNA	AD3364472	41311695260019	$2a$10$BfGFOv8VfPJ9.6QSUaJqaeG6B.vnHaNdyeFLQJYWJWOsLIuVxXBVu	41311695260019	0
135	100	2025-02-22 12:21:38.961021	\N	\N	YO‘LDOSHEV AKMAL BAXTIYOROVICH	AA7273819	30605851050010	$2a$10$MOFNj0CRd5AH5YWEHrdH6Oe6oYufR3hEkX2cLQE6g6UstdMkTL8zm	30605851050010	0
136	100	2025-02-22 12:21:39.023114	\N	\N	YUNUSOVA GULANDOM SAMIYEVNA	AD2909035	42801710930016	$2a$10$anluM0yk9eA.gYRGqMk6q.tcxnbBoUvsVlXxl/4iuWh92C2vlM60u	42801710930016	0
137	100	2025-02-22 12:21:39.086108	\N	\N	XIDIROVA GAVXAR RUSTAMOVNA	AD7245801	41203791130014	$2a$10$zYX1AsOuIu7IIPzSR1ndXupELO3jr6LeyJ6S9j0S85ToN9P9rizJG	41203791130014	0
138	100	2025-02-22 12:21:39.14849	\N	\N	SOBIROV TOLIB RUZIYEVICH	AD3294612	31006581160016	$2a$10$oUBJfuj6QEb19KYVu.7HkORk/kzYmf5C3LP3.s.uvFGn5ieoJ3xci	31006581160016	0
139	100	2025-02-22 12:21:39.211286	\N	\N	XUJAYEV DILMUROD BAKIYEVICH	AD8709471	33110690920031	$2a$10$tUA8eKV/mac/Sy1LHNoBmevrJ.loWQxbu5TLX9qoQNrGviLgyAgpS	33110690920031	0
140	100	2025-02-22 12:21:39.273712	\N	\N	RO‘ZIYEV TO‘LQIN RAZZOQOVICH	AB6859244	32910841050021	$2a$10$BBeS4Wl1dl4AT4/mGs9vXueMwzgBSf4CT8eGa0U/8yR0ijcpEAgCO	32910841050021	0
141	100	2025-02-22 12:21:39.336194	\N	\N	YAXYOYEVA UMIDA IBROHIM QIZI	AD2687530	41411945360019	$2a$10$M30Rw2HU.jRYr.r7yNgk3uRt0qyWB65K1ZZ1i8Ph14djRkPCfHA1O	41411945360019	0
142	100	2025-02-22 12:21:39.398502	\N	\N	SAIDIY SAID BOLTA-ZODA	AA1639114	32509640970018	$2a$10$sbNf2SU7zYWp.ADBhaZPKeEZlKamtaqvCXh7ZlYJGos5.kPy4DWri	32509640970018	0
143	100	2025-02-22 12:21:39.460002	\N	\N	SAFAROVA ZAKIYA TESHAYEVNA	AC0731977	40507760980015	$2a$10$f25yzKpfiA.V7qysUvUXhuamz/bCmUbD8X3.7erS5qno.iDGAhLZa	40507760980015	0
144	100	2025-02-22 12:21:39.520827	\N	\N	BOYMURODOVA NODIRABEGIM BAHODIR QIZI	AD4152426	41206955300010	$2a$10$f9MxTPn/6pEUkiPh6MFVZ..0T.OC/kU93c40yU6um5BK.GN4hM2qW	41206955300010	0
145	100	2025-02-22 12:21:39.582023	\N	\N	ADIZOV AZIM TOLIBOVICH	AB7475324	30306831060020	$2a$10$1ffjhd3wyiXrEVOVidpZI.wVYf1bvZWalfWzyToy78c8p/fEvlGRO	30306831060020	0
146	100	2025-02-22 12:21:39.643269	\N	\N	BOLTAYEVA MATLYUBA OCHILOVNA	AA9969361	42502535260017	$2a$10$KYX6BJhuhcryr3l0Kbbty.4hLAExHCXLjmAsIeuZQnZiPNH5R.xZy	42502535260017	0
147	100	2025-02-22 12:21:39.704243	\N	\N	BARAKAYEV ILXOM JURAYEVICH	AD3513620	33006701150011	$2a$10$0/z2Jczvkda7FBGHE2eW2ujvw3sZoQLF1EgexNCLIm9ZmS5KpsAqq	33006701150011	0
148	100	2025-02-22 12:21:39.765384	\N	\N	FAYZIYEV DILMUROD DAVLATOVICH	AA9982700	30802921140024	$2a$10$dMsZ94MkrLEUxe4jXSY4F.m/hAHRnXjDtstBCX4ba4nCWeqloeB1e	30802921140024	0
149	100	2025-02-22 12:21:39.826528	\N	\N	IDIYEVA MANUCHEHRA IKROM QIZI	AB5780069	62809005340016	$2a$10$tpvIdp6wQ4aMgR4jLvp07OZ/Kjl3Ib42VNNAYRC82279alGwsSDkO	62809005340016	0
150	100	2025-02-22 12:21:39.889836	\N	\N	RAXMATULLAYEV SHAROFIDDIN NEMATULLAYEVICH	AB1647978	32412863990081	$2a$10$7bWQfjKVvyMOSdkaAb.nYOoiKUANGwUm4mEx2SpHXA3egKFh1BqOO	32412863990081	0
154	100	2025-02-22 12:21:40.136249	\N	\N	NUSRATOV FARRUXMIRZO FURQAT O‘G‘LI	AB4319828	32404921120011	$2a$10$UAoFaidpWpVfDeCqkHLGTOJiWY0jwXfspS9PhFK24XT.47fI1VgYS	32404921120011	0
156	100	2025-02-22 12:21:40.268457	\N	\N	OLIMOVA FIRUZA OCHILOVNA	AB1617699	41408731080037	$2a$10$y8GwMeKQoU3R4IGR.mSSou5WAeiCHL97Br/x1i8YhGZJDY2v4/1ZO	41408731080037	0
159	100	2025-02-22 12:21:40.460549	\N	\N	OCHILOVA DILDORA TOSHPULATOVNA	AB1964483	41806791050036	$2a$10$wjdGNM0aY.r2m.hwzOXAd.UJ1TKbechWq9jRevzqQ8FSSNtQ2r/lO	41806791050036	0
160	100	2025-02-22 12:21:40.523305	\N	\N	MUZAFAROV XASAN YADGAROVICH	AB4598741	31409995260075	$2a$10$BMzkuWcUAawqK9VlECGdcOjpnpmRQ9ETmZAn7rrdege9W1NsSisBe	31409995260075	0
163	100	2025-02-22 12:21:40.709242	\N	\N	NURULLAYEVA YAXSHIGUL SHUKRULLOYEVNA	AA1985480	42401605300012	$2a$10$yDGF4B/VhUhx6K8SbOZt/us7eOGTK7W244qMuTDo1wtHANvbcJH2.	42401605300012	0
166	100	2025-02-22 12:21:40.895121	\N	\N	USMONOVA SURAYYO MUXITDINOVNA	AA6071144	40611861050057	$2a$10$dZS9PFJz.U34LvBNJpUlLON96m4CMIb0M8aL1hwwbjFIv3C9sqaX.	40611861050057	0
168	100	2025-02-22 12:21:41.020291	\N	\N	SADULLAYEVA OZODA XAMROYEVNA	AD3222464	40903725300012	$2a$10$d1CuQqJgDptXzyOL65JCj.nxg1jJ9U7f.b9/ParIxJ5Tpvi4xaSxS	40903725300012	0
1	100	2025-02-22 12:21:30.69025	\N	\N	QAYUMOVA NIGORA MUXTOR KIZI	AB2216026	41205911000108	$2a$10$6z984N.eSCA84yg1HPBIwOV.4Y7Dbo2caeK2B824LFZJcEaB4zSPe	1111	+998942488434
170	100	2025-02-22 14:50:09.935918	\N	\N	admin	23	23	$2a$10$.FOMDznUbwlYYAKqc90htu/RZ9IWMlMObIWC2A5TONRRR/9RYTYwK	0000	+998423423423
155	100	2025-02-22 12:21:40.203405	\N	\N	BAROTOV SHUXRAT SHARIPOVICH	AD1828104	31603861010016	$2a$10$Nqh/217iKpkLjO6hTWr6EeoFfb8FwpluVf1UciFBkvvjjyjuTAZDO	3333	0
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (updated_at, id, address, education_form, education_type, faculty, first_name, gender, group_name, image, level, passport_number, passport_pin, payment_form, phone, province, second_name, semester, specialty, student_status, third_name) FROM stdin;
2025-02-26 11:02:00.935186	7ea43f5e-136f-4d38-981e-ff0acac8b7da	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:02:01.672118	81d2ef9c-838e-4b62-9fef-7eae31108f8e	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:02:09.334058	8dbd0a13-3aef-4022-9ada-a7cca6de68dd	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:02:13.017386	cb607287-9010-4022-8b83-ad15c46d08da	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:02:41.90652	ee02e86a-4ebd-4cd5-8f6e-8988f8bd706b	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:02:51.395845	146518c8-c75b-46ff-b38c-d711e51fea6f	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:04:09.91511	a086b52a-9210-4b5b-9fef-88859d452ddd	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:04:10.214165	d426d112-d5fe-4566-92d8-452b9645abd6	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:04:14.962527	48e37258-a9c3-43a0-a539-256d48133e6f	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:05:15.960592	07703b21-b983-4d0b-901d-04c70f9531d0	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:05:53.513357	922243be-f63f-4040-917f-9f665aaf55ba	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:05:54.410345	7b93f9d0-582c-4f55-8f76-c5fc815f0cb4	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 11:05:54.667854	c1180448-aeea-48d3-b5fa-37e71a41b939	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-02-26 17:14:09.334991	93430863-800b-4180-805c-32b2fb378e19	19-SONLI FAYZULLA XO‘JAYeV NOMLI MFY, KIZILKUM,  uy:4	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	XUMOYUN MIRZO	Erkak	1-21 OP	https://hemis.buxpxti.uz/static/crop/5/2/320_320_90_526536579.jpg	4-kurs	AC0417297	51210025260031	To‘lov-shartnoma	+998931422825	Buxoro viloyati	BARAKAYEV	8-semestr	Psixologiya (oila psixologiyasi)	O‘qimoqda	ILXOMOVICH
2025-03-12 14:55:43.466198	6598ceab-978e-4665-8865-1294b425fca8	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-12 14:55:44.732826	7fbe60c6-c5cd-4be0-b5ad-f58ad43de67f	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-12 14:56:00.700561	31776bb7-6c6d-4976-bb93-85d03cd2bb30	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-12 14:56:00.927595	9fe604fe-3406-4d5d-becc-e596be642ece	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-12 14:56:06.218289	35a390f9-8b2b-4eed-b2ae-8c15fea43d99	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-12 14:56:58.235628	773ef4ed-997d-4db4-a21f-a4040aa89391	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-12 14:59:37.199066	714ea1b0-7616-441f-ac30-b130f82b473e	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
2025-03-13 08:28:19.780499	d6f21815-848f-436f-b224-1a1ded914922	Navoiyskaya oblast, Navoiy sh., Ishonch MFY, 10-daxa, A.Navoiy, dom 52, kv. 57	Kunduzgi	Bakalavr	Psixologiya va xorijiy tillar fakulteti	MANZURA	Ayol	1-24 MPL	https://hemis.buxpxti.uz/static/crop/1/9/320_320_90_1919528388.jpg	1-kurs	AD4199839	62806065820027	To‘lov-shartnoma	+998332361217	Navoiy viloyati	SHUKUROVA	2-semestr	Maxsus pedagogika: logopediya	O‘qimoqda	SHUXRAT QIZI
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (faculty_id, id, place, created_at, main_photo_id, description, title) FROM stdin;
\.


--
-- Data for Name: test_education_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_education_field (id, test1_id, test2_id, test3_id, test4_id, test5_id) FROM stdin;
1	7	8	2	9	10
2	8	2	7	5	3
3	7	2	8	6	5
4	7	8	2	9	1
5	7	2	8	6	4
\.


--
-- Data for Name: test_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_score (id, status, "time", abuturient_id, right_score, score) FROM stdin;
1	0	2025-02-12 08:33:11.891354	22fc4052-f732-4bdb-821e-df58b692fdc5	0	0
2	0	2025-02-18 14:48:05.271622	b696fa54-a3f8-4827-9e87-6f28163b7e4c	0	75.7
3	0	2025-02-19 16:00:12.876869	9364a867-ef23-4e74-9aba-118a6151b092	0	0
4	0	2025-02-19 16:01:01.052984	7b4ced50-900f-46b7-9171-6385f46d0f12	0	77.7
5	0	2025-02-19 16:04:54.835862	303e5ad4-1635-42e9-946d-127554579b49	0	0
6	0	2025-02-19 16:07:48.493342	530c54aa-af69-4aa1-936f-4a4851e91c4f	0	0
7	0	2025-02-19 16:18:08.100358	2c192c98-a782-43c1-a3c9-ca2879903057	0	0
8	0	2025-02-19 16:23:22.768962	c6802796-2941-4a10-a313-0e78dcbb8c87	72	72
9	0	2025-02-19 16:25:35.875583	3fe0c841-a06e-4b8d-8094-47f656682b7b	0	0
10	0	2025-02-19 16:34:49.56315	21c1657a-7232-4d29-a6cd-6515e5791c8d	89	89
11	0	2025-02-19 16:55:51.872124	c25d2a79-b63d-48bf-a240-395c167343ce	0	0
13	0	2025-02-19 17:13:43.721051	c2e906b3-340b-4ee7-ada6-4df7c570a907	51.2	51.2
14	0	2025-02-19 17:16:09.219579	19005c92-bf2a-497c-8071-9f57d805dd94	95	95
15	0	2025-02-19 17:32:29.5483	bac68774-87fb-481d-92c7-e309131686b2	23.6	23.6
12	0	2025-02-19 16:58:18.011008	e8f3ef13-5136-42c5-8491-a4eaf2b2bfec	36.4	36.4
16	0	2025-02-20 17:41:02.808334	d9389314-5e6e-46b2-9d47-69f66100e329	23.6	23.6
17	0	2025-02-20 17:42:42.569459	5d3017ca-5477-48af-8aa2-6f30e55c6077	0	0
18	0	2025-02-20 17:54:10.680275	1ae97a44-8528-4b4b-8de9-7ec8358f24d2	60	60
19	0	2025-02-20 18:48:28.140781	d46e1c6f-e682-48e5-832c-90a0bc9f2d9f	0	0
\.


--
-- Data for Name: test_subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_subject (id, created_at, description, name, status) FROM stdin;
1	2025-02-10 09:44:42.848098		Ijodiy imtihon	2
2	2025-02-11 09:53:48.072179		Tarix_0	1
3	2025-02-11 09:53:48.119495		Bialogiya	2
4	2025-02-11 09:53:48.158787		Fizika	2
5	2025-02-11 09:53:48.180662		Ingliz tili	2
6	2025-02-11 09:53:48.322165		Matematika_1	2
7	2025-02-11 09:53:48.355239		Matematika_0	1
8	2025-02-11 09:53:48.374016		Ona tili_0	1
9	2025-02-11 09:53:48.402432		ona tili va adabiyoti	2
10	2025-02-11 09:53:48.485777		Tarix	2
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token (id, created_at, name) FROM stdin;
4	2025-03-04 12:23:19.28948	2K-upyz9Y5uWP7wNgz7_k_6oLgQ3-_gt
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, password, phone) FROM stdin;
faa39f30-0dcd-42ca-a72c-4a3707da3187	$2a$10$1bguaRfprZj/5Z4o4K7I1eW1gjiEoy0eOSeug/L3mwly6dwAq8NSa	admin1234
c8e784e4-1a77-4f18-b7b7-fa3d60eaa351	$2a$10$kzoC25bFCiG2j69oeUDpyOGvCt4arDQbatrNPSEM1VyevU3jjJV9K	admin12345
aae53410-3d22-4e2f-aab5-8097210a02b7	$2a$10$hGYHSpRsC5GSMOrzSNKxhukUuxCpRAi16NSfUaFsXroSiN3l1qLbG	generator
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_roles (roles_id, user_id) FROM stdin;
1	faa39f30-0dcd-42ca-a72c-4a3707da3187
1	c8e784e4-1a77-4f18-b7b7-fa3d60eaa351
8	aae53410-3d22-4e2f-aab5-8097210a02b7
\.


--
-- Data for Name: vacancy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vacancy (id, name) FROM stdin;
\.


--
-- Data for Name: youtube; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.youtube (id, created_at, iframe, hash_tag, title) FROM stdin;
\.


--
-- Name: administrator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administrator_id_seq', 1, false);


--
-- Name: agent_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agent_path_id_seq', 2, true);


--
-- Name: appeal_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appeal_type_id_seq', 2, true);


--
-- Name: certificate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.certificate_id_seq', 1, false);


--
-- Name: command_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.command_id_seq', 18, true);


--
-- Name: command_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.command_message_id_seq', 4, true);


--
-- Name: command_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.command_rating_id_seq', 4, true);


--
-- Name: commander_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commander_id_seq', 11, true);


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_id_seq', 1, false);


--
-- Name: daily_control_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_control_id_seq', 5, true);


--
-- Name: daily_control_sub_folder_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_control_sub_folder_content_id_seq', 4, true);


--
-- Name: daily_control_sub_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_control_sub_folder_id_seq', 16, true);


--
-- Name: duty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.duty_id_seq', 7, true);


--
-- Name: education_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_field_id_seq', 54, true);


--
-- Name: education_form_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_form_id_seq', 5, true);


--
-- Name: education_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_type_id_seq', 2, true);


--
-- Name: faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_id_seq', 3, true);


--
-- Name: gallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gallery_id_seq', 5, true);


--
-- Name: history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.history_id_seq', 45, true);


--
-- Name: kitoblar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kitoblar_id_seq', 1, false);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.language_id_seq', 2, true);


--
-- Name: memorandum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.memorandum_id_seq', 1, false);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_seq', 1, false);


--
-- Name: my_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.my_test_id_seq', 646, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_id_seq', 8, true);


--
-- Name: newspaper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newspaper_id_seq', 3, true);


--
-- Name: nomenklatura_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nomenklatura_file_id_seq', 1, false);


--
-- Name: nomenklatura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nomenklatura_id_seq', 1, true);


--
-- Name: rank_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rank_id_seq', 31, true);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.region_id_seq', 1, false);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 170, true);


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 1, false);


--
-- Name: test_education_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_education_field_id_seq', 5, true);


--
-- Name: test_score_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_score_id_seq', 19, true);


--
-- Name: test_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_subject_id_seq', 10, true);


--
-- Name: token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_id_seq', 4, true);


--
-- Name: vacancy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vacancy_id_seq', 1, false);


--
-- Name: youtube_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.youtube_id_seq', 1, false);


--
-- Name: abuturient abuturient_contract_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT abuturient_contract_number_key UNIQUE (contract_number);


--
-- Name: abuturient abuturient_passport_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT abuturient_passport_number_key UNIQUE (passport_number);


--
-- Name: abuturient abuturient_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT abuturient_phone_key UNIQUE (phone);


--
-- Name: abuturient abuturient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT abuturient_pkey PRIMARY KEY (id);


--
-- Name: administrator administrator_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_login_key UNIQUE (login);


--
-- Name: administrator administrator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_pkey PRIMARY KEY (id);


--
-- Name: agent_path agent_path_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent_path
    ADD CONSTRAINT agent_path_pkey PRIMARY KEY (id);


--
-- Name: appeal_type appeal_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appeal_type
    ADD CONSTRAINT appeal_type_pkey PRIMARY KEY (id);


--
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);


--
-- Name: certificate certificate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificate
    ADD CONSTRAINT certificate_pkey PRIMARY KEY (id);


--
-- Name: command_message command_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_message
    ADD CONSTRAINT command_message_pkey PRIMARY KEY (id);


--
-- Name: command command_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT command_pkey PRIMARY KEY (id);


--
-- Name: command_rating command_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_rating
    ADD CONSTRAINT command_rating_pkey PRIMARY KEY (id);


--
-- Name: commander commander_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commander
    ADD CONSTRAINT commander_pkey PRIMARY KEY (id);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: daily_control daily_control_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control
    ADD CONSTRAINT daily_control_pkey PRIMARY KEY (id);


--
-- Name: daily_control_sub_folder_content daily_control_sub_folder_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder_content
    ADD CONSTRAINT daily_control_sub_folder_content_pkey PRIMARY KEY (id);


--
-- Name: daily_control_sub_folder daily_control_sub_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder
    ADD CONSTRAINT daily_control_sub_folder_pkey PRIMARY KEY (id);


--
-- Name: duty duty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duty
    ADD CONSTRAINT duty_pkey PRIMARY KEY (id);


--
-- Name: education_field education_field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_field
    ADD CONSTRAINT education_field_pkey PRIMARY KEY (id);


--
-- Name: education_form education_form_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_form
    ADD CONSTRAINT education_form_pkey PRIMARY KEY (id);


--
-- Name: education_type education_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_type
    ADD CONSTRAINT education_type_pkey PRIMARY KEY (id);


--
-- Name: faculty faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (id);


--
-- Name: gallery gallery_main_photo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery
    ADD CONSTRAINT gallery_main_photo_id_key UNIQUE (main_photo_id);


--
-- Name: gallery gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery
    ADD CONSTRAINT gallery_pkey PRIMARY KEY (id);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);


--
-- Name: kitoblar kitoblar_main_photo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar
    ADD CONSTRAINT kitoblar_main_photo_id_key UNIQUE (main_photo_id);


--
-- Name: kitoblar_photos kitoblar_photos_photos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar_photos
    ADD CONSTRAINT kitoblar_photos_photos_id_key UNIQUE (photos_id);


--
-- Name: kitoblar kitoblar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar
    ADD CONSTRAINT kitoblar_pkey PRIMARY KEY (id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: memorandum memorandum_main_photo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum
    ADD CONSTRAINT memorandum_main_photo_id_key UNIQUE (main_photo_id);


--
-- Name: memorandum_photos memorandum_photos_photos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum_photos
    ADD CONSTRAINT memorandum_photos_photos_id_key UNIQUE (photos_id);


--
-- Name: memorandum memorandum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum
    ADD CONSTRAINT memorandum_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: my_test my_test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_test
    ADD CONSTRAINT my_test_pkey PRIMARY KEY (id);


--
-- Name: news news_main_photo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_main_photo_id_key UNIQUE (main_photo_id);


--
-- Name: news_photos news_photos_photos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_photos
    ADD CONSTRAINT news_photos_photos_id_key UNIQUE (photos_id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: newspaper newspaper_main_photo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper
    ADD CONSTRAINT newspaper_main_photo_id_key UNIQUE (main_photo_id);


--
-- Name: newspaper_photos newspaper_photos_photos_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper_photos
    ADD CONSTRAINT newspaper_photos_photos_id_key UNIQUE (photos_id);


--
-- Name: newspaper newspaper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper
    ADD CONSTRAINT newspaper_pkey PRIMARY KEY (id);


--
-- Name: nomenklatura_file nomenklatura_file_file_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura_file
    ADD CONSTRAINT nomenklatura_file_file_id_key UNIQUE (file_id);


--
-- Name: nomenklatura_file nomenklatura_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura_file
    ADD CONSTRAINT nomenklatura_file_pkey PRIMARY KEY (id);


--
-- Name: nomenklatura nomenklatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_pkey PRIMARY KEY (id);


--
-- Name: rank rank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rank
    ADD CONSTRAINT rank_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: staff staff_passport_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_passport_number_key UNIQUE (passport_number);


--
-- Name: staff staff_passport_pin_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_passport_pin_key UNIQUE (passport_pin);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_main_photo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_main_photo_id_key UNIQUE (main_photo_id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: test_education_field test_education_field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field
    ADD CONSTRAINT test_education_field_pkey PRIMARY KEY (id);


--
-- Name: test_score test_score_abuturient_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_score
    ADD CONSTRAINT test_score_abuturient_id_key UNIQUE (abuturient_id);


--
-- Name: test_score test_score_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_score
    ADD CONSTRAINT test_score_pkey PRIMARY KEY (id);


--
-- Name: test_subject test_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_subject
    ADD CONSTRAINT test_subject_pkey PRIMARY KEY (id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: abuturient uk2gskfvtl6u50wrcwud91iskxw; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT uk2gskfvtl6u50wrcwud91iskxw UNIQUE (passport_pin);


--
-- Name: abuturient uk37jmk48mbvlmode1er1vnasqk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT uk37jmk48mbvlmode1er1vnasqk UNIQUE (phone);


--
-- Name: test_subject uk63fgsnmmnm1ophku6yakbdl3t; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_subject
    ADD CONSTRAINT uk63fgsnmmnm1ophku6yakbdl3t UNIQUE (name, status);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vacancy vacancy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vacancy
    ADD CONSTRAINT vacancy_pkey PRIMARY KEY (id);


--
-- Name: youtube youtube_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youtube
    ADD CONSTRAINT youtube_pkey PRIMARY KEY (id);


--
-- Name: users_roles fk15d410tj6juko0sq9k4km60xq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk15d410tj6juko0sq9k4km60xq FOREIGN KEY (roles_id) REFERENCES public.role(id);


--
-- Name: kitoblar_photos fk17ji3icbqg74n0dvf3s8f7reb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar_photos
    ADD CONSTRAINT fk17ji3icbqg74n0dvf3s8f7reb FOREIGN KEY (book_id) REFERENCES public.kitoblar(id);


--
-- Name: test_education_field fk1e5ee22gdocb7h1f9j57iwg3y; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field
    ADD CONSTRAINT fk1e5ee22gdocb7h1f9j57iwg3y FOREIGN KEY (test4_id) REFERENCES public.test_subject(id);


--
-- Name: education_form fk2f1ldtqjutdd3a0je12f4y46c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_form
    ADD CONSTRAINT fk2f1ldtqjutdd3a0je12f4y46c FOREIGN KEY (education_type_id) REFERENCES public.education_type(id);


--
-- Name: users_roles fk2o0jvgh89lemvvo17cbqvdxaa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk2o0jvgh89lemvvo17cbqvdxaa FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: teachers fk3e7fyo8qn97vxfksq7m6phno0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk3e7fyo8qn97vxfksq7m6phno0 FOREIGN KEY (main_photo_id) REFERENCES public.attachment(id);


--
-- Name: daily_control_sub_folder_content fk4nps1k04qcn5jhb1ou8mrkjqw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder_content
    ADD CONSTRAINT fk4nps1k04qcn5jhb1ou8mrkjqw FOREIGN KEY (attachment_id) REFERENCES public.attachment(id);


--
-- Name: newspaper fk4y8657dggc6hku05te4u8xyc9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper
    ADD CONSTRAINT fk4y8657dggc6hku05te4u8xyc9 FOREIGN KEY (main_photo_id) REFERENCES public.attachment(id);


--
-- Name: test_education_field fk52wr2vq930vwg5x1lvgo6ypu8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field
    ADD CONSTRAINT fk52wr2vq930vwg5x1lvgo6ypu8 FOREIGN KEY (test2_id) REFERENCES public.test_subject(id);


--
-- Name: education_field fk5he2tq4brg5mg9rrmlwr01hd6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_field
    ADD CONSTRAINT fk5he2tq4brg5mg9rrmlwr01hd6 FOREIGN KEY (test_education_field_id) REFERENCES public.test_education_field(id);


--
-- Name: test_education_field fk6dja6w7uo4p4vt7vsctt5rvjg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field
    ADD CONSTRAINT fk6dja6w7uo4p4vt7vsctt5rvjg FOREIGN KEY (test5_id) REFERENCES public.test_subject(id);


--
-- Name: company fk758u6fn9eae40rfm7jhvkqgjh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT fk758u6fn9eae40rfm7jhvkqgjh FOREIGN KEY (vacancy_name_id) REFERENCES public.vacancy(id);


--
-- Name: history fk77q82vj26hlf4tptfups5shdm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT fk77q82vj26hlf4tptfups5shdm FOREIGN KEY (command_id) REFERENCES public.command(id);


--
-- Name: test_education_field fk7ssgoq3n0pkajji3bog3c4ylt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field
    ADD CONSTRAINT fk7ssgoq3n0pkajji3bog3c4ylt FOREIGN KEY (test3_id) REFERENCES public.test_subject(id);


--
-- Name: command_message fk88dcyygph0u0s0cv08w0a16fa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_message
    ADD CONSTRAINT fk88dcyygph0u0s0cv08w0a16fa FOREIGN KEY (file_id) REFERENCES public.attachment(id);


--
-- Name: newspaper_photos fk8btn793gpr5r92t59pk38trsb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper_photos
    ADD CONSTRAINT fk8btn793gpr5r92t59pk38trsb FOREIGN KEY (photos_id) REFERENCES public.attachment(id);


--
-- Name: teachers fk9eg1sq70c7h7s2mov3aq6529a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT fk9eg1sq70c7h7s2mov3aq6529a FOREIGN KEY (faculty_id) REFERENCES public.faculty(id);


--
-- Name: duty fk9ngk9xd8acvtmlkyhkcwsbgeg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duty
    ADD CONSTRAINT fk9ngk9xd8acvtmlkyhkcwsbgeg FOREIGN KEY (rank_id) REFERENCES public.rank(id);


--
-- Name: education_field fk9sl2tyty3sob9ioy060ne0cer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_field
    ADD CONSTRAINT fk9sl2tyty3sob9ioy060ne0cer FOREIGN KEY (education_form_id) REFERENCES public.education_form(id);


--
-- Name: news fkavct4f51cb2prd2g2d1q95dic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT fkavct4f51cb2prd2g2d1q95dic FOREIGN KEY (main_photo_id) REFERENCES public.attachment(id);


--
-- Name: abuturient fkbajr4dgd26f65ty7fijlx0sap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT fkbajr4dgd26f65ty7fijlx0sap FOREIGN KEY (education_field_id) REFERENCES public.education_field(id);


--
-- Name: commander_ranks fkccctivec5cwt651cb9a7i4bkf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commander_ranks
    ADD CONSTRAINT fkccctivec5cwt651cb9a7i4bkf FOREIGN KEY (commander_id) REFERENCES public.commander(id);


--
-- Name: daily_control_sub_folder fkcsqgw0nxcui9j1e1axha5d4w3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder
    ADD CONSTRAINT fkcsqgw0nxcui9j1e1axha5d4w3 FOREIGN KEY (staff_id) REFERENCES public.staff(id);


--
-- Name: memorandum fkcula9q4gmmh71ks58l3dvf3bc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum
    ADD CONSTRAINT fkcula9q4gmmh71ks58l3dvf3bc FOREIGN KEY (main_photo_id) REFERENCES public.attachment(id);


--
-- Name: commander_ranks fkcuykmrty12bm4tvyel72v5ow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commander_ranks
    ADD CONSTRAINT fkcuykmrty12bm4tvyel72v5ow FOREIGN KEY (ranks_id) REFERENCES public.rank(id);


--
-- Name: newspaper_photos fkdeqpx1qx9sfbrmaqndoq3lvbb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newspaper_photos
    ADD CONSTRAINT fkdeqpx1qx9sfbrmaqndoq3lvbb FOREIGN KEY (newspaper_id) REFERENCES public.newspaper(id);


--
-- Name: command fkdn5me3o4lbhd45fmmw0hk8bkm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT fkdn5me3o4lbhd45fmmw0hk8bkm FOREIGN KEY (file_id) REFERENCES public.attachment(id);


--
-- Name: company fkdxfoamvt3n9eh5k4jmpr79ve0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT fkdxfoamvt3n9eh5k4jmpr79ve0 FOREIGN KEY (region_id) REFERENCES public.region(id);


--
-- Name: nomenklatura_file fke5hri3e30t6vwqhdunlwtdd1w; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura_file
    ADD CONSTRAINT fke5hri3e30t6vwqhdunlwtdd1w FOREIGN KEY (file_id) REFERENCES public.attachment(id);


--
-- Name: test_education_field fkecfnbyt1bu1msupi73ekm0gau; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_education_field
    ADD CONSTRAINT fkecfnbyt1bu1msupi73ekm0gau FOREIGN KEY (test1_id) REFERENCES public.test_subject(id);


--
-- Name: daily_control_sub_folder_content fkfk0w93y9justo0bvl4nfo3u0w; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder_content
    ADD CONSTRAINT fkfk0w93y9justo0bvl4nfo3u0w FOREIGN KEY (daily_control_sub_folder_id) REFERENCES public.daily_control_sub_folder(id);


--
-- Name: news_photos fkh0o110v0v312w8pj83cinx7j2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_photos
    ADD CONSTRAINT fkh0o110v0v312w8pj83cinx7j2 FOREIGN KEY (news_id) REFERENCES public.news(id);


--
-- Name: kitoblar fki258g7pxqc7p87f4nmk6owveh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar
    ADD CONSTRAINT fki258g7pxqc7p87f4nmk6owveh FOREIGN KEY (main_photo_id) REFERENCES public.attachment(id);


--
-- Name: command fkib6aaww739uwnxa1fil6065qc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT fkib6aaww739uwnxa1fil6065qc FOREIGN KEY (command_staff_id) REFERENCES public.staff(id);


--
-- Name: test_score fkidbcp6b9my1o06d9emt7w5mch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_score
    ADD CONSTRAINT fkidbcp6b9my1o06d9emt7w5mch FOREIGN KEY (abuturient_id) REFERENCES public.abuturient(id);


--
-- Name: duty fkigyt7j1l4cc0l7wm1d2ww1p01; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duty
    ADD CONSTRAINT fkigyt7j1l4cc0l7wm1d2ww1p01 FOREIGN KEY (staff_id) REFERENCES public.staff(id);


--
-- Name: gallery fkius1oservmq6pgkptykcs3p7q; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gallery
    ADD CONSTRAINT fkius1oservmq6pgkptykcs3p7q FOREIGN KEY (main_photo_id) REFERENCES public.attachment(id);


--
-- Name: command_message fkjimfurlvu424wgqu0bv3tpmsf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_message
    ADD CONSTRAINT fkjimfurlvu424wgqu0bv3tpmsf FOREIGN KEY (command_id) REFERENCES public.command(id);


--
-- Name: daily_control_sub_folder_content fkk34bmw2p649ugtwlb8y211urw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder_content
    ADD CONSTRAINT fkk34bmw2p649ugtwlb8y211urw FOREIGN KEY (staff_id) REFERENCES public.staff(id);


--
-- Name: daily_control_sub_folder fkknd0qn5kha2ufrg7h07pa6u71; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_control_sub_folder
    ADD CONSTRAINT fkknd0qn5kha2ufrg7h07pa6u71 FOREIGN KEY (daily_control_id) REFERENCES public.daily_control(id);


--
-- Name: my_test fkkpy8qsov5tas58wfd021itr8d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.my_test
    ADD CONSTRAINT fkkpy8qsov5tas58wfd021itr8d FOREIGN KEY (test_subject_id) REFERENCES public.test_subject(id);


--
-- Name: abuturient fkkqnce5yshkmekckl78a0enkwk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abuturient
    ADD CONSTRAINT fkkqnce5yshkmekckl78a0enkwk FOREIGN KEY (appeal_type_id) REFERENCES public.appeal_type(id);


--
-- Name: kitoblar_photos fkl7rtvgw7c0u6forflcx20deqv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitoblar_photos
    ADD CONSTRAINT fkl7rtvgw7c0u6forflcx20deqv FOREIGN KEY (photos_id) REFERENCES public.attachment(id);


--
-- Name: memorandum_photos fknjsln1bu5nqg9myf6m0dsfj3e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum_photos
    ADD CONSTRAINT fknjsln1bu5nqg9myf6m0dsfj3e FOREIGN KEY (photos_id) REFERENCES public.attachment(id);


--
-- Name: news_photos fko1s2a6x19tb44sm8xmayb4v6k; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_photos
    ADD CONSTRAINT fko1s2a6x19tb44sm8xmayb4v6k FOREIGN KEY (photos_id) REFERENCES public.attachment(id);


--
-- Name: certificate fkoeeenf4i3k1w9offp453di4b5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificate
    ADD CONSTRAINT fkoeeenf4i3k1w9offp453di4b5 FOREIGN KEY (abuturient_id) REFERENCES public.abuturient(id);


--
-- Name: command fkos60tbv7dr3e8i76uqabwvi0p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT fkos60tbv7dr3e8i76uqabwvi0p FOREIGN KEY (staff_id) REFERENCES public.staff(id);


--
-- Name: command_rating fkpbpvgbvily1mwakoea0orwbxs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_rating
    ADD CONSTRAINT fkpbpvgbvily1mwakoea0orwbxs FOREIGN KEY (command_id) REFERENCES public.command(id);


--
-- Name: nomenklatura_file fkqkn4ne6ylfvb7bbnm3y8y478y; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura_file
    ADD CONSTRAINT fkqkn4ne6ylfvb7bbnm3y8y478y FOREIGN KEY (nomenklatura_id) REFERENCES public.nomenklatura(id);


--
-- Name: command_message fkqptjjp3esbwtm2ots7h7upue4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command_message
    ADD CONSTRAINT fkqptjjp3esbwtm2ots7h7upue4 FOREIGN KEY (history_id) REFERENCES public.history(id);


--
-- Name: staff fkqqjurem6rl8b27a5ylsky41bs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT fkqqjurem6rl8b27a5ylsky41bs FOREIGN KEY (file_id) REFERENCES public.attachment(id);


--
-- Name: commander fkqwmyy8m2r8ywtsx0xa4gr2mml; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commander
    ADD CONSTRAINT fkqwmyy8m2r8ywtsx0xa4gr2mml FOREIGN KEY (rank_id) REFERENCES public.rank(id);


--
-- Name: nomenklatura fkr2vy6brgpflcpl99a0eqdl84; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT fkr2vy6brgpflcpl99a0eqdl84 FOREIGN KEY (user_id) REFERENCES public.staff(id);


--
-- Name: command fkrqqpk63p0uykwt1os9myr3hat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.command
    ADD CONSTRAINT fkrqqpk63p0uykwt1os9myr3hat FOREIGN KEY (response_file_id) REFERENCES public.attachment(id);


--
-- Name: memorandum_photos fkstwjmtj1jo53oyvxcemto4rte; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memorandum_photos
    ADD CONSTRAINT fkstwjmtj1jo53oyvxcemto4rte FOREIGN KEY (memorandum_id) REFERENCES public.memorandum(id);


--
-- PostgreSQL database dump complete
--

