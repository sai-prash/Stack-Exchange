--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8
-- Dumped by pg_dump version 12.8

-- Started on 2021-12-05 19:16:36

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 52155)
-- Name: Answer Version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Answer Version" (
    "Version_id" bigint NOT NULL,
    "Answer_id" bigint NOT NULL,
    "Content" text,
    "Version_Created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "Version_Created_by" bigint
);


ALTER TABLE public."Answer Version" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 52169)
-- Name: Comment Version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Comment Version" (
    "Version_id" bigint NOT NULL,
    "Comment_id" bigint NOT NULL,
    "Content" text,
    "Version_Created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "Version_Created_by" bigint
);


ALTER TABLE public."Comment Version" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 52119)
-- Name: Community Member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Community Member" (
    "CM_id" bigint NOT NULL,
    "User_id" bigint NOT NULL,
    "Community_id" bigint NOT NULL,
    "Reputation" integer DEFAULT 0,
    "Badge Count" integer DEFAULT 0,
    "isAdmin" boolean DEFAULT false,
    "isRemoved" boolean DEFAULT false
);


ALTER TABLE public."Community Member" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 52141)
-- Name: Question Version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Question Version" (
    "Version_id" bigint NOT NULL,
    "Question_id" bigint NOT NULL,
    "Title" text,
    "Content" text,
    "Version Created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "Version_Created_by" bigint
);


ALTER TABLE public."Question Version" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 52187)
-- Name: Tagged Question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tagged Question" (
    id bigint NOT NULL,
    "Tag_id" bigint,
    "Version_id" bigint
);


ALTER TABLE public."Tagged Question" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 52114)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "User_id" bigint NOT NULL,
    "Name" character varying(60) NOT NULL,
    "Email Address" character varying(80) NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 52150)
-- Name: answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer (
    "Answer_id" bigint NOT NULL,
    "Question_id" bigint NOT NULL,
    "Accepted" boolean
);


ALTER TABLE public.answer OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 52205)
-- Name: badges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.badges (
    "Badge_id" bigint NOT NULL,
    "Badge_name" character varying(30),
    "Badge_type" character varying(30),
    "CM_id" bigint
);


ALTER TABLE public.badges OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 52164)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    "Comment_id" bigint NOT NULL,
    "Question_id" bigint,
    "Answer_id" bigint
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 52107)
-- Name: community; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.community (
    "Community_id" bigint NOT NULL,
    "Name" character varying(40) NOT NULL,
    type character varying(30),
    "Created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "Created_by" bigint,
    CONSTRAINT community_type_check CHECK (((type)::text = ANY ((ARRAY['Public'::character varying, 'Private'::character varying])::text[])))
);


ALTER TABLE public.community OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 52192)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    "Post_id" bigint NOT NULL,
    "Created_by" bigint,
    "Created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 52135)
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    "Question_id" bigint NOT NULL,
    "Protected?" boolean,
    "Reviewed" character varying(30),
    CONSTRAINT "question_Reviewed_check" CHECK ((("Reviewed")::text = ANY ((ARRAY['Accepted'::character varying, 'Rejected'::character varying])::text[])))
);


ALTER TABLE public.question OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 52198)
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    "Review_id" bigint NOT NULL,
    "Reviewed_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "Type" character varying(20),
    "Reviewed_by" bigint,
    "Post_id" bigint,
    CONSTRAINT "review_Type_check" CHECK ((("Type")::text = ANY ((ARRAY['Accepted'::character varying, 'Rejected'::character varying])::text[])))
);


ALTER TABLE public.review OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 52178)
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    "Tag_id" bigint NOT NULL,
    "Name" text,
    "Description" text,
    "Created_by" bigint,
    "Community_id" bigint,
    "Created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 52128)
-- Name: vote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vote (
    id bigint NOT NULL,
    "Vote_type" character varying(5),
    "Voted_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "Voted_by" bigint,
    "Voted_post" bigint,
    CONSTRAINT "vote_Vote_type_check" CHECK ((("Vote_type")::text = ANY ((ARRAY['Up'::character varying, 'Down'::character varying])::text[])))
);


ALTER TABLE public.vote OWNER TO postgres;

