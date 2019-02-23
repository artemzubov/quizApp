package com.quizApp.dao;

import com.quizApp.model.Quiz;
import com.quizApp.model.Topic;
import com.quizApp.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class QuizDAOImpl implements QuizDAO {

    @Autowired
    SessionFactory sessionFactory;

    public QuizDAOImpl() {
    }

    @Override
    public Quiz save(Quiz quiz) {

        if (quiz.getId() == null) {

            return getById((Integer) sessionFactory.getCurrentSession().save(quiz));

        } else {
            sessionFactory.getCurrentSession().saveOrUpdate(quiz);
            return quiz;
        }
    }

    @Override
    public void remove(Quiz quiz) {
        sessionFactory.getCurrentSession().delete(quiz);
    }

    @Override
    public Quiz getById(Integer id) {
        List<Quiz> quiz;
        Query query = sessionFactory.getCurrentSession().createQuery("from Quiz where id = :id");
        query.setParameter("id", id);
        quiz = (List<Quiz>) query.list();
        return quiz.get(0);
    }

    @Override
    public List<Quiz> getByUser(User user) {
        List<Quiz> quiz;
        Query query = sessionFactory.getCurrentSession().createQuery("from Quiz where user_id = :user_id ");
        query.setParameter("user_id", user.getId());
        quiz = (List<Quiz>) query.list();
        return quiz;
    }

    @Override
    public List<Quiz> getEnabledAvailableForUserByTopic(User user, Topic topic) {
        List<Quiz> quiz;
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Quiz where id not in " +
                "(select quiz_id from PassedQuiz where user_id = :user_id_val)" +
                " and topic_id= :topic_id_val and enable = true");
        query.setParameter("topic_id_val", topic.getId());
        query.setParameter("user_id_val", user.getId());
        quiz = (List<Quiz>) query.list();
        return quiz;
    }

    @Override
    public List<Quiz> getAll() {
        String queryString = "from Quiz";
        Query query = sessionFactory.getCurrentSession().createQuery(queryString);
        return query.getResultList();
    }

    @Override
    public void removePassedQuizzes(Quiz quiz, User user) {
    }
}
