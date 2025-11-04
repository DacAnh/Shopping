package vn.chill.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.chill.laptopshop.domain.Cart;
import vn.chill.laptopshop.domain.CartDetail;
import vn.chill.laptopshop.domain.User;
import vn.chill.laptopshop.repository.CartRepository;

@Service
public class CartService {
    private final CartRepository cartRepository;
    private final CartDetailService cartDetailService;

    public CartService(
            CartRepository cartRepository,
            CartDetailService cartDetailService) {
        this.cartRepository = cartRepository;
        this.cartDetailService = cartDetailService;
    }

    public Cart getCartByUser(User user){
        return this.cartRepository.findByUser(user);
    }
    
    public Cart handleSaveCart(Cart cart){
        return this.cartRepository.save(cart);
    }

    public void remove(Cart cart){
        this.cartRepository.delete(cart);
    }

    public void handleUpdateCartBeforeCheckout( List<CartDetail> cartDetails ){
        for( CartDetail cartDetail : cartDetails){
            CartDetail oldCartDetal = this.cartDetailService.getOneCartDetailById(cartDetail.getId());
            oldCartDetal.setQuantity(cartDetail.getQuantity());
            this.cartDetailService.handleCartDetail(oldCartDetal);
        }
    }

}
