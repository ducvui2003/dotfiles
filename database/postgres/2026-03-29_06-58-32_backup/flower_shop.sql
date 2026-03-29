--
-- PostgreSQL database dump
--

\restrict 7jXevBAu3YWFfHAKDFDs8cJUfslhaCrYdF9CELu9TVIKMnVBcZac1TAHrHX5blM

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 18.1 (Ubuntu 18.1-1.pgdg24.04+2)

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
-- Name: NavigatorTableRef; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."NavigatorTableRef" AS ENUM (
    'category',
    'page'
);


ALTER TYPE public."NavigatorTableRef" OWNER TO root;

--
-- Name: PageSectionType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PageSectionType" AS ENUM (
    'banner',
    'category_slider',
    'category_product_section'
);


ALTER TYPE public."PageSectionType" OWNER TO root;

--
-- Name: PageType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PageType" AS ENUM (
    'HOME',
    'CATEGORY',
    'ABOUT'
);


ALTER TYPE public."PageType" OWNER TO root;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text DEFAULT 'anonymous'::text NOT NULL,
    slug_registry_id integer NOT NULL,
    thumbnail_id integer,
    slug_placeholder character varying(50) NOT NULL
);


ALTER TABLE public.categories OWNER TO root;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO root;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: medias; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.medias (
    id integer NOT NULL,
    key text NOT NULL,
    alt text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    provider text
);


ALTER TABLE public.medias OWNER TO root;

--
-- Name: medias_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.medias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medias_id_seq OWNER TO root;

--
-- Name: medias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.medias_id_seq OWNED BY public.medias.id;


--
-- Name: navigators; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.navigators (
    id integer NOT NULL,
    parent integer,
    label text NOT NULL,
    ref integer NOT NULL,
    table_ref public."NavigatorTableRef" NOT NULL
);


ALTER TABLE public.navigators OWNER TO root;

--
-- Name: navigators_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.navigators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.navigators_id_seq OWNER TO root;

--
-- Name: navigators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.navigators_id_seq OWNED BY public.navigators.id;


--
-- Name: page_sections; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.page_sections (
    id integer NOT NULL,
    type public."PageSectionType" NOT NULL,
    "position" integer NOT NULL,
    config jsonb NOT NULL,
    is_active boolean DEFAULT false,
    page_id integer NOT NULL
);


ALTER TABLE public.page_sections OWNER TO root;

--
-- Name: page_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.page_sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.page_sections_id_seq OWNER TO root;

--
-- Name: page_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.page_sections_id_seq OWNED BY public.page_sections.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    title text NOT NULL,
    type public."PageType" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    is_deleted boolean DEFAULT false,
    slug_registry_id integer NOT NULL,
    content text DEFAULT '{}'::text NOT NULL,
    metadata jsonb
);


ALTER TABLE public.pages OWNER TO root;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_id_seq OWNER TO root;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.product_categories (
    "productId" integer NOT NULL,
    "categoryId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.product_categories OWNER TO root;

--
-- Name: product_medias; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.product_medias (
    id integer NOT NULL,
    product_id integer NOT NULL,
    media_id integer NOT NULL,
    "isThumbnail" boolean DEFAULT false
);


ALTER TABLE public.product_medias OWNER TO root;

--
-- Name: product_medias_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.product_medias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_medias_id_seq OWNER TO root;

--
-- Name: product_medias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.product_medias_id_seq OWNED BY public.product_medias.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    created_by text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text,
    updated_at timestamp(3) without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_by text,
    deleted_at timestamp(3) without time zone,
    price double precision NOT NULL,
    price_sale double precision NOT NULL,
    slug_registry_id integer NOT NULL,
    slug_placeholder character varying(50) NOT NULL,
    metadata jsonb,
    description text NOT NULL
);


