package com.quizApp.service;

import com.quizApp.model.Answer;
import com.quizApp.model.Question;
import com.quizApp.model.Quiz;

import javax.transaction.Transactional;
import java.util.List;
@Transactional
public interface QuestionService {

    Question save(Question question);

    void remove(Question question);

    Question getById(Integer id);

    List<Question> getByQuiz(Quiz quiz);
    List<Answer> getAnswers(Question question);
}
