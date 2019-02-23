package com.quizApp.dao;

import com.quizApp.model.Quiz;
import com.quizApp.model.Result;
import com.quizApp.model.User;

import java.util.List;

public interface ResultDAO {
     Result save(Result result);

     void remove(Result result);

     Result getById(Integer resultId);

     List<Result> getByUser(User user);

     List<Result> getByQuiz(Quiz quiz);

     List<Result> getByTeacher(User user);

}
