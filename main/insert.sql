BEGIN;


CREATE TABLE IF NOT EXISTS Community
(
    "Community_id" bigint PRIMARY KEY,
    "Name" varchar(40) NOT NULL,
    "type" varchar(30) check ("type" in ('Public', 'Private')),
    "Created_on" timestamp WITH TIME ZONE default CURRENT_TIMESTAMP,
    "Created_by" bigint
);

CREATE TABLE IF NOT EXISTS "User"
(
    "User_id" bigint PRIMARY KEY,
    "Name" varchar(60) NOT NULL,
    "Email Address" varchar(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS "Community Member"
(
    "CM_id" bigint PRIMARY KEY,
    "User_id" bigint NOT NULL,
    "Community_id" bigint NOT NULL,
    "Reputation" int DEFAULT 0,
    "Badge Count" int DEFAULT 0,
    "isAdmin" boolean  DEFAULT false,
    "isRemoved" boolean DEFAULT false
);

CREATE TABLE IF NOT EXISTS Question
(
    "Question_id" bigint PRIMARY KEY,
    "Protected?" boolean,
    "Reviewed" varchar(30) check ("Reviewed" in ('Accepted', 'Rejected'))
);

CREATE TABLE IF NOT EXISTS "Question Version"
(
    "Version_id" bigint PRIMARY KEY,
    "Question_id" bigint NOT NULL,
    "Title" text,
    "Content" text,
    "Version Created_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "Version_Created_by" bigint
);

CREATE TABLE IF NOT EXISTS Answer
(
    "Answer_id" bigint PRIMARY KEY,
    "Question_id" bigint NOT NULL,
    "Accepted" boolean
);

CREATE TABLE IF NOT EXISTS "Answer Version"
(
    "Version_id" bigint PRIMARY KEY,
    "Answer_id" bigint NOT NULL,
    "Content" text,
    "Version_Created_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "Version_Created_by" bigint
);

CREATE TABLE IF NOT EXISTS Comment
(
    "Comment_id" bigint PRIMARY KEY,
    "Question_id" bigint,
    "Answer_id" bigint
);

CREATE TABLE IF NOT EXISTS "Comment Version"
(
    "Version_id" bigint PRIMARY KEY,
    "Comment_id" bigint NOT NULL,
    "Content" text,
    "Version_Created_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "Version_Created_by" bigint
);

CREATE TABLE IF NOT EXISTS Tag
(
    "Tag_id" bigint PRIMARY KEY,
    "Name" Text,
    "Description" text,
    "Created_by" bigint,
    "Community_id" bigint,
    "Created_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Tagged Question"
(
    id bigint PRIMARY KEY,
    "Tag_id" bigint,
    "Version_id" bigint
);

CREATE TABLE IF NOT EXISTS Post
(
    "Post_id" bigint PRIMARY KEY,
    "Created_by" bigint,
    "Created_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Review
(
    "Review_id" bigint PRIMARY KEY,
    "Reviewed_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "Type" varchar(20) check ("Type" in ('Accepted', 'Rejected')),
    "Reviewed_by" bigint,
    "Post_id" bigint
);

CREATE TABLE IF NOT EXISTS Badges
(
    "Badge_id" bigint PRIMARY KEY,
    "Badge_name" varchar(30),
    "Badge_type" varchar(30),
    "CM_id" bigint
);

ALTER TABLE Community
ADD FOREIGN KEY ("Created_by")
REFERENCES "User" ("User_id")
    NOT VALID;


ALTER TABLE "Community Member"
    ADD FOREIGN KEY ("User_id")
REFERENCES "User" ("User_id")
    NOT VALID;


ALTER TABLE "Community Member"
    ADD FOREIGN KEY ("Community_id")
REFERENCES Community ("Community_id")
    NOT VALID;


ALTER TABLE Question
ADD FOREIGN KEY ("Question_id")
REFERENCES Post ("Post_id")
    NOT VALID;


ALTER TABLE "Question Version"
    ADD FOREIGN KEY ("Version_Created_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;

ALTER TABLE "Question Version"
    ADD FOREIGN KEY ("Question_id")
REFERENCES Question ("Question_id")
    NOT VALID;
    
ALTER TABLE Post
ADD FOREIGN KEY ("Created_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;


ALTER TABLE Answer
ADD FOREIGN KEY ("Answer_id")
REFERENCES Post ("Post_id")
    NOT VALID;

ALTER TABLE Answer
ADD FOREIGN KEY ("Question_id")
REFERENCES Question ("Question_id")
    NOT VALID;


ALTER TABLE "Answer Version"
    ADD FOREIGN KEY ("Version_Created_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;

ALTER TABLE "Answer Version"
    ADD FOREIGN KEY ("Answer_id")
REFERENCES Answer ("Answer_id")
    NOT VALID;


ALTER TABLE Comment
ADD FOREIGN KEY ("Comment_id")
REFERENCES Post ("Post_id")
    NOT VALID;

ALTER TABLE Comment
ADD FOREIGN KEY ("Question_id")
REFERENCES Question ("Question_id")
    NOT VALID;

ALTER TABLE Comment
ADD FOREIGN KEY ("Answer_id")
REFERENCES Answer ("Answer_id")
    NOT VALID;

ALTER TABLE "Comment Version"
    ADD FOREIGN KEY ("Verson_Created_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;

ALTER TABLE "Comment Version"
    ADD FOREIGN KEY ("Comment_id")
REFERENCES Comment ("Comment_id")
    NOT VALID;

ALTER TABLE Tag
ADD FOREIGN KEY ("Created_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;

CREATE TABLE IF NOT EXISTS Vote
(
    id bigint PRIMARY KEY,
    "Vote_type" varchar(5) check ("Vote_type" in ('Up', 'Down')),
    "Voted_on" timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "Voted_by" bigint,
    "Voted_post" bigint 
);


ALTER TABLE Tag
ADD FOREIGN KEY ("Community_id")
REFERENCES Community ("Community_id")
    NOT VALID;


ALTER TABLE "Tagged Question"
    ADD FOREIGN KEY ("Tag_id")
REFERENCES Tag ("Tag_id")
    NOT VALID;


ALTER TABLE "Tagged Question"
    ADD FOREIGN KEY ("Version_id")
REFERENCES "Question Version" ("Version_id")
    NOT VALID;


ALTER TABLE Vote
ADD FOREIGN KEY ("Voted_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;


ALTER TABLE Vote
ADD FOREIGN KEY ("Voted_post")
REFERENCES Post ("Post_id")
    NOT VALID;


ALTER TABLE Review
ADD FOREIGN KEY ("Reviewed_by")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;


ALTER TABLE Review
ADD FOREIGN KEY ("Post_id")
REFERENCES Post ("Post_id")
    NOT VALID;


ALTER TABLE Badges
ADD FOREIGN KEY ("CM_id")
REFERENCES "Community Member" ("CM_id")
    NOT VALID;

END;
