--
-- PostgreSQL database dump
--

\restrict dSqVMJyyP414z0Y3T2Tk9WjHVoXw4rJPMGdYHxLwZqnEdmgbgEq8vFGjg4fl76f

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-15 11:04:40

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
-- TOC entry 233 (class 1259 OID 17240)
-- Name: course_prerequisites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_prerequisites (
    course_id integer NOT NULL,
    prerequisite_course_id integer NOT NULL,
    CONSTRAINT course_prerequisites_check CHECK ((course_id <> prerequisite_course_id))
);


ALTER TABLE public.course_prerequisites OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17150)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_code character varying(20) NOT NULL,
    course_name character varying(100) NOT NULL,
    credits integer NOT NULL,
    department_id integer NOT NULL,
    instructor_id integer NOT NULL,
    CONSTRAINT courses_credits_check CHECK ((credits > 0))
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17149)
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_course_id_seq OWNER TO postgres;

--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 225
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- TOC entry 220 (class 1259 OID 17078)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    department_id integer NOT NULL,
    department_name character varying(100) NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17077)
-- Name: departments_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_department_id_seq OWNER TO postgres;

--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 219
-- Name: departments_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_department_id_seq OWNED BY public.departments.department_id;


--
-- TOC entry 228 (class 1259 OID 17176)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    enrollment_id integer NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    semester character varying(20) NOT NULL,
    enrollment_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17175)
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollments_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 227
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNED BY public.enrollments.enrollment_id;


--
-- TOC entry 230 (class 1259 OID 17200)
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    grade_id integer NOT NULL,
    enrollment_id integer NOT NULL,
    marks numeric(5,2),
    grade character varying(2),
    grade_point numeric(4,2),
    CONSTRAINT grades_marks_check CHECK (((marks >= (0)::numeric) AND (marks <= (100)::numeric)))
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17199)
-- Name: grades_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grades_grade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grades_grade_id_seq OWNER TO postgres;

--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 229
-- Name: grades_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grades_grade_id_seq OWNED BY public.grades.grade_id;


--
-- TOC entry 224 (class 1259 OID 17132)
-- Name: instructors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructors (
    instructor_id integer NOT NULL,
    instructor_name character varying(100) NOT NULL,
    email character varying(100),
    department_id integer NOT NULL
);


ALTER TABLE public.instructors OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17131)
-- Name: instructors_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructors_instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructors_instructor_id_seq OWNER TO postgres;

--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 223
-- Name: instructors_instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructors_instructor_id_seq OWNED BY public.instructors.instructor_id;


--
-- TOC entry 232 (class 1259 OID 17228)
-- Name: student_certifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_certifications (
    student_id integer NOT NULL,
    certification character varying(100) NOT NULL
);


ALTER TABLE public.student_certifications OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17216)
-- Name: student_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_languages (
    student_id integer NOT NULL,
    language character varying(50) NOT NULL
);


ALTER TABLE public.student_languages OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17111)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    roll_number character varying(20) NOT NULL,
    student_name character varying(100) NOT NULL,
    email character varying(100),
    gender character varying(10),
    date_of_birth date,
    department_id integer NOT NULL,
    admission_year integer NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17110)
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 221
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;


