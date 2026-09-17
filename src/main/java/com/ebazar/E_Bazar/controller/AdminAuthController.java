package com.ebazar.E_Bazar.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/auth")
public class AdminAuthController {

    // OPEN LOGIN PAGE
    @GetMapping("/login")
    public String login() {
        return "admin/admin-login";
    }

    // HANDLE LOGIN FORM
    @PostMapping("/login")
    public String doLogin(@RequestParam String email,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {

        // FIXED ADMIN CREDENTIALS
        if (email.equals("admin@gmail.com") && password.equals("admin")) {
            session.setAttribute("adminLogged", true);
            return "redirect:/admin/products"; // redirect to dashboard or product page
        }

        model.addAttribute("error", "Invalid Email or Password");
        return "admin/admin-login";
    }

    // LOGOUT
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
}
