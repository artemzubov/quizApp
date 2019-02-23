package com.quizApp.service;

import com.quizApp.model.Topic;
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
public class TopicServiceImplTest {

    private TopicService topicService;

    @Autowired
    public TopicServiceImplTest(TopicService topicService){
        this.topicService = topicService;
    }

    @Test
    public void testSave() {

        Topic topic = new Topic();
        topic.setName("Mana");
        Topic topicDB = topicService.save(topic);
        Assertions.assertEquals(topic, topicDB, "IDs mismatch");
    }

    @Test
    public void testSaveFailed() {

        Topic topic = new Topic();
        Assertions.assertThrows(Exception.class,() -> topicService.save(topic));
    }

    @Test
    public void testSaveAll(){

        Topic topic1 = new Topic();
        Topic topic2 = new Topic();
        topic1.setName("First");
        topic2.setName("Second");

        List<Topic> topics = new ArrayList<Topic>(){{
            add(topic1);
            add(topic2);
        }};

        List<Topic> topicsDB = topicService.saveAll(topics);

        topic1.setId(37);
        topic2.setId(38);

        Topic[] arrayTopicsFake = topics.toArray(new Topic[topics.size()]);
        Topic[] arrayTopicsFromDB = topicsDB.toArray(new Topic[topicsDB.size()]);

        Assertions.assertArrayEquals(arrayTopicsFake, arrayTopicsFromDB,"List<Topic> from DB and hardcoded List<Topic> differ");

    }

    @Test
    public void testRemove() {

        Topic topic = new Topic();
        topic.setId(7);
        topicService.remove(topic);
    }

    @Test
    public void testGetAll(){

        Topic topic6 = new Topic();
        Topic topic7 = new Topic();
        Topic topic8 = new Topic();

        topic6.setId(6);
        topic7.setId(7);
        topic8.setId(8);

        List<Topic> topicsFake = new ArrayList<Topic>(){{
            add(topic6);
            add(topic7);
            add(topic8);
        }};

        List<Topic> topicsDB = topicService.getAll();

        Topic[] arrayTopicsFake = topicsFake.toArray(new Topic[topicsFake.size()]);
        Topic[] arrayTopicsFromDB = topicsDB.toArray(new Topic[topicsDB.size()]);

        Assertions.assertArrayEquals( arrayTopicsFake, arrayTopicsFromDB, "List<Topic> from DB and hardcoded List<Topic> differ");

    }

    @Test
    public void testGetById() {

        Topic topicFake = new Topic();
        topicFake.setId(7);

        Topic topicDB = topicService.getById(7);
        Assertions.assertEquals(topicFake, topicDB, "Topic from DB and hardcoded topic differ");

    }

}
