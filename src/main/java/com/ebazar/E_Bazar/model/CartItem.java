package com.ebazar.E_Bazar.model;


import jakarta.persistence.*;

@Entity
public class CartItem {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
  private Long userId;
  @ManyToOne private Product product;
  private Integer quantity;
public Long getId() {
	return id;
}
public void setId(Long id) {
	this.id = id;
}
public Long getUserId() {
	return userId;
}
public void setUserId(Long userId) {
	this.userId = userId;
}
public Product getProduct() {
	return product;
}
public void setProduct(Product product) {
	this.product = product;
}
public Integer getQuantity() {
	return quantity;
}
public void setQuantity(Integer quantity) {
	this.quantity = quantity;
}
 
  
}
