package com.quizApp.service;

import com.quizApp.dao.TopicDAO;
import com.quizApp.model.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    private TopicDAO topicDAO;

    @Autowired
    public TopicServiceImpl(TopicDAO topicDAO) {
        this.topicDAO = topicDAO;
    }

    @Override
    public Topic save(Topic topic) {
        return topicDAO.save(topic);
    }

    @Override
    public List<Topic> saveAll(List<Topic> topics) {
        return topicDAO.saveAll(topics);
    }

    @Override
    public void remove(Topic topic) {
         topicDAO.remove(topic);
    }

    @Override
    public List<Topic> getAll() {
        return topicDAO.getAll();
    }

    @Override
    public Topic getById(Integer id) {
        return topicDAO.getById(id);
    }
}
