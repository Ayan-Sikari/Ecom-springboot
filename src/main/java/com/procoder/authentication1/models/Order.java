package com.procoder.authentication1.models;

import java.util.Date;
import java.util.List;

public class Order {

    private long orderId;

    private long userId;

    private List<OrderItem> items;

    private double totalAmount;

    private Date orderDate;

    private String paymentStatus;

    public Order(long orderId,
                 long userId,
                 List<OrderItem> items,
                 double totalAmount) {

        this.orderId = orderId;
        this.userId = userId;
        this.items = items;
        this.totalAmount = totalAmount;
        this.orderDate = new Date();
        this.paymentStatus = "SUCCESS";
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", items=" + items +
                ", totalAmount=" + totalAmount +
                ", orderDate=" + orderDate +
                ", paymentStatus='" + paymentStatus + '\'' +
                '}';
    }

    public long getOrderId() {
        return orderId;
    }

    public long getUserId() {
        return userId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }
}