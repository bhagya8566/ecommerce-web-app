<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>${category.name} Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- BOOTSTRAP ICONS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        /* ===========================
           PRODUCT CARD STYLING
        =========================== */
        .card.shadow-sm {
            background: #111 !important;
            border-radius: 16px !important;
            transition: .3s;
            box-shadow: 0 0 10px rgba(255,218,68,0.15);
        }

        .card.shadow-sm:hover {
            transform: translateY(-6px);
            box-shadow: 0 0 18px #ffda44;
        }

        .card .rating-star {
            color: #ffda44 !important;
        }

        .card .btn {
            background: #000 !important;
            color: #fff !important;
            border: 1px solid #333 !important;
            transition: .3s ease-in-out;
            border-radius: 10px !important;
        }

        .card .btn-success:hover {
            box-shadow: 0 0 12px #00ff66;
            border-color: #00ff66 !important;
            transform: translateY(-3px);
        }

        .card .btn-primary:hover {
            box-shadow: 0 0 12px #ffda44;
            border-color: #ffda44 !important;
            transform: translateY(-3px);
        }

        .card h5, .card p {
            color: #fff !important;
        }
        .card p.fw-bold {
            color: #00ff66 !important;
        }

        /* ===========================
           CAROUSEL STYLING
        =========================== */
        .carousel-inner img {
            border-radius: 16px;
            height: 380px;
            object-fit: cover;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            filter: invert(100%);
        }
         /* STAR */
       /* Empty star */
.rating-star {
    color: #ffda44; /* Filled stars */
}

.empty-star {
    color: transparent;              /* Empty inside */
    -webkit-text-stroke: 1px #ffda44; /* Yellow outline */
    text-stroke: 1px #ffda44;
}

       
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="container mt-3">
    <!-- ========================
         CAROUSEL
    ======================== -->
   <div id="categoryCarousel" class="carousel slide rounded mb-4" data-bs-ride="carousel">
    <div class="carousel-inner">

        <div class="carousel-item active">
            <img src="${pageContext.request.contextPath}/assets/images/man.jpg" class="d-block w-100">
        </div>

        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/assets/images/bannerj.jpg" class="d-block w-100">
        </div>

        <div class="carousel-item">
            <img src="${pageContext.request.contextPath}/assets/images/man.jpg" class="d-block w-100">
        </div>

    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#categoryCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>

    <button class="carousel-control-next" type="button" data-bs-target="#categoryCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>
   
    <!-- ========================
         CATEGORY TITLE & DESCRIPTION
    ======================== -->
    <h3 class="text-warning">${category.name}</h3>
    <p class="text-muted">${category.description}</p>

    <!-- ========================
         PRODUCT CARDS
    ======================== -->
    <div class="row">
        <c:forEach var="p" items="${products}">
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm">
                    <img src="${p.imagePath}" class="card-img-top" style="height:250px; object-fit:contain;">
                    <div class="card-body">
                        <h5>${p.name}</h5>
                        <p class="fw-bold">₹${p.price}</p>

                    <!-- RATING -->
                   <div class="mb-3">
    <c:set var="avg" value="${ratingMap[p.id]}" />
    <c:forEach begin="1" end="5" var="i">
        <i class="bi ${i <= avg ? 'bi-star-fill rating-star' : 'bi-star empty-star'}"></i>
    </c:forEach>
</div>
                   

                        <!-- BUTTONS -->
                        <div class="d-flex gap-2">
                            <a href="/product/${p.id}" class="btn btn-primary btn-sm w-50 text-center">
                                View
                            </a>

                            <form method="post"
                                  action="${pageContext.request.contextPath}/cart/add"
                                  class="w-50">
                                <input type="hidden" name="productId" value="${p.id}" />
                                <input type="hidden" name="qty" value="1" />

                                <button type="submit" class="btn btn-success btn-sm w-100">
                                    <i class="bi bi-cart-plus"></i> Add
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
