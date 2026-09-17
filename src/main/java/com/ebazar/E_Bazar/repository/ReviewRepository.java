package com.ebazar.E_Bazar.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.ebazar.E_Bazar.model.Review;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByProductId(Long productId);
}
