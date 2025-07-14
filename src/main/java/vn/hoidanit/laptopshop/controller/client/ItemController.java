package vn.hoidanit.laptopshop.controller.client;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.OrderDTO;
import vn.hoidanit.laptopshop.domain.dto.ProductCriterialDTO;
import vn.hoidanit.laptopshop.service.CartDetailService;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.OrderService;
import vn.hoidanit.laptopshop.service.ProductService;

@Controller
public class ItemController {

    private final ProductService productService;
    private final CartDetailService cartDetailService;
    private final CartService cartService;
    private final OrderService orderService;

    public ItemController(
            ProductService productService,
            CartDetailService cartDetailService,
            CartService cartService,
            OrderService orderService) {
        this.productService = productService;
        this.cartDetailService = cartDetailService;
        this.cartService = cartService;
        this.orderService = orderService;
    }

    @GetMapping("/products")
    public String getAllItemPage(Model model,
            ProductCriterialDTO productCriterialDTO,
        // Spring boot tự động nạp query string (request param) vào biến java object
            HttpServletRequest request
    ) {
        int page = 1;
        String name ="";
        try {
            if(productCriterialDTO.getPage().isPresent()){
                page = Integer.parseInt(productCriterialDTO.getPage().get());
                
            }
            // if(nameOptional.isPresent()){
            //     name = nameOptional.get();
            // }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        Pageable pageable = PageRequest.of(page-1, 6);
        // Vì sort liên quan đến trang (page) nên chưa thể đưa vào hàm handleProductsWithSpec
        if(productCriterialDTO.getSort().isPresent()){
            String sort = productCriterialDTO.getSort().get();
            if(sort.equals("gia-tang-dan")){
                pageable = PageRequest.of(page-1, 6, Sort.by(Product_.PRICE).ascending());
            }
            else if(sort.equals("gia-giam-dan")){
                pageable = PageRequest.of(page-1, 6, Sort.by(Product_.PRICE).descending());
            }
        }
        

        // case chính
        Page<Product> products = this.productService.handleProductsWithSpec(pageable, productCriterialDTO);

        String queryString = request.getQueryString();
        if(queryString!=null && !queryString.isBlank()){
            queryString = queryString.replace("page="+ page, "");
        }

        //case 1
        // BigDecimal min = minOptional.isPresent() ? 
        //                             BigDecimal.valueOf(Double.parseDouble(minOptional.get())) : BigDecimal.ZERO;
        // Page<Product> products = this.productService.handleProductsWithSpec(pageable, min);


        //case 2
        // BigDecimal max = maxOptional.isPresent() ? 
        //                             BigDecimal.valueOf(Double.parseDouble(maxOptional.get())) : BigDecimal.ZERO;
        // Page<Product> products = this.productService.handleProductsWithSpec(pageable, max);

        
        
        //case 3
        // List<String> factory = factoryOptional.isPresent() ? 
        //                                     Arrays.asList(factoryOptional.get().split(",")) : null;
        // Page<Product> products = this.productService.handleProductsWithSpec(pageable, factory);

        //case 4
        // String price = priceOptional.isPresent() ? 
        //                                     priceOptional.get() : null;
        // Page<Product> products = this.productService.handleProductsWithSpec(pageable, price);

        //case 5
        // List<String> price = priceOptional.isPresent() ? 
        //                                     Arrays.asList(priceOptional.get().split(",")) : null;
        // Page<Product> products = this.productService.handleProductsWithSpec(pageable, price);
        
        // Page<Product> products = this.productService.getAllProductsByName(pageable,name);


        List<Product> listProducts = products.getContent();
        model.addAttribute("products", listProducts);
        model.addAttribute("totalPages", products.getTotalPages());
        model.addAttribute("currentPage", page);
        model.addAttribute("queryString", queryString);
        return "client/product/show";
    }

    @GetMapping("/product/{id}")
    public String getItemPage(Model model, @PathVariable long id) {
        Product product = this.productService.getOneProductById(id);
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(
            @PathVariable long id,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.productService.handleAddProductToCart(session, id, 1);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User currentUser = new User();
        long userId = (long) session.getAttribute("id");
        currentUser.setId(userId);
        // Thiết lập Id tại session thay vì lấy email -> để giảm lời gọi đến DB, tại vì
        // getCartByUser
        // dựa vào user_id để tìm kiếm nên chỉ cần user_id

        Cart cart = this.productService.getCartByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        BigDecimal totalPrice = BigDecimal.ZERO;
        for (CartDetail cartDetail : cartDetails) {
            BigDecimal price = cartDetail.getPrice();
            BigDecimal quantity = BigDecimal.valueOf(cartDetail.getQuantity());
            totalPrice = totalPrice.add(price.multiply(quantity));
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        model.addAttribute("cart", cart);

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartProduct(
            @PathVariable long id,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        CartDetail cartDetail = this.cartDetailService.getOneCartDetailById(id);
        Cart cart = cartDetail.getCart();

        this.cartDetailService.remove(cartDetail);
        int sumCart = cart.getSum();
        if (sumCart > 1) {
            sumCart -= 1;
            cart.setSum(sumCart);
            this.cartService.handleSaveCart(cart);
        } else {
            sumCart = 0;
            this.cartService.remove(cart);
        }
        session.setAttribute("sumCart", sumCart);
        return "redirect:/cart";
    }

    @PostMapping("/confirm-checkout")
    public String confirmCheckout(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.cartService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User currentUser = new User();
        currentUser.setId((long) session.getAttribute("id"));
        Cart cart = this.cartService.getCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        BigDecimal totalPrice = BigDecimal.ZERO;
        for (CartDetail cartDetail : cartDetails) {
            BigDecimal price = cartDetail.getPrice();
            BigDecimal quantity = BigDecimal.valueOf(cartDetail.getQuantity());
            totalPrice = totalPrice.add(price.multiply(quantity));
        }

        OrderDTO orderDTO = new OrderDTO();

        model.addAttribute("orderDTO", orderDTO);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String placeOrder(Model model,
            @ModelAttribute("orderDTO") @Valid OrderDTO orderDTO,
            BindingResult orderBindingResult,
            HttpServletRequest request) {

        HttpSession session = request.getSession();
        User currentUser = new User();
        currentUser.setId((long) session.getAttribute("id"));

        if (orderBindingResult.hasErrors()) {   
            Cart cart = this.cartService.getCartByUser(currentUser);
            List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
            BigDecimal totalPrice = BigDecimal.ZERO;
            for (CartDetail cartDetail : cartDetails) {
                BigDecimal price = cartDetail.getPrice();
                BigDecimal quantity = BigDecimal.valueOf(cartDetail.getQuantity());
                totalPrice = totalPrice.add(price.multiply(quantity));
            }
            model.addAttribute("cartDetails", cartDetails);
            model.addAttribute("totalPrice", totalPrice);
            return "client/cart/checkout";
        }
        
        this.orderService.handlePlaceOrder(session, currentUser, orderDTO);

        return "redirect:/";
    }


    @GetMapping("/order-history")
    public String getHistoryPage(Model model, HttpServletRequest request){
        HttpSession session = request.getSession();
        User currentUser = new User();
        currentUser.setId((long) session.getAttribute("id"));

        List<Order> orders = this.orderService.getAllByUser(currentUser);
        model.addAttribute("orders",orders);
        return "client/history/order_history";
    }
}
