package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.entity.user.Topics;
import com.gmail.yuramitryahin.repository.FileRepository;
import com.gmail.yuramitryahin.repository.TopicsRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class TopicsService {

    @Autowired
    private TopicsRepository topicsRepository;

    public List<Topics> getAllTopics(){
        return topicsRepository.findAll();
    }

    public Topics getTopicById(long id){
        return topicsRepository.getTopicsByTopicId(id);
    }

    public void save(String name){
        topicsRepository.save(Topics.builder().name(name).build());
    }

    public void  deleteTopic(long id) throws Exception{
        topicsRepository.delete(getTopicById(id));
    }
}
