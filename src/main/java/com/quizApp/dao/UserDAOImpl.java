package com.quizApp.dao;

import com.quizApp.model.Quiz;
import com.quizApp.model.Role;
import com.quizApp.model.User;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    SessionFactory sessionFactory;

    public UserDAOImpl() {
    }

    @Override
    public User save(User user) {
        return getById((Integer) sessionFactory.getCurrentSession().save(user));
    }

    @Override
    public void remove(User user) {
        sessionFactory.getCurrentSession().delete(user);
    }

    @Override
    public User getById(Integer id) {

        List<User> users;
        Query query = sessionFactory.getCurrentSession().createQuery("from User where id = :id ");
        query.setParameter("id", id);
        users = (List<User>)query.list();
        return users.get(0);
    }

    @Override
    public List<User> getByName(String name) {
        List<User> users;
        Query query = sessionFactory.getCurrentSession().createQuery("from User where name = :name ");
        query.setParameter("name", name);
        users = (List<User>)query.list();
        return users;
    }

    @Override
    public User getByMail(String email) {
        List<User> user;
        Query query = sessionFactory.getCurrentSession().createQuery("from User where email = :email ");
        query.setParameter("email", email);
        try {
            user = (List<User>)query.list();
            return user.get(0);
        }
        catch (Exception e){
            return null;
        }
    }

    @Override
    public List<User> getByRole(Role role) {

        List<User> users;
        Query query = sessionFactory.getCurrentSession().createQuery("from User where role = :role ");
        query.setParameter("role", role);
        users = (List<User>)query.list();
        return users;
    }

    @Override
    public List<User> getAll() {
        String queryString = "from User";
        Query query = sessionFactory.getCurrentSession().createQuery(queryString);
        return query.getResultList();
    }

    @Override
    public void setRole(User user, Role role) {
        user.setRole(role);
        sessionFactory.getCurrentSession().saveOrUpdate(user);
    }

    @Override
    public void setMail(User user, String mail) {
        user.setEmail(mail);
        sessionFactory.getCurrentSession().saveOrUpdate(user);
    }

    @Override
    public void setName(User user, String name) {
        user.setName(name);
        sessionFactory.getCurrentSession().saveOrUpdate(user);
    }

    @Override
    public void setEnabled(User user, Boolean isEnabled) {
        user.setEnabled(isEnabled);
        sessionFactory.getCurrentSession().saveOrUpdate(user);
    }

    @Override
    public void setPassword(User user, String password) {
        user.setPassword(password);
        sessionFactory.getCurrentSession().saveOrUpdate(user);
    }

    @Override
    public void addPassedQuiz(User user, Quiz quiz) {

    }

    @Override
    public void removeQuiz(User user, Quiz quiz) {
    }
}
