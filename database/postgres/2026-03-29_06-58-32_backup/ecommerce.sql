--
-- PostgreSQL database dump
--

\restrict bgCCaUbCDABe0DYs3GsWXxCU2qk1DYTzkHcTg784LTcJn5q4BQdVRAi2fDYdE0f

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: root
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO root;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: root
--

COMMENT ON SCHEMA public IS '';


--
-- Name: CustomerStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."CustomerStatus" AS ENUM (
    'PENDING',
    'RESOLVED',
    'REJECTED'
);


ALTER TYPE public."CustomerStatus" OWNER TO root;

--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'PENDING',
    'PAID',
    'DELIVERING',
    'CANCELED',
    'COMPLETE'
);


ALTER TYPE public."OrderStatus" OWNER TO root;

--
-- Name: PaymentProvider; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PaymentProvider" AS ENUM (
    'VNPAY',
    'SEPAY'
);


ALTER TYPE public."PaymentProvider" OWNER TO root;

--
-- Name: PaymentStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PaymentStatus" AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED'
);


ALTER TYPE public."PaymentStatus" OWNER TO root;

--
-- Name: UserStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."UserStatus" AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'BLOCKED'
);


ALTER TYPE public."UserStatus" OWNER TO root;

--
-- Name: available_status; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public.available_status AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public.available_status OWNER TO root;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: CommentLike; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."CommentLike" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "commentId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CommentLike" OWNER TO root;

--
-- Name: CommentLike_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."CommentLike_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CommentLike_id_seq" OWNER TO root;

--
-- Name: CommentLike_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."CommentLike_id_seq" OWNED BY public."CommentLike".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO root;

--
-- Name: abouts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.abouts (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    status public.available_status DEFAULT 'ACTIVE'::public.available_status NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.abouts OWNER TO root;

--
-- Name: abouts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.abouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.abouts_id_seq OWNER TO root;

--
-- Name: abouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.abouts_id_seq OWNED BY public.abouts.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    detail text NOT NULL,
    ward text NOT NULL,
    district text NOT NULL,
    province text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.addresses OWNER TO root;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_seq OWNER TO root;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.cart_items (
    id text NOT NULL,
    product_id integer NOT NULL,
    cart_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    option_id integer,
    quantity integer DEFAULT 1 NOT NULL,
    selected boolean DEFAULT true NOT NULL
);


ALTER TABLE public.cart_items OWNER TO root;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.carts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.carts OWNER TO root;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.carts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO root;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL,
    status public.available_status DEFAULT 'INACTIVE'::public.available_status NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
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
-- Name: comments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.comments (
    id text NOT NULL,
    parent_id text,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone,
    content text NOT NULL,
    "like" integer NOT NULL
);


ALTER TABLE public.comments OWNER TO root;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    title text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    name text NOT NULL,
    message text NOT NULL,
    status public."CustomerStatus" DEFAULT 'PENDING'::public."CustomerStatus" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.contacts OWNER TO root;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO root;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.faqs (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    status public.available_status DEFAULT 'ACTIVE'::public.available_status NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.faqs OWNER TO root;

--
-- Name: faqs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.faqs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faqs_id_seq OWNER TO root;

--
-- Name: faqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.faqs_id_seq OWNED BY public.faqs.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    status public.available_status DEFAULT 'ACTIVE'::public.available_status NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.notifications OWNER TO root;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO root;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.options (
    id integer NOT NULL,
    name text NOT NULL,
    price numeric(65,30) NOT NULL,
    stock integer DEFAULT 0,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone,
    product_id integer NOT NULL,
    resource_id integer
);


ALTER TABLE public.options OWNER TO root;

--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_id_seq OWNER TO root;

--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric(65,30) NOT NULL,
    order_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    product jsonb NOT NULL
);


ALTER TABLE public.order_items OWNER TO root;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO root;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    fee_shipping numeric(10,2) NOT NULL,
    status public."OrderStatus" DEFAULT 'PENDING'::public."OrderStatus" NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    receiver jsonb NOT NULL
);


ALTER TABLE public.orders OWNER TO root;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO root;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.payment (
    id integer NOT NULL,
    order_id integer,
    status public."PaymentStatus" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    provider public."PaymentProvider" NOT NULL
);


ALTER TABLE public.payment OWNER TO root;

--
-- Name: payment_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_id_seq OWNER TO root;

--
-- Name: payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;


