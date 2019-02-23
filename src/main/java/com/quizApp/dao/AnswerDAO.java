package com.quizApp.dao;

import com.quizApp.model.Answer;
import com.quizApp.model.Question;

import java.util.List;

public interface AnswerDAO {

    Answer save(Answer answer);

    void remove(Answer answer);

    Answer getById(Integer answerId);

    List<Answer> getByQuestion(Question question);

}
