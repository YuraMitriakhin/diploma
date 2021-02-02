package com.gmail.yuramitryahin.controllers;

import com.gmail.yuramitryahin.DataSaveDBException;
import com.gmail.yuramitryahin.dto.CourseDTO;
import com.gmail.yuramitryahin.dto.LessonDTO;
import com.gmail.yuramitryahin.entity.user.Course;
import com.gmail.yuramitryahin.entity.user.Difficulty;
import com.gmail.yuramitryahin.entity.user.Role;
import com.gmail.yuramitryahin.entity.user.User;
import com.gmail.yuramitryahin.services.*;
import lombok.SneakyThrows;
import org.apache.tomcat.util.codec.binary.Base64;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class CourseController {

    @Autowired
    public CourseService courseService;
    @Autowired
    public TopicsService topicsService;
    @Autowired
    public UserService userService;
    @Autowired
    public LessonService lessonService;
    @Autowired
    public TestsService testsService;

    @RequestMapping("/courses/add")
    public String addBottle(Model model) throws DataSaveDBException {
        model.addAttribute("easy", Difficulty.EASY);
        model.addAttribute("medium", Difficulty.MEDIUM);
        model.addAttribute("hard", Difficulty.HARD);
        model.addAttribute("Topics", topicsService.getAllTopics());
        return "addNewCourse";
    }

    @SneakyThrows
    @RequestMapping(value = "/courses/save", method = RequestMethod.POST)
    public String saveTopic(CourseDTO courseDTO) {
        System.out.println(courseDTO);
        courseService.saveCourse(courseDTO);
        return "redirect:/";
    }

    @ResponseBody
    @RequestMapping("/courses/get")
    public String getCourses() throws JSONException {
        return courseService.convertToJson(courseService.getAllCourse());
    }

    @GetMapping(value = "/course")
    @ResponseBody
    public ModelAndView getCourseById(@RequestParam("id") long id, Model model) throws IOException {
        System.out.println("iiii"+id);
        Course course = courseService.getCourseById(id);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userService.findByUsername(auth.getName());

        if(course.isType()==false || (user!=null && course.isType() && user.isPremium())){
            if(user!=null && user.getAuthorities().stream().findFirst().get()==Role.ADMIN) {
                model.addAttribute("role", true);
            }else{
                model.addAttribute("role", false);
            }

            model.addAttribute("user", user.getUsername());
            model.addAttribute("course", course);
            model.addAttribute("lessonsNum", course.getLessons().size());
            model.addAttribute("lessons", course.getLessons());
            return new ModelAndView("coursePage");
        }else{
            return new ModelAndView("noAccessToCourse");
        }

        //return "redirect:/";
    }

    @GetMapping(value = "/course/delete")
    @ResponseBody
    public int deleteCourse(@RequestParam("id") long id)  {
        try {
            courseService.deleteCourse(id);
            return 200;
        }catch (Exception e){
            return 300;
        }
    }

    @GetMapping(value = "/topic/delete")
    @ResponseBody
    public int deleteTopic(@RequestParam("id") long id)  {
        try {
            topicsService.deleteTopic(id);
            return 200;
        }catch (Exception e){
            return 300;
        }
    }

    @GetMapping(value = "/course/edit")
    @ResponseBody
    public ModelAndView editCourse(@RequestParam("id") long id, Model model)  {
        model.addAttribute("easy", Difficulty.EASY);
        model.addAttribute("medium", Difficulty.MEDIUM);
        model.addAttribute("hard", Difficulty.HARD);
        model.addAttribute("Topics", topicsService.getAllTopics());
        model.addAttribute("course", courseService.getCourseById(id));
        return new ModelAndView("editCourse");
    }


    @RequestMapping(value = "/topic/add", method = RequestMethod.POST)
    @ResponseBody
    public int saveTopic(@RequestBody String topicName) {
        try {

            topicsService.save(topicName.replace("\"",""));
            return 200;
        }catch (Exception e){
            return 300;
        }
    }
}
