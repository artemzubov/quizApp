package com.quizApp.service;

import com.quizApp.model.Topic;
import com.quizApp.model.Quiz;
import com.quizApp.model.User;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.ArrayList;
import java.util.List;

@ContextConfiguration({
        "classpath:spring/springDAO.xml",
        "classpath:spring/springServices.xml"
})
@ExtendWith(SpringExtension.class)
@Sql(scripts = "classpath:db/createAndFillHSQL.sql", config = @SqlConfig(encoding = "UTF-8"))
public class QuizServiceImplTest {

    private QuizService quizService;

    @Autowired
    public QuizServiceImplTest(QuizService quizService){
        this.quizService = quizService;
    }

    @Test
    public void testSaveFailed() {

        Quiz quiz = quizService.getById(9);
        quiz.setId(-1);

        quizService.saveOrUpdate(quiz);
    }

    @Test
    public void testRemove() {

        Quiz quiz = new Quiz();
        quiz.setId(9);

        quizService.remove(quiz);
    }

    @Test
    public void testGetById() {

        Quiz quizFake = new Quiz();
        quizFake.setId(9);

        Quiz quizDB = quizService.getById(9);
        Assertions.assertEquals(quizFake, quizDB, "Quiz from DB and hardcoded quiz differ");

    }

    @Test
    public void testGetByUser() {

        User user = new User();
        user.setId(1);

        List<Quiz> quizDB = quizService.getByUser(user);

        List<Quiz> quizFake = new ArrayList<Quiz>() {{
            add(new Quiz(9, null, null, null, null, null));
            add(new Quiz(10, null, null, null, null, null));
            add(new Quiz(11, null, null, null, null, null));
        }};

        Quiz[] arrayQuizFake = quizFake.toArray(new Quiz[quizFake.size()]);
        Quiz[] arrayQuizDB = quizDB.toArray(new Quiz[quizDB.size()]);

        Assertions.assertArrayEquals(arrayQuizDB, arrayQuizFake, "List<Quiz> from DB and hardcoded List<Quiz> differ");

    }

    @Test                                   //with passed quizzes
    public void testGetEnabledAvailableForUserWithPassedQuizzesByTopic() {

        User user = new User();
        user.setId(3);

        Topic topic = new Topic();
        topic.setId(6);

        List<Quiz> quizDB = quizService.getEnabledAvailableForUserByTopic(user, topic);

        List<Quiz> quizFake = new ArrayList<Quiz>() {{
            add(new Quiz(9, null, null, null, null, null));
        }};

        Quiz[] arrayQuizFake = quizFake.toArray(new Quiz[quizFake.size()]);
        Quiz[] arrayQuizDB = quizDB.toArray(new Quiz[quizDB.size()]);

        Assertions.assertArrayEquals(arrayQuizFake, arrayQuizDB, "List<Quiz> from DB and hardcoded List<Quiz> differ");

    }

    @Test                                     //WITHOUT passed quizzes
    public void testGetEnabledAvailableForUserWithoutPassedQuizzesByTopic1() {

        User user = new User();
        user.setId(4);

        Topic topic = new Topic();
        topic.setId(6);

        List<Quiz> quizDB = quizService.getEnabledAvailableForUserByTopic(user, topic);

        List<Quiz> quizFake = new ArrayList<Quiz>() {{
            add(new Quiz(9, null, null, null, null, null));
            add(new Quiz(10, null, null, null, null, null));
        }};

        Quiz[] arrayQuizFake = quizFake.toArray(new Quiz[quizFake.size()]);
        Quiz[] arrayQuizDB = quizDB.toArray(new Quiz[quizDB.size()]);

        Assertions.assertArrayEquals(arrayQuizFake, arrayQuizDB, "List<Quiz> from DB and hardcoded List<Quiz> differ");

    }

    @Test                                     //WITHOUT passed quizzes
    public void testGetEnabledAvailableForUserWithoutPassedQuizzesByTopic2() {

        User user = new User();
        user.setId(4);

        Topic topic = new Topic();
        topic.setId(7);

        List<Quiz> quizDB = quizService.getEnabledAvailableForUserByTopic(user, topic);

        List<Quiz> quizFake = new ArrayList<Quiz>() {{
            add(new Quiz(11, null, null, null, null, null));
        }};

        Quiz[] arrayQuizFake = quizFake.toArray(new Quiz[quizFake.size()]);
        Quiz[] arrayQuizDB = quizDB.toArray(new Quiz[quizDB.size()]);

        Assertions.assertArrayEquals(arrayQuizFake, arrayQuizDB, "List<Quiz> from DB and hardcoded List<Quiz> differ");

    }

    @Test
    public void testGetAll() {
        List<Quiz> quizDB = quizService.getAll();

        List<Quiz> quizFake = new ArrayList<Quiz>() {{
            add(new Quiz(9, null, null, null, null, null));
            add(new Quiz(10, null, null, null, null, null));
            add(new Quiz(11, null, null, null, null, null));
        }};

        Quiz[] arrayQuizFake = quizFake.toArray(new Quiz[quizFake.size()]);
        Quiz[] arrayQuizDB = quizDB.toArray(new Quiz[quizDB.size()]);

        Assertions.assertArrayEquals(arrayQuizFake, arrayQuizDB, "List<Quiz> from DB and hardcoded List<Quiz> differ");
    }

    @Test
    public void testRemovePassedQuizzes() {

        Quiz quiz = new Quiz();
        quiz.setId(3);

        User user = new User();
        user.setId(10);

        quizService.removePassedQuizzes(quiz, user);
    }

}
