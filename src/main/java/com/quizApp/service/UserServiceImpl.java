package com.quizApp.service;

import com.quizApp.dao.UserDAO;
import com.quizApp.model.Role;
import com.quizApp.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private UserDAO userDAO;

    @Autowired
    public UserServiceImpl(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    public User getByMail(String mail) {
        if (mail != null){
            return userDAO.getByMail(mail);
        }else{
            throw new RuntimeException();
        }
    }

    @Override
    public User save(User user){
        return userDAO.save(user);
    }

    @Override
    public void remove(User user) {
        userDAO.remove(user);
    }

    @Override
    public List<User> getTeacherRequests(){
       return userDAO.getByRole(Role.ROLE_REQUEST);
    }

    @Override
    public void setRole(User user, Role role){

        if(user != null && role != null) {
            userDAO.setRole(user, role);
        }else{
            throw new RuntimeException();
        }
    }

    @Override
    public List<User> getAll() {
        return userDAO.getAll();
    }

    @Override
    public void setMail(User user, String mail){

        if(user != null && mail != null) {
            userDAO.setMail(user,mail);
        }else{
            throw new RuntimeException();
        }
    }

    @Override
    public User getById(Integer id) {
        return userDAO.getById(id);
    }

    @Override
    public void setName(User user, String name){
        if(user != null && name != null) {
            userDAO.setName(user, name);
        }else{
            throw new RuntimeException();
        }
    }

    @Override
    public void setEnabled(User user, Boolean isEnabled){
        if(user != null && isEnabled != null) {
            userDAO.setEnabled(user, isEnabled);
        }else{
            throw new RuntimeException();
        }
    }

    @Override
    public void setPassword(User user, String password){
        if(user != null && password != null) {
            userDAO.setPassword(user, password);
        }else{
            throw new RuntimeException();
        }
    }
}
