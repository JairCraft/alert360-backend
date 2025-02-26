--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-12 21:43:36

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--



ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16549)
-- Name: aid_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aid_resources (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    category character varying(50) NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.aid_resources OWNER TO emergencia_user;

--
-- TOC entry 218 (class 1259 OID 16554)
-- Name: aid_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aid_resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aid_resources_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 218
-- Name: aid_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aid_resources_id_seq OWNED BY public.aid_resources.id;


--
-- TOC entry 219 (class 1259 OID 16555)
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    state character varying(50) DEFAULT 'Enviada'::character varying,
    description text
);


ALTER TABLE public.alerts OWNER TO emergencia_user;

--
-- TOC entry 220 (class 1259 OID 16562)
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alerts_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 220
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;


--
-- TOC entry 221 (class 1259 OID 16563)
-- Name: api_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_config (
    id integer NOT NULL,
    api_name character varying(100) NOT NULL,
    api_key text NOT NULL,
    description text
);


ALTER TABLE public.api_config OWNER TO emergencia_user;

--
-- TOC entry 222 (class 1259 OID 16568)
-- Name: api_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.api_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.api_config_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 222
-- Name: api_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.api_config_id_seq OWNED BY public.api_config.id;


--
-- TOC entry 223 (class 1259 OID 16569)
-- Name: emergency_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emergency_contact (
    id integer NOT NULL,
    user_id integer NOT NULL,
    contact_user_id integer NOT NULL,
    relation character varying(50),
    state character varying(20) DEFAULT 'Pendiente'::character varying,
    request_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    response_date timestamp without time zone
);


ALTER TABLE public.emergency_contact OWNER TO emergencia_user;

--
-- TOC entry 224 (class 1259 OID 16574)
-- Name: emergency_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emergency_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emergency_contact_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 224
-- Name: emergency_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emergency_contact_id_seq OWNED BY public.emergency_contact.id;


--
-- TOC entry 225 (class 1259 OID 16575)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    alert_id integer NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.locations OWNER TO emergencia_user;

--
-- TOC entry 226 (class 1259 OID 16579)
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 226
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- TOC entry 227 (class 1259 OID 16580)
-- Name: logs_sensors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs_sensors (
    id integer NOT NULL,
    user_id integer NOT NULL,
    sensor_type character varying(50) NOT NULL,
    data jsonb NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs_sensors OWNER TO emergencia_user;

--
-- TOC entry 228 (class 1259 OID 16586)
-- Name: logs_sensors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_sensors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_sensors_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 228
-- Name: logs_sensors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_sensors_id_seq OWNED BY public.logs_sensors.id;


--
-- TOC entry 229 (class 1259 OID 16587)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    notification_type character varying(50) NOT NULL,
    message text NOT NULL,
    send_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    state character varying(50) DEFAULT 'Enviado'::character varying
);


ALTER TABLE public.notifications OWNER TO emergencia_user;

--
-- TOC entry 230 (class 1259 OID 16594)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 230
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- TOC entry 231 (class 1259 OID 16595)
-- Name: user_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_configs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    push_notifications boolean DEFAULT true,
    email_notifications boolean DEFAULT true,
    languaje character varying(10) DEFAULT 'es'::character varying,
    sync_frequency integer DEFAULT 15
);


ALTER TABLE public.user_configs OWNER TO emergencia_user;

--
-- TOC entry 232 (class 1259 OID 16602)
-- Name: user_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_configs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_configs_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 232
-- Name: user_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_configs_id_seq OWNED BY public.user_configs.id;


