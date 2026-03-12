package com.procoder.authentication1.controllers;

import com.procoder.authentication1.models.Item;
import com.procoder.authentication1.models.User;
import com.procoder.authentication1.services.ItemService;
import com.procoder.authentication1.services.UserService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class UserController {

    private final UserService userService;
    private final ItemService itemService;

    @Autowired
    public UserController(UserService userService, ItemService itemService) {
        this.userService = userService;
        this.itemService = itemService;
    }

    @GetMapping({"/", "/home"})
    public String home(HttpSession session) {

        if (session.getAttribute("user") != null) {
            return "redirect:/welcome";
        }

        return "login";
    }

    @PostMapping("/auth/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        @RequestParam String role,
                        Model model,
                        HttpSession session) {

        Optional<User> u = userService.authenticate(username, password, role);

        if (u.isPresent()) {

            
            session.setAttribute("user", u.get());
            session.setAttribute("loginTime",new Date());

            return "redirect:/welcome";
        }

        model.addAttribute("error", "Invalid Credentials");
        return "redirect:/";
    }

    @GetMapping("/welcome")
    public String welcome(Model model,
                          HttpSession session,
                          HttpServletResponse response) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/";
        }

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        List<Item> items = itemService.getItems();

        model.addAttribute("username", user.getUsername());
        model.addAttribute("role", user.getRole());
        model.addAttribute("items", items);
        model.addAttribute("loginTime",session.getAttribute("loginTime"));
        return "welcome";
    }

    @GetMapping("/items/{id}")
    public String showItemDetails(@PathVariable Integer id,
                                  Model model,
                                  HttpSession session) {

        if (session.getAttribute("user") == null) {
            return "redirect:/home";
        }

        Optional<Item> item = itemService.getItemById(id);

        item.ifPresent(value -> model.addAttribute("selectedItem", value));

        model.addAttribute("items", itemService.getItems());
        return "welcome";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {

        session.invalidate();

        return "redirect:/home";
    }
}