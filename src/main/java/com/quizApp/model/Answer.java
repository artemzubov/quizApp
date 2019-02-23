package com.quizApp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "answers")
public class Answer {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String variant;

    @Column(name = "correct")
    private Boolean correct;

    @Column(name="question_id")
    private Integer question_id;

    public Answer() {
    }

    public Answer(Integer id, String variant, Boolean isCorrect, Question question) {
        this.id = id;
        this.variant = variant;
        this.correct = isCorrect;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getVariant() {
        return variant;
    }

    public void setVariant(String variant) {
        this.variant = variant;
    }

    public Boolean getCorrect() {
        return correct;
    }

    public void setCorrect(Boolean isCorrect) {
        this.correct = isCorrect;
    }

    public Integer getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(Integer question_id) {
        this.question_id = question_id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Answer answer = (Answer) o;
        return Objects.equals(getId(), answer.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }

    @Override
    public String toString() {
        return "Answer{" +
                "id=" + id +
                ", variant='" + variant + '\'' +
                ", isCorrect=" + correct +
                ", questionId=" + question_id +
                '}';
    }
}
