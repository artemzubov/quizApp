package com.quizApp.controller;

import com.quizApp.dto.PassedQuiz;
import com.quizApp.model.*;
import com.quizApp.service.*;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Set;

@Controller
public class QuizController {

    static final Logger log = LogManager.getLogger(QuizController.class.getName());

    private QuizService quizService;
    private TopicService topicService;
    private UserService userService;
    private QuestionService questionService;
    private AnswerService answerService;

    @Autowired
    public QuizController(QuizService quizService, TopicService topicService, UserService userService, QuestionService questionService, AnswerService answerService, ResultService resultService) {
        this.quizService = quizService;
        this.topicService = topicService;
        this.userService = userService;
        this.questionService = questionService;
        this.answerService = answerService;
    }

    @GetMapping("/teacher/single-quiz/{id}")
    public String getOrEditQuiz(Model model, @PathVariable Integer id) {

        Quiz quiz = quizService.getById(id);
        List<Topic> topics = topicService.getAll();

        Set<Question> questions = quiz.getQuestions();


        model.addAttribute("quizTopic", quiz.getTopic());
        model.addAttribute("quizEnabled", quiz.getEnabled());
        model.addAttribute("quizTitle", quiz.getTitle());
        model.addAttribute("quizId", quiz.getId());
        model.addAttribute("questions", questions);
        model.addAttribute("topics", topics);
        log.info("we're editing or adding some quizzes");

        return "single-quiz";

    }

    @GetMapping("/student/solve-quiz/{id}")
    public String solveQuiz(Model model, @PathVariable Integer id) {

        Quiz quiz = quizService.getById(id);
        Set<Question> questionList = quiz.getQuestions();

        model.addAttribute("quizId", quiz.getId());
        model.addAttribute("quizName", quiz.getTitle());
        model.addAttribute("questions", questionList);
        model.addAttribute("quizNumberOfAnswers", quiz.getQuestions().size());

        return "single-quiz-student";
    }

    @PostMapping("/teacher/edit-quiz")
    public void editQuiz(@RequestBody Quiz quiz) {
        log.info("we saved quiz");

        Object authName = SecurityContextHolder.getContext().getAuthentication().getName();
        User currentUser = userService.getByMail(authName.toString());
        Topic topic = topicService.getById(quiz.getTopic().getId());

        quiz.setTopic(topic);
        quiz.setAuthor(currentUser);

        quizService.saveOrUpdate(quiz);
    }

    @GetMapping("/teacher/add-quiz")
    public String addingQuiz(Model model) {

        List<Topic> topics = topicService.getAll();
        model.addAttribute("topics", topics);

        log.info("we're adding a quiz");

        return "single-quiz";
    }

    @PostMapping("/teacher/delete-answer")
    public void deleteAnswer(@RequestBody Integer id) {
        Answer answer = new Answer();
        answer.setId(id);
        answerService.remove(answer);
    }

    @PostMapping("/teacher/delete-question")
    public void deleteQuestion(@RequestBody Integer id) {
        Question question = new Question();
        question.setId(id);
        questionService.remove(question);
    }

    @GetMapping("/student/by-topic/{topic_id}")
    public String searchByTopic(@PathVariable Integer topic_id, Model model) {

        Topic topic = topicService.getById(topic_id);
        String userName = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getByMail(userName);
        List<Quiz> quizzes = quizService.getEnabledAvailableForUserByTopic(user, topic);

        List<Quiz> quizListStudent = quizService.getAll();
        model.addAttribute("topic", topic.getName());
        model.addAttribute("username", user);
        model.addAttribute("quizListStudent", quizListStudent);
        model.addAttribute("quizzes", quizzes);
        return "by-topic";
    }

    @PostMapping("teacher/remove-passedQuizzes")
    public void removePassedQuizzes(@RequestBody PassedQuiz passedQuiz) {
        User user = userService.getById(passedQuiz.getUser_id());
        Quiz quiz = quizService.getById(passedQuiz.getQuiz_id());
        quizService.removePassedQuizzes(quiz, user);
    }

}
