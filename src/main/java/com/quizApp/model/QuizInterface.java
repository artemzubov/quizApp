package com.quizApp.model;

import java.util.List;

public interface QuizInterface {
    Integer getId();

    void setId(Integer id);

    Topic getTopic();

    void setTopic(Topic topic);

    String getTitle();

    void setTitle(String title);

    User getAuthor();

    void setAuthor(User user_id);

    Boolean getEnabled();

    void setEnabled(Boolean enabled);

    List<Question> getQuestions();

    void setQuestions(List<Question> questions);
}
