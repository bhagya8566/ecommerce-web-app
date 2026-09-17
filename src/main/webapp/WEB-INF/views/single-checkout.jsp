<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Single Checkout | E-Bazar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="text-center mb-4">🧾 Confirm Your Purchase</h3>

    <div class="card mx-auto shadow-sm" style="max-width: 500px;">
        <div class="card-body text-center">
            <h5 class="card-title">${singleItem.product.name}</h5>
            <p>Quantity: <strong>${singleItem.quantity}</strong></p>
            <p>Price: ₹${singleItem.product.price}</p>
            <p>Total: <strong>₹${singleItem.product.price * singleItem.quantity}</strong></p>

            <!-- ERROR ALERT -->
            <c:if test="${not empty emailError}">
                <div class="alert alert-danger">
                    ${emailError}
                    <form action="${pageContext.request.contextPath}/order/single-checkout" method="get" style="display:inline;">
                        <input type="hidden" name="cartId" value="${singleItem.id}">
                        <button type="submit" class="btn btn-warning btn-sm ms-2">Try Again</button>
                    </form>
                </div>
            </c:if>

            <!-- SUCCESS ALERT -->
            <c:if test="${not empty emailSuccess}">
                <div class="alert alert-success">
                    ${emailSuccess}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/order/place-single">
                <input type="hidden" name="cartId" value="${singleItem.id}">
                <div class="mb-3">
                    <input type="text" name="address" class="form-control" placeholder="Enter delivery address"
                           value="${address != null ? address : ''}" required>
                </div>
                <div class="mb-3">
                    <input type="email" name="email" class="form-control" placeholder="Enter email"
                           value="${email != null ? email : ''}" required>
                </div>
                <div class="mb-3">
                        <label>Have a Coupon?</label>
                      <input type="text" name="couponCode" class="form-control" placeholder="Enter coupon code">

                    </div>
                <button class="btn btn-success w-100">Confirm & Place Order</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
