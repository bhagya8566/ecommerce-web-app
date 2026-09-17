package com.ebazar.E_Bazar.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.ebazar.E_Bazar.model.Product;
import com.ebazar.E_Bazar.model.Review;
import com.ebazar.E_Bazar.model.OrderItem;
import com.ebazar.E_Bazar.model.Category;
import com.ebazar.E_Bazar.repository.ProductRepository;
import com.ebazar.E_Bazar.repository.ReviewRepository;
import com.ebazar.E_Bazar.repository.CategoryRepository;
import com.ebazar.E_Bazar.repository.OrderItemRepository;

import java.io.IOException;
import java.nio.file.*;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductRepository productRepo;

    @Autowired
    private OrderItemRepository orderItemRepo;

    @Autowired
    private CategoryRepository categoryRepo;

    @Autowired
    private ReviewRepository reviewRepo;

    private final String uploadDir = "uploads";

    public AdminController() throws IOException {
        Files.createDirectories(Paths.get(uploadDir));
    }

    // =============================================================
    // ✔ ADMIN LOGIN PAGE
    // =============================================================
    @GetMapping("/login")
    public String adminLogin() {
        return "admin/admin-login";   // create this JSP
    }

    // =============================================================
    // ✔ ADMIN LOGIN SUBMIT
    // =============================================================
    @PostMapping("/login")
    public String adminLoginSubmit(@RequestParam String username,
                                   @RequestParam String password,
                                   HttpSession session,
                                   Model model) {

        // Simple login (you can replace with DB later)
        if (username.equals("admin") && password.equals("admin123")) {
            session.setAttribute("adminLogged", true);
            return "redirect:/admin/products";
        }

        model.addAttribute("error", "Invalid username or password");
        return "admin/admin-login";
    }

    // =============================================================
    // ✔ LOGOUT
    // =============================================================
    @GetMapping("/logout")
    public String adminLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    // =============================================================
    // ✔ CHECK ADMIN SESSION
    // =============================================================
    private boolean checkAdmin(HttpSession session) {
        Boolean logged = (Boolean) session.getAttribute("adminLogged");
        return logged != null && logged;
    }

    // =============================================================
    // SHOW ALL PRODUCTS (PROTECTED)
    // =============================================================
    @GetMapping("/products")
    public String listProducts(HttpSession session, Model model,
                               @RequestParam(value = "error", required = false) String error) {

        if (!checkAdmin(session)) return "redirect:/admin/login";

        model.addAttribute("products", productRepo.findAll());
        model.addAttribute("error", error);
        return "admin/manage-products";
    }

    // =============================================================
    // ADD PRODUCT PAGE (PROTECTED)
    // =============================================================
    @GetMapping("/add-product")
    public String addProductForm(HttpSession session, Model model) {

        if (!checkAdmin(session)) return "redirect:/admin/login";

        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryRepo.findAll());
        return "admin/add-product";
    }

    // =============================================================
    // SAVE PRODUCT (PROTECTED)
    // =============================================================
    @PostMapping("/save-product")
    public String saveProduct(HttpSession session,
                              @ModelAttribute Product product,
                              @RequestParam("categoryId") Long categoryId,
                              @RequestParam("imageFile") MultipartFile imageFile)
            throws IOException {

        if (!checkAdmin(session)) return "redirect:/admin/login";

        Category category = categoryRepo.findById(categoryId).orElse(null);
        product.setCategory(category);

        if (!imageFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            Path filePath = Paths.get(uploadDir, fileName);
            Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            product.setImagePath("/uploads/" + fileName);
        }

        productRepo.save(product);
        return "redirect:/admin/products";
    }

    // =============================================================
    // EDIT PRODUCT (PROTECTED)
    // =============================================================
    @GetMapping("/edit-product/{id}")
    public String editProduct(@PathVariable Long id, HttpSession session, Model model) {

        if (!checkAdmin(session)) return "redirect:/admin/login";

        Product product = productRepo.findById(id).orElse(null);
        if (product == null) return "redirect:/admin/products";

        model.addAttribute("product", product);
        model.addAttribute("categories", categoryRepo.findAll());
        return "admin/edit-product";
    }

    // =============================================================
    // UPDATE PRODUCT (PROTECTED)
    // =============================================================
    @PostMapping("/update-product")
    public String updateProduct(HttpSession session,
                                @ModelAttribute Product product,
                                @RequestParam("categoryId") Long categoryId,
                                @RequestParam("imageFile") MultipartFile imageFile)
            throws IOException {

        if (!checkAdmin(session)) return "redirect:/admin/login";

        Product existing = productRepo.findById(product.getId()).orElse(null);

        if (existing != null) {

            existing.setName(product.getName());
            existing.setDescription(product.getDescription());
            existing.setPrice(product.getPrice());
            existing.setStock(product.getStock());

            Category category = categoryRepo.findById(categoryId).orElse(null);
            existing.setCategory(category);

            if (!imageFile.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                Path filePath = Paths.get(uploadDir, fileName);
                Files.copy(imageFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                existing.setImagePath("/uploads/" + fileName);
            }

            productRepo.save(existing);
        }

        return "redirect:/admin/products";
    }

    // =============================================================
    // DELETE PRODUCT (PROTECTED)
    // =============================================================
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id, HttpSession session) {

        if (!checkAdmin(session)) return "redirect:/admin/login";

        List<OrderItem> usedItems = orderItemRepo.findByProductId(id);
        if (usedItems != null && !usedItems.isEmpty()) {
            return "redirect:/admin/products?error=Cannot delete: Product has order history";
        }

        List<Review> reviews = reviewRepo.findByProductId(id);
        if (reviews != null && !reviews.isEmpty()) {
            return "redirect:/admin/products?error=Cannot delete: Product has reviews";
        }

        productRepo.deleteById(id);
        return "redirect:/admin/products?success=Product deleted";
    }
}
