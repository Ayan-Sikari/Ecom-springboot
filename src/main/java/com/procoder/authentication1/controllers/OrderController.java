package com.procoder.authentication1.controllers;

import com.procoder.authentication1.models.Order;
import com.procoder.authentication1.models.User;
import com.procoder.authentication1.services.OrderService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/orders")
    public String myOrders(HttpSession session, Model model){

        User user = (User) session.getAttribute("user");

        List<Order> orders = orderService.getOrdersByUser(user);

        model.addAttribute("orders", user.getOrders());

        return "orders";
    }
}