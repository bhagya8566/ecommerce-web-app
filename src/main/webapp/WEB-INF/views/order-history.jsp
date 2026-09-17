<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Order History</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

<style>
    /* PAGE THEME */
    body {
        background-color: #000;
        color: #fff;
        font-family: Arial, sans-serif;
    }

    h2, h4, h5, h6 {
        font-family: 'Playfair Display', serif;
        color: #fff;
    }

    /* CARD DESIGN */
    .card {
        background-color: #111;
        color: #fff;
        border-radius: 0.5rem;
        border: 2px solid #d4af37;
    }

    .card h5, .card h6, .card p {
        color: #fff;
    }

    /* TABLE DESIGN */
    .table {
        color: #fff;
        border: 2px solid #d4af37;
    }

    .table thead {
        background-color: #f8f9fa;
        color: #000;
    }

    .table th, .table td {
        border: 1px solid #d4af37 !important;
    }

    .table tbody tr:hover {
        background-color: rgba(212,175,55,0.1);
    }

    /* BADGES */
    .badge {
        font-weight: 600;
        padding: 0.4em 0.6em;
        border-radius: 0.35rem;
    }

    /* CANCEL BUTTON */
    .btn-cancel {
        background-color: #fff;
        color: #000;
        border: 2px solid red;
        transition: box-shadow 0.3s ease;
    }

    .btn-cancel:hover {
        box-shadow: 0 0 8px red;
    }

    /* LAYOUT / SPACING */
    .container {
        margin-top: 3rem; /* mt-5 */
    }

    h2, h4 {
        margin-bottom: 1.5rem; /* mb-4 */
        margin-top: 1.5rem; /* mt-4 */
        text-align: center;
    }

    .card.mt-4 {
        margin-top: 1.5rem;
    }

    table.mt-2 {
        margin-top: 0.5rem;
    }

    .alert {
        background-color: #111;
        color: #fff;
        border: 2px solid #d4af37;
    }

</style>
</head>
<body>

<div class="container">
    <h2> Your Order History</h2>

    <div class="card p-3 mt-3 shadow-sm">
        <h5><strong>Name:</strong> ${user.name}</h5>
        <h6><strong>Email:</strong> ${user.email}</h6>
        <p><strong>Address:</strong> ${user.address}</p>
        <p><strong>Phone:</strong> ${user.phone}</p>
    </div>

    <h4> Orders:</h4>

    <c:if test="${empty orders}">
        <div class="alert mt-3">No orders yet.</div>
    </c:if>

    <c:forEach var="order" items="${orders}">
        <div class="card mt-4 p-3 shadow-sm">
            <h5>Order #${order.id}</h5>
            <p><strong>Status:</strong> 
                <span class="badge 
                    ${order.status == 'CANCELLED' ? 'bg-danger' :
                      order.status == 'DELIVERED' ? 'bg-success' : 'bg-warning text-dark'}">
                    ${order.status}
                </span>
            </p>
            <p><strong>Date:</strong> ${order.orderDate}</p>
            <p><strong>Total:</strong> ₹${order.totalAmount}</p>
            <c:if test="${order.payableAmount != null}">
               <p>
                   <strong>Payable After Discount:</strong>
                   <span class="text-success">₹${order.payableAmount}</span>
               </p>
           </c:if>

            <table class="table table-bordered mt-2">
                <thead>
                    <tr><th>Product</th><th>Qty</th><th>Price</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td>${item.product.name}</td>
                            <td>${item.quantity}</td>
                            <td>₹${item.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 🔘 Buttons for Cancel and Track -->
            <div class="mt-3">
                <c:if test="${order.status == 'PLACED'}">
                    <form action="/order/cancel/${order.id}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-sm btn-cancel">Cancel Order</button>
                    </form>
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>
