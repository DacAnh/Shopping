<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài khoản cần xóa</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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
                        <h1>Xóa tài khoản với mã ID là ${id}</h1>
                        <hr>
                        <div class="alert alert-danger" role="alert">
                            Bạn chắc chắn muốn xóa tài khoản này chứ?
                        </div>
                        <form:form action="/admin/user/delete" modelAttribute="user">
                            <div class="mb-3" style="display: none;">
                                <label class="form-label">Id:</label>
                                <form:input type="text" class="form-control" path="id" value="${id}" />
                            </div>
                            <div class="row">
                                <div class="col-md-1 col-12 p-0 mx-4">
                                    <button class="btn btn-danger">Xác nhận</button>
                                </div>
                                <div class="col-md-1 col-12">
                                    <a href="/admin/user" class="btn btn-info">Quay lại</a>
                                </div>
                            </div>
                        </form:form>
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