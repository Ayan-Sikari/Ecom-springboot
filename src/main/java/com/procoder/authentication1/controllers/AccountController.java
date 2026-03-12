package com.procoder.authentication1.controllers;

import com.procoder.authentication1.models.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AccountController {

    @GetMapping("/account")
    public String myAccount(HttpSession session, Model model){

        User user = (User) session.getAttribute("user");

        model.addAttribute("user", user);
        if (session.getAttribute("user") == null) {
            return "redirect:/home";
        }
        return "account";
    }

}