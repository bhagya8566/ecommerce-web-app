<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
google.charts.load('current', {'packages':['corechart','bar']});
google.charts.setOnLoadCallback(drawCharts);

function drawCharts() {

    // ------- PIE CHART ------- 
    var productData = google.visualization.arrayToDataTable([
        ['Category', 'Products'],
        <c:forEach var="entry" items="${productData}">
            ['${entry.key}', ${entry.value}],
        </c:forEach>
    ]);

    var pieOptions = {
        title: 'Category-wise Product Distribution',
        width: 500,
        height: 350
    };

    var pieChart = new google.visualization.PieChart(document.getElementById('productPie'));
    pieChart.draw(productData, pieOptions);

    // ------- BAR CHART ------- 
    var orderData = google.visualization.arrayToDataTable([
        ['Category', 'Orders'],
        <c:forEach var="entry" items="${orderData}">
            ['${entry.key}', ${entry.value}],
        </c:forEach>
    ]);

    var barOptions = {
        title: 'Category-wise Orders',
        width: 500,
        height: 350,
        bars: 'vertical',
        colors: ['#1b9e77']
    };

    var barChart = new google.charts.Bar(document.getElementById('orderBar'));
    barChart.draw(orderData, google.charts.Bar.convertOptions(barOptions));
}
</script>

</head>
<body class="bg-light">
<jsp:include page="admin-navbar.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">Admin Dashboard</h2>

    <!-- Summary Cards -->
    <div class="row mb-4">

        <div class="col-md-3">
            <div class="p-3 bg-white shadow rounded text-center">
                <h5>Total Products</h5>
                <h3>${products}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="p-3 bg-white shadow rounded text-center">
                <h5>Total Categories</h5>
                <h3>${categories}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="p-3 bg-white shadow rounded text-center">
                <h5>Total Orders</h5>
                <h3>${orders}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="p-3 bg-white shadow rounded text-center">
                <h5>Total Users</h5>
                <h3>${users}</h3>
            </div>
        </div>

    </div>

    <!-- Charts -->
    <div class="row">

        <div class="col-md-6 text-center">
            <h5>Category-wise Products</h5>
            <div id="productPie"></div>
        </div>

        <div class="col-md-6 text-center">
            <h5>Category-wise Orders</h5>
            <div id="orderBar"></div>
        </div>

    </div>

    <!-- Detailed Table -->
    <hr class="my-4">

    <h4 class="mt-4">📊 Detailed Category Insights</h4>

    <div class="table-responsive">
    <table class="table table-bordered table-hover mt-3">
        <thead class="table-dark">
            <tr>
                <th>Category</th>
                <th>Total Products</th>
                <th>Total Orders</th>
                <th>Total Stock</th>
                <th>Low Stock (&lt;5)</th>
                <th>Out of Stock</th>
                <th>Most Expensive Product</th>
                <th>Least Expensive Product</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="row" items="${categoryDetails}">
                <tr>
                    <td>${row.category}</td>
                    <td>${row.totalProducts}</td>
                    <td>${row.totalOrders}</td>
                    <td>${row.totalStock}</td>
                    <td class="text-warning fw-bold">${row.lowStock}</td>
                    <td class="text-danger fw-bold">${row.outOfStock}</td>
                    <td>${row.maxProduct}</td>
                    <td>${row.minProduct}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>

</div>

</body>
</html>
