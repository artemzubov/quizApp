package com.quizApp.controller;


import com.quizApp.model.Topic;
import com.quizApp.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;

@Controller
@RequestMapping("/admin")
public class TopicController {

    private TopicService topicService;

    @Autowired
    public TopicController(TopicService topicService) {
        this.topicService = topicService;
    }


    @PostMapping("/edit-topic")
    public void editTopic(@RequestBody Topic[] topics){
        topicService.saveAll(Arrays.asList(topics));
    }

    @PostMapping("/delete-topic")
    public void deleteTopic (@RequestBody Integer topicId){

        if (topicId != -1){
            topicService.remove(topicService.getById(topicId));
        }
    }

}
