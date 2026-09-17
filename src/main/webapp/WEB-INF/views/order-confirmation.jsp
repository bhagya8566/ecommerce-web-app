<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html>
<head>
  <title>Order Confirmed</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="/assets/css/site.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp"/>

<div class="container mt-4">
  <h3>Order Placed</h3>

  <!-- EMAIL MESSAGE -->
  <c:if test="${not empty emailSuccess}">
      <div class="alert alert-success mt-2">${emailSuccess}</div>
  </c:if>

  <c:if test="${not empty emailError}">
      <div class="alert alert-danger mt-2">${emailError}</div>
  </c:if>

  <p>Thank you! Your order #${order.id} has been placed.</p>

  <p>
      <strong>Total Amount:</strong> ₹${order.totalAmount}
  </p>

  <c:if test="${order.payableAmount != null}">
      <p>
          <strong>Discounted / Payable Amount:</strong>
          <span class="text-success">₹${order.payableAmount}</span>
      </p>
  </c:if>


  <a class="btn btn-primary" href="/order/invoice/${order.id}">Download Invoice (PDF)</a>
  <a class="btn btn-link" href="/">Continue Shopping</a>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>

</body>
</html>