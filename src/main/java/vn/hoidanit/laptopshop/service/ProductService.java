package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public ProductService(
            ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            UserService userService) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
    }

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }

    public Product getOneProductById(long id) {
        return this.productRepository.findById(id).get();
    }

    public Product handleSaveProduct(Product newProduct) {
        return this.productRepository.save(newProduct);
    }

    public void deleteOneProductById(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(HttpSession session, long id) {
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setSum(0);
                newCart.setUser(user);
                cart = this.cartRepository.save(newCart);
            }

            Optional<Product> productOptional = this.productRepository.findById(id);
            if (productOptional.isPresent()) {
                Product product = productOptional.get();

                CartDetail oldCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (oldCartDetail == null) {
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(product);
                    cartDetail.setQuantity(1);
                    cartDetail.setPrice(product.getPrice());

                    this.cartDetailRepository.save(cartDetail);
                    int currentSum = cart.getSum()+1;
                    cart.setSum(currentSum);
                    this.cartRepository.save(cart);

                    session.setAttribute("sumCart", currentSum);
                } else {
                    oldCartDetail.setQuantity(oldCartDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oldCartDetail);
                }
            }
        }
    }

    public Cart getCartByUser(User user){
        return this.cartRepository.findByUser(user);
    }
}
