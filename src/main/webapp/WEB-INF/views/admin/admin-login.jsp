<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 450px;">
    <h3 class="text-center mb-4">Admin Login</h3>

    <c:if test="${not empty error}">
        <p class="alert alert-danger">${error}</p>
    </c:if>

    <!-- Correct action -->
    <form action="/admin/auth/login" method="post">

        <div class="mb-3">
            <label>Email</label>
            <!-- Name must be 'email' -->
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <!-- Name must be 'password' -->
            <input type="password" name="password" class="form-control" required>
        </div>

        <button class="btn btn-primary w-100">Login</button>

    </form>

</div>

</body>
</html>
