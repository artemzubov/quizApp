package com.quizApp.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionController {

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNotFoundError() {
        return "404";
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView allExceptions(Exception e) {
        String message = e.getMessage();
        ModelAndView model = new ModelAndView();
        model.setViewName("error");
        model.addObject("msg", message);
        return model;
    }

}