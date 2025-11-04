package vn.chill.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.chill.laptopshop.domain.Cart;
import vn.chill.laptopshop.domain.CartDetail;
import vn.chill.laptopshop.domain.Product;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    CartDetail findByCartAndProduct(Cart cart, Product product);
    List<CartDetail> findAllByCart(Cart cart);
}
