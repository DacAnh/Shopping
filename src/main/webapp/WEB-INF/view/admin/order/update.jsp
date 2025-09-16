<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng cần cập nhật</title>
    <link rel="icon" type="image/png" href="/images/logo/laptop-logo.png">
    <meta property="og:title" content="Laptop Shop" />
    <meta property="og:description" content="Laptop chất lượng, phù hợp giá thị trường !" />
    <meta property="og:image" content="https://laptopshopvn.up.railway.app/images/logo/laptop-logo.png" />
    <meta property="og:url" content="https://laptopshopvn.up.railway.app/" />
    <meta property="og:type" content="website" />
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
                    <h1 class="mt-4">Quản lý đơn hàng</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Đơn hàng</li>
                    </ol>
                    <div>
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h2>Cập nhật đơn hàng</h2>
                                <hr>
                                <form:form class="row g-3" method="post" action="/admin/order/update"
                                    modelAttribute="order" enctype="multipart/form-data">
                                    <div class="mb-3" style="display: none;">
                                        <label class="form-label">Id:</label>
                                        <form:input type="text" class="form-control" path="id" />
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label for="exampleInputEmail1" class="form-label">Họ tên người nhận:</label>
                                        <form:input class="form-control" path="receiverName" disabled="true"/>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label for="exampleInputEmail1" class="form-label">Số điện thoại người nhận:</label>
                                        <form:input class="form-control" path="receiverPhone" disabled="true"/>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label for="exampleInputEmail1" class="form-label">Tổng tiền:</label>
                                        <fmt:formatNumber type="currency" currencySymbol="VNĐ"
                                                    maxFractionDigits="2" value="${order.totalPrice}" />
                                    </div>
                                    <div class="col-md-12 col-12">
                                        <label for="exampleInputEmail1" class="form-label">Địa chỉ người nhận:</label>
                                        <form:input class="form-control" path="receiverAddress" disabled="true"/>
                                    </div>
                                    
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Trạng thái đơn hàng:</label>
                                        <form:select class="form-select" path="status">
                                            <form:option value="PENDING">Chờ xử lý</form:option>
                                            <form:option value="SHIPPING">Đang vận chuyển</form:option>
                                            <form:option value="COMPLETE">Giao hàng thành công</form:option>
                                            <form:option value="CANCEL">Hủy đơn</form:option>
                                        </form:select>
                                    </div>
                                    <div class="col-12 justify-content-end row mt-4">
                                        <div class="col-md-3 p-0 col-12">
                                        <button class="btn btn-warning">Cập nhật</button>
                                    </div>
                                    <div class="col-md-3 col-12">
                                        <a href="/admin/order" class="btn btn-info">Quay lại</a>
                                    </div>
                                    </div>
                                </form:form>
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