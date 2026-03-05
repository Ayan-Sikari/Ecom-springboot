package com.procoder.authentication1.repositories;

import com.procoder.authentication1.models.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public class UserRepository {

    List<User> users = List.of(
            new User(1L, "user_alpha", "alpha@test.com", "alpha123", "USER"),
            new User(2L, "user_beta", "beta@test.com", "beta123", "USER"),
            new User(3L, "dev_ayan", "ayan@test.com", "admin123", "ADMIN"),
            new User(4L, "repo_tester", "tester@test.com", "test123", "USER"),
            new User(5L, "mock_user", "mock@test.com", "mock123", "USER"),
            new User(6L, "qa_engineer", "qa@test.com", "qa123", "USER"),
            new User(7L, "sandbox_dev", "sandbox@test.com", "sandbox123", "USER"),
            new User(8L, "trial_user", "trial@test.com", "trial123", "USER"),
            new User(9L, "opensource_user", "open@test.com", "open123", "USER"),
            new User(10L, "admin_root", "admin@test.com", "root123", "ADMIN")
    );

    public Optional<User> getUserByMailAndPasswordAndRole(String mail, String password,String role){
        return users.stream()
                .filter(x -> x.getMail().equals(mail) && x.getPassword().equals(password) && x.getRole().equals(role))
                .findFirst();
    }
    public Optional<User> getUserById(Integer id){
        return users.stream()
                .filter(x -> x.getId()==id)
                .findFirst();
    }
}
