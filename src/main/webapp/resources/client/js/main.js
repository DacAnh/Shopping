(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })

        // Thêm active vào header
        const navElement = $("#navbarCollapse");
        const currentUrl = window.location.pathname;
        navElement.find('a.nav-link').each(function(){
            const link = $(this);
            const href = link.attr('href');

            if(href === currentUrl){
                link.addClass('active');
            } else{
                link.removeClass('active');
            }
        });
    });

    // Product Quantity
    // $('.quantity button').on('click', function () {
    //     var button = $(this);
    //     var oldValue = button.parent().parent().find('input').val();
    //     if (button.hasClass('btn-plus')) {
    //         var newVal = parseFloat(oldValue) + 1;
    //     } else {
    //         if (oldValue > 0) {
    //             var newVal = parseFloat(oldValue) - 1;
    //         } else {
    //             newVal = 0;
    //         }
    //     }
    //     button.parent().parent().find('input').val(newVal);
    // });
    $('.quantity button').on('click', function () {
        let change = 0;

        var button = $(this);
        var oldValue = button.parent().parent().find('input').val();
        if (button.hasClass('btn-plus')) {
            var newVal = parseFloat(oldValue) + 1;
            change = 1;
        } else {
            if (oldValue > 1) {
                var newVal = parseFloat(oldValue) - 1;
                change = -1;
            } else {
                newVal = 1;
            }
        }
        const input = button.parent().parent().find('input');
        input.val(newVal);

        //set form index
        const index= input.attr("data-cart-detail-index");
        const el = document.getElementById(`cartDetails${index}.quantity`);
        $(el).val(newVal);

        //get price
        const price = input.attr("data-cart-detail-price");
        const id = input.attr("data-cart-detail-id");

        const priceElement = $(`p[data-cart-detail-id='${id}']`);
        if (priceElement) {
            const newPrice = +price * newVal;
            priceElement.text(formatCurrency(newPrice.toFixed(2)) + " VNĐ");
        }

        //update total cart price
        const totalPriceElement = $(`p[data-cart-total-price]`);

        if (totalPriceElement && totalPriceElement.length) {
            const currentTotal = totalPriceElement.first().attr("data-cart-total-price");
            let newTotal = +currentTotal;
            if (change === 0) {
                newTotal = +currentTotal;
            } else {
                newTotal = change * (+price) + (+currentTotal);
            }

            //reset change
            change = 0;

            //update
            totalPriceElement?.each(function (index, element) {
                //update text
                $(totalPriceElement[index]).text(formatCurrency(newTotal.toFixed(2)) + " VNĐ");

                //update data-attribute
                $(totalPriceElement[index]).attr("data-cart-total-price", newTotal);
            });
        }
    });

    function formatCurrency(value) {
        // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
        // and 'VND' as the currency type for Vietnamese đồng
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0, // No decimal part for whole numbers
        });

        let formatted = formatter.format(value);
        // Replace dots with commas for thousands separator
        formatted = formatted.replace(/\./g, ',');
        return formatted;
    }


    $('#btnFilter').click(function(event) {
        event.preventDefault()

        let factoryArr = [];
        let targetArr = [];
        let priceArr = [];

        $("#factoryFilter .form-check-input:checked").each(function (){
            factoryArr.push($(this).val());
        });
        $("#targetFilter .form-check-input:checked").each(function (){
            targetArr.push($(this).val());
        });
        $("#priceFilter .form-check-input:checked").each(function (){
            priceArr.push($(this).val());
        });

        // tiến hành ghi động lên thanh URL

        let sortValue = $('input[name="radio-sort"]:checked').val();

        const currentUrl = new URL(window.location.href);
        const searchParams = currentUrl.searchParams;

        searchParams.set('page','1');
        searchParams.set('sort',sortValue);

        searchParams.delete('factory');
        searchParams.delete('target');
        searchParams.delete('price');

        if( factoryArr.length >0 ){
            searchParams.set('factory', factoryArr.join(','));
        }
        if( targetArr.length >0 ){
            searchParams.set('target', targetArr.join(','));
        }
        if( priceArr.length >0 ){
            searchParams.set('price', priceArr.join(','));
        }

        window.location.href = currentUrl.toString();
    });


    // Quy trình lấy lại checkbox dựa trên query string được trả về
    const searchParams = new URLSearchParams(window.location.search);

    // Lấy và check lại checkbox của factory
    const factory = searchParams.get('factory');
    if (factory) {
        const factoryValues = factory.split(',');
        factoryValues.forEach(val => {
            $('#factoryFilter .form-check-input').each(function () {
                if ($(this).val() === val) {
                    $(this).prop('checked', true);
                }
            });
        });
    }

    // Lấy và check lại checkbox của target
    const target = searchParams.get('target');
    if (target) {
        const targetValues = target.split(',');
        targetValues.forEach(val => {
            $('#targetFilter .form-check-input').each(function () {
                if ($(this).val() === val) {
                    $(this).prop('checked', true);
                }
            });
        });
    }

    //Lấy và check lại checkbox của price
    const price = searchParams.get('price');
    if (price) {
        const priceValues = price.split(',');
        priceValues.forEach(val => {
            $('#priceFilter .form-check-input').each(function () {
                if ($(this).val() === val) {
                    $(this).prop('checked', true);
                }
            });
        });
    }

    //Set lại radio sort nếu có
    const sort = searchParams.get('sort');
    if (sort) {
        $(`input[name="radio-sort"][value="${sort}"]`).prop('checked', true);
    }


    $('.btnAddToCartHomePage').click(function(event) {
        event.preventDefault();

        if( !isLogin()){
            $.toast({
                heading: 'Lỗi thao tác',
                text: 'Bạn cần đăng nhập tài khoản',
                position: 'top-right',
                icon: 'error'
            })
            return;
        }

        const productId= $(this).attr('data-product-id');
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");
        // Khả năng lỗi
        const quantity = $("#cartDetails0\\.quantity").val();

        $.ajax({
            url:    `${window.location.origin}/api/add-product-to-cart`,
            beforeSend: function(xhr){
                xhr.setRequestHeader(header,token);
            },
            type: "POST",
            data: JSON.stringify({quantity: quantity, productId: productId}),
            contentType: "application/json",

            success: function (response){
                const sum = +response;
                $("#sumCart").text(sum)
                $.toast({
                    heading: 'Giỏ hàng',
                    text: 'Thêm sản phẩm vào giỏ hàng thành công',
                    position: 'top-right'
                })
            },
            error: function (response){
                alert ("Có lỗi xảy ra")
            }
        });
    });

    function isLogin(){
        const navElement = $("#navbarCollapse");
        const childLogin = navElement.find('a.a-login');
        if(childLogin.length >0){
            return false;
        }
        return true;
    }

    $('.btnAddToCartDetail').click(function(event) {
        event.preventDefault();

        if( !isLogin()){
            $.toast({
                heading: 'Lỗi thao tác',
                text: 'Bạn cần đăng nhập tài khoản',
                position: 'top-right',
                icon: 'error'
            })
            return;
        }

        const productId= $(this).attr('data-product-id');
        const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");
        // Khả năng lỗi
        const quantity = $("#cartDetails0\\.quantity").val();

        $.ajax({
            url:    `${window.location.origin}/api/add-product-to-cart`,
            beforeSend: function(xhr){
                xhr.setRequestHeader(header,token);
            },
            type: "POST",
            data: JSON.stringify({quantity: quantity, productId: productId}),
            contentType: "application/json",

            success: function (response){
                const sum = +response;
                $("#sumCart").text(sum)
                $.toast({
                    heading: 'Giỏ hàng',
                    text: 'Thêm sản phẩm vào giỏ hàng thành công',
                    position: 'top-right'
                })
            },
            error: function (response){
                alert ("Có lỗi xảy ra")
            }
        });
    });

})(jQuery);

