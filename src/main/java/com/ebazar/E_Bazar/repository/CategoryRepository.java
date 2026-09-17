package com.ebazar.E_Bazar.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.ebazar.E_Bazar.model.Category;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    Optional<Category> findByNameIgnoreCase(String name);

}
