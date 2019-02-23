package com.quizApp.dao;

import com.quizApp.model.Topic;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.Query;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class TopicDAOImpl implements TopicDAO {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public Topic save(Topic topic) {
        return getById((Integer) sessionFactory.getCurrentSession().save(topic));
    }

    @Override
    public List<Topic> saveAll(List<Topic> topics) {

        return topics.stream()
                .filter(topic ->(topic.getId() == null || topic.getId() == -1) )
                .peek(topic -> topic.setId(null))
                .map(this::save)
                .collect(Collectors.toList());
    }

    @Override
    public void remove(Topic topic) {
        sessionFactory.getCurrentSession().delete(topic);
    }

    @Override
    public List<Topic> getAll() {
        String queryString = "from Topic";
        Query query = sessionFactory.getCurrentSession().createQuery(queryString);
        return query.getResultList();
    }

    @Override
    public Topic getById(Integer id) {
        return sessionFactory.getCurrentSession().get(Topic.class, id);
    }
}

