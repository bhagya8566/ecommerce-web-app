<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>E-Bazar | Home</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- BOOTSTRAP ICONS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Cinzel:wght@600&display=swap" rel="stylesheet">

    <style>
         a {
            text-decoration: none !important;
             }
    
        /* GLOBAL */
        body {
            background: #000 !important;
            color: #fff !important;
            font-family: 'Poppins', sans-serif;
        }

        h4, h3 {
            font-family: 'Cinzel', serif;
            color: #ffda44;
            text-shadow: 0 0 8px #ffda44;
            letter-spacing: 2px;
        }

        /* CATEGORY BOX */
        .cat-box {
            background: #111;
            border-radius: 14px;
            transition: .3s;
            height: 130px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-shadow: 0 0 8px rgba(255,218,68,0.2);
        }
        .cat-box:hover {
            background: #151515;
            transform: scale(1.07);
            box-shadow: 0 0 14px #ffda44;
        }

        .cat-icon {
            font-size: 42px;
            color: #ffda44;
            text-shadow: 0 0 6px #ffda44;
        }

        .cat-label {
            margin-top: 5px;
            font-weight: bold;
            color: white !important;
        }

        /* PRODUCT CARD */
        .product-card {
            background: #111 !important;
            border-radius: 16px !important;
            transition: .3s;
            box-shadow: 0 0 10px rgba(255,218,68,0.15);
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 0 18px #ffda44;
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

        /* BUTTONS */
        .btn-dark-action {
            background: #000 !important;
            color: #fff !important;
            border: 1px solid #333 !important;
            transition: .3s ease-in-out;
            border-radius: 10px !important;
        }

        /* ADD = GREEN GLOW */
        .btn-add:hover {
            box-shadow: 0 0 12px #00ff66;
            border-color: #00ff66 !important;
            transform: translateY(-3px);
        }

        /* VIEW = GOLD GLOW */
        .btn-view:hover {
            box-shadow: 0 0 12px #ffda44;
            border-color: #ffda44 !important;
            transform: translateY(-3px);
        }

        /* CAROUSEL */
        .carousel-inner img {
            border-radius: 16px;
            height: 400px;
            object-fit: cover;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            filter: invert(100%);
        }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<!-- ======================== -->
<!-- CAROUSEL BELOW HEADER -->
<!-- ======================== -->

<div id="homeCarousel" class="carousel slide mt-3 container" data-bs-ride="carousel">

    <div class="carousel-inner rounded">

        <div class="carousel-item active">
            <img src="assets/images/banner1.jpg" class="d-block w-100">
        </div>

        <div class="carousel-item">
            <img src="assets/images/banner2.jpg" class="d-block w-100">
        </div>

        <div class="carousel-item">
            <img src="assets/images/banner3.jpg" class="d-block w-100">
        </div>

    </div>

    <!-- ONLY ARROWS -->
    <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>

    <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>

</div>


<!-- ======================== -->
<!-- SUCCESS & ERROR MESSAGES -->
<!-- ======================== -->

<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success mt-3">
        ${sessionScope.successMessage}
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger mt-3">
        ${sessionScope.errorMessage}
    </div>
    <c:remove var="errorMessage" scope="session"/>
</c:if>


<div class="container mt-4">

<!-- ======================== -->
<!-- SHOP BY CATEGORY -->
<!-- ======================== -->

<c:if test="${empty searchResults}">
    <h4 class="mb-3 text-center">Shop by Category</h4>
</c:if>


<div class="row g-3 mb-4 justify-content-center">

    <c:forEach var="c" items="${categories}">

        <!-- ICON MAP -->
        <c:choose>
            <c:when test="${c.name == 'Electronics'}"><c:set var="icon" value="bi-cpu" /></c:when>
            <c:when test="${c.name == 'Fashion'}"><c:set var="icon" value="bi-bag" /></c:when>
            <c:when test="${c.name == 'Grocery'}"><c:set var="icon" value="bi-basket" /></c:when>
            <c:when test="${c.name == 'Mobile'}"><c:set var="icon" value="bi-phone" /></c:when>
            <c:when test="${c.name == 'Home Appliances'}"><c:set var="icon" value="bi-house" /></c:when>
            <c:otherwise><c:set var="icon" value="bi-tag" /></c:otherwise>
        </c:choose>

        <div class="col-2">
            <a href="/category/${c.id}" class="text-decoration-none">
                <div class="p-3 cat-box">
                    <i class="bi ${icon} cat-icon"></i>
                    <p class="cat-label">${c.name}</p>
                </div>
            </a>
        </div>

    </c:forEach>

</div>


<!-- ======================== -->
<!-- FEATURED PRODUCTS -->
<!-- ======================== -->
<
<h4 class="mt-4">Featured Products</h4>

<div class="row mt-3">

    <c:forEach var="p" items="${products}">

        <div class="col-3 mb-4">
            <div class="card product-card">

                <img src="${p.imagePath}" class="card-img-top" style="height:200px; object-fit:contain;">

                <div class="card-body">

                    <h6 class="fw-bold text-white">${p.name}</h6>

                    <p class="fw-bold text-success">₹${p.price}</p>
    
                    <!-- RATING -->
                   <div class="mb-3">
    <c:set var="avg" value="${ratingMap[p.id]}" />
    <c:forEach begin="1" end="5" var="i">
        <i class="bi ${i <= avg ? 'bi-star-fill rating-star' : 'bi-star empty-star'}"></i>
    </c:forEach>
</div>
                   
                    <!-- BUTTONS -->
                    <div class="d-flex gap-2 mt-3">

                        <form method="post"
                              action="${pageContext.request.contextPath}/cart/add"
                              class="w-50">
                            <input type="hidden" name="productId" value="${p.id}" />
                            <input type="hidden" name="qty" value="1" />

                            <button type="submit" class="btn-dark-action btn-add btn-sm w-100">
                                 Add
                            </button>
                        </form>

                        <a href="${pageContext.request.contextPath}/product/${p.id}"
                           class="btn-dark-action btn-view btn-sm w-50 text-center">
                            View
                        </a>

                    </div>

                </div>
            </div>
        </div>

    </c:forEach>

</div>


<!-- ======================== -->
<!-- SEARCH RESULTS -->
<!-- ======================== -->

<c:if test="${not empty message}">
    <div class="alert alert-warning text-center mt-3">${message}</div>
</c:if>

<c:if test="${not empty searchResults}">
    <h3 class="text-center mt-4">Search results for:
        <span class="text-success">${query}</span>
    </h3>

    <div class="row mt-4">
        <c:forEach var="p" items="${searchResults}">
            <div class="col-md-3 mb-3">
                <div class="card product-card p-2">

                    <img src="${p.imagePath}" class="card-img-top" style="height:200px; object-fit:contain;">
                    <h5 class="mt-2 text-white">${p.name}</h5>
                    <p class="text-muted">₹${p.price}</p>

                    <div class="d-flex gap-2 mt-3">

                        <form method="post"
                              action="${pageContext.request.contextPath}/cart/add"
                              class="w-50">
                            <input type="hidden" name="productId" value="${p.id}" />
                            <input type="hidden" name="qty" value="1" />

                            <button type="submit" class="btn-dark-action btn-add btn-sm w-100">
                                <i class="bi bi-cart-plus"></i> Add
                            </button>
                        </form>

                        <a href="${pageContext.request.contextPath}/product/${p.id}"
                           class="btn-dark-action btn-view btn-sm w-50 text-center">
                            View
                        </a>

                    </div>

                </div>
            </div>
        </c:forEach>
    </div>
</c:if>

</div>


<!-- ======================== -->
<!-- AUTO-SUGGEST SCRIPT -->
<!-- ======================== -->

<script>
const box = document.getElementById("searchBox");
const suggestions = document.getElementById("suggestions");

if (box) {
    box.addEventListener("keyup", function () {
        let keyword = this.value;

        if (keyword.length === 0) {
            suggestions.innerHTML = "";
            return;
        }

        fetch("/search/suggest?keyword=" + keyword)
            .then(res => res.json())
            .then(data => {
                suggestions.innerHTML = "";

                data.forEach(item => {
                    let li = document.createElement("li");
                    li.classList.add("list-group-item");
                    li.style.cursor = "pointer";
                    li.innerText = item;

                    li.onclick = () => {
                        box.value = item;
                        suggestions.innerHTML = "";
                    };

                    suggestions.appendChild(li);
                });
            })
    });
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
