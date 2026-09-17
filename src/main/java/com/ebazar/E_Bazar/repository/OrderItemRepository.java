package com.ebazar.E_Bazar.repository;



import com.ebazar.E_Bazar.model.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    List<OrderItem> findByProductId(Long productId);
    
    @Query("SELECT COUNT(oi) FROM OrderItem oi WHERE oi.product.category.id = :catId")
    Long countOrdersByCategory(@Param("catId") Long catId);
   

}
