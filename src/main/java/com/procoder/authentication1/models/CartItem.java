package com.procoder.authentication1.models;

public class CartItem {

    private Item item;
    private int quantity;

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    private double totalPrice;

    public CartItem(){}

    public CartItem(Item item, int quantity) {
        this.item = item;
        this.quantity = quantity;
    }

    public Item getItem() {
        return item;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice(){
        return item.getFinalPrice() * quantity;
    }

    public void updateTotal() {
        this.totalPrice = this.quantity * item.getItemPrice();
    }
}