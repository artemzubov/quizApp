package com.quizApp.dao;

import com.quizApp.model.Topic;

import java.util.List;

public interface TopicDAO {
    Topic save(Topic topic);

    List<Topic> saveAll(List<Topic> topics);

    void remove(Topic topic);

    List<Topic> getAll();

    Topic getById(Integer id);
}
