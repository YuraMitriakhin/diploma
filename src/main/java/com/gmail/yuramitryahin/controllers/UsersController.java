package com.gmail.yuramitryahin.controllers;


import com.gmail.yuramitryahin.entity.user.Role;
import com.gmail.yuramitryahin.entity.user.User;
import com.gmail.yuramitryahin.services.*;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UsersController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/users/all")
    public String getAllUsers(Model model){
        model.addAttribute("users",userService.getAllUsers().getUsers());
        return "allUsers";
    }

    @GetMapping(value = "/user")
    @ResponseBody
    public ModelAndView getUsers(@RequestParam("id") long id, Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userService.findByUsername(auth.getName());
        model.addAttribute("logUser", user);
        model.addAttribute("user", userService.findByUserId(id));

        return new ModelAndView("userPage");
    }

    @GetMapping(value = "/user/results")
    @ResponseBody
    public ModelAndView getUserResults(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userService.findByUsername(auth.getName());
        model.addAttribute("user", user);

        if(user!=null && user.getAuthorities().stream().findFirst().get()==Role.ADMIN) {
            model.addAttribute("role", true);
        }else{
            model.addAttribute("role", false);
        }

        return new ModelAndView("userResultPage");
    }

    @PostMapping(value = "/user/change_type")
    @ResponseBody
    public int changeType(@RequestParam("id") long id, @RequestBody boolean type){
        try {
            System.out.println("Id user - "+id+"; type - "+type);
            User user = userService.findByUserId(id);
            user.setPremium(type);
            userService.save(user);
            return 200;
        }catch (Exception e){
            return 333;
        }
    }

}
