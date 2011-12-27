--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: default; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: peat
--

CREATE TEXT SEARCH CONFIGURATION "default" (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR asciiword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR word WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR hword_part WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR hword_asciipart WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR asciihword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR hword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION "default"
    ADD MAPPING FOR uint WITH simple;


ALTER TEXT SEARCH CONFIGURATION public."default" OWNER TO peat;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authorities; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE authorities (
    id integer NOT NULL,
    name character varying(255),
    region_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.authorities OWNER TO peat;

--
-- Name: authorities_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE authorities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorities_id_seq OWNER TO peat;

--
-- Name: authorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE authorities_id_seq OWNED BY authorities.id;


--
-- Name: authorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('authorities_id_seq', 117, true);


--
-- Name: regions; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    native_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    parent_id integer,
    ancestry character varying(255)
);


ALTER TABLE public.regions OWNER TO peat;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO peat;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE countries_id_seq OWNED BY regions.id;


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('countries_id_seq', 109, true);


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE currencies (
    id integer NOT NULL,
    unit character varying(255) NOT NULL,
    region_id integer NOT NULL,
    symbol character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    authority_id integer
);


ALTER TABLE public.currencies OWNER TO peat;

--
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE currencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currencies_id_seq OWNER TO peat;

--
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE currencies_id_seq OWNED BY currencies.id;


--
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('currencies_id_seq', 149, true);


--
-- Name: grades; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE grades (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    description text,
    rank integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.grades OWNER TO peat;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO peat;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE grades_id_seq OWNED BY grades.id;


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('grades_id_seq', 1, false);


--
-- Name: masters; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE masters (
    id integer NOT NULL,
    currency_id integer NOT NULL,
    code character varying(255),
    denomination numeric NOT NULL,
    description text,
    overprint_currency_id integer,
    overprint_denomination numeric,
    issued_on date,
    printed_on date,
    withdrawn_on date,
    lapsed_on date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    printer_id integer
);


ALTER TABLE public.masters OWNER TO peat;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    master_id integer NOT NULL,
    printed_on date,
    serial character varying(255),
    description text,
    grade_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    replacement boolean DEFAULT false,
    specimen boolean DEFAULT false NOT NULL
);


ALTER TABLE public.notes OWNER TO peat;

--
-- Name: printers; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE printers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    region_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.printers OWNER TO peat;

--
-- Name: master_catalog; Type: VIEW; Schema: public; Owner: peat
--

CREATE VIEW master_catalog AS
    SELECT masters.id AS master_id, masters.currency_id, masters.code AS master_code, masters.denomination AS master_denomination, masters.overprint_currency_id, masters.overprint_denomination, masters.description AS master_description, masters.issued_on AS master_issued_on, masters.printed_on AS master_printed_on, masters.withdrawn_on AS master_withdrawn_on, masters.lapsed_on AS master_lapsed_on, masters.printer_id, (SELECT currencies.unit FROM currencies WHERE (currencies.id = masters.currency_id)) AS currency_unit, (SELECT regions.name FROM (regions JOIN currencies ON (((regions.id = currencies.region_id) AND (currencies.id = masters.currency_id))))) AS currency_region, (SELECT currencies.symbol FROM currencies WHERE (currencies.id = masters.currency_id)) AS currency_symbol, (SELECT currencies.unit FROM currencies WHERE (currencies.id = masters.overprint_currency_id)) AS overprint_currency_unit, (SELECT regions.name FROM (regions JOIN currencies ON (((regions.id = currencies.region_id) AND (currencies.id = masters.overprint_currency_id))))) AS overprint_currency_region, (SELECT currencies.symbol FROM currencies WHERE (currencies.id = masters.overprint_currency_id)) AS overprint_currency_symbol, (SELECT printers.name FROM printers WHERE (printers.id = masters.printer_id)) AS printer_name, (SELECT regions.name FROM (regions JOIN printers ON (((regions.id = printers.region_id) AND (printers.id = masters.printer_id))))) AS printer_region, (SELECT currencies.authority_id FROM currencies WHERE (currencies.id = masters.currency_id)) AS authority_id, (SELECT currencies.region_id FROM currencies WHERE (currencies.id = masters.currency_id)) AS region_id, (SELECT count(notes.id) AS count FROM notes WHERE (notes.master_id = masters.id)) AS note_count FROM masters;


ALTER TABLE public.master_catalog OWNER TO peat;

--
-- Name: masters_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE masters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.masters_id_seq OWNER TO peat;

--
-- Name: masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE masters_id_seq OWNED BY masters.id;


--
-- Name: masters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('masters_id_seq', 542, true);


--
-- Name: note_catalog; Type: VIEW; Schema: public; Owner: peat
--

CREATE VIEW note_catalog AS
    SELECT notes.id AS note_id, notes.master_id, notes.serial AS note_serial, notes.description AS note_description, notes.grade_id, notes.replacement AS note_replacement, masters.currency_id, masters.code AS master_code, masters.denomination AS master_denomination, masters.overprint_currency_id, masters.overprint_denomination, masters.description AS master_description, masters.issued_on AS master_issued_on, masters.printed_on AS master_printed_on, masters.withdrawn_on AS master_withdrawn_on, masters.lapsed_on AS master_lapsed_on, masters.printer_id, (SELECT currencies.unit FROM currencies WHERE (currencies.id = masters.currency_id)) AS currency_unit, (SELECT regions.name FROM (regions JOIN currencies ON (((regions.id = currencies.region_id) AND (currencies.id = masters.currency_id))))) AS currency_region, (SELECT currencies.symbol FROM currencies WHERE (currencies.id = masters.currency_id)) AS currency_symbol, (SELECT grades.name FROM grades WHERE (grades.id = notes.grade_id)) AS grade_name, (SELECT currencies.unit FROM currencies WHERE (currencies.id = masters.overprint_currency_id)) AS overprint_currency_unit, (SELECT regions.name FROM (regions JOIN currencies ON (((regions.id = currencies.region_id) AND (currencies.id = masters.overprint_currency_id))))) AS overprint_currency_region, (SELECT currencies.symbol FROM currencies WHERE (currencies.id = masters.overprint_currency_id)) AS overprint_currency_symbol, (SELECT printers.name FROM printers WHERE (printers.id = masters.printer_id)) AS printer_name, (SELECT regions.name FROM (regions JOIN printers ON (((regions.id = printers.region_id) AND (printers.id = masters.printer_id))))) AS printer_region FROM notes, masters WHERE (notes.master_id = masters.id);


ALTER TABLE public.note_catalog OWNER TO peat;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO peat;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('notes_id_seq', 848, true);


--
-- Name: printers_id_seq; Type: SEQUENCE; Schema: public; Owner: peat
--

CREATE SEQUENCE printers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.printers_id_seq OWNER TO peat;

--
-- Name: printers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: peat
--

ALTER SEQUENCE printers_id_seq OWNED BY printers.id;


--
-- Name: printers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: peat
--

SELECT pg_catalog.setval('printers_id_seq', 10, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: peat; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO peat;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE authorities ALTER COLUMN id SET DEFAULT nextval('authorities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE currencies ALTER COLUMN id SET DEFAULT nextval('currencies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE grades ALTER COLUMN id SET DEFAULT nextval('grades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE masters ALTER COLUMN id SET DEFAULT nextval('masters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE printers ALTER COLUMN id SET DEFAULT nextval('printers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: peat
--

ALTER TABLE regions ALTER COLUMN id SET DEFAULT nextval('countries_id_seq'::regclass);


--
-- Data for Name: authorities; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY authorities (id, name, region_id, created_at, updated_at) FROM stdin;
1	Da Afghanistan Bank	1	2009-04-29 17:38:40.702733	2009-04-29 17:38:40.702733
2	Banka E Shtetit Shqiptar	2	2009-04-29 18:57:11.835664	2009-04-29 18:57:11.835664
3	Banco Central de la Republica Argentina	3	2009-04-29 18:58:14.789542	2009-04-29 18:58:14.789542
4	Provincia de Tucuman	3	2009-04-29 18:58:46.121351	2009-04-29 18:58:46.121351
5	Central Bank of Armenia	4	2009-04-29 19:09:37.303463	2009-04-29 19:09:37.303463
6	Oberösterreich	5	2009-04-29 19:18:13.83782	2009-04-29 19:18:13.83782
7	Deiterreichilich-ungarilche Bank	5	2009-04-29 19:25:32.157188	2009-04-29 19:25:32.157188
8	Azərbaycan Milli Bankı	6	2009-04-29 19:50:25.989922	2009-04-29 19:50:25.989922
9	Central Bank of Bangladesh	7	2009-04-29 19:55:26.419425	2009-04-29 19:55:26.419425
10	Central Bank of Belarus	8	2009-04-29 19:59:04.288608	2009-04-29 19:59:04.288608
11	Royal Monetary Authority of Bhutan	9	2009-04-29 23:10:44.224318	2009-04-29 23:10:44.224318
12	Banco Central de Bolivia	10	2009-04-29 23:22:52.957474	2009-04-29 23:22:52.957474
13	Narodna Banka Bosne I Hercegovine	11	2009-04-29 23:25:54.573348	2009-04-29 23:25:54.573348
14	Banco Central do Brasil	12	2009-04-29 23:44:50.90043	2009-04-30 02:55:28.018709
15	Central Bank of Iraq	13	2009-04-30 04:43:48.037957	2009-04-30 04:43:48.037957
16	Narowdowy Bank Polski	14	2009-05-04 05:56:59.057098	2009-05-04 05:56:59.057098
18	The Japanese Government	16	2009-05-05 20:19:32.907437	2009-05-05 20:19:32.907437
19	The Japanese Government	17	2009-05-05 20:35:53.70058	2009-05-05 20:35:53.70058
20	Union of Burma Bank	17	2009-05-05 20:47:23.094345	2009-05-05 20:47:23.094345
21	The Japanese Government	18	2009-05-05 20:54:08.971079	2009-05-05 20:54:08.971079
22	Central Bank of the Philippines	18	2009-05-05 20:59:55.693734	2009-05-05 20:59:55.693734
17	Moscow MMM Loan Co.	15	2009-05-05 20:11:27.323733	2009-05-05 21:11:47.744573
23	Banque Nationale du Laos	19	2009-05-05 21:21:15.492099	2009-05-05 21:21:15.492099
24	Bank of Lao P.D.R.	19	2009-05-05 21:34:01.055603	2009-05-05 21:34:01.055603
25	Narodna Banka Jugoslavije	20	2009-05-05 21:38:00.760075	2009-05-05 21:38:00.760075
26	Банк России	15	2009-05-06 23:38:26.921359	2009-05-06 23:39:30.798523
27	Holzminden	21	2009-05-10 02:32:22.215579	2009-05-10 02:32:22.215579
28	Reichsbank	21	2009-05-10 02:47:17.424863	2009-05-10 02:47:17.424863
29	Central Bank of Tajikistan	22	2009-05-10 03:47:33.926168	2009-05-10 03:47:33.926168
30	Uzbekistan Central Bank	23	2009-05-10 03:56:07.100545	2009-05-10 03:56:07.100545
31	Kazakhstan Central Bank	24	2009-05-10 04:04:04.54596	2009-05-10 04:04:04.54596
32	National Bank of the Kyrgyz Republic	25	2009-05-10 04:16:56.376752	2009-05-10 04:16:56.376752
33	Государственный банк СССР	26	2009-05-10 04:28:50.701221	2009-05-10 04:28:50.701221
34	Central Bank of Bulgaria	27	2009-05-10 04:52:38.691442	2009-05-10 04:52:38.691442
35	National Bank of Ukraine	28	2009-05-10 05:19:09.652044	2009-05-10 05:19:09.652044
36	Transnistrian Republican Bank	29	2009-05-10 05:30:55.47321	2009-05-10 05:30:55.47321
37	Banque du Zaïre	30	2009-05-10 05:37:05.43981	2009-05-10 05:37:05.43981
38	Banco Central da Guiné-Bissau	31	2009-05-10 17:46:05.172506	2009-05-10 17:46:05.172506
39	Central Bank of Myanmar	32	2009-05-10 17:50:28.254026	2009-05-10 17:50:28.254026
40	Türkmenistanyn Merkezi Döwlet Banky	33	2009-05-10 18:06:47.45336	2009-05-10 18:06:47.45336
41	Banka Slovenije	34	2009-05-10 18:19:07.302865	2009-05-10 18:19:42.48901
42	Government of Pakistan	35	2009-05-10 18:31:52.645802	2009-05-10 18:31:52.645802
43	Lietuvos Bankas	36	2009-05-10 18:41:10.318278	2009-05-10 18:41:10.318278
44	State Bank of Vietnam	37	2009-05-10 19:40:47.282704	2009-05-10 19:40:47.282704
45	Mongolbank	38	2009-05-10 19:48:13.887497	2009-05-10 19:48:13.887497
46	British Armed Forces	39	2009-05-13 04:28:39.050575	2009-05-13 04:28:39.050575
47	Bank of England	39	2009-05-16 19:50:01.434162	2009-05-16 19:50:01.434162
48	Central Bank of Yemen	40	2009-05-17 20:43:43.339379	2009-05-17 20:43:43.339379
49	Banque Centrale de la Republique de Guinee	41	2009-05-17 20:48:32.315933	2009-05-17 20:48:32.315933
50	Bank of Zambia	42	2009-05-17 20:56:48.497797	2009-05-17 20:56:48.497797
51	Bank Indonesia	43	2009-05-17 20:59:59.653842	2009-05-17 20:59:59.653842
52	Bank of Croatia	44	2009-05-17 21:14:32.993065	2009-05-17 21:14:32.993065
53	Eesti Pank	45	2009-05-17 21:26:11.44392	2009-05-17 21:26:11.44392
54	Banque du Liban	46	2009-05-17 21:35:07.311821	2009-05-17 21:35:07.311821
55	Türkie Cumhuriyet Merkez Bankasi	47	2009-05-17 21:49:58.052743	2009-05-17 21:49:58.052743
56	Bank of Jamaica	48	2009-05-17 21:57:05.174124	2009-05-17 21:57:05.174124
57	Banco Central de Costa Rica	49	2009-05-17 22:01:24.340523	2009-05-17 22:01:24.340523
58	Centrale Bank van Suriname	51	2009-05-17 22:09:47.715008	2009-05-17 22:09:47.715008
59	Banque Nationale du Cambodge	52	2009-05-17 22:51:36.422712	2009-05-17 22:51:36.422712
60	People's National Bank of Kampuchea	52	2009-05-17 22:52:56.507389	2009-05-17 22:52:56.507389
61	National Bank of Cambodia	52	2009-05-17 23:16:39.809016	2009-05-17 23:16:39.809016
62	Banco Central de Venezuela	54	2009-05-21 04:20:59.992279	2009-05-21 04:20:59.992279
63	Banco Central del Ecuador	55	2009-05-21 04:31:28.806178	2009-05-21 04:32:16.96419
64	Bank of Sudan	56	2009-05-21 04:47:01.67077	2009-05-21 04:47:01.67077
65	Народна банка на Република Македонија	57	2009-05-23 19:23:36.332492	2009-05-23 19:23:36.332492
66	Banca Nationala a Romaniei	58	2009-05-23 19:30:06.145888	2009-05-23 19:30:06.145888
67	Banco Central de Honduras	59	2009-05-23 19:36:10.741629	2009-05-23 19:36:10.741629
68	Bank of Canada	60	2009-05-23 19:51:07.226474	2009-05-23 19:51:07.226474
69	Zhongguo Renmin Yinhang	61	2009-05-23 19:56:34.697216	2009-05-23 19:56:34.697216
70	Unknown	61	2009-05-23 20:00:46.861677	2009-05-23 20:00:46.861677
71	Banque Centrale du Congo	62	2009-05-23 20:37:17.021504	2009-05-23 20:37:17.021504
72	Bank of Egypt	63	2009-05-23 20:43:13.153381	2009-05-23 20:43:13.153381
73	Bank of Eritrea	64	2009-06-08 01:48:17.831683	2009-06-08 01:48:17.831683
74	National Bank of Georgia	65	2009-06-08 01:52:55.987345	2009-06-08 01:52:55.987345
75	Bank of Guyana	66	2009-06-08 01:59:35.759848	2009-06-08 01:59:35.759848
76	Banque de la Republique d'Haiti	67	2009-06-08 02:05:47.125873	2009-06-08 02:05:47.125873
77	Magyar Nemzeti Bank	68	2009-06-08 02:13:44.132607	2009-06-08 02:13:44.132607
78	Government of Hong Kong	69	2009-06-08 02:22:02.296835	2009-06-08 02:22:02.296835
79	Standard Chartered Bank	69	2009-06-08 02:24:28.213891	2009-06-08 02:24:28.213891
80	Sedlabanki Islands	70	2009-06-08 02:27:29.069513	2009-06-08 02:27:29.069513
81	Government of India	71	2009-06-08 02:30:24.123196	2009-06-08 02:30:24.123196
82	Latvijas Bankas	72	2009-06-08 02:34:11.760867	2009-06-08 02:34:11.760867
83	Banco de Mexico	73	2009-06-08 02:38:09.429651	2009-06-08 02:38:09.429651
84	Banco de Mocambique	74	2009-06-08 02:42:57.590307	2009-06-08 02:42:57.590307
85	Banco Nacional Ultramarino-Mocambique	74	2009-06-08 02:43:23.023142	2009-06-08 02:43:23.023142
86	Banco Nacional Ultramarino	74	2009-06-08 02:48:16.763902	2009-06-08 02:48:16.763902
87	Bank of Nepal	75	2009-06-08 03:10:26.532094	2009-06-08 03:10:26.532094
88	Reserve Bank of New Zealand	76	2009-06-08 03:14:21.245654	2009-06-08 03:14:21.245654
89	Banco Central de Nicaragua	77	2009-06-08 03:19:20.074467	2009-06-08 03:19:20.074467
90	Banque Centrale des Comores	78	2010-01-10 02:16:23.654568	2010-01-10 02:16:23.654568
91	Banco Central de Cuba	79	2010-01-10 02:26:25.222871	2010-01-10 02:26:25.222871
92	Reserve Bank of Zimbabwe	80	2010-01-10 19:12:14.631104	2010-01-10 19:12:14.631104
93	The Central Bank of Ireland	81	2010-01-11 06:32:37.012833	2010-01-11 06:32:37.012833
94	Banco Central de Reserva Del Peru	82	2010-04-18 21:11:19.844917	2010-04-18 21:11:19.844917
95	Banco Nacional de Angola	83	2011-01-10 03:53:47.986945	2011-01-10 03:53:47.986945
96	Government of the Hong Kong Special Administrative Region	69	2011-01-10 04:17:35.591788	2011-01-10 04:17:35.591788
97	Bank of Thailand	84	2011-01-10 04:29:09.749497	2011-01-10 04:29:09.749497
98	Banque Nationale de Belgique	85	2011-01-10 04:58:48.224306	2011-01-10 04:58:48.224306
99	Bank of the Cook Islands	86	2011-01-10 05:21:15.814087	2011-01-10 05:21:15.814087
100	Central Bank of Trinidad and Tobago	87	2011-01-10 19:32:29.098137	2011-01-10 19:32:29.098137
101	Banque de la Republique du Burundi	88	2011-01-11 02:52:56.792118	2011-01-11 02:52:56.792118
102	Baanka Somaliland	89	2011-01-11 03:26:35.082928	2011-01-11 03:26:35.082928
103	Bankiga Dhexe ee Soomaaliya	90	2011-01-11 03:36:20.749331	2011-01-11 03:36:20.749331
104	Central Bank of Oman	91	2011-01-11 03:43:48.744966	2011-01-11 03:43:48.744966
105	Banca Nationala a Moldovei	92	2011-01-11 04:24:48.022544	2011-01-11 04:24:48.022544
106	Philippine National Bank	18	2011-07-18 21:07:16.9664	2011-07-18 21:07:16.9664
107	Cebu Currency Committee	18	2011-07-18 21:08:12.120471	2011-07-18 21:08:12.120471
108	Negros Emergency Currency Board	18	2011-07-18 21:15:06.107862	2011-07-18 21:15:06.107862
109	Bohol Emergency Currency Board	18	2011-07-18 21:20:22.030306	2011-07-18 21:20:22.030306
110	Commonwealth of the Philippines Cagayan	18	2011-07-18 21:27:03.313184	2011-07-18 21:27:03.313184
111	Stadt Bad Kösen	103	2011-07-18 22:10:32.167677	2011-07-18 22:10:32.167677
112	Stadt Mühlberg an Elbe	104	2011-07-18 22:13:56.735725	2011-07-18 22:13:56.735725
113	Kreises Winsen	105	2011-07-18 22:17:21.106586	2011-07-18 22:17:21.106586
114	Stadt Quedlinburg	106	2011-07-18 22:20:55.231187	2011-07-18 22:20:55.231187
115	Stadt Bad Salzig	107	2011-07-18 22:25:40.144164	2011-07-18 22:25:40.144164
116	Korean Central Bank	108	2011-12-27 05:09:45.207605	2011-12-27 05:09:45.207605
117	Singapore Bank ?	109	2011-12-27 11:34:33.406288	2011-12-27 11:34:33.406288
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY currencies (id, unit, region_id, symbol, created_at, updated_at, authority_id) FROM stdin;
1	Afghani	1		2009-04-29 05:38:37.263327	2009-04-29 17:39:39.32346	1
2	Lek	2		2009-04-29 06:25:39.082976	2009-04-29 18:57:29.05061	2
3	Austral	3		2009-04-29 06:28:37.530669	2009-04-29 19:00:33.240438	3
6	Austral	3		2009-04-29 19:01:47.516355	2009-04-29 19:01:47.516355	4
4	Peso	3		2009-04-29 06:50:48.923424	2009-04-29 19:02:52.527496	3
5	Pesos Argentinos	3		2009-04-29 07:11:31.204381	2009-04-29 19:03:04.840593	3
7	Dram	4		2009-04-29 19:09:56.109783	2009-04-29 19:09:56.109783	5
8	Heller	5		2009-04-29 19:20:44.549746	2009-04-29 19:20:44.549746	6
9	Krone	5		2009-04-29 19:25:39.792703	2009-04-29 19:25:39.792703	7
10	Manat	6		2009-04-29 19:50:52.150066	2009-04-29 19:50:52.150066	8
11	Taka	7		2009-04-29 19:55:33.344713	2009-04-29 19:55:33.344713	9
12	Kapeek	8		2009-04-29 19:59:15.290622	2009-04-29 19:59:15.290622	10
14	Ngultrum	9		2009-04-29 23:10:51.587253	2009-04-29 23:10:51.587253	11
15	Pesos Bolivianos	10		2009-04-29 23:23:01.54538	2009-04-29 23:23:01.54538	12
16	Dinara	11		2009-04-29 23:26:06.331438	2009-04-29 23:26:06.331438	13
17	Cruzeiro	12		2009-04-29 23:38:18.5504	2009-04-29 23:45:03.44588	14
18	Centavo	12		2009-04-29 23:57:12.309109	2009-04-29 23:57:12.309109	14
19	Cruzados Novos	12		2009-04-30 02:55:09.193492	2009-04-30 02:55:09.193492	14
20	Cruzeiros Reais	12		2009-04-30 03:17:42.597993	2009-04-30 03:17:42.597993	14
13	Rublei	8		2009-04-29 20:01:29.498771	2009-04-30 04:23:02.316786	10
22	Dinar	13		2009-04-30 04:43:51.876942	2009-04-30 04:43:51.876942	15
23	Zlotych	14		2009-05-04 05:59:14.758678	2009-05-04 06:11:11.090102	16
26	Dollar	16		2009-05-05 20:19:38.067942	2009-05-05 20:19:38.067942	18
27	Rupee	17		2009-05-05 20:35:59.924916	2009-05-05 20:35:59.924916	19
28	Kyat	17		2009-05-05 20:47:27.775396	2009-05-05 20:47:27.775396	20
29	Peso	18		2009-05-05 20:54:14.879298	2009-05-05 20:54:14.879298	21
32	Piso	18		2009-05-05 21:03:19.76203	2009-05-05 21:03:19.76203	22
25	Mavrodi Biletov	15		2009-05-05 20:12:29.87685	2009-05-05 21:11:24.785874	17
21	Cruzado	12		2009-04-30 03:21:29.11041	2009-05-05 21:12:25.497364	14
30	Centavo	18		2009-05-05 20:57:39.442947	2009-05-05 21:12:43.090024	21
31	Centavo	18		2009-05-05 21:00:01.906904	2009-05-05 21:12:51.750363	22
34	Kip	19		2009-05-05 21:21:20.86227	2009-05-05 21:21:20.86227	23
33	Kip	19		2009-05-05 21:17:38.415625	2009-05-05 21:34:24.86158	24
35	Dinara	20		2009-05-05 21:38:07.555113	2009-05-05 21:38:07.555113	25
24	Ruble	15		2009-05-05 20:06:58.816871	2009-05-06 23:38:41.357529	26
36	Pfennig	21		2009-05-10 02:32:32.482899	2009-05-10 02:32:32.482899	27
37	Mark	21		2009-05-10 02:49:22.710134	2009-05-10 02:49:22.710134	28
38	Ruble	22		2009-05-10 03:49:05.237279	2009-05-10 03:49:05.237279	29
39	Diram	22		2009-05-10 03:52:15.931954	2009-05-10 03:52:15.931954	29
40	Sum	23		2009-05-10 03:57:10.090409	2009-05-10 03:57:10.090409	30
41	Tenge	24		2009-05-10 04:04:43.797607	2009-05-10 04:04:43.797607	31
42	Tyin	24		2009-05-10 04:08:00.907492	2009-05-10 04:08:00.907492	31
43	Tyiyn	25		2009-05-10 04:17:38.924979	2009-05-10 04:17:38.924979	32
44	Ruble	26		2009-05-10 04:29:06.452656	2009-05-10 04:29:06.452656	33
45	Lev	27		2009-05-10 04:52:43.291926	2009-05-10 04:52:43.291926	34
46	Som	25		2009-05-10 05:14:35.132765	2009-05-10 05:14:35.132765	32
47	Karbovanets	28		2009-05-10 05:19:35.881876	2009-05-10 05:19:35.881876	35
48	Karbovantsiv	28		2009-05-10 05:24:01.79989	2009-05-10 05:24:01.79989	35
49	Ruble	29		2009-05-10 05:31:04.32701	2009-05-10 05:31:04.32701	36
50	Nouveau Likuta	30		2009-05-10 05:37:47.040702	2009-05-10 05:37:47.040702	37
51	Nouveaux Makuta	30		2009-05-10 05:40:20.488137	2009-05-10 05:40:20.488137	37
52	Nouveau Zaire	30		2009-05-10 05:42:04.165661	2009-05-10 05:42:04.165661	37
53	Peso	31		2009-05-10 17:46:12.216604	2009-05-10 17:46:12.216604	38
54	Pya	32		2009-05-10 17:50:35.164572	2009-05-10 17:50:35.164572	39
55	Kyat	32		2009-05-10 17:52:24.009022	2009-05-10 17:52:24.009022	39
56	Manat	33		2009-05-10 18:07:04.960932	2009-05-10 18:07:04.960932	40
57	Tolar	34		2009-05-10 18:21:29.174536	2009-05-10 18:21:29.174536	41
58	Rupee	35		2009-05-10 18:34:13.685089	2009-05-10 18:34:13.685089	42
59	Talonas	36		2009-05-10 18:41:53.223669	2009-05-10 18:41:53.223669	43
60	Talonu	36		2009-05-10 18:51:32.194132	2009-05-10 18:51:32.194132	43
61	Dong	37		2009-05-10 19:40:53.497519	2009-05-10 19:40:53.497519	44
62	Möngö	38		2009-05-10 19:51:08.153293	2009-05-10 19:51:08.153293	45
63	Tugrik	38		2009-05-13 03:20:43.879905	2009-05-13 03:20:43.879905	45
64	Pence	39		2009-05-13 04:28:45.788763	2009-05-13 04:28:45.788763	46
65	Pound	39		2009-05-16 19:37:49.42264	2009-05-16 19:37:49.42264	46
66	Pound	39		2009-05-16 19:50:15.234338	2009-05-16 19:50:15.234338	47
67	Rial	40		2009-05-17 20:43:49.292863	2009-05-17 20:43:49.292863	48
68	Syli	41		2009-05-17 20:49:11.246033	2009-05-17 20:49:11.246033	49
69	Franc	41		2009-05-17 20:52:58.311365	2009-05-17 20:52:58.311365	49
70	Kwacha	42		2009-05-17 20:56:58.528008	2009-05-17 20:56:58.528008	50
71	Sen	43		2009-05-17 21:00:10.237586	2009-05-17 21:00:10.237586	51
72	Rupiah	43		2009-05-17 21:06:27.573841	2009-05-17 21:06:27.573841	51
73	Dinar	44		2009-05-17 21:14:38.733358	2009-05-17 21:14:38.733358	52
74	Kroon	45		2009-05-17 21:29:33.395505	2009-05-17 21:29:33.395505	53
75	Livre	46		2009-05-17 21:35:17.582229	2009-05-17 21:35:17.582229	54
76	Lira	47		2009-05-17 21:50:16.505947	2009-05-17 21:50:16.505947	55
77	Dollar	48		2009-05-17 21:57:10.44471	2009-05-17 21:57:10.44471	56
78	Colon	49		2009-05-17 22:01:48.196209	2009-05-17 22:01:48.196209	57
79	Gulden	51		2009-05-17 22:09:58.571233	2009-05-17 22:09:58.571233	58
81	Riel	52		2009-05-17 22:51:46.649007	2009-05-17 22:51:46.649007	59
80	Riel	52		2009-05-17 22:46:57.47863	2009-05-17 22:53:14.874507	60
82	Riel	52		2009-05-17 23:16:53.432096	2009-05-17 23:16:53.432096	61
83	Bolivar	54		2009-05-21 04:21:06.261282	2009-05-21 04:21:06.261282	62
84	Sucre	55		2009-05-21 04:32:56.427527	2009-05-21 04:32:56.427527	63
85	Pound	56		2009-05-21 04:47:08.123461	2009-05-21 04:47:08.123461	64
86	Piastre	56		2009-05-23 19:17:10.1342	2009-05-23 19:17:10.1342	64
87	Denar	57		2009-05-23 19:25:10.805356	2009-05-23 19:25:10.805356	65
88	Leu	58		2009-05-23 19:30:31.227512	2009-05-23 19:30:31.227512	66
89	Lempira	59		2009-05-23 19:36:19.268867	2009-05-23 19:36:19.268867	67
90	Dollar	60		2009-05-23 19:51:16.406639	2009-05-23 19:51:16.406639	68
91	Jiao	61		2009-05-23 19:56:47.662632	2009-05-23 19:56:47.662632	69
92	Unknown	61		2009-05-23 20:00:52.976996	2009-05-23 20:00:52.976996	70
93	Yuan	61		2009-05-23 20:03:36.478938	2009-05-23 20:03:36.478938	69
94	Rice Coupon	61		2009-05-23 20:06:53.073148	2009-05-23 20:12:42.614646	70
95	Kilo (Ration Coupon)	61		2009-05-23 20:26:12.616187	2009-05-23 20:27:36.871595	70
96	Centime	62		2009-05-23 20:38:09.591528	2009-05-23 20:38:09.591528	71
97	Piastres	63		2009-05-23 20:43:24.084626	2009-05-23 20:43:24.084626	72
98	Nakfa	64		2009-06-08 01:48:26.58819	2009-06-08 01:48:26.58819	73
99	Lari	65		2009-06-08 01:53:12.131094	2009-06-08 01:53:12.131094	74
100	Dollar	66		2009-06-08 01:59:41.262252	2009-06-08 01:59:41.262252	75
101	Gourde	67		2009-06-08 02:06:03.093681	2009-06-08 02:06:03.093681	76
102	Forint	68		2009-06-08 02:13:52.847221	2009-06-08 02:13:52.847221	77
103	Pengo	68		2009-06-08 02:16:20.410026	2009-06-08 02:16:20.410026	77
104	Cent	69		2009-06-08 02:22:06.638441	2009-06-08 02:22:06.638441	78
105	Dollar	69		2009-06-08 02:24:33.77475	2009-06-08 02:24:33.77475	79
106	Kronur	70		2009-06-08 02:28:32.731136	2009-06-08 02:28:32.731136	80
107	Rupee	71		2009-06-08 02:30:29.557701	2009-06-08 02:30:29.557701	81
108	Rublis	72		2009-06-08 02:34:32.640815	2009-06-08 02:34:32.640815	82
109	Pesos	73		2009-06-08 02:38:24.836238	2009-06-08 02:38:24.836238	83
110	Escudos	74		2009-06-08 02:43:10.903541	2009-06-08 02:43:10.903541	84
111	Escudos	74		2009-06-08 02:43:33.753422	2009-06-08 02:43:33.753422	85
112	Meticais	74		2009-06-08 02:46:03.640661	2009-06-08 02:46:03.640661	85
113	Escudos	74		2009-06-08 02:48:23.537706	2009-06-08 02:48:23.537706	86
114	Rupee	75		2009-06-08 03:10:31.042061	2009-06-08 03:10:31.042061	87
115	Dollar	76		2009-06-08 03:14:25.162105	2009-06-08 03:14:25.162105	88
116	Cordoba	77		2009-06-08 03:19:57.046357	2009-06-08 03:19:57.046357	89
117	Centavo	77		2009-06-08 03:21:32.240108	2009-06-08 03:21:32.240108	89
118	Comorian Franc	78		2010-01-10 02:17:00.082085	2010-01-10 02:17:00.082085	90
119	Peso	79		2010-01-10 02:26:36.504857	2010-01-10 02:26:36.504857	91
120	Franc	62		2010-01-10 18:50:17.805077	2010-01-10 18:50:17.805077	71
121	Dollar	80		2010-01-10 19:12:25.053644	2010-01-10 19:12:25.053644	92
122	Pound	81		2010-01-11 06:32:43.851774	2010-01-11 06:32:43.851774	93
123	Soles de Oro	82		2010-04-18 21:11:35.613427	2010-04-18 21:11:35.613427	94
124	Intis	82		2010-04-18 21:17:20.864708	2010-04-18 21:17:20.864708	94
125	Kwanza	83		2011-01-10 03:53:53.101488	2011-01-10 03:53:53.101488	95
126	Dollar	69		2011-01-10 04:17:54.747854	2011-01-10 04:17:54.747854	96
127	Baht	84		2011-01-10 04:29:27.996602	2011-01-10 04:29:27.996602	97
128	Francs / Belgas	85		2011-01-10 04:59:05.70125	2011-01-10 04:59:05.70125	98
129	Dollar	86		2011-01-10 05:21:21.575047	2011-01-10 05:21:21.575047	99
130	Dollar	87		2011-01-10 19:32:35.929239	2011-01-10 19:32:35.929239	100
131	Francs	88		2011-01-11 02:54:24.957897	2011-01-11 02:54:24.957897	101
132	Shilling	89		2011-01-11 03:26:45.930632	2011-01-11 03:26:45.930632	102
133	Shillings	90		2011-01-11 03:36:26.4241	2011-01-11 03:36:26.4241	103
134	Baisa	91		2011-01-11 03:43:54.667879	2011-01-11 03:43:54.667879	104
135	Leu	92		2011-01-11 04:24:53.998038	2011-01-11 04:24:53.998038	105
136	Peso	18		2011-07-18 21:07:24.760892	2011-07-18 21:07:24.760892	106
137	Peso	18		2011-07-18 21:08:23.48312	2011-07-18 21:12:47.696712	107
138	Peso	18		2011-07-18 21:15:15.140943	2011-07-18 21:15:15.140943	108
139	Peso	18		2011-07-18 21:20:27.916532	2011-07-18 21:20:53.422479	109
140	Centavos	18		2011-07-18 21:24:15.687909	2011-07-18 21:24:15.687909	109
141	Peso	18		2011-07-18 21:27:11.123888	2011-07-18 21:27:11.123888	110
142	Pfennig	103		2011-07-18 22:10:41.148353	2011-07-18 22:10:41.148353	111
143	Pfennig	104		2011-07-18 22:14:03.066464	2011-07-18 22:14:03.066464	112
144	Pfennig	105		2011-07-18 22:17:27.715552	2011-07-18 22:17:27.715552	113
145	Pfennig	106		2011-07-18 22:21:00.093856	2011-07-18 22:21:00.093856	114
146	Pfennig	107		2011-07-18 22:25:49.658487	2011-07-18 22:25:49.658487	115
147	Won	108		2011-12-27 05:09:54.155297	2011-12-27 05:09:54.155297	116
148	Chon	108		2011-12-27 10:16:44.565682	2011-12-27 10:16:44.565682	116
149	Dollar	109		2011-12-27 11:34:44.634352	2011-12-27 11:34:44.634352	117
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY grades (id, name, full_name, description, rank, created_at, updated_at) FROM stdin;
5953181	XF	Extremely Fine	A very attractive note, with light handling. May have a maximum of three light folds or one strong crease. Paper is clean and bright with original sheen. Corners may show only the slightest evidence of rounding. There may also be the slightest sign of wear where a fold meets the edge.	3	2009-04-29 05:33:55	2009-04-29 05:33:55
82	P	Poor	A "rag" with severe damage because of wear, staining, pieces missing, graffiti, larger holes. May have tape holding  pieces of the note together. Trimming may have taken place to remove rough edges. A Poor note is desirable only as a "filler" or when such note is the only one known of that particular issue.	8	2009-04-29 05:33:55	2009-04-29 05:33:55
5817883	VF	Very Fine	An attractive note, but with more evidence of handling and wear. May have a number of folds both vertically and horizontally. Paper may have minimal dirt, or possible color smudging. Paper itself is still relatively crisp and not floppy. There are no tears into the border area, although the edges do show slight wear. Corners also show wear but not full rounding.	4	2009-04-29 05:33:55	2009-04-29 05:33:55
5817884	VG	VG	A well used note, abused but still intact. Corners may have much wear and rounding, tiny nicks, tears may extend into the design, some discoloration may be present, staining may have occurred, and a small hole may be seen at center from excessive folding. Staple and pinholes are usually present, and the note itself is quite limp but NO pieces of the note can be missing. A note in VG condition may still have an overall not unattractive appearance.	6	2009-04-29 05:33:55	2009-04-29 05:33:55
72	F	Fine	A note which shows considerable circulation with many folds, creases and wrinkling. Paper is not excessively dirty, but may have some softness. Edges may show much handling with minor tears in the border area. Tears may not extend into the design. There will be no center hole because of folding. Colors are clear but not bright. A staple hole or two would not be considered unusual wear in a Fine note. Overall appearance is still on the desirable side.	5	2009-04-29 05:33:55	2009-04-29 05:33:55
73	G	Good	A well worn and heavily used note. Normal damage from prolonged circulation will include strong multiple folds and creases, stains, pinholes, and/or staple holes, dirt, discoloration, edge tears, center hole, rounded corners and an overall unattractive appearance. No large pieces of the note may be missing. Graffiti is commonly seen on notes in Good condition.	7	2009-04-29 05:33:55	2009-04-29 05:33:55
4397270	AU	About Uncirculated	A virtually perfect note, with some minor handling. May show evidence of bank counting folds at a corner or one light fold through the center, but not both. An AU note cannot be creased, a crease being a hard fold which has usually "broken" the surface of a note. Paper is clean and bright with original sheen.  Corners are not rounded.	2	2009-04-29 05:33:55	2009-04-29 05:33:55
729449236	UNC	Uncirculated	A perfectly preserved note, never mishandled by the issuing authority, a bank teller, the public or a collector. Paper is clean and firm, without discoloration. Corners are sharp and square, without any evidence of rounding. (Rounded corners are often telltale sign of a cleaned or "doctored" note.) An uncirculated note will have its original natural sheen.	1	2009-04-29 05:33:55	2009-04-29 05:33:55
\.


--
-- Data for Name: masters; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY masters (id, currency_id, code, denomination, description, overprint_currency_id, overprint_denomination, issued_on, printed_on, withdrawn_on, lapsed_on, created_at, updated_at, printer_id) FROM stdin;
107	26	P-M5	1.0	Black w/ pink seal, fruit; blue printed 1s	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:21:09.089802	2009-05-05 20:21:09.089802	\N
113	27	P-16	10.0	Maroon over light green, palm and temple	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:40:45.154024	2009-05-05 20:40:45.154024	\N
119	31	P-126	5.0	Red printing, "R" signature	\N	0.0	1949-01-01	\N	\N	\N	2009-05-05 21:01:44.880005	2009-05-05 21:01:44.880005	\N
125	33	P-20a	10.0	Nurse attending child and mothers; soldiers setting traps	\N	0.0	1979-01-01	\N	\N	\N	2009-05-05 21:26:02.310538	2009-05-05 21:26:02.310538	\N
131	35	P-89	50.0	Sculpture, two men.  Security strip.	\N	0.0	1978-01-01	\N	\N	\N	2009-05-05 21:46:05.464541	2009-05-05 21:46:05.464541	\N
143	35	P-128	5000.0	Red Nikola Tesla; building	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:10:12.731722	2009-05-05 22:10:12.731722	\N
149	35	P-130	50000.0	Purple man with mustache, beard, hat; large church	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:22:46.548402	2009-05-05 22:22:46.548402	\N
155	35	P-133	50000000.0	Man with mustache, glasses; building	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:33:15.503661	2009-05-05 22:33:15.503661	\N
29	13	P-2	1.0	Hare	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:01:54.682627	2009-04-29 20:01:54.682627	\N
1	1	P-55	10.0	Green, mountain road	\N	0.0	1979-01-01	\N	\N	\N	2009-04-29 05:46:33.748989	2009-04-29 05:46:33.748989	\N
2	1	P-56	20.0	Yellow; mountains w/ buildings	\N	0.0	1979-01-01	\N	\N	\N	2009-04-29 06:19:36.843618	2009-04-29 06:19:36.843618	\N
4	1	P-58	100.0	Red; farm worker; dam	\N	0.0	1990-01-01	\N	\N	\N	2009-04-29 06:23:28.49699	2009-04-29 06:23:28.49699	\N
3	1	P-57	50.0	Green; building surrounded by trees	\N	0.0	1991-01-01	\N	\N	\N	2009-04-29 06:21:00.133545	2009-04-29 06:24:32.525811	\N
5	2	P-40	1.0	Shkodra castle; peasant couple	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 06:27:29.216773	2009-04-29 06:27:29.216773	\N
6	3	P-323	1.0	Rivadavia; Liberty	\N	0.0	1985-01-01	\N	\N	\N	2009-04-29 06:31:00.653855	2009-04-29 06:31:00.653855	\N
7	3	P-324	5.0	Urquiza; Liberty	\N	0.0	1985-01-01	\N	\N	\N	2009-04-29 06:35:49.856087	2009-04-29 06:35:49.856087	\N
8	3	P-325	10.0	Santiago Derqui; Liberty	\N	0.0	1985-01-01	\N	\N	\N	2009-04-29 06:39:50.715964	2009-04-29 06:39:50.715964	\N
9	3	P-326	50.0	Bartolome Mitre; Liberty	\N	0.0	1985-01-01	\N	\N	\N	2009-04-29 06:41:47.413505	2009-04-29 06:41:47.413505	\N
10	3	P-327	100.0	Domingo F Sarmiento; Liberty	\N	0.0	1985-01-01	\N	\N	\N	2009-04-29 06:43:10.381003	2009-04-29 06:43:10.381003	\N
14	4	P-303	500.0	San Martin; Cerro de la Gloria, Mendoza	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 06:59:08.215319	2009-04-29 06:59:08.215319	\N
15	4	P-302	100.0	San Martin; harbour	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 07:00:11.769822	2009-04-29 07:00:11.769822	\N
12	4	P-304	1000.0	San Martin; Plaza de Mayo.  More colorful than other P-304.	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 06:51:36.342108	2009-04-29 07:06:47.381646	\N
17	5	P-314	50.0	San Martin; Jujuy Termas de Reyes.  More colorful than older P-301	\N	0.0	1983-01-01	\N	\N	\N	2009-04-29 07:04:13.874035	2009-04-29 07:12:27.057071	\N
18	4	P-300	10.0	Belgrano; Cataratas del Iguazu.	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 07:14:02.410949	2009-04-29 07:14:02.410949	\N
45	16	P-11	25.0	Blue, crown w/ arm and sword	\N	0.0	1992-07-01	\N	\N	\N	2009-04-29 23:26:46.482587	2009-04-29 23:26:46.482587	\N
48	16	P-15	1000.0	Green and red, Mostar bridge	\N	0.0	1992-07-01	\N	\N	\N	2009-04-29 23:30:16.355114	2009-04-29 23:30:16.355114	\N
108	26	P-M6	5.0	Dark red printing	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:23:42.122615	2009-05-05 20:23:42.122615	\N
114	27	P-17	100.0	Green over purple, palm and temple	\N	0.0	1944-01-01	\N	\N	\N	2009-05-05 20:44:01.43826	2009-05-05 20:44:01.43826	\N
120	32	P-159c	2.0	Jose Rizal; revolution scene.  Serial number printed in red	\N	0.0	1978-01-01	\N	\N	\N	2009-05-05 21:06:00.13158	2009-05-05 21:06:00.13158	\N
126	33	P-29	50.0	Rice planting, harvesting; hydroelectric dam	\N	0.0	1979-01-01	\N	\N	\N	2009-05-05 21:28:30.550561	2009-05-05 21:28:30.550561	\N
132	35	P-90b	100.0	Sculpture of man on horse	\N	0.0	1981-01-01	\N	\N	\N	2009-05-05 21:47:48.928098	2009-05-05 21:47:48.928098	\N
138	35	P-113	500.0	Purple N. Hrvanovic	\N	0.0	1992-01-01	\N	\N	\N	2009-05-05 22:01:01.193529	2009-05-05 22:01:01.193529	\N
144	35	P-141	5000.0	Man with long hair, blue and orange crest; old church	\N	0.0	1994-01-01	\N	\N	\N	2009-05-05 22:13:14.643279	2009-05-05 22:13:14.643279	\N
150	35	P-118	100000.0	Woman with head dress; sunflowers	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:24:53.561373	2009-05-05 22:24:53.561373	\N
49	16	P-14	500.0	Pink and yellow, crown w/ arm and sword	\N	0.0	1992-07-01	\N	\N	\N	2009-04-29 23:31:14.948412	2009-04-29 23:31:14.948412	\N
55	17	P-183b	10.0	Getulio Vargas; Unidade Nacional.  Green.	18	1.0	1967-01-01	\N	\N	\N	2009-04-30 00:00:19.425672	2009-04-30 00:00:19.425672	\N
47	16	P-10	10.0	Orange, Mostar bridge	\N	0.0	1992-07-01	\N	\N	\N	2009-04-29 23:29:04.935062	2009-04-30 02:32:15.813657	\N
46	16	P-12	50.0	Red, Mostar bridge	\N	0.0	1992-07-01	\N	\N	\N	2009-04-29 23:27:55.093322	2009-04-30 02:35:05.69869	\N
52	17	P-151	2.0	Duque de Caxias; Escola Militar de Rezende (bright orange)	\N	0.0	1954-01-01	\N	\N	\N	2009-04-29 23:48:16.915187	2009-04-30 02:35:35.150018	\N
56	17	P-167	10.0	Blue, Getulio Vargas; Unidade Nacional.  American Bank Note Company.	\N	0.0	1961-01-01	\N	\N	\N	2009-04-30 02:40:26.407869	2009-04-30 02:40:26.407869	\N
58	17	P-166b	5.0	Indian man; Vitoria Regia.  Casa da Moeda do Brasil.	\N	0.0	1961-01-01	\N	\N	\N	2009-04-30 02:47:27.106077	2009-04-30 02:47:27.106077	\N
59	17	P-191A	1.0	Green Liberty; Banco Central	\N	0.0	1972-01-01	\N	\N	\N	2009-04-30 02:50:24.797875	2009-04-30 02:50:24.797875	\N
60	17	P-192d	5.0	D Pedro I; Parade square	\N	0.0	1979-01-01	\N	\N	\N	2009-04-30 02:52:30.781373	2009-04-30 02:52:30.781373	\N
61	17	P-193d	10.0	D. Pedro II; Propeta Daniel	\N	0.0	1980-01-01	\N	\N	\N	2009-04-30 02:54:20.48032	2009-04-30 02:54:20.48032	\N
63	19	P-220a	100.0	Meireles, crane; boy reading, dancers	\N	0.0	1989-01-01	\N	\N	\N	2009-04-30 03:00:35.818635	2009-04-30 03:00:35.818635	\N
62	19	P-223	50.0	Poet de Andrade; Poem	17	50.0	1991-01-01	\N	\N	\N	2009-04-30 02:57:50.14136	2009-04-30 03:01:21.246492	\N
64	19	P-220x	100.0	Meireles, crane; boy reading, dancers	\N	0.0	1989-01-01	\N	\N	\N	2009-04-30 03:02:48.833185	2009-04-30 03:02:48.833185	\N
65	19	P-224	100.0	Meireles, crane; boy reading, dancers	17	100.0	1991-01-01	\N	\N	\N	2009-04-30 03:04:08.627264	2009-04-30 03:04:08.627264	\N
66	17	P-229	200.0	Liberty; "Patria" oleo de Pedro Bruno	\N	0.0	1992-01-01	\N	\N	\N	2009-04-30 03:06:03.432846	2009-04-30 03:06:03.432846	\N
67	19	P-225	200.0	Liberty; "Patria" oleo de Pedro Bruno	\N	0.0	1991-01-01	\N	\N	\N	2009-04-30 03:07:23.273969	2009-04-30 03:07:23.273969	\N
68	19	P-226	500.0	Augusto Ruschi; Hummingbird, flowers	17	500.0	1991-01-01	\N	\N	\N	2009-04-30 03:09:24.29125	2009-04-30 03:09:24.29125	\N
69	17	P-231c	1000.0	Candido Rondon; Natives, fish	\N	0.0	1991-01-01	\N	\N	\N	2009-04-30 03:11:18.191535	2009-04-30 03:11:18.191535	\N
70	17	P-232	5000.0	Carlos Gomes; Piano, statue	\N	0.0	1992-01-01	\N	\N	\N	2009-04-30 03:12:25.113814	2009-04-30 03:12:25.113814	\N
72	17	P-234	50000.0	Camara Cascudo; Bumba-Meu-Boi, native costumes	\N	0.0	1992-01-01	\N	\N	\N	2009-04-30 03:15:01.789292	2009-04-30 03:15:01.789292	\N
73	17	P-235d	100000.0	Bird, beija-flor; Waterfall, cataratas do Iguacu	\N	0.0	1993-01-01	\N	\N	\N	2009-04-30 03:16:37.663157	2009-04-30 03:16:37.663157	\N
74	17	P-238	100000.0	Bird, beija-flor; Waterfall, cataratas do Iguacu	20	100.0	1993-01-01	\N	\N	\N	2009-04-30 03:18:35.412008	2009-04-30 03:18:35.412008	\N
75	17	P-227	5000.0	Liberty; Coat of arms	\N	0.0	1990-01-01	\N	\N	\N	2009-04-30 03:20:45.215736	2009-04-30 03:20:45.215736	\N
76	21	P-210	50.0	Oswaldo Cruz, microscope; Instituto Oswaldo Cruz	\N	0.0	1986-01-01	\N	\N	\N	2009-04-30 03:22:27.466833	2009-04-30 03:22:27.466833	\N
78	21	P-212c	500.0	Villa Lobos; conductor	\N	0.0	1987-01-01	\N	\N	\N	2009-04-30 03:25:21.688387	2009-04-30 03:25:21.688387	\N
79	21	P-216	1000.0	Machado de Assis; Rio de Janeiro	19	1.0	1989-01-01	\N	\N	\N	2009-04-30 03:28:24.930128	2009-04-30 03:28:24.930128	\N
80	21	P-213b	1000.0	Machado de Assis; Rio de Janeiro	\N	0.0	1988-01-01	\N	\N	\N	2009-04-30 03:29:35.882273	2009-04-30 03:29:35.882273	\N
81	21	P-217	5000.0	Candido Portinari; drawing	19	5.0	1989-01-01	\N	\N	\N	2009-04-30 03:31:11.948813	2009-04-30 03:31:11.948813	\N
57	17	P-183	50.0	Princesa Isabel; Lei Aurea.	18	5.0	1966-01-01	\N	\N	\N	2009-04-30 02:43:11.43951	2009-05-13 20:06:01.89657	1
19	5	P-312	5.0	San Martin; Monumento a la Bandera, Rosario	\N	0.0	1983-01-01	\N	\N	\N	2009-04-29 07:15:24.231795	2009-04-29 07:15:24.231795	\N
20	5	P-311	1.0	San Martin; Bariloche, Llao-Llao	\N	0.0	1983-01-01	\N	\N	\N	2009-04-29 07:16:43.083578	2009-04-29 07:16:43.083578	\N
50	16	P-13	100.0	Green, crown w/ arm and sword	\N	0.0	1992-07-01	\N	\N	\N	2009-04-29 23:32:09.973057	2009-04-29 23:32:09.973057	\N
91	22	P-74	25.0	Lithograph. 3 horses; Abbaside Palace	\N	0.0	1990-01-01	\N	\N	\N	2009-04-30 05:00:38.112602	2009-04-30 05:00:38.112602	\N
51	17	P-150b	1.0	Marques de Tamandare; Escola Naval.  Ministro da Fazenda signature E?? E?? 	\N	0.0	1954-01-01	\N	\N	\N	2009-04-29 23:40:02.397981	2009-04-29 23:40:02.397981	\N
11	6	P-s2711	1.0	Green, terms and conditions on reverse	\N	0.0	1991-01-01	\N	\N	\N	2009-04-29 06:47:08.617721	2009-04-29 19:07:02.733194	\N
21	7	P-33	10.0	Mt. Ararat; David Sasoun	\N	0.0	1993-01-01	\N	\N	\N	2009-04-29 19:11:07.123423	2009-04-29 19:11:07.123423	\N
22	8	P-s119b	10.0	Green, one sided	\N	0.0	1921-01-01	\N	\N	\N	2009-04-29 19:21:43.379127	2009-04-29 19:21:43.379127	\N
71	17	P-233	10000.0	Vital Brazil, snake venom collecting; Snakes	\N	0.0	1992-01-01	\N	\N	\N	2009-04-30 03:13:44.040737	2009-04-30 03:13:44.040737	\N
23	9	P-73	1.0	Red, one sided	\N	0.0	1922-01-02	\N	\N	\N	2009-04-29 19:26:37.471408	2009-04-29 19:27:36.57819	\N
24	9	P-74	2.0	Red and black, one sided	\N	0.0	1922-01-02	\N	\N	\N	2009-04-29 19:28:54.180515	2009-04-29 19:28:54.180515	\N
25	9	P-75	10.0	Dark blue, black printing; child	\N	0.0	1922-01-02	\N	\N	\N	2009-04-29 19:31:55.705335	2009-04-29 19:31:55.705335	\N
26	10	P-11	1.0	Light green, pink; Maiden Tower	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 19:52:41.782196	2009-04-29 19:52:41.782196	\N
27	11	P-6c	2.0	Shahid Minar, Language Movement monument; Bird (Doyel)	\N	0.0	1988-01-01	\N	\N	\N	2009-04-29 19:57:01.712047	2009-04-29 19:57:01.712047	\N
28	12	P-1	50.0	Squirrel	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 19:59:48.905359	2009-04-29 19:59:48.905359	\N
30	13	P-3	3.0	Beavers	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:02:46.268985	2009-04-29 20:02:46.268985	\N
31	13	P-4	5.0	Wolves	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:04:24.009933	2009-04-29 20:04:24.009933	\N
32	13	P-5	10.0	Lynx	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:05:05.051656	2009-04-29 20:05:05.051656	\N
33	13	P-6	25.0	Moose	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:06:15.510159	2009-04-29 20:06:15.510159	\N
34	13	P-7	50.0	Bear	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:07:08.216574	2009-04-29 20:07:08.216574	\N
35	13	P-8	100.0	Bison	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:08:24.231507	2009-04-29 20:08:24.231507	\N
36	13	P-21	1.0	Science Academy in Minsk	\N	0.0	2000-01-01	\N	\N	\N	2009-04-29 20:10:26.203721	2009-04-29 20:10:26.203721	\N
37	13	P-22	5.0	Minsk	\N	0.0	2000-01-01	\N	\N	\N	2009-04-29 20:11:20.866766	2009-04-29 20:11:20.866766	\N
38	13	P-23	10.0	Library in Minsk	\N	0.0	2000-01-01	\N	\N	\N	2009-04-29 20:12:15.968101	2009-04-29 20:12:15.968101	\N
53	17	P-157	2.0	Duque de Caxias; Escola Militar de Rezende (red orange)	\N	0.0	1955-01-01	\N	\N	\N	2009-04-29 23:50:14.640062	2009-04-29 23:50:14.640062	\N
39	13	P-16	1000.0	Science Academy in Minsk; very similar to P-11; 1000 inside seal on reverse, no red serial on obverse	\N	0.0	1998-01-01	\N	\N	\N	2009-04-29 20:14:18.81043	2009-04-29 20:18:14.483583	\N
40	13	P-11	1000.0	Science Academy in Minsk; very similar to P-16; 1000 outside seal on reverse, red serial on obverse	\N	0.0	1992-01-01	\N	\N	\N	2009-04-29 20:15:57.999914	2009-04-29 20:18:38.068573	\N
16	4	P-301	50.0	San Martin; Jujuy Termas de Reyes	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 07:01:22.730771	2009-04-29 21:33:50.297917	\N
13	4	P-304c	1000.0	San Martin; Plaza de Mayo.  Reverse is less colorful than other P-304.	\N	0.0	1976-01-01	\N	\N	\N	2009-04-29 06:57:07.295803	2009-04-29 21:38:49.175998	\N
109	26	P-M7	10.0	Green, banana stalk; palms and ship	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:26:37.687259	2009-05-05 20:26:37.687259	\N
115	28	P-56	1.0	General Aung San; spinning wheel	\N	0.0	1972-01-01	\N	\N	\N	2009-05-05 20:49:07.473323	2009-05-05 20:49:07.473323	\N
121	32	P-166	2.0	Jose Rizal; revolution scene.  Serial number in black; extra stamp on obverse with 1981 date.	\N	0.0	1981-01-01	\N	\N	\N	2009-05-05 21:07:41.512248	2009-05-05 21:07:41.512248	\N
127	33	P-30	100.0	Wheat harvest; bridge, silos, soldier	\N	0.0	1979-01-01	\N	\N	\N	2009-05-05 21:31:08.729312	2009-05-05 21:31:08.729312	\N
133	35	P-91	500.0	Sculpture, man reading book	\N	0.0	1981-01-01	\N	\N	\N	2009-05-05 21:49:07.050284	2009-05-05 21:49:07.050284	\N
139	35	P-106	500.0	Blue N. Hrvanovic	\N	0.0	1990-01-01	\N	\N	\N	2009-05-05 22:03:05.708357	2009-05-05 22:03:05.708357	\N
145	35	P-129	10000.0	Man with impressive mustache, hat; Old churches	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:15:07.529905	2009-05-05 22:15:07.529905	\N
151	35	P-119	500000.0	Blue boy on blue; snow covered buildings	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:26:29.680279	2009-05-05 22:26:29.680279	\N
104	24	P-254	100.0	Large 100, tower w/ Russian flag; old skyline	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 20:07:54.344256	2009-05-05 20:07:54.344256	\N
110	26	P-M8	100.0	Brown, palms, hut; cattle in stream	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:30:18.967599	2009-05-05 20:30:18.967599	\N
116	28	P-63	35.0	General Aung San; peacock and statue.  Security strip, watermark mirroring the obverse portrait	\N	0.0	1986-01-01	\N	\N	\N	2009-05-05 20:51:11.698263	2009-05-05 20:51:11.698263	\N
122	33	P-25	1.0	Parade; school room	\N	0.0	1979-01-01	\N	\N	\N	2009-05-05 21:18:31.520586	2009-05-05 21:18:31.520586	\N
128	35	P-81	5.0	Woman with sickle and headdress	\N	0.0	1968-01-01	\N	\N	\N	2009-05-05 21:39:48.714816	2009-05-05 21:39:48.714816	\N
134	35	P-84a	500.0	Sculpture, man reading book	\N	0.0	1970-01-01	\N	\N	\N	2009-05-05 21:50:38.678957	2009-05-05 21:50:38.678957	\N
140	35	P-114	1000.0	Red Nikola Tesla; Tesla coil	\N	0.0	1992-01-01	\N	\N	\N	2009-05-05 22:04:48.409882	2009-05-05 22:04:48.409882	\N
146	35	P-116	10000.0	Brown girl; pixelated eye 	\N	0.0	1992-01-01	\N	\N	\N	2009-05-05 22:17:07.224232	2009-05-05 22:17:07.224232	\N
152	35	P-131	500000.0	Green man with long hair; old church in courtyard	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:28:28.017238	2009-05-05 22:28:28.017238	\N
105	24	P-255	200.0	Red cast, large 100, tower w/ Russian flag; old town scene	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 20:09:50.753849	2009-05-05 20:09:50.753849	\N
111	27	P-13	0.5	Palm and temple	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:36:38.824105	2009-05-05 20:36:38.824105	\N
117	29	P-108	10.0	Green, palms; brown	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:56:01.818034	2009-05-05 20:56:01.818034	\N
123	33	P-27	10.0	Lumber mill; hospital	\N	0.0	1979-01-01	\N	\N	\N	2009-05-05 21:20:21.574169	2009-05-05 21:20:21.574169	\N
129	35	P-82	10.0	Smiling industrial worker w/ goggles.  Security strip.	\N	0.0	1968-01-01	\N	\N	\N	2009-05-05 21:41:44.339856	2009-05-05 21:41:44.339856	\N
135	35	P-92d	1000.0	Woman with harvest, combine	\N	0.0	1981-01-01	\N	\N	\N	2009-05-05 21:53:37.232534	2009-05-05 21:53:37.232534	\N
141	35	P-110	1000.0	Blue Nikola Tesla; Tesla coil	\N	0.0	1991-01-01	\N	\N	\N	2009-05-05 22:06:17.915553	2009-05-05 22:06:17.915553	\N
147	35	P-117	50000.0	Purple boy on green; roses	\N	0.0	1992-01-01	\N	\N	\N	2009-05-05 22:18:46.116286	2009-05-05 22:18:46.116286	\N
153	35	P-121	5000000.0	Nikola Tesla; tesla coil, hydroelectric dam	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:30:17.093339	2009-05-05 22:30:17.093339	\N
43	14	P-13	2.0	Red dragons; Simtokha Dzong, Castle	\N	0.0	1986-01-01	\N	\N	\N	2009-04-29 23:18:33.614239	2009-04-29 23:18:33.614239	\N
54	17	P-158a	5.0	Barao do Rio Branco; Conquista do Amazonas.  Ministro da Fazenda signature W??	\N	0.0	1953-01-01	\N	\N	\N	2009-04-29 23:52:44.954724	2009-04-29 23:52:44.954724	\N
42	14	P-12b	1.0	Blue dragons; Simtokha Dzong, Castle.  2nd signature in series.	\N	0.0	1986-01-01	\N	\N	\N	2009-04-29 23:17:24.579516	2009-04-29 23:19:26.010896	\N
41	14	P-12c	1.0	Blue dragons; Simtokha Dzong, Castle.  3rd signature in series.	\N	0.0	1986-01-01	\N	\N	\N	2009-04-29 23:15:40.518455	2009-04-29 23:19:38.060902	\N
44	15	P-154	10.0	Busch; Cerro de Potosi	\N	0.0	1962-07-13	\N	\N	\N	2009-04-29 23:23:48.172361	2009-04-29 23:23:48.172361	\N
85	22	P-77	0.25	Palms; Gate	\N	0.0	1993-01-01	\N	\N	\N	2009-04-30 04:45:26.703459	2009-04-30 04:45:41.54947	\N
86	22	P-78	0.5	Astrolabe; Samara	\N	0.0	1993-01-01	\N	\N	\N	2009-04-30 04:46:45.86831	2009-04-30 04:46:45.86831	\N
82	17	P-237	50000.0	Camara Cascudo; native head dresses	20	50.0	1993-01-01	\N	\N	\N	2009-04-30 03:32:53.051303	2009-04-30 03:32:53.051303	\N
83	17	P-198	100.0	Mirrored images. Duque de Caxias; Swords, battle	\N	0.0	1984-01-01	\N	\N	\N	2009-04-30 03:54:26.227038	2009-04-30 03:54:26.227038	\N
84	17	P-199	200.0	Mirrored images. Princesa Isabel; women cooking	\N	0.0	1981-01-01	\N	\N	\N	2009-04-30 03:56:11.444523	2009-04-30 03:56:11.444523	\N
77	21	P-211c	100.0	Juscelino Kubitschek, electrical distribution station; modern buildings	\N	0.0	1987-01-01	\N	\N	\N	2009-04-30 03:24:04.457707	2009-04-30 04:14:14.212325	\N
87	22	P-69	1.0	Coin; Ornate building	\N	0.0	1979-01-01	\N	\N	\N	2009-04-30 04:52:47.2325	2009-04-30 04:52:47.2325	\N
88	22	P-80	5.0	Hussein; Soldier's tomb monument.  Poor quality printing.	\N	0.0	1992-01-01	\N	\N	\N	2009-04-30 04:55:27.000213	2009-04-30 04:55:27.000213	\N
89	22	P-73	25.0	Horsemen, Hussein in uniform; Monument	\N	0.0	1986-01-01	\N	\N	\N	2009-04-30 04:57:23.785615	2009-04-30 04:57:23.785615	\N
90	22	P-86	25.0	Hussein; Ishtar Gate	\N	0.0	2001-01-01	\N	\N	\N	2009-04-30 04:58:38.170705	2009-04-30 04:58:38.170705	\N
92	22	P-83	50.0	Hussein; Saddam Bridge	\N	0.0	1994-01-01	\N	\N	\N	2009-04-30 05:02:40.189234	2009-04-30 05:02:40.189234	\N
93	22	P-87	100.0	Lithograph. Hussein; Old Baghdad	\N	0.0	2002-01-01	\N	\N	\N	2009-04-30 05:04:03.82641	2009-04-30 05:04:03.82641	\N
94	22	P-84	100.0	Al-Ukhether Castle, Hussein; Baghdad Clock	\N	0.0	1994-01-01	\N	\N	\N	2009-04-30 05:05:49.046912	2009-04-30 05:05:49.046912	\N
95	22	P-85	250.0	Hussein; Liberty Monument friese	\N	0.0	1994-01-01	\N	\N	\N	2009-04-30 05:06:35.912832	2009-04-30 05:06:35.912832	\N
96	22	P-88	250.0	Hussein; Rock Dome	\N	0.0	2002-01-01	\N	\N	\N	2009-04-30 05:07:32.857648	2009-04-30 05:07:32.857648	\N
97	22	P-89!	10000.0	Hussein; Astrolabe.  Forgery, because security foil is over the top and bottom red border print. 	\N	0.0	2002-01-01	\N	\N	\N	2009-04-30 05:16:03.427987	2009-04-30 05:16:03.427987	\N
98	23	P-149	20.0	Romauld Traugutt	\N	0.0	1982-01-01	\N	\N	\N	2009-05-04 06:00:32.483642	2009-05-04 06:00:32.483642	\N
99	23	P-142c	50.0	Karol Swierczewski; cross with swords	\N	0.0	1988-01-01	\N	\N	\N	2009-05-04 06:03:15.871308	2009-05-04 06:03:15.871308	\N
100	23	P-143c	100.0	Ludwik Warynski; "Proletaryat Organ"	\N	0.0	1988-01-01	\N	\N	\N	2009-05-04 06:04:53.802234	2009-05-04 06:04:53.802234	\N
101	23	P-144c	200.0	Jaroslaw Dabrowski; woman against wall	\N	0.0	1988-01-01	\N	\N	\N	2009-05-04 06:06:41.513632	2009-05-04 06:06:41.513632	\N
102	23	P-145c	500.0	Tadeusz Koscuiszko	\N	0.0	1982-01-01	\N	\N	\N	2009-05-04 06:08:00.431321	2009-05-04 06:08:00.431321	\N
103	23	P-146c	1000.0	Mikolaj Kopernik; solar system	\N	0.0	1982-01-01	\N	\N	\N	2009-05-04 06:10:05.520406	2009-05-04 06:10:05.520406	\N
112	27	P-14	1.0	Green over pink, palm and temple	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:38:19.662156	2009-05-05 20:38:19.662156	\N
118	30	P-104	10.0	Black w/ orange; brown 	\N	0.0	1942-01-01	\N	\N	\N	2009-05-05 20:58:28.885458	2009-05-05 20:58:28.885458	\N
124	34	P-8a	1.0	Maroon w/ pink and light blue background, goddess; elephant sculpture	\N	0.0	1962-01-01	\N	\N	\N	2009-05-05 21:23:02.47673	2009-05-05 21:23:02.47673	\N
130	35	P-85	20.0	Ship at port.  Security strip.	\N	0.0	1974-01-01	\N	\N	\N	2009-05-05 21:43:36.612354	2009-05-05 21:43:36.612354	\N
136	35	P-138	10.0	Man with impressive mustache, bow tie; mountains	\N	0.0	1994-01-01	\N	\N	\N	2009-05-05 21:57:02.971578	2009-05-05 21:57:02.971578	\N
142	35	P-115	5000.0	Ivo Andric; bridge	\N	0.0	1992-01-01	\N	\N	\N	2009-05-05 22:08:10.442677	2009-05-05 22:11:36.31725	\N
148	35	P-142	50000.0	Red man with mustache, ornate collar; churches	\N	0.0	1994-01-01	\N	\N	\N	2009-05-05 22:20:50.224855	2009-05-05 22:20:50.224855	\N
154	35	P-132	5000000.0	Man with mustache, ornate collar; churches	\N	0.0	1993-01-01	\N	\N	\N	2009-05-05 22:31:39.670852	2009-05-05 22:31:39.670852	\N
156	35	P-124	100000000.0	N. Hrvanovic on blue-green; ornate building	\N	0.0	1993-01-01	\N	\N	\N	2009-05-06 19:47:05.278027	2009-05-06 19:47:05.278027	\N
157	35	P-134	500000000.0	Bald man with mustache; building	\N	0.0	1993-01-01	\N	\N	\N	2009-05-06 19:49:35.255068	2009-05-06 19:49:35.255068	\N
158	35	P-126	1000000000.0	Pink girl; building	\N	0.0	1993-01-01	\N	\N	\N	2009-05-06 19:52:32.231229	2009-05-06 19:52:32.231229	\N
106	25	MMM14	10000.0	Olive, blue, Mavrodi; 10000 Biletov	\N	0.0	1994-01-01	\N	\N	\N	2009-05-05 20:13:17.111189	2009-05-06 20:06:01.342681	\N
159	36		25.0	Small, green and black printing	\N	0.0	1922-05-01	\N	\N	\N	2009-05-10 02:44:52.337072	2009-05-10 02:44:52.337072	\N
160	37	P-58	1.0	Green, black printing, red seal, embossed on right	\N	0.0	1920-03-01	\N	\N	\N	2009-05-10 02:52:48.063323	2009-05-10 02:52:48.063323	\N
161	37	P-62	2.0	Red printing, seal on left, embossed on right	\N	0.0	1920-03-01	\N	\N	\N	2009-05-10 02:54:51.542722	2009-05-10 02:54:51.542722	\N
162	37	P-67	10.0	Green and black; green, black, and red	\N	0.0	1920-02-06	\N	\N	\N	2009-05-10 02:56:53.453124	2009-05-10 02:56:53.453124	\N
163	37	P-57	20.0	Red w/ liberty heads; knight, woman w/ harvest	\N	0.0	1918-02-20	\N	\N	\N	2009-05-10 02:59:48.924674	2009-05-10 02:59:48.924674	\N
164	37	P-40	20.0	Blue printing w/ red seals; blue and red design	\N	0.0	1910-04-21	\N	\N	\N	2009-05-10 03:02:16.483083	2009-05-10 03:02:16.483083	\N
165	37	P-66	50.0	Green and black printing, woman with stars.	\N	0.0	1919-06-24	\N	\N	\N	2009-05-10 03:04:12.955487	2009-05-10 03:04:12.955487	\N
166	37	P-34	100.0	Blue printing w/ green seals; women flanking headshot of another woman	\N	0.0	1908-02-07	\N	\N	\N	2009-05-10 03:07:11.988919	2009-05-10 03:07:11.988919	\N
167	37	P-69	100.0	Dark blue printing, two busts, red seals; design in shape of a large H	\N	0.0	1920-11-01	\N	\N	\N	2009-05-10 03:09:50.793151	2009-05-10 03:09:50.793151	\N
168	37	P-44	1000.0	Black with red seals and serial; two women flanking elaborate coat of arms.  Blue fiber security paper.	\N	0.0	1910-04-21	\N	\N	\N	2009-05-10 03:12:40.390314	2009-05-10 03:12:40.390314	\N
169	37	P-76	1000.0	Black printing over red gradient; light green printing	\N	0.0	1922-09-15	\N	\N	\N	2009-05-10 03:19:28.09501	2009-05-10 03:19:28.09501	\N
170	37	P-81	5000.0	Grumpy man with hat; brown and green printing	\N	0.0	1922-12-02	\N	\N	\N	2009-05-10 03:21:34.525772	2009-05-10 03:21:34.525772	\N
171	37	P-72	10000.0	Blue and green printing, grumpy man; green printing	\N	0.0	1922-01-19	\N	\N	\N	2009-05-10 03:28:16.803917	2009-05-10 03:28:16.803917	\N
173	37	P-104	2000000.0	Black text w/ red pattern; no reverse!	\N	0.0	1923-08-09	\N	\N	\N	2009-05-10 03:32:50.800118	2009-05-10 03:32:50.800118	\N
174	37	P-118	20000000000.0	"Zwanzig milliarden mark"; no reverse	\N	0.0	1923-10-01	\N	\N	\N	2009-05-10 03:34:51.804913	2009-05-10 03:34:51.804913	\N
175	38	P-1	1.0	Orange, green, black printing; Majlisi Olii - Tajik Parliament	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 03:50:38.681594	2009-05-10 03:50:38.681594	\N
176	38	P-2	5.0	Blue and red printing; Majlisi Olii - Tajik Parliament	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 03:51:14.12218	2009-05-10 03:51:14.12218	\N
177	39	P-10	1.0	Opera and ballet theatre; mountains	\N	0.0	1999-01-01	\N	\N	\N	2009-05-10 03:53:09.12789	2009-05-10 03:53:09.12789	\N
178	39	P-11	5.0	Culture Palace; dome over tomb	\N	0.0	1999-01-01	\N	\N	\N	2009-05-10 03:54:02.124438	2009-05-10 03:54:02.124438	\N
179	40	P-61	1.0	Coat of arms on blue and pink gradient; Shir-Dor Madrassa in Samarkand	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 03:57:29.631578	2009-05-10 03:58:48.569587	\N
180	40	P-62	3.0	Green coat of arms; Shir-Dor Madrassa in Samarkand	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 03:59:15.195332	2009-05-10 03:59:15.195332	\N
181	40	P-63	5.0	Purple coat of arms; Shir-Dor Madrassa in Samarkand	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 03:59:57.668438	2009-05-10 03:59:57.668438	\N
182	40	64	10.0	Red coat of arms; Shir-Dor Madrassa in Samarkand	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 04:00:51.650462	2009-05-10 04:00:51.650462	\N
183	40	P-65	25.0	Teal coat of arms; Shir-Dor Madrassa in Samarkand	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 04:01:25.514637	2009-05-10 04:01:25.514637	\N
184	41	P-7	1.0	Man with turban, partial beard; architectural drawings	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:05:54.91988	2009-05-10 04:05:54.91988	\N
185	41	P-8	3.0	Bald man with long white beard; mountains, trees, river	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:06:40.72772	2009-05-10 04:06:40.72772	\N
186	41	P-9	5.0	Man with beard, hat, guitar; ancient temples	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:07:24.691045	2009-05-10 04:07:24.691045	\N
187	42	P-1	1.0	Bright green, yellow, red; coat of arms in green	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:08:32.589761	2009-05-10 04:08:32.589761	\N
188	42	P-2	2.0	Bright colors - purple, pink, green, yellow; coat of arms in blue on pink	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:09:42.329733	2009-05-10 04:09:42.329733	\N
189	42	P-3	5.0	Bright pink, purple, green, yellow; purple coat of arms	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:10:30.736972	2009-05-10 04:10:30.736972	\N
190	42	P-4	10.0	Bright red, pink, yellow, green; red coat of arms	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:11:28.602757	2009-05-10 04:11:28.602757	\N
191	42	P-5	20.0	Green, yellow, blue; dark blue coat of arms	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:12:34.851134	2009-05-10 04:12:34.851134	\N
192	43	P-1	1.0	Squarish, large eagle, red; flag in center of design	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:18:26.821533	2009-05-10 04:18:26.821533	\N
193	43	P-2	10.0	Squarish, big eagle on green; emblem from flag in middle	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:21:56.742874	2009-05-10 04:21:56.742874	\N
194	43	P-3	50.0	Squarish, large eagle on blue; emblem from center of flag	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 04:22:57.108935	2009-05-10 04:22:57.108935	\N
195	44	P-222	1.0	Maroon and green on yellow; brown on yellow	\N	0.0	1961-01-01	\N	\N	\N	2009-05-10 04:31:24.394184	2009-05-10 04:31:24.394184	\N
196	44	P-237	1.0	Maroon and green on yellow; Green and maroon on yellow;	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 04:33:07.767541	2009-05-10 04:33:07.767541	\N
197	44	P-223	3.0	Blue and purple on green; black on green, Kremlin	\N	0.0	1961-01-01	\N	\N	\N	2009-05-10 04:35:27.738908	2009-05-10 04:35:27.738908	\N
198	44	P-238	3.0	Blue on green; black on green, Kremlin	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 04:36:24.841376	2009-05-10 04:36:24.841376	\N
199	44	P-224	5.0	Tan on blue; black on blue, Spasski tower	\N	0.0	1961-01-01	\N	\N	\N	2009-05-10 04:37:49.689768	2009-05-10 04:37:49.689768	\N
200	44	P-239	5.0	Pink and green on blue; black on blue with pink highlight, Spasski tower	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 04:38:48.648328	2009-05-10 04:38:48.648328	\N
201	44	P-233	10.0	Blue and green on red; red, Lenin	\N	0.0	1961-01-01	\N	\N	\N	2009-05-10 04:39:43.81932	2009-05-10 04:39:43.81932	\N
202	44	P-249	500.0	Red and black Lenin; Kremlin	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 04:41:28.879022	2009-05-10 04:41:28.879022	\N
203	44	P-250	1000.0	Black, pink, green Lenin; Red Square Church in Moscow	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 04:44:08.099451	2009-05-10 04:44:08.099451	\N
204	45	P-94	2.0	Woman harvesting grapes; coat of arms	\N	0.0	1974-01-01	\N	\N	\N	2009-05-10 04:54:03.444928	2009-05-10 04:54:03.444928	\N
205	45	P-81	3.0	Hammer and sickle in hands; coat of arms	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 04:55:11.959663	2009-05-10 04:55:11.959663	\N
206	45	P-82	5.0	Hands with hammer and sickle, text; coat of arms	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 04:56:27.202698	2009-05-10 04:56:27.202698	\N
207	45	P-95	5.0	Town on beach, pier; coat of arms	\N	0.0	1974-01-01	\N	\N	\N	2009-05-10 04:57:52.036947	2009-05-10 04:57:52.036947	\N
208	45	P-96	10.0	G. Dimitrov; factory	\N	0.0	1974-01-01	\N	\N	\N	2009-05-10 04:59:34.526849	2009-05-10 04:59:34.526849	\N
209	45	P-83	10.0	G. Dimitrov; wheat harvest	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 05:00:51.305033	2009-05-10 05:00:51.305033	\N
210	45	P-100	20.0	Royal woman; church	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 05:02:16.898807	2009-05-10 05:02:16.898807	\N
211	45	P-84	25.0	Georgi Dimitrov; railroad construction	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 05:03:43.373325	2009-05-10 05:03:43.373325	\N
212	45	P-85	50.0	Georgi Dimitrov; woman with flowers	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 05:04:50.390854	2009-05-10 05:04:50.390854	\N
213	45	P-101	50.0	K. G. Danov; printing press	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 05:05:30.886141	2009-05-10 05:05:30.886141	\N
214	45	P-86	100.0	Georgi Dimitrov; woman harvesting grapes	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 05:06:23.992718	2009-05-10 05:06:23.992718	\N
215	45	P-87	200.0	Georgi Dimitrov; harvesting tobacco	\N	0.0	1951-01-01	\N	\N	\N	2009-05-10 05:07:16.22486	2009-05-10 05:07:16.22486	\N
216	46	P-8	5.0	Bubusara Beishenalieva; Opera and Ballet Theater	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 05:15:14.569399	2009-05-10 05:15:14.569399	\N
217	47	P-81	1.0	Statue of woman; Cathedral of St. Sophia	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 05:20:21.391191	2009-05-10 05:20:21.391191	\N
218	47	P-82	3.0	Statue of woman; Cathedral of St. Sophia	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 05:20:56.475583	2009-05-10 05:20:56.475583	\N
219	47	P-83	5.0	Statue of woman; Cathedral of St. Sophia	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 05:21:25.757219	2009-05-10 05:21:25.757219	\N
220	48	P-94b	10000.0	Statue of man with cross; building and coat of arms	\N	0.0	1995-01-01	\N	\N	\N	2009-05-10 05:24:46.188551	2009-05-10 05:24:46.188551	\N
221	48	P-95b	20000.0	Statue of man with cross; building and coat of arms	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 05:25:57.746264	2009-05-10 05:25:57.746264	\N
222	48	P-93b	5000.0	Viking statue; cathedral	\N	0.0	1995-01-01	\N	\N	\N	2009-05-10 05:26:40.452841	2009-05-10 05:26:40.452841	\N
223	49	P-16	1.0	General Alexander Suvorov; Parliament building	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 05:31:54.953577	2009-05-10 05:31:54.953577	\N
224	49	P-17	5.0	General Alexander Suvorov; Parliament building	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 05:32:39.473975	2009-05-10 05:32:39.473975	\N
225	49	P-18	10.0	General Alexander Suvorov; Parliament building	\N	0.0	1995-01-01	\N	\N	\N	2009-05-10 05:33:29.040322	2009-05-10 05:33:29.040322	\N
226	49	P-19	50.0	Statue of General Alexander Suvorov on horse; Parliament building	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 05:34:30.301553	2009-05-10 05:34:30.301553	\N
227	50	P-47	1.0	Mobutu Sese Seko; Monument	\N	0.0	1993-06-24	\N	\N	\N	2009-05-10 05:39:33.707979	2009-05-10 05:39:33.707979	\N
228	51	P-48	5.0	Mobutu Sese Seko; Monument	\N	0.0	1993-06-24	\N	\N	\N	2009-05-10 05:41:08.711887	2009-05-10 05:41:08.711887	\N
229	52	P-52	1.0	Mobutu Sese Seko; government buildings	\N	0.0	1993-06-24	\N	\N	\N	2009-05-10 05:42:51.491226	2009-05-10 05:42:51.491226	\N
230	52	P-53	5.0	Mobutu Sese Seko; government building	\N	0.0	1993-06-24	\N	\N	\N	2009-05-10 05:44:02.774289	2009-05-10 05:44:02.774289	\N
231	51	P-49	10.0	Mobutu Sese Seko; tusks, pyramids	\N	0.0	1993-06-24	\N	\N	\N	2009-05-10 05:44:55.310117	2009-05-10 05:44:55.310117	\N
232	51	P-51	50.0	Mobutu Sese Seko; man in native dress, fishing nets	\N	0.0	1993-06-24	\N	\N	\N	2009-05-10 05:47:26.71711	2009-05-10 05:47:26.71711	\N
233	3	P-238b	500.0	Man with full curly beard; liberty reclining with torch 	\N	0.0	1998-01-01	\N	\N	\N	2009-05-10 06:29:52.792304	2009-05-10 06:29:52.792304	\N
234	53	P-11	100.0	Domingos Ramos in dark green over pastel gradients; A Lei Pune o Contrafactor, building	\N	0.0	1990-01-01	\N	\N	\N	2009-05-10 17:47:16.967799	2009-05-10 17:47:16.967799	\N
235	54	P-68	50.0	Stringed instrument that looks like a boat	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 17:51:58.492017	2009-05-10 17:51:58.492017	\N
236	55	P-67	1.0	Aung San; carved dragons	\N	0.0	1990-01-01	\N	\N	\N	2009-05-10 17:53:55.191436	2009-05-10 17:53:55.191436	\N
237	55	P-69	1.0	Chinthe (lion/dragon); canoe racing	\N	0.0	1996-01-01	\N	\N	\N	2009-05-10 17:55:46.177457	2009-05-10 17:55:46.177457	\N
238	55	P-70	5.0	Chinthe (lion/dragon); ball game under tree	\N	0.0	1997-01-01	\N	\N	\N	2009-05-10 17:56:26.691664	2009-05-10 17:56:26.691664	\N
239	55	P-71	10.0	Chinthe (lion/dragon); palace barge	\N	0.0	1997-01-01	\N	\N	\N	2009-05-10 17:57:51.489518	2009-05-10 17:57:51.489518	\N
240	55	P-72	20.0	Chinthe (lion/dragon); fountain w/ elephants	\N	0.0	1994-01-01	\N	\N	\N	2009-05-10 17:59:07.484593	2009-05-10 17:59:07.484593	\N
241	56	P-2	5.0	Building, Sazcylyk Okuw Jayy, horn sculpture; church, Abu Seyidin Yadygarligi	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 18:08:50.852796	2009-05-10 18:08:50.852796	\N
242	56	P-3	10.0	Niazov, Turkmenistanyn Hokumeninin Jayy; church, Tekesin Yadygarligi	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 18:10:24.111069	2009-05-10 18:10:24.111069	\N
243	28	P-57	5.0	General Aung San; man climbing palm tree	\N	0.0	1973-01-01	\N	\N	\N	2009-05-10 18:16:49.592807	2009-05-10 18:16:49.592807	\N
244	57	P-2	2.0	Mountains; column	\N	0.0	1990-01-01	\N	\N	\N	2009-05-10 18:21:55.143927	2009-05-10 18:21:55.143927	\N
245	57	P-11	10.0	Primoz Trubar looking kind of crazy; church drawing, Ursulinska cerkev	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 18:24:05.317776	2009-05-10 18:24:05.317776	\N
246	57	P-12	20.0	Janez Vajkard Valvasor, compass and quill; elevation maps	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 18:25:57.36539	2009-05-10 18:25:57.36539	\N
247	53	P-10	50.0	Pansau Na Isna in red; natives cooking	\N	0.0	1990-03-01	\N	\N	\N	2009-05-10 18:28:57.036785	2009-05-10 18:28:57.036785	\N
248	58	P-27m	1.0	Serial number has two letters then number, no slash or dividing line	\N	0.0	1983-01-01	\N	\N	\N	2009-05-10 18:34:52.796619	2009-05-10 18:34:52.796619	\N
249	58	P-37	2.0	Crescent and star; mosque	\N	0.0	1986-01-01	\N	\N	\N	2009-05-10 18:35:55.651785	2009-05-10 18:35:55.651785	\N
250	58	P-44	5.0	Man with hat; tomb/church	\N	0.0	1997-01-01	\N	\N	\N	2009-05-10 18:37:58.150722	2009-05-10 18:37:58.150722	\N
252	59	P-30	0.2	Plants with provisional stamping; coat of arms on yellow	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 18:45:45.4416	2009-05-10 18:45:45.4416	\N
253	59	P-31	0.5	Plants, provisional over stamping; coat of arms on yellow	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 18:46:34.59376	2009-05-10 18:46:34.59376	\N
254	59	P-39	2.0	two birds; flowering plant	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 18:47:31.909349	2009-05-10 18:47:31.909349	\N
255	59	P-43	200.0	Two elk	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 18:49:29.264424	2009-05-10 18:49:29.264424	\N
256	59	P-42	100.0	Two otters	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 18:50:15.873775	2009-05-10 18:50:15.873775	\N
257	59	P-44	500.0	Bear	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 18:51:10.907754	2009-05-10 18:51:10.907754	\N
258	60	P-46	500.0	Wolves	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 18:51:56.897364	2009-05-10 18:51:56.897364	\N
259	59	P-32	1.0	Lizards	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 18:52:59.051068	2009-05-10 18:52:59.051068	\N
260	59	P-33	3.0	Grey herons; juniper branch	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 18:53:55.312797	2009-05-10 18:53:55.312797	\N
261	13	P-9	200.0	Buildings; knight on horse (very similar to Lithuania's coat of arms)	\N	0.0	1992-01-01	\N	\N	\N	2009-05-10 19:02:47.794071	2009-05-10 19:02:47.794071	\N
262	61	P-105	100.0	Coat of arms; temple, big tree	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 19:42:36.372947	2009-05-10 19:42:36.372947	\N
263	61	P-100	200.0	Ho Chi Minh and coat of arms; tractor and harvest	\N	0.0	1987-01-01	\N	\N	\N	2009-05-10 19:44:16.751606	2009-05-10 19:44:16.751606	\N
264	62	P-51	50.0	Vertically oriented, horsemen	\N	0.0	1993-01-01	\N	\N	\N	2009-05-10 19:53:30.665791	2009-05-10 19:53:30.665791	\N
265	62	P-49	10.0	Magenta, orange, archers	\N	0.0	1993-01-01	\N	\N	\N	2009-05-13 03:17:05.79162	2009-05-13 03:17:05.79162	\N
266	62	P-50	20.0	Brown on yellow, dancers	\N	0.0	1993-01-01	\N	\N	\N	2009-05-13 03:19:17.27033	2009-05-13 03:19:17.27033	\N
268	63	P-53	5.0	Damdiny Sühbaatar; horses	\N	0.0	1993-01-01	\N	\N	\N	2009-05-13 03:24:04.003401	2009-05-13 03:24:04.003401	\N
270	63	P-63	20.0	Damdiny Sühbaatar; horses	\N	0.0	2005-01-01	\N	\N	\N	2009-05-13 03:28:01.3214	2009-05-13 03:28:01.3214	\N
269	63	P-62	10.0	Damdiny Sühbaatar; horses	\N	0.0	2005-01-01	\N	\N	\N	2009-05-13 03:24:59.787509	2009-05-13 03:30:09.380804	\N
271	63	P-56	50.0	Damdiny Sühbaatar; horses	\N	0.0	1993-01-01	\N	\N	\N	2009-05-13 04:00:41.98233	2009-05-13 04:00:41.98233	\N
272	63	P-42	1.0	Brown on green, coat of arms, cyrillic; pink, blue, brown on green	\N	0.0	1983-01-01	\N	\N	\N	2009-05-13 04:02:14.067795	2009-05-13 04:02:14.067795	\N
273	63	P-37	5.0	Damdiny Sühbaatar, coat of arms on blue	\N	0.0	1966-01-01	\N	\N	\N	2009-05-13 04:05:29.671234	2009-05-13 04:05:29.671234	\N
274	63	P-38	10.0	Damdiny Sühbaatar, coat of arms, cyrillic	\N	0.0	1966-01-01	\N	\N	\N	2009-05-13 04:06:18.005181	2009-05-13 04:06:18.005181	\N
275	63	P-39	25.0	Damdiny Sühbaatar, coat of arms, cyrillic	\N	0.0	1966-01-01	\N	\N	\N	2009-05-13 04:07:05.66258	2009-05-13 04:07:05.66258	\N
276	63	P-40	50.0	Damdiny Sühbaatar, coat of arms, cyrillic; long building	\N	0.0	1966-01-01	\N	\N	\N	2009-05-13 04:08:04.75379	2009-05-13 04:08:04.75379	\N
277	63	P-33	1.0	Damdiny Sühbaatar, coat of arms, cyrillic	\N	0.0	1955-01-01	\N	\N	\N	2009-05-13 04:09:25.347018	2009-05-13 04:09:25.347018	\N
288	68	P-21	2.0	Man with hat	\N	0.0	1981-01-01	\N	\N	\N	2009-05-17 20:50:58.989478	2009-05-17 20:51:48.451831	\N
289	69	P-29	50.0	Man with beard, hat, coat of arms; man plowing field with ox, traditional mask	\N	0.0	1985-01-01	\N	\N	\N	2009-05-17 20:53:59.076289	2009-05-17 20:53:59.076289	\N
278	64	P-M47	5.0	Red on blue and green, 6th series.	\N	0.0	1972-01-01	\N	\N	\N	2009-05-13 04:31:51.943853	2009-05-13 20:08:49.199903	2
279	64	P-M48	10.0	Maroon printing, 6th series.	\N	0.0	1972-01-01	\N	\N	\N	2009-05-13 04:32:55.888024	2009-05-13 20:09:16.953768	2
280	64	P-M49	50.0	Green printing, 6th series.	\N	0.0	1972-01-01	\N	\N	\N	2009-05-13 04:35:31.220768	2009-05-13 20:09:36.473088	2
281	65	P-M22	1.0	2nd series	\N	0.0	1948-01-01	\N	\N	\N	2009-05-16 19:39:45.232147	2009-05-16 19:39:45.232147	1
282	65	P-M29	1.0	3rd Series	\N	0.0	1956-01-01	\N	\N	\N	2009-05-16 19:40:44.540019	2009-05-16 19:40:44.540019	1
283	65	P-M36	1.0	4th series	\N	0.0	1962-01-01	\N	\N	\N	2009-05-16 19:41:59.685208	2009-05-16 19:41:59.685208	\N
284	65	P-M23	5.0	2nd series	\N	0.0	1958-01-01	\N	\N	\N	2009-05-16 19:43:05.591262	2009-05-16 19:43:05.591262	1
285	66	P-390	20.0	Queen w/ hologram; Sir Edward Elgar, Worcester Cathedral	\N	0.0	1999-01-01	\N	\N	\N	2009-05-16 19:48:28.962898	2009-05-16 19:51:34.081525	\N
286	67	P-16b	1.0	Trees in field; Mosque	\N	0.0	1983-01-01	\N	\N	\N	2009-05-17 20:46:10.918673	2009-05-17 20:46:10.918673	\N
287	68	P-20	1.0	Woman with head wrap	\N	0.0	1981-01-01	\N	\N	\N	2009-05-17 20:50:08.181633	2009-05-17 20:50:08.181633	\N
290	61	P-101	500.0	Ho Chi Minh; ships at port	\N	0.0	1988-01-01	\N	\N	\N	2009-05-17 20:55:47.970399	2009-05-17 20:55:47.970399	\N
291	70	P-24	2.0	Eagle, coat of arms; teacher and student, school	\N	0.0	1986-01-01	\N	\N	\N	2009-05-17 20:58:27.466533	2009-05-17 20:58:27.466533	\N
292	71	P-90	1.0	Man with hat	\N	0.0	1964-01-01	\N	\N	\N	2009-05-17 21:01:24.363345	2009-05-17 21:01:24.363345	\N
293	71	P-91	5.0	Woman with hat in uniform	\N	0.0	1964-01-01	\N	\N	\N	2009-05-17 21:02:28.107151	2009-05-17 21:02:28.107151	\N
294	71	P-92	10.0	Woman with hat, in uniform	\N	0.0	1964-01-01	\N	\N	\N	2009-05-17 21:03:34.085251	2009-05-17 21:03:34.085251	\N
295	71	P-93	25.0	Man with hat in uniform	\N	0.0	1964-01-01	\N	\N	\N	2009-05-17 21:04:25.797579	2009-05-17 21:04:25.797579	\N
296	71	P-94	50.0	Man with hat, in uniform	\N	0.0	1964-01-01	\N	\N	\N	2009-05-17 21:05:12.117946	2009-05-17 21:05:12.117946	\N
297	72	P-127	100.0	Ship, Perahu Pinisi; Volcano, Anak Gunung Krakatau	\N	0.0	1992-01-01	\N	\N	\N	2009-05-17 21:07:07.584996	2009-05-17 21:07:07.584996	\N
298	72	P-122	100.0	Bird, Goura Victoria; dam, Benoungan Tangga Asahan	\N	0.0	1984-01-01	\N	\N	\N	2009-05-17 21:08:09.256691	2009-05-17 21:08:09.256691	\N
299	72	P-79	2.5	People harvesting, cotton and wheat; stylize corn	\N	0.0	1961-01-01	\N	\N	\N	2009-05-17 21:10:18.872524	2009-05-17 21:10:18.872524	\N
300	72	P-78	1.0	People harvesting rice; stylized corn and food	\N	0.0	1961-01-01	\N	\N	\N	2009-05-17 21:11:14.924175	2009-05-17 21:11:14.924175	\N
301	73	P-16	1.0	Ruder Boskovic, geometry; cathedral	\N	0.0	1991-01-01	\N	\N	\N	2009-05-17 21:15:38.172559	2009-05-17 21:15:38.172559	\N
302	73	P-17	5.0	Ruder Boskovic, geometry; cathedral	\N	0.0	1991-01-01	\N	\N	\N	2009-05-17 21:19:00.220899	2009-05-17 21:19:00.220899	\N
303	73	P-18	10.0	Ruder Boskovic, geometry; cathedral	\N	0.0	1991-01-01	\N	\N	\N	2009-05-17 21:19:26.085623	2009-05-17 21:19:26.085623	\N
304	73	P-23	2000.0	Ruder Boskovic, geometry; statue of seated woman	\N	0.0	1992-01-01	\N	\N	\N	2009-05-17 21:20:39.189587	2009-05-17 21:20:39.189587	\N
305	73	P-24	5000.0	Ruder Boskovic, geometry; statue of seated woman	\N	0.0	1992-01-01	\N	\N	\N	2009-05-17 21:21:27.470754	2009-05-17 21:21:27.470754	\N
306	73	P-25	10000.0	Ruder Boskovic, geometry; statue of seated woman	\N	0.0	1993-01-01	\N	\N	\N	2009-05-17 21:22:08.264089	2009-05-17 21:22:08.264089	\N
307	73	P-26	50000.0	Ruder Boskovic, geometry; statue of seated woman	\N	0.0	1993-01-01	\N	\N	\N	2009-05-17 21:22:38.798122	2009-05-17 21:22:38.798122	\N
308	73	P-27	100000.0	Ruder Boskovic, geometry; statue of seated woman	\N	0.0	1993-01-01	\N	\N	\N	2009-05-17 21:23:31.667146	2009-05-17 21:23:31.667146	\N
309	74	P-69	1.0	Man, K. Raud; castle	\N	0.0	1992-01-01	\N	\N	\N	2009-05-17 21:30:31.416798	2009-05-17 21:30:31.416798	\N
310	74	P-70	2.0	Grumpy old guy with spectacles, K. E. von Baer; government building	\N	0.0	1992-01-01	\N	\N	\N	2009-05-17 21:31:46.635484	2009-05-17 21:31:46.635484	\N
312	75	P-62d	5.0	Government building, statue; stone bridge	\N	0.0	1986-01-01	\N	\N	\N	2009-05-17 21:38:28.500303	2009-05-17 21:50:56.054651	1
313	75	P-63f	10.0	Stone pillars and arches; large rocks in the ocean	\N	0.0	1986-01-01	\N	\N	\N	2009-05-17 21:46:58.898289	2009-05-17 21:51:08.397577	1
311	75	P-64c	25.0	Temple next to water; ancient building on top of large rock, stone bridge	\N	0.0	1983-01-01	\N	\N	\N	2009-05-17 21:36:48.718101	2009-05-17 21:51:17.064817	1
314	76	P-192	10.0	President Atatürk; school children	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 21:53:41.252424	2009-05-17 21:53:41.252424	3
315	76	P-187	20.0	President Atatürk; monument with statues	\N	0.0	1970-01-01	\N	\N	\N	2009-05-17 21:54:42.007362	2009-05-17 21:54:42.007362	3
316	76	P-198	5000.0	President Atatürk; Afsin-Elbistan power plant	\N	0.0	1990-01-01	\N	\N	\N	2009-05-17 21:55:48.226868	2009-05-17 21:55:48.226868	\N
317	77	P-69d	2.0	Paul Bogle, bird, coat of arms; school children	\N	0.0	1990-01-01	\N	\N	\N	2009-05-17 21:59:03.495642	2009-05-17 21:59:03.495642	\N
318	77	P-69	2.0	Paul Bogle, bird, coat of arms; school children	\N	0.0	1993-01-01	\N	\N	\N	2009-05-17 22:00:20.218919	2009-05-17 22:00:20.218919	\N
319	78	P-236d	5.0	Rafael Yglesias Castro; market scene, "Alegoria Teatro National".	\N	0.0	1989-10-04	\N	\N	\N	2009-05-17 22:03:47.46134	2009-05-17 22:03:47.46134	1
320	78	P-236e	5.0	Rafael Yglesias Castro; market scene, "Alegoria Teatro Nacional"	\N	0.0	1992-01-15	\N	\N	\N	2009-05-17 22:05:14.591165	2009-05-17 22:05:14.591165	1
321	79	P-125	5.0	Frieze of woman and soldiers; government building	\N	0.0	1982-04-01	\N	\N	\N	2009-05-17 22:11:15.488312	2009-05-17 22:11:15.488312	4
322	79	P-120	5.0	Woman with basket on head; coat of arms	\N	0.0	1963-09-01	\N	\N	\N	2009-05-17 22:12:11.254516	2009-05-17 22:12:11.254516	4
323	79	P-121	10.0	Woman with basket on head; coat of arms	\N	0.0	1963-09-01	\N	\N	\N	2009-05-17 22:13:06.364058	2009-05-17 22:13:06.364058	\N
324	79	P-126	10.0	Frieze of woman with soldiers; government building	\N	0.0	1982-04-01	\N	\N	\N	2009-05-17 22:14:01.285232	2009-05-17 22:14:01.285232	4
325	79	P-127	25.0	Frieze of woman with soldiers; government building	\N	0.0	1985-11-01	\N	\N	\N	2009-05-17 22:15:06.464273	2009-05-17 22:15:06.464273	4
326	79	P-123	100.0	Frieze of woman with soldiers; government building	\N	0.0	1985-11-01	\N	\N	\N	2009-05-17 22:15:38.239532	2009-05-17 22:15:38.239532	4
327	80	P-35	50.0	Litho print, man with hair, coat of arms; boat at dock and tractor	\N	0.0	1992-01-01	\N	\N	\N	2009-05-17 22:49:46.629842	2009-05-17 22:49:46.629842	\N
328	81	P-17	1000.0	Smiling girl, school children; stone head with overgrowing roots	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 22:54:25.464369	2009-05-17 22:54:25.464369	2
329	80	P-34	10.0	Coat of arms, woman harvesting from tree; school yard	\N	0.0	1987-01-01	\N	\N	\N	2009-05-17 22:55:50.137387	2009-05-17 22:55:50.137387	\N
331	81	P-7d	50.0	Fishing boats; large temples	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 22:59:04.623342	2009-05-17 22:59:53.096434	\N
332	80	P-31	20.0	Coat of arms; oxen pulling timber	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:01:03.764505	2009-05-17 23:01:03.764505	\N
333	81	P-15a	100.0	Woman with loom; large temples	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 23:03:33.289902	2009-05-17 23:03:33.289902	\N
334	81	P-13	100.0	Feeding ceremonial cows; relief of women	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 23:06:04.978811	2009-05-17 23:08:14.249169	5
335	81	P-12b	100.0	Temple gate; arial view of temple complex	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 23:11:08.220655	2009-05-17 23:11:53.223406	6
336	81	P-8c	100.0	Stone head (no roots); rowing boat	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 23:15:14.693009	2009-05-17 23:15:14.693009	6
337	82	P-41	100.0	Temple with stone lion, coat of arms; rubber tree harvest	\N	0.0	1995-01-01	\N	\N	\N	2009-05-17 23:18:00.581246	2009-05-17 23:18:00.581246	\N
338	82	P-53	100.0	Temple with stone lion; school yard	\N	0.0	2001-01-01	\N	\N	\N	2009-05-17 23:19:11.896504	2009-05-17 23:19:11.896504	\N
339	81	P-14d	500.0	Woman with pot on head; rice paddys	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 23:21:19.271531	2009-05-17 23:21:19.271531	\N
340	82	P-52	50.0	Temple; dam	\N	0.0	2002-01-01	\N	\N	\N	2009-05-17 23:24:38.264923	2009-05-17 23:24:38.264923	\N
341	82	P-42a	200.0	Coat of arms, dam; ornate carved heads	\N	0.0	1995-01-01	\N	\N	\N	2009-05-17 23:26:08.054115	2009-05-17 23:26:08.054115	\N
342	80	P-29	5.0	Businessman, woman with grain, worker with hammer, soldier with gun; temple	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:29:27.15565	2009-05-17 23:29:27.15565	\N
330	81	P-4	1.0	Boats in harbor; temple	\N	0.0	1972-01-01	\N	\N	\N	2009-05-17 22:57:42.66304	2009-05-17 23:31:00.380036	\N
343	80	P-28	1.0	Coat of arms on yellow; grain harvesting	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:33:19.301934	2009-05-17 23:33:19.301934	\N
344	80	P-27	0.5	Passenger train; fishing from boats at sunrise	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:35:08.399407	2009-05-17 23:35:08.399407	\N
345	80	P-26	0.2	Planting rice; coat of arms	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:36:33.254541	2009-05-17 23:36:33.254541	\N
346	80	P-25	0.1	Oxen, preparing to plant rice; coat of arms	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:37:39.175704	2009-05-17 23:37:39.175704	\N
347	80	P-32	50.0	Giant carved head, coat of arms; arial of temple complex	\N	0.0	1979-01-01	\N	\N	\N	2009-05-17 23:42:08.599841	2009-05-17 23:42:08.599841	\N
348	1	P-60	500.0	Horse riders; fortress on hill	\N	0.0	1990-01-01	\N	\N	\N	2009-05-18 00:21:04.881325	2009-05-18 00:21:04.881325	\N
349	1	P-61	1000.0	Mosque with doves; arches	\N	0.0	1979-01-01	\N	\N	\N	2009-05-21 04:06:46.427912	2009-05-21 04:06:46.427912	\N
350	57	P-1	1.0	Mountain range; pillar	\N	0.0	1990-01-01	\N	\N	\N	2009-05-21 04:11:28.274849	2009-05-21 04:11:28.274849	\N
351	57	P-3	5.0	Mountain range; pillar	\N	0.0	1990-01-01	\N	\N	\N	2009-05-21 04:14:12.91485	2009-05-21 04:14:12.91485	\N
352	83	P-68	1.0	Bolivar relief; coat of arms	\N	0.0	1989-10-05	\N	\N	\N	2009-05-21 04:22:52.905137	2009-05-21 04:22:52.905137	\N
353	83	P-69	2.0	Relief of Bolivar; coat of arms	\N	0.0	1989-10-05	\N	\N	\N	2009-05-21 04:23:49.2778	2009-05-21 04:23:49.2778	\N
354	83	P-70	5.0	Bolivar Libertador, Francisco de Miranda; church and coat of arms	\N	0.0	1989-09-21	\N	\N	\N	2009-05-21 04:26:27.692144	2009-05-21 04:26:27.692144	\N
355	83	P-61c	10.0	Bolivar-Libertador, Mariscal Sucre; monument, coat of arms	\N	0.0	1992-12-08	\N	\N	\N	2009-05-21 04:28:43.423399	2009-05-21 04:28:43.423399	\N
356	83	P-63d	20.0	Jose Antonio Paez; monument and coat of arms 	\N	0.0	1992-12-02	\N	\N	\N	2009-05-21 04:30:09.881123	2009-05-21 04:30:09.881123	\N
358	84	P-113d	5.0	Antonio Jose de Sucre; coat of arms	\N	0.0	1988-11-22	\N	\N	\N	2009-05-21 04:37:21.548438	2009-05-21 04:37:21.548438	1
357	84	P-121	10.0	Sebastan de Benalcazar in a fancy hat; coat of arms	\N	0.0	1988-11-22	\N	\N	\N	2009-05-21 04:34:44.86978	2009-05-21 04:39:49.976089	\N
359	84	P-121Aa	20.0	Compania de Jesus-Quito; coat of arms	\N	0.0	1988-11-22	\N	\N	\N	2009-05-21 04:42:22.263571	2009-05-21 04:42:22.263571	\N
360	84	P-123A?	100.0	Simon Bolivar; coat of arms	\N	0.0	1993-08-20	\N	\N	\N	2009-05-21 04:44:57.5765	2009-05-21 04:44:57.5765	\N
361	85	P-32	1.0	Cotton, coat of arms; government building	\N	0.0	1987-01-01	\N	\N	\N	2009-05-23 19:15:58.27635	2009-05-23 19:15:58.27635	\N
362	86	P-30	25.0	Camels, coat of arms; government building	\N	0.0	1985-01-01	\N	\N	\N	2009-05-23 19:17:44.015466	2009-05-23 19:17:44.015466	\N
363	24	P-252	5000.0	Towers on wall; old church towers in front of business buildings	\N	0.0	1992-01-01	\N	\N	\N	2009-05-23 19:20:59.193433	2009-05-23 19:20:59.193433	\N
364	87	P-1	10.0	Weird Starwars-esque building; women harvesting	\N	0.0	1992-01-01	\N	\N	\N	2009-05-23 19:25:47.05961	2009-05-23 19:25:47.05961	\N
365	87	P-2	25.0	Weird starwars-esque building; women harvesting	\N	0.0	1992-01-01	\N	\N	\N	2009-05-23 19:26:51.488995	2009-05-23 19:26:51.488995	\N
366	87	P-3	50.0	Weird starwars-esque building; women harvesting	\N	0.0	1992-01-01	\N	\N	\N	2009-05-23 19:27:17.623141	2009-05-23 19:27:17.623141	\N
367	87	P-4	100.0	Weird starwars-esque building; women harvesting	\N	0.0	1992-01-01	\N	\N	\N	2009-05-23 19:27:43.563185	2009-05-23 19:27:43.563185	\N
368	88	P-117	1.0	Nicolae Iorga, flowers; Large church, coat of arms.  Polymer.	\N	0.0	2005-01-01	\N	\N	\N	2009-05-23 19:31:23.22401	2009-05-23 19:31:23.22401	\N
369	88	P-101	500.0	Constantin Brancusi; creepy looking sculpture	\N	0.0	1992-12-01	\N	\N	\N	2009-05-23 19:34:18.090446	2009-05-23 19:34:18.090446	\N
370	89	P-79	1.0	Coat of arms, Lempira; temples, carving, "Ruinas de Copan"	\N	0.0	1997-09-18	\N	\N	\N	2009-05-23 19:37:49.636756	2009-05-23 19:37:49.636756	\N
371	90	P-95	5.0	Sir W. Laurier; kingfisher	\N	0.0	1986-01-01	\N	\N	\N	2009-05-23 19:52:05.388394	2009-05-23 19:52:05.388394	\N
372	91	P-877	1.0	Group of 8 farmers walking on path	\N	0.0	1962-01-01	\N	\N	\N	2009-05-23 19:57:32.372875	2009-05-23 19:57:32.372875	\N
373	91	P-878	2.0	Large bridge with train	\N	0.0	1962-01-01	\N	\N	\N	2009-05-23 19:58:53.229284	2009-05-23 19:58:53.229284	\N
374	92		10.0	Perforated on left, red star seal, blue car.  Gas coupon?	\N	0.0	1990-01-01	\N	\N	\N	2009-05-23 20:01:55.209515	2009-05-23 20:01:55.209515	\N
375	93	P-FX1	0.1	Waterfall; "Bank of China Foreign Exchange Certificate"	\N	0.0	1979-01-01	\N	\N	\N	2009-05-23 20:04:07.402244	2009-05-23 20:04:07.402244	\N
417	107	P-78A?	1.0	Designs; oil drilling ship at sea	\N	0.0	1990-01-01	\N	\N	\N	2009-06-08 02:32:09.567285	2009-06-08 02:32:09.567285	\N
418	108	P-35	1.0	Bright green pattern; bright yellow pattern	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:35:29.564754	2009-06-08 02:35:29.564754	\N
376	94	RC1	500.0	Brown printing, pink design behind 500, green combine	\N	0.0	1986-01-01	\N	\N	\N	2009-05-23 20:07:28.668941	2009-05-23 20:12:54.006025	\N
377	94	RC2	500.0	Blue printing, yellow seal behind 500, combine	\N	0.0	1986-01-01	\N	\N	\N	2009-05-23 20:08:24.040154	2009-05-23 20:13:05.028373	\N
378	92	U1	0.0	Red printing on front, portrait of man on left, "AA", everything else is characters; nothing on reverse.	\N	0.0	\N	\N	\N	\N	2009-05-23 20:17:08.15452	2009-05-23 20:19:02.727476	\N
379	92	U2	0.0	Brown printing on front, portrait of man on left, "AA", everything else is characters; nothing on reverse.	\N	0.0	\N	\N	\N	\N	2009-05-23 20:19:37.421734	2009-05-23 20:19:37.421734	\N
380	91	P-881	1.0	Two men on left; coat of arms	\N	0.0	1980-01-01	\N	\N	\N	2009-05-23 20:21:14.166593	2009-05-23 20:21:14.166593	\N
381	91	P-882	2.0	Two women on left; coat of arms	\N	0.0	1980-01-01	\N	\N	\N	2009-05-23 20:22:25.560867	2009-05-23 20:22:25.560867	\N
382	91	P-885	5.0	Young women on left; coat of arms	\N	0.0	1980-01-01	\N	\N	\N	2009-05-23 20:23:54.339765	2009-05-23 20:23:54.339765	\N
383	95	RC1	2.0	Dark maroon printing, soldier with gun, fighter jets	\N	0.0	1975-01-01	\N	\N	\N	2009-05-23 20:26:54.010189	2009-05-23 20:26:54.010189	\N
384	95	RC2	3.0	Purple on blue, factory with fields, train	\N	0.0	1980-01-01	\N	\N	\N	2009-05-23 20:29:09.871652	2009-05-23 20:29:09.871652	\N
385	95	RC3	5.0	Green on green, soldier with gun, fighter jets	\N	0.0	\N	\N	\N	\N	2009-05-23 20:31:07.766841	2009-05-23 20:31:07.766841	\N
386	95	RC4	5.0	Blue on blue, scientists, atom, jets, satellite, rocket	\N	0.0	\N	\N	\N	\N	2009-05-23 20:32:13.990182	2009-05-23 20:32:13.990182	\N
387	92	U3	0.0	Brown on yellow, truck	\N	0.0	\N	\N	\N	\N	2009-05-23 20:33:30.429521	2009-05-23 20:33:30.429521	\N
388	92	U4	0.0	Blue on green, airplane; coat of arms	\N	0.0	\N	\N	\N	\N	2009-05-23 20:34:29.438941	2009-05-23 20:34:29.438941	\N
389	92	U5	0.0	Black on green, ship; coat of arms	\N	0.0	\N	\N	\N	\N	2009-05-23 20:35:28.321773	2009-05-23 20:35:28.321773	\N
390	96	P-81	5.0	Masque Suku (mask); Harpe Zande (harp-type instrument)	\N	0.0	1997-11-01	\N	\N	\N	2009-05-23 20:38:52.89626	2009-05-23 20:38:52.89626	\N
391	96	P-82	10.0	Masque Pende (mask); Danseurs Pende (crazy looking dancers)	\N	0.0	1997-11-01	\N	\N	\N	2009-05-23 20:39:47.377675	2009-05-23 20:39:47.377675	\N
393	97	P-185	5.0	Queen Nefertiti, orange background	\N	0.0	1997-01-01	\N	\N	\N	2009-05-23 20:46:16.272247	2009-05-23 20:46:16.272247	\N
392	97	P-188	5.0	Queen Nefertiti, blue and purple background	\N	0.0	2001-01-01	\N	\N	\N	2009-05-23 20:44:52.917451	2009-05-23 20:46:50.949513	\N
395	97		10.0	Old fashioned soldier, people w/ flag; black and red printing	\N	0.0	2001-01-01	\N	\N	\N	2009-05-23 20:50:25.816196	2009-05-23 20:50:25.816196	\N
394	97		10.0	Sphinx, purple center pattern; Mosque, purple center pattern	\N	0.0	2002-01-01	\N	\N	\N	2009-05-23 20:48:43.366264	2009-05-23 20:50:44.298214	\N
396	97	P-189	10.0	Sphinx, blue center pattern; Mosque, blue center pattern	\N	0.0	1998-01-01	\N	\N	\N	2009-05-23 20:53:22.870323	2009-05-23 20:53:22.870323	\N
397	98	P-1	1.0	Woman with nose ring, flanking children, raising of flag; classroom with students	\N	0.0	1997-05-24	\N	\N	\N	2009-06-08 01:50:32.748826	2009-06-08 01:50:32.748826	\N
398	99	P-33	1.0	Town in valley, man on horse, radio tower, all in red; cliffside fortress in red	\N	0.0	1993-01-01	\N	\N	\N	2009-06-08 01:54:10.688738	2009-06-08 01:54:10.688738	\N
399	99	P-34	3.0	Town in valley, rider on horse, radio tower, all in purple; cliffside fortress, all in purple	\N	0.0	1993-01-01	\N	\N	\N	2009-06-08 01:55:24.629335	2009-06-08 01:55:24.629335	\N
400	99	P-35	5.0	Town in valley, rider on horse, radio tower, all in brown; cliffside fortress in brown	\N	0.0	1993-01-01	\N	\N	\N	2009-06-08 01:56:29.651773	2009-06-08 01:56:29.651773	\N
401	99	P-37	50.0	Town in valley, rider on horse, radio tower, all in cyan; cliffside fortress in cyan	\N	0.0	1993-01-01	\N	\N	\N	2009-06-08 01:57:25.00266	2009-06-08 01:57:25.00266	\N
402	99	P-38	100.0	Town in valley, rider on horseback, radio tower; cliffside fortress in black on orange	\N	0.0	1993-01-01	\N	\N	\N	2009-06-08 01:58:19.776987	2009-06-08 01:58:19.776987	\N
403	100	P-21g	1.0	Kaieteur Falls; Black Bush Polder, Rice harvesting	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:01:17.295193	2009-06-08 02:01:17.295193	1
404	100	P-22f	5.0	Kaieteur Falls; Cane sugar cutting, conveyor	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:02:41.417653	2009-06-08 02:02:41.417653	1
405	100	P-22e	5.0	Kaieteur Falls; Cane sugar cutting, conveyor	\N	0.0	1989-01-01	\N	\N	\N	2009-06-08 02:03:31.173088	2009-06-08 02:03:31.173088	1
406	100	P-23f	10.0	Kaieteur Falls; Bauxite mining, alumina plant	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:04:30.520729	2009-06-08 02:04:30.520729	1
407	101	P-235a	1.0	Toussaint Louverture; coat of arms	\N	0.0	1989-01-01	\N	\N	\N	2009-06-08 02:09:58.398057	2009-06-08 02:10:16.336195	7
408	101	P-259a	1.0	Toussaint Louverture; coat of arms	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:11:21.130337	2009-06-08 02:11:21.130337	1
409	101	P-260a	2.0	Fortress on top of hill; coat of arms	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:12:26.534818	2009-06-08 02:12:26.534818	1
410	102	P-169g	20.0	Dozsa György; naked man with hammer and wheat	\N	0.0	1975-01-01	\N	\N	\N	2009-06-08 02:15:48.659561	2009-06-08 02:15:48.659561	\N
411	103	P-120a	100000.0	Woman with braid and bow; coat of arms	\N	0.0	1945-10-23	\N	\N	\N	2009-06-08 02:17:50.720096	2009-06-08 02:17:50.720096	\N
412	103	P-98	100.0	Man with long hair; castle on top of hill	\N	0.0	1930-07-01	\N	\N	\N	2009-06-08 02:19:47.028079	2009-06-08 02:19:47.028079	\N
413	104	P-325b	1.0		\N	0.0	1971-01-01	\N	\N	\N	2009-06-08 02:22:37.022518	2009-06-08 02:22:37.022518	\N
414	104	P-325?	1.0	Unknown signature	\N	0.0	1981-01-01	\N	\N	\N	2009-06-08 02:23:58.925509	2009-06-08 02:23:58.925509	\N
415	105	P-287c	100.0	Dragon; modern building, flower	\N	0.0	1999-01-01	\N	\N	\N	2009-06-08 02:25:09.661392	2009-06-08 02:25:09.661392	\N
416	106	P-48	10.0	Arngrimur Jonsson Laeroi; people with mittens and hats. Date indicated is March 29, 1961.	\N	0.0	1981-01-01	\N	\N	\N	2009-06-08 02:29:32.038894	2009-06-08 02:29:32.038894	\N
419	108	P-36	2.0	Brown and yellow pattern; Purple and orange pattern	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:36:27.75237	2009-06-08 02:36:27.75237	\N
420	108	P-38	10.0	Red and purple pattern; red and yellow pattern	\N	0.0	1992-01-01	\N	\N	\N	2009-06-08 02:37:16.43178	2009-06-08 02:37:16.43178	\N
421	109	P-122	20.0	Benito Juarez, scales, constitution; Monte Alban, Oax., Cocijo.  Polymer.	\N	0.0	2006-06-19	\N	\N	\N	2009-06-08 02:40:13.014033	2009-06-08 02:40:13.014033	\N
422	111	P-116	50.0	Joao de Azevedo Coutinho; sailing ship.  Overprinted with "Banco De Mocambique"	\N	0.0	1976-01-01	\N	\N	\N	2009-06-08 02:44:59.758095	2009-06-08 02:44:59.758095	\N
423	112	P-129	50.0	Soldiers with guns, mobile missile launcher, flag ceremony, coat of arms; peasants training to be soldiers	\N	0.0	1986-06-16	\N	\N	\N	2009-06-08 02:47:30.051667	2009-06-08 02:47:30.051667	\N
424	113	P-117	100.0	Aires de Ornelas; ship.  Overprinted with "Banco de Mocambique"	\N	0.0	1976-01-01	\N	\N	\N	2009-06-08 03:02:17.018062	2009-06-08 03:02:17.018062	\N
425	112	P-130	100.0	Flag ceremony, bald guy in suit; parade, w/ socialist banner	\N	0.0	1983-06-16	\N	\N	\N	2009-06-08 03:05:00.801159	2009-06-08 03:05:00.801159	\N
426	111	P-118	500.0	Caldas Xavier; coat of arms, ship.  Overprinted with "Banco de Mocambique"	\N	0.0	1976-01-01	\N	\N	\N	2009-06-08 03:06:51.32847	2009-06-08 03:06:51.32847	\N
427	111	P-119	1000.0	Gago Coutinho; relief of two adventurous looking men.  Overprinted with "Banco de Mocambique"	\N	0.0	1976-01-01	\N	\N	\N	2009-06-08 03:08:23.623351	2009-06-08 03:08:23.623351	\N
428	114	P-37	1.0	Man with glasses, ornate hat, temple; two deer, mountains	\N	0.0	1994-01-01	\N	\N	\N	2009-06-08 03:11:13.073735	2009-06-08 03:11:13.073735	\N
429	114	P-24	1.0	Man with military hat, glasses, temple; two deer	\N	0.0	1974-01-01	\N	\N	\N	2009-06-08 03:12:16.810985	2009-06-08 03:12:16.810985	\N
430	114	P-29c	2.0	Man with ornate hat, glasses, temple; leopard, coat of arms	\N	0.0	1981-01-01	\N	\N	\N	2009-06-08 03:13:36.642074	2009-06-08 03:13:36.642074	\N
431	115	P-186	10.0	Kate Sheppard, roses; Whio ducks.  Polymer.	\N	0.0	1999-01-01	\N	\N	\N	2009-06-08 03:15:57.623165	2009-06-08 03:15:57.623165	\N
432	115	P-185	5.0	Sir Edmund Hillary, Mt. Everest; Hoiho penguin, flowers.  Polymer.	\N	0.0	1999-01-01	\N	\N	\N	2009-06-08 03:17:27.213252	2009-06-08 03:17:27.213252	\N
433	117	P-167	1.0	Francisco Hernandez de Cordoba; triangle emblem, flower	\N	0.0	1991-01-01	\N	\N	\N	2009-06-08 03:22:23.187568	2009-06-08 03:22:23.187568	8
434	117	P-168	5.0	Francisco Hernandez de Cordoba; triangle emblem, flower	\N	0.0	1991-01-01	\N	\N	\N	2009-06-08 03:23:37.283369	2009-06-08 03:23:37.283369	8
435	117	P-169	10.0	Francisco Hernandez de Cordoba; triangle emblem, flower	\N	0.0	1991-01-01	\N	\N	\N	2009-06-08 03:24:25.340901	2009-06-08 03:24:25.340901	8
436	117	P-170	25.0	Francisco Hernandez de Cordoba; triangle emblem, flower	\N	0.0	1991-01-01	\N	\N	\N	2009-06-08 03:25:08.605613	2009-06-08 03:25:08.605613	\N
437	118	P-16	1000.0	Boat with outriggers; Coelacanth	\N	0.0	2005-01-01	\N	\N	\N	2010-01-10 02:19:41.900111	2010-01-10 02:19:41.900111	\N
438	119	P-122	1.0	Jose Marti; Casa natal de Jose Marti	\N	0.0	2003-01-01	\N	\N	\N	2010-01-10 02:28:53.674581	2010-01-10 02:28:53.674581	\N
439	78	P-264a	1000.0	Tomas Soley Guell; Instituto nacional de seguros	\N	0.0	2003-04-09	\N	\N	\N	2010-01-10 02:31:49.485364	2010-01-10 02:31:49.485364	\N
440	120	P-92	100.0	Elephant; Barrage D Inga II dam	\N	0.0	2000-01-04	\N	\N	\N	2010-01-10 18:51:47.886853	2010-01-10 18:51:47.886853	\N
441	78	P-50	1000.0	Man with curly hair; Building and horse drawn carriage 	\N	0.0	2001-01-01	\N	\N	\N	2010-01-10 19:01:07.313459	2010-01-10 19:01:07.313459	\N
442	7	P-50	1000.0	Man with curly hair; buildings and horse drawn carriage 	\N	0.0	2001-01-01	\N	\N	\N	2010-01-10 19:03:05.478009	2010-01-10 19:03:05.478009	\N
443	112	P-138	50000.0	Bank of Mozambique building; lake with a dam	\N	0.0	1993-06-16	\N	\N	\N	2010-01-10 19:06:28.757077	2010-01-10 19:06:28.757077	\N
444	22	P-93	1000.0	Brown seal; ornate gate	\N	0.0	2003-01-01	\N	\N	\N	2010-01-10 19:08:59.021117	2010-01-10 19:08:59.021117	\N
450	122	P-64c	1.0	Portrait of woman; bust of man with beard	\N	0.0	1974-01-01	\N	\N	\N	2010-01-11 06:33:30.994343	2010-01-11 06:33:30.994343	\N
451	97	P-NEW	50.0	Minarets; Pharaoh  	\N	0.0	2004-01-01	\N	\N	\N	2010-01-11 07:02:44.153227	2010-01-11 07:02:44.153227	\N
137	35	P-108	100.0	Woman on v. dark blue	\N	0.0	1991-01-01	\N	\N	\N	2009-05-05 21:58:25.786284	2010-01-11 07:07:15.997623	\N
452	35	P-105	100.0	Woman on orange/green	\N	0.0	1990-01-01	\N	\N	\N	2010-01-11 07:08:04.839008	2010-01-11 07:08:04.839008	\N
453	123	P-99a	5.0	Inca Pachacutek, decorated gords; Fortaleza de Sacsahuaman	\N	0.0	1969-06-20	\N	\N	\N	2010-04-18 21:14:18.455296	2010-04-18 21:14:18.455296	1
454	123	P-112	10.0	Garcilaso Inca de la Vega, corner of building with windows; Lago Titicaca, boats	\N	0.0	1976-11-17	\N	\N	\N	2010-04-18 21:16:24.964298	2010-04-18 21:16:24.964298	1
455	124	P-128	10.0	Ricardo Palma; woman in field, harvesting	\N	0.0	1986-01-17	\N	\N	\N	2010-04-18 21:20:04.039274	2010-04-18 21:20:04.039274	\N
456	124	P-129	10.0	Ricardo Palma; woman in field, harvesting	\N	0.0	1987-06-26	\N	\N	\N	2010-04-18 21:20:56.906887	2010-04-18 21:20:56.906887	\N
457	124	P-131b	50.0	Nicolas de Pierola; drilling rig, roughnecks, helicopter, 	\N	0.0	1987-06-26	\N	\N	\N	2010-04-18 21:23:27.21798	2010-04-18 21:23:48.457633	9
458	124	P-133	100.0	Ramon Castilla; woman with loom	\N	0.0	1987-06-26	\N	\N	\N	2010-04-18 21:26:58.831524	2010-04-18 21:27:23.799674	10
459	124	P-134b	500.0	Jose Gabriel Condorcanqui Tupac Amaru II; mountains, mountain climbers	\N	0.0	1987-06-26	\N	\N	\N	2010-04-18 21:29:41.557897	2010-04-18 21:29:41.557897	10
460	124	P-136	1000.0	Mariscal Andres Avelino Caceres; Ruinas de Chan Chan	\N	0.0	1988-06-28	\N	\N	\N	2010-04-18 21:32:25.06206	2010-04-18 21:32:25.06206	1
461	123	P-122	1000.0	Miguel Grau; fishermen with nets, watermark	\N	0.0	1981-11-05	\N	\N	\N	2010-04-18 21:35:46.350836	2010-04-18 21:35:46.350836	5
462	124	P-137	5000.0	Miguel Grau; fishermen with nets, watermark	\N	0.0	1988-06-28	\N	\N	\N	2010-04-18 21:37:41.275321	2010-04-18 21:37:41.275321	6
463	124	P-141	10000.0	Cesar Valejo; Santiago de Chuco, street scene	\N	0.0	1988-06-28	\N	\N	\N	2010-04-18 21:39:44.282956	2010-04-18 21:39:44.282956	1
449	121	P-88	10000000000000.0	Stack of rocks; modern tower, ancient tower	\N	0.0	2008-01-01	\N	\N	\N	2010-01-10 19:18:03.60996	2010-04-18 22:10:36.282415	\N
448	121	P-89	20000000000000.0	Stack of rocks; Miner, silos	\N	0.0	2008-01-01	\N	\N	\N	2010-01-10 19:16:58.433977	2010-04-18 22:11:01.793662	\N
447	121	P-90	50000000000000.0	Stack of rocks; dam, elephant	\N	0.0	2008-01-01	\N	\N	\N	2010-01-10 19:15:49.449351	2010-04-18 22:11:23.809442	\N
446	121	P-91	100000000000000.0	Stack of rocks; waterfall, water buffalo	\N	0.0	2008-01-01	\N	\N	\N	2010-01-10 19:14:34.518016	2010-04-18 22:11:38.664518	\N
445	121	P-86	100000000000.0	Small giraffes; grain silos	\N	0.0	2008-07-01	\N	\N	\N	2010-01-10 19:13:20.78468	2010-04-18 22:12:29.744174	\N
464	125	P-144	5.0	Purple, light-blue and dark blue on multicolor underprint. Conjoined busts of José Eduardo dos Santos and Antonio Agnostinho Neto at right.	\N	0.0	1999-10-01	\N	\N	\N	2011-01-10 03:56:26.068006	2011-01-10 03:56:26.068006	\N
465	61	P-110	20000.0	Blue-green on multicolor underprint. HCM at right, arms at center; packing factory.	\N	0.0	1991-01-01	\N	\N	\N	2011-01-10 04:01:28.6866	2011-01-10 04:01:28.6866	\N
466	61	P-107	2000.0	Brownish purple on lilac and multicolor underprint. HCM at right, arms at left; women workers in textile factory.	\N	0.0	1988-01-01	\N	\N	\N	2011-01-10 04:04:49.759304	2011-01-10 04:04:49.759304	\N
467	61	P-106	1000.0	Purple on gold and multicolor underprint. HCM at right, arms at left center; elephant logging at center.	\N	0.0	1988-01-01	\N	\N	\N	2011-01-10 04:06:43.868426	2011-01-10 04:06:43.868426	\N
468	61	P-115	10000.0	Red and red-violet on multicolor underprint. HCM at right, arms at center; brown -violet on multicolor underprint. Junks along coastline at center.	\N	0.0	1993-01-01	\N	\N	\N	2011-01-10 04:10:12.04771	2011-01-10 04:10:12.04771	\N
469	105	P-285c	20.0	Dark gray, orange and brown on multicolor underprint. Mythological tortoise at right; bank building at left, Bauhinia flower at center.	\N	0.0	1998-01-01	\N	\N	\N	2011-01-10 04:15:14.639473	2011-01-10 04:15:14.639473	\N
470	126	P-400	10.0	Purple, red, turquoise geometric patterns; interwoven security strip.	\N	0.0	2002-07-01	\N	\N	\N	2011-01-10 04:18:54.324732	2011-01-10 04:18:54.324732	\N
471	93	P-1991	100.0	Red, balding man with mustache, interwoven security strip; red, traditional castle	\N	0.0	2001-01-01	\N	\N	\N	2011-01-10 04:21:51.358776	2011-01-10 04:21:51.358776	\N
472	127	P-109	20.0	Green on green and tan multicolor underprint. King Rama IX wearing Field Marshal's uniform at center right; procession with King in military uniform and new bridge.	\N	0.0	2003-01-01	\N	\N	\N	2011-01-10 04:30:13.155318	2011-01-10 04:30:13.155318	\N
473	37	P-94	1000000.0	Uniface; black text on paper with blue and red fibers.	\N	0.0	1923-09-01	\N	\N	\N	2011-01-10 04:35:28.073435	2011-01-10 04:35:28.073435	\N
474	37	P-115	5000000000.0	Uniface, black on light paper that fades to lilac color, watermark.	\N	0.0	1923-09-10	\N	\N	\N	2011-01-10 04:40:12.243243	2011-01-10 04:40:12.243243	\N
475	37	P-85a	20000.0	Black on pink and blue underprint. Watermark of little circles.	\N	0.0	1923-02-20	\N	\N	\N	2011-01-10 04:43:50.706384	2011-01-10 04:43:50.706384	\N
172	37	P-83	100000.0	Dark brown on lilac with lilac tint at right. Portrait merchant Gisze at left by H. Holbein	\N	0.0	1923-02-01	\N	\N	\N	2009-05-10 03:30:45.731103	2011-01-10 04:51:11.527013	\N
477	128	P-106	50.0	Two horses with woman, wheat; woman with ship and cornucopia.	\N	0.0	1944-01-03	\N	\N	\N	2011-01-10 04:59:51.986912	2011-01-10 04:59:51.986912	\N
478	44	P-213	1.0	Brown on gold underprint. Arms at upper left. Miner at right.	\N	0.0	1938-01-01	\N	\N	\N	2011-01-10 05:05:32.074403	2011-01-10 05:05:32.074403	\N
479	13	P-19	1000000.0	Classical government building with cars out front; vase of flowers with fruit	\N	0.0	1999-01-01	\N	\N	\N	2011-01-10 05:16:18.959195	2011-01-10 05:16:18.959195	\N
480	129	P-3	3.0	Deep green, blue and black on multicolor underprint. Nude Ina and shark at left; fishing canoe and statue of the god of Te-Rongo.	\N	0.0	1987-01-01	\N	\N	\N	2011-01-10 05:22:08.790501	2011-01-10 05:22:08.790501	\N
481	105	P-278d	10.0	Dark green on yellow-green and multicolor underprint. Mythological carp at right; bank building at left, bank arms at center. Watermark: Helmeted warrior's head. 	\N	0.0	1991-01-01	\N	\N	\N	2011-01-10 05:27:50.636142	2011-01-10 05:27:50.636142	\N
482	130	P-36	1.0	Red-orange and purple on multicolor underprint. Arms at center, scarlet Ibis at left; twin towered modern bank building at center, oil refinery at right. Watermark: Bird of Paradise.	\N	0.0	1985-01-01	\N	\N	\N	2011-01-10 19:34:16.716576	2011-01-10 19:34:16.716576	\N
483	131	P-33b	10.0	Blue-green on tan underprint. Map of Burundi with arms superimposed at center.	\N	0.0	1989-10-01	\N	\N	\N	2011-01-11 02:55:45.787932	2011-01-11 02:55:45.787932	\N
484	132	P-1	5.0	Bright green, olive-green and red-brown on multicolor underprint. Greater Kudu at right, building at center; trader with camels.	\N	0.0	1994-01-01	\N	\N	\N	2011-01-11 03:27:31.205986	2011-01-11 03:28:17.902476	\N
485	133	P-31c	5.0	Brown-violet. Cape Buffalo herd at left center, arms at top left center, star near lower center; harvesting bananas.	\N	0.0	1987-01-01	\N	\N	\N	2011-01-11 03:37:33.328719	2011-01-11 03:37:33.328719	\N
486	134	P-31	100.0	Deep olive-green, dark green-blue and purple on multicolor underprint. Sultan Qaboos bin Sa'id at right, Faslajs irrigation system at center, arms at upper left; Verreaux's eagle and white oryx at center. Watermark: Sultan Qaboos bin Sa'id.	\N	0.0	1995-01-01	\N	\N	\N	2011-01-11 03:46:33.486933	2011-01-11 03:46:33.486933	\N
251	59	P-29a	0.1	Plants, no overprint; coat of arms. 	\N	0.0	1991-01-01	\N	\N	\N	2009-05-10 18:43:58.103294	2011-01-11 03:57:18.432983	\N
487	59	P-29b	0.1	Brown on green and gold underprint. Plants; Arms at center in gray.\r\n\r\n3 lines of black text over printed.	\N	0.0	1991-01-01	\N	\N	\N	2011-01-11 03:57:05.680949	2011-01-11 03:57:31.050611	\N
488	59	P-31b	0.5	Blue-green on green and gold underprint. Plants; arms at center in gray.	\N	0.0	1991-01-01	\N	\N	\N	2011-01-11 03:59:12.971629	2011-01-11 03:59:12.971629	\N
489	88	P-106	1000.0	Blue-violet, dark green and olive-brown on multicolor underprint. Mihai Eminescu at right, lily flower and quill pen at center. Arms at top left, bank monogram at upper center right; lime and blue flowers at left center, ruins of ancient fort of Histria at center, bank monogram at top right	\N	0.0	1998-01-01	\N	\N	\N	2011-01-11 04:05:20.112331	2011-01-11 04:05:56.731742	\N
490	100	P-24d	20.0	Brown and purple on multicolor underprint. Arms at center, Kaieteur Falls at right; shipbuilding at left, ferry Malali at right. Watermark: Macaw's (parrot) head.	\N	0.0	1989-01-01	\N	\N	\N	2011-01-11 04:09:56.055632	2011-01-11 04:09:56.055632	1
491	7	P-41	50.0	Brownish pink and slate blue on multicolor underprint. Aram Khachaturian at left, opera house at right; scene from Gayaneh Ballet and Mt. Ararat.	\N	0.0	1998-01-01	\N	\N	\N	2011-01-11 04:17:07.70971	2011-01-11 04:17:07.70971	\N
492	69	P-36	500.0	Woman at left, arms at center; minehead at center, helmet at right.	\N	0.0	1998-01-01	\N	\N	\N	2011-01-11 04:21:16.540561	2011-01-11 04:21:16.540561	\N
493	135	P-8	1.0	Brown on ochre, pale yellow-green and multicolor underprint. King Stefan at left, arms at upper center right. Bank monogram at upper right corner; monastery at Capriana at center right.	\N	0.0	2002-01-01	\N	\N	\N	2011-01-11 04:25:36.500822	2011-01-11 04:25:36.500822	\N
494	33	P-26	5.0	Green on multicolor underprint. Shoppers at a store, arms at upper right; logging elephants at left.	\N	0.0	1979-01-01	\N	\N	\N	2011-01-11 04:31:18.145145	2011-01-11 04:31:18.145145	\N
495	131	P-33d	10.0	Blue-green on tan underprint. Map of Burundi with arms superimposed at center.	\N	0.0	1997-02-05	\N	\N	\N	2011-01-11 04:39:43.431434	2011-01-11 04:39:43.431434	\N
496	69	P-35	100.0	Young woman at left, arms at center; harvesting bananas at center.	\N	0.0	1998-01-01	\N	\N	\N	2011-01-11 04:46:10.182669	2011-01-11 04:46:10.182669	\N
497	7	P-54?	2.0	Red printing, king and old church; cross and holy figures.	\N	0.0	2004-01-01	\N	\N	\N	2011-01-11 17:26:12.170082	2011-01-11 17:26:12.170082	\N
498	137		1.0	Black printing w/ red serial; yellow/orange printing w/ seal	\N	0.0	1941-12-29	\N	\N	\N	2011-07-18 21:09:05.887014	2011-07-18 21:09:05.887014	\N
499	138		1.0	Red printing, with serial and seal in green; very simple green printing	\N	0.0	1943-01-01	\N	\N	\N	2011-07-18 21:16:01.582286	2011-07-18 21:16:01.582286	\N
500	139		1.0	Black printing with red serial	\N	0.0	1942-01-01	\N	\N	\N	2011-07-18 21:21:31.31566	2011-07-18 21:21:31.31566	\N
501	139		5.0	Black printing with red serial	\N	0.0	1942-01-01	\N	\N	\N	2011-07-18 21:22:25.627701	2011-07-18 21:22:25.627701	\N
502	139		10.0	Black printing with red serial	\N	0.0	1942-01-01	\N	\N	\N	2011-07-18 21:23:15.573494	2011-07-18 21:23:15.573494	\N
503	140		10.0	Black printing, red serial	\N	0.0	1942-01-01	\N	\N	\N	2011-07-18 21:24:29.318316	2011-07-18 21:24:29.318316	\N
504	141		1.0	Black on purple pattern	\N	0.0	\N	\N	\N	\N	2011-07-18 21:27:50.313736	2011-07-18 21:27:50.313736	\N
505	139		1.0	Black printing with red serial numbers	\N	0.0	1943-01-01	\N	\N	\N	2011-07-18 21:29:01.306478	2011-07-18 21:29:01.306478	\N
506	140		50.0	Black printing with red serials	\N	0.0	1942-01-01	\N	\N	\N	2011-07-18 21:30:34.048237	2011-07-18 21:30:34.048237	\N
507	140		25.0	Black printing with red serial	\N	0.0	1942-01-01	\N	\N	\N	2011-07-18 21:32:06.943703	2011-07-18 21:32:06.943703	\N
508	142		10.0	Building (Solschacht); coat of arms	\N	0.0	1921-06-01	\N	\N	\N	2011-07-18 22:12:06.973899	2011-07-18 22:12:06.973899	\N
509	143		25.0	Church (Neustädter Kirche); coins and coat of arms	\N	0.0	1921-07-01	\N	\N	\N	2011-07-18 22:15:13.042925	2011-07-18 22:15:13.042925	\N
510	144		10.0	Red printing; Church (Kirche zu Egestrof)	\N	0.0	1921-06-30	\N	\N	\N	2011-07-18 22:18:36.323665	2011-07-18 22:18:36.323665	\N
511	145		25.0	Coat of arms; House (Klopstocks Geburtshaus)	\N	0.0	1921-06-01	\N	1924-12-31	\N	2011-07-18 22:23:27.406744	2011-07-18 22:23:27.406744	\N
512	146		25.0	Woman, trees, spring, grapes; small church in woods	\N	0.0	1921-04-25	\N	\N	\N	2011-07-18 22:26:24.809484	2011-07-18 22:26:24.809484	\N
267	63	P-52	1.0	Chinthe, coat of arms	\N	0.0	1993-01-01	\N	\N	\N	2009-05-13 03:21:12.395135	2009-05-13 03:30:51.993473	\N
513	147	P-38	50.0	"Socialist Visitor" Issue. Red and blue; Temple and olive branch; Olive branch and "50"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:12:07.248187	2011-12-27 10:12:07.248187	\N
514	147	P-37	10.0	"Socialist Visitor" Issue. Red and blue; Temple and olive branch; Olive branch and "10"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:13:26.543051	2011-12-27 10:13:26.543051	\N
515	147	P-36	5.0	"Socialist Visitor" Issue. Red and blue; Temple and olive branch; Olive branch and "5"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:14:20.257844	2011-12-27 10:14:20.257844	\N
516	147	P-35	1.0	"Socialist Visitor" Issue. Red and blue; Temple and olive branch; Olive branch and "1"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:16:00.289823	2011-12-27 10:16:00.289823	\N
517	148	P-34	50.0	"Socialist Visitor" Issue. Brown and violet; "50" and small arms; "50"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:17:40.536721	2011-12-27 10:17:40.536721	\N
518	148	P-33	10.0	"Socialist Visitor" Issue. Pink and green; "10" and arms at upper right; "10"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:18:28.666613	2011-12-27 10:18:28.666613	\N
519	148	P-32	5.0	"Socialist Visitor" Issue. Pink and purple; "5" and arms at upper right; "5"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:19:47.514868	2011-12-27 10:19:47.514868	\N
520	148	P-31	1.0	"Socialist Visitor" Issue. Pink and dark red; "1" and arms in upper right; "1"	\N	0.0	1988-01-01	\N	\N	\N	2011-12-27 10:20:44.913984	2011-12-27 10:20:44.913984	\N
521	147	P-10Ab	10.0	Black on red and green underprint. Worker and farmer at left center; Mountain. No watermark (modern reprint)	\N	0.0	1947-01-01	1990-01-01	\N	\N	2011-12-27 10:41:48.616815	2011-12-27 10:41:48.616815	\N
522	147	P-10b	5.0	Black on blue and red underprint. Worker and farmer at left center. Eight lines between second and third character at bottom; more connected Korean numeral at lower right; Mountain. No watermark (modern reprint).	\N	0.0	1947-01-01	1990-01-01	\N	\N	2011-12-27 10:43:53.217714	2011-12-27 10:43:53.217714	\N
523	147	P-8b	1.0	Black on orange and green underprint. Worker and farmer at left center; Mountain. No watermark (modern reprint).	\N	0.0	1947-01-01	1990-01-01	\N	\N	2011-12-27 10:45:40.416899	2011-12-27 10:45:40.416899	\N
524	148	P-7b	50.0	Blue on light olive underprint. No watermark (modern reprint)	\N	0.0	1947-01-01	1990-01-01	\N	\N	2011-12-27 10:46:50.339928	2011-12-27 10:46:50.339928	\N
525	148	P-6b	20.0	Green printing. No watermark (modern reprint).	\N	0.0	1947-01-01	1990-01-01	\N	\N	2011-12-27 10:47:54.412981	2011-12-27 10:47:54.412981	\N
526	148	P-5b	15.0	Brown printing. No watermark (modern reprint).	\N	0.0	1947-01-01	1990-01-01	\N	\N	2011-12-27 10:48:39.472534	2011-12-27 10:48:39.472534	\N
527	147	P-20b	10.0	Brown on multicolor underprint. Winged equestrian statue "Chonllima" at center, arms at upper left; Waterfront factory. Black serial; green seal at upper right (socialist visitor issue).	\N	0.0	1978-01-01	\N	\N	\N	2011-12-27 10:52:21.247112	2011-12-27 10:52:21.247112	\N
528	147	P-20d	10.0	Brown on multicolor underprint. Winged equestrian statue "Chonllima" at center, arms at upper left; Waterfront factory. Red serial; "10" in red guilloche on back (replacement).	\N	0.0	1978-01-01	\N	\N	\N	2011-12-27 10:54:50.709122	2011-12-27 10:54:50.709122	\N
529	147	P-19b	5.0	Blue-gray on multicolor underprint. Worker with book and gear, and woman with wheat at center, arms at upper left; Mount gumgang. Black serial; green seal lower left (socialist visitor issue).	\N	0.0	1978-01-01	\N	\N	\N	2011-12-27 10:56:31.761825	2011-12-27 10:56:31.761825	\N
530	147	P-18b	1.0	Olive-green on multicolor underprint. Two adults and two children at center, arms at upper left; Purple and multicolor. Soldier at left, woman with flowers at center, woman at right. Black serial; green seal lower left (socialist visitor issue).	\N	0.0	1978-01-01	\N	\N	\N	2011-12-27 10:58:28.53871	2011-12-27 10:58:28.53871	\N
531	147	P-21a	50.0	Olive-green on multicolor underprint. Soldier with man holding torch, woman with wheat, man with book at center, arms at upper left; Lake scene. Red and black serials; no seal (general circulation).	\N	0.0	1978-01-01	\N	\N	\N	2011-12-27 11:00:03.525965	2011-12-27 11:00:03.525965	\N
532	147	P-52	5.0	Black and green. Two men, atom; Hwanggang hydroelectric dam. Red and black serials.	\N	0.0	2002-01-01	\N	\N	\N	2011-12-27 11:05:00.700979	2011-12-27 11:05:00.700979	\N
533	147	P-22	100.0	Brown on lilac and multicolor underprint. Kim II Sung at center right, arms at upper left. Red and serial number; House with trees. No seal.	\N	0.0	1978-01-01	\N	\N	\N	2011-12-27 11:06:40.663428	2011-12-27 11:06:40.663428	\N
534	147	P-53	10.0	Three military men; monument, with statue of man with flag. Red serial.	\N	0.0	2002-01-01	\N	\N	\N	2011-12-27 11:09:43.716285	2011-12-27 11:09:43.716285	\N
535	147	P-43 (CS2)	100.0	Deep brown and red print. Arms at lower left center, Kim II Sung at right; Rural home at center. No watermark. Oversized red character stamp near serial.	\N	0.0	1992-01-01	\N	\N	\N	2011-12-27 11:12:57.324725	2011-12-27 11:16:30.951431	\N
536	147	P-42 (CS2)	50.0	Brown and red print. Tower of the Juche Idea and three professionals; forest and mountain range. Red serial, with specimen characters near.	\N	0.0	1992-01-01	\N	\N	\N	2011-12-27 11:18:35.640825	2011-12-27 11:18:35.640825	\N
537	147	P-41 (CS2)	10.0	Brown and red printing. Worker and "Chonllima" statue; floodgates. Red serial, specimen character stamp opposite.	\N	0.0	1992-01-01	\N	\N	\N	2011-12-27 11:20:47.485644	2011-12-27 11:20:47.485644	\N
538	147	P-40 (CS2)	5.0	Dark blue printing. Students; castle. Red and black serials with large specimen characters nearby.	\N	0.0	1998-01-01	\N	\N	\N	2011-12-27 11:22:34.734584	2011-12-27 11:22:34.734584	\N
539	147	P-39a (CS2)	1.0	Black and green printing. Woman with flowers; mountains and spirit at left. Eight digit serial, large red specimen characters nearby.	\N	0.0	1992-01-01	\N	\N	\N	2011-12-27 11:25:35.01841	2011-12-27 11:25:35.01841	\N
540	147	P-39b (CS2)	1.0	Black and green printing. Woman with flowers; mountains and spirit at left. Six digit serial, large red specimen characters nearby.	\N	0.0	1992-01-01	\N	\N	\N	2011-12-27 11:26:17.235448	2011-12-27 11:26:17.235448	\N
541	147	P-48	200.0	Green on multicolor underprint. Flowers; "200".	\N	0.0	2005-01-01	\N	\N	\N	2011-12-27 11:28:19.432574	2011-12-27 11:28:19.432574	\N
542	149	P-40	10.0	Red printing with foil strip, hologram. Yusof bin Ishak; sports scenes.	\N	0.0	1999-01-01	\N	\N	\N	2011-12-27 11:35:50.709624	2011-12-27 11:35:50.709624	\N
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY notes (id, master_id, printed_on, serial, description, grade_id, created_at, updated_at, replacement, specimen) FROM stdin;
126	106	\N	B?5209854		729449236	2009-05-05 20:13:33.724848	2009-05-05 20:13:33.724848	\N	f
134	112	\N		Crisp, slight fuzzing on corners, otherwise great	4397270	2009-05-05 20:39:41.9133	2009-05-05 20:39:41.9133	\N	f
36	30	\N	AP 1461104		729449236	2009-04-29 20:03:06.633972	2009-04-29 20:03:06.633972	\N	f
48	37	\N	?? 6697485		729449236	2009-04-29 20:11:37.708955	2009-04-29 20:11:37.708955	\N	f
49	38	\N	TB 7242363		729449236	2009-04-29 20:12:26.767676	2009-04-29 20:12:26.767676	\N	f
67	53	\N	2A 212A 095536		729449236	2009-04-29 23:50:33.143612	2009-04-29 23:50:33.143612	\N	f
50	39	\N	KB 1261795		729449236	2009-04-29 20:14:36.155026	2009-04-29 20:14:36.155026	\N	f
19	16	\N	91.591.454 B		729449236	2009-04-29 07:01:43.097011	2009-04-29 07:01:43.097011	\N	f
16	13	\N	77.559.211 I		729449236	2009-04-29 06:57:30.661016	2009-04-29 06:57:30.661016	\N	f
54	43	\N	B/1 6463236		729449236	2009-04-29 23:18:50.577703	2009-04-29 23:18:50.577703	\N	f
68	54	\N	2A 2946A 051711		729449236	2009-04-29 23:53:16.581778	2009-04-29 23:53:16.581778	\N	f
3	4	\N			729449236	2009-04-29 06:24:48.165938	2009-04-29 06:24:48.165938	\N	f
2	3	\N			729449236	2009-04-29 06:21:23.419095	2009-04-29 06:21:23.419095	\N	f
5	6	\N	18.960.712 C		729449236	2009-04-29 06:31:40.529524	2009-04-29 06:31:40.529524	\N	f
7	7	\N	88.629.936 A		729449236	2009-04-29 06:37:15.410651	2009-04-29 06:37:15.410651	\N	f
6	7	\N	89.071.734 A		729449236	2009-04-29 06:36:42.115414	2009-04-29 06:36:42.115414	\N	f
9	8	\N	14.647.816 C		729449236	2009-04-29 06:40:42.550223	2009-04-29 06:40:42.550223	\N	f
8	8	\N	14.867.036 C		729449236	2009-04-29 06:40:09.361182	2009-04-29 06:40:09.361182	\N	f
11	9	\N	64.561.336 A		729449236	2009-04-29 06:42:23.026267	2009-04-29 06:42:23.026267	\N	f
10	9	\N	44.358.432 A		729449236	2009-04-29 06:42:03.867679	2009-04-29 06:42:03.867679	\N	f
13	10	\N	16.441.920 D		729449236	2009-04-29 06:44:02.730738	2009-04-29 06:44:02.730738	\N	f
12	10	\N	15.864.735 D		729449236	2009-04-29 06:43:43.665826	2009-04-29 06:43:43.665826	\N	f
17	14	\N	08.253.336 D		729449236	2009-04-29 06:59:21.075159	2009-04-29 06:59:21.075159	\N	f
18	15	\N	05.138.451 E		729449236	2009-04-29 07:00:24.314161	2009-04-29 07:00:24.314161	\N	f
100	85	\N			729449236	2009-04-30 04:46:03.11424	2009-04-30 04:46:03.11424	\N	f
15	12	\N	78.401.291 D		729449236	2009-04-29 06:51:54.988106	2009-04-29 06:51:54.988106	\N	f
20	17	\N	31.074.936 A		729449236	2009-04-29 07:04:25.772752	2009-04-29 07:04:25.772752	\N	f
21	18	\N	95.799.736 D		729449236	2009-04-29 07:14:22.83261	2009-04-29 07:14:22.83261	\N	f
53	42	\N	A/1 7097711		729449236	2009-04-29 23:17:40.386893	2009-04-29 23:17:40.386893	\N	f
106	91	\N		Paper UNC; sloppy printing	4397270	2009-04-30 05:01:16.146721	2009-04-30 05:01:16.146721	\N	f
142	117	\N		Small folds on two corners, otherwise crisp and sharp	5953181	2009-05-05 20:57:30.727142	2009-05-05 20:57:30.727142	\N	f
150	124	\N	R 160514		729449236	2009-05-05 21:23:23.444274	2009-05-05 21:23:23.444274	\N	f
158	129	\N	AP 5474631		729449236	2009-05-05 21:41:59.144123	2009-05-05 21:41:59.144123	\N	f
127	106	\N	??3662833		729449236	2009-05-05 20:13:53.351069	2009-05-05 20:13:53.351069	\N	f
135	113	\N		Minor stain on lower left obverse, slight fuzzing of corners, otherwise great	5953181	2009-05-05 20:41:25.953888	2009-05-05 20:41:25.953888	\N	f
143	118	\N		No creases or wrinkles; slight fuzzing of corners; large water stain	5817884	2009-05-05 20:59:40.760671	2009-05-05 20:59:40.760671	\N	f
151	124	\N	R 954836		729449236	2009-05-05 21:23:44.879077	2009-05-05 21:23:44.879077	\N	f
22	19	\N	02.814.244 A		729449236	2009-04-29 07:15:40.281787	2009-04-29 07:15:40.281787	\N	f
23	20	\N	49.853.036 A		729449236	2009-04-29 07:16:57.173343	2009-04-29 07:16:57.173343	\N	f
61	50	\N	CJ 43589609		729449236	2009-04-29 23:32:27.361074	2009-04-29 23:32:27.361074	\N	f
65	51	\N	2450A 068643		729449236	2009-04-29 23:40:24.54719	2009-04-29 23:40:24.54719	\N	f
159	129	\N	BD 2828711	Small fold in upper right obverse	4397270	2009-05-05 21:42:32.57084	2009-05-05 21:42:32.57084	\N	f
166	133	\N	BS 0296928		729449236	2009-05-05 21:49:26.342322	2009-05-05 21:49:26.342322	\N	f
173	140	\N	AC 4127672	Worn; graffiti on obverse	73	2009-05-05 22:05:33.663026	2009-05-05 22:05:33.663026	\N	f
14	11	\N	17128916		729449236	2009-04-29 06:49:37.853176	2009-04-29 06:49:37.853176	\N	f
25	21	\N	24112601		729449236	2009-04-29 19:11:45.964405	2009-04-29 19:11:45.964405	\N	f
24	21	\N	13620506		729449236	2009-04-29 19:11:26.851328	2009-04-29 19:11:26.851328	\N	f
26	22	\N		Crisp, sharp corners; can't tell if the paper is tan or just aged ..	4397270	2009-04-29 19:22:25.627215	2009-04-29 19:22:25.627215	\N	f
86	71	\N	A 7257044268 A		729449236	2009-04-30 03:13:59.711352	2009-04-30 03:13:59.711352	\N	f
27	23	\N		Crisp paper, sharp corners; paper is yellowed ... age?	4397270	2009-04-29 19:27:13.582488	2009-04-29 19:27:13.582488	\N	f
28	24	\N		Crisp paper, sharp edges; slightly yellowed .. age?	4397270	2009-04-29 19:30:21.882722	2009-04-29 19:30:21.882722	\N	f
29	25	\N	1063 748631	Crisp paper, sharp corners; slightly yellowed .. age?	4397270	2009-04-29 19:32:34.314072	2009-04-29 19:32:34.314072	\N	f
30	26	\N	A/1 06500477		729449236	2009-04-29 19:52:59.006369	2009-04-29 19:52:59.006369	\N	f
31	27	\N			729449236	2009-04-29 19:57:12.443937	2009-04-29 19:57:12.443937	\N	f
33	28	\N			729449236	2009-04-29 20:01:03.205203	2009-04-29 20:01:03.205203	\N	f
180	147	\N	AD 5255770	Heavy wrinkling, some smudging	72	2009-05-05 22:19:23.069785	2009-05-05 22:19:23.069785	\N	f
32	28	\N			729449236	2009-04-29 20:00:09.433658	2009-04-29 20:00:09.433658	\N	f
35	29	\N	AO 0228651		729449236	2009-04-29 20:02:15.040969	2009-04-29 20:02:15.040969	\N	f
37	30	\N	A3 0373457		5817884	2009-04-29 20:03:54.658936	2009-04-29 20:03:54.658936	\N	f
79	65	\N	A 8991048565 A		729449236	2009-04-30 03:04:34.790914	2009-04-30 03:04:34.790914	\N	f
80	66	\N	A 0363091814 A		729449236	2009-04-30 03:06:18.821046	2009-04-30 03:06:18.821046	\N	f
82	67	\N	A 2300073290 A		729449236	2009-04-30 03:07:57.351772	2009-04-30 03:07:57.351772	\N	f
81	67	\N	A 2490062685 A		729449236	2009-04-30 03:07:38.583943	2009-04-30 03:07:38.583943	\N	f
91	76	\N	A 1048070690 A		729449236	2009-04-30 03:22:42.761152	2009-04-30 03:22:42.761152	\N	f
93	78	\N	A 6156097687 A		729449236	2009-04-30 03:25:45.226263	2009-04-30 03:26:16.812431	\N	f
94	79	\N	B 0266077948 A		729449236	2009-04-30 03:28:41.605557	2009-04-30 03:28:41.605557	\N	f
95	80	\N	A 9407062690 A		729449236	2009-04-30 03:29:57.898253	2009-04-30 03:29:57.898253	\N	f
96	81	\N	A 2844037290 A		729449236	2009-04-30 03:31:26.809789	2009-04-30 03:31:26.809789	\N	f
128	107	\N		Aged paper; very slight rounding; very small stain on top left corner	5953181	2009-05-05 20:22:21.44141	2009-05-05 20:22:21.44141	\N	f
38	31	\N	A0 4446568		729449236	2009-04-29 20:04:40.353712	2009-04-29 20:04:40.353712	\N	f
136	113	\N		Wrinkles and small corner creases; some staining on edges, otherwise attractive	5817883	2009-05-05 20:42:51.655434	2009-05-05 20:42:51.655434	\N	f
144	119	\N	TG 844553	Very minor handling fold in lower right obverse	4397270	2009-05-05 21:02:29.609194	2009-05-05 21:02:29.609194	\N	f
152	125	\N	FC 421359	Light wrinkling, no folds or creases	4397270	2009-05-05 21:26:31.095546	2009-05-05 21:26:31.095546	\N	f
160	130	\N	DM 8678807		729449236	2009-05-05 21:43:48.835899	2009-05-05 21:43:48.835899	\N	f
167	134	\N	A0614515	Well worn, many folds and nicks, no pieces missing, no holes	5817884	2009-05-05 21:51:46.990848	2009-05-05 21:51:46.990848	\N	f
174	141	\N	AC 2159314	Obviously circulated, but in decent shape with only one hard crease	5817883	2009-05-05 22:06:57.373433	2009-05-05 22:06:57.373433	\N	f
181	148	\N	AA 4441306	Upper right obverse corner is heavily wrinkled, otherwise, XF	5817883	2009-05-05 22:21:27.84783	2009-05-05 22:21:27.84783	\N	f
187	154	\N	AA 8699143		72	2009-05-05 22:32:07.309403	2009-05-05 22:32:07.309403	\N	f
40	32	\N	A? 6803936		729449236	2009-04-29 20:05:47.629634	2009-04-29 20:05:47.629634	\N	f
39	32	\N	AK 6429611		729449236	2009-04-29 20:05:22.629954	2009-04-29 20:05:22.629954	\N	f
42	33	\N	A0 2941438		729449236	2009-04-29 20:06:45.403571	2009-04-29 20:06:45.403571	\N	f
41	33	\N	AH 9528816		729449236	2009-04-29 20:06:28.0954	2009-04-29 20:06:28.0954	\N	f
44	34	\N	AB 2680614		729449236	2009-04-29 20:07:53.517936	2009-04-29 20:07:53.517936	\N	f
43	34	\N	A? 6982125		729449236	2009-04-29 20:07:23.653226	2009-04-29 20:07:23.653226	\N	f
46	35	\N	A? 8095758		729449236	2009-04-29 20:08:54.580051	2009-04-29 20:08:54.580051	\N	f
45	35	\N	A? 8194426		729449236	2009-04-29 20:08:37.112231	2009-04-29 20:08:37.112231	\N	f
47	36	\N	?? 8909685		729449236	2009-04-29 20:10:39.454028	2009-04-29 20:10:39.454028	\N	f
97	82	\N	A 6291068765 A		729449236	2009-04-30 03:33:09.681905	2009-04-30 03:33:09.681905	\N	f
98	83	\N	A 6884012640 A		729449236	2009-04-30 03:54:45.766946	2009-04-30 03:54:45.766946	\N	f
99	84	\N	A 1854009536 A		729449236	2009-04-30 03:56:24.089545	2009-04-30 03:56:24.089545	\N	f
92	77	\N	A 1704048760 A		729449236	2009-04-30 03:24:17.895944	2009-04-30 03:24:17.895944	\N	f
102	87	\N			729449236	2009-04-30 04:52:51.296669	2009-04-30 04:52:51.296669	\N	f
103	88	\N			729449236	2009-04-30 04:55:30.38623	2009-04-30 04:55:30.38623	\N	f
104	89	\N			729449236	2009-04-30 04:57:32.004676	2009-04-30 04:57:32.004676	\N	f
105	90	\N			729449236	2009-04-30 04:58:43.962995	2009-04-30 04:58:43.962995	\N	f
107	93	\N		Paper UNC; horizontal cut offset.	4397270	2009-04-30 05:04:33.897638	2009-04-30 05:04:33.897638	\N	f
117	100	\N	PR 4503473		729449236	2009-05-04 06:05:34.299494	2009-05-04 06:05:34.299494	\N	f
116	100	\N	RG 5222912		729449236	2009-05-04 06:05:08.719929	2009-05-04 06:05:08.719929	\N	f
118	101	\N	EL 2245908		729449236	2009-05-04 06:06:52.909935	2009-05-04 06:06:52.909935	\N	f
120	102	\N	ET 3142154		729449236	2009-05-04 06:08:38.869968	2009-05-04 06:08:38.869968	\N	f
119	102	\N	GB 0512013		729449236	2009-05-04 06:08:23.049627	2009-05-04 06:08:23.049627	\N	f
122	103	\N	HF 7406573		729449236	2009-05-04 06:10:36.049918	2009-05-04 06:10:36.049918	\N	f
121	103	\N	EH 0250340		729449236	2009-05-04 06:10:16.48355	2009-05-04 06:10:16.48355	\N	f
108	94	\N			729449236	2009-04-30 05:05:52.337646	2009-04-30 05:05:52.337646	\N	f
109	95	\N			729449236	2009-04-30 05:06:56.878623	2009-04-30 05:06:56.878623	\N	f
129	108	\N		Three creases, soft corners, paper is pretty dark; printing is still sharp and clear.	5817884	2009-05-05 20:25:23.730342	2009-05-05 20:25:23.730342	\N	f
137	114	\N		Missing a corner, doesn't extend into design; nicks, staining, wrinkles on edges	73	2009-05-05 20:44:58.325064	2009-05-05 20:44:58.325064	\N	f
145	120	\N	FP565245		729449236	2009-05-05 21:06:15.669867	2009-05-05 21:06:15.669867	\N	f
153	126	\N	AQ 0814239	Very small fold in upper right obverse corner	4397270	2009-05-05 21:29:31.469976	2009-05-05 21:29:31.469976	\N	f
175	142	\N	AB 4104928	Worn, no missing pieces; security strip is starting to peel	5817884	2009-05-05 22:08:45.581373	2009-05-05 22:08:45.581373	\N	f
182	149	\N	AC 3643791	Would be F or XF, except for major damage to back of note .. stuck to another one?	73	2009-05-05 22:23:53.505416	2009-05-05 22:23:53.505416	\N	f
188	155	\N	AB 1046731		72	2009-05-05 22:33:34.448706	2009-05-05 22:33:34.448706	\N	f
161	130	\N	DM 9092790		729449236	2009-05-05 21:44:00.193719	2009-05-10 05:22:56.624558	\N	f
168	135	\N	DZ 0542053		729449236	2009-05-05 21:54:18.598075	2009-05-23 19:40:11.157889	f	f
52	41	\N	A/3 5119461		729449236	2009-04-29 23:15:58.832986	2009-04-29 23:15:58.832986	\N	f
55	44	\N	T3262575		729449236	2009-04-29 23:24:06.221416	2009-04-29 23:24:06.221416	\N	f
63	45	\N	BK 62075809		729449236	2009-04-29 23:33:27.887257	2009-04-29 23:33:27.887257	\N	f
56	45	\N	DK 64855270		729449236	2009-04-29 23:27:04.865384	2009-04-29 23:27:04.865384	\N	f
59	48	\N	KA 20879225		729449236	2009-04-29 23:30:36.411294	2009-04-29 23:30:36.411294	\N	f
60	49	\N	AB 21194204		729449236	2009-04-29 23:31:31.075166	2009-04-29 23:31:31.075166	\N	f
69	55	\N	2A 3148A 019958		729449236	2009-04-30 00:00:49.859158	2009-04-30 00:00:49.859158	\N	f
64	47	\N	DF 74209002	Light wrinkling; still crisp and sharp	4397270	2009-04-29 23:34:17.914469	2009-04-29 23:34:17.914469	\N	f
58	47	\N	JF 78255534	Small fold in corner	4397270	2009-04-29 23:29:32.145435	2009-04-29 23:29:32.145435	\N	f
62	46	\N	HE 67525607		729449236	2009-04-29 23:33:04.338073	2009-04-29 23:33:04.338073	\N	f
57	46	\N	FD 55382633		729449236	2009-04-29 23:28:14.744131	2009-04-29 23:28:14.744131	\N	f
66	52	\N	1078A 082241		729449236	2009-04-29 23:48:33.687715	2009-04-29 23:48:33.687715	\N	f
70	56	\N	1A 858A 082397		729449236	2009-04-30 02:40:51.022233	2009-04-30 02:40:51.022233	\N	f
71	57	\N	2A 1558A 070136		729449236	2009-04-30 02:43:38.158898	2009-04-30 02:43:38.158898	\N	f
110	96	\N		Paper UNC; vertically offset.	4397270	2009-04-30 05:08:08.453098	2009-04-30 05:08:08.453098	\N	f
111	97	\N		Counterfeit note.	729449236	2009-04-30 05:16:25.826041	2009-04-30 05:16:25.826041	\N	f
113	98	\N	AM 6175141		729449236	2009-05-04 06:01:14.091706	2009-05-04 06:01:14.091706	\N	f
112	98	\N	AC 1989210		729449236	2009-05-04 06:00:58.172071	2009-05-04 06:00:58.172071	\N	f
115	99	\N	HC 7569025		729449236	2009-05-04 06:03:48.548988	2009-05-04 06:03:48.548988	\N	f
130	109	\N		Wrinkled, soft corners, small stains on obverse and reverse.  Printing is still sharp.	5817884	2009-05-05 20:28:01.322662	2009-05-05 20:28:01.322662	\N	f
114	99	\N	GG 0098601		729449236	2009-05-04 06:03:30.48746	2009-05-04 06:03:30.48746	\N	f
101	86	\N			729449236	2009-04-30 04:46:51.193111	2009-04-30 04:46:51.193111	\N	f
138	114	\N		Slight fuzzing on corners, paper looks a little aged, but clean, uniform appearance	5953181	2009-05-05 20:45:43.254022	2009-05-05 20:45:43.254022	\N	f
146	122	\N	AL 9345290		729449236	2009-05-05 21:18:56.656836	2009-05-05 21:18:56.656836	\N	f
154	126	\N	AQ 0381816		729449236	2009-05-05 21:29:52.975056	2009-05-05 21:29:52.975056	\N	f
162	131	\N	AE 5298458		729449236	2009-05-05 21:46:21.645464	2009-05-05 21:46:21.645464	\N	f
176	143	\N	AB 7598486	Winkled, folded, no hard creases	5817883	2009-05-05 22:10:52.707407	2009-05-05 22:10:52.707407	\N	f
183	150	\N	AA 1893219	Worn but intact	72	2009-05-05 22:25:29.587277	2009-05-05 22:25:29.587277	\N	f
1	1	\N			729449236	2009-04-29 05:47:08.281586	2009-05-15 23:36:44.503059	f	f
123	104	\N	CE 0343565		729449236	2009-05-05 20:08:14.253612	2009-05-05 20:08:14.253612	\N	f
131	109	\N		Light wrinkling, corners slightly fuzzed, looks good	72	2009-05-05 20:28:54.546623	2009-05-05 20:28:54.546623	\N	f
139	115	\N	ND 4677453	Slightly wrinkled surface, otherwise perfect	4397270	2009-05-05 20:49:41.236941	2009-05-05 20:49:41.236941	\N	f
147	122	\N	AH 0578776		729449236	2009-05-05 21:19:18.590259	2009-05-05 21:19:18.590259	\N	f
155	127	\N	VN 7905316		729449236	2009-05-05 21:31:36.421156	2009-05-05 21:31:36.421156	\N	f
163	131	\N	AL 9423253		729449236	2009-05-05 21:46:44.001693	2009-05-05 21:46:44.001693	\N	f
170	137	\N	AB 9878709	Worn with creases, but still clearly printed, good corners	72	2009-05-05 21:59:39.749073	2009-05-05 21:59:39.749073	\N	f
177	144	\N	AA 8032820	Wrinkles and folds, no hard creases	5953181	2009-05-05 22:13:56.185407	2009-05-05 22:13:56.185407	\N	f
184	151	\N	AA 6449221	Couple of creases, noticeable staining around edges	5817884	2009-05-05 22:27:04.782185	2009-05-05 22:27:04.782185	\N	f
72	58	\N	104 073970		729449236	2009-04-30 02:47:49.345422	2009-04-30 02:47:49.345422	\N	f
73	59	\N	B17542 019687		729449236	2009-04-30 02:50:41.114374	2009-04-30 02:50:41.114374	\N	f
74	60	\N	B06239 038265		729449236	2009-04-30 02:52:53.896315	2009-04-30 02:52:53.896315	\N	f
75	61	\N	B03491 094361		729449236	2009-04-30 02:54:40.876739	2009-04-30 02:54:40.876739	\N	f
77	63	\N	A 3074092165 A		729449236	2009-04-30 03:00:55.501328	2009-04-30 03:00:55.501328	\N	f
76	62	\N	A 4379051711 A		729449236	2009-04-30 02:58:16.890369	2009-04-30 02:58:16.890369	\N	f
78	64	\N	A 0027031687 A		729449236	2009-04-30 03:03:06.446859	2009-04-30 03:03:06.446859	\N	f
124	104	\N	?H 3678048		729449236	2009-05-05 20:08:48.110941	2009-05-05 20:08:48.110941	\N	f
132	110	\N		Sharp corners, crisp paper; light wrinkles around edges, no creases	5953181	2009-05-05 20:31:32.6101	2009-05-05 20:31:32.6101	\N	f
140	116	\N		Slight wrinkling on surface; small grease stains near portrait; otherwise, great condition.	5817883	2009-05-05 20:51:56.810549	2009-05-05 20:51:56.810549	\N	f
148	123	\N	DA 4345181		729449236	2009-05-05 21:20:38.469058	2009-05-05 21:20:38.469058	\N	f
156	128	\N	CS158636		729449236	2009-05-05 21:40:00.56251	2009-05-05 21:40:00.56251	\N	f
164	132	\N	CF 0943963		729449236	2009-05-05 21:48:04.792382	2009-05-05 21:48:04.792382	\N	f
171	138	\N	AC 0821773	Well worn, but not missing any pieces	73	2009-05-05 22:01:55.641911	2009-05-05 22:01:55.641911	\N	f
178	145	\N	AA 3210673	Folds and wrinkles, no hard creases	5817883	2009-05-05 22:15:39.369551	2009-05-05 22:15:39.369551	\N	f
185	152	\N	AB 6012396	Fold in middle, small wrinkles, otherwise great	5953181	2009-05-05 22:29:03.055463	2009-05-05 22:29:03.055463	\N	f
125	105	\N	?? 3779765		729449236	2009-05-05 20:10:08.161514	2009-05-05 20:10:08.161514	\N	f
133	111	\N		Crisp paper, edges sharp; older paper	4397270	2009-05-05 20:37:20.497856	2009-05-05 20:37:20.497856	\N	f
141	117	\N		Slight staining on edge, worn corner	5817883	2009-05-05 20:56:46.902728	2009-05-05 20:56:46.902728	\N	f
149	123	\N	DA 1326231		729449236	2009-05-05 21:20:58.653631	2009-05-05 21:20:58.653631	\N	f
157	128	\N	AD668576		729449236	2009-05-05 21:40:18.99478	2009-05-05 21:40:18.99478	\N	f
165	132	\N	CF 0950404		729449236	2009-05-05 21:48:20.732396	2009-05-05 21:48:20.732396	\N	f
172	139	\N	AD 8884006	No hard creases, small stain on portrait	72	2009-05-05 22:03:54.338186	2009-05-05 22:03:54.338186	\N	f
179	146	\N	AE 3520346	Worn, with creases	72	2009-05-05 22:17:56.385553	2009-05-05 22:17:56.385553	\N	f
186	153	\N	AB 9128272	Worn, minor smudging	5817883	2009-05-05 22:30:48.299784	2009-05-05 22:30:48.299784	\N	f
189	156	\N	AB 6749240	Small pinhole, lots of staining	5817884	2009-05-06 19:48:06.928938	2009-05-06 19:48:06.928938	\N	f
190	157	\N	AA 2866997	Minor folds, wrinkles, smudge on reverse upper right	5817883	2009-05-06 19:50:23.841927	2009-05-06 19:50:23.841927	\N	f
191	158	\N	AB 5045613	Significant staining, minor graffiti on upper right obverse	73	2009-05-06 19:53:07.125011	2009-05-06 19:53:07.125011	\N	f
192	159	\N			729449236	2009-05-10 02:46:10.862333	2009-05-10 02:46:10.862333	\N	f
193	160	\N	529 752894	Lines in printing indicate creasing; could be ironed	73	2009-05-10 02:53:34.29583	2009-05-10 02:53:34.29583	\N	f
194	161	\N	75 676233		5817883	2009-05-10 02:55:22.306074	2009-05-10 02:55:22.306074	\N	f
195	162	\N	U 6868041	Nicks, staining, could have been ironed	5817884	2009-05-10 02:57:32.525994	2009-05-10 02:57:32.525994	\N	f
196	162	\N	O 7253974	Just about perfect	4397270	2009-05-10 02:58:23.635008	2009-05-10 02:58:23.635008	\N	f
197	163	\N	Q 2888245	No missing pieces, but very heavily worn, pinholes	73	2009-05-10 03:00:39.633184	2009-05-10 03:00:39.633184	\N	f
198	164	\N	H 7966802	Heavily used, no holes or tears into the design	5817884	2009-05-10 03:03:00.786685	2009-05-10 03:03:00.786685	\N	f
199	165	\N	Reihe 2 168279	Worn, no holes, no tears; horizontal and vertical crease marks	5817884	2009-05-10 03:05:35.082883	2009-05-10 03:05:35.082883	\N	f
200	166	\N	0628757M	Light creasing, small stain on obverse date	73	2009-05-10 03:08:02.190272	2009-05-10 03:08:02.190272	\N	f
201	167	\N	K 28919423	No holes, worn edges but no tears, significant horizontal and vertical creases	5817884	2009-05-10 03:10:43.932307	2009-05-10 03:10:43.932307	\N	f
202	168	\N	1972314K	Light folding and smudging on paper	5953181	2009-05-10 03:13:16.074499	2009-05-10 03:13:16.074499	\N	f
203	168	\N	7164716M	Beautiful condition, very slight fuzzing of corners	4397270	2009-05-10 03:14:00.178187	2009-05-10 03:14:00.178187	\N	f
204	169	\N	700012	Light staining around edges, fuzzy corners, otherwise nice	72	2009-05-10 03:20:03.818236	2009-05-10 03:20:03.818236	\N	f
205	170	\N	S 893298 *	Slight folding and fuzzing at corners, otherwise great.	5953181	2009-05-10 03:22:51.659044	2009-05-10 03:25:56.462839	t	f
206	171	\N	7p 452473	Light fuzzing and folding at corners	5953181	2009-05-10 03:28:54.960369	2009-05-10 03:28:54.960369	f	f
208	173	\N	MM	Staining, otherwise Fine	5817884	2009-05-10 03:33:22.480389	2009-05-10 03:33:22.480389	f	f
209	174	\N	002738	Light staining, pinholes, vertical crease line, small graffiti in upper right obverse	73	2009-05-10 03:35:36.03823	2009-05-10 03:35:36.03823	f	f
210	175	\N	AM 2315783		729449236	2009-05-10 03:50:51.091215	2009-05-10 03:50:51.091215	f	f
211	176	\N	AK 0400517		729449236	2009-05-10 03:51:26.424094	2009-05-10 03:51:26.424094	f	f
212	177	\N	AA 9202800		729449236	2009-05-10 03:53:22.208012	2009-05-10 03:53:22.208012	f	f
213	178	\N	BA 6091216		729449236	2009-05-10 03:54:14.901469	2009-05-10 03:54:14.901469	f	f
214	179	\N	AA 91568728		729449236	2009-05-10 03:57:41.446525	2009-05-10 03:57:41.446525	f	f
215	180	\N	BB 61268283		729449236	2009-05-10 03:59:26.083686	2009-05-10 03:59:26.083686	f	f
216	181	\N	EA 67374364		729449236	2009-05-10 04:00:11.050748	2009-05-10 04:00:11.050748	f	f
217	181	\N	EA 83509436		729449236	2009-05-10 04:00:27.249059	2009-05-10 04:00:27.249059	f	f
218	182	\N	KB 118224833		729449236	2009-05-10 04:01:03.817174	2009-05-10 04:01:03.817174	f	f
219	183	\N	MA 86811137		729449236	2009-05-10 04:01:37.291227	2009-05-10 04:01:37.291227	f	f
220	184	\N	A?7633038		729449236	2009-05-10 04:06:06.530345	2009-05-10 04:06:06.530345	f	f
221	185	\N	AT2985440		729449236	2009-05-10 04:06:51.859452	2009-05-10 04:06:51.859452	f	f
222	186	\N	A?7352136		729449236	2009-05-10 04:07:36.123451	2009-05-10 04:07:36.123451	f	f
223	187	\N	1553529		729449236	2009-05-10 04:08:45.439628	2009-05-10 04:08:45.439628	f	f
224	187	\N	9115858		729449236	2009-05-10 04:08:59.208317	2009-05-10 04:08:59.208317	f	f
83	68	\N	A 6330068466 A		729449236	2009-04-30 03:09:42.166551	2009-04-30 03:09:42.166551	\N	f
84	69	\N	A 8444074314 A		729449236	2009-04-30 03:11:35.534782	2009-04-30 03:11:35.534782	\N	f
85	70	\N	A 5747090290 A		729449236	2009-04-30 03:12:38.333912	2009-04-30 03:12:38.333912	\N	f
87	72	\N	A 4725053445 A		729449236	2009-04-30 03:15:22.714994	2009-04-30 03:15:22.714994	\N	f
88	73	\N	A 6440002065 A		729449236	2009-04-30 03:16:56.178237	2009-04-30 03:16:56.178237	\N	f
89	74	\N	A 6901028165 A		729449236	2009-04-30 03:18:59.660084	2009-04-30 03:18:59.660084	\N	f
90	75	\N	A 0541074816 B		729449236	2009-04-30 03:21:06.770189	2009-04-30 03:21:06.770189	\N	f
225	188	\N	8066380		729449236	2009-05-10 04:09:53.96685	2009-05-10 04:09:53.96685	f	f
226	189	\N	3388952		729449236	2009-05-10 04:10:43.818064	2009-05-10 04:10:43.818064	f	f
227	189	\N	0929706		729449236	2009-05-10 04:11:02.844663	2009-05-10 04:11:02.844663	f	f
228	190	\N	5645473		729449236	2009-05-10 04:11:41.876254	2009-05-10 04:11:41.876254	f	f
229	190	\N	6106019		729449236	2009-05-10 04:11:57.162229	2009-05-10 04:11:57.162229	f	f
230	191	\N	4960408		729449236	2009-05-10 04:12:48.393937	2009-05-10 04:12:48.393937	f	f
231	192	\N	42/IK 00930314		729449236	2009-05-10 04:20:56.104846	2009-05-10 04:20:56.104846	f	f
232	192	\N	46/CH 00165716		729449236	2009-05-10 04:21:11.114643	2009-05-10 04:21:11.114643	f	f
233	193	\N	05/KT 03559931		729449236	2009-05-10 04:22:09.507156	2009-05-10 04:22:09.507156	f	f
234	193	\N	45/CH 00641816		729449236	2009-05-10 04:22:25.376243	2009-05-10 04:22:25.376243	f	f
235	194	\N	21/TS 01147780		729449236	2009-05-10 04:23:09.659744	2009-05-10 04:23:09.659744	f	f
236	194	\N	32/OH 01357523		729449236	2009-05-10 04:23:26.596081	2009-05-10 04:23:26.596081	f	f
237	195	\N	?? 7493314		729449236	2009-05-10 04:31:37.15761	2009-05-10 04:31:37.15761	f	f
238	195	\N	?? 1994941	Significant water damage, staining, bleeding colors	82	2009-05-10 04:32:12.145346	2009-05-10 04:32:12.145346	f	f
239	196	\N	AX 4814985		729449236	2009-05-10 04:33:23.14764	2009-05-10 04:33:23.14764	f	f
240	197	\N	KO 9721737		729449236	2009-05-10 04:35:40.527174	2009-05-10 04:35:40.527174	f	f
241	198	\N	?A 0917104		729449236	2009-05-10 04:36:44.411173	2009-05-10 04:36:44.411173	f	f
242	199	\N	K? 5504265		729449236	2009-05-10 04:38:01.803917	2009-05-10 04:38:01.803917	f	f
243	200	\N	?B 6132206		729449236	2009-05-10 04:39:00.937439	2009-05-10 04:39:00.937439	f	f
244	201	\N	?? 7469258		729449236	2009-05-10 04:39:56.603214	2009-05-10 04:39:56.603214	f	f
245	202	\N	B? 9790685		729449236	2009-05-10 04:41:43.05659	2009-05-10 04:41:43.05659	f	f
246	203	\N	B? 9360266		729449236	2009-05-10 04:44:19.43167	2009-05-10 04:44:19.43167	f	f
247	204	\N	OY 4433731		729449236	2009-05-10 04:54:15.697444	2009-05-10 04:54:15.697444	f	f
248	205	\N	BK 192794		729449236	2009-05-10 04:55:22.770853	2009-05-10 04:55:22.770853	f	f
249	206	\N	B3 090206		729449236	2009-05-10 04:56:38.623109	2009-05-10 04:56:38.623109	f	f
250	207	\N	?? 637219		729449236	2009-05-10 04:58:09.669652	2009-05-10 04:58:09.669652	f	f
251	208	\N	?? 0131589		729449236	2009-05-10 04:59:46.234402	2009-05-10 04:59:46.234402	f	f
252	209	\N	?? 570861	Thin, wavy paper	4397270	2009-05-10 05:01:13.301978	2009-05-10 05:01:13.301978	f	f
253	210	\N	A? 6413545		729449236	2009-05-10 05:02:23.863608	2009-05-10 05:02:46.942368	f	f
254	211	\N	AX 115765	Thin, wavy paper	4397270	2009-05-10 05:04:07.182295	2009-05-10 05:04:07.182295	f	f
255	212	\N	AA 390015	Thin, wavy paper	4397270	2009-05-10 05:05:02.121518	2009-05-10 05:05:02.121518	f	f
256	213	\N	A3 6869845		729449236	2009-05-10 05:05:46.122325	2009-05-10 05:05:46.122325	f	f
257	214	\N	?? 978441	Thin, wavy paper	4397270	2009-05-10 05:06:37.239152	2009-05-10 05:06:37.239152	f	f
258	215	\N	A? 182201	Thin wavy paper; left obverse has fold on edge	5953181	2009-05-10 05:07:41.872404	2009-05-10 05:07:41.872404	f	f
259	216	\N	AD1672831		729449236	2009-05-10 05:15:29.263928	2009-05-10 05:15:29.263928	f	f
260	217	\N			729449236	2009-05-10 05:20:34.976491	2009-05-10 05:20:34.976491	f	f
261	217	\N			729449236	2009-05-10 05:20:41.35098	2009-05-10 05:20:41.35098	f	f
262	218	\N			729449236	2009-05-10 05:21:05.568166	2009-05-10 05:21:05.568166	f	f
263	218	\N			729449236	2009-05-10 05:21:08.678351	2009-05-10 05:21:08.678351	f	f
264	219	\N			729449236	2009-05-10 05:21:29.584111	2009-05-10 05:21:29.584111	f	f
51	40	\N	A3 6826342		729449236	2009-04-29 20:16:15.111028	2009-05-10 05:22:56.608126	\N	f
265	219	\N			729449236	2009-05-10 05:21:33.259869	2009-05-10 05:22:56.616928	f	f
266	220	\N	P ?9585067		729449236	2009-05-10 05:25:03.448602	2009-05-10 05:25:03.448602	f	f
267	222	\N	C?7007086		729449236	2009-05-10 05:27:04.713769	2009-05-10 05:27:04.713769	f	f
268	223	\N	AA 3768911		729449236	2009-05-10 05:32:06.381322	2009-05-10 05:32:06.381322	f	f
269	223	\N	A? 0184594		729449236	2009-05-10 05:32:22.238857	2009-05-10 05:32:22.238857	f	f
270	224	\N	AB 0487709		729449236	2009-05-10 05:32:51.099555	2009-05-10 05:32:51.099555	f	f
271	224	\N	A? 1118516		729449236	2009-05-10 05:33:11.261366	2009-05-10 05:33:11.261366	f	f
272	225	\N	AA 1049412		729449236	2009-05-10 05:33:40.096883	2009-05-10 05:33:40.096883	f	f
273	225	\N	A? 3698362		729449236	2009-05-10 05:33:54.037376	2009-05-10 05:33:54.037376	f	f
274	226	\N	A? 1346141		729449236	2009-05-10 05:34:39.560023	2009-05-10 05:34:39.560023	f	f
275	227	\N	J 1292314 A		729449236	2009-05-10 05:39:49.883366	2009-05-10 05:39:49.883366	f	f
276	228	\N	K 0972896 A		729449236	2009-05-10 05:41:24.119095	2009-05-10 05:41:24.119095	f	f
277	228	\N	K 2430614 B		729449236	2009-05-10 05:41:40.897722	2009-05-10 05:41:40.897722	f	f
278	229	\N	C 7949035 B		729449236	2009-05-10 05:43:05.935266	2009-05-10 05:43:05.935266	f	f
279	229	\N	C 4858328 K		729449236	2009-05-10 05:43:26.925503	2009-05-10 05:43:26.925503	f	f
280	230	\N	D 7002846 B		729449236	2009-05-10 05:44:15.419682	2009-05-10 05:44:15.419682	f	f
281	231	\N	A 2126753 A		729449236	2009-05-10 05:45:07.839592	2009-05-10 05:45:07.839592	f	f
282	232	\N	B 1747005 C		729449236	2009-05-10 05:47:41.614821	2009-05-10 05:47:41.614821	f	f
283	19	\N	55.840.020 A		729449236	2009-05-10 06:24:07.647447	2009-05-10 06:24:07.647447	f	f
284	14	\N	17.376.644 D		729449236	2009-05-10 06:25:36.040207	2009-05-10 06:25:36.040207	f	f
285	233	\N	85.463.555 A		729449236	2009-05-10 06:30:21.9386	2009-05-10 06:30:21.9386	f	f
286	17	\N	31.427.743 A		729449236	2009-05-10 06:31:41.811893	2009-05-10 06:31:41.811893	f	f
287	11	\N	17908336		729449236	2009-05-10 06:32:35.051068	2009-05-10 06:32:35.051068	f	f
288	20	\N	13.497.249 B		729449236	2009-05-10 06:33:18.945636	2009-05-10 06:33:18.945636	f	f
289	234	\N	BA302045		729449236	2009-05-10 17:47:36.243281	2009-05-10 17:47:36.243281	f	f
290	235	\N			729449236	2009-05-10 17:52:03.441047	2009-05-10 17:52:03.441047	f	f
291	235	\N			729449236	2009-05-10 17:52:09.295362	2009-05-10 17:52:09.295362	f	f
292	236	\N	TJ 4292614		729449236	2009-05-10 17:54:09.066867	2009-05-10 17:54:09.066867	f	f
293	237	\N			729449236	2009-05-10 17:55:52.158843	2009-05-10 17:55:52.158843	f	f
294	237	\N			729449236	2009-05-10 17:55:55.602164	2009-05-10 17:55:55.602164	f	f
295	238	\N	AD 8289197		729449236	2009-05-10 17:56:54.385412	2009-05-10 17:56:54.385412	f	f
296	238	\N	CA 4679116		\N	2009-05-10 17:57:08.251998	2009-05-10 17:57:08.251998	f	f
297	239	\N	CS 4084493		729449236	2009-05-10 17:58:12.892924	2009-05-10 17:58:12.892924	f	f
298	239	\N	AL 2272958		729449236	2009-05-10 17:58:33.094298	2009-05-10 17:58:33.094298	f	f
299	240	\N	DA 3882662		729449236	2009-05-10 17:59:20.761324	2009-05-10 17:59:20.761324	f	f
300	240	\N	AZ 5491045		729449236	2009-05-10 18:01:03.790533	2009-05-10 18:01:03.790533	f	f
301	241	\N	AD0871802		729449236	2009-05-10 18:09:04.369702	2009-05-10 18:09:04.369702	f	f
302	242	\N	AB2291661		729449236	2009-05-10 18:10:41.543013	2009-05-10 18:10:41.543013	f	f
303	3	\N			729449236	2009-05-10 18:11:35.624514	2009-05-10 18:11:35.624514	f	f
304	243	\N	HZ 4954431		729449236	2009-05-10 18:17:12.83446	2009-05-10 18:17:12.83446	f	f
305	244	\N	AJ 90754239	Small fold on right obverse	5953181	2009-05-10 18:22:19.85527	2009-05-10 18:22:19.85527	f	f
306	244	\N	AD 90757614		729449236	2009-05-10 18:22:36.152635	2009-05-10 18:22:36.152635	f	f
307	245	\N	HG 494465		729449236	2009-05-10 18:24:17.207268	2009-05-10 18:24:17.207268	f	f
308	245	\N	LT458836		729449236	2009-05-10 18:24:36.981184	2009-05-10 18:24:36.981184	f	f
309	246	\N	VN042036		729449236	2009-05-10 18:26:07.717606	2009-05-10 18:26:07.717606	f	f
310	247	\N	AA088853		729449236	2009-05-10 18:29:13.774937	2009-05-10 18:29:13.774937	f	f
311	227	\N	J 1052646 A		729449236	2009-05-10 18:30:41.940251	2009-05-10 18:30:41.940251	f	f
312	248	\N	FP0939390		729449236	2009-05-10 18:35:03.126986	2009-05-10 18:35:03.126986	f	f
313	249	\N	PE1493613		729449236	2009-05-10 18:36:09.890356	2009-05-10 18:36:09.890356	f	f
314	250	\N	COM1848144		729449236	2009-05-10 18:38:10.527449	2009-05-10 18:38:10.527449	f	f
315	251	\N	AB 391722		729449236	2009-05-10 18:44:48.515922	2009-05-10 18:44:48.515922	f	f
316	252	\N	AB 481521		729449236	2009-05-10 18:45:58.924057	2009-05-10 18:45:58.924057	f	f
317	253	\N	BD 178173		729449236	2009-05-10 18:46:44.838652	2009-05-10 18:46:44.838652	f	f
318	254	\N	LH064387		729449236	2009-05-10 18:47:43.612313	2009-05-10 18:47:43.612313	f	f
319	254	\N	TD080475		729449236	2009-05-10 18:47:55.724781	2009-05-10 18:47:55.724781	f	f
320	255	\N	JC008447		729449236	2009-05-10 18:49:39.984908	2009-05-10 18:49:39.984908	f	f
321	256	\N	KC069768		729449236	2009-05-10 18:50:31.964847	2009-05-10 18:50:31.964847	f	f
322	257	\N	OF146061		729449236	2009-05-10 18:51:20.604923	2009-05-10 18:51:20.604923	f	f
323	258	\N	RH358754		729449236	2009-05-10 18:52:09.771014	2009-05-10 18:52:09.771014	f	f
324	259	\N	AM 477857		729449236	2009-05-10 18:53:13.11526	2009-05-10 18:53:13.11526	f	f
325	260	\N	CK 527066		729449236	2009-05-10 18:54:10.42464	2009-05-10 18:54:10.42464	f	f
326	261	\N	AC 4945274		729449236	2009-05-10 19:03:09.018954	2009-05-10 19:03:09.018954	f	f
327	262	\N	DL 6498338		729449236	2009-05-10 19:42:49.06622	2009-05-10 19:42:49.06622	f	f
328	263	\N	XN 5061562		729449236	2009-05-10 19:44:29.117205	2009-05-10 19:44:29.117205	f	f
329	263	\N	NT 7058436		729449236	2009-05-10 19:44:43.188923	2009-05-10 19:44:43.188923	f	f
330	264	\N	AA5829590		729449236	2009-05-10 19:53:48.457777	2009-05-10 19:53:48.457777	f	f
331	264	\N	AA1120342		729449236	2009-05-13 03:14:47.261232	2009-05-13 03:14:47.261232	f	f
332	265	\N	AA3916661		729449236	2009-05-13 03:17:17.663941	2009-05-13 03:17:17.663941	f	f
333	265	\N	AA8583124		729449236	2009-05-13 03:17:37.798078	2009-05-13 03:17:37.798078	f	f
334	266	\N	AA3287642		729449236	2009-05-13 03:19:28.771744	2009-05-13 03:19:28.771744	f	f
335	266	\N	AA0362339		729449236	2009-05-13 03:19:51.867343	2009-05-13 03:19:51.867343	f	f
336	267	\N	AA0163614		729449236	2009-05-13 03:21:35.222773	2009-05-13 03:21:35.222773	f	f
337	267	\N	AB6911786		729449236	2009-05-13 03:21:50.08031	2009-05-13 03:21:50.08031	f	f
338	268	\N	AB6687157		729449236	2009-05-13 03:24:13.490544	2009-05-13 03:24:13.490544	f	f
339	268	\N	AA0017690		729449236	2009-05-13 03:24:33.142089	2009-05-13 03:24:33.142089	f	f
340	269	\N	AD8954179		729449236	2009-05-13 03:25:11.419096	2009-05-13 03:25:11.419096	f	f
341	269	\N	AD4656216		729449236	2009-05-13 03:25:24.878406	2009-05-13 03:25:24.878406	f	f
342	270	\N	AD8304870		729449236	2009-05-13 03:28:15.068597	2009-05-13 03:28:15.068597	f	f
343	270	\N	AD8304869		729449236	2009-05-13 03:28:37.244788	2009-05-13 03:28:37.244788	f	f
344	271	\N	AB8644373		729449236	2009-05-13 04:00:54.068794	2009-05-13 04:00:54.068794	f	f
345	272	\N	?A 310596		729449236	2009-05-13 04:02:26.36416	2009-05-13 04:02:26.36416	f	f
346	273	\N	AC 132814		729449236	2009-05-13 04:05:39.463956	2009-05-13 04:05:39.463956	f	f
347	274	\N	?T 136326		729449236	2009-05-13 04:06:31.565469	2009-05-13 04:06:31.565469	f	f
348	275	\N	AC 297165		729449236	2009-05-13 04:07:19.424554	2009-05-13 04:07:19.424554	f	f
349	276	\N	AA 139996		729449236	2009-05-13 04:08:14.05473	2009-05-13 04:08:14.05473	f	f
350	277	\N	569653 A?		729449236	2009-05-13 04:09:36.666909	2009-05-13 04:09:36.666909	f	f
351	277	\N	257390 AO		729449236	2009-05-13 04:25:55.718297	2009-05-13 04:25:55.718297	f	f
352	278	\N			729449236	2009-05-13 04:31:59.356279	2009-05-13 04:31:59.356279	f	f
353	278	\N			729449236	2009-05-13 04:32:03.399321	2009-05-13 04:32:03.399321	f	f
354	279	\N	A/6 723687		729449236	2009-05-13 04:33:07.852664	2009-05-13 04:33:07.852664	f	f
355	279	\N	A/3 015324		729449236	2009-05-13 04:33:23.334527	2009-05-13 04:33:23.334527	f	f
356	280	\N	B/2 059314		729449236	2009-05-13 04:35:49.1984	2009-05-13 04:35:49.1984	f	f
357	280	\N	B/1 189812		729449236	2009-05-13 04:36:03.160918	2009-05-13 04:36:03.160918	f	f
34	28	\N			729449236	2009-04-29 20:01:10.900309	2009-05-16 19:20:48.756311	f	f
358	281	\N	AA/9 823414		729449236	2009-05-16 19:39:59.404336	2009-05-16 19:39:59.404336	f	f
359	283	\N	K/3 497838		729449236	2009-05-16 19:42:10.825929	2009-05-16 19:42:10.825929	f	f
360	283	\N	K/2 125811		729449236	2009-05-16 19:42:23.988789	2009-05-16 19:42:23.988789	f	f
361	285	\N	DK70 296943		5817884	2009-05-16 19:48:59.283757	2009-05-16 19:48:59.283757	f	f
362	286	\N			729449236	2009-05-17 20:46:21.818125	2009-05-17 20:46:21.818125	f	f
363	287	\N	BB 247970		729449236	2009-05-17 20:50:18.5304	2009-05-17 20:50:18.5304	f	f
364	288	\N	AN 065642		729449236	2009-05-17 20:52:04.511849	2009-05-17 20:52:04.511849	f	f
365	288	\N	AN 025237		729449236	2009-05-17 20:52:19.402923	2009-05-17 20:52:19.402923	f	f
366	289	\N	AJ8779933		729449236	2009-05-17 20:54:08.169867	2009-05-17 20:54:08.169867	f	f
367	290	\N	ZD 4307939		729449236	2009-05-17 20:56:06.654976	2009-05-17 20:56:06.654976	f	f
368	291	\N	79/B 149145		729449236	2009-05-17 20:58:40.853225	2009-05-17 20:58:40.853225	f	f
369	291	\N	87/B 712036		729449236	2009-05-17 20:58:53.090737	2009-05-17 20:58:53.090737	f	f
370	292	\N	AJW 035788		729449236	2009-05-17 21:01:35.340295	2009-05-17 21:01:35.340295	f	f
371	292	\N	AFM096382		729449236	2009-05-17 21:01:50.998436	2009-05-17 21:01:50.998436	f	f
372	293	\N	ARR063212		729449236	2009-05-17 21:02:41.302423	2009-05-17 21:02:41.302423	f	f
373	293	\N	ALT070926		729449236	2009-05-17 21:02:52.84188	2009-05-17 21:02:52.84188	f	f
374	294	\N	BNF039213		729449236	2009-05-17 21:03:45.413042	2009-05-17 21:03:45.413042	f	f
375	294	\N	DEJ014856		729449236	2009-05-17 21:04:01.729253	2009-05-17 21:04:01.729253	f	f
376	295	\N	BFG094356		729449236	2009-05-17 21:04:39.812942	2009-05-17 21:04:39.812942	f	f
377	295	\N	XEH017795		729449236	2009-05-17 21:04:51.972131	2009-05-17 21:04:51.972131	f	f
378	296	\N	HFQ054217		729449236	2009-05-17 21:05:24.950297	2009-05-17 21:05:24.950297	f	f
379	296	\N	GRF069409		729449236	2009-05-17 21:05:36.581793	2009-05-17 21:05:36.581793	f	f
380	297	\N	HMU029636		729449236	2009-05-17 21:07:17.965038	2009-05-17 21:07:17.965038	f	f
381	298	\N	DOH150680		729449236	2009-05-17 21:08:19.044957	2009-05-17 21:08:19.044957	f	f
382	298	\N	OZP137911		729449236	2009-05-17 21:08:42.448182	2009-05-17 21:08:42.448182	f	f
383	299	\N	DGH052211		729449236	2009-05-17 21:10:28.608819	2009-05-17 21:10:28.608819	f	f
384	300	\N	BST014641		729449236	2009-05-17 21:11:29.596018	2009-05-17 21:11:29.596018	f	f
385	301	\N	H2856916		729449236	2009-05-17 21:15:54.647119	2009-05-17 21:15:54.647119	f	f
386	301	\N	F0972314		729449236	2009-05-17 21:18:04.643282	2009-05-17 21:18:04.643282	f	f
387	302	\N	C4926211		729449236	2009-05-17 21:19:09.92454	2009-05-17 21:19:09.92454	f	f
388	303	\N	C0428844		729449236	2009-05-17 21:19:34.749577	2009-05-17 21:19:34.749577	f	f
389	303	\N	C8634686		729449236	2009-05-17 21:19:45.928331	2009-05-17 21:19:45.928331	f	f
390	304	\N	B4743645		729449236	2009-05-17 21:20:53.084298	2009-05-17 21:20:53.084298	f	f
391	305	\N	D0089838		729449236	2009-05-17 21:21:46.219611	2009-05-17 21:21:46.219611	f	f
392	306	\N	B8226546		729449236	2009-05-17 21:22:17.136656	2009-05-17 21:22:17.136656	f	f
393	307	\N	C3905528		729449236	2009-05-17 21:22:47.454772	2009-05-17 21:22:47.454772	f	f
394	307	\N	C3612422		729449236	2009-05-17 21:22:59.555238	2009-05-17 21:22:59.555238	f	f
395	308	\N	B8230560		729449236	2009-05-17 21:23:39.806635	2009-05-17 21:23:39.806635	f	f
396	308	\N	A6696632		729449236	2009-05-17 21:23:49.74909	2009-05-17 21:23:49.74909	f	f
397	297	\N	ESV004160		729449236	2009-05-17 21:25:15.051071	2009-05-17 21:25:15.051071	f	f
398	306	\N	B8357674		729449236	2009-05-17 21:28:53.263396	2009-05-17 21:28:53.263396	f	f
399	309	\N	AB7591195		729449236	2009-05-17 21:30:43.594558	2009-05-17 21:30:43.594558	f	f
400	309	\N	AD3813665		729449236	2009-05-17 21:30:56.637241	2009-05-17 21:30:56.637241	f	f
401	310	\N	AA2826320		729449236	2009-05-17 21:31:57.261426	2009-05-17 21:31:57.261426	f	f
402	311	\N			729449236	2009-05-17 21:36:51.475171	2009-05-17 21:36:51.475171	f	f
403	312	\N			729449236	2009-05-17 21:38:39.689933	2009-05-17 21:38:39.689933	f	f
404	313	\N			729449236	2009-05-17 21:47:01.697899	2009-05-17 21:47:01.697899	f	f
405	313	\N			729449236	2009-05-17 21:47:04.008141	2009-05-17 21:47:04.008141	f	f
406	314	\N	A55 090724		729449236	2009-05-17 21:53:51.22203	2009-05-17 21:53:51.22203	f	f
407	315	\N	I73 154643		729449236	2009-05-17 21:54:53.016697	2009-05-17 21:54:53.016697	f	f
408	316	\N	H27 868113		729449236	2009-05-17 21:55:58.659774	2009-05-17 21:55:58.659774	f	f
409	317	\N	GL324836		729449236	2009-05-17 21:59:16.224852	2009-05-17 21:59:16.224852	f	f
410	318	\N	HX 497757		729449236	2009-05-17 22:00:29.009321	2009-05-17 22:00:29.009321	f	f
411	319	\N	D56946137		729449236	2009-05-17 22:04:03.251167	2009-05-17 22:04:03.251167	f	f
412	320	\N	D63607511		729449236	2009-05-17 22:05:30.236074	2009-05-17 22:05:30.236074	f	f
413	44	\N	S3573035		729449236	2009-05-17 22:06:16.652607	2009-05-17 22:06:16.652607	f	f
414	321	\N	0030491001		729449236	2009-05-17 22:11:27.712179	2009-05-17 22:11:27.712179	f	f
415	322	\N	CN027827		729449236	2009-05-17 22:12:22.860595	2009-05-17 22:12:22.860595	f	f
416	323	\N	LM052661		729449236	2009-05-17 22:13:17.912027	2009-05-17 22:13:17.912027	f	f
417	324	\N	020852206		729449236	2009-05-17 22:14:11.590838	2009-05-17 22:14:11.590838	f	f
418	325	\N	0440393337		729449236	2009-05-17 22:15:16.599038	2009-05-17 22:15:16.599038	f	f
419	326	\N	062148906		729449236	2009-05-17 22:15:52.145448	2009-05-17 22:15:52.145448	f	f
420	325	\N	0438292647		729449236	2009-05-17 22:16:42.666151	2009-05-17 22:16:42.666151	f	f
421	322	\N	CN032936		729449236	2009-05-17 22:17:03.261204	2009-05-17 22:17:03.261204	f	f
422	323	\N	LN01632		729449236	2009-05-17 22:17:20.947474	2009-05-17 22:17:20.947474	f	f
423	327	\N	??8704855		729449236	2009-05-17 22:49:59.5226	2009-05-17 22:49:59.5226	f	f
424	327	\N	?? 8386514		729449236	2009-05-17 22:50:10.935789	2009-05-17 22:50:10.935789	f	f
425	328	\N	?? 575491	Slight fold on obverse left	5953181	2009-05-17 22:54:49.206149	2009-05-17 22:54:49.206149	f	f
426	329	\N	?? 1851630		729449236	2009-05-17 22:56:02.552399	2009-05-17 22:56:02.552399	f	f
427	330	\N	885553		729449236	2009-05-17 22:57:54.445291	2009-05-17 22:57:54.445291	f	f
429	332	\N	?? 2036077		729449236	2009-05-17 23:01:15.093439	2009-05-17 23:01:15.093439	f	f
430	333	\N	?? 152754	Light fold on right obverse	4397270	2009-05-17 23:03:55.85898	2009-05-17 23:03:55.85898	f	f
431	334	\N	282393	Very faint staining and folding at corners	5953181	2009-05-17 23:07:56.861445	2009-05-17 23:07:56.861445	f	f
432	335	\N	?? 095009		729449236	2009-05-17 23:11:19.071178	2009-05-17 23:11:19.071178	f	f
433	336	\N	?? 675382		729449236	2009-05-17 23:15:24.406481	2009-05-17 23:15:24.406481	f	f
434	336	\N	?? 806339		729449236	2009-05-17 23:15:40.087517	2009-05-17 23:15:40.087517	f	f
435	337	\N	??9474752		729449236	2009-05-17 23:18:14.705288	2009-05-17 23:18:14.705288	f	f
436	338	\N	??8346816		729449236	2009-05-17 23:19:26.61773	2009-05-17 23:19:26.61773	f	f
437	339	\N	?? 030952	Light folding on corners	5953181	2009-05-17 23:21:44.973019	2009-05-17 23:21:44.973019	f	f
438	339	\N	?? 244176	Light folding on corners	5953181	2009-05-17 23:22:09.321431	2009-05-17 23:22:09.321431	f	f
439	331	\N	107100	light folding at corners	5953181	2009-05-17 23:23:05.037771	2009-05-17 23:23:05.037771	f	f
440	340	\N	??8456616		729449236	2009-05-17 23:24:51.399402	2009-05-17 23:24:51.399402	f	f
441	341	\N	??1827946		729449236	2009-05-17 23:26:23.931429	2009-05-17 23:26:23.931429	f	f
442	329	\N	?? 1022365		729449236	2009-05-17 23:27:32.836144	2009-05-17 23:27:32.836144	f	f
443	342	\N	?? 2432527		729449236	2009-05-17 23:29:41.024969	2009-05-17 23:29:41.024969	f	f
444	342	\N	?? 8420290		729449236	2009-05-17 23:29:52.04444	2009-05-17 23:29:52.04444	f	f
445	330	\N	785708		729449236	2009-05-17 23:30:44.671	2009-05-17 23:30:44.671	f	f
446	343	\N	?? 8515211		729449236	2009-05-17 23:33:32.860834	2009-05-17 23:33:32.860834	f	f
447	343	\N	?? 9900252		729449236	2009-05-17 23:33:43.433657	2009-05-17 23:33:43.433657	f	f
448	344	\N	?? 0603290		729449236	2009-05-17 23:35:18.711585	2009-05-17 23:35:18.711585	f	f
449	344	\N	?? 1885136		729449236	2009-05-17 23:35:32.422807	2009-05-17 23:35:32.422807	f	f
450	345	\N	?? 8550790		729449236	2009-05-17 23:36:42.83892	2009-05-17 23:36:42.83892	f	f
451	345	\N	?? 8716628		729449236	2009-05-17 23:36:52.868006	2009-05-17 23:36:52.868006	f	f
452	346	\N	?? 4372211		729449236	2009-05-17 23:37:48.747916	2009-05-17 23:37:48.747916	f	f
453	346	\N	?? 8114956		729449236	2009-05-17 23:38:00.359119	2009-05-17 23:38:00.359119	f	f
428	331	\N	726494	Light folding and staining at corners	5953181	2009-05-17 22:59:23.590739	2009-05-17 23:40:31.772642	f	f
454	347	\N	?? 3624255		729449236	2009-05-17 23:42:22.478274	2009-05-17 23:42:22.478274	f	f
455	50	\N	DJ 44824853		729449236	2009-05-18 00:17:03.028679	2009-05-18 00:17:03.028679	f	f
456	49	\N	AB 21203724		729449236	2009-05-18 00:17:27.348103	2009-05-18 00:17:27.348103	f	f
457	48	\N	LA 21263883		729449236	2009-05-18 00:17:51.680054	2009-05-18 00:17:51.680054	f	f
458	4	\N			729449236	2009-05-18 00:19:11.737063	2009-05-18 00:19:11.737063	f	f
459	348	\N			729449236	2009-05-18 00:21:12.277295	2009-05-18 00:21:12.277295	f	f
460	59	\N	B16870 019809		729449236	2009-05-21 03:50:38.110838	2009-05-21 03:50:38.110838	f	f
461	54	\N	2A 4316A 079955		729449236	2009-05-21 03:51:42.041082	2009-05-21 03:51:42.041082	f	f
462	62	\N	A 5174096232 A		729449236	2009-05-21 03:52:20.255298	2009-05-21 03:52:20.255298	f	f
463	76	\N	A 1510013833 A		729449236	2009-05-21 03:52:58.982878	2009-05-21 03:52:58.982878	f	f
464	63	\N	A 3090030083 A		729449236	2009-05-21 03:53:56.598134	2009-05-21 03:53:56.598134	f	f
465	64	\N	A 1035064752 A		729449236	2009-05-21 03:54:39.808902	2009-05-21 03:54:39.808902	f	f
466	83	\N	A 6892075487 A		729449236	2009-05-21 03:55:35.437724	2009-05-21 03:55:35.437724	f	f
467	77	\N	A 1119083428 A		729449236	2009-05-21 03:56:11.836091	2009-05-21 03:56:11.836091	f	f
468	84	\N	A 3938017962 A		729449236	2009-05-21 03:56:49.688492	2009-05-21 03:56:49.688492	f	f
469	66	\N	A 0628050091 A		729449236	2009-05-21 03:57:34.583254	2009-05-21 03:57:34.583254	f	f
470	78	\N	A 7817037536 A		729449236	2009-05-21 03:58:06.659642	2009-05-21 03:58:06.659642	f	f
471	68	\N	A 6240092110 A		729449236	2009-05-21 03:58:40.322831	2009-05-21 03:58:40.322831	f	f
472	69	\N	A 5700086795 A		729449236	2009-05-21 03:59:13.455719	2009-05-21 03:59:13.455719	f	f
473	79	\N	B 1047022103 A		729449236	2009-05-21 03:59:46.046633	2009-05-21 03:59:46.046633	f	f
474	80	\N	A 9822015959 A		729449236	2009-05-21 04:00:11.431767	2009-05-21 04:00:11.431767	f	f
475	70	\N	A 5742072787 A		729449236	2009-05-21 04:00:50.724665	2009-05-21 04:00:50.724665	f	f
476	349	\N		Wavy paper	5953181	2009-05-21 04:07:06.060901	2009-05-21 04:07:06.060901	f	f
477	350	\N	AE 90137734		729449236	2009-05-21 04:11:46.387786	2009-05-21 04:12:16.576985	f	f
478	352	\N	B15450587		729449236	2009-05-21 04:23:06.550075	2009-05-21 04:23:06.550075	f	f
479	353	\N	AK3936314		729449236	2009-05-21 04:24:05.989403	2009-05-21 04:24:05.989403	f	f
480	354	\N	A49313311		729449236	2009-05-21 04:27:01.568116	2009-05-21 04:27:01.568116	f	f
481	354	\N	L21833211		729449236	2009-05-21 04:27:13.266596	2009-05-21 04:27:13.266596	f	f
482	355	\N	N25900236		729449236	2009-05-21 04:29:17.84735	2009-05-21 04:29:17.84735	f	f
483	356	\N	J28536936		729449236	2009-05-21 04:30:25.370991	2009-05-21 04:30:25.370991	f	f
484	357	\N	LR 02245436		729449236	2009-05-21 04:35:04.821941	2009-05-21 04:35:04.821941	f	f
485	357	\N	LP 08260740		729449236	2009-05-21 04:36:04.140967	2009-05-21 04:36:04.140967	f	f
486	358	\N	1E 02994614		729449236	2009-05-21 04:37:37.618169	2009-05-21 04:37:37.618169	f	f
487	358	\N	1D 04361177		729449236	2009-05-21 04:37:54.944283	2009-05-21 04:37:54.944283	f	f
488	359	\N	LR 05110725		729449236	2009-05-21 04:42:32.6694	2009-05-21 04:42:32.6694	f	f
489	359	\N	LR 07173536		729449236	2009-05-21 04:42:46.203127	2009-05-21 04:42:46.203127	f	f
490	361	\N	C/350 750835		729449236	2009-05-23 19:16:14.033098	2009-05-23 19:16:14.033098	f	f
491	361	\N	C/350 971735		729449236	2009-05-23 19:16:30.241109	2009-05-23 19:16:30.241109	f	f
492	362	\N	A/268 886073		729449236	2009-05-23 19:18:00.686605	2009-05-23 19:18:00.686605	f	f
493	362	\N	A/241 670313		729449236	2009-05-23 19:18:15.305146	2009-05-23 19:18:15.305146	f	f
494	363	\N	3M 6723252		729449236	2009-05-23 19:21:13.689079	2009-05-23 19:21:13.689079	f	f
495	364	\N	8937348		729449236	2009-05-23 19:25:59.922084	2009-05-23 19:25:59.922084	f	f
496	364	\N	8187387		729449236	2009-05-23 19:26:20.388293	2009-05-23 19:26:20.388293	f	f
497	365	\N	4062137		729449236	2009-05-23 19:27:02.446673	2009-05-23 19:27:02.446673	f	f
498	366	\N	5913900		729449236	2009-05-23 19:27:28.002811	2009-05-23 19:27:28.002811	f	f
499	367	\N	1881613		729449236	2009-05-23 19:27:53.389681	2009-05-23 19:27:53.389681	f	f
500	368	\N	053A2543828	Several creases that break the printing	5817884	2009-05-23 19:32:22.575405	2009-05-23 19:32:22.575405	f	f
501	369	\N	A.0046 545776		729449236	2009-05-23 19:34:40.087123	2009-05-23 19:34:40.087123	f	f
502	370	\N	CD6329754		729449236	2009-05-23 19:38:06.776393	2009-05-23 19:38:06.776393	f	f
503	257	\N	MH142473		729449236	2009-05-23 19:42:29.220481	2009-05-23 19:42:29.220481	f	f
504	234	\N	BB649674		729449236	2009-05-23 19:44:23.54366	2009-05-23 19:44:23.54366	f	f
505	371	\N	ANG5264519	Well worn, with small tears, smudging, heavy crease down the center	73	2009-05-23 19:52:41.665475	2009-05-23 19:52:41.665475	f	f
506	372	\N	IV VII 73624736		729449236	2009-05-23 19:57:48.728489	2009-05-23 19:57:48.728489	f	f
507	372	\N	V IX III 0364742		729449236	2009-05-23 19:58:04.156288	2009-05-23 19:58:04.156288	f	f
508	373	\N	II III 95726965		729449236	2009-05-23 19:59:16.24492	2009-05-23 19:59:16.24492	f	f
509	374	\N	0778694		729449236	2009-05-23 20:02:18.208953	2009-05-23 20:02:18.208953	f	f
510	375	\N	YM 614436		729449236	2009-05-23 20:04:21.304535	2009-05-23 20:04:21.304535	f	f
511	376	\N			729449236	2009-05-23 20:07:37.101914	2009-05-23 20:07:37.101914	f	f
512	377	\N			729449236	2009-05-23 20:08:47.544906	2009-05-23 20:08:47.544906	f	f
513	377	\N			729449236	2009-05-23 20:08:50.135155	2009-05-23 20:08:50.135155	f	f
514	378	\N			729449236	2009-05-23 20:17:16.443934	2009-05-23 20:17:16.443934	f	f
515	378	\N			729449236	2009-05-23 20:17:18.54977	2009-05-23 20:17:18.54977	f	f
516	379	\N			729449236	2009-05-23 20:19:46.157379	2009-05-23 20:19:46.157379	f	f
517	379	\N			729449236	2009-05-23 20:19:49.476027	2009-05-23 20:19:49.476027	f	f
518	380	\N	PJ 40421920		729449236	2009-05-23 20:21:34.901213	2009-05-23 20:21:34.901213	f	f
519	380	\N	CG 73078816		729449236	2009-05-23 20:21:48.017938	2009-05-23 20:21:48.017938	f	f
520	381	\N	IY 25646211		729449236	2009-05-23 20:22:37.113313	2009-05-23 20:22:37.113313	f	f
521	381	\N	XL 57422131		729449236	2009-05-23 20:22:48.261274	2009-05-23 20:22:48.261274	f	f
522	382	\N	IY 00309236		729449236	2009-05-23 20:24:06.116599	2009-05-23 20:24:06.116599	f	f
523	382	\N	TN 74422718		729449236	2009-05-23 20:24:24.795609	2009-05-23 20:24:24.795609	f	f
524	383	\N			729449236	2009-05-23 20:27:02.312139	2009-05-23 20:27:02.312139	f	f
525	383	\N			729449236	2009-05-23 20:27:06.606729	2009-05-23 20:27:06.606729	f	f
526	384	\N			729449236	2009-05-23 20:29:16.90948	2009-05-23 20:29:16.90948	f	f
527	384	\N			729449236	2009-05-23 20:29:21.191733	2009-05-23 20:29:21.191733	f	f
528	385	\N			729449236	2009-05-23 20:31:13.301892	2009-05-23 20:31:13.301892	f	f
529	385	\N			729449236	2009-05-23 20:31:16.244534	2009-05-23 20:31:16.244534	f	f
530	386	\N			729449236	2009-05-23 20:32:22.097775	2009-05-23 20:32:22.097775	f	f
531	386	\N			729449236	2009-05-23 20:32:24.412535	2009-05-23 20:32:24.412535	f	f
532	387	\N	III VI III		729449236	2009-05-23 20:33:42.49194	2009-05-23 20:33:42.49194	f	f
533	387	\N	VII IX		729449236	2009-05-23 20:33:51.288688	2009-05-23 20:33:51.288688	f	f
534	388	\N	IV II IV		729449236	2009-05-23 20:34:38.413261	2009-05-23 20:34:38.413261	f	f
535	388	\N	VI VI II		729449236	2009-05-23 20:34:47.383634	2009-05-23 20:34:47.383634	f	f
536	389	\N	III III V		729449236	2009-05-23 20:35:36.971889	2009-05-23 20:35:36.971889	f	f
537	389	\N	V III III		729449236	2009-05-23 20:35:46.458455	2009-05-23 20:35:46.458455	f	f
538	390	\N	B 3978353 C		729449236	2009-05-23 20:39:05.783409	2009-05-23 20:39:05.783409	f	f
539	391	\N	C 8845971 J		729449236	2009-05-23 20:40:08.954665	2009-05-23 20:40:08.954665	f	f
540	392	\N			729449236	2009-05-23 20:45:01.887202	2009-05-23 20:45:01.887202	f	f
541	393	\N			729449236	2009-05-23 20:46:19.300903	2009-05-23 20:46:19.300903	f	f
542	394	\N			729449236	2009-05-23 20:48:47.437494	2009-05-23 20:48:47.437494	f	f
543	395	\N	769811		729449236	2009-05-23 20:51:59.59416	2009-05-23 20:51:59.59416	f	f
544	396	\N			729449236	2009-05-23 20:53:28.536338	2009-05-23 20:53:28.536338	f	f
545	397	\N	AB 4045255		729449236	2009-06-08 01:50:42.457212	2009-06-08 01:50:42.457212	f	f
546	398	\N	214/2 054468		729449236	2009-06-08 01:54:25.418882	2009-06-08 01:54:25.418882	f	f
547	398	\N	249/2 054260		729449236	2009-06-08 01:54:39.088415	2009-06-08 01:54:39.088415	f	f
548	399	\N	210/2 051527		729449236	2009-06-08 01:55:37.542112	2009-06-08 01:55:37.542112	f	f
549	400	\N	213/2 225612		729449236	2009-06-08 01:56:41.388583	2009-06-08 01:56:41.388583	f	f
550	401	\N	211/2 223464		729449236	2009-06-08 01:57:33.928941	2009-06-08 01:57:33.928941	f	f
551	402	\N	207/2 162483		729449236	2009-06-08 01:58:30.083995	2009-06-08 01:58:30.083995	f	f
552	403	\N	B/41 846650		729449236	2009-06-08 02:01:29.453559	2009-06-08 02:01:29.453559	f	f
553	403	\N	B/45 410925		729449236	2009-06-08 02:01:39.086531	2009-06-08 02:01:39.086531	f	f
554	404	\N	A/39 597825		729449236	2009-06-08 02:02:54.51841	2009-06-08 02:02:54.51841	f	f
555	405	\N	A/35 199247		729449236	2009-06-08 02:03:41.339921	2009-06-08 02:03:41.339921	f	f
556	406	\N	A/25 892795		729449236	2009-06-08 02:04:42.450601	2009-06-08 02:04:42.450601	f	f
557	407	\N	AP 653886		729449236	2009-06-08 02:10:36.539552	2009-06-08 02:10:36.539552	f	f
558	408	\N	AU869936		729449236	2009-06-08 02:11:33.269302	2009-06-08 02:11:33.269302	f	f
559	409	\N	Y482536		729449236	2009-06-08 02:12:40.6727	2009-06-08 02:12:40.6727	f	f
560	410	\N	C 849 158202		729449236	2009-06-08 02:16:05.067666	2009-06-08 02:16:05.067666	f	f
561	411	\N	M 498 057247	Small nicks and creases, rounded corners, light staining from wear	72	2009-06-08 02:18:35.137422	2009-06-08 02:18:35.137422	f	f
562	412	\N	E 458 074143		729449236	2009-06-08 02:20:04.087418	2009-06-08 02:20:04.087418	f	f
563	413	\N			729449236	2009-06-08 02:22:43.036372	2009-06-08 02:22:43.036372	f	f
564	414	\N			729449236	2009-06-08 02:24:01.439001	2009-06-08 02:24:01.439001	f	f
565	415	\N	EV799763	Nicks and creases extending into  design	72	2009-06-08 02:25:42.773149	2009-06-08 02:25:42.773149	f	f
566	416	\N	A 11625856		729449236	2009-06-08 02:29:42.264894	2009-06-08 02:29:42.264894	f	f
567	417	\N	J6F 592203	Staple holes on left obverse	5817883	2009-06-08 02:32:36.803986	2009-06-08 02:32:36.803986	f	f
568	418	\N	AB 228672		729449236	2009-06-08 02:35:39.686061	2009-06-08 02:35:39.686061	f	f
569	418	\N	AB 297387		729449236	2009-06-08 02:35:52.519686	2009-06-08 02:35:52.519686	f	f
570	419	\N	KK 939687		729449236	2009-06-08 02:36:39.212569	2009-06-08 02:36:39.212569	f	f
571	419	\N	AK 288109		729449236	2009-06-08 02:36:47.296751	2009-06-08 02:36:47.296751	f	f
572	420	\N	BK 603450		729449236	2009-06-08 02:37:26.970418	2009-06-08 02:37:26.970418	f	f
573	421	\N	C4786730	Multiple folds	5817883	2009-06-08 02:40:41.073569	2009-06-08 02:40:41.073569	f	f
574	422	\N	A4268643		729449236	2009-06-08 02:45:12.275528	2009-06-08 02:45:12.275528	f	f
575	423	\N	AK 0030865		729449236	2009-06-08 02:47:45.298529	2009-06-08 02:47:45.298529	f	f
576	424	\N	C52236030		729449236	2009-06-08 03:02:31.500729	2009-06-08 03:02:31.500729	f	f
577	424	\N	C59233536		729449236	2009-06-08 03:02:43.041256	2009-06-08 03:02:43.041256	f	f
578	425	\N	AJ 10036		729449236	2009-06-08 03:05:12.900642	2009-06-08 03:05:12.900642	f	f
579	426	\N	7672045		729449236	2009-06-08 03:07:04.466232	2009-06-08 03:07:04.466232	f	f
580	427	\N	C093520		729449236	2009-06-08 03:08:33.591862	2009-06-08 03:08:33.591862	f	f
581	428	\N			729449236	2009-06-08 03:11:19.256283	2009-06-08 03:11:19.256283	f	f
582	429	\N			729449236	2009-06-08 03:12:20.358575	2009-06-08 03:12:20.358575	f	f
583	429	\N			729449236	2009-06-08 03:12:29.2107	2009-06-08 03:12:29.2107	f	f
584	430	\N			729449236	2009-06-08 03:13:42.989418	2009-06-08 03:13:42.989418	f	f
585	431	\N	BE 99656551	Crease in middle, multiple folds	72	2009-06-08 03:16:24.863073	2009-06-08 03:16:24.863073	f	f
586	432	\N	AB 99714606	Well worn, creases ... no pieces missing, but print is faded.	5817884	2009-06-08 03:18:04.04651	2009-06-08 03:18:04.04651	f	f
587	433	\N	A/C 5417337		729449236	2009-06-08 03:22:37.275272	2009-06-08 03:22:37.275272	f	f
588	433	\N	A/A 3739687		729449236	2009-06-08 03:22:48.365598	2009-06-08 03:22:48.365598	f	f
589	434	\N	A/B 3168315		729449236	2009-06-08 03:23:53.960787	2009-06-08 03:23:53.960787	f	f
590	434	\N	A/A 4348190		729449236	2009-06-08 03:24:07.199084	2009-06-08 03:24:07.199084	f	f
591	435	\N	A/C 7842864		729449236	2009-06-08 03:24:39.714554	2009-06-08 03:24:39.714554	f	f
592	435	\N	A/A 8590614		729449236	2009-06-08 03:24:52.239356	2009-06-08 03:24:52.239356	f	f
593	436	\N	A/A 8286687		729449236	2009-06-08 03:25:20.916245	2009-06-08 03:25:20.916245	f	f
594	436	\N	A/A 3271104		729449236	2009-06-08 03:25:30.659422	2009-06-08 03:25:30.659422	f	f
595	438	\N	994233		729449236	2010-01-10 02:29:08.87044	2010-01-10 02:29:08.87044	f	f
596	439	\N	D62634869		729449236	2010-01-10 02:32:16.460791	2010-01-10 02:32:16.460791	f	f
597	440	\N	MA0475698K		729449236	2010-01-10 18:52:06.534261	2010-01-10 18:52:06.534261	f	f
598	442	\N	L08786088		729449236	2010-01-10 19:03:21.86312	2010-01-10 19:03:21.86312	f	f
599	443	\N	ED8688742		729449236	2010-01-10 19:06:44.598159	2010-01-10 19:06:44.598159	f	f
600	444	\N			729449236	2010-01-10 19:09:08.380307	2010-01-10 19:09:08.380307	f	f
601	445	\N	AA1750087		729449236	2010-01-10 19:13:37.430194	2010-01-10 19:13:37.430194	f	f
602	446	\N	AA4578562		729449236	2010-01-10 19:14:48.150301	2010-01-10 19:14:48.150301	f	f
603	447	\N	AA2948536		729449236	2010-01-10 19:16:04.819392	2010-01-10 19:16:04.819392	f	f
604	448	\N	AA0046953		729449236	2010-01-10 19:17:12.806048	2010-01-10 19:17:12.806048	f	f
605	449	\N	AA4191148		729449236	2010-01-10 19:18:17.234444	2010-01-10 19:18:17.234444	f	f
606	450	\N	96K287392	Several creases, dirtiness; no holes or missing pieces.	73	2010-01-11 06:34:14.262447	2010-01-11 06:34:14.262447	f	f
607	451	\N			729449236	2010-01-11 07:03:01.036267	2010-01-11 07:03:01.036267	f	f
608	452	\N	AP4748515		5817884	2010-01-11 07:08:27.48911	2010-01-11 07:08:27.48911	f	f
609	453	\N	J173232445		729449236	2010-04-18 21:14:41.453203	2010-04-18 21:14:41.453203	f	f
610	454	\N	I480439743		729449236	2010-04-18 21:16:40.292368	2010-04-18 21:16:40.292368	f	f
611	454	\N	I464713937		729449236	2010-04-18 21:16:59.451189	2010-04-18 21:16:59.451189	f	f
612	455	\N	A 5156416H		729449236	2010-04-18 21:20:23.847801	2010-04-18 21:20:23.847801	f	f
613	456	\N	A 0222415P		729449236	2010-04-18 21:21:07.098066	2010-04-18 21:21:07.098066	f	f
614	457	\N	A 7545034 M		729449236	2010-04-18 21:24:12.413093	2010-04-18 21:24:12.413093	f	f
615	457	\N	A 5164687 Q		729449236	2010-04-18 21:24:27.286139	2010-04-18 21:24:27.286139	f	f
616	458	\N	B6572024C		729449236	2010-04-18 21:27:46.417135	2010-04-18 21:27:46.417135	f	f
617	458	\N	A5761514V		729449236	2010-04-18 21:28:00.995513	2010-04-18 21:28:00.995513	f	f
618	459	\N	A 2829335 S		729449236	2010-04-18 21:29:55.068515	2010-04-18 21:29:55.068515	f	f
619	459	\N	A 2161614 R		729449236	2010-04-18 21:30:07.991282	2010-04-18 21:30:07.991282	f	f
620	460	\N	B3071456Q		729449236	2010-04-18 21:32:39.581211	2010-04-18 21:32:39.581211	f	f
621	460	\N	B3685470Q		729449236	2010-04-18 21:32:56.623751	2010-04-18 21:32:56.623751	f	f
622	461	\N	B9918969P		729449236	2010-04-18 21:36:04.155614	2010-04-18 21:36:04.155614	f	f
623	462	\N	A4181450W		729449236	2010-04-18 21:37:57.055313	2010-04-18 21:37:57.055313	f	f
624	462	\N	A4198211W		729449236	2010-04-18 21:38:07.882082	2010-04-18 21:38:07.882082	f	f
625	463	\N	A 3529614F		729449236	2010-04-18 21:40:02.739499	2010-04-18 21:40:02.739499	f	f
626	463	\N	A 4752634F		729449236	2010-04-18 21:40:17.282383	2010-04-18 21:40:17.282383	f	f
627	196	\N	AX 4814008		729449236	2010-04-18 21:53:02.038005	2010-04-18 21:53:02.038005	f	f
628	198	\N	?A 0917137		729449236	2010-04-18 21:53:44.546444	2010-04-18 21:53:44.546444	f	f
629	200	\N	BM 6613784		729449236	2010-04-18 21:54:47.342155	2010-04-18 21:54:47.342155	f	f
630	201	\N	?? 7469357		729449236	2010-04-18 21:56:01.481939	2010-04-18 21:56:01.481939	f	f
631	202	\N	Bb 9790694		729449236	2010-04-18 21:57:04.132465	2010-04-18 21:57:04.132465	f	f
632	203	\N	B? 9360288		729449236	2010-04-18 21:57:51.767898	2010-04-18 21:57:51.767898	f	f
633	215	\N	A? 182245		5953181	2011-01-10 03:15:40.705075	2011-01-10 03:15:40.705075	f	f
634	214	\N	?? 978466		4397270	2011-01-10 03:18:12.656471	2011-01-10 03:18:12.656471	f	f
635	212	\N	A? 900899		4397270	2011-01-10 03:19:01.077847	2011-01-10 03:19:01.077847	f	f
636	213	\N	A3 6869864		729449236	2011-01-10 03:21:23.49238	2011-01-10 03:21:23.49238	f	f
637	211	\N	AX 115899		4397270	2011-01-10 03:22:35.483245	2011-01-10 03:22:35.483245	f	f
638	210	\N	A? 6413003		729449236	2011-01-10 03:23:45.110896	2011-01-10 03:23:45.110896	f	f
639	209	\N	?? 572289		4397270	2011-01-10 03:24:24.969433	2011-01-10 03:24:38.694701	f	f
640	208	\N	?? 0131558		729449236	2011-01-10 03:26:12.535837	2011-01-10 03:26:12.535837	f	f
641	206	\N	B? 250822		729449236	2011-01-10 03:27:03.893137	2011-01-10 03:27:03.893137	f	f
642	207	\N	?? 631164		729449236	2011-01-10 03:28:32.141385	2011-01-10 03:28:32.141385	f	f
643	204	\N	OY 4433663		729449236	2011-01-10 03:29:03.029363	2011-01-10 03:29:03.029363	f	f
644	205	\N	BE 479318		729449236	2011-01-10 03:29:37.708385	2011-01-10 03:29:37.708385	f	f
645	363	\N	3M 6723341		729449236	2011-01-10 03:33:00.383868	2011-01-10 03:33:00.383868	f	f
646	176	\N	AK 0400573		729449236	2011-01-10 03:34:31.708025	2011-01-10 03:34:31.708025	f	f
647	216	\N	AD1672705		729449236	2011-01-10 03:36:23.91059	2011-01-10 03:36:23.91059	f	f
648	261	\N	A? 9022604		729449236	2011-01-10 03:39:14.30973	2011-01-10 03:39:14.30973	f	f
649	31	\N	AO 4446960		729449236	2011-01-10 03:40:01.695555	2011-01-10 03:40:01.695555	f	f
650	29	\N	AO 0228692		729449236	2011-01-10 03:40:31.072222	2011-01-10 03:40:31.072222	f	f
651	188	\N	8066755		729449236	2011-01-10 03:42:57.51674	2011-01-10 03:42:57.51674	f	f
652	191	\N	4860504		729449236	2011-01-10 03:43:34.565148	2011-01-10 03:43:34.565148	f	f
653	184	\N	A?7633055		729449236	2011-01-10 03:44:17.494616	2011-01-10 03:44:17.494616	f	f
654	185	\N	AT2985462		729449236	2011-01-10 03:44:53.07874	2011-01-10 03:44:53.07874	f	f
655	186	\N	A?7352162		729449236	2011-01-10 03:45:18.763292	2011-01-10 03:45:18.763292	f	f
656	222	\N	?A 9949392		729449236	2011-01-10 03:47:54.99004	2011-01-10 03:47:54.99004	f	f
657	220	\N	P ?9585054		729449236	2011-01-10 03:49:27.454369	2011-01-10 03:49:27.454369	f	f
658	221	\N	M ?5257735		729449236	2011-01-10 03:50:04.189693	2011-01-10 03:50:04.189693	f	f
659	221	\N	M ?5257927		729449236	2011-01-10 03:50:24.559732	2011-01-10 03:50:24.559732	f	f
660	179	\N	AA 86835590		729449236	2011-01-10 03:51:58.307406	2011-01-10 03:51:58.307406	f	f
661	180	\N	BB 61268306		729449236	2011-01-10 03:52:20.137791	2011-01-10 03:52:20.137791	f	f
662	464	\N	DQ8890882		72	2011-01-10 03:56:59.906931	2011-01-10 03:56:59.906931	f	f
663	465	\N	FX 9411564		5817883	2011-01-10 04:01:48.475215	2011-01-10 04:01:48.475215	f	f
664	466	\N	IS 1459164		729449236	2011-01-10 04:05:06.134018	2011-01-10 04:05:06.134018	f	f
665	467	\N	RI 6385381		5817884	2011-01-10 04:07:06.042951	2011-01-10 04:07:06.042951	f	f
666	468	\N	JN 1588774		5817884	2011-01-10 04:10:30.794751	2011-01-10 04:10:30.794751	f	f
667	469	\N	DV175086		72	2011-01-10 04:15:35.222308	2011-01-10 04:15:35.222308	f	f
668	470	\N	JP880870		5817883	2011-01-10 04:19:07.595364	2011-01-10 04:19:07.595364	f	f
669	471	\N	AT875251UG		729449236	2011-01-10 04:22:27.288299	2011-01-10 04:22:27.288299	f	f
670	472	\N	O A 8818829		5953181	2011-01-10 04:30:26.887306	2011-01-10 04:30:26.887306	f	f
671	473	\N	A 1902815		72	2011-01-10 04:35:48.671253	2011-01-10 04:35:48.671253	f	f
672	474	\N	C 01012111		5953181	2011-01-10 04:40:53.449607	2011-01-10 04:40:53.449607	f	f
673	475	\N	333329	Small folds, pin point staining.	72	2011-01-10 04:44:19.789568	2011-01-10 04:44:19.789568	f	f
674	172	\N	11w 014571		729449236	2011-01-10 04:51:33.77147	2011-01-10 04:51:33.77147	f	f
207	172	\N	S 05679148		729449236	2009-05-10 03:31:07.219904	2011-01-10 04:51:54.686774	f	f
675	477	\N	131509387	Heavily worn, folded corners, heavy cross creases with a hole worn in the middle.	73	2011-01-10 05:00:38.84487	2011-01-10 05:00:38.84487	f	f
676	478	\N	TK 448562	Stained and creased, but intact!	73	2011-01-10 05:06:04.667739	2011-01-10 05:06:04.667739	f	f
677	479	\N	AB 2869568		729449236	2011-01-10 05:16:41.449461	2011-01-10 05:16:41.449461	f	f
678	470	\N	GA883591	Wrinkled, light creasing	72	2011-01-10 05:24:41.913309	2011-01-10 05:24:41.913309	f	f
679	481	\N	FD555199	Light creases, edge staining	5817883	2011-01-10 05:28:23.954317	2011-01-10 05:28:23.954317	f	f
680	397	\N	AB 4045173		729449236	2011-01-10 05:36:18.868086	2011-01-10 05:36:18.868086	f	f
681	328	\N	?? 575460		5953181	2011-01-10 05:37:37.574464	2011-01-10 05:37:37.574464	f	f
682	334	\N	282388		5953181	2011-01-10 05:38:28.619394	2011-01-10 05:38:28.619394	f	f
683	333	\N	?? 152770		4397270	2011-01-10 05:39:12.447844	2011-01-10 05:39:12.447844	f	f
684	410	\N	C 865 181143		4397270	2011-01-10 05:40:12.353874	2011-01-10 05:40:12.353874	f	f
685	427	\N	C093508		4397270	2011-01-10 05:41:13.831585	2011-01-10 05:41:13.831585	f	f
686	335	\N	?? 114792		729449236	2011-01-10 06:11:00.228719	2011-01-10 06:11:00.228719	f	f
687	426	\N	7672063		729449236	2011-01-10 06:21:52.959559	2011-01-10 06:21:52.959559	f	f
688	422	\N	A4268671		729449236	2011-01-10 06:23:13.885142	2011-01-10 06:23:13.885142	f	f
689	230	\N	D 7002825 B		729449236	2011-01-10 06:29:55.70126	2011-01-10 06:29:55.70126	f	f
690	231	\N	A 2126760 A		729449236	2011-01-10 06:31:06.955872	2011-01-10 06:31:06.955872	f	f
691	16	\N	31.427.766 A		729449236	2011-01-10 06:31:51.40387	2011-01-10 06:31:51.40387	f	f
692	233	\N	77.903.192 A		729449236	2011-01-10 06:32:43.311902	2011-01-10 06:32:43.311902	f	f
693	370	\N	CD6329766		729449236	2011-01-10 06:34:04.691462	2011-01-10 06:34:04.691462	f	f
694	369	\N	A.0046 545751		729449236	2011-01-10 06:34:57.108356	2011-01-10 06:34:57.108356	f	f
695	347	\N	?? 3624202		729449236	2011-01-10 06:36:15.706756	2011-01-10 06:36:15.706756	f	f
696	311	\N			729449236	2011-01-10 06:37:12.561243	2011-01-10 06:37:12.561243	f	f
697	12	\N	78.401.201 D		729449236	2011-01-10 06:38:26.068502	2011-01-10 06:38:26.068502	f	f
698	15	\N	78.752.949 D		729449236	2011-01-10 06:39:20.867131	2011-01-10 06:39:20.867131	f	f
699	6	\N	90.374.777 B		729449236	2011-01-10 06:40:10.622752	2011-01-10 06:40:10.622752	f	f
169	135	\N	DV 4006052		729449236	2009-05-05 21:54:42.669883	2011-01-10 19:10:53.819004	f	f
700	456	\N	A2289798N		729449236	2011-01-10 19:15:16.720077	2011-01-10 19:15:16.720077	f	f
701	406	\N	A/25 892730		729449236	2011-01-10 19:16:16.614909	2011-01-10 19:16:16.614909	f	f
702	133	\N	BS 1967494		729449236	2011-01-10 19:17:08.400261	2011-01-10 19:17:08.400261	f	f
703	461	\N	B 9872749 P		729449236	2011-01-10 19:18:00.219517	2011-01-10 19:18:00.219517	f	f
704	349	\N			4397270	2011-01-10 19:18:50.028976	2011-01-10 19:18:50.028976	f	f
705	101	\N	EL 4467799		729449236	2011-01-10 19:19:52.650144	2011-01-10 19:19:52.650144	f	f
706	312	\N			729449236	2011-01-10 19:20:18.42135	2011-01-10 19:20:18.42135	f	f
707	416	\N	A 11625836		729449236	2011-01-10 19:21:53.361231	2011-01-10 19:21:53.361231	f	f
708	348	\N			729449236	2011-01-10 19:22:29.79698	2011-01-10 19:22:29.79698	f	f
709	482	\N	FE568349		729449236	2011-01-10 19:34:32.353178	2011-01-10 19:34:32.353178	f	f
710	321	\N	0030492531		729449236	2011-01-10 19:36:19.252669	2011-01-10 19:36:19.252669	f	f
711	324	\N	0202509891		729449236	2011-01-10 19:37:15.837838	2011-01-10 19:37:15.837838	f	f
712	326	\N	0621495495		729449236	2011-01-10 19:38:08.060846	2011-01-10 19:38:08.060846	f	f
713	482	\N	FE568444		729449236	2011-01-10 19:42:45.122882	2011-01-10 19:42:45.122882	f	f
714	282	\N	E/1 942283		729449236	2011-01-10 19:43:53.299403	2011-01-10 19:43:53.299403	f	f
715	284	\N	EE/1 345892		729449236	2011-01-10 19:44:44.03419	2011-01-10 19:44:44.03419	f	f
716	284	\N	EE/1 345791		729449236	2011-01-10 19:45:20.195889	2011-01-10 19:45:20.195889	f	f
717	316	\N	H27 868440		729449236	2011-01-10 19:47:45.644304	2011-01-10 19:47:45.644304	f	f
718	315	\N	I73 154697		729449236	2011-01-10 19:48:21.487889	2011-01-10 19:48:21.487889	f	f
719	305	\N	D0089768		729449236	2011-01-10 19:49:49.299771	2011-01-10 19:49:49.299771	f	f
720	282	\N	E/1 942106		729449236	2011-01-10 19:51:06.764444	2011-01-10 19:51:06.764444	f	f
721	304	\N	B4743523		729449236	2011-01-10 19:51:49.14889	2011-01-10 19:51:49.14889	f	f
722	242	\N	AB2291951		729449236	2011-01-10 19:52:40.704616	2011-01-10 19:52:40.704616	f	f
723	290	\N	ZD 4300548		729449236	2011-01-10 19:53:27.063751	2011-01-10 19:53:27.063751	f	f
724	289	\N	AJ8779576		729449236	2011-01-10 19:54:26.830275	2011-01-10 19:54:26.830275	f	f
725	259	\N	AM 477965		729449236	2011-01-10 20:01:18.173206	2011-01-10 20:01:18.173206	f	f
726	260	\N	CK 527138		729449236	2011-01-10 20:03:30.425283	2011-01-10 20:03:30.425283	f	f
727	250	\N	COM1848032		729449236	2011-01-10 20:04:08.570105	2011-01-10 20:04:08.570105	f	f
728	247	\N	AA088447		729449236	2011-01-11 02:32:59.713599	2011-01-11 02:32:59.713599	f	f
729	243	\N	HZ 4954460		729449236	2011-01-11 02:34:19.782053	2011-01-11 02:34:19.782053	f	f
730	241	\N	AD0871820		729449236	2011-01-11 02:38:04.464309	2011-01-11 02:38:04.464309	f	f
731	125	\N	FC421049		729449236	2011-01-11 02:39:57.590547	2011-01-11 02:39:57.590547	f	f
732	341	\N	??1827966		729449236	2011-01-11 02:51:22.864295	2011-01-11 02:51:22.864295	f	f
733	483	\N	AF 529005		729449236	2011-01-11 02:55:57.479093	2011-01-11 02:55:57.479093	f	f
734	483	\N	AF 529084		729449236	2011-01-11 02:57:56.088039	2011-01-11 02:57:56.088039	f	f
735	430	\N			729449236	2011-01-11 02:58:58.977787	2011-01-11 02:58:58.977787	f	f
736	115	\N	ND 4677469		729449236	2011-01-11 03:00:01.660295	2011-01-11 03:00:01.660295	f	f
737	272	\N	AT 585992		729449236	2011-01-11 03:01:45.056315	2011-01-11 03:01:45.056315	f	f
738	1	\N			729449236	2011-01-11 03:02:38.83737	2011-01-11 03:02:38.83737	f	f
739	2	\N			729449236	2011-01-11 03:03:18.367579	2011-01-11 03:03:18.367579	f	f
740	249	\N	PE1493687		729449236	2011-01-11 03:06:54.12788	2011-01-11 03:06:54.12788	f	f
741	400	\N	250/2 214956		729449236	2011-01-11 03:08:43.601564	2011-01-11 03:08:43.601564	f	f
742	399	\N	210/2 051645		729449236	2011-01-11 03:09:18.72977	2011-01-11 03:09:18.72977	f	f
743	27	\N			729449236	2011-01-11 03:14:18.705327	2011-01-11 03:14:18.705327	f	f
744	5	\N	BL 143849		729449236	2011-01-11 03:15:23.487505	2011-01-11 03:15:23.487505	f	f
745	402	\N	207/2 162356		729449236	2011-01-11 03:16:39.67714	2011-01-11 03:16:39.67714	f	f
746	401	\N	215/2 252832		729449236	2011-01-11 03:17:24.757384	2011-01-11 03:17:24.757384	f	f
747	248	\N	FP0939430		729449236	2011-01-11 03:19:18.518436	2011-01-11 03:19:18.518436	f	f
748	258	\N	NF264460		729449236	2011-01-11 03:20:47.578109	2011-01-11 03:20:47.578109	f	f
749	118	\N	PR	Stamped with "Received for Safe Keeping"	5953181	2011-01-11 03:24:01.288835	2011-01-11 03:24:01.288835	f	f
750	484	\N	AG823175		729449236	2011-01-11 03:27:45.886132	2011-01-11 03:27:45.886132	f	f
751	484	\N	AG823045		729449236	2011-01-11 03:29:08.10785	2011-01-11 03:29:08.10785	f	f
752	119	\N	PK 932108		729449236	2011-01-11 03:30:21.088326	2011-01-11 03:30:21.088326	f	f
753	255	\N	JC008493		729449236	2011-01-11 03:31:03.948592	2011-01-11 03:31:03.948592	f	f
754	256	\N	NE069389		729449236	2011-01-11 03:31:40.811963	2011-01-11 03:31:40.811963	f	f
755	392	\N			729449236	2011-01-11 03:32:34.88684	2011-01-11 03:32:34.88684	f	f
756	396	\N			729449236	2011-01-11 03:33:17.47945	2011-01-11 03:33:17.47945	f	f
757	395	\N	769821		729449236	2011-01-11 03:34:10.541096	2011-01-11 03:34:10.541096	f	f
758	337	\N	??9474762		729449236	2011-01-11 03:35:08.031406	2011-01-11 03:35:08.031406	f	f
759	485	\N	798539		729449236	2011-01-11 03:38:16.996026	2011-01-11 03:38:16.996026	f	f
760	485	\N	798520		729449236	2011-01-11 03:38:34.252968	2011-01-11 03:38:34.252968	f	f
761	2	\N			729449236	2011-01-11 03:39:28.415953	2011-01-11 03:39:28.415953	f	f
762	420	\N	BK 603431		729449236	2011-01-11 03:40:40.780752	2011-01-11 03:40:40.780752	f	f
763	486	\N			729449236	2011-01-11 03:46:44.97934	2011-01-11 03:46:44.97934	f	f
764	486	\N			729449236	2011-01-11 03:46:48.389433	2011-01-11 03:46:48.389433	f	f
765	390	\N	B 3978363 C		729449236	2011-01-11 03:47:52.322088	2011-01-11 03:47:52.322088	f	f
766	391	\N	C 8845940 J		729449236	2011-01-11 03:48:21.628308	2011-01-11 03:48:21.628308	f	f
767	393	\N			729449236	2011-01-11 03:51:26.974974	2011-01-11 03:51:26.974974	f	f
768	287	\N	BE 845817		729449236	2011-01-11 03:53:40.656533	2011-01-11 03:53:40.656533	f	f
769	487	\N	AM 476731		729449236	2011-01-11 03:57:48.392361	2011-01-11 03:57:48.392361	f	f
770	252	\N	AB 481564		729449236	2011-01-11 04:00:11.040222	2011-01-11 04:00:11.040222	f	f
771	488	\N	BA 172861		729449236	2011-01-11 04:00:50.552583	2011-01-11 04:00:50.552583	f	f
772	489	\N	011B1238427		729449236	2011-01-11 04:06:15.762148	2011-01-11 04:06:15.762148	f	f
773	490	\N	B/6 681194		729449236	2011-01-11 04:10:12.928741	2011-01-11 04:10:12.928741	f	f
774	92	\N			729449236	2011-01-11 04:11:25.191714	2011-01-11 04:11:25.191714	f	f
775	88	\N			729449236	2011-01-11 04:13:38.370266	2011-01-11 04:13:38.370266	f	f
776	491	\N	U08666588		729449236	2011-01-11 04:17:23.208773	2011-01-11 04:17:23.208773	f	f
777	492	\N	HC932694		729449236	2011-01-11 04:21:32.148962	2011-01-11 04:21:32.148962	f	f
778	493	\N	A.0075 893394		729449236	2011-01-11 04:25:59.040838	2011-01-11 04:25:59.040838	f	f
779	494	\N	CA 1186242		729449236	2011-01-11 04:31:50.254164	2011-01-11 04:31:50.254164	f	f
780	494	\N	CA 0730893		729449236	2011-01-11 04:32:18.35557	2011-01-11 04:32:18.35557	f	f
781	417	\N	79B 428193		5817883	2011-01-11 04:34:46.286743	2011-01-11 04:34:46.286743	f	f
782	493	\N	A.0009 050842	Issued 1994	729449236	2011-01-11 04:37:00.764282	2011-01-11 04:37:00.764282	f	f
783	495	\N	BA194684		729449236	2011-01-11 04:39:59.386056	2011-01-11 04:39:59.386056	f	f
784	491	\N	U08528684		729449236	2011-01-11 04:42:25.970062	2011-01-11 04:42:25.970062	f	f
785	262	\N	CM 0564242		729449236	2011-01-11 04:43:20.013584	2011-01-11 04:43:20.013584	f	f
786	496	\N	FH381634		729449236	2011-01-11 04:46:28.789483	2011-01-11 04:46:28.789483	f	f
787	489	\N	001C8022034		729449236	2011-01-11 04:47:58.008069	2011-01-11 04:47:58.008069	f	f
788	490	\N	B/6 682284		729449236	2011-01-11 04:49:10.840103	2011-01-11 04:49:10.840103	f	f
789	497	\N	00395194		729449236	2011-01-11 17:26:33.508021	2011-01-11 17:26:33.508021	f	f
790	497	\N	00394634		729449236	2011-01-11 17:26:58.906857	2011-01-11 17:26:58.906857	f	f
791	121	\N	FP565245		729449236	2011-07-18 21:06:11.878385	2011-07-18 21:06:11.878385	f	f
792	121	\N	RY217315		729449236	2011-07-18 21:06:26.638644	2011-07-18 21:06:26.638644	f	f
793	498	\N	392338	Noticable stains, rounding of corners, nicks, heavy creases; no missing pieces or tears into the printing.	73	2011-07-18 21:14:26.938693	2011-07-18 21:14:26.938693	f	f
794	499	\N	183646	Fuzzy edges and corners, nicked, faded, heavy creasing; no tears into printed regions.	73	2011-07-18 21:16:54.75861	2011-07-18 21:16:54.75861	f	f
795	500	\N	3709	Faded, rounded corners, nicks, heavy creasing.	73	2011-07-18 21:22:04.145753	2011-07-18 21:22:04.145753	f	f
796	501	\N	67785	Heavily faded, wrinkled, rounded corners	73	2011-07-18 21:22:53.730672	2011-07-18 21:22:53.730672	f	f
797	502	\N	180939	Faded, some rounding of corners, nicks, staple holes	73	2011-07-18 21:23:54.625678	2011-07-18 21:23:54.625678	f	f
798	503	\N	20956	Faded, creased, fuzzy, nicks.	73	2011-07-18 21:24:55.250026	2011-07-18 21:24:55.250026	f	f
799	504	\N	5949	Almost unreadable, extremely faded, but still intact	82	2011-07-18 21:28:20.754974	2011-07-18 21:28:20.754974	f	f
800	505	\N	136314	A little fade, minor creasing, edges and corners only slightly fuzzy. Post-printing signatures on reverse.	5817884	2011-07-18 21:30:06.620156	2011-07-18 21:30:06.620156	f	f
801	506	\N	359929	Faded, slight fuzzing on edges and corners, water staining.	5817884	2011-07-18 21:31:19.389958	2011-07-18 21:31:19.389958	f	f
802	507	\N	286320	Faded, edges and corners OK, post-printing signatures and water damage	73	2011-07-18 21:32:42.268639	2011-07-18 21:32:42.268639	f	f
803	136	\N			729449236	2011-07-18 21:33:18.636009	2011-07-18 21:33:18.636009	f	f
804	351	\N	AM 90994167		729449236	2011-07-18 21:33:58.058713	2011-07-18 21:33:58.058713	f	f
805	360	\N	03265314		729449236	2011-07-18 21:34:51.842357	2011-07-18 21:34:51.842357	f	f
806	437	\N	B096971		729449236	2011-07-18 21:35:31.469557	2011-07-18 21:35:31.469557	f	f
807	441	\N	D62634869		729449236	2011-07-18 21:36:15.145365	2011-07-18 21:36:15.145365	f	f
808	480	\N	ABA 011812	Wrinkles, small staining specks	5953181	2011-07-18 21:37:19.438044	2011-07-18 21:37:19.438044	f	f
809	508	\N			729449236	2011-07-18 22:12:16.254313	2011-07-18 22:12:16.254313	f	f
810	509	\N			729449236	2011-07-18 22:15:26.008804	2011-07-18 22:15:26.008804	f	f
811	510	\N			729449236	2011-07-18 22:18:47.669828	2011-07-18 22:18:47.669828	f	f
812	511	\N			729449236	2011-07-18 22:23:46.311866	2011-07-18 22:23:46.311866	f	f
814	512	\N	07150		5953181	2011-07-18 22:26:42.318541	2011-07-18 22:26:42.318541	f	f
4	5	\N	BL 143748		729449236	2009-04-29 06:27:49.497267	2011-12-27 04:06:22.542189	f	f
815	513	\N	?? 004798		729449236	2011-12-27 10:12:26.345203	2011-12-27 10:12:26.345203	f	f
816	514	\N	?? 006004		729449236	2011-12-27 10:13:39.742492	2011-12-27 10:13:39.742492	f	f
817	515	\N	?? 005172		729449236	2011-12-27 10:14:31.241513	2011-12-27 10:15:26.762406	f	f
818	516	\N	?? 015965		729449236	2011-12-27 10:16:16.75047	2011-12-27 10:16:16.75047	f	f
819	517	\N	?? 007732		729449236	2011-12-27 10:17:53.164058	2011-12-27 10:17:53.164058	f	f
820	518	\N	?? 006023		729449236	2011-12-27 10:18:41.640879	2011-12-27 10:18:41.640879	f	f
821	519	\N	?? 011126		729449236	2011-12-27 10:19:56.4841	2011-12-27 10:19:56.4841	f	f
822	520	\N	?? 002862		729449236	2011-12-27 10:20:57.760345	2011-12-27 10:20:57.760345	f	f
823	521	\N	?? 803923		729449236	2011-12-27 10:42:32.224682	2011-12-27 10:42:32.224682	f	f
824	522	\N	?? 903823		729449236	2011-12-27 10:44:08.844741	2011-12-27 10:44:08.844741	f	f
825	523	\N	?? 501123		729449236	2011-12-27 10:45:50.9896	2011-12-27 10:45:50.9896	f	f
826	524	\N			729449236	2011-12-27 10:47:07.354751	2011-12-27 10:47:07.354751	f	f
827	525	\N			729449236	2011-12-27 10:47:59.438097	2011-12-27 10:47:59.438097	f	f
828	526	\N			729449236	2011-12-27 10:48:43.303641	2011-12-27 10:48:43.303641	f	f
829	527	\N	?? 198350		729449236	2011-12-27 10:52:36.844465	2011-12-27 10:52:36.844465	f	f
830	528	\N	?? 077080		729449236	2011-12-27 10:55:09.188331	2011-12-27 10:55:09.188331	t	f
831	529	\N	?? 084549		729449236	2011-12-27 10:56:43.638327	2011-12-27 10:56:43.638327	f	f
832	529	\N	?? 128938		729449236	2011-12-27 10:56:55.609372	2011-12-27 10:56:55.609372	f	f
833	530	\N	?? 874838		729449236	2011-12-27 10:58:43.15981	2011-12-27 10:58:43.15981	f	f
834	530	\N	?? 155731		729449236	2011-12-27 10:58:54.072862	2011-12-27 10:58:54.072862	f	f
835	531	\N	?? 695349		729449236	2011-12-27 11:00:21.401936	2011-12-27 11:00:21.401936	f	f
836	532	\N	?? 0817323		729449236	2011-12-27 11:05:15.04687	2011-12-27 11:05:15.04687	f	f
837	533	\N	?? 655455		729449236	2011-12-27 11:06:52.607132	2011-12-27 11:06:52.607132	f	f
838	533	\N	?? 380481		729449236	2011-12-27 11:07:07.663898	2011-12-27 11:07:07.663898	f	f
839	534	\N	?? 0551150		729449236	2011-12-27 11:09:54.522964	2011-12-27 11:09:54.522964	f	f
840	535	\N	?? 000000		729449236	2011-12-27 11:13:15.313724	2011-12-27 11:13:15.313724	f	t
841	536	\N	?? 000000		729449236	2011-12-27 11:18:47.433261	2011-12-27 11:18:47.433261	f	t
842	537	\N	?? 000000		729449236	2011-12-27 11:21:04.686997	2011-12-27 11:21:04.686997	f	t
843	538	\N	?? 000000		729449236	2011-12-27 11:22:44.826923	2011-12-27 11:22:44.826923	f	t
844	539	\N	?? 00000000		729449236	2011-12-27 11:25:46.04966	2011-12-27 11:25:46.04966	f	t
845	540	\N	?? 000000		729449236	2011-12-27 11:26:26.332554	2011-12-27 11:26:26.332554	f	t
846	541	\N	?? 000000	Large red "specimen" characters, ala CS2 series notes.	729449236	2011-12-27 11:29:13.100569	2011-12-27 11:29:13.100569	f	t
847	542	\N	ONY04713		72	2011-12-27 11:37:06.518352	2011-12-27 11:37:06.518352	f	f
848	542	\N	OML567472		72	2011-12-27 11:37:27.632439	2011-12-27 11:37:27.632439	f	f
\.


--
-- Data for Name: printers; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY printers (id, name, region_id, created_at, updated_at) FROM stdin;
1	De La Rue	39	2009-05-13 20:02:24.243806	2009-05-13 20:02:24.243806
2	Bradbury, Wilkinson & Co.	39	2009-05-13 20:08:16.177338	2009-05-13 20:08:16.177338
3	Türkiye Cumhuriyet Merkez Bankasi Banknot Matbaasi	47	2009-05-17 21:51:57.423128	2009-05-17 21:51:57.423128
4	Joh. Enschedé	50	2009-05-17 22:09:11.139057	2009-05-17 22:09:11.139057
5	American Bank Note Company	53	2009-05-17 23:06:56.054756	2009-05-17 23:06:56.054756
6	Giesecke & Devrient, München	21	2009-05-17 23:09:15.400926	2009-05-17 23:09:15.400926
7	United States Bank Note Company	53	2009-06-08 02:08:18.646983	2009-06-08 02:08:18.646983
8	Harrison & Sons Limited	39	2009-06-08 03:21:24.738501	2009-06-08 03:21:24.738501
9	Casa de Moeda do Brasil	12	2010-04-18 21:23:19.322233	2010-04-18 21:23:19.322233
10	Bundesdruckerei	21	2010-04-18 21:26:47.823107	2010-04-18 21:26:47.823107
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY regions (id, name, native_name, created_at, updated_at, parent_id, ancestry) FROM stdin;
7	Bangladesh		2009-04-29 19:53:52.019573	2011-06-21 06:13:52.005193	96	Earth:Asia:Bangladesh
9	Bhutan		2009-04-29 23:10:34.359802	2011-06-21 06:14:03.477214	96	Earth:Asia:Bhutan
52	Cambodia		2009-05-17 22:45:41.600597	2011-06-21 06:14:20.536072	96	Earth:Asia:Cambodia
61	China		2009-05-23 19:56:20.527527	2011-06-21 06:14:29.63508	96	Earth:Asia:China
69	Hong Kong		2009-06-08 02:20:58.764916	2011-06-21 06:14:37.390064	96	Earth:Asia:Hong Kong
43	Indonesia		2009-05-17 20:59:52.394476	2011-06-21 06:14:46.72569	96	Earth:Asia:Indonesia
19	Laos		2009-05-05 21:15:45.130303	2011-06-21 06:14:55.510972	96	Earth:Asia:Laos
32	Myanmar		2009-05-10 17:50:19.686998	2011-06-21 06:15:10.741656	96	Earth:Asia:Myanmar
96	Asia		2011-06-21 05:23:16.821707	2011-06-21 05:58:14.418423	94	Earth:Asia
75	Nepal		2009-06-08 03:09:33.034083	2011-06-21 06:15:18.53396	96	Earth:Asia:Nepal
16	Malaya		2009-05-05 20:19:26.384117	2011-07-16 20:56:06.691425	96	Earth:Asia:Malaya
73	Mexico		2009-06-08 02:38:01.782021	2011-07-16 20:56:25.101889	101	Earth:Central America:Mexico
74	Mozambique	Mocambique	2009-06-08 02:42:41.12499	2011-07-16 20:56:43.060411	97	Earth:Africa:Mozambique
76	New Zealand		2009-06-08 03:14:12.644295	2011-07-16 20:56:55.420274	100	Earth:Oceania:New Zealand
91	Oman		2011-01-11 03:43:38.998302	2011-07-16 20:57:16.435674	102	Earth:Middle East:Oman
35	Pakistan		2009-05-10 18:31:44.251665	2011-07-16 20:57:31.219142	102	Earth:Middle East:Pakistan
90	Somalia	Soomaaliya	2011-01-11 03:36:08.271473	2011-07-16 20:58:19.782903	97	Earth:Africa:Somalia
89	Somaliland		2011-01-11 03:26:26.889044	2011-07-16 20:58:23.689653	97	Earth:Africa:Somaliland
26	Soviet Union	CCCP	2009-05-10 04:27:57.107019	2011-07-16 20:58:29.37475	96	Earth:Asia:Soviet Union
56	Sudan		2009-05-21 04:46:55.295961	2011-07-16 20:58:34.033391	97	Earth:Africa:Sudan
22	Tajikistan	Ҷумҳурии Тоҷикистон	2009-05-10 03:47:25.157795	2011-07-16 20:58:55.488971	96	Earth:Asia:Tajikistan
33	Turkmenistan		2009-05-10 18:06:13.759759	2011-07-16 20:59:08.984381	96	Earth:Asia:Turkmenistan
23	Uzbekistan	Ўзбекистон	2009-05-10 03:55:56.68753	2011-07-16 20:59:23.791618	96	Earth:Asia:Uzbekistan
54	Venezuela		2009-05-21 04:20:50.114701	2011-07-16 20:59:38.855089	98	Earth:South America:Venezuela
40	Yemen		2009-05-17 20:43:34.965345	2011-07-16 20:59:56.630891	102	Earth:Middle East:Yemen
30	Zaire	Zaïre	2009-05-10 05:36:12.264728	2011-07-16 21:00:05.867935	97	Earth:Africa:Zaire
42	Zambia		2009-05-17 20:56:42.78716	2011-07-16 21:00:13.38251	97	Earth:Africa:Zambia
80	Zimbabwe		2010-01-10 19:12:01.035407	2011-07-16 21:00:16.230445	97	Earth:Africa:Zimbabwe
83	Angola		2011-01-10 03:53:20.378279	2011-07-16 21:07:29.67504	97	Earth:Africa:Angola
94	Earth	\N	2011-06-21 04:04:34.104448	2011-06-21 06:07:24.496543	\N	Earth
84	Thailand		2011-01-10 04:28:31.727893	2011-06-21 06:15:25.788405	96	Earth:Asia:Thailand
37	Vietnam		2009-05-10 19:40:14.528834	2011-06-21 06:15:39.475912	96	Earth:Asia:Vietnam
95	Europe		2011-06-21 05:20:41.663082	2011-06-21 06:19:14.690005	94	Earth:Europe
5	Austria	Österreich	2009-04-29 19:16:18.678798	2011-06-21 06:19:21.252636	95	Earth:Europe:Austria
85	Belgium	Belgique	2011-01-10 04:58:37.158783	2011-06-21 06:19:21.267259	95	Earth:Europe:Belgium
11	Bosnia & Herzegovina		2009-04-29 23:25:04.411807	2011-06-21 06:19:48.215459	95	Earth:Europe:Bosnia & Herzegovina
27	Bulgaria		2009-05-10 04:52:23.464975	2011-06-21 06:20:00.445949	95	Earth:Europe:Bulgaria
45	Estonia	Eesti	2009-05-17 21:26:02.822491	2011-06-21 06:20:08.64751	95	Earth:Europe:Estonia
68	Hungary	Magyar	2009-06-08 02:13:35.611364	2011-06-21 06:20:27.948293	95	Earth:Europe:Hungary
70	Iceland		2009-06-08 02:26:28.573985	2011-06-21 06:20:35.699529	95	Earth:Europe:Iceland
81	Ireland	Eireann	2010-01-11 06:32:27.817018	2011-06-21 06:20:52.780785	95	Earth:Europe:Ireland
72	Latvia	Latvijas	2009-06-08 02:33:51.941062	2011-06-21 06:21:01.438029	95	Earth:Europe:Latvia
50	Netherlands	Nederlands	2009-05-17 22:08:14.691758	2011-06-21 06:21:16.169998	95	Earth:Europe:Netherlands
14	Poland	Polska	2009-05-04 05:56:40.688951	2011-06-21 06:21:23.723959	95	Earth:Europe:Poland
58	Romania	Romaniei	2009-05-23 19:29:50.171436	2011-06-21 06:21:32.344396	95	Earth:Europe:Romania
34	Slovenia	Republika Slovenija	2009-05-10 18:18:45.208499	2011-06-21 06:21:41.658521	95	Earth:Europe:Slovenia
29	Transnistria		2009-05-10 05:30:16.835491	2011-06-21 06:21:49.247046	95	Earth:Europe:Transnistria
47	Turkey	Türkiye	2009-05-17 21:49:42.095915	2011-06-21 06:21:56.368915	95	Earth:Europe:Turkey
1	Afghanistan		2009-04-29 05:38:27.048907	2011-07-16 20:42:20.116819	96	Earth:Asia:Afghanistan
3	Argentina		2009-04-29 06:28:26.796547	2011-07-16 20:45:13.360242	98	Earth:South America:Argentina
4	Armenia		2009-04-29 19:08:54.516171	2011-07-16 20:45:52.284866	95	Earth:Europe:Armenia
8	Belarus		2009-04-29 19:58:19.129059	2011-07-16 20:46:11.581349	95	Earth:Europe:Belarus
10	Bolivia		2009-04-29 23:22:45.129266	2011-07-16 20:46:36.461867	98	Earth:South America:Bolivia
12	Brazil		2009-04-29 23:35:17.225037	2011-07-16 20:46:43.79734	98	Earth:South America:Brazil
88	Burundi		2011-01-11 02:52:41.264651	2011-07-16 20:46:57.875418	96	Earth:Asia:Burundi
60	Canada		2009-05-23 19:50:59.808785	2011-07-16 20:47:49.841761	99	Earth:North America:Canada
62	Congo		2009-05-23 20:37:06.784157	2011-07-16 20:48:25.584014	97	Earth:Africa:Congo
86	Cook Islands		2011-01-10 05:20:48.407834	2011-07-16 20:49:43.974555	100	Earth:Oceania:Cook Islands
49	Costa Rica		2009-05-17 22:01:14.512847	2011-07-16 20:50:44.547623	101	Earth:Central America:Costa Rica
79	Cuba		2010-01-10 02:26:14.661053	2011-07-16 20:51:00.980403	101	Earth:Central America:Cuba
55	Ecuador		2009-05-21 04:31:17.546855	2011-07-16 20:52:29.501393	98	Earth:South America:Ecuador
63	Egypt		2009-05-23 20:41:02.242949	2011-07-16 20:52:37.243859	97	Earth:Africa:Egypt
64	Eritrea		2009-06-08 01:48:03.64	2011-07-16 20:52:43.371758	97	Earth:Africa:Eritrea
65	Georgia		2009-06-08 01:52:38.953239	2011-07-16 20:52:56.107332	96	Earth:Asia:Georgia
41	Guinea	Republique de Guinee	2009-05-17 20:48:18.790912	2011-07-16 20:53:11.898677	97	Earth:Africa:Guinea
31	Guinea-Bissau		2009-05-10 17:45:33.940713	2011-07-16 20:53:17.57043	97	Earth:Africa:Guinea-Bissau
66	Guyana		2009-06-08 01:59:27.878825	2011-07-16 20:53:22.186654	97	Earth:Africa:Guyana
67	Haiti	Republique d'Haiti	2009-06-08 02:05:36.522297	2011-07-16 20:53:30.529112	101	Earth:Central America:Haiti
71	India		2009-06-08 02:30:12.320587	2011-07-16 20:53:53.015792	96	Earth:Asia:India
13	Iraq		2009-04-30 04:43:41.280076	2011-07-16 20:54:25.679224	102	Earth:Middle East:Iraq
48	Jamaica	Jamaica	2009-05-17 21:56:58.93006	2011-07-16 20:54:34.752159	101	Earth:Central America:Jamaica
46	Lebanon	Liban	2009-05-17 21:34:55.509098	2011-07-16 20:55:25.140712	102	Earth:Middle East:Lebanon
57	Macedonia	Македонија	2009-05-23 19:22:36.509248	2011-07-16 20:55:44.123448	95	Earth:Europe:Macedonia
92	Moldova	Republica Moldova	2011-01-11 04:24:33.252294	2011-07-16 20:56:33.258867	95	Earth:Europe:Moldova
77	Nicaragua	Republica de Nicaragua	2009-06-08 03:19:08.647575	2011-07-16 20:57:07.122239	101	Earth:Central America:Nicaragua
17	Burma	Myanmar	2009-05-05 20:35:41.676623	2011-06-21 06:14:12.393515	96	Earth:Asia:Burma
38	Mongolia	Монгол улс	2009-05-10 19:47:28.69863	2011-06-21 06:15:03.542113	96	Earth:Asia:Mongolia
2	Albania		2009-04-29 06:25:32.16567	2011-06-21 06:19:21.239099	95	Earth:Europe:Albania
39	Great Britain		2009-05-13 04:28:31.483795	2011-06-21 06:20:18.131991	95	Earth:Europe:Great Britain
36	Lithuania	Lietuvos Respublika	2009-05-10 18:40:23.67995	2011-06-21 06:21:09.09677	95	Earth:Europe:Lithuania
28	Ukraine	Україна	2009-05-10 05:18:27.271793	2011-06-21 06:22:06.29692	95	Earth:Europe:Ukraine
20	Yugoslavia	Југославија	2009-05-05 21:37:41.482994	2011-06-21 06:22:16.075774	95	Earth:Europe:Yugoslavia
82	Peru	Peru	2010-04-18 21:11:04.810367	2011-07-16 20:57:46.378907	98	Earth:South America:Peru
97	Africa	\N	2011-07-16 20:43:05.851417	2011-07-16 20:43:43.993821	94	Earth:Africa
15	Russia	Российская Федерация	2009-05-05 20:06:18.756842	2011-07-16 20:58:14.041955	96	Earth:Asia:Russia
98	South America	\N	2011-07-16 20:44:06.321165	2011-07-16 20:44:35.136365	94	Earth:South America
6	Azerbaijan	Azərbaycan	2009-04-29 19:49:28.703524	2011-07-16 20:46:01.727909	96	Earth:Asia:Azerbaijan
99	North America	\N	2011-07-16 20:47:40.116155	2011-07-16 20:47:40.116155	94	Earth:North America
78	Comoros	Comores	2010-01-10 02:16:09.151013	2011-07-16 20:48:17.162994	97	Earth:Africa:Comoros
100	Oceania	\N	2011-07-16 20:49:34.656832	2011-07-16 20:49:34.656832	94	Earth:Oceania
101	Central America	\N	2011-07-16 20:50:23.055952	2011-07-16 20:50:23.055952	94	Earth:Central America
44	Croatia	Republika Hrvatska	2009-05-17 21:14:18.950918	2011-07-16 20:50:52.478148	95	Earth:Europe:Croatia
21	Germany	Deutschland	2009-05-10 02:32:05.592204	2011-07-16 20:53:04.78684	95	Earth:Europe:Germany
59	Honduras	Republica de Honduras	2009-05-23 19:35:59.242555	2011-07-16 20:53:43.347042	101	Earth:Central America:Honduras
102	Middle East	\N	2011-07-16 20:54:17.93421	2011-07-16 20:54:17.93421	94	Earth:Middle East
24	Kazakhstan	Қазақстан	2009-05-10 04:03:55.596817	2011-07-16 20:54:42.733381	96	Earth:Asia:Kazakhstan
25	Kyrgyzstan	Кыргыз Республикасы	2009-05-10 04:16:17.203258	2011-07-16 20:54:47.205336	96	Earth:Asia:Kyrgyzstan
51	Surinam	Suriname	2009-05-17 22:09:38.365882	2011-07-16 20:58:49.624987	98	Earth:South America:Surinam
87	Trinidad and Tobago		2011-01-10 19:32:19.000823	2011-07-16 20:59:03.456458	101	Earth:Central America:Trinidad and Tobago
53	United States	United States of America	2009-05-17 23:06:42.510058	2011-07-16 20:59:16.088271	99	Earth:North America:United States
103	Bad Kösen		2011-07-18 22:09:50.894713	2011-07-18 22:09:50.894713	21	Earth:Europe:Germany:Bad Kösen
104	Mühlberg an Elbe		2011-07-18 22:13:46.214042	2011-07-18 22:13:46.214042	21	Earth:Europe:Germany:Mühlberg an Elbe
105	Kreises Winsen		2011-07-18 22:17:06.55863	2011-07-18 22:17:06.55863	21	Earth:Europe:Germany:Kreises Winsen
106	Quedlinburg		2011-07-18 22:20:13.8292	2011-07-18 22:20:43.842879	21	Earth:Europe:Germany:Quedlinburg
107	Bad Salzig		2011-07-18 22:25:18.837299	2011-07-18 22:25:18.837299	21	Earth:Europe:Germany:Bad Salzig
18	Philippines		2009-05-05 20:53:53.240762	2011-07-18 22:30:19.484071	96	Earth:Asia:Philippines
108	North Korea		2011-12-27 05:08:50.691129	2011-12-27 11:16:30.988191	96	Earth:Asia:North Korea
109	Singapore	Singapura	2011-12-27 11:31:03.880125	2011-12-27 11:31:03.880125	96	Earth:Asia:Singapore
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: peat
--

COPY schema_migrations (version) FROM stdin;
20090426201902
20090426203046
20090426205208
20090426215048
20090427025632
20090429155308
20090510032416
20090513194645
20090513224039
20100110195959
20110620051611
20110620062128
20110621035717
20110718180601
201112270223
\.


--
-- Name: authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY authorities
    ADD CONSTRAINT authorities_pkey PRIMARY KEY (id);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);


--
-- Name: grades_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: masters_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY masters
    ADD CONSTRAINT masters_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: printers_pkey; Type: CONSTRAINT; Schema: public; Owner: peat; Tablespace: 
--

ALTER TABLE ONLY printers
    ADD CONSTRAINT printers_pkey PRIMARY KEY (id);


--
-- Name: index_authorities_on_country_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_authorities_on_country_id ON authorities USING btree (region_id);


--
-- Name: index_authorities_on_name; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_authorities_on_name ON authorities USING btree (name);


--
-- Name: index_countries_on_name; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_countries_on_name ON regions USING btree (name);


--
-- Name: index_currencies_on_authority_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_currencies_on_authority_id ON currencies USING btree (authority_id);


--
-- Name: index_currencies_on_country_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_currencies_on_country_id ON currencies USING btree (region_id);


--
-- Name: index_currencies_on_unit; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_currencies_on_unit ON currencies USING btree (unit);


--
-- Name: index_grades_on_rank; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_grades_on_rank ON grades USING btree (rank);


--
-- Name: index_masters_on_code; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_masters_on_code ON masters USING btree (code);


--
-- Name: index_masters_on_currency_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_masters_on_currency_id ON masters USING btree (currency_id);


--
-- Name: index_masters_on_denomination; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_masters_on_denomination ON masters USING btree (denomination);


--
-- Name: index_masters_on_issued_on; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_masters_on_issued_on ON masters USING btree (issued_on);


--
-- Name: index_masters_on_printer_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_masters_on_printer_id ON masters USING btree (printer_id);


--
-- Name: index_notes_on_grade_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_notes_on_grade_id ON notes USING btree (grade_id);


--
-- Name: index_notes_on_master_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_notes_on_master_id ON notes USING btree (master_id);


--
-- Name: index_notes_on_serial; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_notes_on_serial ON notes USING btree (serial);


--
-- Name: index_printers_on_region_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_printers_on_region_id ON printers USING btree (region_id);


--
-- Name: index_regions_on_ancestry; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_regions_on_ancestry ON regions USING btree (ancestry);


--
-- Name: index_regions_on_parent_id; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE INDEX index_regions_on_parent_id ON regions USING btree (parent_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: peat; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: authorities_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY authorities
    ADD CONSTRAINT authorities_region_id_fkey FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: currencies_authority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY currencies
    ADD CONSTRAINT currencies_authority_id_fkey FOREIGN KEY (authority_id) REFERENCES authorities(id);


--
-- Name: currencies_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY currencies
    ADD CONSTRAINT currencies_region_id_fkey FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: masters_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY masters
    ADD CONSTRAINT masters_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES currencies(id);


--
-- Name: masters_overprint_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY masters
    ADD CONSTRAINT masters_overprint_currency_id_fkey FOREIGN KEY (overprint_currency_id) REFERENCES currencies(id);


--
-- Name: masters_printer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY masters
    ADD CONSTRAINT masters_printer_id_fkey FOREIGN KEY (printer_id) REFERENCES printers(id);


--
-- Name: notes_grade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_grade_id_fkey FOREIGN KEY (grade_id) REFERENCES grades(id);


--
-- Name: notes_master_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_master_id_fkey FOREIGN KEY (master_id) REFERENCES masters(id);


--
-- Name: printers_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY printers
    ADD CONSTRAINT printers_region_id_fkey FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: regions_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: peat
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES regions(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: peat
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM peat;
GRANT ALL ON SCHEMA public TO peat;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