--
-- TOC entry 2776 (class 2606 OID 52163)
-- Name: Answer Version Answer Version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer Version"
    ADD CONSTRAINT "Answer Version_pkey" PRIMARY KEY ("Version_id");


--
-- TOC entry 2780 (class 2606 OID 52177)
-- Name: Comment Version Comment Version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment Version"
    ADD CONSTRAINT "Comment Version_pkey" PRIMARY KEY ("Version_id");


--
-- TOC entry 2766 (class 2606 OID 52127)
-- Name: Community Member Community Member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Community Member"
    ADD CONSTRAINT "Community Member_pkey" PRIMARY KEY ("CM_id");


--
-- TOC entry 2772 (class 2606 OID 52149)
-- Name: Question Version Question Version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question Version"
    ADD CONSTRAINT "Question Version_pkey" PRIMARY KEY ("Version_id");


--
-- TOC entry 2784 (class 2606 OID 52191)
-- Name: Tagged Question Tagged Question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tagged Question"
    ADD CONSTRAINT "Tagged Question_pkey" PRIMARY KEY (id);


--
-- TOC entry 2764 (class 2606 OID 52118)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("User_id");


--
-- TOC entry 2774 (class 2606 OID 52154)
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY ("Answer_id");


--
-- TOC entry 2790 (class 2606 OID 52209)
-- Name: badges badges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY ("Badge_id");


--
-- TOC entry 2778 (class 2606 OID 52168)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY ("Comment_id");


--
-- TOC entry 2762 (class 2606 OID 52113)
-- Name: community community_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community
    ADD CONSTRAINT community_pkey PRIMARY KEY ("Community_id");


--
-- TOC entry 2786 (class 2606 OID 52197)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY ("Post_id");


--
-- TOC entry 2770 (class 2606 OID 52140)
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY ("Question_id");


--
-- TOC entry 2788 (class 2606 OID 52204)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY ("Review_id");


--
-- TOC entry 2782 (class 2606 OID 52186)
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY ("Tag_id");


--
-- TOC entry 2768 (class 2606 OID 52134)
-- Name: vote vote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_pkey PRIMARY KEY (id);


--
-- TOC entry 2802 (class 2606 OID 52260)
-- Name: Answer Version Answer Version_Answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer Version"
    ADD CONSTRAINT "Answer Version_Answer_id_fkey" FOREIGN KEY ("Answer_id") REFERENCES public.answer("Answer_id") NOT VALID;


