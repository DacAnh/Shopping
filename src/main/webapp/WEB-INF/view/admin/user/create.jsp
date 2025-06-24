<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài khoản mới</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- <link href="/css/demo.css" rel="stylesheet"> -->
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });
        });
    </script>

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
                            <div class="col-md-6 col-12 mx-auto">
                                <h2>Tạo mới tài khoản</h2>
                                <hr>

                                <form:form class="row g-3" method="post" action="/admin/user/create"
                                    modelAttribute="newUser" enctype="multipart/form-data">
                                    <div class="col-md-6 col-12">

                                        <c:set var="errorEmail">
                                            <form:errors path="email" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Địa chỉ Email:</label>
                                        <form:input type="email"
                                            class="form-control ${not empty errorEmail ? 'is-invalid':''}" path="email" />
                                        ${errorEmail}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <c:set var="errorPassword">
                                            <form:errors path="password" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label for="exampleInputPassword1" class="form-label">Mật khẩu:</label>
                                        <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid':''}" path="password" />
                                        ${errorPassword}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <c:set var="errorPhone">
                                            <form:errors path="phone" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Số điện thoại:</label>
                                        <form:input type="text" class="form-control ${not empty errorPhone ? 'is-invalid':''}" path="phone" />
                                        ${errorPhone}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <c:set var="errorFullName">
                                            <form:errors path="fullName" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Họ tên</label>
                                        <form:input type="text" class="form-control ${not empty errorFullName ? 'is-invalid':''}" path="fullName" />
                                        ${errorFullName}
                                    </div>
                                    <div class="col-12 col-12">
                                        <c:set var="errorAddress">
                                            <form:errors path="address" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Địa chỉ:</label>
                                        <form:input type="text" class="form-control ${not empty errorAddress ? 'is-invalid':''}" path="address" />
                                        ${errorAddress}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Vai trò:</label>
                                        <form:select class="form-select" path="role.name">
                                            <form:option value="ADMIN">Quản trị viên</form:option>
                                            <form:option value="USER">Khách hàng</form:option>
                                        </form:select>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label for="avatarFile" class="form-label">Avatar</label>
                                        <input class="form-control" type="file" id="avatarFile"
                                            accept=".png, .jpg, .jpeg" name="avatarFileTest" />
                                    </div>
                                    <div class="col-12">
                                        <img src="" style="max-height: 250px; display: none;" alt="avatar preview"
                                            id="avatarPreview" />
                                    </div>
                                    <div class="col-md-2 col-12">
                                        <button class="btn btn-primary">Tạo mới</button>
                                    </div>
                                    <div class="col-md-2 col-12">
                                        <a href="/admin/user" class="btn btn-info">Quay lại</a>
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