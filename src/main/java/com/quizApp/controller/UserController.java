package com.quizApp.controller;

import com.quizApp.model.*;
import com.quizApp.service.QuizService;
import com.quizApp.service.ResultService;
import com.quizApp.service.TopicService;
import com.quizApp.service.UserService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class UserController {
    @Autowired
    private PasswordEncoder passwordEncoder;

    static final Logger log = LogManager.getLogger(UserController.class.getName());

    private QuizService quizService;
    private ResultService resultService;
    private UserService userService;
    private TopicService topicService;

    @Autowired
    public UserController(QuizService quizService, ResultService resultService, UserService userService, TopicService topicService) {
        this.quizService = quizService;
        this.resultService = resultService;
        this.userService = userService;
        this.topicService = topicService;
    }

    @GetMapping("/admin")
    public String getAdminPage(Model model) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getByMail(userName);
        List<User> allUsers = userService.getAll();
        List<Topic> topics = topicService.getAll();
        List<User> users = userService.getTeacherRequests();

        model.addAttribute("allUsers", allUsers);
        model.addAttribute("userList", users);
        model.addAttribute("username", user);
        model.addAttribute("topics", topics);

        return "admin";
    }

    @GetMapping("/student")
    public String getStudentPage(Model model) {

        List<String> randomColors = new ArrayList<>();
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getByMail(userName);
        List<Result> resultListStudent = resultService.getByUser(user);

        List<Topic> topics = topicService.getAll();

        for (int i = 0; i < topics.size(); i++) {
            int r = (int) (Math.random() * 195);
            int g = (int) (Math.random() * 195);
            int b = (int) (Math.random() * 195);
            randomColors.add("rgb(" + r + "," + g + "," + b + ")");
        }

        model.addAttribute("username", user);
        model.addAttribute("colors", randomColors);
        model.addAttribute("resultList", resultListStudent);

        model.addAttribute("topics", topics);
        log.info("hello, student");
        return "student";

    }

    @GetMapping("/teacher")
    public String getTeacherPage(Model model) {

        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getByMail(userName);

        List<Quiz> quizList = quizService.getByUser(user);

        List<Result> resultList = resultService.getByTeacher(user);

        log.info("hello, teacher");

        model.addAttribute("quizList", quizList);
        model.addAttribute("username", user);
        model.addAttribute("resultList", resultList);
        return "teacher";
    }

    @PostMapping("/admin/reject-request")
    public void rejectRequest(@RequestBody Integer id) {
        userService.setRole(userService.getById(id), Role.ROLE_REJECTED);
    }

    @PostMapping("/admin/approve-request")
    public void approveRequest(@RequestBody Integer id) {
        userService.setRole(userService.getById(id), Role.ROLE_TEACHER);
    }

    @GetMapping("/admin/edit-user/{id}")
    public String editUser(@PathVariable Integer id, Model model) {
        User user = userService.getById(id);
        model.addAttribute("user", user);
        return "edit-user";
    }

    @PostMapping("/admin/save-user")
    public void saveUser(@RequestBody User user) {
        User changedUser = userService.getById(user.getId());
        userService.setRole(changedUser, user.getRole());
        userService.setEnabled(changedUser, user.getEnabled());

    }

    @PostMapping("/admin/delete-user")
    public void deleteUser(@RequestBody User user) {
        userService.remove(user);
    }

    @GetMapping("/settings")
    public String getSettings(Model model) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getByMail(userName);
        model.addAttribute("user", user);
        return "settings";
    }

    @PostMapping("/update-user")
    public void updateUser(@RequestBody User user) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User changedUser = userService.getByMail(userName);
        userService.setName(changedUser, user.getName());
        userService.setMail(changedUser, user.getEmail());

    }

    @PostMapping("/update-user-password")
    public void updateUserPassword(@RequestBody User user) {
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User changedUser = userService.getByMail(userName);
        String hashPassword = passwordEncoder.encode(user.getPassword());
        userService.setPassword(changedUser, hashPassword);
    }

}
