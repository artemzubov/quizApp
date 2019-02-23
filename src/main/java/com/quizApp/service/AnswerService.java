package com.quizApp.service;

import com.quizApp.model.Answer;
import com.quizApp.model.Question;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface AnswerService {

    Answer save(Answer answer);

    void remove(Answer answer);

    Answer getById(Integer answerId);

    List<Answer> getByQuestion(Question question);

}
