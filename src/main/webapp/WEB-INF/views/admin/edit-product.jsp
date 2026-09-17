<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="admin-navbar.jsp"/>

<div class="container mt-5 col-md-6">
    <div class="card shadow">
        <div class="card-header bg-warning">
            <h4>Edit Product</h4>
        </div>

        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/update-product" method="post" enctype="multipart/form-data">

                <input type="hidden" name="id" value="${product.id}"/>

                <div class="mb-3">
                    <label class="form-label">Product Name</label>
                    <input type="text" class="form-control" name="name" value="${product.name}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="description" required>${product.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="number" class="form-control" name="price" value="${product.price}" required min="0">
                </div>

                <div class="mb-3">
                    <label class="form-label">Stock</label>
                    <input type="number" class="form-control" name="stock" value="${product.stock}" required min="0">
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select class="form-control" name="categoryId">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${product.category.id == cat.id ? 'selected' : ''}>
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Current Image</label><br>
                    <img src="${product.imagePath}" width="120" class="img-thumbnail mb-2">

                    <input type="file" class="form-control" name="imageFile">
                </div>

                <button class="btn btn-warning">Update Product</button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Back</a>

            </form>
        </div>
    </div>
</div>

</body>
</html>
