package com.quizApp.controller;


import com.quizApp.dto.SolvedQuiz;
import com.quizApp.model.Result;
import com.quizApp.model.User;
import com.quizApp.service.ResultService;
import com.quizApp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.quizApp.controller.UserController.log;

@Controller
public class ResultController {
    private UserService userService;

    private ResultService resultService;

    @Autowired
    ResultController(UserService userservice, ResultService resultService) {
        this.userService = userservice;
        this.resultService = resultService;
    }

    @PostMapping("/student/resultOfQuiz")
    public void acceptQuiz(HttpServletResponse res, @RequestBody SolvedQuiz quiz) {
        Result result;
        //quiz.setId(quiz.quiz_id);
        //quiz.setAnsweredQuestions(quiz.answeredQuestions);
        log.info("we get resolved quiz");
        System.out.println("dsvjhlhjskfhjlfshjldfshjlfadshjlfsdhjl"+quiz);
        Object authName = SecurityContextHolder.getContext().getAuthentication().getName();
        User currentUser = userService.getByMail(authName.toString());
        result = resultService.createResult(quiz, currentUser);
        try {
            res.getWriter().write(result.getCorrectAnswers().toString());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}

