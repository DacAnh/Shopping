package vn.hoidanit.laptopshop.controller.client;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.OrderDTO;
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
        this.productService.handleAddProductToCart(session, id);
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
}
