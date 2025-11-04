package vn.chill.laptopshop.service;

import org.springframework.stereotype.Service;

import vn.chill.laptopshop.domain.CartDetail;
import vn.chill.laptopshop.repository.CartDetailRepository;

@Service
public class CartDetailService {
    private final CartDetailRepository cartDetailRepository;

    public CartDetailService(CartDetailRepository cartDetailRepository) {
        this.cartDetailRepository = cartDetailRepository;
    }

    public CartDetail getOneCartDetailById(long id){
        return this.cartDetailRepository.findById(id).get();
    }

    public void remove(CartDetail cartDetail){
        this.cartDetailRepository.delete(cartDetail);
    }

    public CartDetail handleCartDetail(CartDetail cartDetail){
        return this.cartDetailRepository.save(cartDetail);
    }
}
