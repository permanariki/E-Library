--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.0

-- Started on 2018-12-26 17:08:02

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 17496)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id integer NOT NULL,
    title character varying,
    number integer,
    published character varying,
    author character varying
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17507)
-- Name: book_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_history (
    id integer NOT NULL,
    lend_date character varying,
    return_date character varying,
    user_id integer,
    book_id integer
);


ALTER TABLE public.book_history OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17505)
-- Name: book_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_history_id_seq OWNER TO postgres;

--
-- TOC entry 2843 (class 0 OID 0)
-- Dependencies: 200
-- Name: book_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_history_id_seq OWNED BY public.book_history.id;


--
-- TOC entry 198 (class 1259 OID 17494)
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.book_id_seq OWNER TO postgres;

--
-- TOC entry 2844 (class 0 OID 0)
-- Dependencies: 198
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;


--
-- TOC entry 197 (class 1259 OID 17485)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(50),
    status character varying,
    password character varying,
    phone_number integer,
    address character varying
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 17483)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 2845 (class 0 OID 0)
-- Dependencies: 196
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 2701 (class 2604 OID 17499)
-- Name: book id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);


--
-- TOC entry 2702 (class 2604 OID 17510)
-- Name: book_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_history ALTER COLUMN id SET DEFAULT nextval('public.book_history_id_seq'::regclass);


--
-- TOC entry 2700 (class 2604 OID 17488)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 2835 (class 0 OID 17496)
-- Dependencies: 199
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (id, title, number, published, author) FROM stdin;
1	Lord of the rings I	1	1999	J.R.R Tolkien
2	Lord of the rings II	2	2000	J.R.R Tolkien
3	Lord of the rings III	3	2001	J.R.R Tolkien
4	Mengarang bebas	4	1998	Susi R.
\.


--
-- TOC entry 2837 (class 0 OID 17507)
-- Dependencies: 201
-- Data for Name: book_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_history (id, lend_date, return_date, user_id, book_id) FROM stdin;
\.


--
-- TOC entry 2833 (class 0 OID 17485)
-- Dependencies: 197
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, status, password, phone_number, address) FROM stdin;
1	riki	admin	1234	1234567890	Cimahi
2	andre	admin	1234	1234567890	Cimahi
3	Oka	user	\N	1234567890	Bandung
4	Nanda	user	\N	1234567890	Bandung
5	Fahmi	user	\N	1234567890	Bandung
\.


--
-- TOC entry 2846 (class 0 OID 0)
-- Dependencies: 200
-- Name: book_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_history_id_seq', 1, false);


--
-- TOC entry 2847 (class 0 OID 0)
-- Dependencies: 198
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_seq', 1, false);


--
-- TOC entry 2848 (class 0 OID 0)
-- Dependencies: 196
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- TOC entry 2708 (class 2606 OID 17515)
-- Name: book_history book_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_history
    ADD CONSTRAINT book_history_pkey PRIMARY KEY (id);


--
-- TOC entry 2706 (class 2606 OID 17504)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- TOC entry 2704 (class 2606 OID 17493)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2710 (class 2606 OID 17521)
-- Name: book_history book_history_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_history
    ADD CONSTRAINT book_history_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- TOC entry 2709 (class 2606 OID 17516)
-- Name: book_history book_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_history
    ADD CONSTRAINT book_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


-- Completed on 2018-12-26 17:08:03

--
-- PostgreSQL database dump complete
--

