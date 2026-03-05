package com.procoder.authentication1.models;

public class Item {

    private Integer itemId;
    private String itemName;
    private String itemDescription;
    private Integer itemQuantity;
    private Double itemPrice;
    private Double itemDiscount;
    private Double itemRating;

    public Item(){

    }

    public Item(Integer itemId, String itemName, String itemDescription, Integer itemQuantity, Double itemPrice, Double itemDiscount, Double itemRating) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.itemDescription = itemDescription;
        this.itemQuantity = itemQuantity;
        this.itemPrice = itemPrice;
        this.itemDiscount = itemDiscount;
        this.itemRating = itemRating;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemDescription() {
        return itemDescription;
    }

    public void setItemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
    }

    public Integer getItemQuantity() {
        return itemQuantity;
    }

    public void setItemQuantity(Integer itemQuantity) {
        this.itemQuantity = itemQuantity;
    }

    public Double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(Double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Double getItemDiscount() {
        return itemDiscount;
    }

    public void setItemDiscount(Double itemDiscount) {
        this.itemDiscount = itemDiscount;
    }

    public Double getItemRating() {
        return itemRating;
    }

    public void setItemRating(Double itemRating) {
        this.itemRating = itemRating;
    }

}
