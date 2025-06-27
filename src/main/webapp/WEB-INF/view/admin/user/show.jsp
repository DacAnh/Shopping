<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài khoản</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- <link href="/css/demo.css" rel="stylesheet"> -->
    <link href="/css/styles.css" rel="stylesheet" />

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
                                    <h2> Danh sách tài khoản </h2>
                                    <a href="/admin/user/create" class="btn btn btn-primary">Tạo tài khoản</a>
                                </div>
                                <hr>
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Id</th>
                                            <th scope="col">Địa chỉ Email</th>
                                            <th scope="col">Họ tên</th>
                                            <th scope="col">Vai trò</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${users}">
                                            <tr>
                                                <th scope="row">${user.id}</th>
                                                <td>${user.email}</td>
                                                <td>${user.fullName}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.role.name == 'ADMIN'}">Quản trị viên
                                                        </c:when>
                                                        <c:when test="${user.role.name == 'USER'}">Khách hàng</c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="/admin/user/${user.id}" class="btn btn-success">Xem chi
                                                        tiết</a>
                                                    <a href="/admin/user/update/${user.id}" class="btn btn-warning">Cập
                                                        nhật</a>
                                                    <a href="/admin/user/delete/${user.id}"
                                                        class="btn btn-danger">Xóa</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage ne 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/user?page=${currentPage-1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="0" end="${totalPages-1}" varStatus="loop">
                                            <li class="page-item">
                                                <a class="${(loop.index+1) eq currentPage ? 'page-link active' :'page-link'}"
                                                    href="/admin/user?page=${loop.index+1}">
                                                    ${loop.index+1}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage ne totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/user?page=${currentPage+1}"
                                                    aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                    </ul>
                                </nav>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>