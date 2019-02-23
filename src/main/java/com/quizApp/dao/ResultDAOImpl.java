package com.quizApp.dao;

import com.quizApp.dto.PassedQuiz;
import com.quizApp.model.Quiz;
import com.quizApp.model.Result;
import com.quizApp.model.User;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ResultDAOImpl implements ResultDAO {

    @Autowired
    SessionFactory sessionFactory;

    public ResultDAOImpl() {

    }

    @Override
    public Result save(Result result) {
        PassedQuiz passedQuiz = new PassedQuiz();
        passedQuiz.setQuiz_id(result.getQuiz().getId());
        passedQuiz.setUser_id(result.getUser().getId());
        System.out.println("DDDDDDDDDDDDDDD"+result);
        System.out.println("sadklnkjdsajksadas;ads;"+passedQuiz);
        sessionFactory.getCurrentSession().save(passedQuiz);

        return getById((Integer) sessionFactory.getCurrentSession().save(result));
    }

    @Override
    public void remove(Result result) {
        sessionFactory.getCurrentSession().delete(result);
    }

    @Override
    public Result getById(Integer resultId) {
        List<Result> result;
        Query query = sessionFactory.getCurrentSession().createQuery("from Result where id = :id ");
        query.setParameter("id", resultId);
        result = (List<Result>) query.list();
        return result.get(0);
    }

    @Override
    public List<Result> getByUser(User user) {
        List<Result> results;
        Query query = sessionFactory.getCurrentSession().createQuery("from Result where user_id = :user_id ");
        query.setParameter("user_id", user.getId());
        results = (List<Result>) query.list();
        return results;

    }

    @Override
    public List<Result> getByQuiz(Quiz quiz) {
        List<Result> results;
        Query query = sessionFactory.getCurrentSession().createQuery("from Result where quiz_id = :quiz_id_val ");
        query.setParameter("quiz_id_val", quiz.getId());
        results = (List<Result>) query.list();
        return results;
    }

    @Override
    public List<Result> getByTeacher(User user) {
        List<Result> results;
        Query query = sessionFactory.getCurrentSession()
                .createQuery("from Result where quiz_id in( select id from Quiz where user_id = :user_id_val)");
        query.setParameter("user_id_val", user.getId());
        results = (List<Result>) query.list();
        return results;
    }
}
