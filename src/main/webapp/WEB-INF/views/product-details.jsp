<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html>
<head>
  <title>${product.name}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
  <style>
    /* Apply white text globally */
    body, p, h1, h2, h3, h4, h5, h6, label, small, span {
        color: #fff !important;
    }

    /* Luxury font for product name */
    h3 {
        font-family: 'Playfair Display', serif;
        font-weight: 700;
        color: #fff;
    }

    /* Optional: rating stars color */
    .text-warning {
        color: #d4af37 !important;
    }

    /* Make alerts dark with white text for luxury theme */
    .alert-danger {
        background-color: #111;
        border: 2px solid #d4af37;
        color: #fff;
    }

    /* Luxury styling for input/textarea borders */
    input.form-control, textarea.form-control {
        background-color: #111;
        color: #fff;
        border: 1px solid #d4af37;
    }

    input.form-control::placeholder, textarea.form-control::placeholder {
        color: rgba(212, 175, 55, 0.6);
    }

    input.form-control:focus, textarea.form-control:focus {
        border-color: #d4af37;
        box-shadow: 0 0 8px rgba(212,175,55,0.5);
        outline: none;
    }

    /* Buttons */
    .btn-success, .btn-primary, .btn-secondary {
        border-radius: 0.5rem;
    }

    .btn-success {
        background-color: #d4af37;
        color: #000;
        border: 2px solid #d4af37;
    }

    .btn-success:hover {
        background-color: #b5952c;
        color: #000;
    }

    .btn-primary {
        background-color: #d4af37;
        border: 2px solid #d4af37;
        color: #000;
    }

    .btn-primary:hover {
        background-color: #b5952c;
        color: #000;
    }

    .btn-secondary {
        background-color: #555;
        color: #fff;
    }

    /* Card / review boxes */
    .border, .card {
        background-color: #111;
        border-color: #d4af37 !important;
        color: #fff;
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp"/>

<div class="container mt-4">

  <div class="row">
    <div class="col-md-6">
      <img src="${product.imagePath != null ? product.imagePath : '/assets/images/no-image.png'}"
           class="img-fluid" alt="${product.name}">
    </div>

    <div class="col-md-6">
      <h3>
        ${product.name}

        <c:if test="${averageRating > 0}">
          <span class="text-warning">
            <c:forEach var="i" begin="1" end="5">
              <c:choose>
                <c:when test="${i <= averageRating}">⭐</c:when>
                <c:otherwise>☆</c:otherwise>
              </c:choose>
            </c:forEach>
            (<fmt:formatNumber value="${averageRating}" maxFractionDigits="1" /> / 5)
          </span>
        </c:if>
      </h3>

      <p class="fw-bold">₹${product.price}</p>
      <p>${product.description}</p>

      <!-- ⭐ OUT OF STOCK MESSAGE -->
      <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger">
          ${sessionScope.errorMessage}
        </div>
        <c:remove var="errorMessage" scope="session"/>
      </c:if>

      <!-- Add to Cart Form -->
      <form method="post" action="/cart/add">
        <input type="hidden" name="productId" value="${product.id}" />
        <div class="mb-2">
          <label>Quantity</label>
          <input type="number" name="qty" value="1" class="form-control" style="width:100px;">
        </div>

        <c:choose>
          <c:when test="${product.stock <= 0}">
            <button class="btn btn-secondary" disabled>Out of Stock</button>
          </c:when>
          <c:otherwise>
            <button class="btn btn-success">Add to Cart</button>
          </c:otherwise>
        </c:choose>
      </form>

    </div>
  </div>

  <!-- ⭐ Customer Reviews -->
  <div class="mt-5">
    <h4>Customer Reviews</h4>

    <c:if test="${empty reviews}">
      <p>No reviews yet. Be the first to review this product!</p>
    </c:if>

    <c:forEach var="r" items="${reviews}">
      <div class="border p-2 rounded mb-2">
        <strong>⭐ ${r.rating} / 5</strong> <br>
        <p>${r.comment}</p>
        <small class="text-muted">
          Posted on 
          <fmt:formatDate value="${r.createdAtDate}" pattern="dd-MM-yyyy HH:mm"/>
        </small>
      </div>
    </c:forEach>

    <!-- Review Form -->
    <form method="post" action="/product/${product.id}/review" class="mt-4">
      <h5>Leave a Review</h5>

      <div class="mb-2">
        <label>Rating (1–5):</label>
        <input type="number" name="rating" min="1" max="5" required class="form-control" style="width:100px;">
      </div>

      <div class="mb-2">
        <label>Comment:</label>
        <textarea name="comment" class="form-control" rows="3" required></textarea>
      </div>

      <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
  </div>

</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>

</body>
</html>
