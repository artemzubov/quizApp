package com.quizApp.dao;

import com.quizApp.model.Quiz;
import com.quizApp.model.Topic;
import com.quizApp.model.User;

import java.util.List;

public interface QuizDAO {

    Quiz save(Quiz quiz);

    void remove(Quiz quiz);

    Quiz getById(Integer id);

    List<Quiz> getByUser(User user);

    List<Quiz> getEnabledAvailableForUserByTopic(User user, Topic topic);

    List<Quiz> getAll();

    void removePassedQuizzes(Quiz quiz, User user);
}
