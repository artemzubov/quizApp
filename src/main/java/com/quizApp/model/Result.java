package com.quizApp.model;


import javax.persistence.*;
import java.time.LocalDate;
import java.util.Objects;

@Entity
@Table(name = "results")
public class Result {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "date")
    private LocalDate date;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "quiz_id")
    private Quiz quiz;

    @Column(name = "correct_answers")
    private Integer correct_answers;

    public Result() {
    }

    public Result(Integer id, User user, LocalDate date, Quiz quiz, Integer correct_answers) {
        this.id = id;
        this.user = user;
        this.date = date;
        this.quiz = quiz;
        this.correct_answers = correct_answers;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public Integer getCorrectAnswers() {
        return correct_answers;
    }

    public void setCorrectAnswers(Integer correct_answers) {
        this.correct_answers = correct_answers;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Result result = (Result) o;
        return Objects.equals(getId(), result.getId()) &&
                Objects.equals(getUser(), result.getUser()) &&
                Objects.equals(getDate(), result.getDate()) &&
                Objects.equals(getQuiz(), result.getQuiz()) &&
                Objects.equals(getCorrectAnswers(), result.getCorrectAnswers());
    }

    @Override
    public int hashCode() {

        return Objects.hash(getId(), getUser(), getDate(), getQuiz(), getCorrectAnswers());
    }

    @Override
    public String toString() {
        return "Result{" +
                "id=" + id +
                ", user=" + user +
                ", date=" + date +
                ", quiz=" + quiz.toString() +
                ", correct_answers=" + correct_answers +
                '}';
    }
}

