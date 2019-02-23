package com.quizApp.service;

import com.quizApp.dao.AnswerDAO;
import com.quizApp.dao.QuestionDAO;
import com.quizApp.model.Answer;
import com.quizApp.model.Question;
import com.quizApp.model.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    private QuestionDAO questionDAO;
    private AnswerDAO answerDAO;

    @Autowired
    public QuestionServiceImpl(QuestionDAO questionDAO, AnswerDAO answerDAO) {
        this.questionDAO = questionDAO;
        this.answerDAO = answerDAO;
    }

    @Override
    public Question save(Question question) {
        return questionDAO.save(question);
    }

    @Override
    public void remove(Question question) {
        questionDAO.remove(question);
    }

    @Override
    public Question getById(Integer id) {
        return questionDAO.getById(id);
    }

    @Override
    public List<Question> getByQuiz(Quiz quiz) {
        return questionDAO.getByQuiz(quiz);
    }

    @Override
    public List<Answer> getAnswers(Question question) {
        return answerDAO.getByQuestion(question);
    }

}
