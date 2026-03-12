package com.procoder.authentication1.services;

import com.procoder.authentication1.models.Item;
import com.procoder.authentication1.models.Order;
import com.procoder.authentication1.models.OrderItem;
import com.procoder.authentication1.models.User;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class OrderService {

    private List<Order> orders = new ArrayList<>();

    private long generateOrderId() {
        return Math.abs(new Random().nextLong());
    }

    public Order placeOrder(User user, List<OrderItem> items, double totalAmount){

        long orderId = generateOrderId();

        Order order = new Order(
                orderId,
                user.getId(),
                items,
                totalAmount
        );

        orders.add(order);

        return order;
    }

    public List<Order> getOrdersByUser(User user){

        List<Order> userOrders = new ArrayList<>();

        for(Order order : orders){

            if(order.getUserId() == user.getId()){
                userOrders.add(order);
            }

        }

        return userOrders;
    }

}