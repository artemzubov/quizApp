package com.quizApp.dto;

public class AnsweredQuestion {
    private Integer questionId;
    private Integer [] answersId;

    public void setAnswersId(Integer[] answersId) {
        this.answersId = answersId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public Integer getQuestionId() {
        return questionId;
    }

    public Integer[] getAnswersId() {
        return answersId;
    }
}