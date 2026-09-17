package com.ebazar.E_Bazar.controller;

import com.ebazar.E_Bazar.model.User;
import com.ebazar.E_Bazar.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
public class AuthController {

    private final UserRepository userRepo;

    public AuthController(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    // ✅ Registration form
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    // ✅ Handle registration
    @PostMapping("/register")
    public String register(@ModelAttribute User user, Model model) {
        if (userRepo.findByEmail(user.getEmail()).isPresent()) {
            model.addAttribute("error", "Email already exists!");
            return "register";
        }
        userRepo.save(user);
        model.addAttribute("msg", "Registration successful! Please login.");
        return "login";
    }

    // ✅ Login form
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

 // ✅ Handle login (with redirect-after-login support)
    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        Optional<User> userOpt = userRepo.findByEmail(email);
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            User loggedUser = userOpt.get();
            session.setAttribute("loggedUser", loggedUser);

            // ✅ Add userId in session for reviews
            session.setAttribute("userId", loggedUser.getId());

            // Redirect back to requested page if available
            String redirectPage = (String) session.getAttribute("redirectAfterLogin");
            if (redirectPage != null) {
                session.removeAttribute("redirectAfterLogin");
                return "redirect:" + redirectPage;
            }

            return "redirect:/";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "login";
        }
    }


    // ✅ Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    
    
    
    
    
    
    
    
}
