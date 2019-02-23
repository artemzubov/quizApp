package com.quizApp.dao;

import com.quizApp.model.Answer;
import com.quizApp.model.Question;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AnswerDAOImpl implements AnswerDAO {

    @Autowired
    SessionFactory sessionFactory;

    public AnswerDAOImpl() {
    }

    @Override
    public Answer save(Answer answer) {
        return getById((Integer) sessionFactory.getCurrentSession().save(answer));
    }

    @Override
    public void remove(Answer answer) {
        sessionFactory.getCurrentSession().delete(answer);
    }

    @Override
    public Answer getById(Integer answerId) {
        return sessionFactory.getCurrentSession().load(Answer.class, answerId);
    }

    @Override
    public List<Answer> getByQuestion(Question question) {
        List<Answer> answers;
        Query query = sessionFactory.getCurrentSession().createQuery("from Answer where question = :question ");
        query.setParameter("question", question);
        answers = (List<Answer>) query.list();
        return answers;
    }
}
