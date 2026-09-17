<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="admin-navbar.jsp"/>


<div class="container mt-4">

    <h2 class="mb-3">Products List</h2>

    <a href="${pageContext.request.contextPath}/admin/add-product" class="btn btn-primary mb-3">
        + Add New Product
    </a>

    <!-- Error Alert -->
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Error: </strong> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Success Alert -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <strong>Success: </strong> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <table class="table table-bordered table-hover bg-white shadow">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price (₹)</th>
                <th>Stock</th>
                <th>Image</th>
                <th width="180">Actions</th>
            </tr>
        </thead>

        <tbody>
        <c:forEach var="p" items="${products}">
            <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>${p.category.name}</td>
                <td>${p.price}</td>
                <td>${p.stock}</td>
                <td>
                    <img src="${p.imagePath}" width="70" class="img-thumbnail">
                </td>

                <td>
                    <a href="${pageContext.request.contextPath}/admin/edit-product/${p.id}" 
                       class="btn btn-warning btn-sm">
                        Edit
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/delete/${p.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this product?')">
                        Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>

    </table>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
