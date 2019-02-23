package com.quizApp.dao;

import com.quizApp.model.Question;
import com.quizApp.model.Quiz;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class QuestionDAOImpl implements QuestionDAO {

    @Autowired
    SessionFactory sessionFactory;

    public QuestionDAOImpl() {
    }

    @Override
    public Question save(Question question) {
        if (question.getId() == null){
            return getById((Integer) sessionFactory.getCurrentSession().save(question));
        }
        else {
            sessionFactory.getCurrentSession().saveOrUpdate(question);
            return question;
        }
    }

    @Override
    public void remove(Question question) {
        sessionFactory.getCurrentSession().delete(question);
    }

    @Override
    public Question getById(Integer questionId) {
        return sessionFactory.getCurrentSession().load(Question.class, questionId);
    }

    @Override
    public List<Question> getByQuiz(Quiz quiz) {
        List<Question> questions;
        Query query = sessionFactory.getCurrentSession().createQuery("from Question where quiz_id = :quiz_id_val ");
        query.setParameter("quiz_id_val", quiz.getId());
        questions = (List<Question>) query.list();
        return questions;
    }
}
