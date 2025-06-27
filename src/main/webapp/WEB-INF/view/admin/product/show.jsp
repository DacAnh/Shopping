<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Sản phẩm</title>
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
                                    <h2> Danh sách sản phẩm </h2>
                                    <a href="/admin/product/create" class="btn btn btn-primary">Tạo sản
                                        phẩm</a>
                                </div>
                                <hr>
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Tên</th>
                                            <th scope="col">Giá cả</th>
                                            <th scope="col">Hãng sản xuất</th>
                                            <th scope="col">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${products}">
                                            <tr>
                                                <th scope="row">${product.id}</th>
                                                <td>${product.name}</td>
                                                <td>
                                                    <fmt:formatNumber type="currency" currencySymbol="VNĐ"
                                                        maxFractionDigits="2" value="${product.price}" />
                                                </td>
                                                <td>${product.factory}</td>
                                                <td>
                                                    <a href="/admin/product/${product.id}" class="btn btn-success">Xem
                                                        chi tiết</a>
                                                    <a href="/admin/product/update/${product.id}"
                                                        class="btn btn-warning">Cập nhật</a>
                                                    <a href="/admin/product/delete/${product.id}"
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
                                                <a class="page-link" href="/admin/product?page=${currentPage-1}"
                                                    aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="0" end="${totalPages-1}" varStatus="loop">
                                            <li class="page-item">
                                                <a class="${(loop.index+1) eq currentPage ? 'page-link active' :'page-link'}"
                                                    href="/admin/product?page=${loop.index+1}">
                                                    ${loop.index+1}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage ne totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/product?page=${currentPage+1}"
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
    <script src="js/scripts.js"></script>
</body>

</html>