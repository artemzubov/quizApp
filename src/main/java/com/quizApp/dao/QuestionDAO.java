package com.quizApp.dao;

import com.quizApp.model.Question;
import com.quizApp.model.Quiz;

import java.util.List;

public interface QuestionDAO {

    Question save(Question question);

    void remove(Question question);

    Question getById(Integer questionId);

    List<Question> getByQuiz(Quiz quiz);
}
