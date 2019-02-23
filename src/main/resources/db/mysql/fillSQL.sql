INSERT INTO users (id, name, email, hash_password, enabled, role) VALUES
(1,  'Yoda',     'yoda@starwars.ru',     '$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC',  TRUE,   'ROLE_TEACHER'),
(2,  'Obi',      'Obi@starwars.ru',      '$2a$10$RDsfJ/j.hO9LX9VSRmET8.fcuDsuBKM6/A68VidG8dMiSsHXIUR5G',  TRUE,   'ROLE_ADMIN'),
(3,  'Luke',     'luke@starwars.ru',     '$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC',  TRUE,   'ROLE_STUDENT'),
(4,  'Anykey',   'anykey@starwars.ru',   '$2a$10$Lj8BnWseTugcWJAvcd949eEDfjWwSDmNKhXu.L9HxCPHivf/iG3Ru',  TRUE,   'ROLE_STUDENT'),
(5,  'Dooku',    'dooku@starwars.ru',    '$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC',  TRUE,   'ROLE_REQUEST');


-- insert topics
INSERT INTO topics (id, name) VALUES
(1,   'PowerManagement'),
(2,   'LaserSwordSwinging'),
(3,   'Telekinesis');


-- insert quizzes
INSERT INTO quizzes (id, name, enable, user_id, topic_id) VALUES
(1,   'Jedi power. Basic rules.',   TRUE,   1,  1),
(2,   'Sword structure.',           TRUE,   1,  2);


-- insert passed_quizzes
INSERT INTO passed_quizzes (id, user_id, quiz_id) VALUES
(1, 3,   2);


-- insert passed_quizzes
INSERT INTO questions (id, name, quiz_id) VALUES
(1,   'First question for quiz about jedi POWER. Your question could be here',        1),
(2,   'Second question for quiz about jedi POWER. Your question could be here too',   1),

(3,   'First question for quiz about jedi SWORDS. Your question could be here',       2),
(4,   'Second question for quiz about jedi SWORDS. Your question could be here too',  2);


-- insert answers
INSERT INTO answers (id, correct, name, question_id) VALUES
(1,   FALSE,  'Wrong answer for Question ONE for quiz about POWER',     1),
(2,   TRUE,   'Correct answer for Question ONE for quiz about POWER',   1),
(3,   FALSE,  'Wrong answer for Question ONE for quiz about POWER',     1),
(4,   FALSE,  'Wrong answer for Question ONE for quiz about POWER',     1),

(5,   FALSE,  'Wrong answer for Question TWO for quiz about POWER',     2),
(6,   FALSE,  'Wrong answer for Question TWO for quiz about POWER',     2),
(7,   TRUE,   'Correct answer for Question TWO for quiz about POWER',   2),
(8,   FALSE,  'Wrong answer for Question TWO for quiz about POWER',     2),

(9,   FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    3),
(10,  FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    3),
(11,  FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    3),
(12,  TRUE,   'Correct answer for Question ONE for quiz about SWORDS',  3),

(13,  TRUE,   'Correct answer for Question ONE for quiz about SWORDS',  4),
(14,  TRUE,   'Correct answer for Question ONE for quiz about SWORDS',  4),
(15,  FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    4),
(16,  FALSE,  'Wrong answer for Question ONE for quiz about SWORDS',    4);


-- insert tags
INSERT INTO tags (id, name, quiz_id) VALUES
(1,   'Im a tag bound to quiz about SWORDS.',           2),
(2,   'Im a tag bound to quiz about SWORDS either!',    2);


-- insert results
INSERT INTO results (id, user_id, date, quiz_id, correct_answers) VALUES
(1,   3,  '2018-06-06',    2,    0),
(2,   3,  '2018-07-06',    2,    1);
