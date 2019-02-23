package com.quizApp.service;

import com.quizApp.model.Question;
import com.quizApp.model.Quiz;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


@ContextConfiguration({
        "classpath:spring/springDAO.xml",
        "classpath:spring/springServices.xml"
})
@ExtendWith(SpringExtension.class)
@Sql(scripts = "classpath:db/createAndFillHSQL.sql", config = @SqlConfig(encoding = "UTF-8"))
public class QuestionServiceImplTest {

    private QuestionService questionService;

    @Autowired
    public QuestionServiceImplTest(QuestionService questionService){
        this.questionService = questionService;
    }

    @Test
    public void testSave() {

        Question question = new Question();
        question.setQuestionText("Some text");
        question.setQuiz_id(9);
        Question questionDB = questionService.save(question);
        Assertions.assertEquals(question, questionDB,"Questions mismatch");
    }

    @Test
    public void testSaveFailed() {

        //Question fields are NOT filled
        Question question = new Question();
        Assertions.assertThrows(Exception.class,() -> questionService.save(question));
    }

    @Test
    public void testRemove() {

        Question question = new Question();
        question.setId(12);
        questionService.remove(question);
    }

    @Test
    public void testGetById() {
        Question questionFake = new Question();
        questionFake.setId(13);
        Question questionDB = questionService.getById(13);
        Assertions.assertEquals(questionFake.getId(), questionDB.getId(),"Question from DB and hardcoded question differ");

    }

    @Test
    public void testGetByQuiz() {

        Quiz quiz = new Quiz();
        quiz.setId(10);

        List<Question> questionsFake = new ArrayList<Question>(){{
            add(new Question(14, Collections.emptyList(), "Some text", Collections.emptyList()));
            add(new Question(15, Collections.emptyList(), "Some text", Collections.emptyList()));

        }};

        List<Question> questionsDB = questionService.getByQuiz(quiz);

        Question[] arrayQuestionsFake = questionsFake.toArray(new Question[questionsFake.size()]);
        Question[] arrayQuestionsDB = questionsDB.toArray(new Question[questionsDB.size()]);

        Assertions.assertArrayEquals(arrayQuestionsFake, arrayQuestionsDB,"List<Question> from DB and hardcoded List<Question> differ");

    }
}