<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Lịch sử mua hàng - Laptopshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
</head>

<body>

    <!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->


    <!-- Navbar start -->
    <jsp:include page="../layout/header.jsp" />
    <!-- Navbar End -->


    <!-- Cart Page Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                    </ol>
                </nav>
            </div>
            <div class="table-responsive">

                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Sản phẩm</th>
                            <th scope="col">Tên</th>
                            <th scope="col">Giá cả</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Thành tiền</th>
                            <th scope="col">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}" varStatus="status">
                            <tr>
                                <th colspan="2">
                                    Lần mua thứ ${status.index+1}
                                </th>
                                <th>
                                    <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                        value="${order.totalPrice}" />
                                </th>
                                <th></th>
                                <th></th>
                                <th>
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            Chờ xử lý
                                        </c:when>
                                        <c:when test="${order.status == 'SHIPPING'}">
                                            Đang vận chuyển
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETE'}">
                                            Giao hàng thành công
                                        </c:when>
                                        <c:when test="${order.status == 'CANCEL'}">
                                            Đã hủy
                                        </c:when>
                                    </c:choose>
                                </th>
                            </tr>
                            <c:forEach var="orderDetail" items="${order.orderDetails}">
                                <tr>
                                    <th scope="row">
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
                                        <p class="mb-0 mt-4">
                                            <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                                value="${orderDetail.price}" />
                                        </p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            ${orderDetail.quantity}
                                    </p>
                                </td>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                                value="${orderDetail.price * orderDetail.quantity}" />
                                        </p>
                                    </td>
                                    <td></td>
                                </tr>
                            </c:forEach>

                        </c:forEach>

                    </tbody>
                </table>
            </div>

            <c:if test="${empty orders}">
                <div class="d-flex justify-content-center">
                    <div class=" d-flex flex-column">
                        <h2>Không có lịch sử mua hàng nào</h2>
                        <div class="d-flex justify-content-center">
                            <a href="/" class="btn btn-success mt-2">
                                Tiếp tục mua hàng
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
    <!-- Cart Page End -->


    <jsp:include page="../layout/footer.jsp" />



    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
            class="fa fa-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
</body>

</html>