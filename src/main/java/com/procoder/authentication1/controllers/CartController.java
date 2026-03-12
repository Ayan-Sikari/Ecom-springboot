package com.procoder.authentication1.controllers;

import com.procoder.authentication1.models.*;
import com.procoder.authentication1.services.ItemService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ItemService itemService;

    @GetMapping("/view")
    public String viewCart(HttpSession session, Model model){

        User user = (User) session.getAttribute("user");

        if(user == null){
            return "redirect:/home";
        }

        if(user.getCart() == null){
            user.setCart(new Cart(user.getId()));
        }

        model.addAttribute("cart", user.getCart());

        return "cart";
    }

    @PostMapping("/add/{id}")
    public String addToCart(@PathVariable Integer id, HttpSession session){

        User user = (User) session.getAttribute("user");

        if(user == null){
            return "redirect:/home";
        }

        Item item = itemService.getItemById(id).orElse(null);

        if(item == null || item.getItemQuantity()==0){
            return "redirect:/welcome";
        }

        if(user.getCart() == null){
            user.setCart(new Cart(user.getId()));
        }

        user.getCart().addItem(item);

        return "redirect:/cart/view";
    }

    @GetMapping("/remove/{id}")
    public String removeItem(@PathVariable Integer id, HttpSession session){

        User user = (User) session.getAttribute("user");

        if(user == null){
            return "redirect:/home";
        }

        Cart cart = user.getCart();

        if(cart != null){
            cart.removeItem(id);
        }

        return "redirect:/cart/view";
    }

    @GetMapping("/increase/{id}")
    public String increaseQuantity(@PathVariable Integer id, HttpSession session) {

        User user = (User) session.getAttribute("user");

        user.getCart().increaseItem(id);

        return "redirect:/cart/view";
    }

    @GetMapping("/decrease/{id}")
    public String decreaseQuantity(@PathVariable Integer id, HttpSession session) {

        User user = (User) session.getAttribute("user");

        user.getCart().decreaseItem(id);

        return "redirect:/cart/view";
    }

    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model){

        User user = (User) session.getAttribute("user");

        if(user == null){
            return "redirect:/home";
        }

        Cart cart = user.getCart();

        if(cart == null || cart.getItems().isEmpty()){
            return "redirect:/cart/view";
        }

        model.addAttribute("cart", cart);

        return "checkout";
    }

    @PostMapping("/pay")
    public String processPayment(HttpSession session){

        User user = (User) session.getAttribute("user");

        if(user == null){
            return "redirect:/home";
        }

        Cart cart = user.getCart();

        if(cart == null || cart.getItems().isEmpty()){
            return "redirect:/cart/view";
        }

        List<OrderItem> orderItems = new ArrayList<>();

        for(CartItem ci : cart.getItems()){

            orderItems.add(
                    new OrderItem(
                            ci.getItem(),
                            ci.getQuantity(),
                            ci.getItem().getFinalPrice()
                    )
            );
        }

        Order order = new Order(
                new Random().nextInt(100000),
                user.getId(),
                orderItems,
                cart.getTotal()
        );

        user.addOrder(order);
        cart.clear();
        return "paymentSuccess";
    }

}