--
-- TOC entry 4896 (class 2604 OID 17153)
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 17081)
-- Name: departments department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN department_id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 17179)
-- Name: enrollments enrollment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN enrollment_id SET DEFAULT nextval('public.enrollments_enrollment_id_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 17203)
-- Name: grades grade_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades ALTER COLUMN grade_id SET DEFAULT nextval('public.grades_grade_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 17135)
-- Name: instructors instructor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructors ALTER COLUMN instructor_id SET DEFAULT nextval('public.instructors_instructor_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 17114)
-- Name: students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- TOC entry 5111 (class 0 OID 17240)
-- Dependencies: 233
-- Data for Name: course_prerequisites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_prerequisites (course_id, prerequisite_course_id) FROM stdin;
14	13
15	13
18	17
\.


--
-- TOC entry 5104 (class 0 OID 17150)
-- Dependencies: 226
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, course_code, course_name, credits, department_id, instructor_id) FROM stdin;
13	CS101	DBMS	4	5	17
14	CS102	Python Programming	4	5	18
15	CS103	Computer Networks	3	5	17
16	IT101	Web Technologies	3	6	19
17	DS101	Data Analytics	4	7	20
18	DS102	Machine Learning	4	7	20
\.


--
-- TOC entry 5098 (class 0 OID 17078)
-- Dependencies: 220
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (department_id, department_name) FROM stdin;
5	Computer Science
6	Information Technology
7	Data Science
8	Electronics
\.


--
-- TOC entry 5106 (class 0 OID 17176)
-- Dependencies: 228
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (enrollment_id, student_id, course_id, semester, enrollment_date) FROM stdin;
1	16	13	Semester 1	2025-07-01
2	16	14	Semester 1	2025-07-01
3	16	15	Semester 1	2025-07-01
4	17	13	Semester 1	2025-07-01
5	17	14	Semester 1	2025-07-01
6	17	15	Semester 1	2025-07-01
7	18	16	Semester 1	2025-07-01
8	19	17	Semester 1	2025-07-01
9	19	18	Semester 1	2025-07-01
10	20	17	Semester 1	2025-07-01
11	20	18	Semester 1	2025-07-01
12	22	13	Semester 1	2025-08-01
13	22	14	Semester 1	2025-08-01
14	22	15	Semester 1	2025-08-01
15	22	17	Semester 2	2025-08-01
16	22	18	Semester 2	2025-08-01
17	22	16	Semester 2	2025-08-01
18	23	13	Semester 1	2025-08-01
19	23	14	Semester 1	2025-08-01
20	23	15	Semester 1	2025-08-01
21	23	17	Semester 2	2025-08-01
22	23	18	Semester 2	2025-08-01
23	23	16	Semester 2	2025-08-01
24	24	13	Semester 1	2025-08-01
25	24	14	Semester 1	2025-08-01
26	24	15	Semester 1	2025-08-01
27	24	17	Semester 2	2025-08-01
28	24	18	Semester 2	2025-08-01
29	24	16	Semester 2	2025-08-01
30	25	13	Semester 1	2025-08-01
31	25	14	Semester 1	2025-08-01
32	25	15	Semester 1	2025-08-01
33	25	17	Semester 2	2025-08-01
34	25	18	Semester 2	2025-08-01
35	25	16	Semester 2	2025-08-01
36	26	13	Semester 1	2025-08-01
37	26	14	Semester 1	2025-08-01
38	26	15	Semester 1	2025-08-01
39	26	17	Semester 2	2025-08-01
40	26	18	Semester 2	2025-08-01
41	26	16	Semester 2	2025-08-01
42	27	13	Semester 1	2025-08-01
43	27	14	Semester 1	2025-08-01
44	27	15	Semester 1	2025-08-01
45	27	17	Semester 2	2025-08-01
46	27	18	Semester 2	2025-08-01
47	27	16	Semester 2	2025-08-01
48	28	13	Semester 1	2025-08-01
49	28	14	Semester 1	2025-08-01
50	28	15	Semester 1	2025-08-01
51	28	17	Semester 2	2025-08-01
52	28	18	Semester 2	2025-08-01
53	28	16	Semester 2	2025-08-01
54	29	13	Semester 1	2025-08-01
55	29	14	Semester 1	2025-08-01
56	29	15	Semester 1	2025-08-01
57	29	17	Semester 2	2025-08-01
58	29	18	Semester 2	2025-08-01
59	29	16	Semester 2	2025-08-01
60	30	13	Semester 1	2025-08-01
61	30	14	Semester 1	2025-08-01
62	30	15	Semester 1	2025-08-01
63	30	17	Semester 2	2025-08-01
64	30	18	Semester 2	2025-08-01
65	30	16	Semester 2	2025-08-01
66	31	13	Semester 1	2025-08-01
67	31	14	Semester 1	2025-08-01
68	31	15	Semester 1	2025-08-01
69	31	17	Semester 2	2025-08-01
70	31	18	Semester 2	2025-08-01
71	31	16	Semester 2	2025-08-01
72	32	13	Semester 1	2025-08-01
73	32	14	Semester 1	2025-08-01
74	32	15	Semester 1	2025-08-01
75	32	17	Semester 2	2025-08-01
76	32	18	Semester 2	2025-08-01
77	32	16	Semester 2	2025-08-01
78	33	13	Semester 1	2025-08-01
79	33	14	Semester 1	2025-08-01
80	33	15	Semester 1	2025-08-01
81	33	17	Semester 2	2025-08-01
82	33	18	Semester 2	2025-08-01
83	33	16	Semester 2	2025-08-01
84	34	13	Semester 1	2025-08-01
85	34	14	Semester 1	2025-08-01
86	34	15	Semester 1	2025-08-01
87	34	17	Semester 2	2025-08-01
88	34	18	Semester 2	2025-08-01
89	34	16	Semester 2	2025-08-01
90	35	13	Semester 1	2025-08-01
91	35	14	Semester 1	2025-08-01
92	35	15	Semester 1	2025-08-01
93	35	17	Semester 2	2025-08-01
94	35	18	Semester 2	2025-08-01
95	35	16	Semester 2	2025-08-01
96	36	13	Semester 1	2025-08-01
97	36	14	Semester 1	2025-08-01
98	36	15	Semester 1	2025-08-01
99	36	17	Semester 2	2025-08-01
100	36	18	Semester 2	2025-08-01
101	36	16	Semester 2	2025-08-01
102	37	13	Semester 1	2025-08-01
103	37	14	Semester 1	2025-08-01
104	37	15	Semester 1	2025-08-01
105	37	17	Semester 2	2025-08-01
106	37	18	Semester 2	2025-08-01
107	37	16	Semester 2	2025-08-01
108	38	13	Semester 1	2025-08-01
109	38	14	Semester 1	2025-08-01
110	38	15	Semester 1	2025-08-01
111	38	17	Semester 2	2025-08-01
112	38	18	Semester 2	2025-08-01
113	38	16	Semester 2	2025-08-01
114	39	13	Semester 1	2025-08-01
115	39	14	Semester 1	2025-08-01
116	39	15	Semester 1	2025-08-01
117	39	17	Semester 2	2025-08-01
118	39	18	Semester 2	2025-08-01
119	39	16	Semester 2	2025-08-01
120	40	13	Semester 1	2025-08-01
121	40	14	Semester 1	2025-08-01
122	40	15	Semester 1	2025-08-01
123	40	17	Semester 2	2025-08-01
124	40	18	Semester 2	2025-08-01
125	40	16	Semester 2	2025-08-01
126	41	13	Semester 1	2025-08-01
127	41	14	Semester 1	2025-08-01
128	41	15	Semester 1	2025-08-01
129	41	17	Semester 2	2025-08-01
130	41	18	Semester 2	2025-08-01
131	41	16	Semester 2	2025-08-01
132	42	13	Semester 1	2025-08-01
133	42	14	Semester 1	2025-08-01
134	42	15	Semester 1	2025-08-01
135	42	17	Semester 2	2025-08-01
136	42	18	Semester 2	2025-08-01
137	42	16	Semester 2	2025-08-01
138	43	13	Semester 1	2025-08-01
139	43	14	Semester 1	2025-08-01
140	43	15	Semester 1	2025-08-01
141	43	17	Semester 2	2025-08-01
142	43	18	Semester 2	2025-08-01
143	43	16	Semester 2	2025-08-01
144	44	13	Semester 1	2025-08-01
145	44	14	Semester 1	2025-08-01
146	44	15	Semester 1	2025-08-01
147	44	17	Semester 2	2025-08-01
148	44	18	Semester 2	2025-08-01
149	44	16	Semester 2	2025-08-01
150	45	13	Semester 1	2025-08-01
151	45	14	Semester 1	2025-08-01
152	45	15	Semester 1	2025-08-01
153	45	17	Semester 2	2025-08-01
154	45	18	Semester 2	2025-08-01
155	45	16	Semester 2	2025-08-01
156	46	13	Semester 1	2025-08-01
157	46	14	Semester 1	2025-08-01
158	46	15	Semester 1	2025-08-01
159	46	17	Semester 2	2025-08-01
160	46	18	Semester 2	2025-08-01
161	46	16	Semester 2	2025-08-01
162	47	13	Semester 1	2025-08-01
163	47	14	Semester 1	2025-08-01
164	47	15	Semester 1	2025-08-01
165	47	17	Semester 2	2025-08-01
166	47	18	Semester 2	2025-08-01
167	47	16	Semester 2	2025-08-01
168	48	13	Semester 1	2025-08-01
169	48	14	Semester 1	2025-08-01
170	48	15	Semester 1	2025-08-01
171	48	17	Semester 2	2025-08-01
172	48	18	Semester 2	2025-08-01
173	48	16	Semester 2	2025-08-01
174	49	13	Semester 1	2025-08-01
175	49	14	Semester 1	2025-08-01
176	49	15	Semester 1	2025-08-01
177	49	17	Semester 2	2025-08-01
178	49	18	Semester 2	2025-08-01
179	49	16	Semester 2	2025-08-01
180	50	13	Semester 1	2025-08-01
181	50	14	Semester 1	2025-08-01
182	50	15	Semester 1	2025-08-01
183	50	17	Semester 2	2025-08-01
184	50	18	Semester 2	2025-08-01
185	50	16	Semester 2	2025-08-01
186	51	13	Semester 1	2025-08-01
187	51	14	Semester 1	2025-08-01
188	51	15	Semester 1	2025-08-01
189	51	17	Semester 2	2025-08-01
190	51	18	Semester 2	2025-08-01
191	51	16	Semester 2	2025-08-01
192	52	13	Semester 1	2025-08-01
193	52	14	Semester 1	2025-08-01
194	52	15	Semester 1	2025-08-01
195	52	17	Semester 2	2025-08-01
196	52	18	Semester 2	2025-08-01
197	52	16	Semester 2	2025-08-01
198	53	13	Semester 1	2025-08-01
199	53	14	Semester 1	2025-08-01
200	53	15	Semester 1	2025-08-01
201	53	17	Semester 2	2025-08-01
202	53	18	Semester 2	2025-08-01
203	53	16	Semester 2	2025-08-01
204	54	13	Semester 1	2025-08-01
205	54	14	Semester 1	2025-08-01
206	54	15	Semester 1	2025-08-01
207	54	17	Semester 2	2025-08-01
208	54	18	Semester 2	2025-08-01
209	54	16	Semester 2	2025-08-01
210	55	13	Semester 1	2025-08-01
211	55	14	Semester 1	2025-08-01
212	55	15	Semester 1	2025-08-01
213	55	17	Semester 2	2025-08-01
214	55	18	Semester 2	2025-08-01
215	55	16	Semester 2	2025-08-01
216	56	13	Semester 1	2025-08-01
217	56	14	Semester 1	2025-08-01
218	56	15	Semester 1	2025-08-01
219	56	17	Semester 2	2025-08-01
220	56	18	Semester 2	2025-08-01
221	56	16	Semester 2	2025-08-01
222	57	13	Semester 1	2025-08-01
223	57	14	Semester 1	2025-08-01
224	57	15	Semester 1	2025-08-01
225	57	17	Semester 2	2025-08-01
226	57	18	Semester 2	2025-08-01
227	57	16	Semester 2	2025-08-01
228	58	13	Semester 1	2025-08-01
229	58	14	Semester 1	2025-08-01
230	58	15	Semester 1	2025-08-01
231	58	17	Semester 2	2025-08-01
232	58	18	Semester 2	2025-08-01
233	58	16	Semester 2	2025-08-01
234	59	13	Semester 1	2025-08-01
235	59	14	Semester 1	2025-08-01
236	59	15	Semester 1	2025-08-01
237	59	17	Semester 2	2025-08-01
238	59	18	Semester 2	2025-08-01
239	59	16	Semester 2	2025-08-01
240	60	13	Semester 1	2025-08-01
241	60	14	Semester 1	2025-08-01
242	60	15	Semester 1	2025-08-01
243	60	17	Semester 2	2025-08-01
244	60	18	Semester 2	2025-08-01
245	60	16	Semester 2	2025-08-01
246	61	13	Semester 1	2025-08-01
247	61	14	Semester 1	2025-08-01
248	61	15	Semester 1	2025-08-01
249	61	17	Semester 2	2025-08-01
250	61	18	Semester 2	2025-08-01
251	61	16	Semester 2	2025-08-01
252	62	13	Semester 1	2025-08-01
253	62	14	Semester 1	2025-08-01
254	62	15	Semester 1	2025-08-01
255	62	17	Semester 2	2025-08-01
256	62	18	Semester 2	2025-08-01
257	62	16	Semester 2	2025-08-01
258	63	13	Semester 1	2025-08-01
259	63	14	Semester 1	2025-08-01
260	63	15	Semester 1	2025-08-01
261	63	17	Semester 2	2025-08-01
262	63	18	Semester 2	2025-08-01
263	63	16	Semester 2	2025-08-01
264	64	13	Semester 1	2025-08-01
265	64	14	Semester 1	2025-08-01
266	64	15	Semester 1	2025-08-01
267	64	17	Semester 2	2025-08-01
268	64	18	Semester 2	2025-08-01
269	64	16	Semester 2	2025-08-01
270	65	13	Semester 1	2025-08-01
271	65	14	Semester 1	2025-08-01
272	65	15	Semester 1	2025-08-01
273	65	17	Semester 2	2025-08-01
274	65	18	Semester 2	2025-08-01
275	65	16	Semester 2	2025-08-01
276	66	13	Semester 1	2025-08-01
277	66	14	Semester 1	2025-08-01
278	66	15	Semester 1	2025-08-01
279	66	17	Semester 2	2025-08-01
280	66	18	Semester 2	2025-08-01
281	66	16	Semester 2	2025-08-01
282	67	13	Semester 1	2025-08-01
283	67	14	Semester 1	2025-08-01
284	67	15	Semester 1	2025-08-01
285	67	17	Semester 2	2025-08-01
286	67	18	Semester 2	2025-08-01
287	67	16	Semester 2	2025-08-01
288	68	13	Semester 1	2025-08-01
289	68	14	Semester 1	2025-08-01
290	68	15	Semester 1	2025-08-01
291	68	17	Semester 2	2025-08-01
292	68	18	Semester 2	2025-08-01
293	68	16	Semester 2	2025-08-01
294	69	13	Semester 1	2025-08-01
295	69	14	Semester 1	2025-08-01
296	69	15	Semester 1	2025-08-01
297	69	17	Semester 2	2025-08-01
298	69	18	Semester 2	2025-08-01
299	69	16	Semester 2	2025-08-01
300	70	13	Semester 1	2025-08-01
301	70	14	Semester 1	2025-08-01
302	70	15	Semester 1	2025-08-01
303	70	17	Semester 2	2025-08-01
304	70	18	Semester 2	2025-08-01
305	70	16	Semester 2	2025-08-01
306	71	13	Semester 1	2025-08-01
307	71	14	Semester 1	2025-08-01
308	71	15	Semester 1	2025-08-01
309	71	17	Semester 2	2025-08-01
310	71	18	Semester 2	2025-08-01
311	71	16	Semester 2	2025-08-01
312	72	13	Semester 1	2025-08-01
313	72	14	Semester 1	2025-08-01
314	72	15	Semester 1	2025-08-01
315	72	17	Semester 2	2025-08-01
316	72	18	Semester 2	2025-08-01
317	72	16	Semester 2	2025-08-01
318	73	13	Semester 1	2025-08-01
319	73	14	Semester 1	2025-08-01
320	73	15	Semester 1	2025-08-01
321	73	17	Semester 2	2025-08-01
322	73	18	Semester 2	2025-08-01
323	73	16	Semester 2	2025-08-01
324	74	13	Semester 1	2025-08-01
325	74	14	Semester 1	2025-08-01
326	74	15	Semester 1	2025-08-01
327	74	17	Semester 2	2025-08-01
328	74	18	Semester 2	2025-08-01
329	74	16	Semester 2	2025-08-01
330	75	13	Semester 1	2025-08-01
331	75	14	Semester 1	2025-08-01
332	75	15	Semester 1	2025-08-01
333	75	17	Semester 2	2025-08-01
334	75	18	Semester 2	2025-08-01
335	75	16	Semester 2	2025-08-01
336	76	13	Semester 1	2025-08-01
337	76	14	Semester 1	2025-08-01
338	76	15	Semester 1	2025-08-01
339	76	17	Semester 2	2025-08-01
340	76	18	Semester 2	2025-08-01
341	76	16	Semester 2	2025-08-01
342	77	13	Semester 1	2025-08-01
343	77	14	Semester 1	2025-08-01
344	77	15	Semester 1	2025-08-01
345	77	17	Semester 2	2025-08-01
346	77	18	Semester 2	2025-08-01
347	77	16	Semester 2	2025-08-01
348	78	13	Semester 1	2025-08-01
349	78	14	Semester 1	2025-08-01
350	78	15	Semester 1	2025-08-01
351	78	17	Semester 2	2025-08-01
352	78	18	Semester 2	2025-08-01
353	78	16	Semester 2	2025-08-01
354	79	13	Semester 1	2025-08-01
355	79	14	Semester 1	2025-08-01
356	79	15	Semester 1	2025-08-01
357	79	17	Semester 2	2025-08-01
358	79	18	Semester 2	2025-08-01
359	79	16	Semester 2	2025-08-01
360	80	13	Semester 1	2025-08-01
361	80	14	Semester 1	2025-08-01
362	80	15	Semester 1	2025-08-01
363	80	17	Semester 2	2025-08-01
364	80	18	Semester 2	2025-08-01
365	80	16	Semester 2	2025-08-01
366	81	13	Semester 1	2025-08-01
367	81	14	Semester 1	2025-08-01
368	81	15	Semester 1	2025-08-01
369	81	17	Semester 2	2025-08-01
370	81	18	Semester 2	2025-08-01
371	81	16	Semester 2	2025-08-01
372	82	13	Semester 1	2025-08-01
373	82	14	Semester 1	2025-08-01
374	82	15	Semester 1	2025-08-01
375	82	17	Semester 2	2025-08-01
376	82	18	Semester 2	2025-08-01
377	82	16	Semester 2	2025-08-01
378	83	13	Semester 1	2025-08-01
379	83	14	Semester 1	2025-08-01
380	83	15	Semester 1	2025-08-01
381	83	17	Semester 2	2025-08-01
382	83	18	Semester 2	2025-08-01
383	83	16	Semester 2	2025-08-01
384	84	13	Semester 1	2025-08-01
385	84	14	Semester 1	2025-08-01
386	84	15	Semester 1	2025-08-01
387	84	17	Semester 2	2025-08-01
388	84	18	Semester 2	2025-08-01
389	84	16	Semester 2	2025-08-01
390	85	13	Semester 1	2025-08-01
391	85	14	Semester 1	2025-08-01
392	85	15	Semester 1	2025-08-01
393	85	17	Semester 2	2025-08-01
394	85	18	Semester 2	2025-08-01
395	85	16	Semester 2	2025-08-01
396	86	13	Semester 1	2025-08-01
397	86	14	Semester 1	2025-08-01
398	86	15	Semester 1	2025-08-01
399	86	17	Semester 2	2025-08-01
400	86	18	Semester 2	2025-08-01
401	86	16	Semester 2	2025-08-01
402	87	13	Semester 1	2025-08-01
403	87	14	Semester 1	2025-08-01
404	87	15	Semester 1	2025-08-01
405	87	17	Semester 2	2025-08-01
406	87	18	Semester 2	2025-08-01
407	87	16	Semester 2	2025-08-01
408	88	13	Semester 1	2025-08-01
409	88	14	Semester 1	2025-08-01
410	88	15	Semester 1	2025-08-01
411	88	17	Semester 2	2025-08-01
412	88	18	Semester 2	2025-08-01
413	88	16	Semester 2	2025-08-01
414	89	13	Semester 1	2025-08-01
415	89	14	Semester 1	2025-08-01
416	89	15	Semester 1	2025-08-01
417	89	17	Semester 2	2025-08-01
418	89	18	Semester 2	2025-08-01
419	89	16	Semester 2	2025-08-01
420	90	13	Semester 1	2025-08-01
421	90	14	Semester 1	2025-08-01
422	90	15	Semester 1	2025-08-01
423	90	17	Semester 2	2025-08-01
424	90	18	Semester 2	2025-08-01
425	90	16	Semester 2	2025-08-01
426	91	13	Semester 1	2025-08-01
427	91	14	Semester 1	2025-08-01
428	91	15	Semester 1	2025-08-01
429	91	17	Semester 2	2025-08-01
430	91	18	Semester 2	2025-08-01
431	91	16	Semester 2	2025-08-01
432	92	13	Semester 1	2025-08-01
433	92	14	Semester 1	2025-08-01
434	92	15	Semester 1	2025-08-01
435	92	17	Semester 2	2025-08-01
436	92	18	Semester 2	2025-08-01
437	92	16	Semester 2	2025-08-01
438	93	13	Semester 1	2025-08-01
439	93	14	Semester 1	2025-08-01
440	93	15	Semester 1	2025-08-01
441	93	17	Semester 2	2025-08-01
442	93	18	Semester 2	2025-08-01
443	93	16	Semester 2	2025-08-01
444	94	13	Semester 1	2025-08-01
445	94	14	Semester 1	2025-08-01
446	94	15	Semester 1	2025-08-01
447	94	17	Semester 2	2025-08-01
448	94	18	Semester 2	2025-08-01
449	94	16	Semester 2	2025-08-01
450	95	13	Semester 1	2025-08-01
451	95	14	Semester 1	2025-08-01
452	95	15	Semester 1	2025-08-01
453	95	17	Semester 2	2025-08-01
454	95	18	Semester 2	2025-08-01
455	95	16	Semester 2	2025-08-01
456	96	13	Semester 1	2025-08-01
457	96	14	Semester 1	2025-08-01
458	96	15	Semester 1	2025-08-01
459	96	17	Semester 2	2025-08-01
460	96	18	Semester 2	2025-08-01
461	96	16	Semester 2	2025-08-01
462	97	13	Semester 1	2025-08-01
463	97	14	Semester 1	2025-08-01
464	97	15	Semester 1	2025-08-01
465	97	17	Semester 2	2025-08-01
466	97	18	Semester 2	2025-08-01
467	97	16	Semester 2	2025-08-01
468	98	13	Semester 1	2025-08-01
469	98	14	Semester 1	2025-08-01
470	98	15	Semester 1	2025-08-01
471	98	17	Semester 2	2025-08-01
472	98	18	Semester 2	2025-08-01
473	98	16	Semester 2	2025-08-01
474	99	13	Semester 1	2025-08-01
475	99	14	Semester 1	2025-08-01
476	99	15	Semester 1	2025-08-01
477	99	17	Semester 2	2025-08-01
478	99	18	Semester 2	2025-08-01
479	99	16	Semester 2	2025-08-01
480	100	13	Semester 1	2025-08-01
481	100	14	Semester 1	2025-08-01
482	100	15	Semester 1	2025-08-01
483	100	17	Semester 2	2025-08-01
484	100	18	Semester 2	2025-08-01
485	100	16	Semester 2	2025-08-01
486	101	13	Semester 1	2025-08-01
487	101	14	Semester 1	2025-08-01
488	101	15	Semester 1	2025-08-01
489	101	17	Semester 2	2025-08-01
490	101	18	Semester 2	2025-08-01
491	101	16	Semester 2	2025-08-01
492	102	13	Semester 1	2025-08-01
493	102	14	Semester 1	2025-08-01
494	102	15	Semester 1	2025-08-01
495	102	17	Semester 2	2025-08-01
496	102	18	Semester 2	2025-08-01
497	102	16	Semester 2	2025-08-01
498	103	13	Semester 1	2025-08-01
499	103	14	Semester 1	2025-08-01
500	103	15	Semester 1	2025-08-01
501	103	17	Semester 2	2025-08-01
502	103	18	Semester 2	2025-08-01
503	103	16	Semester 2	2025-08-01
504	104	13	Semester 1	2025-08-01
505	104	14	Semester 1	2025-08-01
506	104	15	Semester 1	2025-08-01
507	104	17	Semester 2	2025-08-01
508	104	18	Semester 2	2025-08-01
509	104	16	Semester 2	2025-08-01
510	105	13	Semester 1	2025-08-01
511	105	14	Semester 1	2025-08-01
512	105	15	Semester 1	2025-08-01
513	105	17	Semester 2	2025-08-01
514	105	18	Semester 2	2025-08-01
515	105	16	Semester 2	2025-08-01
516	106	13	Semester 1	2025-08-01
517	106	14	Semester 1	2025-08-01
518	106	15	Semester 1	2025-08-01
519	106	17	Semester 2	2025-08-01
520	106	18	Semester 2	2025-08-01
521	106	16	Semester 2	2025-08-01
522	107	13	Semester 1	2025-08-01
523	107	14	Semester 1	2025-08-01
524	107	15	Semester 1	2025-08-01
525	107	17	Semester 2	2025-08-01
526	107	18	Semester 2	2025-08-01
527	107	16	Semester 2	2025-08-01
528	108	13	Semester 1	2025-08-01
529	108	14	Semester 1	2025-08-01
530	108	15	Semester 1	2025-08-01
531	108	17	Semester 2	2025-08-01
532	108	18	Semester 2	2025-08-01
533	108	16	Semester 2	2025-08-01
534	109	13	Semester 1	2025-08-01
535	109	14	Semester 1	2025-08-01
536	109	15	Semester 1	2025-08-01
537	109	17	Semester 2	2025-08-01
538	109	18	Semester 2	2025-08-01
539	109	16	Semester 2	2025-08-01
540	110	13	Semester 1	2025-08-01
541	110	14	Semester 1	2025-08-01
542	110	15	Semester 1	2025-08-01
543	110	17	Semester 2	2025-08-01
544	110	18	Semester 2	2025-08-01
545	110	16	Semester 2	2025-08-01
546	111	13	Semester 1	2025-08-01
547	111	14	Semester 1	2025-08-01
548	111	15	Semester 1	2025-08-01
549	111	17	Semester 2	2025-08-01
550	111	18	Semester 2	2025-08-01
551	111	16	Semester 2	2025-08-01
552	112	13	Semester 1	2025-08-01
553	112	14	Semester 1	2025-08-01
554	112	15	Semester 1	2025-08-01
555	112	17	Semester 2	2025-08-01
556	112	18	Semester 2	2025-08-01
557	112	16	Semester 2	2025-08-01
558	113	13	Semester 1	2025-08-01
559	113	14	Semester 1	2025-08-01
560	113	15	Semester 1	2025-08-01
561	113	17	Semester 2	2025-08-01
562	113	18	Semester 2	2025-08-01
563	113	16	Semester 2	2025-08-01
564	114	13	Semester 1	2025-08-01
565	114	14	Semester 1	2025-08-01
566	114	15	Semester 1	2025-08-01
567	114	17	Semester 2	2025-08-01
568	114	18	Semester 2	2025-08-01
569	114	16	Semester 2	2025-08-01
570	115	13	Semester 1	2025-08-01
571	115	14	Semester 1	2025-08-01
572	115	15	Semester 1	2025-08-01
573	115	17	Semester 2	2025-08-01
574	115	18	Semester 2	2025-08-01
575	115	16	Semester 2	2025-08-01
576	116	13	Semester 1	2025-08-01
577	116	14	Semester 1	2025-08-01
578	116	15	Semester 1	2025-08-01
579	116	17	Semester 2	2025-08-01
580	116	18	Semester 2	2025-08-01
581	116	16	Semester 2	2025-08-01
582	117	13	Semester 1	2025-08-01
583	117	14	Semester 1	2025-08-01
584	117	15	Semester 1	2025-08-01
585	117	17	Semester 2	2025-08-01
586	117	18	Semester 2	2025-08-01
587	117	16	Semester 2	2025-08-01
588	118	13	Semester 1	2025-08-01
589	118	14	Semester 1	2025-08-01
590	118	15	Semester 1	2025-08-01
591	118	17	Semester 2	2025-08-01
592	118	18	Semester 2	2025-08-01
593	118	16	Semester 2	2025-08-01
594	119	13	Semester 1	2025-08-01
595	119	14	Semester 1	2025-08-01
596	119	15	Semester 1	2025-08-01
597	119	17	Semester 2	2025-08-01
598	119	18	Semester 2	2025-08-01
599	119	16	Semester 2	2025-08-01
600	120	13	Semester 1	2025-08-01
601	120	14	Semester 1	2025-08-01
602	120	15	Semester 1	2025-08-01
603	120	17	Semester 2	2025-08-01
604	120	18	Semester 2	2025-08-01
605	120	16	Semester 2	2025-08-01
606	121	13	Semester 1	2025-08-01
607	121	14	Semester 1	2025-08-01
608	121	15	Semester 1	2025-08-01
609	121	17	Semester 2	2025-08-01
610	121	18	Semester 2	2025-08-01
611	121	16	Semester 2	2025-08-01
\.


--
-- TOC entry 5108 (class 0 OID 17200)
-- Dependencies: 230
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades (grade_id, enrollment_id, marks, grade, grade_point) FROM stdin;
1	1	88.00	A	9.00
2	2	92.00	A+	10.00
3	3	85.00	A	9.00
4	4	81.00	A	9.00
5	5	85.00	A	9.00
6	6	78.00	B+	8.00
7	7	89.00	A	9.00
8	8	94.00	A+	10.00
9	9	91.00	A+	10.00
10	10	86.00	A	9.00
11	11	88.00	A	9.00
12	12	71.00	B+	8.00
13	13	45.00	D	5.00
14	14	95.00	A+	10.00
15	15	48.00	D	5.00
16	16	45.00	D	5.00
17	17	47.00	D	5.00
18	18	80.00	A	9.00
19	19	97.00	A+	10.00
20	20	93.00	A+	10.00
21	21	78.00	B+	8.00
22	22	87.00	A	9.00
23	23	49.00	D	5.00
24	24	59.00	C	6.00
25	25	70.00	B+	8.00
26	26	48.00	D	5.00
27	27	55.00	C	6.00
28	28	59.00	C	6.00
29	29	80.00	A	9.00
30	30	80.00	A	9.00
31	31	59.00	C	6.00
32	32	49.00	D	5.00
33	33	83.00	A	9.00
34	34	79.00	B+	8.00
35	35	86.00	A	9.00
36	36	65.00	B	7.00
37	37	72.00	B+	8.00
38	38	52.00	C	6.00
39	39	92.00	A+	10.00
40	40	79.00	B+	8.00
41	41	53.00	C	6.00
42	42	50.00	C	6.00
43	43	66.00	B	7.00
44	44	99.00	A+	10.00
45	45	62.00	B	7.00
46	46	83.00	A	9.00
47	47	81.00	A	9.00
48	48	90.00	A+	10.00
49	49	86.00	A	9.00
50	50	73.00	B+	8.00
51	51	84.00	A	9.00
52	52	49.00	D	5.00
53	53	63.00	B	7.00
54	54	89.00	A	9.00
55	55	91.00	A+	10.00
56	56	51.00	C	6.00
57	57	50.00	C	6.00
58	58	70.00	B+	8.00
59	59	98.00	A+	10.00
60	60	74.00	B+	8.00
61	61	80.00	A	9.00
62	62	66.00	B	7.00
63	63	49.00	D	5.00
64	64	63.00	B	7.00
65	65	84.00	A	9.00
66	66	47.00	D	5.00
67	67	45.00	D	5.00
68	68	63.00	B	7.00
69	69	92.00	A+	10.00
70	70	53.00	C	6.00
71	71	70.00	B+	8.00
72	72	65.00	B	7.00
73	73	81.00	A	9.00
74	74	78.00	B+	8.00
75	75	54.00	C	6.00
76	76	71.00	B+	8.00
77	77	74.00	B+	8.00
78	78	90.00	A+	10.00
79	79	49.00	D	5.00
80	80	63.00	B	7.00
81	81	98.00	A+	10.00
82	82	77.00	B+	8.00
83	83	47.00	D	5.00
84	84	70.00	B+	8.00
85	85	78.00	B+	8.00
86	86	61.00	B	7.00
87	87	89.00	A	9.00
88	88	50.00	C	6.00
89	89	59.00	C	6.00
90	90	65.00	B	7.00
91	91	57.00	C	6.00
92	92	97.00	A+	10.00
93	93	95.00	A+	10.00
94	94	48.00	D	5.00
95	95	51.00	C	6.00
96	96	68.00	B	7.00
97	97	72.00	B+	8.00
98	98	78.00	B+	8.00
99	99	47.00	D	5.00
100	100	90.00	A+	10.00
101	101	75.00	B+	8.00
102	102	56.00	C	6.00
103	103	66.00	B	7.00
104	104	71.00	B+	8.00
105	105	55.00	C	6.00
106	106	91.00	A+	10.00
107	107	75.00	B+	8.00
108	108	75.00	B+	8.00
109	109	98.00	A+	10.00
110	110	57.00	C	6.00
111	111	83.00	A	9.00
112	112	50.00	C	6.00
113	113	69.00	B	7.00
114	114	50.00	C	6.00
115	115	82.00	A	9.00
116	116	77.00	B+	8.00
117	117	50.00	C	6.00
118	118	46.00	D	5.00
119	119	65.00	B	7.00
120	120	99.00	A+	10.00
121	121	55.00	C	6.00
122	122	59.00	C	6.00
123	123	54.00	C	6.00
124	124	61.00	B	7.00
125	125	75.00	B+	8.00
126	126	74.00	B+	8.00
127	127	61.00	B	7.00
128	128	46.00	D	5.00
129	129	92.00	A+	10.00
130	130	54.00	C	6.00
131	131	59.00	C	6.00
132	132	97.00	A+	10.00
133	133	72.00	B+	8.00
134	134	46.00	D	5.00
135	135	74.00	B+	8.00
136	136	82.00	A	9.00
137	137	45.00	D	5.00
138	138	59.00	C	6.00
139	139	93.00	A+	10.00
140	140	91.00	A+	10.00
141	141	94.00	A+	10.00
142	142	52.00	C	6.00
143	143	96.00	A+	10.00
144	144	48.00	D	5.00
145	145	55.00	C	6.00
146	146	46.00	D	5.00
147	147	53.00	C	6.00
148	148	57.00	C	6.00
149	149	93.00	A+	10.00
150	150	97.00	A+	10.00
151	151	94.00	A+	10.00
152	152	71.00	B+	8.00
153	153	56.00	C	6.00
154	154	76.00	B+	8.00
155	155	45.00	D	5.00
156	156	57.00	C	6.00
157	157	84.00	A	9.00
158	158	80.00	A	9.00
159	159	82.00	A	9.00
160	160	64.00	B	7.00
161	161	56.00	C	6.00
162	162	92.00	A+	10.00
163	163	87.00	A	9.00
164	164	59.00	C	6.00
165	165	83.00	A	9.00
166	166	90.00	A+	10.00
167	167	97.00	A+	10.00
168	168	98.00	A+	10.00
169	169	78.00	B+	8.00
170	170	72.00	B+	8.00
171	171	61.00	B	7.00
172	172	68.00	B	7.00
173	173	73.00	B+	8.00
174	174	54.00	C	6.00
175	175	80.00	A	9.00
176	176	66.00	B	7.00
177	177	45.00	D	5.00
178	178	51.00	C	6.00
179	179	57.00	C	6.00
180	180	95.00	A+	10.00
181	181	46.00	D	5.00
182	182	82.00	A	9.00
183	183	58.00	C	6.00
184	184	96.00	A+	10.00
185	185	72.00	B+	8.00
186	186	88.00	A	9.00
187	187	79.00	B+	8.00
188	188	94.00	A+	10.00
189	189	73.00	B+	8.00
190	190	97.00	A+	10.00
191	191	55.00	C	6.00
192	192	65.00	B	7.00
193	193	81.00	A	9.00
194	194	92.00	A+	10.00
195	195	71.00	B+	8.00
196	196	74.00	B+	8.00
197	197	73.00	B+	8.00
198	198	88.00	A	9.00
199	199	82.00	A	9.00
200	200	99.00	A+	10.00
201	201	65.00	B	7.00
202	202	70.00	B+	8.00
203	203	47.00	D	5.00
204	204	66.00	B	7.00
205	205	53.00	C	6.00
206	206	88.00	A	9.00
207	207	51.00	C	6.00
208	208	72.00	B+	8.00
209	209	55.00	C	6.00
210	210	99.00	A+	10.00
211	211	59.00	C	6.00
212	212	99.00	A+	10.00
213	213	74.00	B+	8.00
214	214	46.00	D	5.00
215	215	92.00	A+	10.00
216	216	52.00	C	6.00
217	217	77.00	B+	8.00
218	218	70.00	B+	8.00
219	219	50.00	C	6.00
220	220	93.00	A+	10.00
221	221	70.00	B+	8.00
222	222	57.00	C	6.00
223	223	51.00	C	6.00
224	224	50.00	C	6.00
225	225	60.00	B	7.00
226	226	83.00	A	9.00
227	227	45.00	D	5.00
228	228	55.00	C	6.00
229	229	49.00	D	5.00
230	230	82.00	A	9.00
231	231	53.00	C	6.00
232	232	98.00	A+	10.00
233	233	83.00	A	9.00
234	234	74.00	B+	8.00
235	235	67.00	B	7.00
236	236	84.00	A	9.00
237	237	76.00	B+	8.00
238	238	97.00	A+	10.00
239	239	47.00	D	5.00
240	240	77.00	B+	8.00
241	241	81.00	A	9.00
242	242	68.00	B	7.00
243	243	86.00	A	9.00
244	244	58.00	C	6.00
245	245	82.00	A	9.00
246	246	89.00	A	9.00
247	247	45.00	D	5.00
248	248	68.00	B	7.00
249	249	71.00	B+	8.00
250	250	80.00	A	9.00
251	251	46.00	D	5.00
252	252	62.00	B	7.00
253	253	91.00	A+	10.00
254	254	77.00	B+	8.00
255	255	73.00	B+	8.00
256	256	89.00	A	9.00
257	257	48.00	D	5.00
258	258	66.00	B	7.00
259	259	79.00	B+	8.00
260	260	55.00	C	6.00
261	261	93.00	A+	10.00
262	262	66.00	B	7.00
263	263	81.00	A	9.00
264	264	53.00	C	6.00
265	265	98.00	A+	10.00
266	266	92.00	A+	10.00
267	267	80.00	A	9.00
268	268	97.00	A+	10.00
269	269	78.00	B+	8.00
270	270	52.00	C	6.00
271	271	60.00	B	7.00
272	272	88.00	A	9.00
273	273	99.00	A+	10.00
274	274	46.00	D	5.00
275	275	86.00	A	9.00
276	276	68.00	B	7.00
277	277	55.00	C	6.00
278	278	63.00	B	7.00
279	279	72.00	B+	8.00
280	280	58.00	C	6.00
281	281	97.00	A+	10.00
282	282	59.00	C	6.00
283	283	50.00	C	6.00
284	284	77.00	B+	8.00
285	285	83.00	A	9.00
286	286	97.00	A+	10.00
287	287	83.00	A	9.00
288	288	94.00	A+	10.00
289	289	64.00	B	7.00
290	290	85.00	A	9.00
291	291	66.00	B	7.00
292	292	67.00	B	7.00
293	293	52.00	C	6.00
294	294	92.00	A+	10.00
295	295	98.00	A+	10.00
296	296	61.00	B	7.00
297	297	62.00	B	7.00
298	298	52.00	C	6.00
299	299	91.00	A+	10.00
300	300	55.00	C	6.00
301	301	49.00	D	5.00
302	302	94.00	A+	10.00
303	303	52.00	C	6.00
304	304	52.00	C	6.00
305	305	73.00	B+	8.00
306	306	87.00	A	9.00
307	307	90.00	A+	10.00
308	308	80.00	A	9.00
309	309	54.00	C	6.00
310	310	67.00	B	7.00
311	311	79.00	B+	8.00
312	312	88.00	A	9.00
313	313	71.00	B+	8.00
314	314	82.00	A	9.00
315	315	77.00	B+	8.00
316	316	91.00	A+	10.00
317	317	77.00	B+	8.00
318	318	61.00	B	7.00
319	319	92.00	A+	10.00
320	320	77.00	B+	8.00
321	321	62.00	B	7.00
322	322	96.00	A+	10.00
323	323	49.00	D	5.00
324	324	83.00	A	9.00
325	325	97.00	A+	10.00
326	326	75.00	B+	8.00
327	327	65.00	B	7.00
328	328	97.00	A+	10.00
329	329	73.00	B+	8.00
330	330	70.00	B+	8.00
331	331	76.00	B+	8.00
332	332	95.00	A+	10.00
333	333	82.00	A	9.00
334	334	94.00	A+	10.00
335	335	53.00	C	6.00
336	336	64.00	B	7.00
337	337	81.00	A	9.00
338	338	86.00	A	9.00
339	339	71.00	B+	8.00
340	340	65.00	B	7.00
341	341	74.00	B+	8.00
342	342	74.00	B+	8.00
343	343	56.00	C	6.00
344	344	99.00	A+	10.00
345	345	56.00	C	6.00
346	346	90.00	A+	10.00
347	347	75.00	B+	8.00
348	348	81.00	A	9.00
349	349	80.00	A	9.00
350	350	73.00	B+	8.00
351	351	70.00	B+	8.00
352	352	95.00	A+	10.00
353	353	63.00	B	7.00
354	354	81.00	A	9.00
355	355	65.00	B	7.00
356	356	54.00	C	6.00
357	357	78.00	B+	8.00
358	358	80.00	A	9.00
359	359	55.00	C	6.00
360	360	75.00	B+	8.00
361	361	59.00	C	6.00
362	362	52.00	C	6.00
363	363	98.00	A+	10.00
364	364	51.00	C	6.00
365	365	68.00	B	7.00
366	366	86.00	A	9.00
367	367	60.00	B	7.00
368	368	70.00	B+	8.00
369	369	89.00	A	9.00
370	370	51.00	C	6.00
371	371	86.00	A	9.00
372	372	48.00	D	5.00
373	373	83.00	A	9.00
374	374	92.00	A+	10.00
375	375	66.00	B	7.00
376	376	66.00	B	7.00
377	377	54.00	C	6.00
378	378	68.00	B	7.00
379	379	99.00	A+	10.00
380	380	50.00	C	6.00
381	381	87.00	A	9.00
382	382	78.00	B+	8.00
383	383	98.00	A+	10.00
384	384	93.00	A+	10.00
385	385	53.00	C	6.00
386	386	45.00	D	5.00
387	387	86.00	A	9.00
388	388	62.00	B	7.00
389	389	83.00	A	9.00
390	390	75.00	B+	8.00
391	391	87.00	A	9.00
392	392	87.00	A	9.00
393	393	89.00	A	9.00
394	394	58.00	C	6.00
395	395	91.00	A+	10.00
396	396	83.00	A	9.00
397	397	50.00	C	6.00
398	398	63.00	B	7.00
399	399	79.00	B+	8.00
400	400	84.00	A	9.00
401	401	83.00	A	9.00
402	402	73.00	B+	8.00
403	403	90.00	A+	10.00
404	404	83.00	A	9.00
405	405	93.00	A+	10.00
406	406	77.00	B+	8.00
407	407	80.00	A	9.00
408	408	50.00	C	6.00
409	409	98.00	A+	10.00
410	410	55.00	C	6.00
411	411	67.00	B	7.00
412	412	53.00	C	6.00
413	413	52.00	C	6.00
414	414	83.00	A	9.00
415	415	94.00	A+	10.00
416	416	83.00	A	9.00
417	417	73.00	B+	8.00
418	418	93.00	A+	10.00
419	419	93.00	A+	10.00
420	420	86.00	A	9.00
421	421	88.00	A	9.00
422	422	97.00	A+	10.00
423	423	69.00	B	7.00
424	424	50.00	C	6.00
425	425	88.00	A	9.00
426	426	88.00	A	9.00
427	427	83.00	A	9.00
428	428	89.00	A	9.00
429	429	79.00	B+	8.00
430	430	47.00	D	5.00
431	431	89.00	A	9.00
432	432	60.00	B	7.00
433	433	68.00	B	7.00
434	434	77.00	B+	8.00
435	435	86.00	A	9.00
436	436	53.00	C	6.00
437	437	58.00	C	6.00
438	438	45.00	D	5.00
439	439	80.00	A	9.00
440	440	78.00	B+	8.00
441	441	83.00	A	9.00
442	442	45.00	D	5.00
443	443	55.00	C	6.00
444	444	72.00	B+	8.00
445	445	79.00	B+	8.00
446	446	87.00	A	9.00
447	447	55.00	C	6.00
448	448	73.00	B+	8.00
449	449	77.00	B+	8.00
450	450	80.00	A	9.00
451	451	48.00	D	5.00
452	452	64.00	B	7.00
453	453	56.00	C	6.00
454	454	58.00	C	6.00
455	455	82.00	A	9.00
456	456	51.00	C	6.00
457	457	48.00	D	5.00
458	458	58.00	C	6.00
459	459	82.00	A	9.00
460	460	94.00	A+	10.00
461	461	45.00	D	5.00
462	462	46.00	D	5.00
463	463	87.00	A	9.00
464	464	98.00	A+	10.00
465	465	86.00	A	9.00
466	466	62.00	B	7.00
467	467	77.00	B+	8.00
468	468	98.00	A+	10.00
469	469	86.00	A	9.00
470	470	97.00	A+	10.00
471	471	55.00	C	6.00
472	472	51.00	C	6.00
473	473	48.00	D	5.00
474	474	92.00	A+	10.00
475	475	94.00	A+	10.00
476	476	78.00	B+	8.00
477	477	55.00	C	6.00
478	478	94.00	A+	10.00
479	479	91.00	A+	10.00
480	480	92.00	A+	10.00
481	481	66.00	B	7.00
482	482	59.00	C	6.00
483	483	83.00	A	9.00
484	484	59.00	C	6.00
485	485	47.00	D	5.00
486	486	49.00	D	5.00
487	487	90.00	A+	10.00
488	488	57.00	C	6.00
489	489	74.00	B+	8.00
490	490	61.00	B	7.00
491	491	85.00	A	9.00
492	492	59.00	C	6.00
493	493	90.00	A+	10.00
494	494	50.00	C	6.00
495	495	49.00	D	5.00
496	496	57.00	C	6.00
497	497	90.00	A+	10.00
498	498	86.00	A	9.00
499	499	86.00	A	9.00
500	500	70.00	B+	8.00
501	501	79.00	B+	8.00
502	502	75.00	B+	8.00
503	503	52.00	C	6.00
504	504	71.00	B+	8.00
505	505	45.00	D	5.00
506	506	90.00	A+	10.00
507	507	80.00	A	9.00
508	508	64.00	B	7.00
509	509	78.00	B+	8.00
510	510	81.00	A	9.00
511	511	47.00	D	5.00
512	512	61.00	B	7.00
513	513	82.00	A	9.00
514	514	68.00	B	7.00
515	515	48.00	D	5.00
516	516	55.00	C	6.00
517	517	91.00	A+	10.00
518	518	96.00	A+	10.00
519	519	83.00	A	9.00
520	520	50.00	C	6.00
521	521	90.00	A+	10.00
522	522	68.00	B	7.00
523	523	51.00	C	6.00
524	524	94.00	A+	10.00
525	525	49.00	D	5.00
526	526	66.00	B	7.00
527	527	87.00	A	9.00
528	528	49.00	D	5.00
529	529	68.00	B	7.00
530	530	96.00	A+	10.00
531	531	52.00	C	6.00
532	532	69.00	B	7.00
533	533	48.00	D	5.00
534	534	67.00	B	7.00
535	535	49.00	D	5.00
536	536	48.00	D	5.00
537	537	73.00	B+	8.00
538	538	97.00	A+	10.00
539	539	98.00	A+	10.00
540	540	46.00	D	5.00
541	541	91.00	A+	10.00
542	542	48.00	D	5.00
543	543	59.00	C	6.00
544	544	55.00	C	6.00
545	545	53.00	C	6.00
546	546	73.00	B+	8.00
547	547	83.00	A	9.00
548	548	62.00	B	7.00
549	549	83.00	A	9.00
550	550	66.00	B	7.00
551	551	66.00	B	7.00
552	552	92.00	A+	10.00
553	553	79.00	B+	8.00
554	554	61.00	B	7.00
555	555	93.00	A+	10.00
556	556	86.00	A	9.00
557	557	82.00	A	9.00
558	558	54.00	C	6.00
559	559	45.00	D	5.00
560	560	99.00	A+	10.00
561	561	90.00	A+	10.00
562	562	76.00	B+	8.00
563	563	79.00	B+	8.00
564	564	60.00	B	7.00
565	565	98.00	A+	10.00
566	566	57.00	C	6.00
567	567	82.00	A	9.00
568	568	62.00	B	7.00
569	569	58.00	C	6.00
570	570	79.00	B+	8.00
571	571	82.00	A	9.00
572	572	93.00	A+	10.00
573	573	49.00	D	5.00
574	574	60.00	B	7.00
575	575	74.00	B+	8.00
576	576	62.00	B	7.00
577	577	48.00	D	5.00
578	578	81.00	A	9.00
579	579	90.00	A+	10.00
580	580	95.00	A+	10.00
581	581	53.00	C	6.00
582	582	47.00	D	5.00
583	583	99.00	A+	10.00
584	584	63.00	B	7.00
585	585	93.00	A+	10.00
586	586	61.00	B	7.00
587	587	79.00	B+	8.00
588	588	62.00	B	7.00
589	589	79.00	B+	8.00
590	590	63.00	B	7.00
591	591	80.00	A	9.00
592	592	53.00	C	6.00
593	593	60.00	B	7.00
594	594	71.00	B+	8.00
595	595	98.00	A+	10.00
596	596	84.00	A	9.00
597	597	62.00	B	7.00
598	598	67.00	B	7.00
599	599	59.00	C	6.00
600	600	73.00	B+	8.00
601	601	79.00	B+	8.00
602	602	55.00	C	6.00
603	603	70.00	B+	8.00
604	604	58.00	C	6.00
605	605	46.00	D	5.00
606	606	91.00	A+	10.00
607	607	79.00	B+	8.00
608	608	58.00	C	6.00
609	609	52.00	C	6.00
610	610	69.00	B	7.00
611	611	66.00	B	7.00
\.


--
-- TOC entry 5102 (class 0 OID 17132)
-- Dependencies: 224
-- Data for Name: instructors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructors (instructor_id, instructor_name, email, department_id) FROM stdin;
17	Dr. Ravi Kumar	ravi@example.com	5
18	Dr. Anitha Rao	anitha@example.com	5
19	Prof. Kiran Reddy	kiran@example.com	6
20	Dr. Meena Sharma	meena@example.com	7
\.


--
-- TOC entry 5110 (class 0 OID 17228)
-- Dependencies: 232
-- Data for Name: student_certifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_certifications (student_id, certification) FROM stdin;
16	Python
16	SQL
16	AWS
17	Python
17	SQL
18	HTML
19	Python
19	SQL
20	Machine Learning
22	SQL Fundamentals
23	Data Analytics
24	Web Development
25	Cloud Fundamentals
26	Machine Learning Basics
27	Python Programming
28	SQL Fundamentals
29	Data Analytics
30	Web Development
31	Cloud Fundamentals
32	Machine Learning Basics
33	Python Programming
34	SQL Fundamentals
35	Data Analytics
36	Web Development
37	Cloud Fundamentals
38	Machine Learning Basics
39	Python Programming
40	SQL Fundamentals
41	Data Analytics
42	Web Development
43	Cloud Fundamentals
44	Machine Learning Basics
45	Python Programming
46	SQL Fundamentals
47	Data Analytics
48	Web Development
49	Cloud Fundamentals
50	Machine Learning Basics
51	Python Programming
52	SQL Fundamentals
53	Data Analytics
54	Web Development
55	Cloud Fundamentals
56	Machine Learning Basics
57	Python Programming
58	SQL Fundamentals
59	Data Analytics
60	Web Development
61	Cloud Fundamentals
62	Machine Learning Basics
63	Python Programming
64	SQL Fundamentals
65	Data Analytics
66	Web Development
67	Cloud Fundamentals
68	Machine Learning Basics
69	Python Programming
70	SQL Fundamentals
71	Data Analytics
72	Web Development
73	Cloud Fundamentals
74	Machine Learning Basics
75	Python Programming
76	SQL Fundamentals
77	Data Analytics
78	Web Development
79	Cloud Fundamentals
80	Machine Learning Basics
81	Python Programming
82	SQL Fundamentals
83	Data Analytics
84	Web Development
85	Cloud Fundamentals
86	Machine Learning Basics
87	Python Programming
88	SQL Fundamentals
89	Data Analytics
90	Web Development
91	Cloud Fundamentals
92	Machine Learning Basics
93	Python Programming
94	SQL Fundamentals
95	Data Analytics
96	Web Development
97	Cloud Fundamentals
98	Machine Learning Basics
99	Python Programming
100	SQL Fundamentals
101	Data Analytics
102	Web Development
103	Cloud Fundamentals
104	Machine Learning Basics
105	Python Programming
106	SQL Fundamentals
107	Data Analytics
108	Web Development
109	Cloud Fundamentals
110	Machine Learning Basics
111	Python Programming
112	SQL Fundamentals
113	Data Analytics
114	Web Development
115	Cloud Fundamentals
116	Machine Learning Basics
117	Python Programming
118	SQL Fundamentals
119	Data Analytics
120	Web Development
121	Cloud Fundamentals
\.


--
-- TOC entry 5109 (class 0 OID 17216)
-- Dependencies: 231
-- Data for Name: student_languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_languages (student_id, language) FROM stdin;
16	English
16	Telugu
16	Hindi
17	English
17	Telugu
18	English
19	English
19	Telugu
20	English
22	SQL
23	Java
24	JavaScript
25	C++
26	Python
27	SQL
28	Java
29	JavaScript
30	C++
31	Python
32	SQL
33	Java
34	JavaScript
35	C++
36	Python
37	SQL
38	Java
39	JavaScript
40	C++
41	Python
42	SQL
43	Java
44	JavaScript
45	C++
46	Python
47	SQL
48	Java
49	JavaScript
50	C++
51	Python
52	SQL
53	Java
54	JavaScript
55	C++
56	Python
57	SQL
58	Java
59	JavaScript
60	C++
61	Python
62	SQL
63	Java
64	JavaScript
65	C++
66	Python
67	SQL
68	Java
69	JavaScript
70	C++
71	Python
72	SQL
73	Java
74	JavaScript
75	C++
76	Python
77	SQL
78	Java
79	JavaScript
80	C++
81	Python
82	SQL
83	Java
84	JavaScript
85	C++
86	Python
87	SQL
88	Java
89	JavaScript
90	C++
91	Python
92	SQL
93	Java
94	JavaScript
95	C++
96	Python
97	SQL
98	Java
99	JavaScript
100	C++
101	Python
102	SQL
103	Java
104	JavaScript
105	C++
106	Python
107	SQL
108	Java
109	JavaScript
110	C++
111	Python
112	SQL
113	Java
114	JavaScript
115	C++
116	Python
117	SQL
118	Java
119	JavaScript
120	C++
121	Python
\.


--
-- TOC entry 5100 (class 0 OID 17111)
-- Dependencies: 222
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, roll_number, student_name, email, gender, date_of_birth, department_id, admission_year) FROM stdin;
16	CS001	Arjun Kumar	arjun@example.com	Male	2004-05-12	5	2023
17	CS002	Priya Sharma	priya@example.com	Female	2004-08-21	5	2023
18	IT001	Rahul Verma	rahul@example.com	Male	2003-11-15	6	2023
19	DS001	Sneha Reddy	sneha@example.com	Female	2004-02-10	7	2023
20	DS002	Vikram Singh	vikram@example.com	Male	2003-12-05	7	2023
22	EV260001	Aarav Reddy	ev260001@eduvault.demo	Male	2003-02-02	5	2025
23	EV260002	Ananya Kumar	ev260002@eduvault.demo	Female	2004-03-03	6	2025
24	EV260003	Arjun Patel	ev260003@eduvault.demo	Male	2005-04-04	7	2025
25	EV260004	Diya Verma	ev260004@eduvault.demo	Female	2006-05-05	8	2025
26	EV260005	Ishaan Rao	ev260005@eduvault.demo	Male	2002-06-06	5	2025
27	EV260006	Kavya Singh	ev260006@eduvault.demo	Female	2003-07-07	6	2025
28	EV260007	Rahul Gupta	ev260007@eduvault.demo	Male	2004-08-08	7	2025
29	EV260008	Priya Naidu	ev260008@eduvault.demo	Female	2005-09-09	8	2025
30	EV260009	Sneha Das	ev260009@eduvault.demo	Male	2006-10-10	5	2025
31	EV260010	Vikram Sharma	ev260010@eduvault.demo	Female	2002-11-11	6	2025
32	EV260011	Aditya Reddy	ev260011@eduvault.demo	Male	2003-12-12	7	2025
33	EV260012	Meera Kumar	ev260012@eduvault.demo	Female	2004-01-13	8	2025
34	EV260013	Rohan Patel	ev260013@eduvault.demo	Male	2005-02-14	5	2025
35	EV260014	Saanvi Verma	ev260014@eduvault.demo	Female	2006-03-15	6	2025
36	EV260015	Varun Rao	ev260015@eduvault.demo	Male	2002-04-16	7	2025
37	EV260016	Nisha Singh	ev260016@eduvault.demo	Female	2003-05-17	8	2025
38	EV260017	Kiran Gupta	ev260017@eduvault.demo	Male	2004-06-18	5	2025
39	EV260018	Pooja Naidu	ev260018@eduvault.demo	Female	2005-07-19	6	2025
40	EV260019	Sai Das	ev260019@eduvault.demo	Male	2006-08-20	7	2025
41	EV260020	Keerthi Sharma	ev260020@eduvault.demo	Female	2002-09-21	8	2025
42	EV260021	Aarav Kumar	ev260021@eduvault.demo	Male	2003-10-22	5	2025
43	EV260022	Ananya Patel	ev260022@eduvault.demo	Female	2004-11-23	6	2025
44	EV260023	Arjun Verma	ev260023@eduvault.demo	Male	2005-12-24	7	2025
45	EV260024	Diya Rao	ev260024@eduvault.demo	Female	2006-01-25	8	2025
46	EV260025	Ishaan Singh	ev260025@eduvault.demo	Male	2002-02-26	5	2025
47	EV260026	Kavya Gupta	ev260026@eduvault.demo	Female	2003-03-27	6	2025
48	EV260027	Rahul Naidu	ev260027@eduvault.demo	Male	2004-04-01	7	2025
49	EV260028	Priya Das	ev260028@eduvault.demo	Female	2005-05-02	8	2025
50	EV260029	Sneha Sharma	ev260029@eduvault.demo	Male	2006-06-03	5	2025
51	EV260030	Vikram Reddy	ev260030@eduvault.demo	Female	2002-07-04	6	2025
52	EV260031	Aditya Kumar	ev260031@eduvault.demo	Male	2003-08-05	7	2025
53	EV260032	Meera Patel	ev260032@eduvault.demo	Female	2004-09-06	8	2025
54	EV260033	Rohan Verma	ev260033@eduvault.demo	Male	2005-10-07	5	2025
55	EV260034	Saanvi Rao	ev260034@eduvault.demo	Female	2006-11-08	6	2025
56	EV260035	Varun Singh	ev260035@eduvault.demo	Male	2002-12-09	7	2025
57	EV260036	Nisha Gupta	ev260036@eduvault.demo	Female	2003-01-10	8	2025
58	EV260037	Kiran Naidu	ev260037@eduvault.demo	Male	2004-02-11	5	2025
59	EV260038	Pooja Das	ev260038@eduvault.demo	Female	2005-03-12	6	2025
60	EV260039	Sai Sharma	ev260039@eduvault.demo	Male	2006-04-13	7	2025
61	EV260040	Keerthi Reddy	ev260040@eduvault.demo	Female	2002-05-14	8	2025
62	EV260041	Aarav Patel	ev260041@eduvault.demo	Male	2003-06-15	5	2025
63	EV260042	Ananya Verma	ev260042@eduvault.demo	Female	2004-07-16	6	2025
64	EV260043	Arjun Rao	ev260043@eduvault.demo	Male	2005-08-17	7	2025
65	EV260044	Diya Singh	ev260044@eduvault.demo	Female	2006-09-18	8	2025
66	EV260045	Ishaan Gupta	ev260045@eduvault.demo	Male	2002-10-19	5	2025
67	EV260046	Kavya Naidu	ev260046@eduvault.demo	Female	2003-11-20	6	2025
68	EV260047	Rahul Das	ev260047@eduvault.demo	Male	2004-12-21	7	2025
69	EV260048	Priya Sharma	ev260048@eduvault.demo	Female	2005-01-22	8	2025
70	EV260049	Sneha Reddy	ev260049@eduvault.demo	Male	2006-02-23	5	2025
71	EV260050	Vikram Kumar	ev260050@eduvault.demo	Female	2002-03-24	6	2025
72	EV260051	Aditya Patel	ev260051@eduvault.demo	Male	2003-04-25	7	2025
73	EV260052	Meera Verma	ev260052@eduvault.demo	Female	2004-05-26	8	2025
74	EV260053	Rohan Rao	ev260053@eduvault.demo	Male	2005-06-27	5	2025
75	EV260054	Saanvi Singh	ev260054@eduvault.demo	Female	2006-07-01	6	2025
76	EV260055	Varun Gupta	ev260055@eduvault.demo	Male	2002-08-02	7	2025
77	EV260056	Nisha Naidu	ev260056@eduvault.demo	Female	2003-09-03	8	2025
78	EV260057	Kiran Das	ev260057@eduvault.demo	Male	2004-10-04	5	2025
79	EV260058	Pooja Sharma	ev260058@eduvault.demo	Female	2005-11-05	6	2025
80	EV260059	Sai Reddy	ev260059@eduvault.demo	Male	2006-12-06	7	2025
81	EV260060	Keerthi Kumar	ev260060@eduvault.demo	Female	2002-01-07	8	2025
82	EV260061	Aarav Verma	ev260061@eduvault.demo	Male	2003-02-08	5	2025
83	EV260062	Ananya Rao	ev260062@eduvault.demo	Female	2004-03-09	6	2025
84	EV260063	Arjun Singh	ev260063@eduvault.demo	Male	2005-04-10	7	2025
85	EV260064	Diya Gupta	ev260064@eduvault.demo	Female	2006-05-11	8	2025
86	EV260065	Ishaan Naidu	ev260065@eduvault.demo	Male	2002-06-12	5	2025
87	EV260066	Kavya Das	ev260066@eduvault.demo	Female	2003-07-13	6	2025
88	EV260067	Rahul Sharma	ev260067@eduvault.demo	Male	2004-08-14	7	2025
89	EV260068	Priya Reddy	ev260068@eduvault.demo	Female	2005-09-15	8	2025
90	EV260069	Sneha Kumar	ev260069@eduvault.demo	Male	2006-10-16	5	2025
91	EV260070	Vikram Patel	ev260070@eduvault.demo	Female	2002-11-17	6	2025
92	EV260071	Aditya Verma	ev260071@eduvault.demo	Male	2003-12-18	7	2025
93	EV260072	Meera Rao	ev260072@eduvault.demo	Female	2004-01-19	8	2025
94	EV260073	Rohan Singh	ev260073@eduvault.demo	Male	2005-02-20	5	2025
95	EV260074	Saanvi Gupta	ev260074@eduvault.demo	Female	2006-03-21	6	2025
96	EV260075	Varun Naidu	ev260075@eduvault.demo	Male	2002-04-22	7	2025
97	EV260076	Nisha Das	ev260076@eduvault.demo	Female	2003-05-23	8	2025
98	EV260077	Kiran Sharma	ev260077@eduvault.demo	Male	2004-06-24	5	2025
99	EV260078	Pooja Reddy	ev260078@eduvault.demo	Female	2005-07-25	6	2025
100	EV260079	Sai Kumar	ev260079@eduvault.demo	Male	2006-08-26	7	2025
101	EV260080	Keerthi Patel	ev260080@eduvault.demo	Female	2002-09-27	8	2025
102	EV260081	Aarav Rao	ev260081@eduvault.demo	Male	2003-10-01	5	2025
103	EV260082	Ananya Singh	ev260082@eduvault.demo	Female	2004-11-02	6	2025
104	EV260083	Arjun Gupta	ev260083@eduvault.demo	Male	2005-12-03	7	2025
105	EV260084	Diya Naidu	ev260084@eduvault.demo	Female	2006-01-04	8	2025
106	EV260085	Ishaan Das	ev260085@eduvault.demo	Male	2002-02-05	5	2025
107	EV260086	Kavya Sharma	ev260086@eduvault.demo	Female	2003-03-06	6	2025
108	EV260087	Rahul Reddy	ev260087@eduvault.demo	Male	2004-04-07	7	2025
109	EV260088	Priya Kumar	ev260088@eduvault.demo	Female	2005-05-08	8	2025
110	EV260089	Sneha Patel	ev260089@eduvault.demo	Male	2006-06-09	5	2025
111	EV260090	Vikram Verma	ev260090@eduvault.demo	Female	2002-07-10	6	2025
112	EV260091	Aditya Rao	ev260091@eduvault.demo	Male	2003-08-11	7	2025
113	EV260092	Meera Singh	ev260092@eduvault.demo	Female	2004-09-12	8	2025
114	EV260093	Rohan Gupta	ev260093@eduvault.demo	Male	2005-10-13	5	2025
115	EV260094	Saanvi Naidu	ev260094@eduvault.demo	Female	2006-11-14	6	2025
116	EV260095	Varun Das	ev260095@eduvault.demo	Male	2002-12-15	7	2025
117	EV260096	Nisha Sharma	ev260096@eduvault.demo	Female	2003-01-16	8	2025
118	EV260097	Kiran Reddy	ev260097@eduvault.demo	Male	2004-02-17	5	2025
119	EV260098	Pooja Kumar	ev260098@eduvault.demo	Female	2005-03-18	6	2025
120	EV260099	Sai Patel	ev260099@eduvault.demo	Male	2006-04-19	7	2025
121	EV260100	Keerthi Verma	ev260100@eduvault.demo	Female	2002-05-20	8	2025
\.


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 225
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 18, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 219
-- Name: departments_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_department_id_seq', 11, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 227
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollments_enrollment_id_seq', 611, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 229
-- Name: grades_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_grade_id_seq', 611, true);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 223
-- Name: instructors_instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructors_instructor_id_seq', 20, true);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 221
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 121, true);


