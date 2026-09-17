package com.ebazar.E_Bazar.controller;

import java.util.List;
import java.time.ZoneId;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.ebazar.E_Bazar.model.Product;
import com.ebazar.E_Bazar.model.Review;
import com.ebazar.E_Bazar.model.User;
import com.ebazar.E_Bazar.repository.ProductRepository;
import com.ebazar.E_Bazar.repository.ReviewRepository;
import com.ebazar.E_Bazar.service.FileStorageService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/product")
public class ProductController {

    private final ProductRepository productRepo;
    private final FileStorageService storage;

    @Autowired
    private ReviewRepository reviewRepository;

    public ProductController(ProductRepository productRepo, FileStorageService storage) {
        this.productRepo = productRepo;
        this.storage = storage;
    }

    // 🛒 Show Product + Reviews
    @GetMapping("/{id}")
    public String getProductById(@PathVariable Long id, Model model) {

        Product product = productRepo.findById(id).orElse(null);
        model.addAttribute("product", product);

        // Fetch reviews
        List<Review> reviews = reviewRepository.findByProductId(id);

        // Convert LocalDateTime → java.util.Date for JSP formatting
        for (Review r : reviews) {
            if (r.getCreatedAt() != null) {
                Date date = Date.from(r.getCreatedAt()
                        .atZone(ZoneId.systemDefault())
                        .toInstant());
                r.setCreatedAtDate(date);
            }
        }

        model.addAttribute("reviews", reviews);

        // ⭐ Calculate average rating
        double avg = 0;
        if (!reviews.isEmpty()) {
            avg = reviews.stream()
                    .mapToInt(Review::getRating)
                    .average()
                    .orElse(0.0);
        }
        model.addAttribute("averageRating", avg);

        return "product-details"; // JSP file
    }


    // 💬 Add Review
    @PostMapping("/{id}/review")
    public String addReview(@PathVariable Long id,
                            @RequestParam("rating") int rating,
                            @RequestParam("comment") String comment,
                            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null) {
            return "redirect:/login";
        }

        Product product = productRepo.findById(id).orElse(null);
        if (product == null) {
            return "redirect:/";
        }

        Review review = new Review();
        review.setProduct(product);
        review.setRating(rating);
        review.setComment(comment);
        review.setUserId(user.getId());
        reviewRepository.save(review);

        return "redirect:/product/" + id;
    }


    // 🧑‍💼 Admin Add Product Form
    @GetMapping("/admin/add")
    public String addForm(Model model) {
        model.addAttribute("product", new Product());
        return "admin/add-product";
    }


    // 🧑‍💼 Admin Save Product
    @PostMapping("/admin/save")
    public String save(@ModelAttribute Product product,
                       @RequestParam("image") MultipartFile file) {

        if (file != null && !file.isEmpty()) {
            String path = storage.storeFile(file);
            product.setImagePath(path);
        }

        productRepo.save(product);
        return "redirect:/";
    }
}
