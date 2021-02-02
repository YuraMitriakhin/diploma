package com.gmail.yuramitryahin.controllers;

import com.gmail.yuramitryahin.dto.PassedTestDTO;
import com.gmail.yuramitryahin.dto.TestsDTO;
import com.gmail.yuramitryahin.entity.user.Question;
import com.gmail.yuramitryahin.entity.user.QuestionType;
import com.gmail.yuramitryahin.entity.user.Role;
import com.gmail.yuramitryahin.entity.user.User;
import com.gmail.yuramitryahin.services.LessonService;
import com.gmail.yuramitryahin.services.ResultService;
import com.gmail.yuramitryahin.services.TestsService;
import com.gmail.yuramitryahin.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.List;

@Controller
public class TestController {

    @Autowired
    private LessonService lessonService;
    @Autowired
    private TestsService testsService;
    @Autowired
    private ResultService resultService;
    @Autowired
    private UserService userService;

    @GetMapping(value = "/test/add")
    @ResponseBody
    public ModelAndView editLesson(@RequestParam("id") long id, Model model) {
        model.addAttribute("lesson", lessonService.findById(id));
        //model.addAttribute("type", QuestionType.LEC);
        return new ModelAndView("addTest");
    }

    @PostMapping(value = "/test/save")
    @ResponseBody
    public int post(@RequestBody TestsDTO testsDTO){
        System.out.println(testsDTO);
        testsService.save(testsDTO);
       /* for (int i=0; i<testsDTO.getCorrect().length; i++){
            for (int j=0; j<testsDTO.getCorrect()[i].length; j++){
                System.out.print(testsDTO.getCorrect()[i][j]+" ");
            }
            System.out.println();
        }*/
        return 333;
    }

    @PostMapping(value = "/tests/passed")
    @ResponseBody
    public int passedTest(@RequestBody PassedTestDTO passedTestDTO){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userService.findByUsername(auth.getName());
        System.out.println(passedTestDTO.toString());
            try {
                if (passedTestDTO.getQuestionId()!=null) {
                    List<Question> mistake = testsService.checkTest(passedTestDTO);
                    resultService.saveResult(passedTestDTO, user, mistake, true);
                }else{
                    resultService.saveResult(passedTestDTO, user, null, false);
                    return 202;
                }
                return 200;
            } catch (Exception e) {
                return 333;
            }
    }

    @RequestMapping(value = "/test/result")
    @ResponseBody
    public ModelAndView getResult(@RequestParam("id") long id, Model model){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userService.findByUsername(auth.getName());

            if(user!=null && user.getAuthorities().stream().findFirst().get()== Role.ADMIN) {
                model.addAttribute("role", true);
            }else{
                model.addAttribute("role", false);
            }
            model.addAttribute("user", user.getUsername());

        model.addAttribute("result", resultService.findByLessonAndUser(user, lessonService.findById(id)));
        return new ModelAndView("resultPage");
    }

    @RequestMapping(value = "/video/save", method = RequestMethod.POST)
    @ResponseBody
    public int saveVideo(@RequestParam("video") MultipartFile file, boolean end) throws IOException {
        try{
            resultService.saveVideo(file,end);
            return 200;
        }catch (IOException e){
            return 300;
        }
    }

    @RequestMapping(value = "/video/delete", method = RequestMethod.GET)
    @ResponseBody
    public int deleteVideo() {
        System.out.println("Delete reqwest");
       resultService.deleteVideo();
       return 200;
    }

}