--
-- Name: payment_transaction; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.payment_transaction (
    id integer NOT NULL,
    payment_id integer,
    amount numeric(20,2) NOT NULL,
    payload jsonb NOT NULL,
    provider_payment_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.payment_transaction OWNER TO root;

--
-- Name: payment_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.payment_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_transaction_id_seq OWNER TO root;

--
-- Name: payment_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.payment_transaction_id_seq OWNED BY public.payment_transaction.id;


--
-- Name: policies; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.policies (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    status public.available_status DEFAULT 'ACTIVE'::public.available_status NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.policies OWNER TO root;

--
-- Name: policies_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.policies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.policies_id_seq OWNER TO root;

--
-- Name: policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.policies_id_seq OWNED BY public.policies.id;


--
-- Name: product_resources; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.product_resources (
    product_id integer NOT NULL,
    resource_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.product_resources OWNER TO root;

--
-- Name: products; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    base_price numeric(10,2) NOT NULL,
    sale_price numeric(10,2),
    category_id integer NOT NULL,
    supplier_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    thumbnail_id integer,
    views integer DEFAULT 0 NOT NULL,
    is_deleted boolean DEFAULT false
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
-- Name: promotion_order_items; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.promotion_order_items (
    id integer NOT NULL,
    promotion_id integer NOT NULL,
    order_item_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.promotion_order_items OWNER TO root;

--
-- Name: promotion_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.promotion_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotion_order_items_id_seq OWNER TO root;

--
-- Name: promotion_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.promotion_order_items_id_seq OWNED BY public.promotion_order_items.id;


--
-- Name: promotion_orders; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.promotion_orders (
    id integer NOT NULL,
    promotion_id integer NOT NULL,
    order_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.promotion_orders OWNER TO root;

--
-- Name: promotion_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.promotion_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotion_orders_id_seq OWNER TO root;

--
-- Name: promotion_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.promotion_orders_id_seq OWNED BY public.promotion_orders.id;


--
-- Name: promotions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.promotions (
    id integer NOT NULL,
    code text NOT NULL,
    description text NOT NULL,
    percent numeric(65,30) NOT NULL,
    map_amount numeric(65,30) NOT NULL,
    start_date timestamp(3) without time zone NOT NULL,
    end_date timestamp(3) without time zone NOT NULL,
    usage_limit integer NOT NULL,
    status public.available_status DEFAULT 'ACTIVE'::public.available_status NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.promotions OWNER TO root;

--
-- Name: promotions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.promotions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotions_id_seq OWNER TO root;

--
-- Name: promotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.promotions_id_seq OWNED BY public.promotions.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    public_id text NOT NULL,
    type text NOT NULL,
    format text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.resources OWNER TO root;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resources_id_seq OWNER TO root;

--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    content text NOT NULL,
    rating integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone,
    order_item_id integer NOT NULL,
    response text
);


ALTER TABLE public.reviews OWNER TO root;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO root;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.roles OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    country text NOT NULL,
    website text NOT NULL,
    status public.available_status DEFAULT 'INACTIVE'::public.available_status NOT NULL,
    address_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
    deleted_at timestamp(3) without time zone
);


ALTER TABLE public.suppliers OWNER TO root;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO root;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    name text DEFAULT ''::text,
    password character varying(255) NOT NULL,
    phone text DEFAULT ''::text,
    avatar text DEFAULT ''::text,
    status public."UserStatus" DEFAULT 'INACTIVE'::public."UserStatus" NOT NULL,
    dob date,
    role_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone,
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
-- Name: wishlists; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wishlists (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.wishlists OWNER TO root;

--
-- Name: wishlists_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wishlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wishlists_id_seq OWNER TO root;

--
-- Name: wishlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wishlists_id_seq OWNED BY public.wishlists.id;


--
-- Name: CommentLike id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."CommentLike" ALTER COLUMN id SET DEFAULT nextval('public."CommentLike_id_seq"'::regclass);


--
-- Name: abouts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.abouts ALTER COLUMN id SET DEFAULT nextval('public.abouts_id_seq'::regclass);


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: faqs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.faqs ALTER COLUMN id SET DEFAULT nextval('public.faqs_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: options id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payment id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.payment ALTER COLUMN id SET DEFAULT nextval('public.payment_id_seq'::regclass);


--
-- Name: payment_transaction id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.payment_transaction ALTER COLUMN id SET DEFAULT nextval('public.payment_transaction_id_seq'::regclass);


--
-- Name: policies id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.policies ALTER COLUMN id SET DEFAULT nextval('public.policies_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: promotion_order_items id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_order_items ALTER COLUMN id SET DEFAULT nextval('public.promotion_order_items_id_seq'::regclass);


--
-- Name: promotion_orders id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_orders ALTER COLUMN id SET DEFAULT nextval('public.promotion_orders_id_seq'::regclass);


--
-- Name: promotions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotions ALTER COLUMN id SET DEFAULT nextval('public.promotions_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: wishlists id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wishlists ALTER COLUMN id SET DEFAULT nextval('public.wishlists_id_seq'::regclass);


--
-- Data for Name: CommentLike; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."CommentLike" (id, "userId", "commentId", "createdAt") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
15ecd06b-39dc-46ef-b70a-2c87095cd197	4869595b20b932734170e72fec889ed77fb6d39dbe5e0477edf95cb4c9052f1d	2025-06-18 02:04:17.882711+00	20250523110350_remove_payment_id_order	\N	\N	2025-06-18 02:04:17.879026+00	1
95896b86-0890-4c7b-9eb1-edb06badb750	df03d2a45935cf825cfb62c2e99791b53ada24825319d6bb2a3b54b8cc611f02	2025-06-18 02:04:17.812723+00	20250501102044_init_database	\N	\N	2025-06-18 02:04:17.765679+00	1
c0f448b6-194e-4b91-8c43-417b0fc54487	8564b21f3985740d69fcf4b93afaa0849dde7a43af87d9645fb514be2c80b028	2025-06-18 02:04:17.818128+00	20250514012744_product_bigint_into_decimal_price	\N	\N	2025-06-18 02:04:17.813914+00	1
0aad9a87-2dfc-4c58-b7ca-79ed78f21276	8db6b2321d309c4d4d7ffeb75a1526d3d1decc7df1e0cab0e38c3794814c205c	2025-06-18 02:04:17.929524+00	20250531115939_change_column_in_comment	\N	\N	2025-06-18 02:04:17.924732+00	1
0465d081-ecb2-4d1d-843e-0325ec272c11	f118d7add70ba0f31b5107b083ec7bb9df8f8d31d7ad2cdf4f189898ebdbce5a	2025-06-18 02:04:17.82592+00	20250514034040_price_numeric_product	\N	\N	2025-06-18 02:04:17.819485+00	1
ef1d4712-9ac0-4b53-bfd2-b6e51cba17ac	0ea04267951b2abd45cd593081c700e219974df63d7254d2522dbc036102f882	2025-06-18 02:04:17.888634+00	20250527165946_remove_delivered_order_status	\N	\N	2025-06-18 02:04:17.883909+00	1
54daadee-6e82-4ef9-9bc9-71232acb88b4	a565756f7415239fd3e58e3625a935d2c6e5548a6470c646b00c8f1fcf14096a	2025-06-18 02:04:17.83224+00	20250515064751_merge_volumn_option_product	\N	\N	2025-06-18 02:04:17.827157+00	1
f0021792-a054-440a-8312-d1fdca76478a	5c6bcd8e4c8cbf93b8e001bc4601f767a0a5880a24d378fece8dc1634cc278e5	2025-06-18 02:04:17.837257+00	20250515071032_rename_option_field	\N	\N	2025-06-18 02:04:17.833063+00	1
e53d0af7-d70d-49ce-9b6b-0728f5e00e27	380ed07db77e59552ebee5595f87ec761e3dd20363563c18f159ea85b4bc2785	2025-06-18 02:04:17.844174+00	20250516085440_option_remove_value_price_bigint_decimal	\N	\N	2025-06-18 02:04:17.838412+00	1
adcbd3d7-5078-4c12-8c7a-fff79e57a0ca	ab7eca176bd097a9611e8d484342818ceb08403c3186da14bc0a3585d026c92a	2025-06-18 02:04:17.894554+00	20250527170134_remove_delivered_order_status_2	\N	\N	2025-06-18 02:04:17.889793+00	1
9669b2ef-812f-4883-bb05-abd909081b94	81dc12fbf33dbd291885afbbe51d0d0906a94b04b2e7f8c1be146d090604d9db	2025-06-18 02:04:17.852006+00	20250516154253_change_cart	\N	\N	2025-06-18 02:04:17.845408+00	1
8bc36320-9eb0-4f74-a881-eb36e48ea6a3	15f20c6d19b3917fdf8260d5b3eb93ea920c213f729cbd068b1764959a2a5e12	2025-06-18 02:04:17.856927+00	20250516154409_rename_create_at	\N	\N	2025-06-18 02:04:17.853259+00	1
f85fe0e6-1a83-45e2-973a-4eab66daabad	65c9aeb191174e5a1ffcfe59078bae57869d52e0ad10cca4c8f519b8fe9006cd	2025-06-18 02:04:17.861351+00	20250516160851_rename_resource_option	\N	\N	2025-06-18 02:04:17.857693+00	1
c65173eb-9030-47ed-8769-ee9e73231bc8	74cd61111c91b2872dc2c862f58504bdb52edbf3f76a81bf667b8e2702e3703a	2025-06-18 02:04:17.9008+00	20250528023127_rename_customer_service_to_contact	\N	\N	2025-06-18 02:04:17.895629+00	1
a3c087bf-1f81-4eac-a31a-d8d1de9b3853	a73cde307c6a24ac58193bb479ac1c7dc294933f602c8f57ad858b897656b6ec	2025-06-18 02:04:17.866829+00	20250522034931_modified_cart_item	\N	\N	2025-06-18 02:04:17.862539+00	1
a2e0dbff-1a80-4577-9c1c-04f38b1189d7	981ca9635b21645d77ef6230ba5a3a9f96d68bfdcf1c2183775c50619c0ed4a3	2025-06-18 02:04:17.873663+00	20250522112911_collect_data_provider_payment_to_json	\N	\N	2025-06-18 02:04:17.868138+00	1
5cb27032-ec4c-48a0-a796-dc45c5586058	062e510550b391c11c08d0dbaa1b5b4772fd89e4cfa07f688b00a2d084ee4930	2025-06-18 02:04:17.934752+00	20250601060235_create_table_comment_like	\N	\N	2025-06-18 02:04:17.930445+00	1
6f4c900a-ef76-4022-816c-f1507c8dbf44	0ce506bfca6a024c0c97e1d8523dc169f3ab9bf1cb9160f5088d81e3cd48fa96	2025-06-18 02:04:17.8778+00	20250523034708_remove_provider_payment_transaction	\N	\N	2025-06-18 02:04:17.874878+00	1
ce4db6d3-56ec-4542-85bb-98d134bdff23	3af6685bed4a77de840b19977e372d50b8e64424fbe8fe3a94306dfa9c58806b	2025-06-18 02:04:17.905754+00	20250528164134_add_thumbnail_table_product	\N	\N	2025-06-18 02:04:17.901981+00	1
679bb5de-5a90-4800-bbb4-87fd984ec46f	2c63a1f60315ca4bb070522c5e437e9bf502a6cfa36f5e7691c7e36ca29ca12a	2025-06-18 02:04:17.958639+00	20250615072555_remove_update_at_and_delete_at_in_wishlist	\N	\N	2025-06-18 02:04:17.955627+00	1
a8df2b06-3b00-44a4-8547-cc4225e86e9b	d8bb9d5855a35b9b60115e58c6e1eeda0184928795bc554930f18a1d0dc3dc4c	2025-06-18 02:04:17.911707+00	20250528164609_remove_resource_id_table_product	\N	\N	2025-06-18 02:04:17.906945+00	1
fbd4d475-ede1-4e8c-b8e8-5fcb1dc39009	d9e2886dda014317ef16b712d59a5a894477c14ab3fb4dab207a621121919cfc	2025-06-18 02:04:17.940105+00	20250601141042_add_cascade_to_order_items	\N	\N	2025-06-18 02:04:17.935954+00	1
5a762ef1-0425-4d8d-8a13-d05f43bbb2cf	12c4cc181429a1c1f41480f669e4fac60818dc4868cae07465b4fa2705f47abd	2025-06-18 02:04:17.916987+00	20250529014900_set_thumbnail_product_from_resource	\N	\N	2025-06-18 02:04:17.91248+00	1
a220c7cb-9812-49c3-bc45-045fd8b01c7d	e80975fcae54d563a4984f403947c445a8639cca1f95ce4a29197d871bf47e19	2025-06-18 02:04:17.923569+00	20250531115747_change_id_comment_to_uuid	\N	\N	2025-06-18 02:04:17.918128+00	1
41d2fac7-6dc2-4881-9f3b-3d650b3febe9	9066f0283dc7c33b37aa520393e5305743dddbc7600fac0249b9eb07889fb2c2	2025-06-18 02:04:17.945303+00	20250601141233_add_cascade_to_order_items	\N	\N	2025-06-18 02:04:17.940986+00	1
81c6c2b7-e2c9-41dc-a6e2-380dc408275d	38c63f811952ce653fa21e0c0672ae92e0ddd360314b95a19623b9baed100806	2025-06-18 02:04:17.963189+00	20250615074207_unique_user_id_product_id_in_wishlist	\N	\N	2025-06-18 02:04:17.95989+00	1
5110266d-a820-4f30-a17f-ff6d966a58ec	815a470d87de5a92b8aae4010fc55190104f70d94cfd762eb1d15d189dfb5c19	2025-06-18 02:04:17.949637+00	20250601141432_order_delete_nullify_payment	\N	\N	2025-06-18 02:04:17.946084+00	1
0d13bfdc-20c1-4843-add0-a58283ddb67a	fea4f1419f21c8dade4a3d8028b20b2c7e3ef7bf81ef343339b0271d7b406a24	2025-06-18 02:04:17.954464+00	20250609162625_add_view_column_in_product_table	\N	\N	2025-06-18 02:04:17.950865+00	1
71d5b5f3-6ee4-48c9-af13-7a189f40e054	5e07ed628458ed1e1400e4c30e61f9ee0fa64f77ba6687f1c6c66292f13f3b8c	2025-06-18 02:04:17.972102+00	20250618015455_add_casade_product	\N	\N	2025-06-18 02:04:17.964345+00	1
83a19801-5bae-439c-b3bf-13bf1fe939e1	4869595b20b932734170e72fec889ed77fb6d39dbe5e0477edf95cb4c9052f1d	2025-05-29 01:46:37.642401+00	20250523110350_remove_payment_id_order	\N	\N	2025-05-29 01:46:37.639089+00	1
19c260ad-86a8-4e6d-8c08-8f5dc4079e6b	df03d2a45935cf825cfb62c2e99791b53ada24825319d6bb2a3b54b8cc611f02	2025-05-29 01:46:37.568977+00	20250501102044_init_database	\N	\N	2025-05-29 01:46:37.515014+00	1
8479f7fc-12e5-4669-ab09-0e17a430a6cf	8564b21f3985740d69fcf4b93afaa0849dde7a43af87d9645fb514be2c80b028	2025-05-29 01:46:37.575153+00	20250514012744_product_bigint_into_decimal_price	\N	\N	2025-05-29 01:46:37.570425+00	1
0a3ed992-43d9-42b5-b975-56a8028f1f9a	d9e2886dda014317ef16b712d59a5a894477c14ab3fb4dab207a621121919cfc	2025-06-01 14:10:42.886587+00	20250601141042_add_cascade_to_order_items	\N	\N	2025-06-01 14:10:42.878994+00	1
b874bd31-6de0-4386-beb3-4e002b8240d2	f118d7add70ba0f31b5107b083ec7bb9df8f8d31d7ad2cdf4f189898ebdbce5a	2025-05-29 01:46:37.583397+00	20250514034040_price_numeric_product	\N	\N	2025-05-29 01:46:37.576449+00	1
9bf15876-1084-468f-b8f6-6d59f2b1fde0	0ea04267951b2abd45cd593081c700e219974df63d7254d2522dbc036102f882	2025-05-29 01:46:37.648324+00	20250527165946_remove_delivered_order_status	\N	\N	2025-05-29 01:46:37.643513+00	1
e6502222-b2f0-41d1-a7cc-d272c8131c65	a565756f7415239fd3e58e3625a935d2c6e5548a6470c646b00c8f1fcf14096a	2025-05-29 01:46:37.591063+00	20250515064751_merge_volumn_option_product	\N	\N	2025-05-29 01:46:37.584602+00	1
01a0c39a-3aa7-470d-b418-4d0957188060	5c6bcd8e4c8cbf93b8e001bc4601f767a0a5880a24d378fece8dc1634cc278e5	2025-05-29 01:46:37.597682+00	20250515071032_rename_option_field	\N	\N	2025-05-29 01:46:37.592469+00	1
d3d77b0b-f106-4519-8e0c-5b9000a21680	380ed07db77e59552ebee5595f87ec761e3dd20363563c18f159ea85b4bc2785	2025-05-29 01:46:37.603111+00	20250516085440_option_remove_value_price_bigint_decimal	\N	\N	2025-05-29 01:46:37.598493+00	1
f959b6de-6ad7-4b9e-8531-a29c4e9ce76c	ab7eca176bd097a9611e8d484342818ceb08403c3186da14bc0a3585d026c92a	2025-05-29 01:46:37.654356+00	20250527170134_remove_delivered_order_status_2	\N	\N	2025-05-29 01:46:37.649168+00	1
8a8a357f-2945-417a-b9b4-de4a609ffae9	81dc12fbf33dbd291885afbbe51d0d0906a94b04b2e7f8c1be146d090604d9db	2025-05-29 01:46:37.612938+00	20250516154253_change_cart	\N	\N	2025-05-29 01:46:37.604003+00	1
17d421bc-f54e-469f-bf33-80a74a86b6dd	15f20c6d19b3917fdf8260d5b3eb93ea920c213f729cbd068b1764959a2a5e12	2025-05-29 01:46:37.616993+00	20250516154409_rename_create_at	\N	\N	2025-05-29 01:46:37.613909+00	1
1004e3fa-988d-403d-8770-3a5b5d538921	65c9aeb191174e5a1ffcfe59078bae57869d52e0ad10cca4c8f519b8fe9006cd	2025-05-29 01:46:37.622677+00	20250516160851_rename_resource_option	\N	\N	2025-05-29 01:46:37.618193+00	1
c3c066ed-b4cd-40de-ac6e-606f17410237	74cd61111c91b2872dc2c862f58504bdb52edbf3f76a81bf667b8e2702e3703a	2025-05-29 01:46:37.660827+00	20250528023127_rename_customer_service_to_contact	\N	\N	2025-05-29 01:46:37.65546+00	1
56c81a57-8d56-449e-b68e-52a5a9733866	a73cde307c6a24ac58193bb479ac1c7dc294933f602c8f57ad858b897656b6ec	2025-05-29 01:46:37.627982+00	20250522034931_modified_cart_item	\N	\N	2025-05-29 01:46:37.623873+00	1
05e88002-44dc-452d-8818-d333b6b9a851	981ca9635b21645d77ef6230ba5a3a9f96d68bfdcf1c2183775c50619c0ed4a3	2025-05-29 01:46:37.633816+00	20250522112911_collect_data_provider_payment_to_json	\N	\N	2025-05-29 01:46:37.62883+00	1
8c7c21e6-0451-44ba-90d2-d7fb23ff4a39	9066f0283dc7c33b37aa520393e5305743dddbc7600fac0249b9eb07889fb2c2	2025-06-01 14:12:33.685784+00	20250601141233_add_cascade_to_order_items	\N	\N	2025-06-01 14:12:33.680979+00	1
fe2fdb1e-6bac-4952-9fe9-382cd7d9d710	0ce506bfca6a024c0c97e1d8523dc169f3ab9bf1cb9160f5088d81e3cd48fa96	2025-05-29 01:46:37.638252+00	20250523034708_remove_provider_payment_transaction	\N	\N	2025-05-29 01:46:37.634688+00	1
fea2df7f-6b27-49d9-8b95-c7dfe9066d3a	3af6685bed4a77de840b19977e372d50b8e64424fbe8fe3a94306dfa9c58806b	2025-05-29 01:46:37.666271+00	20250528164134_add_thumbnail_table_product	\N	\N	2025-05-29 01:46:37.662197+00	1
abc54acc-b0aa-42d1-bd0b-1c4f9092bf2e	fea4f1419f21c8dade4a3d8028b20b2c7e3ef7bf81ef343339b0271d7b406a24	2025-06-12 04:02:31.799811+00	20250609162625_add_view_column_in_product_table	\N	\N	2025-06-12 04:02:31.795352+00	1
75dc2c8a-4c55-476a-904e-ddac78289b8f	d8bb9d5855a35b9b60115e58c6e1eeda0184928795bc554930f18a1d0dc3dc4c	2025-05-29 01:46:37.671126+00	20250528164609_remove_resource_id_table_product	\N	\N	2025-05-29 01:46:37.667023+00	1
89d06e55-cc83-46ba-8776-d958b99c77e5	815a470d87de5a92b8aae4010fc55190104f70d94cfd762eb1d15d189dfb5c19	2025-06-01 14:14:32.418618+00	20250601141432_order_delete_nullify_payment	\N	\N	2025-06-01 14:14:32.414694+00	1
9f8485f7-5a75-4bac-8b0c-50fc1130995b	12c4cc181429a1c1f41480f669e4fac60818dc4868cae07465b4fa2705f47abd	2025-05-29 01:57:31.539414+00	20250529014900_set_thumbnail_product_from_resource	\N	\N	2025-05-29 01:57:31.533039+00	1
57a4fff9-2846-4b7a-ae4f-a721d1bf0911	e80975fcae54d563a4984f403947c445a8639cca1f95ce4a29197d871bf47e19	2025-06-07 10:10:02.184928+00	20250531115747_change_id_comment_to_uuid	\N	\N	2025-06-07 10:10:02.174219+00	1
9ea008f3-da2e-4484-9793-9279f9c80a26	2c63a1f60315ca4bb070522c5e437e9bf502a6cfa36f5e7691c7e36ca29ca12a	2025-06-15 07:41:35.043896+00	20250615072555_remove_update_at_and_delete_at_in_wishlist	\N	\N	2025-06-15 07:41:35.038678+00	1
395da276-11af-4b9d-ab98-3d5172ca03a4	8db6b2321d309c4d4d7ffeb75a1526d3d1decc7df1e0cab0e38c3794814c205c	2025-06-07 10:10:02.189873+00	20250531115939_change_column_in_comment	\N	\N	2025-06-07 10:10:02.185674+00	1
b5082787-d578-4333-b04d-273820a67050	062e510550b391c11c08d0dbaa1b5b4772fd89e4cfa07f688b00a2d084ee4930	2025-06-07 10:10:02.196726+00	20250601060235_create_table_comment_like	\N	\N	2025-06-07 10:10:02.191062+00	1
80a9097f-117f-4a38-9913-b43a0918669b	482911f26945225ca587f0879b9cdf655dfc1ecdd7fea7841dd63ff526fee51e	2025-06-18 02:28:30.492099+00	20250618022824_deleted_at_to_is_deleted_product	\N	\N	2025-06-18 02:28:30.489346+00	1
6a0b9ca9-d713-45f5-be42-9ecca326830d	d2a271498488d4937e444945813339729b278eb8eda83ad68c9ddc0fec00eb7a	2025-06-20 04:52:27.418173+00	20250614095903_add_order_item_column	\N	\N	2025-06-20 04:52:27.409814+00	1
5e733436-5e5f-4ecd-b409-0a4e50754d7b	d1d938ca919b060fb181434efadb47ddab2180d5159bdb15c2fe9d9d3290010a	2025-06-20 04:52:27.42188+00	20250616233805_add_response_column	\N	\N	2025-06-20 04:52:27.418956+00	1
b95bd9cd-dd10-46c7-9313-7dab3e29e485	0ce907b715f9bff9bb2dc4964cc62266a4c900bf97f8634ed3014308e188526e	2025-06-20 04:52:27.426253+00	20250619043516_add_unique_item_id_oder_item_id	\N	\N	2025-06-20 04:52:27.422692+00	1
22ab8504-4b36-451b-bef7-dafc22ab9302	7e30df0e434d5168726e553ef5f1dfb037767c49efe743861493e0a8fbd7edec	2025-06-21 07:29:55.144104+00	20250621072946_nullable_sale_price_product	\N	\N	2025-06-21 07:29:55.141237+00	1
\.


--
-- Data for Name: abouts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.abouts (id, title, content, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.addresses (id, detail, ward, district, province, user_id, created_at, updated_at, deleted_at) FROM stdin;
4	12 Nguyễn Huệ	Phường Bến Nghé	Quận 1	Hồ Chí Minh	1	2025-04-27 04:06:30.566	2025-04-27 04:06:30.566	\N
5	35 Xuân Thủy	Phường Thảo Điền	Quận 2	Hồ Chí Minh	1	2025-04-27 04:06:30.566	2025-04-27 04:06:30.566	\N
6	102 Hai Bà Trưng	Phường Tân Định	Quận 1	Hồ Chí Minh	1	2025-04-27 04:06:30.566	2025-04-27 04:06:30.566	\N
7	45 Bạch Đằng	Phường 2	Quận Tân Bình	Hồ Chí Minh	1	2025-04-27 04:11:13.111	\N	\N
8	65 Phan Bội Châu	Phường 4	Quận Tân Phú	Hồ Chí Minh	1	2025-04-27 04:13:42.397	\N	\N
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.cart_items (id, product_id, cart_id, created_at, updated_at, option_id, quantity, selected) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
2	1	2025-05-22 03:51:24.949	2025-05-22 03:51:24.949
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.categories (id, name, status, created_at, updated_at, deleted_at) FROM stdin;
1	Tinh dầu	ACTIVE	2025-04-27 04:17:47.076	2025-04-27 04:17:47.076	\N
2	Lọ đựng tinh dầu	ACTIVE	2025-04-27 04:17:47.076	2025-04-27 04:17:47.076	\N
3	Máy xông tinh dầu	ACTIVE	2025-04-27 04:17:47.076	2025-04-27 04:17:47.076	\N
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.comments (id, parent_id, user_id, product_id, created_at, updated_at, deleted_at, content, "like") FROM stdin;
6dd96ab7-93ac-4cc6-b203-ad64612351c7	\N	1	2	2025-06-07 10:14:38.754	2025-06-07 10:14:48.847	\N	hello	0
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.contacts (id, title, email, phone, name, message, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: faqs; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.faqs (id, title, content, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.notifications (id, title, content, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.options (id, name, price, stock, created_at, updated_at, deleted_at, product_id, resource_id) FROM stdin;
14	XL	100000.000000000000000000000000000000	0	2025-05-19 04:28:12.522	2025-06-21 04:20:31.338	\N	1	1
1	XXL	10000.000000000000000000000000000000	0	2025-05-16 09:01:12.197	2025-06-22 09:22:09.795	\N	33	1
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.order_items (id, quantity, price, order_id, created_at, product) FROM stdin;
2	11	1100000.000000000000000000000000000000	8	2025-05-23 11:04:01.728	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
3	11	1100000.000000000000000000000000000000	9	2025-05-23 13:21:18.669	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
4	11	1100000.000000000000000000000000000000	10	2025-05-23 13:24:59.342	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
5	11	1100000.000000000000000000000000000000	11	2025-05-23 13:26:48.243	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
6	11	1100000.000000000000000000000000000000	12	2025-05-23 13:30:20.321	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
7	11	1100000.000000000000000000000000000000	13	2025-05-23 13:33:41.268	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
8	11	1100000.000000000000000000000000000000	14	2025-05-23 13:41:07.385	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
9	11	1100000.000000000000000000000000000000	15	2025-05-23 13:41:41.713	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
10	11	1100000.000000000000000000000000000000	16	2025-05-23 13:49:19.285	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
11	11	1100000.000000000000000000000000000000	17	2025-05-23 13:55:31.791	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
12	11	1100000.000000000000000000000000000000	18	2025-05-23 13:59:41.074	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
13	11	1100000.000000000000000000000000000000	19	2025-05-23 14:06:11.893	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
14	11	1100000.000000000000000000000000000000	20	2025-05-23 14:10:42.723	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
15	11	1100000.000000000000000000000000000000	21	2025-05-23 14:12:18.007	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
16	11	1100000.000000000000000000000000000000	22	2025-05-23 14:15:09.182	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
17	11	1100000.000000000000000000000000000000	23	2025-05-23 14:21:52.735	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
18	11	1100000.000000000000000000000000000000	24	2025-05-23 14:22:47.892	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
19	5	500000.000000000000000000000000000000	25	2025-05-24 00:56:29.458	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
20	5	500000.000000000000000000000000000000	26	2025-05-24 00:59:25.597	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
21	5	500000.000000000000000000000000000000	27	2025-05-24 01:11:43.91	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
22	5	500000.000000000000000000000000000000	28	2025-05-24 01:23:01.774	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
23	5	500000.000000000000000000000000000000	29	2025-05-24 01:25:31.526	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
24	5	500000.000000000000000000000000000000	30	2025-05-24 01:37:06.936	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
25	5	500000.000000000000000000000000000000	31	2025-05-24 01:37:55.739	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
26	5	500000.000000000000000000000000000000	32	2025-05-27 05:26:29.116	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
37	5	500000.000000000000000000000000000000	43	2025-05-27 17:09:43.931	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
45	8	800000.000000000000000000000000000000	50	2025-05-31 17:16:30.881	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
46	8	800000.000000000000000000000000000000	51	2025-06-01 05:27:36.434	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
1	11	1100000.000000000000000000000000000000	7	2025-05-23 10:51:47.328	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
47	8	800000.000000000000000000000000000000	52	2025-06-09 03:59:30.228	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
48	2	0.000000000000000000000000000000	52	2025-06-09 03:59:30.228	{"id": 6, "name": "Tinh dầu Lemongrass", "media": "", "price": 350000, "category": "Tinh dầu", "supplier": "Edens Garden"}
49	7	0.000000000000000000000000000000	52	2025-06-09 03:59:30.228	{"id": 2, "name": "Tinh dầu Lavender", "media": "", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
50	8	800000.000000000000000000000000000000	53	2025-06-09 04:03:53.009	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
51	8	800000.000000000000000000000000000000	54	2025-06-09 04:04:10.77	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
52	8	800000.000000000000000000000000000000	55	2025-06-09 04:21:59.711	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
53	8	800000.000000000000000000000000000000	56	2025-06-09 04:22:36.925	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
54	8	800000.000000000000000000000000000000	57	2025-06-09 15:55:49.902	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
55	8	800000.000000000000000000000000000000	58	2025-06-09 15:58:09.457	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
56	8	800000.000000000000000000000000000000	59	2025-06-09 15:58:55.065	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
57	8	800000.000000000000000000000000000000	60	2025-06-09 15:59:44.783	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
58	8	800000.000000000000000000000000000000	61	2025-06-09 16:05:01.911	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
59	8	800000.000000000000000000000000000000	62	2025-06-09 16:06:32.229	{"id": 1, "name": "Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên ", "media": "", "price": 500000, "options": {"id": 14, "name": "XL", "price": 100000}, "category": "Lọ đựng tinh dầu", "supplier": "Jade Bloom"}
75	2	0.000000000000000000000000000000	78	2025-06-20 06:23:50.674	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
76	2	0.000000000000000000000000000000	79	2025-06-20 06:24:17.546	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
77	2	0.000000000000000000000000000000	80	2025-06-20 06:24:47.244	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
78	2	0.000000000000000000000000000000	81	2025-06-20 06:36:41.996	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
79	2	0.000000000000000000000000000000	82	2025-06-20 06:50:07.461	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
80	3	0.000000000000000000000000000000	83	2025-06-20 06:58:06.202	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
81	3	0.000000000000000000000000000000	84	2025-06-20 06:58:43.01	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
82	3	1500000.000000000000000000000000000000	85	2025-06-20 07:01:57.807	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
83	3	1500000.000000000000000000000000000000	86	2025-06-20 07:36:43.904	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
84	1	500000.000000000000000000000000000000	87	2025-06-21 09:21:09.13	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
85	1	600000.000000000000000000000000000000	87	2025-06-21 09:21:09.13	{"id": 3, "name": "Tinh dầu Peppermint", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/2UmoHYI_d", "price": 600000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
86	1	500000.000000000000000000000000000000	88	2025-06-21 09:24:53.337	{"id": 2, "name": "Tinh dầu Lavender", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/8AKfzzipX", "price": 500000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
87	1	600000.000000000000000000000000000000	88	2025-06-21 09:24:53.337	{"id": 3, "name": "Tinh dầu Peppermint", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/2UmoHYI_d", "price": 600000, "category": "Tinh dầu", "supplier": "Jade Bloom"}
88	2	40000.000000000000000000000000000000	89	2025-06-22 09:56:41.907	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
89	1	20000.000000000000000000000000000000	90	2025-06-22 13:36:01.736	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
90	1	20000.000000000000000000000000000000	91	2025-06-22 13:39:23.16	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
91	2	40000.000000000000000000000000000000	92	2025-06-22 13:41:33.395	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
92	2	40000.000000000000000000000000000000	93	2025-06-22 13:54:59.146	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
93	2	40000.000000000000000000000000000000	94	2025-06-22 13:59:35.799	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
94	1	20000.000000000000000000000000000000	95	2025-06-22 14:08:18.151	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
95	1	20000.000000000000000000000000000000	96	2025-06-22 14:10:46.325	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
96	1	20000.000000000000000000000000000000	97	2025-06-22 14:20:27.861	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
97	2	40000.000000000000000000000000000000	98	2025-06-22 14:36:52.761	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
98	2	40000.000000000000000000000000000000	99	2025-06-22 15:48:53.052	{"id": 33, "name": "Generic H2 (Embedded)", "media": "https://res.cloudinary.com/yourstyle/image/upload/v1/ecommerce/test/kltn_logohbf7jOH7", "price": 20000, "options": {"id": 1, "name": "XXL", "price": 10000}, "category": "Tinh dầu", "supplier": "Edens Garden"}
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.orders (id, total_amount, fee_shipping, status, user_id, created_at, receiver) FROM stdin;
10	1100000.00	120000.00	PENDING	1	2025-05-23 13:24:59.331	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
11	1100000.00	120000.00	PENDING	1	2025-05-23 13:26:48.232	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
12	1100000.00	120000.00	PENDING	1	2025-05-23 13:30:20.309	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
13	1100000.00	120000.00	PENDING	1	2025-05-23 13:33:41.257	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
14	1100000.00	120000.00	PENDING	1	2025-05-23 13:41:07.373	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
15	1100000.00	120000.00	PENDING	1	2025-05-23 13:41:41.701	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
16	1100000.00	120000.00	PENDING	1	2025-05-23 13:49:19.27	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
17	1100000.00	120000.00	PENDING	1	2025-05-23 13:55:31.78	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
19	1100000.00	120000.00	PENDING	1	2025-05-23 14:06:11.882	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
20	1100000.00	120000.00	PENDING	1	2025-05-23 14:10:42.72	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
21	1100000.00	120000.00	PENDING	1	2025-05-23 14:12:17.995	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
22	1100000.00	120000.00	PENDING	1	2025-05-23 14:15:09.17	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
23	1100000.00	120000.00	PENDING	1	2025-05-23 14:21:52.723	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
24	1100000.00	120000.00	PENDING	1	2025-05-23 14:22:47.879	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
25	500000.00	120000.00	PENDING	1	2025-05-24 00:56:29.43	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
26	500000.00	120000.00	PENDING	1	2025-05-24 00:59:25.573	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
27	500000.00	120000.00	PENDING	1	2025-05-24 01:11:43.888	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
28	500000.00	120000.00	PENDING	1	2025-05-24 01:23:01.759	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
29	500000.00	120000.00	PENDING	1	2025-05-24 01:25:31.511	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
30	500000.00	120000.00	PENDING	1	2025-05-24 01:37:06.911	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
31	500000.00	120000.00	PENDING	1	2025-05-24 01:37:55.711	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
32	500000.00	120000.00	PENDING	1	2025-05-27 05:26:29.086	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
7	1100000.00	120000.00	CANCELED	1	2025-05-23 10:51:47.307	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
8	1100000.00	120000.00	CANCELED	1	2025-05-23 11:04:01.691	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
9	1100000.00	120000.00	CANCELED	1	2025-05-23 13:21:18.656	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
18	1100000.00	120000.00	PAID	1	2025-05-23 13:59:41.063	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
43	500000.00	120000.00	PENDING	1	2025-05-27 17:09:43.919	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
53	800000.00	120000.00	PENDING	1	2025-06-09 04:03:53.004	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
50	800000.00	120000.00	PENDING	1	2025-05-31 17:16:30.854	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
51	800000.00	120000.00	PENDING	1	2025-06-01 05:27:36.418	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
52	800000.00	0.00	PENDING	1	2025-06-09 03:59:30.215	{"name": "Lê Anh Đức", "ward": "{\\"id\\":10521,\\"parentId\\":349,\\"districtId\\":349,\\"districtLocationId\\":349,\\"name\\":\\"Phường Phú Thuận\\"}", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "qưe", "district": "{\\"id\\":349,\\"parentId\\":255,\\"cityId\\":255,\\"cityLocationId\\":255,\\"name\\":\\"Quận 7\\"}", "province": "{\\"id\\":255,\\"parentId\\":0,\\"countryId\\":0,\\"name\\":\\"Hồ Chí Minh\\"}"}
54	800000.00	120000.00	PENDING	1	2025-06-09 04:04:10.76	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
55	800000.00	120000.00	PENDING	1	2025-06-09 04:21:59.698	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
56	800000.00	120000.00	PENDING	1	2025-06-09 04:22:36.912	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
57	800000.00	120000.00	PAID	1	2025-06-09 15:55:49.869	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
58	800000.00	120000.00	PAID	1	2025-06-09 15:58:09.441	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
59	800000.00	120000.00	PAID	1	2025-06-09 15:58:55.059	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
60	800000.00	120000.00	PAID	1	2025-06-09 15:59:44.761	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
61	800000.00	120000.00	PAID	1	2025-06-09 16:05:01.893	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
62	800000.00	120000.00	COMPLETE	1	2025-06-09 16:06:32.203	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
78	0.00	0.00	PENDING	1	2025-06-20 06:23:50.665	{"name": "Lê Anh Đức", "ward": "Phường Cống Vị", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123123", "district": "Quận Ba Đình", "province": "Hà Nội"}
79	0.00	0.00	PENDING	1	2025-06-20 06:24:17.541	{"name": "Lê Anh Đức", "ward": "Phường Bách Khoa", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123123", "district": "Quận Hai Bà Trưng", "province": "Hà Nội"}
80	0.00	0.00	PENDING	1	2025-06-20 06:24:47.238	{"name": "Lê Anh Đức", "ward": "Xã Hạnh Sơn", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123", "district": "Thị xã Nghĩa Lộ", "province": "Yên Bái"}
81	0.00	0.00	PENDING	1	2025-06-20 06:36:41.981	{"name": "Lê Anh Đức", "ward": "Xã Phú Thọ", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123", "district": "Huyện Tam Nông", "province": "Đồng Tháp"}
82	0.00	0.00	PENDING	1	2025-06-20 06:50:07.438	{"name": "Lê Anh Đức", "ward": "Phường Cống Vị", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123", "district": "Quận Ba Đình", "province": "Hà Nội"}
83	0.00	120000.00	PENDING	1	2025-06-20 06:58:06.193	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
84	0.00	120000.00	PENDING	1	2025-06-20 06:58:42.995	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
85	1500000.00	120000.00	PENDING	1	2025-06-20 07:01:57.79	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
86	1500000.00	120000.00	PENDING	1	2025-06-20 07:36:43.887	{"name": "Le Anh Duc", "ward": "Linh Trung", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "111", "district": "Thu Duc", "province": "TP. HCM"}
87	1100000.00	0.00	PENDING	1	2025-06-21 09:21:09.119	{"name": "Lê Anh Đức", "ward": "Phường Bách Khoa", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "asdasdasd", "district": "Quận Hai Bà Trưng", "province": "Hà Nội"}
88	1100000.00	0.00	PAID	1	2025-06-21 09:24:53.327	{"name": "Lê Anh Đức", "ward": "Phường Cống Vị", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123", "district": "Quận Ba Đình", "province": "Hà Nội"}
89	40000.00	0.00	PENDING	1	2025-06-22 09:56:41.895	{"name": "Lê Anh Đức", "ward": "Phường Cống Vị", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "132", "district": "Quận Ba Đình", "province": "Hà Nội"}
90	20000.00	0.00	PAID	1	2025-06-22 13:36:01.709	{"name": "Lê Anh Đức", "ward": "Xã Tân Lộc", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123123", "district": "Huyện Tam Bình", "province": "Vĩnh Long"}
91	20000.00	0.00	PENDING	1	2025-06-22 13:39:23.149	{"name": "Lê Anh Đức", "ward": "Xã Trà Côn", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "132", "district": "Huyện Trà Ôn", "province": "Vĩnh Long"}
92	40000.00	0.00	PENDING	1	2025-06-22 13:41:33.368	{"name": "Lê Anh Đức", "ward": "Phường Bạch Mai", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "qưe", "district": "Quận Hai Bà Trưng", "province": "Hà Nội"}
93	40000.00	0.00	PAID	1	2025-06-22 13:54:59.122	{"name": "Lê Anh Đức", "ward": "Phường Nghĩa Tân", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "qưe", "district": "Thành Phố Gia Nghĩa", "province": "Đắk Nông"}
94	40000.00	0.00	PAID	1	2025-06-22 13:59:35.762	{"name": "Lê Anh Đức", "ward": "Phường Lái Hiếu", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "qưe", "district": "Thành Phố Ngã Bảy", "province": "Hậu Giang"}
95	20000.00	0.00	PAID	1	2025-06-22 14:08:18.132	{"name": "Lê Anh Đức", "ward": "Xã Trúc Sơn", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "132", "district": "Huyện Cư Jút", "province": "Đắk Nông"}
96	20000.00	0.00	PAID	1	2025-06-22 14:10:46.311	{"name": "Lê Anh Đức", "ward": "Xã Hiệp Thành", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123123", "district": "Thành phố Bạc Liêu", "province": "Bạc Liêu"}
97	20000.00	0.00	PENDING	1	2025-06-22 14:20:27.838	{"name": "Lê Anh Đức", "ward": "Xã Đắk DRông", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123", "district": "Huyện Cư Jút", "province": "Đắk Nông"}
98	40000.00	0.00	PAID	1	2025-06-22 14:36:52.732	{"name": "Lê Anh Đức", "ward": "Phường Sông Đà", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123123", "district": "Thị xã Mường Lay", "province": "Điện Biên"}
99	40000.00	0.00	PENDING	1	2025-06-22 15:48:53.044	{"name": "Lê Anh Đức", "ward": "Phường Bạch Mai", "email": "ducvui2003@gmail.com", "phone": "0965809127", "detail": "123", "district": "Quận Hai Bà Trưng", "province": "Hà Nội"}
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.payment (id, order_id, status, created_at, updated_at, provider) FROM stdin;
1	7	PENDING	2025-05-23 10:51:47.328	2025-05-23 10:51:47.328	VNPAY
2	8	PENDING	2025-05-23 11:04:01.728	2025-05-23 11:04:01.728	VNPAY
3	9	PENDING	2025-05-23 13:21:18.669	2025-05-23 13:21:18.669	VNPAY
4	10	PENDING	2025-05-23 13:24:59.342	2025-05-23 13:24:59.342	VNPAY
5	11	PENDING	2025-05-23 13:26:48.243	2025-05-23 13:26:48.243	VNPAY
6	12	PENDING	2025-05-23 13:30:20.321	2025-05-23 13:30:20.321	VNPAY
7	13	PENDING	2025-05-23 13:33:41.268	2025-05-23 13:33:41.268	VNPAY
8	14	PENDING	2025-05-23 13:41:07.385	2025-05-23 13:41:07.385	VNPAY
9	15	PENDING	2025-05-23 13:41:41.713	2025-05-23 13:41:41.713	VNPAY
10	16	PENDING	2025-05-23 13:49:19.285	2025-05-23 13:49:19.285	VNPAY
11	17	PENDING	2025-05-23 13:55:31.791	2025-05-23 13:55:31.791	VNPAY
13	19	PENDING	2025-05-23 14:06:11.893	2025-05-23 14:06:11.893	VNPAY
14	20	PENDING	2025-05-23 14:10:42.723	2025-05-23 14:10:42.723	VNPAY
15	21	PENDING	2025-05-23 14:12:18.007	2025-05-23 14:12:18.007	VNPAY
16	22	PENDING	2025-05-23 14:15:09.182	2025-05-23 14:15:09.182	VNPAY
17	23	PENDING	2025-05-23 14:21:52.735	2025-05-23 14:21:52.735	VNPAY
18	24	PENDING	2025-05-23 14:22:47.892	2025-05-23 14:22:47.892	VNPAY
19	25	PENDING	2025-05-24 00:56:29.458	2025-05-24 00:56:29.458	VNPAY
20	26	PENDING	2025-05-24 00:59:25.597	2025-05-24 00:59:25.597	VNPAY
21	27	PENDING	2025-05-24 01:11:43.91	2025-05-24 01:11:43.91	VNPAY
22	28	PENDING	2025-05-24 01:23:01.774	2025-05-24 01:23:01.774	VNPAY
23	29	PENDING	2025-05-24 01:25:31.526	2025-05-24 01:25:31.526	VNPAY
24	30	PENDING	2025-05-24 01:37:06.936	2025-05-24 01:37:06.936	VNPAY
25	31	PENDING	2025-05-24 01:37:55.739	2025-05-24 01:37:55.739	VNPAY
26	32	PENDING	2025-05-27 05:26:29.116	2025-05-27 05:26:29.116	SEPAY
37	43	PENDING	2025-05-27 17:09:43.931	2025-05-27 17:09:43.931	SEPAY
44	50	PENDING	2025-05-31 17:16:30.885	2025-05-31 17:16:30.885	SEPAY
45	51	PENDING	2025-06-01 05:27:36.436	2025-06-01 05:27:36.436	SEPAY
46	52	PENDING	2025-06-09 03:59:30.23	2025-06-09 03:59:30.23	VNPAY
47	53	PENDING	2025-06-09 04:03:53.01	2025-06-09 04:03:53.01	SEPAY
48	54	PENDING	2025-06-09 04:04:10.771	2025-06-09 04:04:10.771	VNPAY
49	55	PENDING	2025-06-09 04:21:59.712	2025-06-09 04:21:59.712	VNPAY
50	56	PENDING	2025-06-09 04:22:36.926	2025-06-09 04:22:36.926	VNPAY
51	57	FAILED	2025-06-09 15:55:49.906	2025-06-09 15:57:32.231	VNPAY
52	58	FAILED	2025-06-09 15:58:09.459	2025-06-09 15:58:19.277	VNPAY
53	59	FAILED	2025-06-09 15:58:55.067	2025-06-09 15:59:49.722	VNPAY
54	60	FAILED	2025-06-09 15:59:44.786	2025-06-09 15:59:54.379	VNPAY
55	61	FAILED	2025-06-09 16:05:01.913	2025-06-09 16:05:16.584	VNPAY
56	62	FAILED	2025-06-09 16:06:32.234	2025-06-10 02:55:05.032	VNPAY
12	18	FAILED	2025-05-23 13:59:41.074	2025-06-10 02:57:37.602	VNPAY
72	78	PENDING	2025-06-20 06:23:50.677	2025-06-20 06:23:50.677	VNPAY
73	79	PENDING	2025-06-20 06:24:17.547	2025-06-20 06:24:17.547	VNPAY
74	80	PENDING	2025-06-20 06:24:47.245	2025-06-20 06:24:47.245	VNPAY
75	81	PENDING	2025-06-20 06:36:41.998	2025-06-20 06:36:41.998	VNPAY
76	82	PENDING	2025-06-20 06:50:07.463	2025-06-20 06:50:07.463	VNPAY
77	83	PENDING	2025-06-20 06:58:06.204	2025-06-20 06:58:06.204	VNPAY
78	84	PENDING	2025-06-20 06:58:43.011	2025-06-20 06:58:43.011	VNPAY
79	85	PENDING	2025-06-20 07:01:57.809	2025-06-20 07:01:57.809	VNPAY
80	86	PENDING	2025-06-20 07:36:43.906	2025-06-20 07:36:43.906	VNPAY
81	87	PENDING	2025-06-21 09:21:09.133	2025-06-21 09:21:09.133	VNPAY
82	88	SUCCESS	2025-06-21 09:24:53.339	2025-06-21 09:25:28.682	VNPAY
83	89	PENDING	2025-06-22 09:56:41.91	2025-06-22 09:56:41.91	SEPAY
84	90	SUCCESS	2025-06-22 13:36:01.742	2025-06-22 13:36:48.444	SEPAY
85	91	PENDING	2025-06-22 13:39:23.163	2025-06-22 13:39:23.163	SEPAY
86	92	PENDING	2025-06-22 13:41:33.398	2025-06-22 13:41:33.398	SEPAY
87	93	SUCCESS	2025-06-22 13:54:59.149	2025-06-22 13:55:54.592	SEPAY
88	94	SUCCESS	2025-06-22 13:59:35.802	2025-06-22 14:00:11.148	SEPAY
89	95	SUCCESS	2025-06-22 14:08:18.155	2025-06-22 14:09:11.012	SEPAY
90	96	SUCCESS	2025-06-22 14:10:46.327	2025-06-22 14:11:24.747	SEPAY
91	97	PENDING	2025-06-22 14:20:27.866	2025-06-22 14:20:27.866	SEPAY
92	98	SUCCESS	2025-06-22 14:36:52.765	2025-06-22 14:37:29.458	SEPAY
93	99	PENDING	2025-06-22 15:48:53.054	2025-06-22 15:48:53.054	VNPAY
\.


--
-- Data for Name: payment_transaction; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.payment_transaction (id, payment_id, amount, payload, provider_payment_id, created_at) FROM stdin;
1	42	50000000.00	{"amount": 50000000, "txnRef": "42", "payDate": "2025-05-28T01:48:42.000Z", "tnnCode": "G0M7ZFHB", "bankCode": "NCB", "cardType": "ATM", "orderInfo": "HD: 42", "bankTranNo": "VNP14984178", "responseCode": "00", "transactionNo": "14984178", "transactionStatus": "00"}	14984178	2025-05-28 01:48:21.839
2	43	80000000.00	{"amount": 80000000, "txnRef": "43", "payDate": "2025-05-31T00:50:06.000Z", "tnnCode": "G0M7ZFHB", "bankCode": "NCB", "cardType": "ATM", "orderInfo": "HD: 43", "bankTranNo": "VNP14990937", "responseCode": "00", "transactionNo": "14990937", "transactionStatus": "00"}	14990937	2025-05-31 00:49:36.412
3	51	2277000.00	{"id": 92704, "code": null, "content": "HD 51", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 15:57:32.218
4	52	2277000.00	{"id": 92704, "code": null, "content": "HD 52", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 15:58:19.27
5	53	2277000.00	{"id": 92704, "code": null, "content": "HD 53", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 15:59:02.25
6	53	2277000.00	{"id": 92704, "code": null, "content": "HD 53", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 15:59:49.714
7	54	2277000.00	{"id": 92704, "code": null, "content": "HD 54", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 15:59:54.365
8	999	2277000.00	{"id": 92704, "code": null, "content": "HD 999", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 16:01:18.595
9	55	2277000.00	{"id": 92704, "code": null, "content": "HD 55", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 16:05:16.572
10	56	2277000.00	{"id": 92704, "code": null, "content": "HD 56", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-09 16:06:39.66
11	56	2277000.00	{"id": 92704, "code": null, "content": "HD 56", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 02:55:05.024
12	12	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 12", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 02:55:59.996
13	12	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 12", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 02:56:35.861
14	12	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 12", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 02:57:37.592
15	66	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 66", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 02:59:12.196
16	60	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 60", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:00:06.548
17	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:01:49.362
18	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:02:11.557
19	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:03:36.881
20	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:06:59.043
21	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:08:12.042
22	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:08:49.893
23	61	11110.00	{"id": 14582930, "code": null, "content": "90307285629-0965809127-HD 61", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90307285629-0965809127-HD 61", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "16859261-8565-437e-9765-cbde3ffae7f3", "transferAmount": 11110, "transactionDate": "2025-06-10T03:10:13.000Z"}	14582930	2025-06-10 03:14:07.007
24	61	11110.00	{"id": 14583286, "code": null, "content": "90309051412-0965809127-HD 61", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90309051412-0965809127-HD 61", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "444b53b0-154b-4ca6-b53c-8d37c956420f", "transferAmount": 11110, "transactionDate": "2025-06-10T03:16:59.000Z"}	14583286	2025-06-10 03:16:59.842
25	59	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 59", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:23:15.423
26	62	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 62", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:23:21.814
27	63	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 63", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:24:53.103
28	64	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 64", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:30:54.093
29	66	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 66", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:40:36.057
30	68	2277000.00	{"id": 92704, "code": null, "content": "90304996780 0965809127 HD 68", "gateway": "Vietcombank", "subAccount": null, "accumulated": 19077000, "description": "hello 123", "transferType": "in", "accountNumber": "0123499999", "referenceCode": "MBVCB.3278907687", "transferAmount": 2277000, "transactionDate": "2023-03-25T07:02:37.000Z"}	92704	2025-06-10 03:47:11.323
31	12	10000.00	{"id": 14582105, "code": null, "content": "90304996780 0965809127 HD12", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90304996780 0965809127 HD12", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "eb7facc4-a094-4011-b84e-80571e309056", "transferAmount": 10000, "transactionDate": "2025-06-10T02:52:28.000Z"}	14582105	2025-06-10 03:56:20.804
32	69	11110.00	{"id": 14587483, "code": null, "content": "90315373594 0965809127 HD 69", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90315373594 0965809127 HD 69", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "d208b76f-c51f-406b-8c99-98c9fca6fafe", "transferAmount": 11110, "transactionDate": "2025-06-10T04:14:59.000Z"}	14587483	2025-06-10 04:14:59.937
33	12	10000.00	{"id": 14581915, "code": null, "content": "90305203432 0965809127 HD 12", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90305203432 0965809127 HD 12", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "97f9092e-50e0-47e6-abf3-2ceba17d0109", "transferAmount": 10000, "transactionDate": "2025-06-10T02:47:18.000Z"}	14581915	2025-06-10 04:28:37.707
34	60	11110.00	{"id": 14581783, "code": null, "content": "90304714225 0965809127 HD 60", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90304714225 0965809127 HD 60", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "9a4c5f5e-3f9c-4b82-8239-c304c93f69a7", "transferAmount": 11110, "transactionDate": "2025-06-10T02:43:50.000Z"}	14581783	2025-06-10 04:52:04.023
35	60	11110.00	{"id": 14581596, "code": null, "content": "90304233488-0965809127-HD 60", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 90304233488-0965809127-HD 60", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "e76261d5-dee7-4da4-aac5-c74d3dbf507b", "transferAmount": 11110, "transactionDate": "2025-06-10T02:38:51.000Z"}	14581596	2025-06-10 05:27:19.066
36	82	110000000.00	{"amount": 110000000, "txnRef": "82", "payDate": "2025-06-21T09:26:09.000Z", "tnnCode": "G0M7ZFHB", "bankCode": "NCB", "cardType": "ATM", "orderInfo": "HD: 82", "bankTranNo": "VNP15030211", "responseCode": "00", "transactionNo": "15030211", "transactionStatus": "00"}	15030211	2025-06-21 09:25:28.678
37	84	20000.00	{"id": 15576516, "code": null, "content": "91684932010 0965809127 HD 84", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91684932010 0965809127 HD 84", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "f96b9a84-2362-4c6e-bc22-29c95520987b", "transferAmount": 20000, "transactionDate": "2025-06-22T13:36:48.000Z"}	15576516	2025-06-22 13:36:48.438
38	87	40000.00	{"id": 15578198, "code": null, "content": "91685826951 0965809127 HD 87", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91685826951 0965809127 HD 87", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "73d7c0bc-7074-4ac0-8d06-14d352930127", "transferAmount": 40000, "transactionDate": "2025-06-22T13:55:54.000Z"}	15578198	2025-06-22 13:55:54.585
39	88	40000.00	{"id": 15578549, "code": null, "content": "91686635147 0965809127 HD 88", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91686635147 0965809127 HD 88", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "7d5f7d6e-150e-4757-81be-9b5fd8a1b068", "transferAmount": 40000, "transactionDate": "2025-06-22T14:00:09.000Z"}	15578549	2025-06-22 14:00:11.14
40	89	20000.00	{"id": 15579247, "code": null, "content": "91688221271 0965809127 HD 89", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91688221271 0965809127 HD 89", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "7329a26a-bf12-42db-a3b5-5be8375d3c9c", "transferAmount": 20000, "transactionDate": "2025-06-22T14:09:10.000Z"}	15579247	2025-06-22 14:09:11.005
41	90	20000.00	{"id": 15579441, "code": null, "content": "91688470996 0965809127 HD 90", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91688470996 0965809127 HD 90", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "c34cddb2-f4ba-474f-9d10-fe378a0363a9", "transferAmount": 20000, "transactionDate": "2025-06-22T14:11:24.000Z"}	15579441	2025-06-22 14:11:24.74
42	92	40000.00	{"id": 15582129, "code": null, "content": "91690244273 0965809127 HD 92", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91690244273 0965809127 HD 92", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "f5101d3e-7d9d-40c5-8394-90357b9197f3", "transferAmount": 40000, "transactionDate": "2025-06-22T14:37:27.000Z"}	15582129	2025-06-22 14:37:29.455
43	94	40000.00	{"id": 15588711, "code": null, "content": "91696671229 0965809127 HD 94", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91696671229 0965809127 HD 94", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "49a430c2-40be-49ad-b8a1-24904f46b48f", "transferAmount": 40000, "transactionDate": "2025-06-22T16:00:13.000Z"}	15588711	2025-06-22 16:00:13.792
44	95	20000.00	{"id": 15589094, "code": null, "content": "91696950855 0965809127 HD 95", "gateway": "BIDV", "subAccount": "962475QLZ4", "accumulated": 0, "description": "BankAPINotify 91696950855 0965809127 HD 95", "transferType": "in", "accountNumber": "3149041322", "referenceCode": "f91df101-34cb-4974-ad77-3df6eb926ab8", "transferAmount": 20000, "transactionDate": "2025-06-22T16:04:57.000Z"}	15589094	2025-06-22 16:04:57.918
\.


--
-- Data for Name: policies; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.policies (id, title, content, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: product_resources; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.product_resources (product_id, resource_id, created_at) FROM stdin;
2	5	2025-05-11 04:51:51.765
2	6	2025-05-11 04:51:51.765
2	7	2025-05-11 04:51:51.765
2	8	2025-05-11 04:51:51.765
2	9	2025-05-11 04:51:51.765
2	10	2025-05-11 04:51:51.765
2	11	2025-05-11 04:51:51.765
2	12	2025-05-11 04:51:51.765
2	13	2025-05-11 04:51:51.765
3	14	2025-05-11 05:06:12.423
3	15	2025-05-11 05:06:12.423
3	16	2025-05-11 05:06:12.423
3	17	2025-05-11 05:06:12.423
4	18	2025-05-11 05:09:22.939
4	19	2025-05-11 05:09:22.939
4	20	2025-05-11 05:09:22.939
4	21	2025-05-11 05:09:22.939
5	22	2025-05-11 05:13:22.772
5	23	2025-05-11 05:13:22.772
5	24	2025-05-11 05:13:22.772
5	25	2025-05-11 05:13:22.772
5	26	2025-05-11 05:13:22.772
5	27	2025-05-11 05:13:22.772
5	28	2025-05-11 05:13:22.772
6	29	2025-05-11 05:16:15.838
6	30	2025-05-11 05:16:15.838
6	31	2025-05-11 05:16:15.838
6	32	2025-05-11 05:16:15.838
7	33	2025-05-11 05:21:27.129
7	34	2025-05-11 05:21:27.129
7	35	2025-05-11 05:21:27.129
7	36	2025-05-11 05:21:27.129
8	37	2025-05-11 05:28:15.421
8	38	2025-05-11 05:28:15.421
8	39	2025-05-11 05:28:15.421
8	40	2025-05-11 05:28:15.421
9	41	2025-05-11 05:30:11.93
9	42	2025-05-11 05:30:11.93
9	43	2025-05-11 05:30:11.93
10	44	2025-05-11 05:32:39.364
10	45	2025-05-11 05:32:39.364
10	46	2025-05-11 05:32:39.364
10	47	2025-05-11 05:32:39.364
11	41	2025-05-11 05:33:42.242
11	42	2025-05-11 05:33:42.242
11	43	2025-05-11 05:33:42.242
12	48	2025-05-11 05:37:30.001
12	49	2025-05-11 05:37:30.001
12	50	2025-05-11 05:37:30.001
12	51	2025-05-11 05:37:30.001
13	52	2025-05-11 05:40:30.588
13	53	2025-05-11 05:40:30.588
13	54	2025-05-11 05:40:30.588
13	55	2025-05-11 05:40:30.588
14	56	2025-05-11 05:45:09.976
14	57	2025-05-11 05:45:09.976
14	58	2025-05-11 05:45:09.976
14	59	2025-05-11 05:45:09.976
14	60	2025-05-11 05:45:09.976
14	61	2025-05-11 05:45:09.976
14	62	2025-05-11 05:45:09.976
15	63	2025-05-11 05:51:50.109
15	64	2025-05-11 05:51:50.109
15	65	2025-05-11 05:51:50.109
15	66	2025-05-11 05:51:50.109
15	67	2025-05-11 05:51:50.109
15	68	2025-05-11 05:51:50.109
15	69	2025-05-11 05:51:50.109
15	70	2025-05-11 05:51:50.109
16	71	2025-05-11 05:55:19.296
16	72	2025-05-11 05:55:19.296
16	73	2025-05-11 05:55:19.296
16	74	2025-05-11 05:55:19.296
16	75	2025-05-11 05:55:19.296
16	76	2025-05-11 05:55:19.296
16	77	2025-05-11 05:55:19.296
16	78	2025-05-11 05:55:19.296
17	79	2025-05-11 06:01:46.833
17	80	2025-05-11 06:01:46.833
17	81	2025-05-11 06:01:46.833
17	82	2025-05-11 06:01:46.833
17	83	2025-05-11 06:01:46.833
17	84	2025-05-11 06:01:46.833
17	85	2025-05-11 06:01:46.833
17	86	2025-05-11 06:01:46.833
18	87	2025-05-11 06:04:50.493
18	88	2025-05-11 06:04:50.493
18	89	2025-05-11 06:04:50.493
18	90	2025-05-11 06:04:50.493
18	91	2025-05-11 06:04:50.493
18	92	2025-05-11 06:04:50.493
18	93	2025-05-11 06:04:50.493
18	94	2025-05-11 06:04:50.493
19	95	2025-05-11 06:08:23.258
19	96	2025-05-11 06:08:23.258
19	97	2025-05-11 06:08:23.258
19	98	2025-05-11 06:08:23.258
19	99	2025-05-11 06:08:23.258
19	100	2025-05-11 06:08:23.258
19	101	2025-05-11 06:08:23.258
19	102	2025-05-11 06:08:23.258
20	103	2025-05-11 06:10:55.231
20	104	2025-05-11 06:10:55.231
20	105	2025-05-11 06:10:55.231
20	106	2025-05-11 06:10:55.231
20	107	2025-05-11 06:10:55.231
20	108	2025-05-11 06:10:55.231
20	109	2025-05-11 06:10:55.231
21	110	2025-05-11 06:13:41.906
21	111	2025-05-11 06:13:41.906
21	112	2025-05-11 06:13:41.906
21	113	2025-05-11 06:13:41.906
21	114	2025-05-11 06:13:41.906
21	115	2025-05-11 06:13:41.906
21	116	2025-05-11 06:13:41.906
21	117	2025-05-11 06:13:41.906
22	119	2025-05-11 06:17:04.488
22	120	2025-05-11 06:17:04.488
22	121	2025-05-11 06:17:04.488
22	122	2025-05-11 06:17:04.488
22	123	2025-05-11 06:17:04.488
22	124	2025-05-11 06:17:04.488
22	125	2025-05-11 06:17:04.488
22	126	2025-05-11 06:17:04.488
22	127	2025-05-11 06:17:04.488
23	128	2025-05-11 06:19:48.223
23	129	2025-05-11 06:19:48.223
23	130	2025-05-11 06:19:48.223
23	131	2025-05-11 06:19:48.223
23	132	2025-05-11 06:19:48.223
23	133	2025-05-11 06:19:48.223
23	134	2025-05-11 06:19:48.223
23	135	2025-05-11 06:19:48.223
24	136	2025-05-11 06:27:34.095
24	137	2025-05-11 06:27:34.095
24	138	2025-05-11 06:27:34.095
24	139	2025-05-11 06:27:34.095
24	140	2025-05-11 06:27:34.095
24	141	2025-05-11 06:27:34.095
24	142	2025-05-11 06:27:34.095
24	143	2025-05-11 06:27:34.095
24	144	2025-05-11 06:27:34.095
25	145	2025-05-11 06:30:41.847
25	146	2025-05-11 06:30:41.847
25	147	2025-05-11 06:30:41.847
25	148	2025-05-11 06:30:41.847
25	149	2025-05-11 06:30:41.847
25	150	2025-05-11 06:30:41.847
25	151	2025-05-11 06:30:41.847
25	152	2025-05-11 06:30:41.847
26	153	2025-05-11 06:33:27.118
26	154	2025-05-11 06:33:27.118
26	155	2025-05-11 06:33:27.118
26	156	2025-05-11 06:33:27.118
26	157	2025-05-11 06:33:27.118
26	158	2025-05-11 06:33:27.118
26	159	2025-05-11 06:33:27.118
26	160	2025-05-11 06:33:27.118
27	161	2025-05-11 06:36:25.526
27	162	2025-05-11 06:36:25.526
27	163	2025-05-11 06:36:25.526
27	164	2025-05-11 06:36:25.526
27	165	2025-05-11 06:36:25.526
27	166	2025-05-11 06:36:25.526
27	167	2025-05-11 06:36:25.526
27	168	2025-05-11 06:36:25.526
28	169	2025-05-11 06:39:20.495
28	170	2025-05-11 06:39:20.495
28	171	2025-05-11 06:39:20.495
28	172	2025-05-11 06:39:20.495
28	173	2025-05-11 06:39:20.495
28	174	2025-05-11 06:39:20.495
28	175	2025-05-11 06:39:20.495
28	176	2025-05-11 06:39:20.495
29	177	2025-05-11 06:41:24.899
29	178	2025-05-11 06:41:24.899
29	179	2025-05-11 06:41:24.899
29	180	2025-05-11 06:41:24.899
29	181	2025-05-11 06:41:24.899
29	182	2025-05-11 06:41:24.899
29	183	2025-05-11 06:41:24.899
29	184	2025-05-11 06:41:24.899
30	185	2025-05-11 06:43:18.663
30	186	2025-05-11 06:43:18.663
30	187	2025-05-11 06:43:18.663
30	188	2025-05-11 06:43:18.663
30	189	2025-05-11 06:43:18.663
30	190	2025-05-11 06:43:18.663
30	191	2025-05-11 06:43:18.663
30	192	2025-05-11 06:43:18.663
33	1	2025-05-16 09:01:12.203
1	2004	2025-05-19 04:02:51.835
1	2	2025-05-19 04:02:51.835
52	163	2025-06-21 07:20:44.579
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.products (id, name, description, base_price, sale_price, category_id, supplier_id, created_at, updated_at, thumbnail_id, views, is_deleted) FROM stdin;
11	Lọ đựng tinh dầu 20ml	Lọ đựng tinh dầu 20ml thủy tinh	150000.00	140000.00	2	11	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	43	0	f
9	Lọ đựng tinh dầu 10ml	Lọ đựng tinh dầu 10ml bằng thủy tinh	100000.00	90000.00	2	12	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	43	0	f
15	Tinh Dầu Trà Trắng (White Tea Essential Oil) Heny Garden	Tinh dầu White Tea hay còn gọi là tinh dầu trà trắng là một trong những “gương mặt” nổi bật trong thời gian gần đây bởi hương thơm thuần khiết và khả năng tuyệt vời mà nó mang lại.\n\nCùng Heny Garden khám phá một số công dụng cũng như nhiều cách sử dụng hay ho của loại tinh dầu này nhé. 	119000.00	119000.00	1	16	2025-05-11 05:48:40.135	\N	70	0	f
26	Tinh Dầu Quế (Cinnamon Essential Oil) Heny Garden	Tinh dầu Quế cay nồng, ngọt ngào, quen thuộc với nhiều người vì quế là nguyên liệu phổ biến trong ẩm thực. Dầu quế được đánh giá cao vì hương thơm tươi mới và những lợi ích về sức khỏe và sắc đẹp mà nó mang lại nhờ những khả năng kháng khuẩn, chống nấm, chống oxy hoá.\nNhưng nhiều người vẫn còn băn khoăn rằng tinh dầu Quế có tốt hay không? Vậy hãy cùng Heny tìm hiểu các lợi ích mà tinh dầu Quế mang lại và giải đáp thắc mắc trên nhé. 	99000.00	69000.00	1	12	2025-05-11 13:31:54	\N	160	0	f
19	Tinh Dầu Cà Phê (Coffee Essential Oil) Heny Garden	Tinh dầu Cà Phê khi được khuếch tán vào trong không khí sẽ khiến hương thơm nồng nàn ấm áp lan tỏa khắp ngôi nhà bạn	119000.00	89000.00	1	12	2025-05-11 13:06:12	\N	102	0	f
30	Tinh Dầu Thơm Phối Hương Christmas Spirit (Giáng Sinh Rộn Ràng) Heny Garden	Tinh dầu thơm phối hương Christmas Spirit đem đến không khí một ngày lễ Giáng Sinh quây quần thưởng thức một bữa tối ấm cúng và trao quà vào lúc nửa đêm tại hầu hết các quốc gia Châu Âu. Người ta thường nhớ đến hương vị ngọt ấm của món tráng miệng bánh táo quế trong bữa tối đêm Giáng Sinh. Nhớ đến khoảnh khắc hồi hộp trao quà bên cạnh chiếc lò sưởi, hòa với hương thơm mát lạnh từ cây Thông lấp lánh ánh đèn. Nhớ đến mùi hương đặc trưng như Christmas Spirit.	189000.00	149000.00	1	12	2025-05-11 13:41:55	\N	192	0	f
21	Tinh Dầu Hương Thảo (Rosemary Essential Oil) Heny Garden	Hương Thảo được biết đến chủ yếu như 1 loại nguyên liệu ẩm thực, nhưng gần đây Tinh Dầu Hương Thảo lại được đánh giá cao về hương thơm đặc trưng cùng những lợi ích trong y học. Cùng Heny tìm hiểu các công dụng và lợi ich của cây Hương Thảo mang lại nhé.	109000.00	79000.00	1	12	2025-05-11 13:11:51	\N	117	0	f
17	Tinh Dầu Phối Hương Tropical Paradise (Thiên Đường Nhiệt Đới) Xông Thơm Phòng HENY GARDEN	Tinh dầu phối hương Tropical Paradise (Thiên Đường Nhiệt Đới) đem đến một mùi hương giống như gió mang theo hương thơm của dừa và các loài hoa tươi. Bạn sẽ cảm nhận được sự dịu mát và tươi mới, như là một cuộc phiêu lưu vào một thiên đường nhiệt đới.	179000.00	149000.00	1	12	2025-05-11 05:59:23.039	\N	86	0	f
28	Tinh Dầu Hoàng Đàn - Tuyết Tùng (Cedarwood Essential Oil) Heny Garden	Tinh dầu Hoàng Đàn (tinh dầu gỗ Tuyết Tùng) có hương gỗ ngọt nồng ấm, dễ chịu, tạo hương thơm thư giãn, dịu êm khi được khuếch tán. Tinh dầu Cedarwood là một thành phần bổ sung tuyệt vời cho các sản phẩm chăm sóc da và tóc, còn được tìm thấy trong nước hoa, chống côn trùng và khử mùi.	139000.00	99000.00	1	12	2025-05-11 13:37:37	\N	176	0	f
5	Tinh dầu Rose	Tinh dầu hoa hồng	700000.00	650000.00	1	12	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	28	0	f
29	Tinh Dầu Thơm Phối Hương The Stars (Vì Sao Trên Trời) Heny Garden	Tinh dầu thơm phối hương The Stars tái hiện khoảnh khắc đứng giữa bầu trời trong một đêm lộng gió tại căn hộ penthouse tọa lạc tại quận 7 năm ngoái. Vào cái buổi đêm ấy, tiết trời se lạnh, đầy sao và im lặng đến lạ. Khác biệt với vòng xoay kèm sự náo nhiệt, ồn ào của một ngày dài; Dường như lúc này vạn vật đều nín thở vì sợ làm tan vỡ bầu không khí yên tĩnh.	189000.00	149000.00	1	12	2025-05-11 13:39:54	\N	184	0	f
4	Tinh dầu Eucalyptus	Tinh dầu Eucalyptus thư giãn	450000.00	400000.00	1	12	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	21	0	f
10	Máy xông tinh dầu	Máy xông tinh dầu 100ml	1200000.00	1100000.00	3	13	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	47	0	f
6	Tinh dầu Lemongrass	Tinh dầu sả chanh	350000.00	320000.00	1	13	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	32	0	f
14	Tinh Dầu Phối Hương Yummy Kiwi (Kiwi Hảo Hạng) Xông Thơm Phòng HENY GARDEN	- Tinh dầu thơm phối hương Yummy Kiwi (Kiwi Hảo Hạng)\n\n- Mùi hương là sự phối hợp giữa các tầng Top/Mid/Base note (hương Đầu/ Giữa/ Cuối) tạo nên sự độc đáo và lưu luyến hơn so với tinh dầu đơn hương.\n\n- Nốt hương chính: Kiwi, Sữa dừa, Xoài chín\n\n- Nốt hương bổ trợ: Chanh dây, Hoa ly, Hoa cam, Hổ phách, Dưa lưới\n\n- Dung tích: 10mL\n\n- Thương hiệu: Heny Garden\n\n- Thời hạn sử dụng: 2 năm\n\n- Heny Garden bảo chứng chất lượng sản phẩm với đánh giá 5 sao.	179000.00	149000.00	1	15	2025-05-11 05:42:52.348	\N	62	0	f
13	Máy xông tinh dầu LORITA KDK-TT3D	Máy xông, máy khuếch tán tinh dầu LORITA KDK-TT3D  là dòng máy xông siêu âm với thiết kế hình Lọ hoa với đèn màu 3D và chất liệu thủy tinh, phù hợp với nhiều không gian.\nThường được đặt trên kệ tủ, bàn khách, bàn ăn,… đem đến cảm giác sang trọng, tạo điểm nhấn.	650000.00	650000.00	3	13	2025-05-11 05:38:57.285	\N	55	0	f
22	Tinh Dầu Thơm Phối Hương Aquamarine (Viên Ngọc Của Đại Dương) Heny Garden	Tinh dầu thơm phối hương Aquamarine lấy cảm hứng từ hơi thở của vùng biển lộng gió Windansea tại San Diego	189000.00	149000.00	1	12	2025-05-11 13:14:59	2025-06-20 12:40:20.383	127	1	f
16	Tinh Dầu Hoa Nhài (Elegant Jasmine Essential Oil) Heny Garden	Tinh dầu Hoa Nhài (tinh dầu hoa Lài) được chiết xuất từ những đóa hoa nhài trắng muốt - một loài hoa chỉ nở vào ban đêm. Hoa lài được yêu thích nhờ vào hương thơm lãng mạn	179000.00	149000.00	1	12	2025-05-11 05:53:05.428	\N	78	0	f
24	Tinh Dầu Thơm Phối Hương Black Ocean (Đại Dương Đen) Heny Garden	Tinh dầu thơm phối hương Black Ocean không miêu tả năng lượng sảng khoái và tràn đầy tinh thần như những tay lướt sóng cừ khôi trên vùng biển lộng gió Windansea	179000.00	149000.00	1	12	2025-05-11 13:25:21	\N	144	0	f
25	Tinh Dầu Sả Hoa Hồng (Palmarosa Essential Oil) Heny Garden	Tinh dầu Sả Hoa Hồng đã được sử dụng ngàn năm trong lĩnh vực Y học tại Trung Quốc và Ấn Độ. Ngày nay	99000.00	69000.00	1	12	2025-05-11 13:28:28	\N	152	0	f
7	Tinh dầu Tea Tree	Tinh dầu tràm trà	550000.00	500000.00	1	13	2025-04-27 04:23:32.889	2025-06-15 09:05:16.627	36	1	f
20	Tinh Dầu Gỗ Thông (Pine Essential Oil) Heny Garden	Tinh dầu Thông từ lâu đã gắn liền với đời sống con người, nhờ các lợi ích mà nó mang lại trong đời sống và sức khỏe. Ngày nay để thuận tiện hơn cho việc khai thác các lợi ích sức khỏe mà cây Thông mang lại, tinh dầu Thông đã được chiết xuất để được sử dụng rộng rãi hơn.  Tinh dầu Thông đã trở thành một hương thơm phổ biến trong mỹ phẩm, đồ vệ sinh cá nhân, xà phòng và chất tẩy rửa. Bài viết sản phẩm này nêu bật các lợi ích, đặc tính và cách sử dụng an toàn khác của Tinh dầu Thông.	99000.00	69000.00	1	12	2025-05-11 13:09:23	\N	109	0	f
18	Tinh Dầu Vani (Sweet Vanilla Essential Oil) Heny Garden	Tinh dầu Vani đã xuất hiện từ rất lâu và được sử dụng phổ biến trên thế giới. Không chỉ là nguyên liệu phổ biến trong công thức làm bánh	119000.00	89000.00	1	12	2025-05-11 13:03:03	\N	94	0	f
27	Tinh Dầu Ngọc Lan Tây (Ylang Ylang Essential Oil) Heny Garden	Tinh dầu Ngọc Lan Tây (Ylang Ylang essential oil) với hương quyến rũ, nữ tính và lãng mạn, hoa Ngọc Lan Tây thường được sử dụng làm nước hoa, liệu pháp điều trị tâm lý và chăm sóc da tóc.\nNếu là một người yêu thích hương thơm, nhất là nước hoa, chắc hẳn bạn đã từng thấy sự xuất hiện của Hoa Ngọc Lan Tây trong thành phần, điển hình như nước hoa Chanel No5	149000.00	119000.00	1	12	2025-05-11 13:34:58	\N	168	0	f
23	Tinh Dầu Đàn Hương (Sandalwood Essential Oil) Heny Garden	Tinh dầu Đàn Hương được chiết xuất từ một loại cây rất có giá trị, có mùi hương cổ điển và là thành phần được tìm thấy trong nhiều loại nước hoa.  Giá trị mà tinh dầu gỗ Đàn hương mang lại không chỉ là hương thơm, mà còn nhiều lợi ích khác cho sức khỏe: điều trị mất ngủ, cân bằng cảm xúc và tâm trạng, làm lành vết thương,...	229000.00	189000.00	1	12	2025-05-11 13:17:55	\N	135	0	f
8	Tinh dầu Orange	Tinh dầu cam tự nhiên	400000.00	350000.00	1	11	2025-04-27 04:23:32.889	2025-04-27 04:23:32.889	40	0	f
12	Máy xông tinh dầu LORITA DK-BL02	Máy xông, máy khuếch tán tinh dầu LORITA DK-BL01 là dòng máy xông siêu âm với thiết kế Hình Trụ dài hoạ tiết bông lúa vân gỗ phù hợp với nhiều không gian, có tông màu nhẹ nhàng, thanh lịch.\nThường được đặt trên bàn, phòng khách, kệ tủ đầu giường,… tạo điểm nhấn trong thiết kế nội thất	100000.00	100000.00	3	11	2025-05-11 05:35:50.738	2025-06-21 04:07:12.816	51	8	f
3	Tinh dầu Peppermint	Tinh dầu Peppermint tự nhiên	600000.00	550000.00	1	11	2025-04-27 04:23:32.889	2025-06-21 09:19:51.154	17	94	f
33	Generic H2 (Embedded)	asdasdasaa	20000.00	10000.00	1	13	2025-05-16 09:01:12.197	2025-06-22 15:48:32.994	1	13	f
2	Tinh dầu Lavender	Tinh dầu Lavender nguyên chất	500000.00	450000.00	1	11	2025-04-27 04:23:32.889	2025-06-22 13:38:42.056	13	44	f
1	Chai Tinh Dầu Trắng Mờ Nắp Bóp Nhỏ Giọt Khuyên 	1. Chi Tiết Sản Phẩm\n- Mã số : TDNM-XS\n- Dung tích :5ml, 10ml, 15ml , 20ml, 30ml, 50ml, 100ml\n- Loại Nắp : Xịt Sương | Mạ Vàng Cao Cấp\n- Trọng lượng :20gr-100gr\n- Còn Hàng - Ship Toàn quốc\n\n2.  Điểm nổi bật :\n- Dòng chai thủy tinh dùng Đựng tinh dầu , hóa chất thì không thể thiếu được màu hỗ phách. vì chỉ có loai này thì mới có thể không làm thay đổi hoạt tích hóa học của tinh dau .với Đầu lăn cao cấp. bạn có Thể ứng dụng rất nhiều công Dụng.\n\n- chất liệu thủy tinh sáng, đẹp và màu hỗ Phách. Chai thủy tinh rất dầy và chắc chắn cùng quay xách cùng ống bớp sang trọng nên được dùng nhiều để bao bì các chất hóa chất , tinh dau các loại , liệu hương .....\n- Với thiết kế riêng biệt dầy các Tính tạo một thương hiệu sản phẩm của bạn.\n\n- Dòng Sản Phẩm có Nhiều Dung Tích :  5ml, 10ml, 15ml , 20ml, 30ml, 50ml, 100ml	500000.00	400000.00	2	11	2025-05-11 10:52:08	2025-06-21 04:26:36.711	2004	8	f
52	Tinh dầu trị liệu - Chữa lành bằng mùi hương	<p><strong style="color: rgb(128, 128, 0);"><em>Tinh dầu trị liệu</em></strong><em style="color: rgb(106, 106, 105);"> nhà Cỏ Mềm là liệu pháp giúp giải quyết các vấn đề về tinh thần mà nhiều người thường xuyên gặp phải trong cuộc sống hiện nay như căng thẳng, lo âu, kém tập trung, ngủ không sâu, mất cân bằng tâm trí… Cùng khám phá vì sao tinh dầu trị liệu nhà Cỏ lại được tin dùng như vậy nhé!</em></p>	180000.00	1.00	1	11	2025-06-21 07:20:44.572	2025-06-21 10:00:24.164	168	7	f
\.


--
-- Data for Name: promotion_order_items; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.promotion_order_items (id, promotion_id, order_item_id, created_at) FROM stdin;
\.


--
-- Data for Name: promotion_orders; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.promotion_orders (id, promotion_id, order_id, created_at) FROM stdin;
\.


--
-- Data for Name: promotions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.promotions (id, code, description, percent, map_amount, start_date, end_date, usage_limit, status, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.resources (id, public_id, type, format, created_at, updated_at, deleted_at, "isDeleted") FROM stdin;
1	ecommerce/test/kltn_logohbf7jOH7	image	jpg	2025-05-11 03:47:29.768	2025-05-11 03:47:29.768	\N	f
2	ecommerce/test/3QQD7-6VK	image	webp	2025-05-11 04:19:29.121	2025-05-11 04:19:29.121	\N	f
3	ecommerce/test/2UpN_3NLU	image	webp	2025-05-11 04:19:29.221	2025-05-11 04:19:29.221	\N	f
4	ecommerce/test/13ROxBLAg	image	webp	2025-05-11 04:19:29.367	2025-05-11 04:19:29.367	\N	f
5	ecommerce/test/30Q3QQbhp	image	jpg	2025-05-11 04:51:25.536	2025-05-11 04:51:25.536	\N	f
6	ecommerce/test/4c5TQBXtM	image	webp	2025-05-11 04:51:25.738	2025-05-11 04:51:25.738	\N	f
7	ecommerce/test/55SI62S4j	image	webp	2025-05-11 04:51:25.739	2025-05-11 04:51:25.739	\N	f
8	ecommerce/test/1ac-T1cbZ	image	webp	2025-05-11 04:51:25.818	2025-05-11 04:51:25.818	\N	f
9	ecommerce/test/6E8rpaNc6	image	jpg	2025-05-11 04:51:27.128	2025-05-11 04:51:27.128	\N	f
10	ecommerce/test/7lbRTZKFu	image	webp	2025-05-11 04:51:27.733	2025-05-11 04:51:27.733	\N	f
11	ecommerce/test/3XOzjGjb-	image	webp	2025-05-11 04:51:27.831	2025-05-11 04:51:27.831	\N	f
12	ecommerce/test/2kJtogosa	image	webp	2025-05-11 04:51:27.832	2025-05-11 04:51:27.832	\N	f
13	ecommerce/test/8AKfzzipX	image	webp	2025-05-11 04:51:29.159	2025-05-11 04:51:29.159	\N	f
14	ecommerce/test/4zg06_vkF	image	jpg	2025-05-11 05:05:54.256	2025-05-11 05:05:54.256	\N	f
15	ecommerce/test/1dd6ctflu	image	webp	2025-05-11 05:05:54.78	2025-05-11 05:05:54.78	\N	f
16	ecommerce/test/3NLNKejGT	image	webp	2025-05-11 05:05:55.052	2025-05-11 05:05:55.052	\N	f
17	ecommerce/test/2UmoHYI_d	image	webp	2025-05-11 05:05:56.111	2025-05-11 05:05:56.111	\N	f
18	ecommerce/test/31mC2Ow6f	image	webp	2025-05-11 05:08:57.361	2025-05-11 05:08:57.361	\N	f
19	ecommerce/test/4QxUZxrhC	image	webp	2025-05-11 05:08:57.71	2025-05-11 05:08:57.71	\N	f
20	ecommerce/test/1pLZ53dK6	image	webp	2025-05-11 05:08:59.949	2025-05-11 05:08:59.949	\N	f
21	ecommerce/test/2A7w-WHjv	image	webp	2025-05-11 05:09:00.133	2025-05-11 05:09:00.133	\N	f
22	ecommerce/test/4LeP-NkxQ	image	webp	2025-05-11 05:12:51.052	2025-05-11 05:12:51.052	\N	f
23	ecommerce/test/3aeMG3q_V	image	webp	2025-05-11 05:12:51.92	2025-05-11 05:12:51.92	\N	f
24	ecommerce/test/6YZSDMUTy	image	webp	2025-05-11 05:12:52.226	2025-05-11 05:12:52.226	\N	f
25	ecommerce/test/2an2Wphq0	image	webp	2025-05-11 05:12:52.369	2025-05-11 05:12:52.369	\N	f
26	ecommerce/test/5ynuOGGyH	image	webp	2025-05-11 05:12:52.474	2025-05-11 05:12:52.474	\N	f
27	ecommerce/test/7v1-1gu2o	image	jpg	2025-05-11 05:12:52.684	2025-05-11 05:12:52.684	\N	f
28	ecommerce/test/1jS1wyPoD	image	webp	2025-05-11 05:12:55.446	2025-05-11 05:12:55.446	\N	f
29	ecommerce/test/4qFAi9Nib	image	webp	2025-05-11 05:15:19.026	2025-05-11 05:15:19.026	\N	f
30	ecommerce/test/1wafGgx8r	image	webp	2025-05-11 05:15:19.321	2025-05-11 05:15:19.321	\N	f
31	ecommerce/test/2QybZXWtF	image	jpg	2025-05-11 05:15:19.322	2025-05-11 05:15:19.322	\N	f
32	ecommerce/test/38VjPn5hR	image	webp	2025-05-11 05:15:19.456	2025-05-11 05:15:19.456	\N	f
33	ecommerce/test/27VhodOUG	image	webp	2025-05-11 05:20:29.107	2025-05-11 05:20:29.107	\N	f
34	ecommerce/test/3DIOfUZ7U	image	webp	2025-05-11 05:20:29.256	2025-05-11 05:20:29.256	\N	f
35	ecommerce/test/4Gpu27wp-	image	webp	2025-05-11 05:20:29.574	2025-05-11 05:20:29.574	\N	f
36	ecommerce/test/1zC-RX4Cb	image	webp	2025-05-11 05:20:30.024	2025-05-11 05:20:30.024	\N	f
37	ecommerce/test/1zqmIrzXk	image	webp	2025-05-11 05:25:14.352	2025-05-11 05:25:14.352	\N	f
38	ecommerce/test/2uymTbwCB	image	webp	2025-05-11 05:25:14.353	2025-05-11 05:25:14.353	\N	f
39	ecommerce/test/4f8ohRou1	image	webp	2025-05-11 05:25:14.7	2025-05-11 05:25:14.7	\N	f
40	ecommerce/test/3uLAW2y_1	image	webp	2025-05-11 05:25:15.146	2025-05-11 05:25:15.146	\N	f
41	ecommerce/test/38Fu3DTej	image	jpg	2025-05-11 05:29:48.243	2025-05-11 05:29:48.243	\N	f
42	ecommerce/test/28pYaSW7E	image	jpg	2025-05-11 05:29:48.288	2025-05-11 05:29:48.288	\N	f
43	ecommerce/test/1IIcv3dCz	image	png	2025-05-11 05:29:48.45	2025-05-11 05:29:48.45	\N	f
44	ecommerce/test/4oOPi-rVV	image	jpg	2025-05-11 05:32:09.518	2025-05-11 05:32:09.518	\N	f
45	ecommerce/test/3ycbIqFyx	image	jpg	2025-05-11 05:32:09.583	2025-05-11 05:32:09.583	\N	f
46	ecommerce/test/2MxQRR9gz	image	jpg	2025-05-11 05:32:09.778	2025-05-11 05:32:09.778	\N	f
47	ecommerce/test/1zYAOxpue	image	jpg	2025-05-11 05:32:11.01	2025-05-11 05:32:11.01	\N	f
48	ecommerce/test/4RzLZxiGF	image	jpg	2025-05-11 05:36:56.274	2025-05-11 05:36:56.274	\N	f
49	ecommerce/test/3ztAdArI5	image	jpg	2025-05-11 05:36:56.276	2025-05-11 05:36:56.276	\N	f
50	ecommerce/test/22nDtAi7b	image	jpg	2025-05-11 05:36:56.577	2025-05-11 05:36:56.577	\N	f
51	ecommerce/test/1y7h-dfZR	image	jpg	2025-05-11 05:36:56.719	2025-05-11 05:36:56.719	\N	f
52	ecommerce/test/4isYzkR9C	image	png	2025-05-11 05:40:15.849	2025-05-11 05:40:15.849	\N	f
53	ecommerce/test/1Qyl05u2X	image	jpg	2025-05-11 05:40:15.849	2025-05-11 05:40:15.849	\N	f
54	ecommerce/test/20hNqLDTk	image	png	2025-05-11 05:40:16.033	2025-05-11 05:40:16.033	\N	f
55	ecommerce/test/3VB0kxlvY	image	png	2025-05-11 05:40:16.122	2025-05-11 05:40:16.122	\N	f
56	ecommerce/test/79wNOLge3	image	webp	2025-05-11 05:44:46.557	2025-05-11 05:44:46.557	\N	f
57	ecommerce/test/1-johGJjc	image	webp	2025-05-11 05:44:46.95	2025-05-11 05:44:46.95	\N	f
58	ecommerce/test/3jEsPsJOY	image	webp	2025-05-11 05:44:47.002	2025-05-11 05:44:47.002	\N	f
59	ecommerce/test/5-E8Y4UDb	image	webp	2025-05-11 05:44:47.411	2025-05-11 05:44:47.411	\N	f
60	ecommerce/test/2xq9xzQG_	image	webp	2025-05-11 05:44:48.981	2025-05-11 05:44:48.981	\N	f
61	ecommerce/test/4OqZdjC_c	image	webp	2025-05-11 05:44:48.981	2025-05-11 05:44:48.981	\N	f
62	ecommerce/test/6o8CwIfp7	image	webp	2025-05-11 05:44:49.748	2025-05-11 05:44:49.748	\N	f
63	ecommerce/test/3K9GMbAfK	image	webp	2025-05-11 05:51:18.06	2025-05-11 05:51:18.06	\N	f
64	ecommerce/test/6GO0ZLipj	image	webp	2025-05-11 05:51:19.074	2025-05-11 05:51:19.074	\N	f
65	ecommerce/test/4lHyyZsbV	image	webp	2025-05-11 05:51:19.726	2025-05-11 05:51:19.726	\N	f
66	ecommerce/test/5Ygu4BpHz	image	webp	2025-05-11 05:51:20.117	2025-05-11 05:51:20.117	\N	f
67	ecommerce/test/6iW1kaPYs	image	jpg	2025-05-11 05:51:20.118	2025-05-11 05:51:20.118	\N	f
68	ecommerce/test/29UinImRy	image	webp	2025-05-11 05:51:20.742	2025-05-11 05:51:20.742	\N	f
69	ecommerce/test/1C3_dGB7X	image	webp	2025-05-11 05:51:21.235	2025-05-11 05:51:21.235	\N	f
70	ecommerce/test/7OAbXkOzL	image	webp	2025-05-11 05:51:23.61	2025-05-11 05:51:23.61	\N	f
71	ecommerce/test/4sdZiZAZO	image	webp	2025-05-11 05:54:57.362	2025-05-11 05:54:57.362	\N	f
72	ecommerce/test/1gRZJmILn	image	webp	2025-05-11 05:54:58.576	2025-05-11 05:54:58.576	\N	f
73	ecommerce/test/8TsbK_43I	image	webp	2025-05-11 05:54:58.8	2025-05-11 05:54:58.8	\N	f
74	ecommerce/test/6iXRRDddH	image	webp	2025-05-11 05:54:58.864	2025-05-11 05:54:58.864	\N	f
75	ecommerce/test/7tkveCut-	image	jpg	2025-05-11 05:54:59.206	2025-05-11 05:54:59.206	\N	f
76	ecommerce/test/2xgsSmQQp	image	webp	2025-05-11 05:54:59.207	2025-05-11 05:54:59.207	\N	f
77	ecommerce/test/5kvYnvfOe	image	webp	2025-05-11 05:54:59.984	2025-05-11 05:54:59.984	\N	f
78	ecommerce/test/3LcK26K9c	image	webp	2025-05-11 05:55:00.429	2025-05-11 05:55:00.429	\N	f
79	ecommerce/test/74Nrt0IJU	image	webp	2025-05-11 06:01:25.873	2025-05-11 06:01:25.873	\N	f
80	ecommerce/test/1XljQVx05	image	webp	2025-05-11 06:01:26.14	2025-05-11 06:01:26.14	\N	f
81	ecommerce/test/3FDmGEYYo	image	webp	2025-05-11 06:01:26.21	2025-05-11 06:01:26.21	\N	f
82	ecommerce/test/4IDJHbpOv	image	webp	2025-05-11 06:01:26.238	2025-05-11 06:01:26.238	\N	f
83	ecommerce/test/2I4O2pn2N	image	webp	2025-05-11 06:01:26.358	2025-05-11 06:01:26.358	\N	f
84	ecommerce/test/5ZsF7cUYD	image	webp	2025-05-11 06:01:27.422	2025-05-11 06:01:27.422	\N	f
85	ecommerce/test/8tys-Qj_t	image	webp	2025-05-11 06:01:27.469	2025-05-11 06:01:27.469	\N	f
86	ecommerce/test/6Huoc0DVn	image	webp	2025-05-11 06:01:28.065	2025-05-11 06:01:28.065	\N	f
87	ecommerce/test/8vtO8yNzy	image	webp	2025-05-11 06:04:30.563	2025-05-11 06:04:30.563	\N	f
88	ecommerce/test/5RwnmohcM	image	webp	2025-05-11 06:04:30.803	2025-05-11 06:04:30.803	\N	f
89	ecommerce/test/4VrK9vudp	image	webp	2025-05-11 06:04:32.316	2025-05-11 06:04:32.316	\N	f
90	ecommerce/test/1ag5OgXey	image	webp	2025-05-11 06:04:32.521	2025-05-11 06:04:32.521	\N	f
91	ecommerce/test/3HoaVesJF	image	webp	2025-05-11 06:04:32.522	2025-05-11 06:04:32.522	\N	f
92	ecommerce/test/7LeXkOq6h	image	jpg	2025-05-11 06:04:33.431	2025-05-11 06:04:33.431	\N	f
93	ecommerce/test/2J2y97I6j	image	webp	2025-05-11 06:04:34.965	2025-05-11 06:04:34.965	\N	f
94	ecommerce/test/6eU7Bmhey	image	webp	2025-05-11 06:04:35.562	2025-05-11 06:04:35.562	\N	f
95	ecommerce/test/4rYnGkSgw	image	webp	2025-05-11 06:08:05.558	2025-05-11 06:08:05.558	\N	f
96	ecommerce/test/2yBU6ZJ4X	image	webp	2025-05-11 06:08:05.559	2025-05-11 06:08:05.559	\N	f
97	ecommerce/test/3EPRKf6T0	image	webp	2025-05-11 06:08:05.732	2025-05-11 06:08:05.732	\N	f
98	ecommerce/test/8NXLGSiIA	image	webp	2025-05-11 06:08:06.039	2025-05-11 06:08:06.039	\N	f
99	ecommerce/test/5DbPMRGx4	image	webp	2025-05-11 06:08:06.41	2025-05-11 06:08:06.41	\N	f
100	ecommerce/test/7sR1EpMab	image	jpg	2025-05-11 06:08:08.101	2025-05-11 06:08:08.101	\N	f
101	ecommerce/test/1ti4fCkni	image	webp	2025-05-11 06:08:08.185	2025-05-11 06:08:08.185	\N	f
102	ecommerce/test/67As7VDc2	image	webp	2025-05-11 06:08:08.8	2025-05-11 06:08:08.8	\N	f
103	ecommerce/test/4j9pKwhaT	image	webp	2025-05-11 06:10:30.232	2025-05-11 06:10:30.232	\N	f
104	ecommerce/test/5G0UoiSK2	image	webp	2025-05-11 06:10:30.439	2025-05-11 06:10:30.439	\N	f
105	ecommerce/test/395hpnkkg	image	jpg	2025-05-11 06:10:30.921	2025-05-11 06:10:30.921	\N	f
106	ecommerce/test/78jwDco9f	image	webp	2025-05-11 06:10:30.943	2025-05-11 06:10:30.943	\N	f
107	ecommerce/test/2IXMDF3b9	image	webp	2025-05-11 06:10:31.133	2025-05-11 06:10:31.133	\N	f
108	ecommerce/test/1y5IMw_9a	image	webp	2025-05-11 06:10:31.671	2025-05-11 06:10:31.671	\N	f
109	ecommerce/test/6LtxFdsd3	image	webp	2025-05-11 06:10:31.842	2025-05-11 06:10:31.842	\N	f
110	ecommerce/test/2NfyGOGSJ	image	webp	2025-05-11 06:13:23.839	2025-05-11 06:13:23.839	\N	f
111	ecommerce/test/17fJg8NAR	image	webp	2025-05-11 06:13:24.48	2025-05-11 06:13:24.48	\N	f
112	ecommerce/test/8CknTAZd6	image	webp	2025-05-11 06:13:24.616	2025-05-11 06:13:24.616	\N	f
113	ecommerce/test/4ILMe1YNP	image	webp	2025-05-11 06:13:24.744	2025-05-11 06:13:24.744	\N	f
114	ecommerce/test/5x6538-_Y	image	webp	2025-05-11 06:13:25.044	2025-05-11 06:13:25.044	\N	f
115	ecommerce/test/6lD2JO4TI	image	jpg	2025-05-11 06:13:25.211	2025-05-11 06:13:25.211	\N	f
116	ecommerce/test/77kY2LB4q	image	webp	2025-05-11 06:13:26.231	2025-05-11 06:13:26.231	\N	f
117	ecommerce/test/3vbdPJLdr	image	webp	2025-05-11 06:13:26.652	2025-05-11 06:13:26.652	\N	f
118	ecommerce/test/8xtZj-TJS	image	webp	2025-05-11 06:16:25.197	2025-05-11 06:16:25.197	\N	f
119	ecommerce/test/53_VI6j6o	image	webp	2025-05-11 06:16:25.434	2025-05-11 06:16:25.434	\N	f
120	ecommerce/test/7upNhhoEp	image	webp	2025-05-11 06:16:25.566	2025-05-11 06:16:25.566	\N	f
121	ecommerce/test/6P9-Rruyv	image	webp	2025-05-11 06:16:25.758	2025-05-11 06:16:25.758	\N	f
122	ecommerce/test/2JBalJOSh	image	webp	2025-05-11 06:16:25.873	2025-05-11 06:16:25.873	\N	f
123	ecommerce/test/1NSdLIfNg	image	webp	2025-05-11 06:16:26.646	2025-05-11 06:16:26.646	\N	f
124	ecommerce/test/9ocLgKdjm	image	webp	2025-05-11 06:16:27.566	2025-05-11 06:16:27.566	\N	f
125	ecommerce/test/10YPhCPCcL	image	webp	2025-05-11 06:16:27.632	2025-05-11 06:16:27.632	\N	f
126	ecommerce/test/3ooH-SY4Q	image	webp	2025-05-11 06:16:28.811	2025-05-11 06:16:28.811	\N	f
127	ecommerce/test/4BuKEL6uW	image	webp	2025-05-11 06:16:30.516	2025-05-11 06:16:30.516	\N	f
128	ecommerce/test/7UKPBTcum	image	webp	2025-05-11 06:19:20.273	2025-05-11 06:19:20.273	\N	f
129	ecommerce/test/1QbJzrMe-	image	webp	2025-05-11 06:19:20.952	2025-05-11 06:19:20.952	\N	f
130	ecommerce/test/5Jz_7pvep	image	webp	2025-05-11 06:19:21.255	2025-05-11 06:19:21.255	\N	f
131	ecommerce/test/454vT40OT	image	webp	2025-05-11 06:19:21.407	2025-05-11 06:19:21.407	\N	f
132	ecommerce/test/3aKrj0jsP	image	webp	2025-05-11 06:19:21.919	2025-05-11 06:19:21.919	\N	f
133	ecommerce/test/6w86sVDvS	image	jpg	2025-05-11 06:19:22.121	2025-05-11 06:19:22.121	\N	f
134	ecommerce/test/8tmi2U0VE	image	webp	2025-05-11 06:19:22.417	2025-05-11 06:19:22.417	\N	f
135	ecommerce/test/2W-4GA584	image	webp	2025-05-11 06:19:23.238	2025-05-11 06:19:23.238	\N	f
136	ecommerce/test/8Yza8Z9Nv	image	webp	2025-05-11 06:27:09.828	2025-05-11 06:27:09.828	\N	f
137	ecommerce/test/3J-r2EpQ2	image	webp	2025-05-11 06:27:09.877	2025-05-11 06:27:09.877	\N	f
138	ecommerce/test/5XS68HDwC	image	webp	2025-05-11 06:27:10.477	2025-05-11 06:27:10.477	\N	f
139	ecommerce/test/2udSew6f0	image	webp	2025-05-11 06:27:10.897	2025-05-11 06:27:10.897	\N	f
140	ecommerce/test/96fG_DMwK	image	webp	2025-05-11 06:27:11.305	2025-05-11 06:27:11.305	\N	f
141	ecommerce/test/6743jdzKy	image	webp	2025-05-11 06:27:12.76	2025-05-11 06:27:12.76	\N	f
142	ecommerce/test/7mpFizL2b	image	webp	2025-05-11 06:27:13.449	2025-05-11 06:27:13.449	\N	f
143	ecommerce/test/47M_YHq9d	image	png	2025-05-11 06:27:14.081	2025-05-11 06:27:14.081	\N	f
144	ecommerce/test/1Sl-cLeIX	image	webp	2025-05-11 06:27:14.691	2025-05-11 06:27:14.691	\N	f
145	ecommerce/test/4e2CVgDvy	image	webp	2025-05-11 06:30:18.371	2025-05-11 06:30:18.371	\N	f
146	ecommerce/test/28abBfYIT	image	webp	2025-05-11 06:30:18.664	2025-05-11 06:30:18.664	\N	f
147	ecommerce/test/8DoAzveiB	image	webp	2025-05-11 06:30:18.986	2025-05-11 06:30:18.986	\N	f
148	ecommerce/test/5qkpKz8n7	image	webp	2025-05-11 06:30:19.045	2025-05-11 06:30:19.045	\N	f
149	ecommerce/test/33bPn6BWA	image	webp	2025-05-11 06:30:19.81	2025-05-11 06:30:19.81	\N	f
150	ecommerce/test/6ihn7g2ta	image	webp	2025-05-11 06:30:19.906	2025-05-11 06:30:19.906	\N	f
151	ecommerce/test/1ryw2u_TZ	image	webp	2025-05-11 06:30:20.316	2025-05-11 06:30:20.316	\N	f
152	ecommerce/test/7CsfXKlzj	image	jpg	2025-05-11 06:30:20.565	2025-05-11 06:30:20.565	\N	f
153	ecommerce/test/8erNn_eH7	image	webp	2025-05-11 06:33:10.525	2025-05-11 06:33:10.525	\N	f
154	ecommerce/test/7i0br0IHC	image	jpg	2025-05-11 06:33:10.818	2025-05-11 06:33:10.818	\N	f
155	ecommerce/test/5kKCIM8c8	image	jpg	2025-05-11 06:33:10.852	2025-05-11 06:33:10.852	\N	f
156	ecommerce/test/40tf024Bi	image	webp	2025-05-11 06:33:10.918	2025-05-11 06:33:10.918	\N	f
157	ecommerce/test/1-JeO1Wo-	image	webp	2025-05-11 06:33:11.02	2025-05-11 06:33:11.02	\N	f
158	ecommerce/test/6Bg6343_o	image	jpg	2025-05-11 06:33:11.161	2025-05-11 06:33:11.161	\N	f
159	ecommerce/test/2nKtozEce	image	webp	2025-05-11 06:33:11.735	2025-05-11 06:33:11.735	\N	f
160	ecommerce/test/3XH9hr860	image	webp	2025-05-11 06:33:12.546	2025-05-11 06:33:12.546	\N	f
161	ecommerce/test/4El3Pq-I6	image	webp	2025-05-11 06:36:07.273	2025-05-11 06:36:07.273	\N	f
162	ecommerce/test/2lmMGDPvA	image	webp	2025-05-11 06:36:07.273	2025-05-11 06:36:07.273	\N	f
163	ecommerce/test/8Wl8KnBWz	image	webp	2025-05-11 06:36:07.569	2025-05-11 06:36:07.569	\N	f
164	ecommerce/test/53s2waA4I	image	webp	2025-05-11 06:36:07.57	2025-05-11 06:36:07.57	\N	f
165	ecommerce/test/6XzozpmAf	image	webp	2025-05-11 06:36:08.056	2025-05-11 06:36:08.056	\N	f
166	ecommerce/test/3ghDumyvz	image	webp	2025-05-11 06:36:08.089	2025-05-11 06:36:08.089	\N	f
167	ecommerce/test/7rpHfF5_W	image	jpg	2025-05-11 06:36:08.851	2025-05-11 06:36:08.851	\N	f
168	ecommerce/test/1PDWtfxdZ	image	webp	2025-05-11 06:36:08.984	2025-05-11 06:36:08.984	\N	f
169	ecommerce/test/1388T9GHR	image	webp	2025-05-11 06:38:58.895	2025-05-11 06:38:58.895	\N	f
170	ecommerce/test/2CN2N4bZ5	image	webp	2025-05-11 06:38:59.09	2025-05-11 06:38:59.09	\N	f
171	ecommerce/test/4PXurmsX0	image	webp	2025-05-11 06:38:59.529	2025-05-11 06:38:59.529	\N	f
172	ecommerce/test/3VuWzToU8	image	jpg	2025-05-11 06:38:59.814	2025-05-11 06:38:59.814	\N	f
173	ecommerce/test/8oCUjeJXa	image	webp	2025-05-11 06:39:00.238	2025-05-11 06:39:00.238	\N	f
174	ecommerce/test/7PxsYOSBH	image	webp	2025-05-11 06:39:00.793	2025-05-11 06:39:00.793	\N	f
175	ecommerce/test/5qSK7WNSu	image	jpg	2025-05-11 06:39:01.361	2025-05-11 06:39:01.361	\N	f
176	ecommerce/test/6lHEskuqz	image	webp	2025-05-11 06:39:05.005	2025-05-11 06:39:05.005	\N	f
177	ecommerce/test/7cG_wdKjJ	image	webp	2025-05-11 06:41:07.056	2025-05-11 06:41:07.056	\N	f
178	ecommerce/test/3DYtjCnu4	image	webp	2025-05-11 06:41:07.462	2025-05-11 06:41:07.462	\N	f
179	ecommerce/test/5w9guf8SQ	image	webp	2025-05-11 06:41:07.486	2025-05-11 06:41:07.486	\N	f
180	ecommerce/test/8wmMQcC7_	image	webp	2025-05-11 06:41:07.791	2025-05-11 06:41:07.791	\N	f
181	ecommerce/test/2YcR0kOo1	image	webp	2025-05-11 06:41:07.843	2025-05-11 06:41:07.843	\N	f
182	ecommerce/test/6u2q3NwvP	image	webp	2025-05-11 06:41:07.947	2025-05-11 06:41:07.947	\N	f
183	ecommerce/test/1gs-lCa2x	image	webp	2025-05-11 06:41:08.516	2025-05-11 06:41:08.516	\N	f
184	ecommerce/test/4cdvbJGsP	image	webp	2025-05-11 06:41:08.956	2025-05-11 06:41:08.956	\N	f
185	ecommerce/test/3Wf4sLijl	image	webp	2025-05-11 06:43:00.739	2025-05-11 06:43:00.739	\N	f
186	ecommerce/test/7rEOs1xvD	image	webp	2025-05-11 06:43:00.834	2025-05-11 06:43:00.834	\N	f
187	ecommerce/test/8_FhJyKsu	image	webp	2025-05-11 06:43:00.998	2025-05-11 06:43:00.998	\N	f
188	ecommerce/test/1MkuaEJ9B	image	webp	2025-05-11 06:43:01.058	2025-05-11 06:43:01.058	\N	f
189	ecommerce/test/67JnNGSnI	image	webp	2025-05-11 06:43:01.462	2025-05-11 06:43:01.462	\N	f
190	ecommerce/test/5HgcL7zS1	image	webp	2025-05-11 06:43:02.062	2025-05-11 06:43:02.062	\N	f
191	ecommerce/test/2T_YM8mWl	image	webp	2025-05-11 06:43:02.676	2025-05-11 06:43:02.676	\N	f
192	ecommerce/test/42VGvH1O9	image	webp	2025-05-11 06:43:02.782	2025-05-11 06:43:02.782	\N	f
2000	ecommerce/test/user-avatarGTTDTV-Y	image	png	2025-05-15 12:04:19.104	2025-05-15 12:04:19.104	\N	f
2001	ecommerce/test/user-avatarGTTDTV-Y	image	png	2025-05-15 12:08:59.121	2025-05-15 12:08:59.121	\N	f
2002	ecommerce/test/user-avatarWzXk9uUE	image	png	2025-05-15 12:10:12.92	2025-05-15 12:10:12.92	\N	f
2003	ecommerce/test/user-avatarAGz9agSD	image	png	2025-05-17 15:15:57.432	2025-05-17 15:15:57.432	\N	f
2004	ecommerce/test/logoxVjsZThD	image	png	2025-05-19 04:02:44.943	2025-05-19 04:02:44.943	\N	f
2005	ecommerce/test/Screenshot from 2025-05-11 13-49-01Jr8Coc7R	image	png	2025-05-19 04:38:03.684	2025-05-19 04:38:03.684	\N	f
2006	ecommerce/test/Screenshot from 2025-05-05 20-47-27fxbDP4_f	image	png	2025-05-19 04:38:03.899	2025-05-19 04:38:03.899	\N	f
2007	ecommerce/test/Screenshot from 2025-05-05 21-39-25AD-aZEN7	image	png	2025-05-19 04:38:05.09	2025-05-19 04:38:05.09	\N	f
2008	ecommerce/test/Screenshot from 2025-05-14 15-24-51OWkqArUL	image	png	2025-05-19 04:38:05.091	2025-05-19 04:38:05.091	\N	f
2009	ecommerce/test/Screenshot from 2025-05-14 17-27-15RqoeBOL1	image	png	2025-05-19 04:38:05.428	2025-05-19 04:38:05.428	\N	f
2010	ecommerce/test/Screenshot from 2025-05-11 18-45-44uKLncH0-	image	png	2025-05-19 04:38:05.806	2025-05-19 04:38:05.806	\N	f
2011	ecommerce/test/Screenshot from 2025-05-16 19-19-00QWd80EM6	image	png	2025-05-19 04:38:05.918	2025-05-19 04:38:05.918	\N	f
2012	ecommerce/test/Screenshot from 2025-05-10 11-37-17zx6ZzMBC	image	png	2025-05-19 04:38:06.281	2025-05-19 04:38:06.281	\N	f
2013	ecommerce/test/Screenshot from 2025-05-15 18-05-51iwopLI6_	image	png	2025-05-19 04:38:07.382	2025-05-19 04:38:07.382	\N	f
2014	ecommerce/test/Screenshot from 2025-05-16 19-17-39dmiKTQTl	image	png	2025-05-19 04:38:09.424	2025-05-19 04:38:09.424	\N	f
2015	ecommerce/test/tinh-dau-lan-tinh_sp2xBcwVe3As	image	webp	2025-06-21 07:01:08.843	2025-06-21 07:01:08.843	\N	f
2016	ecommerce/test/tinh-dau-lan-tinh_sp2xk3iMrixV	image	webp	2025-06-21 07:11:21.299	2025-06-21 07:11:21.299	\N	f
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.reviews (id, content, rating, user_id, product_id, created_at, updated_at, deleted_at, order_item_id, response) FROM stdin;
1	Sp rất tốt	5	1	1	2025-06-20 05:01:13.062	\N	\N	59	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.roles (id, name, created_at, updated_at) FROM stdin;
1	ADMIN	2025-05-14 01:35:14.722	\N
2	USER	2025-05-14 01:35:14.722	\N
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.suppliers (id, name, email, phone, country, website, status, address_id, created_at, updated_at, deleted_at) FROM stdin;
11	Jade Bloom	contact@jadebloom.vn	0909123456	Vietnam	https://www.jadebloom.com	ACTIVE	4	2025-04-27 04:07:50.683	2025-04-27 04:07:50.683	\N
12	doTERRA	contact@doterra.vn	0911123456	Vietnam	https://www.doterra.com	ACTIVE	5	2025-04-27 04:07:50.683	2025-04-27 04:07:50.683	\N
13	Edens Garden	contact@edensgarden.vn	0988123456	Vietnam	https://www.edensgarden.com	ACTIVE	6	2025-04-27 04:07:50.683	2025-04-27 04:07:50.683	\N
15	Young Living	contact@youngliving.vn	0985635273	America	https://www.youngliving.com	ACTIVE	7	2025-04-27 04:11:26.836	\N	\N
16	Rocky Mountain Oils	contact@rockymountainoils.vn	0963647462	Franch	https://www.rockymountainoils.com	ACTIVE	8	2025-04-27 04:13:49.383	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, email, name, password, phone, avatar, status, dob, role_id, created_at, updated_at, deleted_at) FROM stdin;
2	user2@example.com	John Doe	fake_password_hash	1234567890	\N	ACTIVE	1995-06-15	2	2025-05-14 11:13:54.136	\N	\N
3	user3@example.com	Jane Smith	fake_password_hash	1234567891	\N	INACTIVE	1990-09-22	2	2025-05-14 11:13:54.136	\N	\N
4	user4@example.com	Alice Johnson	fake_password_hash	1234567892	\N	BLOCKED	1988-04-10	2	2025-05-14 11:13:54.136	\N	\N
5	user5@example.com	Bob Brown	fake_password_hash	1234567893	\N	ACTIVE	1992-01-03	2	2025-05-14 11:13:54.136	\N	\N
6	user6@example.com	Charlie Davis	fake_password_hash	1234567894	\N	INACTIVE	1997-07-19	2	2025-05-14 11:13:54.136	\N	\N
7	user7@example.com	Diana Evans	fake_password_hash	1234567895	\N	BLOCKED	1985-11-11	2	2025-05-14 11:13:54.136	\N	\N
8	user8@example.com	Edward Ford	fake_password_hash	1234567896	\N	ACTIVE	1993-03-07	2	2025-05-14 11:13:54.136	\N	\N
9	user9@example.com	Fiona Green	fake_password_hash	1234567897	\N	INACTIVE	1989-10-30	2	2025-05-14 11:13:54.136	\N	\N
10	user10@example.com	George Hill	fake_password_hash	1234567898	\N	BLOCKED	1996-08-25	2	2025-05-14 11:13:54.136	\N	\N
12	user12@example.com	Ian Jones	fake_password_hash	1234567800	\N	INACTIVE	1994-12-21	2	2025-05-14 11:13:54.136	\N	\N
13	user13@example.com	Julia King	fake_password_hash	1234567801	\N	BLOCKED	1987-06-09	2	2025-05-14 11:13:54.136	\N	\N
14	user14@example.com	Kevin Lee	fake_password_hash	1234567802	\N	ACTIVE	1998-05-17	2	2025-05-14 11:13:54.136	\N	\N
15	user15@example.com	Laura Miller	fake_password_hash	1234567803	\N	INACTIVE	1993-03-12	2	2025-05-14 11:13:54.136	\N	\N
16	user16@example.com	Mike Nelson	fake_password_hash	1234567804	\N	BLOCKED	1990-01-29	2	2025-05-14 11:13:54.136	\N	\N
17	user17@example.com	Nina Owens	fake_password_hash	1234567805	\N	ACTIVE	1986-09-03	2	2025-05-14 11:13:54.136	\N	\N
18	user18@example.com	Oscar Perez	fake_password_hash	1234567806	\N	INACTIVE	1995-04-06	2	2025-05-14 11:13:54.136	\N	\N
19	user19@example.com	Paula Quinn	fake_password_hash	1234567807	\N	BLOCKED	1992-08-28	2	2025-05-14 11:13:54.136	\N	\N
20	user20@example.com	Quinn Roberts	fake_password_hash	1234567808	\N	ACTIVE	1984-10-15	2	2025-05-14 11:13:54.136	\N	\N
21	user21@example.com	Rachel Stone	fake_password_hash	1234567809	\N	INACTIVE	1999-12-01	2	2025-05-14 11:13:54.136	\N	\N
22	user22@example.com	Sam Turner	fake_password_hash	1234567810	\N	BLOCKED	1983-07-23	2	2025-05-14 11:13:54.136	\N	\N
23	user23@example.com	Tina Underwood	fake_password_hash	1234567811	\N	ACTIVE	1996-02-17	2	2025-05-14 11:13:54.136	\N	\N
24	user24@example.com	Ulysses Vega	fake_password_hash	1234567812	\N	INACTIVE	1982-06-18	2	2025-05-14 11:13:54.136	\N	\N
25	user25@example.com	Victoria White	fake_password_hash	1234567813	\N	BLOCKED	1994-01-05	2	2025-05-14 11:13:54.136	\N	\N
26	user26@example.com	Walter Xiong	fake_password_hash	1234567814	\N	ACTIVE	1989-11-27	2	2025-05-14 11:13:54.136	\N	\N
27	user27@example.com	Xena Young	fake_password_hash	1234567815	\N	INACTIVE	1990-05-09	2	2025-05-14 11:13:54.136	\N	\N
28	user28@example.com	Yusuf Zane	fake_password_hash	1234567816	\N	BLOCKED	1988-03-14	2	2025-05-14 11:13:54.136	\N	\N
29	user29@example.com	Zara Allen	fake_password_hash	1234567817	\N	ACTIVE	1985-12-31	2	2025-05-14 11:13:54.136	\N	\N
30	user30@example.com	Aaron Blue	fake_password_hash	1234567818	\N	INACTIVE	1997-07-01	2	2025-05-14 11:13:54.136	\N	\N
11	user11@example.com	Hannah Irving	fake_password_hash	1234567899	\N	BLOCKED	1991-02-14	2	2025-05-14 11:13:54.136	2025-05-15 03:25:59.375	\N
31	alt.x2-ejpjo30@yopmail.com	Lê Anh Đức	$argon2id$v=19$m=65536,t=3,p=4$KQAdwtHm9YAwQdoE3wFs1g$WKzGzf/MFH64wDJ2iiaJK8l/pQgOa6X5wFrW4g45Mzk			INACTIVE	\N	2	2025-05-30 15:37:08.674	2025-05-30 15:37:08.674	\N
1	ducvui2003@gmail.com	Le Anh Đức	$argon2id$v=19$m=65536,t=3,p=4$RWU4vr16nGLLaaZdMbXU9A$p5TcGkfd8ihHdA1RzD9uTmHssKneIeMg/+JryhyBav0	0965809129	http://res.cloudinary.com/yourstyle/image/upload/v1747746790/ecommerce/user/images.png	ACTIVE	1995-06-15	1	2025-05-14 01:35:14.722	2025-05-21 04:00:06.723	\N
\.


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wishlists (id, user_id, product_id, created_at) FROM stdin;
15	1	7	2025-06-15 09:49:42.159
16	1	2	2025-06-15 09:57:29.956
\.


--
-- Name: CommentLike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."CommentLike_id_seq"', 1, true);


--
-- Name: abouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.abouts_id_seq', 1, false);


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.carts_id_seq', 2, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, false);


--
-- Name: faqs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.faqs_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.options_id_seq', 15, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.order_items_id_seq', 98, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.orders_id_seq', 99, true);


--
-- Name: payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.payment_id_seq', 93, true);


--
-- Name: payment_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.payment_transaction_id_seq', 44, true);


--
-- Name: policies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.policies_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.products_id_seq', 52, true);


--
-- Name: promotion_order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.promotion_order_items_id_seq', 1, false);


--
-- Name: promotion_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.promotion_orders_id_seq', 1, false);


--
-- Name: promotions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.promotions_id_seq', 1, false);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.resources_id_seq', 2016, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 31, true);


--
-- Name: wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wishlists_id_seq', 23, true);


--
-- Name: CommentLike CommentLike_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: abouts abouts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.abouts
    ADD CONSTRAINT abouts_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: faqs faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: payment_transaction payment_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (id);


--
-- Name: policies policies_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_pkey PRIMARY KEY (id);


--
-- Name: product_resources product_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT product_resources_pkey PRIMARY KEY (product_id, resource_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: promotion_order_items promotion_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_order_items
    ADD CONSTRAINT promotion_order_items_pkey PRIMARY KEY (id);


--
-- Name: promotion_orders promotion_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_orders
    ADD CONSTRAINT promotion_orders_pkey PRIMARY KEY (id);


--
-- Name: promotions promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wishlists wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: CommentLike_userId_commentId_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "CommentLike_userId_commentId_key" ON public."CommentLike" USING btree ("userId", "commentId");


--
-- Name: cart_items_cart_id_product_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX cart_items_cart_id_product_id_key ON public.cart_items USING btree (cart_id, product_id);


--
-- Name: cart_items_cart_id_product_id_option_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX cart_items_cart_id_product_id_option_id_key ON public.cart_items USING btree (cart_id, product_id, option_id);


--
-- Name: carts_user_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX carts_user_id_key ON public.carts USING btree (user_id);


--
-- Name: payment_order_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX payment_order_id_key ON public.payment USING btree (order_id);


--
-- Name: promotions_code_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX promotions_code_key ON public.promotions USING btree (code);


--
-- Name: reviews_order_item_id_user_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX reviews_order_item_id_user_id_key ON public.reviews USING btree (order_item_id, user_id);


--
-- Name: roles_name_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX roles_name_key ON public.roles USING btree (name);


--
-- Name: suppliers_address_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX suppliers_address_id_key ON public.suppliers USING btree (address_id);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: wishlists_user_id_product_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX wishlists_user_id_product_id_key ON public.wishlists USING btree (user_id, product_id);


--
-- Name: addresses addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cart_items cart_items_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.options(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: cart_items cart_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: carts carts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comments comments_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: options options_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: options options_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment payment_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_resources product_resources_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT product_resources_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_resources product_resources_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT product_resources_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: products products_thumbnail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_thumbnail_id_fkey FOREIGN KEY (thumbnail_id) REFERENCES public.resources(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: promotion_order_items promotion_order_items_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_order_items
    ADD CONSTRAINT promotion_order_items_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: promotion_order_items promotion_order_items_promotion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_order_items
    ADD CONSTRAINT promotion_order_items_promotion_id_fkey FOREIGN KEY (promotion_id) REFERENCES public.promotions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: promotion_orders promotion_orders_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_orders
    ADD CONSTRAINT promotion_orders_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: promotion_orders promotion_orders_promotion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.promotion_orders
    ADD CONSTRAINT promotion_orders_promotion_id_fkey FOREIGN KEY (promotion_id) REFERENCES public.promotions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reviews reviews_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: suppliers suppliers_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: wishlists wishlists_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wishlists wishlists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wishlists
    ADD CONSTRAINT wishlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: root
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict bgCCaUbCDABe0DYs3GsWXxCU2qk1DYTzkHcTg784LTcJn5q4BQdVRAi2fDYdE0f

