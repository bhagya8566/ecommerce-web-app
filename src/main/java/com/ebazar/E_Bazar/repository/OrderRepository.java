package com.ebazar.E_Bazar.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ebazar.E_Bazar.model.Order;


public interface OrderRepository extends JpaRepository<Order, Long> {
	
	 List<Order> findByUserId(Long userId);
}

