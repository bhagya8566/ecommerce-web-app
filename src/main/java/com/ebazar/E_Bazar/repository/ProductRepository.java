package com.ebazar.E_Bazar.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ebazar.E_Bazar.model.Category;
import com.ebazar.E_Bazar.model.Product;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByCategoryId(Long categoryId);
    List<Product> findByNameContainingIgnoreCase(String q);
    
    List<Product> findByCategory(Category category);
    long countByCategoryId(Long categoryId);
    Long countByCategory(Category category);




}

