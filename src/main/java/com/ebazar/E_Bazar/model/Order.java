package com.ebazar.E_Bazar.model;


import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name="orders")
public class Order {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
  private Long userId;
  private Double totalAmount;
  private String status;
  private LocalDateTime orderDate;
  private String address;
  private String email;
  private Double payableAmount; // NEW final amount to pay
	private Double discountAmount;

  public Double getPayableAmount() {
		return payableAmount;
	}

	public void setPayableAmount(Double payableAmount) {
		this.payableAmount = payableAmount;
	}

	public Double getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(Double discountAmount) {
		this.discountAmount = discountAmount;
	}

  @OneToMany(cascade = CascadeType.ALL)
  private List<OrderItem> items = new ArrayList<>();
  // getters/setters

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

public Double getTotalAmount() {
	return totalAmount;
}

public void setTotalAmount(Double totalAmount) {
	this.totalAmount = totalAmount;
}

public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}

public LocalDateTime getOrderDate() {
	return orderDate;
}

public void setOrderDate(LocalDateTime orderDate) {
	this.orderDate = orderDate;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public List<OrderItem> getItems() {
	return items;
}

public void setItems(List<OrderItem> items) {
	this.items = items;
}
  
  
}

