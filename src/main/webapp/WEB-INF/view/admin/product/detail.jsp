<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- <link href="/css/demo.css" rel="stylesheet"> -->
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Quản lý sản phẩm</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Sản phẩm</li>
                    </ol>
                    <div>

                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between">
                                    <h2> Thông tin sản phẩm với mã ID là ${product.id} </h2>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-6 col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                Thông tin sản phẩm
                                            </div>
                                            <ul class="list-group list-group-flush">
                                                <li class="list-group-item">ID: ${product.id}</li>
                                                <li class="list-group-item">Tên: ${product.name}</li>
                                                <li class="list-group-item">
                                                    Giá: <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2" value="${product.price}" />
                                                </li>
                                                <li class="list-group-item">Mô tả chi tiết: ${product.detailDesc}</li>
                                                <li class="list-group-item">Mô tả ngắn: ${product.shortDesc}</li>
                                                <li class="list-group-item">Số lượng: ${product.quantity}</li>
                                                <li class="list-group-item">Hãng sản xuất: ${product.factory}</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <img src="/images/product/${product.image}"
                                            style="max-height: 250px; display: block;" alt="avatar preview"
                                            id="productImagePreview" />
                                    </div>
                                </div>
                                <a href="/admin/product" class="btn btn-success mt-4">Quay lại</a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
</body>

</html>