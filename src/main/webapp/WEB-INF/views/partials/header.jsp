<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.ebazar.E_Bazar.model.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>E-Bazar</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* ====== LUXURY NAVBAR THEME WITH GRADIENT + SMOOTH HOVER ====== */

body {
    background: #000 !important;
    margin: 0;
    padding: 0;
}

/* Navbar gradient black */
.navbar {
    background: linear-gradient(to right, #000000, #0a0a0a, #000000) !important;
    padding: 12px 0;
    box-shadow: 0 0 14px rgba(255,218,68,0.08);
    border-bottom: 1px solid rgba(255,218,68,0.15);
}

/* Flex alignment */
.navbar .container,
.navbar-nav .nav-item,
.nav-link {
    display: flex;
    align-items: center;
}

/* BRAND + LOGO */
.navbar-brand {
    font-family: 'Cinzel', serif;
    font-size: 1.6rem;
    font-weight: 700;
    color: #ffda44 !important;
    display: flex;
    align-items: center;
    gap: 10px;
    transition: 0.4s ease; /* smooth fade */
}

/* Logo */
.navbar-brand img {
    height: 55px;
    width: auto;
    object-fit: contain;
    filter: drop-shadow(0 0 6px rgba(255,218,68,0.4));
    transition: 0.4s ease;
}

.navbar-brand:hover img {
    filter: drop-shadow(0 0 10px rgba(255,218,68,0.7));
}

.navbar-brand:hover {
    color: #ffffff !important;
    text-shadow: 0 0 8px rgba(255,218,68,0.55);
    transform: scale(1.03);
}

/* Nav links default */
.nav-link {
    font-family: 'Cinzel', serif;
    font-size: 1rem;
    color: #ffffff !important;
    padding: 8px 16px !important;
    transition: all 0.35s ease; /* slow fade */
}

/* SOFT GOLD HOVER – NO UNDERLINE */
.nav-link:hover {
    color: #ffda44 !important;
    text-shadow: 0 0 6px rgba(255,218,68,0.6);
    transform: translateY(-1px); /* smooth hover lift */
}

/* Remove underline highlight */
.nav-link::after {
    display: none !important;
}

/* Search box */
#searchBox {
    background: #111 !important;
    border: 1px solid rgba(255,218,68,0.5) !important;
    color: #ffda44 !important;
    padding: 7px 12px;
    border-radius: 8px;
    font-family: 'Cinzel', serif;
    transition: 0.3s ease-in-out;
}

#searchBox:focus {
    box-shadow: 0 0 9px rgba(255,218,68,0.8);
    outline: none;
}

/* Suggestions */
#suggestions {
    background: #000;
    border: 1px solid rgba(255,218,68,0.4);
    border-radius: 8px;
}

#suggestions .list-group-item {
    background: #000;
    color: white;
    font-family: 'Cinzel', serif;
    transition: 0.3s;
}

#suggestions .list-group-item:hover {
    background: #111;
    color: #ffda44;
    text-shadow: 0 0 5px rgba(255,218,68,0.5);
}

/* Username and Logout */
.nav-link.text-success strong {
    color: #ffda44 !important;
    text-shadow: 0 0 6px rgba(255,218,68,0.6);
}

.nav-link.text-danger:hover {
    color: #ff4d4d !important;
    text-shadow: 0 0 6px rgba(255,80,80,0.7);
}

/* Toggler */
.navbar-toggler {
    border-color: #ffda44 !important;
}

.navbar-toggler-icon {
    filter: brightness(180%);
}

</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">
 <div class="container">

  <!-- BRAND + LOGO -->
  <a class="navbar-brand" href="/">
      <img src="/assets/images/logo.png" alt="Logo">
      Home
  </a>

  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navmenu">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <!-- SEARCH BOX -->
  <form action="/search" method="get" class="d-flex me-3">
      <input type="text" id="searchBox" name="query" class="form-control" placeholder="Search products..." autocomplete="off">
  </form>

  <ul id="suggestions" class="list-group position-absolute" style="z-index: 999;"></ul>

  <div class="collapse navbar-collapse" id="navmenu">
    <ul class="navbar-nav ms-auto">

      <!-- Normal User Links -->
      <li class="nav-item">
  <a class="nav-link" href="/cart/view">
    Cart 
    <span class="badge bg-danger ms-1">
      <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %>
    </span>
  </a>
</li>
      <li class="nav-item"><a class="nav-link" href="/order/checkout">Checkout</a></li>
      <li class="nav-item"><a class="nav-link" href="/order/history">My Orders</a></li>

      <% User loggedUser = (User) session.getAttribute("loggedUser");
         if (loggedUser != null) { %>

        <li class="nav-item">
          <a class="nav-link text-success">hi, <strong><%= loggedUser.getName() %></strong></a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-danger" href="/logout">Logout</a>
        </li>

      <% } else { %>

        <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
        <li class="nav-item"><a class="nav-link" href="/register">Register</a></li>

      <% } %>

    </ul>
  </div>

 </div>
</nav>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html> 