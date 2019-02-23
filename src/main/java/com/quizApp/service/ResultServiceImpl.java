package com.quizApp.service;

import com.quizApp.dao.QuizDAO;
import com.quizApp.dao.ResultDAO;
import com.quizApp.dto.AnsweredQuestion;
import com.quizApp.dto.SolvedQuiz;
import com.quizApp.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

@Service
public class ResultServiceImpl implements ResultService {

    private ResultDAO resultDAO;
    private QuizDAO quizDAO;

    @Autowired
    public ResultServiceImpl(ResultDAO resultDAO, QuizDAO quizDAO) {
        this.quizDAO = quizDAO;
        this.resultDAO = resultDAO;
    }

    @Override
    public Result save(Result result) {
        return resultDAO.save(result);
    }

    @Override
    public void remove(Result result) {
        resultDAO.remove(result);
    }

    @Override
    public Result getById(Integer id) {
        return resultDAO.getById(id);
    }

    @Override
    public List<Result> getByUser(User user) {
        List<Result> results = resultDAO.getByUser(user);
        return results;
    }

    @Override
    public List<Result> getByQuiz(Quiz quiz) {
        List<Result> results = resultDAO.getByQuiz(quiz);
        return results;
    }

    @Override
    public List<Result> getByTeacher(User user) {
        List<Result> results = resultDAO.getByTeacher(user);
        return results;
    }

    @Override
    public Result createResult(SolvedQuiz solvedQuiz, User user) {
        int correct_answers = 0;
        AnsweredQuestion answeredQuestion;
        Quiz quizSample = quizDAO.getById(solvedQuiz.getQuiz_id());
        Set<Question> questionsSample = quizSample.getQuestions();
        List<Answer> answersSample;
        boolean answerIsCorrect;
        Result result = new Result();
        for (Question oneQuestionSample : questionsSample) {
            answerIsCorrect = true;
            answeredQuestion = solvedQuiz.getQuestionById(oneQuestionSample.getId());
            answersSample = oneQuestionSample.getAnswers();
            for (Answer answerSample : answersSample) {
                if (answerSample.getCorrect()) {
                    if (!Arrays.asList(
                            answeredQuestion.getAnswersId())
                            .contains(answerSample.getId())) {
                        answerIsCorrect = false;
                    }
                } else {
                    if (Arrays.asList(
                            answeredQuestion.getAnswersId())
                            .contains(answerSample.getId())) {
                        answerIsCorrect = false;
                    }
                }
            }
            if (answerIsCorrect) {
                correct_answers++;
            }
        }
        result.setCorrectAnswers(correct_answers);
        result.setDate(LocalDate.now());
        result.setUser(user);
        result.setQuiz(quizSample);

        return resultDAO.save(result);

    }
}