ALTER TABLE public.products OWNER TO root;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO root;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: slug_registries; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.slug_registries (
    id integer NOT NULL,
    slug text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.slug_registries OWNER TO root;

--
-- Name: slug_registries_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.slug_registries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.slug_registries_id_seq OWNER TO root;

--
-- Name: slug_registries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.slug_registries_id_seq OWNED BY public.slug_registries.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text DEFAULT 'anonymous'::text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    created_by text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text,
    updated_at timestamp(3) without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_by text,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.users OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: medias id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.medias ALTER COLUMN id SET DEFAULT nextval('public.medias_id_seq'::regclass);


--
-- Name: navigators id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.navigators ALTER COLUMN id SET DEFAULT nextval('public.navigators_id_seq'::regclass);


--
-- Name: page_sections id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_sections ALTER COLUMN id SET DEFAULT nextval('public.page_sections_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: product_medias id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_medias ALTER COLUMN id SET DEFAULT nextval('public.product_medias_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: slug_registries id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.slug_registries ALTER COLUMN id SET DEFAULT nextval('public.slug_registries_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.categories (id, name, slug_registry_id, thumbnail_id, slug_placeholder) FROM stdin;
1	Hoa Sinh Nhật	6	1	hoa-sinh-nhat
3	Hoa Chúc Mừng	6	1	hoa-chuc-mung
2	Hoa Khai Trương	6	1	hoa-khai-truong
4	Hoa Sinh Nhật Sang Trọng	6	1	hoa-sinh-nhat-sang-trong
5	Hoa Sinh Nhật Giá Rẻ	6	1	hoa-sinh-nhat-gia-re
\.


--
-- Data for Name: medias; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.medias (id, key, alt, metadata, provider) FROM stdin;
8	bo-hoa-hong-mat-nau.jpg	\N	{}	r2
2	slide/slider-02.jpg	hoa-tuoi-nhat-nam	{}	r2
3	slide/slider-03.jpg	hoa-tuoi-nhat-nam	{}	r2
23	bo-hoa-hong-mat-nau-20260201-142439.jpg	\N	{"place": "description"}	r2
1	slide/slider-01.jpg	hoa-tuoi-nhat-nam	{"url": "https://example.com/123.png", "name": "123.png", "size": "123", "type": "image/png"}	r2
\.


--
-- Data for Name: navigators; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.navigators (id, parent, label, ref, table_ref) FROM stdin;
1	\N	Hoa Khai Trương	1	category
2	\N	Hoa Sinh Nhật	2	category
4	1	Hoa Sinh Nhật Sang Trọng	4	category
5	1	Hoa Sinh Nhật Giá Rẻ	5	category
3	\N	Lan Hồ Điệp	7	category
\.


--
-- Data for Name: page_sections; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.page_sections (id, type, "position", config, is_active, page_id) FROM stdin;
1	banner	1	{"mediaIds": [1, 2, 3]}	t	1
4	banner	1	{"mediaIds": [1]}	t	2
2	category_slider	2	{"title": "Danh sách thể loại hoa tươi", "categoryIds": [1, 3, 4]}	t	1
3	category_product_section	3	{"categories": [{"id": 1, "title": "Hoa Tươi", "productIds": [1, 3, 4]}, {"id": 1, "title": "Hoa Tươi 1", "productIds": [1, 3, 4]}]}	t	1
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.pages (id, title, type, created_at, updated_at, is_deleted, slug_registry_id, content, metadata) FROM stdin;
3	Về Chúng Tôi	ABOUT	2026-01-24 16:09:06	2026-02-01 07:50:35.313	f	2	{"time":1769932234761,"version":"2.31.1","blocks":[{"id":"GOGDgSupdF","type":"paragraph","data":{"text":"hello"}},{"id":"vmkGE-igSO","type":"image","data":{"caption":"chung toi","withBorder":true,"withBackground":true,"stretched":false,"file":{"url":"https://s3.leanhduc.id.vn/bo-hoa-hong-mat-nau-20260201-142439.jpg"}}}]}	{"title": "Ve Chung Toi", "metaDescription": "hep"}
2	:category	CATEGORY	2025-11-22 05:04:38.995	\N	f	6	{}	\N
1	Hoa Tươi Nhật Nam	HOME	2025-11-16 15:46:29	2025-11-16 08:47:00.528	f	1	{}	\N
5	Liên Hệ	ABOUT	2026-01-24 21:29:28	2026-01-24 21:29:29	f	7	{}	\N
4	Chính sách	ABOUT	2026-01-24 21:19:05	2026-02-01 01:29:18.524	f	4	{"time":1769909299650,"version":"2.31.1","blocks":[]}	{"title": "Chinh sach", "metaDescription": "Chinh sach"}
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.product_categories ("productId", "categoryId", "createdAt") FROM stdin;
1	1	2025-12-21 11:04:37.444
21	2	2026-01-02 08:14:21.322
2	2	2026-02-21 14:03:54.808
3	2	2026-03-08 03:17:13.073
\.


--
-- Data for Name: product_medias; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.product_medias (id, product_id, media_id, "isThumbnail") FROM stdin;
45	3	1	t
46	1	2	f
47	1	1	f
48	1	3	f
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.products (id, name, created_by, created_at, updated_by, updated_at, is_deleted, deleted_by, deleted_at, price, price_sale, slug_registry_id, slug_placeholder, metadata, description) FROM stdin;
3	Hoa tuoi tham	\N	2025-12-20 02:26:46.532	\N	2026-03-08 03:17:29.504	f	\N	\N	20000	10000	3	hoa-tuoi-tham	{"title": "hoa tuoi tham", "metaDescription": "Image"}	{"time":1767341362032,"version":"2.31.0","blocks":[{"id":"_u76dMuhD6","type":"paragraph","data":{"text":"asdasdas"}}]}
1	sunny2	\N	2025-11-22 12:11:17	duc	2026-03-08 03:22:10.97	f	\N	\N	100000	10000	3	sunny-2	{"title": "sunny-2", "metaDescription": "Image"}	{"time":1767341362032,"version":"2.31.0","blocks":[{"id":"_u76dMuhD6","type":"paragraph","data":{"text":"asdasdas"}}]}
21	Hoa Ghép 	\N	2026-01-02 08:14:21.318	\N	2026-02-01 13:27:37.313	f	\N	\N	100000	50000	3	sunny-111111	{"title": "hoa-ghep", "metaDescription": "hep"}	{"time":1767341362032,"version":"2.31.0","blocks":[{"id":"_u76dMuhD6","type":"paragraph","data":{"text":"asdasdas"}}]}
2	sunny1	\N	2025-12-07 07:59:37.129	\N	2026-02-21 14:03:54.806	f	\N	\N	100000	50000	3	sunny-1	{"title": "sunny 1", "metaDescription": "Image"}	{"time":1767341362032,"version":"2.31.0","blocks":[{"id":"_u76dMuhD6","type":"paragraph","data":{"text":"asdasdas"}}]}
\.


--
-- Data for Name: slug_registries; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.slug_registries (id, slug, created_at, updated_at) FROM stdin;
5	/chu-de	2025-11-16 05:29:30.315	\N
3	/san-pham/:name	2025-11-16 05:28:34.453	\N
6	/:name	2025-11-22 12:14:30	\N
4	/thong-tin/chinh-sach	2025-11-16 05:29:30.315	\N
7	/thong-tin/lien-he	2026-01-24 21:27:10	\N
2	/thong-tin/gioi-thieu	2025-11-16 05:28:34.453	\N
1	/	2025-11-16 05:28:34.453	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, name, email, password, created_by, created_at, updated_by, updated_at, is_deleted, deleted_by, deleted_at) FROM stdin;
1	alice	alice123@example.com	$argon2id$v=19$m=65536,t=3,p=4$L695+f08sLSjWBPXPia1fg$utvD350XJXEWMaM7kr/0z/bOOXUP6bIdui+XfkiQbx4	\N	2025-11-16 08:45:02.37	\N	2025-11-16 08:45:02.37	f	\N	\N
3	Le Anh	ducvui2003@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$YeSogkPKummuU1AIfFks3Q$bznTLEcftET1yaD5O3kiQTp1B5EsmGKIP3Ge/Ee5xB8	\N	2026-03-08 08:14:49.905	\N	2026-03-08 08:14:49.905	f	\N	\N
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, true);


--
-- Name: medias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.medias_id_seq', 23, true);


--
-- Name: navigators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.navigators_id_seq', 1, false);


--
-- Name: page_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.page_sections_id_seq', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.pages_id_seq', 1, true);


