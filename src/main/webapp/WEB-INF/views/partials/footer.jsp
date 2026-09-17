<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>      

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Luxury Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600&family=Cormorant+Garamond:wght@300;400;500&display=swap" rel="stylesheet">

<style>
    footer {
        background-color: #0d0d0d;
        color: #fff;
        font-family: "Cinzel", serif;
        letter-spacing: 0.5px;
    }

    footer h5 {
        color: #ffda44;
        font-weight: 600;
        margin-bottom: 15px;
    }

    /* PREMIUM LUXURY DESCRIPTION FONT */
    .footer-desc {
        font-family: "Cormorant Garamond", serif !important;
        font-size: 1.05rem;
        line-height: 1.5;
        color: #d6d6d6;
        letter-spacing: 0.3px;
    }

    footer a {
        color: #ffda44;
        text-decoration: none;
        font-family: "Cinzel", serif;
    }

    footer a:hover {
        color: white;
        text-shadow: 0 0 8px #ffda44;
    }

    .footer-logo img {
        height: 55px;
        margin-bottom: 10px;
        border-radius: 5px;
    }

    .footer-contact i {
        color: #ffda44;
        margin-right: 8px;
    }

    .footer-social a {
        font-size: 1.3rem;
        margin-right: 12px;
        transition: 0.3s;
    }

    .footer-social a:hover {
        transform: scale(1.12);
    }
</style>
</head>

<body>

<footer class="py-5">
    <div class="container text-center text-md-start">
        <div class="row">

            <!-- Logo + About -->
            <div class="col-md-4 mb-4 footer-logo">
                <img src="/assets/images/logo.png" alt="E-Bazar Logo">
                <p class="mt-3 footer-desc">
                    LuxeVera – Bringing luxury, quality, and style to your online shopping experience.  
                    Explore categories from Fashion, Electronics, Grocery & more.
                </p>
            </div>

            <!-- About Us Section -->
            <div class="col-md-4 mb-4">
                <h5>About Us</h5>
                <p class="footer-desc">
                    We are committed to offering premium products at the best value.  
                    Our goal is to deliver a seamless, elegant shopping experience  
                    with trusted quality and fast service.
                </p>
            </div>

            <!-- Contact Info -->
            <div class="col-md-4 mb-4 footer-contact">
                <h5>Contact Us</h5>
                <p class="footer-desc"><i class="bi bi-telephone-fill"></i> +91 7740093933</p>
                <p class="footer-desc"><i class="bi bi-envelope-fill"></i> support@LuxeVera.com</p>
                <p class="footer-desc"><i class="bi bi-geo-alt-fill"></i> Amritsar Group Of Colleges, India</p>

                <!-- Instagram -->
                <div class="footer-social mt-3">
                    <a href="https://www.instagram.com/luxevera_?igsh=ZjgyamRjbmpicHJ2" id="instaLink"><i class="bi bi-instagram"></i> Instagram</a>
                </div>
            </div>

        </div>

        <hr class="bg-secondary">

        <div class="text-center pt-3" style="font-family: 'Cinzel', serif;">
            &copy; LuxeVera - 2025. All rights reserved.
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

</body>
</html>