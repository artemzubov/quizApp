package com.quizApp.model;

import javax.persistence.*;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "quizzes")
public class Quiz  {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "topic_id")
    private Topic topic;

    @Column(name = "name")
    private String title;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User author;

    @Column(name = "enable")
    private Boolean enabled;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "quiz_id")
    private Set<Question> questions;

    public Quiz() {
    }

    public Quiz(Integer id, Topic topic, String title, User author, Boolean isEnabled, Set<Question> questions) {
        this.id = id;
        this.topic = topic;
        this.title = title;
        this.author = author;
        this.enabled = isEnabled;
        this.questions = questions;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean isEnabled) {
        this.enabled = isEnabled;
    }

    public Set<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(Set<Question> questions) {
        this.questions = questions;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Quiz quiz = (Quiz) o;
        return Objects.equals(getId(), quiz.getId());
    }

    @Override
    public int hashCode() {

        return Objects.hash(getId());
    }

    @Override
    public String toString() {
        return "Quiz{" +
                "id=" + id +
                ", topic='" + topic + '\'' +
                ", title='" + title + '\'' +
                ", author=" + author +
                ", isEnabled=" + enabled +
                 ", questions=" + questions +
                '}';
    }
}