--
-- Name: product_medias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.product_medias_id_seq', 48, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.products_id_seq', 22, true);


--
-- Name: slug_registries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.slug_registries_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: medias medias_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.medias
    ADD CONSTRAINT medias_pkey PRIMARY KEY (id);


--
-- Name: navigators navigators_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.navigators
    ADD CONSTRAINT navigators_pkey PRIMARY KEY (id);


--
-- Name: page_sections page_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_sections
    ADD CONSTRAINT page_sections_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY ("productId", "categoryId");


--
-- Name: product_medias product_medias_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_medias
    ADD CONSTRAINT product_medias_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: slug_registries slug_registries_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.slug_registries
    ADD CONSTRAINT slug_registries_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: categories_slug_placeholder_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX categories_slug_placeholder_key ON public.categories USING btree (slug_placeholder);


--
-- Name: page_sections_page_id_position_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX page_sections_page_id_position_key ON public.page_sections USING btree (page_id, "position");


--
-- Name: product_medias_product_id_media_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX product_medias_product_id_media_id_key ON public.product_medias USING btree (product_id, media_id);


--
-- Name: products_slug_placeholder_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX products_slug_placeholder_key ON public.products USING btree (slug_placeholder);


--
-- Name: slug_registries_slug_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX slug_registries_slug_key ON public.slug_registries USING btree (slug);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: categories categories_slug_registry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_registry_id_fkey FOREIGN KEY (slug_registry_id) REFERENCES public.slug_registries(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: categories categories_thumbnail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_thumbnail_id_fkey FOREIGN KEY (thumbnail_id) REFERENCES public.medias(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: page_sections page_sections_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.page_sections
    ADD CONSTRAINT page_sections_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pages pages_slug_registry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_slug_registry_id_fkey FOREIGN KEY (slug_registry_id) REFERENCES public.slug_registries(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: product_categories product_categories_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT "product_categories_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: product_categories product_categories_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT "product_categories_productId_fkey" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: product_medias product_medias_media_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_medias
    ADD CONSTRAINT product_medias_media_id_fkey FOREIGN KEY (media_id) REFERENCES public.medias(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_medias product_medias_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_medias
    ADD CONSTRAINT product_medias_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products products_slug_registry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_registry_id_fkey FOREIGN KEY (slug_registry_id) REFERENCES public.slug_registries(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict 7jXevBAu3YWFfHAKDFDs8cJUfslhaCrYdF9CELu9TVIKMnVBcZac1TAHrHX5blM

