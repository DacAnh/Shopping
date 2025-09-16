<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết tài khoản</title>
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
                    <h1 class="mt-4">Quản lý người dùng</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Người dùng</li>
                    </ol>
                    <div>

                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between">
                                    <h2> Thông tin tài khoản với mã ID là: ${user.id} </h2>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-6 col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                Thông tin tài khoản 
                                            </div>
                                            <ul class="list-group list-group-flush">
                                                <li class="list-group-item">ID: ${user.id}</li>
                                                <li class="list-group-item">Địa chỉ Email: ${user.email}</li>
                                                <li class="list-group-item">Họ tên: ${user.fullName}</li>
                                                <li class="list-group-item">Vai trò: 
                                                     <c:choose>
                                                        <c:when test="${user.role.name == 'ADMIN'}">Quản trị viên
                                                        </c:when>
                                                        <c:when test="${user.role.name == 'USER'}">Khách hàng</c:when>
                                                    </c:choose>
                                                </li>
                                                <li class="list-group-item">Số điện thoại: ${user.phone}</li>
                                                <li class="list-group-item">Địa chỉ: ${user.address}</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <img src="/images/avatar/${user.avatar}"
                                            style="max-height: 250px; display: block;" alt="avatar preview"
                                            id="avatarPreview" />
                                    </div>
                                </div>
                                <a href="/admin/user" class="btn btn-success mt-4">Quay lại</a>
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