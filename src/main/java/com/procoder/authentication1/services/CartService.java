package com.procoder.authentication1.services;

import com.procoder.authentication1.models.Cart;
import com.procoder.authentication1.models.Item;
import org.springframework.stereotype.Service;

@Service
public class CartService {

    public void addItem(Cart cart, Item item){

        if(cart == null || item == null){
            return;
        }

        cart.addItem(item);
    }

    public void removeItem(Cart cart, Integer id){

        if(cart == null){
            return;
        }

        cart.removeItem(id);
    }

}