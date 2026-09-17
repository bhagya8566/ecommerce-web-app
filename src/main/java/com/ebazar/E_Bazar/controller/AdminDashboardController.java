package com.ebazar.E_Bazar.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ebazar.E_Bazar.model.Category;
import com.ebazar.E_Bazar.model.Product;
import com.ebazar.E_Bazar.repository.*;

import java.util.*;

@Controller
public class AdminDashboardController {

    @Autowired private ProductRepository productRepo;
    @Autowired private CategoryRepository categoryRepo;
    @Autowired private OrderRepository orderRepo;
    @Autowired private OrderItemRepository orderItemRepo;
    @Autowired private UserRepository userRepo;

    @GetMapping("/admin/dashboard")
    public String dashboard(Model model) {

        // ---- COUNT CARDS ----
        long totalProducts = productRepo.count();
        long totalCategories = categoryRepo.count();
        long totalOrders = orderRepo.count();
        long totalUsers = userRepo.count();

        model.addAttribute("products", totalProducts);
        model.addAttribute("categories", totalCategories);
        model.addAttribute("orders", totalOrders);
        model.addAttribute("users", totalUsers);

        // Category list
        List<Category> categories = categoryRepo.findAll();

        // ---- CATEGORY WISE PRODUCT COUNT (For PIE CHART) ----
        Map<String, Long> productCountMap = new LinkedHashMap<>();
        for (Category cat : categories) {
            Long count = productRepo.countByCategory(cat);
            productCountMap.put(cat.getName(), count);
        }
        model.addAttribute("productData", productCountMap);

        // ---- CATEGORY WISE ORDER COUNT (For BAR CHART) ----
        Map<String, Long> orderCountMap = new LinkedHashMap<>();
        for (Category cat : categories) {
            Long count = orderItemRepo.countOrdersByCategory(cat.getId());
            orderCountMap.put(cat.getName(), count);
        }
        model.addAttribute("orderData", orderCountMap);

        // ---- ANALYTICS TABLE (DETAILED) ----
        List<Map<String, Object>> categoryDetails = new ArrayList<>();

        for (Category cat : categories) {

            Map<String, Object> map = new LinkedHashMap<>();

            List<Product> plist = productRepo.findByCategory(cat);

            long totalProductCount = plist.size();
            long totalStock = plist.stream().mapToLong(p -> p.getStock()).sum();
            long lowStock = plist.stream().filter(p -> p.getStock() < 5).count();
            long outOfStock = plist.stream().filter(p -> p.getStock() == 0).count();

            Product maxPrice = plist.stream().max(Comparator.comparing(Product::getPrice)).orElse(null);
            Product minPrice = plist.stream().min(Comparator.comparing(Product::getPrice)).orElse(null);

            Long orderCount = orderItemRepo.countOrdersByCategory(cat.getId());

            map.put("category", cat.getName());
            map.put("totalProducts", totalProductCount);
            map.put("totalOrders", orderCount);
            map.put("totalStock", totalStock);
            map.put("lowStock", lowStock);
            map.put("outOfStock", outOfStock);
            map.put("maxProduct", maxPrice != null ? maxPrice.getName() : "N/A");
            map.put("minProduct", minPrice != null ? minPrice.getName() : "N/A");

            categoryDetails.add(map);
        }

        model.addAttribute("categoryDetails", categoryDetails);

        return "admin/dashboard";
    }
}
