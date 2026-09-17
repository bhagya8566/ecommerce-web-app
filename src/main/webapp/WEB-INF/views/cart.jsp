<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <title>Cart</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>

    /* FULL BLACK PAGE */
    body {
        background: #000 !important;
        color: #fff !important;
        font-family: 'Poppins', sans-serif;
    }

    /* Luxury Heading Fix */
    h3 {
        font-family: 'Playfair Display', serif !important;
        font-size: 36px !important;
        font-weight: 700 !important;
        text-align: center !important;
        margin-bottom: 40px !important;
        color: #ffffff !important;
        text-shadow: 1px 1px 4px rgba(0,0,0,0.7) !important;
    }

    /* TABLE THEME (white table, black text) */
    .table {
        background: #fff !important;
        color: #000 !important;
    }

    .table th,
    .table td {
        background: #fff !important;
        color: #000 !important;
    }

    /* Remove table hover glow */
    .table tbody tr:hover {
        background: #f2f2f2 !important;
    }

    /* QUANTITY BUTTONS — ROUND WHITE BACKGROUND + BLACK SYMBOL */
    .quantity-box {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
    }

    .quantity-box button {
        width: 35px;
        height: 35px;
        font-size: 20px;
        font-weight: bold;
        border-radius: 50%;
        background: #fff !important;
        color: #000 !important;
        border: 1px solid #000 !important;
    }

    /* Quantity number */
    .quantity-value {
        width: 50px;
        text-align: center;
        font-weight: bold;
        border: 1px solid #ccc;
        border-radius: 6px;
        padding: 5px 0;
        background: #fff;
        color: #000;
    }

    /* REMOVE BUTTON */
    .custom-remove {
        background: white !important;
        color: black !important;
        border: 2px solid red !important;
        border-radius: 10px;
        padding: 6px 12px;
        font-weight: 600;
    }
    .custom-remove:hover {
        box-shadow: 0 0 10px red !important;
    }

    /* BUY NOW BUTTON */
    .custom-buy {
        background: white !important;
        color: black !important;
        border: 2px solid green !important;
        border-radius: 10px;
        padding: 6px 12px;
        font-weight: 600;
    }
    .custom-buy:hover {
        box-shadow: 0 0 10px green !important;
    }

  </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp"/>

<div class="container mt-5">
  <h3 class="fw-bold mb-4 text-center"> Your Shopping Cart</h3>

  <c:if test="${empty items}">
    <div class="alert alert-info text-center">
      Your cart is empty. <a href="/" class="fw-bold">Continue shopping</a>
    </div>
  </c:if>

  <c:if test="${not empty items}">
    <table class="table table-bordered table-striped align-middle shadow-sm">
      <thead class="table-dark text-center">
        <tr>
          <th>Product</th>
          <th>Quantity</th>
          <th>Price</th>
          <th>Total</th>
          <th>Action</th>
        </tr>
      </thead>

      <tbody class="text-center">

        <c:forEach items="${items}" var="it">
          <tr>

            <td class="fw-semibold">${it.product.name}</td>

            <td>
              <div class="quantity-box">

                <form method="post" action="/cart/update" style="display:inline;">
                  <input type="hidden" name="id" value="${it.id}">
                  <input type="hidden" name="quantity" value="${it.quantity - 1}">
                  <button ${it.quantity <= 1 ? 'disabled' : ''}>−</button>
                </form>

                <div class="quantity-value">${it.quantity}</div>

                <form method="post" action="/cart/update" style="display:inline;">
                  <input type="hidden" name="id" value="${it.id}">
                  <input type="hidden" name="quantity" value="${it.quantity + 1}">
                  <button>+</button>
                </form>

              </div>
            </td>

            <td>₹${it.product.price}</td>
            <td class="fw-bold" style="color:black;">₹${it.product.price * it.quantity}</td>

            <td>
              <div class="d-flex flex-column gap-2">

                <!-- REMOVE BUTTON -->
                <form method="post" action="/cart/remove">
                  <input type="hidden" name="id" value="${it.id}" />
                  <button class="btn btn-sm w-100 custom-remove">Remove</button>
                </form>

                <!-- BUY NOW BUTTON -->
                <form method="get" action="/order/single-checkout">
                  <input type="hidden" name="cartId" value="${it.id}" />
                  <button class="btn btn-sm w-100 custom-buy">Buy Now</button>
                </form>

              </div>
            </td>

          </tr>
        </c:forEach>

      </tbody>
    </table>

    <div class="text-end mt-4">
      <a href="/order/checkout" class="btn btn-lg btn-primary px-4">Proceed to Checkout →</a>
    </div>

  </c:if>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp"/>

</body>
</html>
