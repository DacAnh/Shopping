<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Laptopshop</title>

    <link rel="icon" type="image/png" href="https://laptopshopvn.up.railway.app/images/logo/laptop-logo.png">
    <meta property="og:title" content="Laptop Shop" />
    <meta property="og:description" content="Laptop chất lượng, phù hợp giá thị trường !" />
    <meta property="og:image" content="https://laptopshopvn.up.railway.app/images/logo/laptop-logo.png" />
    <meta property="og:image:type" content="image/png" />
    <meta property="og:image:width" content="300" /> <meta property="og:image:height" content="300" />
    <meta property="og:url" content="https://laptopshopvn.up.railway.app/" />
    <meta property="og:type" content="website" />

    <!-- String boot hướng dẫn cần làm thế này để gửi json -->
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <!-- sử dụng toast plugin để làm hiệu ứng thêm giỏ hàng -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.css" rel="stylesheet">

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
    <style>
        @media (max-width: 767.98px) {
            .custom-dropdown-menu {
                left: 50% !important;
                transform: translateX(-40%) !important;
                right: auto !important;
            }
        }
    </style>

    <style>
  #successToast {
    position: fixed;
    top: -100px; /* bắt đầu ngoài khung nhìn */
    left: 50%;
    transform: translateX(-50%);
    background-color: #4caf50;
    color: white;
    padding: 20px 30px;
    border-radius: 10px;
    font-size: 18px;
    z-index: 9999;
    opacity: 0;
    animation: slideDownFadeIn 1s forwards, fadeOut 1s forwards 3s;
  }

  @keyframes slideDownFadeIn {
    from {
      top: -100px;
      opacity: 0;
    }
    to {
      top: 20%;
      opacity: 1;
      transform: translate(-50%, -50%);
    }
  }

  @keyframes fadeOut {
    to {
      opacity: 0;
    }
  }

  .hidden-toast {
    display: none;
  }

  .show-toast {
    display: block;
  }
</style>
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

    <!-- Hero Start -->
         <div id="successToast" class="hidden-toast p-3">
  Đặt hàng thành công!
</div>
    <jsp:include page="../layout/banner.jsp" />
    <!-- Hero End -->



    <!-- Featurs Section Start -->
    <jsp:include page="../layout/feature.jsp" />
    <!-- Featurs Section End -->


    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
        <div class="container py-5">
            <div class="tab-class text-center">
                <div class="row g-4">
                    <div class="col-lg-4 text-start">
                        <h1>Sản phẩm nổi bật</h1>
                    </div>
                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill active" href="/products">
                                    <span class="text-dark" style="width: 130px;">Tất cả sản phẩm</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4">
                                    <c:forEach var="product" items="${products}">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="/images/product/${product.image}"
                                                        class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                    style="top: 10px; left: 10px;">Laptop</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4 style="font-size: 15px;">
                                                        <a href="/product/${product.id}">${product.name}</a>
                                                    </h4>
                                                    <p style="font-size: 13px;">${product.shortDesc}</p>
                                                    <div class="d-flex flex-lg-wrap justify-content-center flex-column">
                                                        <p style="font-size: 15px; text-align: center; width: 100%;"
                                                            class="text-dark fw-bold mb-3">
                                                            <fmt:formatNumber type="currency" currencySymbol="VNĐ"
                                                                maxFractionDigits="2" value="${product.price}" />
                                                        </p>

                                                        <!-- <form action="/add-product-to-cart/${product.id}" method="post">
                                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                <button
                                                                class="mx-auto btn border border-secondary rounded-pill px-2 text-primary"><i
                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                Thêm vào giỏ</button>
                                                            </form> -->
                                                        <button data-product-id="${product.id}"
                                                            class="btnAddToCartHomePage mx-auto btn border border-secondary rounded-pill px-2 text-primary"><i
                                                                class="fa fa-shopping-bag me-2 text-primary"></i>
                                                            Thêm vào giỏ</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Fruits Shop End-->


    <jsp:include page="../layout/footer.jsp" />


    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
            class="fa fa-arrow-up"></i></a>


    <!-- JavaScript Libraries -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- sử dụng toast plugin js để hỗ trợ toast plugin css làm hiệu ứng thêm giỏ hàng -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script>
        window.addEventListener("DOMContentLoaded", () => {
            if (sessionStorage.getItem("successOrder") === "true") {
                const toast = document.getElementById("successToast");
                toast.classList.add("show-toast");

                // Sau 3 giây ẩn toast và xóa flag
                setTimeout(() => {
                    toast.classList.remove("show-toast");
                    sessionStorage.removeItem("successOrder");
                }, 3000);
            }
        });
    </script>
</body>

</html>