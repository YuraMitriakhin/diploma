package com.gmail.yuramitryahin.services;

import com.gmail.yuramitryahin.dto.CourseDTO;
import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Files;
import com.gmail.yuramitryahin.entity.user.Tegs;
import com.gmail.yuramitryahin.repository.CourseRepository;
import com.gmail.yuramitryahin.repository.FileRepository;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
public class CourseService {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private TopicsService topicsService;

    @Autowired
    private TegsService tegsService;

    public List<Course> getAllCourse(){
        return courseRepository.findAll();
    }

    public Course getCourseById(long id){
        return courseRepository.getCourseByCourseId(id);
    }

    @Transactional
    public void saveCourse(CourseDTO courseDTO){
        Course course = Course.builder()
                .name(courseDTO.getName())
                .description(courseDTO.getDescription())
                .type(courseDTO.isType())
                .difficulty(courseDTO.getDifficulty())
                .topic(topicsService.getTopicById(courseDTO.getTopicId()))
                .build();
        if(courseDTO.getCourseId()!=0){
            course.setCourseId(courseDTO.getCourseId());
        }
        course.setTegs(tegsService.saveTeg(courseDTO.getTegs(),course));
        courseRepository.save(course);
    }

    public String convertToJson(List<Course> list) throws JSONException {
        JSONArray jsonArray=new JSONArray();
        JSONArray tegsArray=new JSONArray();

        for(Course c: list){
            JSONObject json = new JSONObject();
            tegsArray=new JSONArray();
            json.put("courseId", c.getCourseId());
            json.put("name", c.getName());
            json.put("description", c.getDescription());
            json.put("type", c.isType());
            json.put("difficulty", c.getDifficulty());
            json.put("topic", c.getTopic().getTopicId());

            for (Tegs t: c.getTegs()){
                tegsArray.put(t.getTegId());
            }
            json.put("tegs", tegsArray.toString());
            jsonArray.put(json);
        }
        return jsonArray.toString();
    }

    @Transactional
    public void deleteCourse(long id) {

        Course course = getCourseById(id);
        System.out.println("Deleeeeete-"+course.getName());
        tegsService.delteTegs(courseRepository.getCourseByCourseId(id));
        courseRepository.delete(course);
    }

}
