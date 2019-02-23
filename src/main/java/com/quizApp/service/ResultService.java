package com.quizApp.service;

import com.quizApp.dto.SolvedQuiz;
import com.quizApp.model.Quiz;
import com.quizApp.model.Result;
import com.quizApp.model.User;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface ResultService {

    Result save(Result result);

    void remove(Result result);

    Result getById(Integer id);

    List<Result> getByUser(User user);

    List<Result> getByQuiz(Quiz quiz);

    List<Result> getByTeacher(User user);

    Result createResult(SolvedQuiz solvedQuiz, User user);

}
