package com.quizApp.service;

import com.quizApp.model.Answer;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;


@ContextConfiguration({
        "classpath:spring/springDAO.xml",
        "classpath:spring/springServices.xml"
})
@ExtendWith(SpringExtension.class)
@Sql(scripts = "classpath:db/createAndFillHSQL.sql", config = @SqlConfig(encoding = "UTF-8"))
public class AnswerServiceImplTest {

    private AnswerService answerService;

    @Autowired
    public  AnswerServiceImplTest(AnswerService answerService){
        this.answerService = answerService;
    }

    @Test
    public void testSave() {

        Answer answer = new Answer();
        answer.setVariant("Вариант");
        answer.setCorrect(true);
        answer.setQuestion_id(12);
        Answer savedAnswer = answerService.save(answer);
        answer.setId(37);
        Assertions.assertEquals(answer, savedAnswer,"Answers mismatch");
    }

    @Test
    public void testSaveFailed() {

        //Question fields are NOT filled
        Answer answer = new Answer();
        Assertions.assertThrows(Exception.class,() -> answerService.save(answer));
    }

    @Test
    public void testRemove() {

        Answer answer = new Answer();
        answer.setVariant("Вариант");
        answer.setId(16);
        answerService.remove(answer);

    }

    @Test
    public void testGetById() {

        Answer answerFake = new Answer();
        answerFake.setId(24);

        Answer answerDB = answerService.getById(24);
        Assertions.assertEquals( answerFake.getId(), answerDB.getId(),"Answer from DB and hardcoded answer differ");

    }

}