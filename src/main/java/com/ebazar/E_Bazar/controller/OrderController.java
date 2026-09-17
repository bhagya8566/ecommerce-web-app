package com.ebazar.E_Bazar.controller;

import com.ebazar.E_Bazar.model.*;
import com.ebazar.E_Bazar.repository.*;
import com.ebazar.E_Bazar.service.EmailService;
import com.ebazar.E_Bazar.service.PdfService;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private CartItemRepository cartRepo;

    @Autowired
    private OrderRepository orderRepo;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PdfService pdfService;

    // ---------- SHOW CHECKOUT PAGE ----------
    @GetMapping("/checkout")
    public String checkout(Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "redirect:/login";
        }

        List<CartItem> items = cartRepo.findByUserId(user.getId());

        // Calculate total price
        double totalAmount = 0.0;
        for (CartItem item : items) {
            totalAmount += item.getQuantity() * item.getProduct().getPrice();
        }

        model.addAttribute("items", items);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("userEmail", user.getEmail());

        return "checkout";
    }
    // ---------- PLACE ORDER (FULL CART) ----------
    @PostMapping("/place")
    public String placeOrder(@RequestParam String address,
                             @RequestParam String email,
                             @RequestParam(required = false) String couponCode,
                             Model model,
                             HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        // Email format check
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        if (email == null || !email.matches(emailRegex)) {
            model.addAttribute("emailError", "❌ Invalid email format. Please enter a correct email.");
            model.addAttribute("userEmail", user.getEmail());
            return "checkout";
        }

        boolean verifyOk = emailService.verifyEmailBySendingTest(email);

        if (!verifyOk) {
            model.addAttribute("emailError",
                "❌ Email appears invalid or unreachable. Please enter a working email.");
            return "checkout";
        }
        List<CartItem> items = cartRepo.findByUserId(user.getId());
        if (items.isEmpty()) {
            model.addAttribute("error", "Your cart is empty!");
            return "checkout";
        }

        // Create order
        Order order = new Order();
        order.setUserId(user.getId());
        order.setAddress(address);
        order.setEmail(email);
        order.setStatus("PLACED");
        order.setOrderDate(LocalDateTime.now());

        double total = 0.0;
        for (CartItem ci : items) {
            OrderItem oi = new OrderItem();
            oi.setProduct(ci.getProduct());
            oi.setQuantity(ci.getQuantity());
            oi.setPrice(ci.getProduct().getPrice());
            order.getItems().add(oi);
            total += ci.getProduct().getPrice() * ci.getQuantity() ;
            double discount = 0.0;

            if (couponCode != null && !couponCode.isEmpty()) {
                if (couponCode.equalsIgnoreCase("AGC10")) {
                    discount = total * 0.10;
                }
            }

            double payable = total - discount;

            order.setDiscountAmount(discount);
            order.setPayableAmount(payable);

            order.setTotalAmount(total);

//            Order savedOrder = orderRepo.save(order);
            order = orderRepo.save(order);
            model.addAttribute("order", order);
        }
        order.setTotalAmount(total);

       // Order savedOrder = orderRepo.save(order);

        // Clear cart
        cartRepo.deleteAll(items);

        // Send email confirmation
        boolean emailSent = emailService.sendOrderConfirmation(
                email,
                "Order Confirmed - E-Bazar",
                "Your order #" + order.getId() + " has been placed successfully."
        );

        if (!emailSent) {
            model.addAttribute("emailError", "⚠ Order placed but confirmation email could not be delivered.");
        } else {
            model.addAttribute("emailSuccess", "📩 Confirmation email sent successfully.");
        }

        model.addAttribute("order", order);
        return "order-confirmation";
    }

    // ---------- SINGLE CHECKOUT PAGE ----------
    @GetMapping("/single-checkout")
    public String singleCheckout(@RequestParam Long cartId, Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        CartItem item = cartRepo.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart item not found!"));

        model.addAttribute("singleItem", item);
        model.addAttribute("userEmail", user.getEmail()); // <-- pass user email here
        return "single-checkout";
    }

    // ---------- PLACE SINGLE ITEM ORDER ----------
    @PostMapping("/place-single")
    public String placeSingleOrder(@RequestParam Long cartId,
                                   @RequestParam String address,
                                   @RequestParam String email,
                                   @RequestParam(required = false) String couponCode,
                                   Model model,
                                   HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        // --- EMAIL VERIFICATION ---
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        if (email == null || !email.matches(emailRegex)) {
            model.addAttribute("emailError", "❌ Invalid email format. Please enter a correct email.");
            model.addAttribute("userEmail", user.getEmail());
            return "single-checkout";
        }

        boolean verifyOk = emailService.verifyEmailBySendingTest(email);
        if (!verifyOk) {
            model.addAttribute("emailError", "❌ Email appears invalid or unreachable. Please enter a working email.");
            model.addAttribute("userEmail", user.getEmail());
            return "single-checkout";
        }

        CartItem ci = cartRepo.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart item not found!"));

        // Create order
        Order order = new Order();
        order.setUserId(user.getId());
        order.setAddress(address);
        order.setEmail(email);
        order.setStatus("PLACED");
        order.setOrderDate(LocalDateTime.now());

        OrderItem oi = new OrderItem();
        oi.setProduct(ci.getProduct());
        oi.setQuantity(ci.getQuantity());
        oi.setPrice(ci.getProduct().getPrice());
        order.getItems().add(oi);
        order.setTotalAmount(oi.getPrice() * oi.getQuantity());
        double total = oi.getPrice() * oi.getQuantity();
        double discount = 0.0;

        if (couponCode != null && !couponCode.isEmpty()) {
            if (couponCode.equalsIgnoreCase("AGC10")) {
                discount = total * 0.10;
            }
        }

        double payable = total - discount;

        order.setTotalAmount(total);
        order.setDiscountAmount(discount);
        order.setPayableAmount(payable);

        Order savedOrder = orderRepo.save(order);
        cartRepo.delete(ci);

        boolean emailSent = emailService.sendOrderConfirmation(
                email,
                "Order Confirmed - E-Bazar",
                "Your order #" + savedOrder.getId() + " has been placed successfully."
        );

        if (!emailSent) {
            model.addAttribute("emailError", "⚠ Order placed but confirmation email could not be delivered.");
        } else {
            model.addAttribute("emailSuccess", "📩 Confirmation email sent successfully.");
        }

        model.addAttribute("order", savedOrder);
        return "order-confirmation";
    }

    // ---------- ORDER HISTORY ----------
    @GetMapping("/history")
    public String orderHistory(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            session.setAttribute("redirectAfterLogin", "/order/history");
            return "redirect:/login";
        }

        List<Order> orders = orderRepo.findByUserId(loggedUser.getId());
        model.addAttribute("user", loggedUser);
        model.addAttribute("orders", orders);
        return "order-history"; // <-- Make sure this JSP exists
    }


    // ---------- CANCEL ORDER ----------
    @PostMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable Long orderId, HttpSession session) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        Order order = orderRepo.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found!"));

        if (!order.getUserId().equals(user.getId())) {
            return "redirect:/order/history";
        }

        if (!order.getStatus().equals("DELIVERED")) {
            order.setStatus("CANCELLED");
            orderRepo.save(order);

            emailService.sendOrderConfirmation(
                    user.getEmail(),
                    "Order Cancelled - E-Bazar",
                    "Your order #" + orderId + " has been cancelled successfully."
            );
        }

        return "redirect:/order/history";
    }

    // ---------- DOWNLOAD INVOICE ----------
 // ---------- DOWNLOAD INVOICE ----------
    @GetMapping("/invoice/{orderId}")
    public ResponseEntity<InputStreamResource> downloadInvoice(@PathVariable Long orderId, HttpSession session) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return ResponseEntity.status(401).build();

        Order order = orderRepo.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        String[][] items = order.getItems().stream()
                .map(oi -> new String[]{
                        oi.getProduct().getName(),
                        String.valueOf(oi.getQuantity()),
                        String.valueOf(oi.getPrice()),
                        oi.getProduct().getImagePath() != null ? oi.getProduct().getImagePath() : ""
                })
                .toArray(String[][]::new);

        ByteArrayInputStream bis = pdfService.generateInvoicePdf(
                String.valueOf(order.getId()),
                user.getName(),
                items,
                order.getTotalAmount(),
                order.getDiscountAmount(),    // discount applied
                order.getPayableAmount()
        );

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=invoice_" + order.getId() + ".pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(bis));
    }
}
