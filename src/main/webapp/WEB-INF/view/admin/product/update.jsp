<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm cần cập nhật</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- <link href="/css/demo.css" rel="stylesheet"> -->
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#productFile");
            const oldProductImage = "${product.image}";
            if (oldProductImage) {
                const urlImage = "/images/product/" + oldProductImage;
                $("#productPreview").attr("src", urlImage);
                $("#productPreview").css({ "display": "block" });
            }

            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#productPreview").attr("src", imgURL);
                $("#productPreview").css({ "display": "block" });
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
                    <h1 class="mt-4">Quản lý sản phẩm</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Sản phẩm</li>
                    </ol>
                    <div>
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h2>Cập nhật mặt hàng</h2>
                                <hr>
                                <form:form class="row g-3" method="post" action="/admin/product/update"
                                    modelAttribute="product" enctype="multipart/form-data">
                                    <c:set var="errorName">
                                        <form:errors path="name" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorPrice">
                                        <form:errors path="price" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorDetailDesc">
                                        <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorShortDesc">
                                        <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorQuantity">
                                        <form:errors path="quantity" cssClass="invalid-feedback" />
                                    </c:set>
                                    <div class="mb-3" style="display: none;">
                                        <label class="form-label">Id:</label>
                                        <form:input type="text" class="form-control" path="id" />
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Tên:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty errorName ? 'is-invalid':''}" path="name" />
                                        ${errorName}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Giá:</label>
                                        <form:input type="number"
                                            class="form-control ${not empty errorPrice ? 'is-invalid':''}"
                                            path="price" />
                                        ${errorPrice}
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Mô tả chi tiết:</label>
                                        <form:textarea type="text"
                                            rows="5"
                                            class="form-control ${not empty errorDetailDesc ? 'is-invalid':''}"
                                            path="detailDesc" />
                                        ${errorDetailDesc}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Mô tả ngắn:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty errorShortDesc ? 'is-invalid':''}"
                                            path="shortDesc" />
                                        ${errorShortDesc}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Số lượng:</label>
                                        <form:input type="text"
                                            class="form-control ${not empty errorQuantity ? 'is-invalid':''}"
                                            path="quantity" />
                                        ${errorQuantity}
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <label class="form-label">Hãng sản xuất:</label>
                                        <form:select class="form-select" path="factory">
                                            <form:option value="APPLE">Apple (MacBook)</form:option>
                                            <form:option value="ASUS">Asus</form:option>
                                            <form:option value="LENOVO">Lenovo</form:option>
                                            <form:option value="LG">LG</form:option>
                                            <form:option value="DELL">Dell</form:option>
                                            <form:option value="ACER">Acer</form:option>
                                        </form:select>
                                    </div>
                                    <div class="mb-3 col-md-6 col-12">
                                        <label class="form-label">Đối tượng:</label>
                                        <form:select class="form-select" path="target">
                                            <form:option value="GAMMING">Gamming</form:option>
                                            <form:option value="VAN-PHONG">Văn phòng</form:option>
                                            <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                        </form:select>
                                    </div>
                                    <div class="col-12">
                                        <label for="avatarFile" class="form-label">Ảnh minh họa:</label>
                                        <input class="form-control" type="file" id="productFile"
                                            accept=".png, .jpg, .jpeg" name="productFileTest" />
                                    </div>
                                    <div class="col-12">
                                        <img style="max-height: 250px; display: none;" alt="product image preview"
                                            id="productPreview" />
                                    </div>
                                    <div class="col-md-2 p-0 col-12">
                                        <button class="btn btn-warning">Cập nhật</button>
                                    </div>
                                    <div class="col-md-2 col-12">
                                        <a href="/admin/product" class="btn btn-info">Quay lại</a>
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