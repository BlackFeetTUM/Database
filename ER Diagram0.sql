CREATE TABLE lectureGroups (
 groupId INT NOT NULL,
 name VARCHAR(255)
);

ALTER TABLE lectureGroups ADD CONSTRAINT PK_lectureGroups PRIMARY KEY (groupId);


CREATE TABLE lecutres (
 lectureId INT NOT NULL,
 name VARCHAR(255),
 startDate TIMESTAMP(255),
 endDate TIMESTAMP(255),
 active INT DEFAULT 0,
 password VARCHAR(255)
);

ALTER TABLE lecutres ADD CONSTRAINT PK_lecutres PRIMARY KEY (lectureId);


CREATE TABLE user (
 userId INT NOT NULL,
 prename VARCHAR(255),
 surname VARCHAR(255),
 email VARCHAR(255),
 username VARCHAR(255),
 password VARCHAR(255)
);

ALTER TABLE user ADD CONSTRAINT PK_user PRIMARY KEY (userId);


CREATE TABLE evaType (
 etId INT NOT NULL,
 hostUserId INT NOT NULL,
 value VARCHAR(255)
);

ALTER TABLE evaType ADD CONSTRAINT PK_evaType PRIMARY KEY (etId,hostUserId);


CREATE TABLE lectureXGroups (
 groupId INT NOT NULL,
 lectureId INT NOT NULL
);

ALTER TABLE lectureXGroups ADD CONSTRAINT PK_lectureXGroups PRIMARY KEY (groupId,lectureId);


CREATE TABLE session (
 userId INT NOT NULL,
 lectureId INT NOT NULL,
 role INT
);

ALTER TABLE session ADD CONSTRAINT PK_session PRIMARY KEY (userId,lectureId);


CREATE TABLE evaluation (
 lectureId INT NOT NULL,
 userId INT NOT NULL,
 hostUserId INT NOT NULL,
 etId INT NOT NULL,
 value VARCHAR(255)
);

ALTER TABLE evaluation ADD CONSTRAINT PK_evaluation PRIMARY KEY (lectureId,userId,hostUserId,etId);


CREATE TABLE mcQuestions (
 mcId INT NOT NULL,
 value VARCHAR(255),
 userId INT NOT NULL,
 lectureId INT NOT NULL
);

ALTER TABLE mcQuestions ADD CONSTRAINT PK_mcQuestions PRIMARY KEY (mcId);


CREATE TABLE paceControl (
 paceId INT NOT NULL,
 value VARCHAR(255),
 timestamp TIMESTAMP(255),
 userId INT NOT NULL,
 lectureId INT NOT NULL
);

ALTER TABLE paceControl ADD CONSTRAINT PK_paceControl PRIMARY KEY (paceId);


CREATE TABLE questionAlert (
 questionId INT NOT NULL,
 active INT,
 timestamp TIMESTAMP(255),
 userId INT NOT NULL,
 lectureId INT NOT NULL
);

ALTER TABLE questionAlert ADD CONSTRAINT PK_questionAlert PRIMARY KEY (questionId);


CREATE TABLE questionAnswers (
 ansId INT NOT NULL,
 mcId INT NOT NULL,
 value VARCHAR(255)
);

ALTER TABLE questionAnswers ADD CONSTRAINT PK_questionAnswers PRIMARY KEY (ansId,mcId);


CREATE TABLE userAnswers (
 userId INT NOT NULL,
 ansId INT NOT NULL,
 mcId INT NOT NULL
);

ALTER TABLE userAnswers ADD CONSTRAINT PK_userAnswers PRIMARY KEY (userId,ansId,mcId);


ALTER TABLE evaType ADD CONSTRAINT FK_evaType_0 FOREIGN KEY (hostUserId) REFERENCES user (userId);


ALTER TABLE lectureXGroups ADD CONSTRAINT FK_lectureXGroups_0 FOREIGN KEY (groupId) REFERENCES lectureGroups (groupId);
ALTER TABLE lectureXGroups ADD CONSTRAINT FK_lectureXGroups_1 FOREIGN KEY (lectureId) REFERENCES lecutres (lectureId);


ALTER TABLE session ADD CONSTRAINT FK_session_0 FOREIGN KEY (userId) REFERENCES user (userId);
ALTER TABLE session ADD CONSTRAINT FK_session_1 FOREIGN KEY (lectureId) REFERENCES lecutres (lectureId);


ALTER TABLE evaluation ADD CONSTRAINT FK_evaluation_0 FOREIGN KEY (lectureId) REFERENCES lecutres (lectureId);
ALTER TABLE evaluation ADD CONSTRAINT FK_evaluation_1 FOREIGN KEY (userId,lectureId) REFERENCES session (userId,lectureId);
ALTER TABLE evaluation ADD CONSTRAINT FK_evaluation_2 FOREIGN KEY (etId,userId) REFERENCES evaType (etId,hostUserId);


ALTER TABLE mcQuestions ADD CONSTRAINT FK_mcQuestions_0 FOREIGN KEY (userId,lectureId) REFERENCES session (userId,lectureId);


ALTER TABLE paceControl ADD CONSTRAINT FK_paceControl_0 FOREIGN KEY (userId,lectureId) REFERENCES session (userId,lectureId);


ALTER TABLE questionAlert ADD CONSTRAINT FK_questionAlert_0 FOREIGN KEY (userId,lectureId) REFERENCES session (userId,lectureId);


ALTER TABLE questionAnswers ADD CONSTRAINT FK_questionAnswers_0 FOREIGN KEY (mcId) REFERENCES mcQuestions (mcId);


ALTER TABLE userAnswers ADD CONSTRAINT FK_userAnswers_0 FOREIGN KEY (userId) REFERENCES user (userId);
ALTER TABLE userAnswers ADD CONSTRAINT FK_userAnswers_1 FOREIGN KEY (ansId,mcId) REFERENCES questionAnswers (ansId,mcId);


