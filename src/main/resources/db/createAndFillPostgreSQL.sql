DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS passed_quizzes;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS users;

DROP SEQUENCE IF EXISTS global_seq;

CREATE SEQUENCE global_seq START WITH 1;

CREATE TABLE users
(
  id               INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  name             VARCHAR(50)                 NOT NULL,
  email            VARCHAR(50)                 NOT NULL,
  hash_password    VARCHAR(100)                NOT NULL,
  enabled          BOOL DEFAULT FALSE          NOT NULL,
  role             VARCHAR(15)                 NOT NULL,
  CONSTRAINT email UNIQUE (email)
) ;
CREATE UNIQUE INDEX users_unique_email_idx ON users(email);


CREATE TABLE topics
(
  id               INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  name             VARCHAR(50)                 NOT NULL
) ;


CREATE TABLE quizzes
(
  id                INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  name              VARCHAR(50)               NOT NULL,
  enable            BOOL DEFAULT TRUE         NOT NULL,
  user_id           INTEGER                   NOT NULL,
  topic_id          INTEGER                   ,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (topic_id) REFERENCES topics (id) On DELETE SET NULL
) ;

CREATE TABLE passed_quizzes
(
  id                INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  user_id           INTEGER                   NOT NULL,
  quiz_id           INTEGER                   NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ;


CREATE TABLE questions
(
  id                INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  name              VARCHAR(500)              NOT NULL,
  quiz_id           INTEGER                   ,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ;

CREATE TABLE answers
(
  id                INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  correct           BOOL DEFAULT FALSE        NOT NULL,
  name              VARCHAR(300)              NOT NULL,
  question_id       INTEGER                   ,
  FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
) ;

CREATE TABLE tags
(
  id                INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  name              VARCHAR(50)               NOT NULL,
  quiz_id           INTEGER                   ,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE SET NULL,
  CONSTRAINT name UNIQUE (name)
) ;


CREATE TABLE results
(
  id                INTEGER PRIMARY KEY DEFAULT nextval('global_seq'),
  user_id           INTEGER                  NOT NULL,
  date              TIMESTAMP(0)                NOT NULL,
  quiz_id           INTEGER                  NOT NULL,
  correct_answers   INTEGER                  NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE
) ;




-- insert users
INSERT INTO users (name, email, hash_password, enabled, role) VALUES
--1,2,3,4,5
('Yoda',     'yoda@starwars.ru',     '$2a$10$pFpTCkKuc8TshT1GinbyrOLY9ALa/VZYkoZb0ogbhEPxAsmAs4l4m',  TRUE,   'ROLE_TEACHER'),
('Obi',      'Obi@starwars.ru',      '$2a$10$pFpTCkKuc8TshT1GinbyrOLY9ALa/VZYkoZb0ogbhEPxAsmAs4l4m',  TRUE,   'ROLE_ADMIN'),
('Luke',     'luke@starwars.ru',     '$2a$10$pFpTCkKuc8TshT1GinbyrOLY9ALa/VZYkoZb0ogbhEPxAsmAs4l4m',  TRUE,   'ROLE_STUDENT'),
('Anykey',   'anykey@starwars.ru',   '$2a$10$pFpTCkKuc8TshT1GinbyrOLY9ALa/VZYkoZb0ogbhEPxAsmAs4l4m',  TRUE,   'ROLE_STUDENT'),
('Dooku',    'dooku@starwars.ru',    '$2a$10$pFpTCkKuc8TshT1GinbyrOLY9ALa/VZYkoZb0ogbhEPxAsmAs4l4m',  TRUE,   'ROLE_REQUEST');

-- insert topics
INSERT INTO topics (name) VALUES
-- 6,7,8
('PowerManagement'),
('LaserSwordSwinging'),
('Telekinesis');


-- insert quizzes
INSERT INTO quizzes (name, enable, user_id, topic_id) VALUES
-- 9, 10, 11
('Jedi power. Basic rules.',   TRUE,   1,  6),
('Sword structure.',           TRUE,   1,  6),
('One more quiz',              TRUE,   1,  7);


-- insert passed_quizzes
INSERT INTO passed_quizzes (user_id, quiz_id) VALUES
(3,   10);


-- insert passed_quizzes
INSERT INTO questions (name, quiz_id) VALUES
--12,13,14,15
('First question for quiz about jedi POWER. Your question could be here',        9),
('Second question for quiz about jedi POWER. Your question could be here too',   9),

('First question for quiz about jedi SWORDS. Your question could be here',       10),
('Second question for quiz about jedi SWORDS. Your question could be here too',  10);


-- insert answers
INSERT INTO answers (correct, name, question_id) VALUES
--16,17,18,19
(FALSE,  'Wrong answer for Question ONE for quiz about POWER',     13),
(TRUE,   'Correct answer for Question ONE for quiz about POWER',   13),
(FALSE,  'Wrong answer for Question ONE for quiz about POWER',     13),
(FALSE,  'Wrong answer for Question ONE for quiz about POWER',     13),

--20,21,22,23
(FALSE,  'Wrong answer for Question TWO for quiz about POWER',     13),
(FALSE,  'Wrong answer for Question TWO for quiz about POWER',     13),
(TRUE,   'Correct answer for Question TWO for quiz about POWER',   13),
(FALSE,  'Wrong answer for Question TWO for quiz about POWER',     13),

--24,25,26,27
(FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    14),
(FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    14),
(FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    14),
(TRUE,   'Correct answer for Question ONE for quiz about SWORDS',  14),

--28,29,30,31
(TRUE,   'Correct answer for Question ONE for quiz about SWORDS',  15),
(TRUE,   'Correct answer for Question ONE for quiz about SWORDS',  15),
(FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    15),
(FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    15);


-- insert tags
INSERT INTO tags (name, quiz_id) VALUES
--32,33
('Im a tag bound to quiz about SWORDS.',           10),
('Im a tag bound to quiz about SWORDS either!',    10);


-- insert results
INSERT INTO results (user_id, date, quiz_id, correct_answers) VALUES
--34,35
(3,  '2018-06-06 10:00:00',    10,    0),
(3,  '2018-07-06 10:00:00',    10,    1);