--
-- TOC entry 4938 (class 2606 OID 17247)
-- Name: course_prerequisites course_prerequisites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_prerequisites
    ADD CONSTRAINT course_prerequisites_pkey PRIMARY KEY (course_id, prerequisite_course_id);


--
-- TOC entry 4919 (class 2606 OID 17164)
-- Name: courses courses_course_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_course_code_key UNIQUE (course_code);


--
-- TOC entry 4921 (class 2606 OID 17162)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- TOC entry 4904 (class 2606 OID 17087)
-- Name: departments departments_department_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_department_name_key UNIQUE (department_name);


--
-- TOC entry 4906 (class 2606 OID 17085)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);


--
-- TOC entry 4923 (class 2606 OID 17186)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);


--
-- TOC entry 4925 (class 2606 OID 17188)
-- Name: enrollments enrollments_student_id_course_id_semester_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_course_id_semester_key UNIQUE (student_id, course_id, semester);


--
-- TOC entry 4929 (class 2606 OID 17210)
-- Name: grades grades_enrollment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_enrollment_id_key UNIQUE (enrollment_id);


--
-- TOC entry 4931 (class 2606 OID 17208)
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (grade_id);


--
-- TOC entry 4915 (class 2606 OID 17142)
-- Name: instructors instructors_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructors
    ADD CONSTRAINT instructors_email_key UNIQUE (email);


