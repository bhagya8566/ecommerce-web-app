package com.ebazar.E_Bazar.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.ebazar.E_Bazar.model.CartItem;

import java.util.List;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    List<CartItem> findByUserId(Long userId);
}
