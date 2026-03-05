package com.procoder.authentication1.services;

import com.procoder.authentication1.models.Item;
import com.procoder.authentication1.repositories.ItemReposirory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ItemService {
    private final ItemReposirory itemReposirory;
    @Autowired
    public ItemService(ItemReposirory itemReposirory) {
        this.itemReposirory = itemReposirory;
    }

    public List<Item> getItems(){
        return itemReposirory.getAllItems();
    }

    public Optional<Item> getItemById(Integer id) {
        return itemReposirory.getUserById(id);
    }
}
