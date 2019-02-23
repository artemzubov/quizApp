package com.quizApp.service;

import com.quizApp.dao.AnswerDAO;
import com.quizApp.model.Answer;
import com.quizApp.model.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class AnswerServiceImpl implements AnswerService {

    private AnswerDAO answerDAO;

    @Autowired
    public AnswerServiceImpl(AnswerDAO answerDAO) {
        this.answerDAO = answerDAO;
    }

    @Override
    public Answer save(Answer answer) {
        return answerDAO.save(answer);
    }

    @Override
    public void remove(Answer answer) {
        answerDAO.remove(answer);
    }

    @Override
    public Answer getById(Integer id) {
        return answerDAO.getById(id);
    }

    @Override
    public List<Answer> getByQuestion(Question question) {
        List<Answer> answers = answerDAO.getByQuestion(question);
        Collections.shuffle(answers);
        return answers;
    }
}
