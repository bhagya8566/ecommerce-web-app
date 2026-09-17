<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <title>Checkout</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="/assets/css/site.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
  <style>
    /* Page background */
    body {
        background-color: #000;
        color: #fff;
        font-family: Arial, sans-serif;
    }

    /* Checkout heading: white + luxury font */
    .container h3 {
        font-family: 'Playfair Display', serif !important;
        font-weight: 700;
        color: #fff !important;
    }

    /* Make all text white globally */
    p, label, option, textarea, input, select, small {
        color: #fff !important;
    }

    /* Form controls */
    textarea.form-control, input.form-control, select.form-select {
        background-color: #111;
        color: #fff;
        border: 1px solid #444;
        border-radius: 0.25rem;
    }

    textarea.form-control::placeholder,
    input.form-control::placeholder {
        color: rgba(255,255,255,0.5);
    }

    textarea.form-control:focus,
    input.form-control:focus,
    select.form-select:focus {
        border-color: #888;
        box-shadow: 0 0 6px rgba(255,255,255,0.2);
        outline: none;
    }

    /* Alerts */
    .alert-danger {
        background-color: #111;
        border: 1px solid #444;
        color: #fff;
    }

    /* Buttons */
    .btn-success {
        background-color: #d4af37; /* luxury gold */
        color: #000;
        border: none;
        border-radius: 0.25rem;
        transition: background-color 0.3s, transform 0.2s;
    }

    .btn-success:hover {
        background-color: #b5952c;
        color: #000;
        transform: scale(1.03);
    }

    .btn-secondary {
        background-color: #333;
        color: #fff;
        border: none;
    }

    /* Client-side error message */
    #clientEmailError {
        color: red;
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp"/>

<div class="container mt-4">
  <h3>Checkout</h3>
    <h4 class="text-end mt-4">Total Payable Amount: 
    <span style="color: green; font-weight: bold;">
        ₹ <c:out value="${totalAmount}"/>
    </span>
     </h4>
  <c:if test="${not empty emailError}">
      <div class="alert alert-danger">${emailError}</div>
  </c:if>

  <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
  </c:if>

  <form method="post" action="/order/place" onsubmit="return validateEmailClient()">
    <div class="mb-3">
      <label>Shipping Address</label>
      <textarea name="address" class="form-control" required></textarea>
    </div>
    <div class="mb-3">
      <label>Email</label>
      <input id="email" type="email" name="email" class="form-control" required/>
      <div id="clientEmailError" style="display:none;margin-top:8px;">❌ Please enter a valid email format.</div>
      
    </div>
    <div class="mb-3">
      <label>Have a Coupon?</label>
      <input type="text" name="couponCode" class="form-control" placeholder="Enter coupon code">

    </div>

    <!-- Dummy payment simulation -->
    <div class="mb-3">
      <label>Payment Method</label>
      <select class="form-select" name="paymentMethod">
        <option>UPI (Dummy)</option>
        <option>Card (Dummy)</option>
      </select>
    </div>

    <button type="submit" class="btn btn-success">Place Order</button>
  </form>
</div>

<script>
function validateEmailClient() {
    const email = document.getElementById('email').value.trim();
    const pattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
    if (!pattern.test(email)) {
        document.getElementById('clientEmailError').style.display = 'block';
        return false;
    }
    return true;
}
</script>

<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>
</body>
</html>
