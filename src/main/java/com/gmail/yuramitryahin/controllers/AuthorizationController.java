package com.gmail.yuramitryahin.controllers;

import com.gmail.yuramitryahin.DataSaveDBException;
import com.gmail.yuramitryahin.dto.UserDTO;
import com.gmail.yuramitryahin.services.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.constraints.Null;

@Slf4j
@Controller
public class AuthorizationController {

    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String getLogin(@RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "logout", required = false) String logout,
                           Model model) {
        if (!SecurityContextHolder.getContext().getAuthentication().getName().equals("anonymousUser")){
            return "redirect:/403";
        }
        model.addAttribute("error", error != null);
        model.addAttribute("logout", logout != null);
        return "login";
    }

    @PostMapping(value = "/register")
    public String getLogin(UserDTO userDTO){
        try {
            userService.saveNewUser(userDTO);
        } catch (DataSaveDBException e) {
            return "redirect:/registration?error";
        }
        return "redirect:/";
    }

    @RequestMapping("/registration")
    public String getLogin(@RequestParam(value = "error", required = false) String error,
                           Model model) {
        model.addAttribute("error", error != null);
        return "registration";
    }
}
