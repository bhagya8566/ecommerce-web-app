package com.ebazar.E_Bazar.model;


import jakarta.persistence.*;

@Entity
public class OrderItem {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
  @ManyToOne private Product product;
  private Integer quantity;
  private Double price;
public Long getId() {
	return id;
}
public void setId(Long id) {
	this.id = id;
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
public Double getPrice() {
	return price;
}
public void setPrice(Double price) {
	this.price = price;
}
 
  
}
