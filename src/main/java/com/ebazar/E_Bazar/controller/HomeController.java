package com.ebazar.E_Bazar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.ebazar.E_Bazar.model.Product;
import com.ebazar.E_Bazar.model.Review;
import com.ebazar.E_Bazar.repository.CategoryRepository;
import com.ebazar.E_Bazar.repository.ProductRepository;
import com.ebazar.E_Bazar.repository.ReviewRepository;

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class HomeController {

    private final ProductRepository productRepo;
    private final CategoryRepository categoryRepo;

    @Autowired
    private ReviewRepository reviewRepository;

    public HomeController(ProductRepository p, CategoryRepository c) {
        this.productRepo = p;
        this.categoryRepo = c;
    }

    // ------------------------------------------
    // 1️⃣ Home Page -> Show Categories + Products + Average Rating
    // ------------------------------------------
    
    


    @GetMapping("/")
    
    public String home(Model model) {

        List<Product> products = productRepo.findAll();

        // ⭐ Average rating map
        Map<Long, Double> ratingMap = new HashMap<>();

        for (Product p : products) {
            List<Review> reviews = reviewRepository.findByProductId(p.getId());

            double avgRating = 0;
            if (!reviews.isEmpty()) {
                avgRating = reviews.stream()
                        .mapToInt(Review::getRating)
                        .average()
                        .orElse(0.0);
            }
            ratingMap.put(p.getId(), avgRating);
        }

        // ⭐ Random 8 products for homepage
        Collections.shuffle(products);
        List<Product> randomProducts = products.stream()
                .limit(8)
                .toList();

        model.addAttribute("categories", categoryRepo.findAll());
        model.addAttribute("products", randomProducts);
        model.addAttribute("ratingMap", ratingMap);

        return "index";
    }


    // ------------------------------------------
    // 2️⃣ Category-wise Products Page
    // ------------------------------------------
    @GetMapping("/category/{id}")
    public String categoryProducts(@PathVariable Long id, Model model) {

        List<Product> products = productRepo.findByCategoryId(id);

        // ⭐ Average rating map for this category
        Map<Long, Double> ratingMap = new HashMap<>();

        for (Product p : products) {
            List<Review> reviews = reviewRepository.findByProductId(p.getId());

            double avgRating = 0;
            if (!reviews.isEmpty()) {
                avgRating = reviews.stream()
                        .mapToInt(Review::getRating)
                        .average()
                        .orElse(0.0);
            }
            ratingMap.put(p.getId(), avgRating);
        }

        model.addAttribute("categories", categoryRepo.findAll());
        model.addAttribute("products", products);
        model.addAttribute("ratingMap", ratingMap);
        model.addAttribute("selectedCategoryId", id);

        return "category-products";
    }
    

    // MAIN SEARCH RESULT PAGE (index.jsp)
    @GetMapping("/search")
    public String searchProducts(@RequestParam("query") String query, Model model) {

        List<Product> products = productRepo.findByNameContainingIgnoreCase(query);

        if (products.isEmpty()) {
            model.addAttribute("message", "No products found for: " + query);
        }

        model.addAttribute("searchResults", products);
        model.addAttribute("query", query);

        return "index";   // Results will show on home page
    }

    // AUTO SUGGEST (AJAX)
    @GetMapping("/search/suggest")
    @ResponseBody
    public List<String> suggest(@RequestParam String keyword) {

        List<Product> list = productRepo.findByNameContainingIgnoreCase(keyword);

        return list.stream()
                .map(Product::getName)
                .collect(Collectors.toList());
    }
}