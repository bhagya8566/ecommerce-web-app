package com.ebazar.E_Bazar.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long userId;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    private Integer rating;

    @Column(length = 1000)
    private String comment;

    // Save original time
    private LocalDateTime createdAt = LocalDateTime.now();

    // This field is NOT in DB (just for JSP display)
    @Transient
    private Date createdAtDate;

    // -----------------------------
    // Getters & Setters
    // -----------------------------
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public Date getCreatedAtDate() { return createdAtDate; }
    public void setCreatedAtDate(Date createdAtDate) { this.createdAtDate = createdAtDate; }
}
