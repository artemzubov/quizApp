DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS passed_quizzes;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
  id               INTEGER                     NOT NULL      AUTO_INCREMENT,
  name             VARCHAR(50)                 NOT NULL,
  email            VARCHAR(50)                 NOT NULL,
  hash_password    VARCHAR(100)                NOT NULL,
  enabled          BOOL DEFAULT FALSE          NOT NULL,
  role             VARCHAR(15)                 NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE topics
(
  id               INTEGER                     NOT NULL      AUTO_INCREMENT,
  name             VARCHAR(50)                 NOT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE quizzes
(
  id                INTEGER                   NOT NULL      AUTO_INCREMENT,
  name              VARCHAR(50)               NOT NULL,
  enable            BOOL DEFAULT TRUE         NOT NULL,
  user_id           INTEGER                   NOT NULL,
  topic_id          INTEGER                   ,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (topic_id) REFERENCES topics (id) On DELETE SET NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE passed_quizzes
(
  id                INTEGER                   NOT NULL      AUTO_INCREMENT,
  user_id           INTEGER                   NOT NULL,
  quiz_id           INTEGER                   NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE questions
(
  id                INTEGER                   NOT NULL      AUTO_INCREMENT,
  name              VARCHAR(500)              NOT NULL,
  quiz_id           INTEGER                   ,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE answers
(
  id                INTEGER                   NOT NULL      AUTO_INCREMENT,
  correct           BOOL DEFAULT FALSE        NOT NULL,
  name              VARCHAR(300)              NOT NULL,
  question_id       INTEGER,
  FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE tags
(
  id                INTEGER                   NOT NULL      AUTO_INCREMENT,
  name              VARCHAR(50)               NOT NULL,
  quiz_id           INTEGER                   ,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE SET NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;

CREATE TABLE results
(
  id                INTEGER                  NOT NULL      AUTO_INCREMENT,
  user_id           INTEGER                  NOT NULL,
  date              TIMESTAMP                NOT NULL,
  quiz_id           INTEGER                  NOT NULL,
  correct_answers   INTEGER                  NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_id) REFERENCES quizzes (id) ON DELETE CASCADE,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 AUTO_INCREMENT = 1 ;
