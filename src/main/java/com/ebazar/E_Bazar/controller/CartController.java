package com.ebazar.E_Bazar.controller;

import com.ebazar.E_Bazar.model.CartItem;
import com.ebazar.E_Bazar.model.Product;
import com.ebazar.E_Bazar.repository.CartItemRepository;
import com.ebazar.E_Bazar.repository.ProductRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final ProductRepository productRepo;
    private final CartItemRepository cartRepo;

    public CartController(ProductRepository p, CartItemRepository c) {
        this.productRepo = p;
        this.cartRepo = c;
    }

    // METHOD TO UPDATE CART COUNT IN SESSION
    private void updateCartCount(HttpSession session, Long userId) {
        int count = cartRepo.findByUserId(userId).size();
        session.setAttribute("cartCount", count);
    }

    // ================================
    // ADD TO CART (Stay on Same Page)
    // ================================
    @PostMapping("/add")
    public String addToCart(@RequestParam Long productId,
                            @RequestParam(defaultValue = "1") Integer qty,
                            HttpSession session,
                            HttpServletRequest request) {

        Long userId = (Long) session.getAttribute("userId");

        // If user not logged in → redirect to login
        if (userId == null) {
            session.setAttribute("redirectAfterLogin", "/cart/add?productId=" + productId);
            return "redirect:/login";
        }

        Product product = productRepo.findById(productId).orElse(null);
        if (product == null) return "redirect:/";

        // OUT OF STOCK
        if (product.getStock() <= 0) {
            session.setAttribute("errorMessage", "❌ This product is currently OUT OF STOCK.");
            return "redirect:" + request.getHeader("Referer");
        }

        // Check if already in cart
        List<CartItem> existingItems = cartRepo.findByUserId(userId);
        for (CartItem ci : existingItems) {
            if (ci.getProduct().getId().equals(productId)) {
                ci.setQuantity(ci.getQuantity() + qty);
                cartRepo.save(ci);

                updateCartCount(session, userId);
                session.setAttribute("successMessage", "✔ Quantity updated in cart.");
                return "redirect:" + request.getHeader("Referer");
            }
        }

        // Add new item in cart
        CartItem item = new CartItem();
        item.setProduct(product);
        item.setQuantity(qty);
        item.setUserId(userId);
        cartRepo.save(item);

        updateCartCount(session, userId);
        session.setAttribute("successMessage", "✔ Product added to cart successfully!");
        return "redirect:" + request.getHeader("Referer");
    }

    // ================================
    // VIEW CART
    // ================================
    @GetMapping("/view")
    public String viewCart(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        List<CartItem> items = cartRepo.findByUserId(userId);
        model.addAttribute("items", items);

        updateCartCount(session, userId);
        return "cart";
    }

    // ================================
    // REMOVE ITEM
    // ================================
    @PostMapping("/remove")
    public String remove(@RequestParam Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        cartRepo.deleteById(id);
        updateCartCount(session, userId);

        return "redirect:/cart/view";
    }

    // ================================
    // UPDATE QTY
    // ================================
    @PostMapping("/update")
    public String updateQuantity(@RequestParam Long id,
                                 @RequestParam int quantity,
                                 HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        CartItem item = cartRepo.findById(id).orElseThrow();

        if (quantity >= 1) {
            Product product = item.getProduct();

            if (quantity > product.getStock()) {
                session.setAttribute("errorMessage", "⚠ Cannot exceed available stock.");
                quantity = product.getStock();
            }

            item.setQuantity(quantity);
            cartRepo.save(item);
        }

        updateCartCount(session, userId);
        return "redirect:/cart/view";
    }
}