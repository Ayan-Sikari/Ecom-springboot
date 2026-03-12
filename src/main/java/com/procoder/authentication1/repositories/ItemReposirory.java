package com.procoder.authentication1.repositories;


import com.procoder.authentication1.models.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public class ItemReposirory {

    private final RestTemplate restTemplate;

    private static final String PRODUCT_API =
            "http://localhost:8080/ProductAPI/products";

    @Autowired
    public ItemReposirory(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<Item> getAllItems(){

        Item[] items =
                restTemplate.getForObject(PRODUCT_API, Item[].class);
        return Arrays.asList(items);
    }

    public Optional<Item> getUserById(Integer id){

        List<Item> items = getAllItems();

        return items.stream()
                .filter(x -> Objects.equals(x.getItemId(), id))
                .findFirst();
    }
}