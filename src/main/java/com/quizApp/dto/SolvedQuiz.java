package com.quizApp.dto;

import java.util.Arrays;
import java.util.NoSuchElementException;

public class SolvedQuiz {
    private Integer quiz_id;
    private AnsweredQuestion [] answeredQuestions;

    public void setQuiz_id(Integer id) {
        this.quiz_id = id;
    }
    public void setAnsweredQuestions(AnsweredQuestion[] answeredQuestions){
        this.answeredQuestions = answeredQuestions;
    }

    public Integer getQuiz_id(){
        return quiz_id;
    }

    public AnsweredQuestion[] getAnsweredQuestions(){
        return answeredQuestions;
    }

    public AnsweredQuestion getQuestionById(Integer id) throws NoSuchElementException {
        final int LEN = answeredQuestions.length;

        for (int i = 0; i < LEN; i++) {
            if (answeredQuestions[i].getQuestionId() == id) {
                return answeredQuestions[i];
            }
        }
        throw new NoSuchElementException();
    }

    @Override
    public String toString() {
        return "SolvedQuiz{" +
                "quiz_id=" + quiz_id +
                ", answeredQuestions=" + Arrays.toString(answeredQuestions) +
                '}';
    }
}