--
-- TOC entry 233 (class 1259 OID 16603)
-- Name: user_devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_devices (
    id integer NOT NULL,
    user_id integer NOT NULL,
    endpoint_arn text NOT NULL,
    device_id text NOT NULL,
    platform character varying(50) NOT NULL,
    registry_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_devices OWNER TO emergencia_user;

--
-- TOC entry 234 (class 1259 OID 16609)
-- Name: user_devices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_devices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_devices_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 234
-- Name: user_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_devices_id_seq OWNED BY public.user_devices.id;


--
-- TOC entry 235 (class 1259 OID 16610)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(15),
    password text NOT NULL,
    registry_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO emergencia_user;

--
-- TOC entry 236 (class 1259 OID 16616)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO emergencia_user;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 236
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4787 (class 2604 OID 16617)
-- Name: aid_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aid_resources ALTER COLUMN id SET DEFAULT nextval('public.aid_resources_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 16618)
-- Name: alerts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 16619)
-- Name: api_config id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_config ALTER COLUMN id SET DEFAULT nextval('public.api_config_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 16620)
-- Name: emergency_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergency_contact ALTER COLUMN id SET DEFAULT nextval('public.emergency_contact_id_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 16621)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 16622)
-- Name: logs_sensors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_sensors ALTER COLUMN id SET DEFAULT nextval('public.logs_sensors_id_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 16623)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 16624)
-- Name: user_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configs ALTER COLUMN id SET DEFAULT nextval('public.user_configs_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 16625)
-- Name: user_devices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_devices ALTER COLUMN id SET DEFAULT nextval('public.user_devices_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 16626)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4990 (class 0 OID 16549)
-- Dependencies: 217
-- Data for Name: aid_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4992 (class 0 OID 16555)
-- Dependencies: 219
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4994 (class 0 OID 16563)
-- Dependencies: 221
-- Data for Name: api_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4996 (class 0 OID 16569)
-- Dependencies: 223
-- Data for Name: emergency_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4998 (class 0 OID 16575)
-- Dependencies: 225
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5000 (class 0 OID 16580)
-- Dependencies: 227
-- Data for Name: logs_sensors; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5002 (class 0 OID 16587)
-- Dependencies: 229
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5004 (class 0 OID 16595)
-- Dependencies: 231
-- Data for Name: user_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5006 (class 0 OID 16603)
-- Dependencies: 233
-- Data for Name: user_devices; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5008 (class 0 OID 16610)
-- Dependencies: 235
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Jair', 'jair@jair.com', '0980363692', 'jair', '2025-02-01 17:38:22.326588');
INSERT INTO public.users VALUES (2, 'jair', 'jhon@testemail.com', '0980363692', 'jair', '2025-02-01 17:57:32.070989');
INSERT INTO public.users VALUES (7, 'jair', 'jair@testemail.com', '0980363692', 'jair', '2025-02-04 19:25:09.916362');
INSERT INTO public.users VALUES (8, 'jair', 'sex@testemail.com', '0980363692', 'jair', '2025-02-04 19:25:30.443944');
INSERT INTO public.users VALUES (9, 'jair', 'email@fantasticemail.com', '0980363692', 'motocrosS10.', '2025-02-04 19:32:55.277285');
INSERT INTO public.users VALUES (10, 'Name surname', 'nickname@email.com', '09999999', 'Mysecret17.', '2025-02-11 17:44:43.801155');
INSERT INTO public.users VALUES (11, 'Name surname', 'Bruhname@email.com', '09999999', 'Mysecret17.', '2025-02-11 17:46:11.43838');
INSERT INTO public.users VALUES (12, 'Lakdbxñq', 'thebest@email.com', '099999999', 'Lsnfj17.', '2025-02-11 17:54:28.608747');
INSERT INTO public.users VALUES (13, 'Lakdbxñq', 'theboizst@email.com', '099999999', 'Lsnfj17.', '2025-02-11 17:55:26.048942');
INSERT INTO public.users VALUES (14, 'Boiwhathehell', 'nosequeponer@email.com', '099999999', 'Moto182....', '2025-02-11 17:57:29.764193');
INSERT INTO public.users VALUES (15, 'Boiwhathehell', 'nosequeoner@email.com', '099999999', 'Moto182....', '2025-02-11 17:59:04.484153');
INSERT INTO public.users VALUES (16, 'Boiwhathehell', 'osequeoner@email.com', '099999999', 'Moto182....', '2025-02-11 17:59:17.515079');
INSERT INTO public.users VALUES (17, 'Boiwhathehell', 'equeoner@email.com', '099999999', 'Moto182....', '2025-02-11 17:59:47.95936');
INSERT INTO public.users VALUES (18, 'Boiwhathehell', 'Aequeoner@email.com', '099999999', 'Moto182....', '2025-02-11 18:00:27.192623');
INSERT INTO public.users VALUES (19, 'Boiwhathehell', 'Bequeoner@email.com', '099999999', 'Moto182....', '2025-02-11 18:00:54.003403');
INSERT INTO public.users VALUES (20, 'Boiwhathehell', 'Cqueoner@email.com', '099999999', 'Moto182....', '2025-02-11 18:01:21.281202');
INSERT INTO public.users VALUES (21, 'Boiwhathehell', 'Dqueoner@email.com', '099999999', 'Moto182....', '2025-02-11 18:03:50.69493');
INSERT INTO public.users VALUES (24, 'jair', 'email@boiwahthtehjkl.com', '0980363692', 'motocrosS10.', '2025-02-11 21:21:28.935436');
INSERT INTO public.users VALUES (28, 'Jair Guanotoa', 'jairguanotoa@hotmail.com', '0980363692', 'motocrosS10.', '2025-02-11 21:35:56.836694');
INSERT INTO public.users VALUES (29, 'Boiwhat', 'kalfbdla@kald.com', '099999999', 'Moaj17.lapd', '2025-02-11 22:33:03.351707');
INSERT INTO public.users VALUES (30, 'Boiwhathehel', 'Laajdk@bfpsod.com', '099999999', 'Mapfj18y..', '2025-02-11 22:33:40.393904');


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 218
-- Name: aid_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aid_resources_id_seq', 1, false);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 220
-- Name: alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alerts_id_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 222
-- Name: api_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.api_config_id_seq', 1, false);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 224
-- Name: emergency_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emergency_contact_id_seq', 1, false);


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 226
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, false);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 228
-- Name: logs_sensors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_sensors_id_seq', 1, false);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 230
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 232
-- Name: user_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_configs_id_seq', 1, false);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 234
-- Name: user_devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_devices_id_seq', 1, false);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 236
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 30, true);


--
-- TOC entry 4812 (class 2606 OID 16628)
-- Name: aid_resources aid_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aid_resources
    ADD CONSTRAINT aid_resources_pkey PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 16630)
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- TOC entry 4817 (class 2606 OID 16632)
-- Name: api_config api_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_config
    ADD CONSTRAINT api_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4819 (class 2606 OID 16634)
-- Name: emergency_contact emergency_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergency_contact
    ADD CONSTRAINT emergency_contact_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 16636)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4826 (class 2606 OID 16638)
-- Name: logs_sensors logs_sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_sensors
    ADD CONSTRAINT logs_sensors_pkey PRIMARY KEY (id);


--
-- TOC entry 4828 (class 2606 OID 16640)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4830 (class 2606 OID 16642)
-- Name: user_configs user_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configs
    ADD CONSTRAINT user_configs_pkey PRIMARY KEY (id);


--
-- TOC entry 4832 (class 2606 OID 16644)
-- Name: user_devices user_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_devices
    ADD CONSTRAINT user_devices_pkey PRIMARY KEY (id);


--
-- TOC entry 4834 (class 2606 OID 16646)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4836 (class 2606 OID 16648)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4815 (class 1259 OID 16649)
-- Name: idx_alerts_users; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_alerts_users ON public.alerts USING btree (user_id);


--
-- TOC entry 4820 (class 1259 OID 16650)
-- Name: idx_contacts_users; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_contacts_users ON public.emergency_contact USING btree (user_id);


--
-- TOC entry 4821 (class 1259 OID 16651)
-- Name: idx_location_alert; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_location_alert ON public.locations USING btree (alert_id);


--
-- TOC entry 4824 (class 1259 OID 16652)
-- Name: idx_logs_sensrs_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logs_sensrs_user ON public.logs_sensors USING btree (user_id);


--
-- TOC entry 4837 (class 2606 OID 16653)
-- Name: alerts alerts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4838 (class 2606 OID 16658)
-- Name: emergency_contact emergency_contact_contact_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergency_contact
    ADD CONSTRAINT emergency_contact_contact_user_id_fkey FOREIGN KEY (contact_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4839 (class 2606 OID 16663)
-- Name: emergency_contact emergency_contact_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emergency_contact
    ADD CONSTRAINT emergency_contact_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4840 (class 2606 OID 16668)
-- Name: locations locations_alert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_alert_id_fkey FOREIGN KEY (alert_id) REFERENCES public.alerts(id) ON DELETE CASCADE;


--
-- TOC entry 4841 (class 2606 OID 16673)
-- Name: logs_sensors logs_sensors_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_sensors
    ADD CONSTRAINT logs_sensors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4842 (class 2606 OID 16678)
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4843 (class 2606 OID 16683)
-- Name: user_configs user_configs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_configs
    ADD CONSTRAINT user_configs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4844 (class 2606 OID 16688)
-- Name: user_devices user_devices_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_devices
    ADD CONSTRAINT user_devices_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-02-12 21:43:36

--
-- PostgreSQL database dump complete
--

