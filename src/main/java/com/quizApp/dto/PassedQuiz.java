package com.quizApp.dto;

import javax.persistence.*;

@Entity
@Table(name = "passed_quizzes")
public class PassedQuiz {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "user_id")
    private Integer user_id;

    @Column(name = "quiz_id")
    private Integer quiz_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public void setQuiz_id(Integer quiz_id) {
        this.quiz_id = quiz_id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public Integer getQuiz_id() {
        return quiz_id;
    }
    @Override
    public String toString() {
        return "Quiz{" +
                "id"+id+
                "quiz_id=" + quiz_id +
                "user_id = "+ user_id+
                '}';
    }

}
