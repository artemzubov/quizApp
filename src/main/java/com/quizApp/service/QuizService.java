package com.quizApp.service;

import com.quizApp.model.Question;
import com.quizApp.model.Quiz;
import com.quizApp.model.Topic;
import com.quizApp.model.User;

import javax.transaction.Transactional;
import java.util.List;
@Transactional
public interface QuizService {

    void saveOrUpdate(Quiz quiz);

    void remove(Quiz quiz);

    Quiz getById(Integer id);

    List<Quiz> getByUser(User user);

    List<Quiz> getEnabledAvailableForUserByTopic(User user, Topic topic);

    List<Quiz> getAll();
    List<Question> getQuestions(Quiz quiz);

    void removePassedQuizzes(Quiz quiz, User user);

}
