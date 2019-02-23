package com.quizApp.service;

import com.quizApp.model.Topic;

import javax.transaction.Transactional;
import java.util.List;
@Transactional
public interface TopicService {

    Topic save(Topic topic);

    List<Topic> saveAll(List<Topic> topics);

    void remove(Topic topic);

    List<Topic> getAll();

    Topic getById(Integer id);


}
