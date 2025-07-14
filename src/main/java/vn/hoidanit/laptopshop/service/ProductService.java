package vn.hoidanit.laptopshop.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.ProductCriterialDTO;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.service.specification.ProductSpecs;

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

    //case 1
    // public Page<Product> handleProductsWithSpec(Pageable page, BigDecimal min){
    //     return this.productRepository.findAll(ProductSpecs.minPrice(min), page);
    // }

    //case 2
    // public Page<Product> handleProductsWithSpec(Pageable page, BigDecimal max){
    //     return this.productRepository.findAll(ProductSpecs.maxPrice(max), page);
    // }

    //case 3
    // public Page<Product> handleProductsWithSpec(Pageable pageable, List<String> factory) {
    //     return this.productRepository.findAll(ProductSpecs.matchListFactory(factory), pageable);
    // }

    //case 4
    // public Page<Product> handleProductsWithSpec(Pageable pageable, String price) {

    //     if(price.equals("10-toi-15-trieu")){
    //         BigDecimal min = BigDecimal.valueOf(10000000);
    //         BigDecimal max = BigDecimal.valueOf(15000000);
    //         return this.productRepository.findAll(ProductSpecs.matchPrice(min, max),pageable);
    //     }
    //     else if (price.equals("15-toi-30-trieu")){
    //         BigDecimal min = BigDecimal.valueOf(15000000);
    //         BigDecimal max = BigDecimal.valueOf(30000000);
    //         return this.productRepository.findAll(ProductSpecs.matchPrice(min, max),pageable);
    //     }
    //     // nếu muốn nhiều tầm giá thì viết tiếp so sánh vào đây
    //     else return this.productRepository.findAll(pageable);
        
    // }

    //case 5
    public Specification<Product> buildPriceSpecification(List<String> priceList) {

        // Specification<Product> combinedSpec = (root, query, criteriaBuilder) -> criteriaBuilder.disjunction();
        // Dùng combinedSpec để cộng gộp nhiều query lại với nhau. Lý do cần disjunction là để tạo biến combinedSpec
        //khác null ( vì trong lần chạy đầu tiên thì chưa có query price nào cả ), nếu combinedSpec bằng null sẽ
        //trả ra lỗi vì cần dùng hàm or()

        Specification<Product> combinedSpec = Specification.where(null);
        // Tương tự như dùng api criteriaBuilder ở trên
        for(String price : priceList){
            BigDecimal min = BigDecimal.ZERO;
            BigDecimal max = BigDecimal.ZERO;

            switch (price) {
                case "duoi-10-trieu":
                    min= BigDecimal.valueOf(1);
                    max= BigDecimal.valueOf(10000000);
                    break;
                case "10-toi-15-trieu":
                    min= BigDecimal.valueOf(10000000);
                    max= BigDecimal.valueOf(15000000);
                    break;
                
                case "15-toi-20-trieu":
                    min= BigDecimal.valueOf(15000000);
                    max= BigDecimal.valueOf(20000000);
                    break;
                case "20-toi-30-trieu":
                    min= BigDecimal.valueOf(20000000);
                    max= BigDecimal.valueOf(30000000);
                    break;
                default:
                    break;
            }

            if ( !min.equals(BigDecimal.ZERO) && !max.equals(BigDecimal.ZERO) ){
                Specification<Product> rangeSpec = ProductSpecs.matchMultiPrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }

        }
        return combinedSpec;
    }

    public Page<Product> handleProductsWithSpec(Pageable page, ProductCriterialDTO productCriterialDTO){
        Specification<Product> combinedSpec = Specification.where(null);
        // Cần xét theo nhiều tiêu chí nên cần biến combinedSpec

        if(productCriterialDTO.getTarget().isPresent()){
            Specification<Product> currentSpecs = ProductSpecs
                                                    .matchListTarget(productCriterialDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if(productCriterialDTO.getFactory().isPresent()){
            Specification<Product> currentSpecs = ProductSpecs
                                                    .matchListFactory(productCriterialDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if(productCriterialDTO.getPrice().isPresent()){
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriterialDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    public Page<Product> getAllProductsByPage(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }

    public Page<Product> getAllProductsByName(Pageable pageable, String name) {
        return this.productRepository.findAll(ProductSpecs.nameLike(name), pageable);
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

    public void handleAddProductToCart(HttpSession session, long id, long quantity) {
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
                if(quantity==0) quantity=1;
                CartDetail oldCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (oldCartDetail == null) {
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(product);
                    cartDetail.setQuantity(quantity);
                    cartDetail.setPrice(product.getPrice());

                    this.cartDetailRepository.save(cartDetail);
                    int currentSum = cart.getSum() + 1;
                    cart.setSum(currentSum);
                    this.cartRepository.save(cart);

                    session.setAttribute("sumCart", currentSum);
                } else {
                    oldCartDetail.setQuantity(oldCartDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldCartDetail);
                }
            }
        }
    }

    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }
}
