<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Giỏ hàng - Laptopshop</title>
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
    <div class="container-fluid pt-5">
        <div class="container pt-5">
            <div class="mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
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
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="cartDetail" items="${cartDetails}">
                            <tr>
                                <th scope="row">
                                    <div class="d-flex align-items-center">
                                        <img src="/images/product/${cartDetail.product.image}"
                                            class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;"
                                            alt="">
                                    </div>
                                </th>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <a href="/product/${cartDetail.product.id}" target="_blank">
                                            <!-- dùng _blank để click mở tab mới -->
                                            ${cartDetail.product.name}
                                        </a>
                                    </p>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                            value="${cartDetail.product.price}" />
                                    </p>
                                </td>
                                <td>
                                    <div class="text-center mt-4 justify-content-center" style="width: 100px;">
                                        ${cartDetail.quantity}
                                    </div>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                        <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                            value="${cartDetail.product.price * cartDetail.quantity}" />
                                    </p>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>

            <form:form action="/place-order" method="post" modelAttribute="orderDTO">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="mt-5 row g-4 justify-content-start">
                    <div class="col-12 col-md-6">
                        <div class="p-4">
                            <h5>Thông tin người nhận</h5>
                            <div class="row">
                                <c:set var="errorName">
                                    <form:errors path="name" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorPhone">
                                    <form:errors path="phone" cssClass="invalid-feedback" />
                                </c:set>
                                <c:set var="errorAddress">
                                    <form:errors path="address" cssClass="invalid-feedback" />
                                </c:set>

                                <div class="col-12 form-group mb-3">
                                    <label>Tên người nhận</label>
                                    <form:input 
                                        type="text" 
                                        class="form-control ${not empty errorName ? 'is-invalid':''}" 
                                        path="name"/>
                                    ${errorName}
                                </div>
                                <div class="col-12 form-group mb-3">
                                    <label>Số điện thoại</label>
                                    <form:input 
                                        type="text" 
                                        class="form-control ${not empty errorPhone ? 'is-invalid':''}" 
                                        path="phone"/>
                                    ${errorPhone}
                                </div>
                                <div class="col-12 form-group mb-3">
                                    <label>Địa chỉ người nhận</label>
                                    <form:input 
                                        type="text" 
                                        class="form-control ${not empty errorAddress ? 'is-invalid':''}" 
                                        path="address"/>
                                    ${errorAddress}
                                </div>
                            </div>
                            <div class="mt-2">
                                <a href="/cart" class="btn btn-success bi bi-cart">
                                    Quay lại giỏ hàng
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6">
                        <div class="bg-light rounded">
                            <div class="p-4">
                                <h1 class="display-6 mb-4">Thông tin <span class="fw-normal">thanh toán</span></h1>
                                <div class="d-flex justify-content-between mb-4">
                                    <h5 class="mb-0 me-4">Tạm tính:</h5>
                                    <p class="mb-0" data-cart-total-price="${totalPrice}">
                                        <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                            value="${totalPrice}" />
                                    </p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                    <div class="">
                                        <p class="mb-0">Miễn phí</p>
                                    </div>
                                </div>
                                <p class="mb-2 text-end">Giao hàng tiết kiệm</p>
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-0 me-4">Hình thức thanh toán</h5>
                                    <div class="">
                                        <p class="mb-0">Thanh toán khi nhận hàng (COD)</p>
                                    </div>
                                </div>

                            </div>
                            <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                    <fmt:formatNumber type="currency" currencySymbol="VNĐ" maxFractionDigits="2"
                                        value="${totalPrice}" />
                                </p>
                            </div>
                            <button class="btn border-secondary 
                                rounded-pill px-4 py-3 text-primary 
                                text-uppercase mb-4 ms-4" onclick="checkout()">
                                Xác nhận thanh toán
                            </button>

                        </div>
                    </div>
                </div>
            </form:form>

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

    <script>
    function checkout() {
        // Đặt flag vào sessionStorage
        sessionStorage.setItem("successOrder", "true");
    }
    </script>
</body>

</html>