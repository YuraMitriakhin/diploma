package com.gmail.yuramitryahin.controllers;

import com.gmail.yuramitryahin.DataSaveDBException;
import com.gmail.yuramitryahin.dto.LessonDTO;
import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Lesson;
import com.gmail.yuramitryahin.services.*;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;

@Controller
public class LessonController {

    @Autowired
    private LessonService lessonService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private TestsService testsService;

    @Autowired
    private QuestionService questionService;



    @GetMapping(value = "/lessons/add")
    @ResponseBody
    public ModelAndView deleteCourse(@RequestParam("id") long id, Model model) throws DataSaveDBException {
        Course course =  courseService.getCourseById(id);
        model.addAttribute("Course", course);
        model.addAttribute("Lessons", lessonService.findByCourseId(course));
        return new ModelAndView("addNewLesson");
    }

    @SneakyThrows
    @RequestMapping(value = "/lessons/save", method = RequestMethod.POST)
    public String saveTopic(@RequestParam("files") MultipartFile[] files, LessonDTO topicDTO) {
        System.out.println(topicDTO.getCourseId()+" - course id");
        lessonService.saveLesson(topicDTO, files);
        return "redirect:/";
    }

    @GetMapping(value = "/lessons/delete")
    @ResponseBody
    public int deleteLesson(@RequestParam("id") long id) {
        Lesson lesson = lessonService.findById(id);
        try{
            lessonService.delete(lesson);
            return 200;
        }catch (Exception e){
            return 300;
        }
    }

    @GetMapping(value = "/lessons/edit")
    @ResponseBody
    public ModelAndView editLesson(@RequestParam("id") long id, Model model) {
        Lesson lesson = lessonService.findById(id);
        model.addAttribute("lesson", lesson);
        model.addAttribute("Lessons", lessonService.getAllLessons());
        model.addAttribute("Courses", courseService.getAllCourse());
        return new ModelAndView("editLesson");
    }

    @GetMapping(value = "/lesson")
    @ResponseBody
    public ModelAndView lessonPage (@RequestParam("id") long id, Model model) {
        Lesson lesson = lessonService.findById(id);

        model.addAttribute("lesson", lesson);
        model.addAttribute("questions", questionService.findQuestionByTest(lesson.getTest()));
        model.addAttribute("questionsSize", questionService.findQuestionByTest(lesson.getTest()).size());
        return new ModelAndView("lessonPage");
    }

}
