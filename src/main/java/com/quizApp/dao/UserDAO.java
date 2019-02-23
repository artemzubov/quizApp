package com.quizApp.dao;

import com.quizApp.model.Quiz;
import com.quizApp.model.Role;
import com.quizApp.model.User;

import java.util.List;

public interface UserDAO {

    User save(User user);

    void remove(User user);

    User getById(Integer id);

    List<User> getByName(String name);

    User getByMail(String email);

    List<User> getByRole(Role role);

    List<User> getAll();

    void setRole(User user, Role role);

    void setMail(User user, String mail);

    void setName(User user, String name);

    void setEnabled(User user, Boolean isEnabled);

    void setPassword(User user, String mail);

    void addPassedQuiz(User user, Quiz quiz);

    void removeQuiz(User user, Quiz quiz);

}
