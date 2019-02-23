package com.quizApp.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "questions")
public class Question implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Transient
    private List<String> tags;

    @Column(name = "name")
    private String questionText;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name ="question_id")
    private List<Answer> answers;

    @Column(name = "quiz_id")
    private Integer quiz_id;


    public Question() {
    }

    public Question(Integer id, List<String> tags, String questionText, List<Answer> answers) {
        this.id = id;
        this.tags = tags;
        this.questionText = questionText;
       this.answers = answers;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public Integer getQuiz_id() {
        return quiz_id;
    }

    public void setQuiz_id(Integer quiz_id) {
        this.quiz_id = quiz_id;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Question question = (Question) o;
        return Objects.equals(getId(), question.getId());
    }



    @Override
    public int hashCode() {

        return Objects.hash(getId());
    }

    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", tags=" + tags +
                ", questionText='" + questionText + '\'' +
                ", quizId=" + quiz_id +
                ", answers=" + answers +
                '}';
    }
}