--
-- TOC entry 2801 (class 2606 OID 52255)
-- Name: Answer Version Answer Version_Version_Created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer Version"
    ADD CONSTRAINT "Answer Version_Version_Created_by_fkey" FOREIGN KEY ("Version_Created_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2807 (class 2606 OID 52285)
-- Name: Comment Version Comment Version_Comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment Version"
    ADD CONSTRAINT "Comment Version_Comment_id_fkey" FOREIGN KEY ("Comment_id") REFERENCES public.comment("Comment_id") NOT VALID;


--
-- TOC entry 2806 (class 2606 OID 52280)
-- Name: Comment Version Comment Version_Version_Created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Comment Version"
    ADD CONSTRAINT "Comment Version_Version_Created_by_fkey" FOREIGN KEY ("Version_Created_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2793 (class 2606 OID 52220)
-- Name: Community Member Community Member_Community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Community Member"
    ADD CONSTRAINT "Community Member_Community_id_fkey" FOREIGN KEY ("Community_id") REFERENCES public.community("Community_id") NOT VALID;


--
-- TOC entry 2792 (class 2606 OID 52215)
-- Name: Community Member Community Member_User_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Community Member"
    ADD CONSTRAINT "Community Member_User_id_fkey" FOREIGN KEY ("User_id") REFERENCES public."User"("User_id") NOT VALID;


--
-- TOC entry 2798 (class 2606 OID 52235)
-- Name: Question Version Question Version_Question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question Version"
    ADD CONSTRAINT "Question Version_Question_id_fkey" FOREIGN KEY ("Question_id") REFERENCES public.question("Question_id") NOT VALID;


--
-- TOC entry 2797 (class 2606 OID 52230)
-- Name: Question Version Question Version_Version_Created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question Version"
    ADD CONSTRAINT "Question Version_Version_Created_by_fkey" FOREIGN KEY ("Version_Created_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2810 (class 2606 OID 52300)
-- Name: Tagged Question Tagged Question_Tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tagged Question"
    ADD CONSTRAINT "Tagged Question_Tag_id_fkey" FOREIGN KEY ("Tag_id") REFERENCES public.tag("Tag_id") NOT VALID;


--
-- TOC entry 2811 (class 2606 OID 52305)
-- Name: Tagged Question Tagged Question_Version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tagged Question"
    ADD CONSTRAINT "Tagged Question_Version_id_fkey" FOREIGN KEY ("Version_id") REFERENCES public."Question Version"("Version_id") NOT VALID;


--
-- TOC entry 2799 (class 2606 OID 52245)
-- Name: answer answer_Answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT "answer_Answer_id_fkey" FOREIGN KEY ("Answer_id") REFERENCES public.post("Post_id") NOT VALID;


--
-- TOC entry 2800 (class 2606 OID 52250)
-- Name: answer answer_Question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT "answer_Question_id_fkey" FOREIGN KEY ("Question_id") REFERENCES public.question("Question_id") NOT VALID;


--
-- TOC entry 2815 (class 2606 OID 52330)
-- Name: badges badges_CM_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badges
    ADD CONSTRAINT "badges_CM_id_fkey" FOREIGN KEY ("CM_id") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2805 (class 2606 OID 52275)
-- Name: comment comment_Answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "comment_Answer_id_fkey" FOREIGN KEY ("Answer_id") REFERENCES public.answer("Answer_id") NOT VALID;


--
-- TOC entry 2803 (class 2606 OID 52265)
-- Name: comment comment_Comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "comment_Comment_id_fkey" FOREIGN KEY ("Comment_id") REFERENCES public.post("Post_id") NOT VALID;


--
-- TOC entry 2804 (class 2606 OID 52270)
-- Name: comment comment_Question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "comment_Question_id_fkey" FOREIGN KEY ("Question_id") REFERENCES public.question("Question_id") NOT VALID;


--
-- TOC entry 2791 (class 2606 OID 52210)
-- Name: community community_Created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community
    ADD CONSTRAINT "community_Created_by_fkey" FOREIGN KEY ("Created_by") REFERENCES public."User"("User_id") NOT VALID;


--
-- TOC entry 2812 (class 2606 OID 52240)
-- Name: post post_Created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT "post_Created_by_fkey" FOREIGN KEY ("Created_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2796 (class 2606 OID 52225)
-- Name: question question_Question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT "question_Question_id_fkey" FOREIGN KEY ("Question_id") REFERENCES public.post("Post_id") NOT VALID;


--
-- TOC entry 2814 (class 2606 OID 52325)
-- Name: review review_Post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT "review_Post_id_fkey" FOREIGN KEY ("Post_id") REFERENCES public.post("Post_id") NOT VALID;


--
-- TOC entry 2813 (class 2606 OID 52320)
-- Name: review review_Reviewed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT "review_Reviewed_by_fkey" FOREIGN KEY ("Reviewed_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2809 (class 2606 OID 52295)
-- Name: tag tag_Community_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "tag_Community_id_fkey" FOREIGN KEY ("Community_id") REFERENCES public.community("Community_id") NOT VALID;


--
-- TOC entry 2808 (class 2606 OID 52290)
-- Name: tag tag_Created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "tag_Created_by_fkey" FOREIGN KEY ("Created_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2794 (class 2606 OID 52310)
-- Name: vote vote_Voted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vote
    ADD CONSTRAINT "vote_Voted_by_fkey" FOREIGN KEY ("Voted_by") REFERENCES public."Community Member"("CM_id") NOT VALID;


--
-- TOC entry 2795 (class 2606 OID 52315)
-- Name: vote vote_Voted_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vote
    ADD CONSTRAINT "vote_Voted_post_fkey" FOREIGN KEY ("Voted_post") REFERENCES public.post("Post_id") NOT VALID;


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2021-12-05 19:16:36

--
-- PostgreSQL database dump complete
--

