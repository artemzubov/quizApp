package com.quizApp.service;

import com.quizApp.dao.AnswerDAO;
import com.quizApp.dao.QuestionDAO;
import com.quizApp.dao.QuizDAO;
import com.quizApp.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
public class QuizServiceImpl implements QuizService {

    private QuizDAO quizDAO;
    private QuestionDAO questionDAO;
    private AnswerDAO answerDAO;

    @Autowired
    public QuizServiceImpl(QuizDAO quizDAO, QuestionDAO questionDAO, AnswerDAO answerDAO) {
        this.quizDAO = quizDAO;
        this.questionDAO = questionDAO;
        this.answerDAO = answerDAO;
    }

    @Override
    public void saveOrUpdate(Quiz quiz) {

        if (quiz.getTopic().equals("-1")) {
            quiz.setTopic(null);
        }

        if (quiz.getId() == -1){
            quiz.setId(null);
        }

        Quiz savedQuiz = quizDAO.save(quiz);

       Set<Question> questions = savedQuiz.getQuestions();

        questions.forEach(question -> {

            if (question.getId() == -1){
                question.setId(null);
            }
            question.setQuiz_id(savedQuiz.getId());
            question.setQuiz_id(quiz.getId());
            Question savedQuestion = questionDAO.save(question);

           List<Answer> answers = savedQuestion.getAnswers();
            answers.forEach(answer -> {
                if (answer.getId() == -1){
                    answer.setId(null);
               }
               answer.setQuestion_id(question.getId());
               answerDAO.save(answer);
           });
        });

    }

    @Override
    public void remove(Quiz quiz) {
        quizDAO.remove(quiz);
    }

    @Override
    public Quiz getById(Integer id) {
        return quizDAO.getById(id);
    }

    @Override
    public List<Quiz> getByUser(User user) {
        List<Quiz> quizzes = quizDAO.getByUser(user);
        return quizzes;
    }

    @Override
    public List<Quiz> getEnabledAvailableForUserByTopic(User user, Topic topic) {
        List<Quiz> quizzes = quizDAO.getEnabledAvailableForUserByTopic(user, topic);
        return quizzes;
    }

    @Override
    public List<Quiz> getAll() {
        List<Quiz> quizzes = quizDAO.getAll();
        return quizzes;
    }

    @Override
    public List<Question> getQuestions(Quiz quiz) {
        List<Question> questions = questionDAO.getByQuiz(quiz);
        return questions;
    }

    @Override
    public void removePassedQuizzes(Quiz quiz, User user) {
        quizDAO.removePassedQuizzes(quiz, user);
    }
}
