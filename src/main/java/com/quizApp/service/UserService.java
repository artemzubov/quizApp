package com.quizApp.service;

import com.quizApp.model.Role;
import com.quizApp.model.User;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
public interface UserService {

   User getByMail(String mail);

   User save(User user);

   void remove(User user);

   List<User> getTeacherRequests();

   void setRole(User user, Role role);

   List<User> getAll();

   void setMail(User user, String mail);

   User getById(Integer id);

   void setName(User user, String name);

   void setEnabled(User user, Boolean isEnabled);

   void setPassword(User user, String mail);

}
