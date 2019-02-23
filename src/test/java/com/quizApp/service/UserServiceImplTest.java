package com.quizApp.service;

import com.quizApp.model.Role;
import com.quizApp.model.User;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;

@ContextConfiguration({
        "classpath:spring/springDAO.xml",
        "classpath:spring/springServices.xml"
})
@ExtendWith(SpringExtension.class)
@Sql(scripts = "classpath:db/createAndFillHSQL.sql", config = @SqlConfig(encoding = "UTF-8"))
public class UserServiceImplTest {

    private UserService userService;

    @Autowired
    public UserServiceImplTest(UserService userService){
        this.userService = userService;
    }

    private User user = new User();

    @Test
    public void testSave() {
        user.setName("Yoda");
        user.setEmail("yoda@wars.ru");
        user.setRole(Role.ROLE_TEACHER);
        user.setPassword("$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC");
        user.setEnabled(true);
        User userDB = userService.save(user);
        Assertions.assertEquals(user, userDB, "save test failed");
    }

    @Test
    public void testSaveFailed() {

        //User with mail yoda@starwars.ru is already exist in DB
        user.setName("Yoda");
        user.setEmail("yoda@starwars.ru");
        user.setRole(Role.ROLE_TEACHER);
        user.setPassword("$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC");
        user.setEnabled(true);
        user.setId(1);

        Assertions.assertThrows(Exception.class,() -> userService.save(user));
    }

    @Test
    public void testRemove() {
        user.setId(1);
        userService.remove(user);
    }

    @Test
    public void testGetById() {
        user.setName("Yoda");
        user.setEmail("yoda@starwars.ru");
        user.setRole(Role.ROLE_TEACHER);
        user.setPassword("$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC");
        user.setEnabled(true);
        user.setId(1);
        User userDB = userService.getById(1);
        Assertions.assertEquals(userDB, user, "User from DB and hardcoded user differ");

    }

    @Test
    public void testGetByMail() {
        user.setName("Yoda");
        user.setEmail("yoda@starwars.ru");
        user.setRole(Role.ROLE_TEACHER);
        user.setPassword("$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC");
        user.setEnabled(true);
        user.setId(1);

        User userDB = userService.getByMail("yoda@starwars.ru");

        Assertions.assertEquals(userDB, user, "User from DB and hardcoded user differ");

    }

    @Test
    public void testGetTeacherRequest(){
        User user = new User();
        User[] users = new User[1];
        User[] usersDBarray;

        user.setName("Dooku");
        user.setEmail("dooku@starwars.ru");
        user.setRole(Role.ROLE_REQUEST);
        user.setPassword("$2a$10$8f0R4OfmY43RbYc2W.Mz7.FfeIY4I9bappekGGXas4HTx5LazC3NC");
        user.setId(5);
        user.setEnabled(true);
        users[0] = user;
        List<User> usersDB = userService.getTeacherRequests();
        usersDBarray = usersDB.toArray(new User[usersDB.size()]);

        Assertions.assertArrayEquals(usersDBarray, users, "Array from DB of users who send request and hardcoded array are differ");
    }

}