package com.procoder.authentication1.models;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {

    private Long userId;
    private List<CartItem> items = new ArrayList<>();

    public Cart() {}

    public Cart(Long userId) {
        this.userId = userId;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void addItem(Item item){

        for(CartItem ci : items){
            if(ci.getItem().getItemId().equals(item.getItemId())){
                ci.setQuantity(ci.getQuantity()+1);
                return;
            }
        }

        items.add(new CartItem(item,1));
    }

    public void removeItem(Integer id){
        items.removeIf(i -> i.getItem().getItemId().equals(id));
    }

    public double getTotal(){

        return items.stream()
                .mapToDouble(CartItem::getTotalPrice)
                .sum();
    }

    public void clear(){
        items.clear();
    }

    public void increaseItem(Integer itemId) {

        for (CartItem ci : items) {
            if (ci.getItem().getItemId().equals(itemId)) {
                ci.setQuantity(ci.getQuantity() + 1);
                ci.updateTotal();
                return;
            }
        }
    }

    public void decreaseItem(Integer itemId) {

        Iterator<CartItem> iterator = items.iterator();

        while (iterator.hasNext()) {

            CartItem ci = iterator.next();

            if (ci.getItem().getItemId().equals(itemId)) {

                if (ci.getQuantity() > 1) {
                    ci.setQuantity(ci.getQuantity() - 1);
                    ci.updateTotal();
                } else {
                    iterator.remove();
                }

                return;
            }
        }
    }
}