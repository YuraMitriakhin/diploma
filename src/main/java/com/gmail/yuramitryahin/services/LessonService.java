package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.dto.LessonDTO;
import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.repository.CourseRepository;
import com.gmail.yuramitryahin.repository.LessonRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Service
public class LessonService {



    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private FileService fileService;

    @Autowired
    private LinksService linksService;

    @Autowired
    private CourseService courseService;

    @Transactional
    public void saveLesson (LessonDTO topicDTO, MultipartFile[]files) throws IOException {
        Lesson lesson = Lesson
                .builder()
                .name(topicDTO.getName())
                .courseId(courseService.getCourseById(topicDTO.getCourseId()))
                .number(topicDTO.getNumber())
                .description(topicDTO.getDescription())
                .text(topicDTO.getText())
                .build();

        if(topicDTO.getLessonId()!=0){
           lesson.setId(topicDTO.getLessonId());
        }else {
            linksService.saveLinks(topicDTO.getLinks(),lesson);
            fileService.saveFiles(files,topicDTO.getDescriptionToFiles(),lesson);
        }
        lessonRepository.save(lesson);

    }

    public List<Lesson> getAllLessons(){
        return lessonRepository.findAll();
    }

    @Transactional
    public void delete(Lesson lesson) throws Exception  {
       // Lesson lesson = topicRepository.findByLessonId(id);
      //  System.out.println(lesson);
            linksService.deleteByLessonId(lesson);
            fileService.deleteByLessonId(lesson);
        lessonRepository.delete(lesson);

    }

    public Lesson findById(long id){
        Lesson lesson = lessonRepository.findById(id);
        List<Files> imgs = new ArrayList<>();

        System.out.println(Arrays.toString(lesson.getFiles().toArray()));


        if(lesson.getFiles() != null) {
            for (int i = 0; i < lesson.getFiles().size(); i++) {
                boolean f = false;
                for(Files fl: imgs){
                    System.out.println(fl.getId()+"=="+lesson.getFiles().get(i).getId());
                    if(fl.getId()== lesson.getFiles().get(i).getId()){
                        f=true;
                    }
                }
                if(!f){
                    imgs.add(lesson.getFiles().get(i));
                }
            }
        }

        lesson.setFiles(imgs);
        return lesson;
    }

    public List<Lesson> findByCourseId(Course course){
        return lessonRepository.findAllByCourseId(course);
    }

    public void save(Lesson lesson){
        lessonRepository.save(lesson);
    }




}