--
-- TOC entry 4917 (class 2606 OID 17140)
-- Name: instructors instructors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructors
    ADD CONSTRAINT instructors_pkey PRIMARY KEY (instructor_id);


--
-- TOC entry 4936 (class 2606 OID 17234)
-- Name: student_certifications student_certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_certifications
    ADD CONSTRAINT student_certifications_pkey PRIMARY KEY (student_id, certification);


--
-- TOC entry 4934 (class 2606 OID 17222)
-- Name: student_languages student_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_languages
    ADD CONSTRAINT student_languages_pkey PRIMARY KEY (student_id, language);


--
-- TOC entry 4909 (class 2606 OID 17125)
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- TOC entry 4911 (class 2606 OID 17121)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4913 (class 2606 OID 17123)
-- Name: students students_roll_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_roll_number_key UNIQUE (roll_number);


--
-- TOC entry 4926 (class 1259 OID 17260)
-- Name: idx_enrollments_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_course ON public.enrollments USING btree (course_id);


--
-- TOC entry 4927 (class 1259 OID 17259)
-- Name: idx_enrollments_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollments_student ON public.enrollments USING btree (student_id);


--
-- TOC entry 4932 (class 1259 OID 17261)
-- Name: idx_grades_enrollment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_grades_enrollment ON public.grades USING btree (enrollment_id);


