<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<jsp:include page="admin-navbar.jsp"/>


<div class="container mt-5 col-md-6">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>Add New Product</h4>
        </div>

        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/save-product" method="post" enctype="multipart/form-data">

                <div class="mb-3">
                    <label class="form-label">Product Name</label>
                    <input type="text" class="form-control" name="name" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" required></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="number" class="form-control" name="price" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Stock</label>
                    <input type="number" class="form-control" name="stock" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select class="form-control" name="categoryId" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}">${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Product Image</label>
                    <input type="file" class="form-control" name="imageFile">
                </div>

                <button class="btn btn-success">Save Product</button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Back</a>
            </form>
        </div>
    </div>
</div>

</body>
</html>
