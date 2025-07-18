<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Chi tiết đơn hàng</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp"/>
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp"/>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Quản lý đơn hàng</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Đơn hàng</li>
                    </ol>
                    <div>
                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between mx-4">
                                    <h2>Danh sách chi tiết đơn hàng với mã ID là ${orderId}</h2>
                                    <a href="/admin/order"
                                        class="btn btn-success px-3">Quay lại</a>
                                </div>
                                <hr>
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Ảnh minh họa</th>
                                            <th scope="col">Tên sản phẩm</th>
                                            <th scope="col">Giá cả</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="orderDetail" items="${orderDetails}">
                                            <tr>
                                                <th>
                                                    <div class="d-flex align-items-center">
                                                        <img src="/images/product/${orderDetail.product.image}"
                                                            class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;"
                                                            alt="">
                                                    </div>
                                                </th>
                                                <td>
                                                    <p class="mb-0 mt-4">
                                                        <a href="/product/${orderDetail.product.id}" target="_blank">
                                                            <!-- dùng _blank để click mở tab mới -->
                                                            ${orderDetail.product.name}
                                                        </a>
                                                    </p>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber type="currency" currencySymbol="VNĐ"
                                                        maxFractionDigits="2" value="${orderDetail.price}" />               
                                                </td>
                                                <td>${orderDetail.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber type="currency" currencySymbol="VNĐ"
                                                        maxFractionDigits="2" 
                                                        value="${orderDetail.price*orderDetail.quantity}" />      
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp"/>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
</body>

</html>