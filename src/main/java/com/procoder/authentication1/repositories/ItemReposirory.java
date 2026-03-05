package com.procoder.authentication1.repositories;


import com.procoder.authentication1.models.Item;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Repository
public class ItemReposirory {


    List<Item> items = Arrays.asList(
            new Item(1, "Samsung Galaxy S23", "5G Smartphone, 8GB RAM, 256GB Storage", 50, 74999.0, 10.0, 4.6),
            new Item(2, "Apple iPhone 14", "128GB, Midnight Black", 30, 69999.0, 7.0, 4.7),
            new Item(3, "Redmi Note 13 Pro", "5G, 12GB RAM, 256GB Storage", 100, 25999.0, 15.0, 4.4),
            new Item(4, "OnePlus Nord CE 3", "5G Smartphone, 8GB RAM", 70, 24999.0, 12.0, 4.3),
            new Item(5, "Realme Narzo 60", "5G, AMOLED Display", 120, 17999.0, 18.0, 4.2),
            new Item(6, "HP Pavilion Laptop", "Intel i5, 16GB RAM, 512GB SSD", 25, 64999.0, 20.0, 4.5),
            new Item(7, "Dell Inspiron 15", "Intel i3, 8GB RAM, 1TB HDD", 40, 45999.0, 17.0, 4.1),
            new Item(8, "MacBook Air M1", "8GB RAM, 256GB SSD", 0, 89999.0, 5.0, 4.8),
            new Item(9, "Lenovo IdeaPad Slim 3", "Ryzen 5, 16GB RAM", 35, 55999.0, 22.0, 4.3),
            new Item(10, "Sony WH-1000XM5", "Noise Cancelling Headphones", 60, 29999.0, 10.0, 4.7),
            new Item(11, "boAt Rockerz 450", "Wireless Bluetooth Headphones", 150, 1499.0, 30.0, 4.2),
            new Item(12, "JBL Flip 6", "Portable Bluetooth Speaker", 80, 11999.0, 15.0, 4.6),
            new Item(13, "Samsung 55-inch Smart TV", "4K UHD, Crystal Display", 20, 52999.0, 18.0, 4.4),
            new Item(14, "LG 1.5 Ton AC", "5 Star, Dual Inverter", 18, 41999.0, 25.0, 4.5),
            new Item(15, "Whirlpool Washing Machine", "7kg Fully Automatic", 22, 18999.0, 20.0, 4.3),
            new Item(16, "Canon EOS 1500D", "DSLR Camera with 18-55mm Lens", 0, 34999.0, 12.0, 4.4),
            new Item(17, "Noise ColorFit Pro 4", "Smartwatch with AMOLED Display", 200, 3499.0, 35.0, 4.2),
            new Item(18, "Apple Watch SE", "GPS, 40mm", 28, 29999.0, 8.0, 4.6),
            new Item(19, "Puma Running Shoes", "Men's Sports Shoes", 90, 4999.0, 40.0, 4.1),
            new Item(20, "Wildcraft Backpack", "35L Waterproof Travel Bag", 110, 2499.0, 28.0, 4.3)
    );

    public Optional<Item> getUserById(Integer id){
        return items.stream()
                .filter(x -> Objects.equals(x.getItemId(), id))
                .findFirst();
    }

    public List<Item> getAllItems() {
        return items;
    }
}
