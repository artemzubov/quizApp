package com.quizApp.service;

import com.quizApp.model.Quiz;
import com.quizApp.model.Result;
import com.quizApp.model.User;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@ContextConfiguration({
        "classpath:spring/springDAO.xml",
        "classpath:spring/springServices.xml"
})
@ExtendWith(SpringExtension.class)
@Sql(scripts = "classpath:db/createAndFillHSQL.sql", config = @SqlConfig(encoding = "UTF-8"))
public class ResultServiceImplTest {

    @Autowired
    private ResultService resultService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private UserService userService;

    @Test
    public void testSave() {

        Result result = new Result();
        result.setCorrectAnswers(4);
        result.setDate(LocalDate.of(2010, 10, 1));
        User user = new User();
        user.setId(3);
        result.setUser(user);
        Quiz quiz = new Quiz();
        quiz.setId(10);
        result.setQuiz(quiz);
        Result success = resultService.save(result);
        System.out.println(success);
        Assertions.assertEquals(success, result,"Save has returned false instead of true");
    }

    @Test
    public void testSaveFailed() {

        Result result = new Result();
        Assertions.assertThrows(Exception.class,() -> resultService.save(result));
    }

    @Test
    public void testRemove() {

        Result result = new Result();
        result.setId(35);
        resultService.remove(result);
    }

    @Test
    public void testGetById() {

        Result resultFake = new Result();
        resultFake.setCorrectAnswers(0);
        resultFake.setDate(LocalDate.of(2018, 6, 6));
        resultFake.setUser(userService.getById(3));
        resultFake.setQuiz(quizService.getById(10));
        resultFake.setId(34);
        Result resultDB = resultService.getById(34);
        Assertions.assertEquals(resultFake, resultDB, "Result from DB and hardcoded result differ");

    }

    @Test
    public void testGetByUser() {

        Result result1 = new Result();
        result1.setCorrectAnswers(0);
        result1.setDate(LocalDate.of(2018, 6, 6));
        result1.setUser(userService.getById(3));
        result1.setQuiz(quizService.getById(10));
        result1.setId(34);

        Result result2 = new Result();
        result2.setCorrectAnswers(1);
        result2.setDate(LocalDate.of(2018, 7, 6));
        result2.setUser(userService.getById(3));
        result2.setQuiz(quizService.getById(10));
        result2.setId(35);

        List<Result> resultsFake = new ArrayList<Result>(){{
            add(result1);
            add(result2);
        }};

        List<Result> resultsDB = resultService.getByUser(userService.getById(3));

        Result[] arrayResultsFake = resultsFake.toArray(new Result[resultsFake.size()]);
        Result[] arrayResultsDB = resultsDB.toArray(new Result[resultsDB.size()]);

        Assertions.assertArrayEquals(arrayResultsDB, arrayResultsFake, "List<Result> from DB and hardcoded List<Result> differ");

    }

    @Test
    public void testGetByQuiz() {

        Result result1 = new Result();
        result1.setCorrectAnswers(0);
        result1.setDate(LocalDate.of(2018, 6, 6));
        result1.setUser(userService.getById(3));
        result1.setQuiz(quizService.getById(10));
        result1.setId(34);

        Result result2 = new Result();
        result2.setCorrectAnswers(1);
        result2.setDate(LocalDate.of(2018, 7, 6));
        result2.setUser(userService.getById(3));
        result2.setQuiz(quizService.getById(10));
        result2.setId(35);

        List<Result> resultsFake = new ArrayList<Result>(){{
            add(result1);
            add(result2);
        }};

        Quiz quiz1  = quizService.getById(10);
        Quiz quiz2 = new Quiz();
        quiz2.setId(quiz1.getId());
        quiz2.setAuthor(quiz1.getAuthor());
        quiz2.setTopic(quiz1.getTopic());
        quiz2.setEnabled(quiz1.getEnabled());
        quiz2.setQuestions(quiz1.getQuestions());
        quiz2.setTitle(quiz1.getTitle());

        List<Result> resultsDB = resultService.getByQuiz(quiz2);

        Result[] arrayResultsFake = resultsFake.toArray(new Result[resultsFake.size()]);
        Result[] arrayResultsDB = resultsDB.toArray(new Result[resultsDB.size()]);

        Assertions.assertArrayEquals(arrayResultsDB, arrayResultsFake, "List<Result> from DB and hardcoded List<Result> differ");

    }

    @Test
    public void testGetByTeacher() {

        Result result1 = new Result();
        result1.setCorrectAnswers(0);
        result1.setDate(LocalDate.of(2018, 6, 6));
        result1.setUser(userService.getById(3));
        result1.setQuiz(quizService.getById(10));
        result1.setId(34);

        Result result2 = new Result();
        result2.setCorrectAnswers(1);
        result2.setDate(LocalDate.of(2018, 7, 6));
        result2.setUser(userService.getById(3));
        result2.setQuiz(quizService.getById(10));
        result2.setId(35);

        List<Result> resultsFake = new ArrayList<Result>(){{
            add(result1);
            add(result2);
        }};

        List<Result> resultsDB = resultService.getByTeacher(quizService.getById(10).getAuthor());

        Result[] arrayResultsFake = resultsFake.toArray(new Result[resultsFake.size()]);
        Result[] arrayResultsDB = resultsDB.toArray(new Result[resultsDB.size()]);

        Assertions.assertArrayEquals(arrayResultsDB, arrayResultsFake, "List<Result> from DB and hardcoded List<Result> differ");

    }

}
