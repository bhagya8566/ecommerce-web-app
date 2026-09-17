package com.ebazar.E_Bazar.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.ebazar.E_Bazar.model.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}

