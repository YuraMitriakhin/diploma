package com.gmail.yuramitryahin.controllers;

import com.gmail.yuramitryahin.DataSaveDBException;
import com.gmail.yuramitryahin.dto.CourseDTO;
import com.gmail.yuramitryahin.dto.CourseSearchDTO;
import com.gmail.yuramitryahin.dto.LessonDTO;
import com.gmail.yuramitryahin.entity.user.*;
import com.gmail.yuramitryahin.services.CourseService;
import com.gmail.yuramitryahin.services.TegsService;
import com.gmail.yuramitryahin.services.TopicsService;
import com.gmail.yuramitryahin.services.UserService;
import lombok.SneakyThrows;
import org.apache.tomcat.util.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.sampled.*;
import java.io.*;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Controller
public class MainController {
    @Autowired
    private UserService userService;

    @Autowired
    private TopicsService topicsService;

    @Autowired
    private TegsService tegsService;

    @Autowired
    private CourseService courseService;



    @RequestMapping("/")
    public String getMainPage(Model model) {
        model.addAttribute("easy", Difficulty.EASY);
        model.addAttribute("medium", Difficulty.MEDIUM);
        model.addAttribute("hard", Difficulty.HARD);
        model.addAttribute("topics", topicsService.getAllTopics());
        model.addAttribute("tegs", tegsService.getAllTegs().stream().limit(10).collect(Collectors.toList()));
        model.addAttribute("courses", courseService.getAllCourse());

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        model.addAttribute("user", auth.getName());
        model.addAttribute("us", userService.findByUsername(auth.getName()));

        if(auth!=null && auth.getAuthorities().stream().findFirst().get()==Role.ADMIN) {
            model.addAttribute("role", true);
        }else{
            model.addAttribute("role", false);
        }

        return "main";
    }

    @ResponseBody
    @RequestMapping("/tags/get")
    public String getTegs() throws JSONException {
        return tegsService.convertToJson(tegsService.getAllTegs().stream().skip(10).collect(Collectors.toList()));
    }



    @RequestMapping("/i")
    public String getLocal() {
        List<Difficulty> list = Arrays.asList((Difficulty.values()));
        for (Difficulty d: list) {
            System.out.println(d.getValue());
        }
        return "index";
    }


    @GetMapping(value = "/user/num")
    @ResponseBody
    public ModelAndView getCruiseById(@RequestParam("id") long id, HttpServletResponse response, Model model) throws IOException {
        model.addAttribute("users", userService.findUserNative(id));
        return new ModelAndView("selectedUser");
    }


}