--
-- TOC entry 4907 (class 1259 OID 17258)
-- Name: idx_students_department; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_students_department ON public.students USING btree (department_id);


--
-- TOC entry 4948 (class 2606 OID 17248)
-- Name: course_prerequisites course_prerequisites_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_prerequisites
    ADD CONSTRAINT course_prerequisites_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- TOC entry 4949 (class 2606 OID 17253)
-- Name: course_prerequisites course_prerequisites_prerequisite_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_prerequisites
    ADD CONSTRAINT course_prerequisites_prerequisite_course_id_fkey FOREIGN KEY (prerequisite_course_id) REFERENCES public.courses(course_id);


--
-- TOC entry 4941 (class 2606 OID 17165)
-- Name: courses courses_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


--
-- TOC entry 4942 (class 2606 OID 17170)
-- Name: courses courses_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructors(instructor_id);


--
-- TOC entry 4943 (class 2606 OID 17194)
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- TOC entry 4944 (class 2606 OID 17189)
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- TOC entry 4945 (class 2606 OID 17211)
-- Name: grades grades_enrollment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollments(enrollment_id);


--
-- TOC entry 4940 (class 2606 OID 17143)
-- Name: instructors instructors_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructors
    ADD CONSTRAINT instructors_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


--
-- TOC entry 4947 (class 2606 OID 17235)
-- Name: student_certifications student_certifications_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_certifications
    ADD CONSTRAINT student_certifications_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- TOC entry 4946 (class 2606 OID 17223)
-- Name: student_languages student_languages_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_languages
    ADD CONSTRAINT student_languages_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- TOC entry 4939 (class 2606 OID 17126)
-- Name: students students_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


-- Completed on 2026-10-15 11:04:41

--
-- PostgreSQL database dump complete
--

\unrestrict dSqVMJyyP414z0Y3T2Tk9WjHVoXw4rJPMGdYHxLwZqnEdmgbgEq8vFGjg4fl76f

