package vn.hoidanit.laptopshop.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.constant.SystemConstant;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.OrderDTO;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository,
            CartRepository cartRepository, CartDetailRepository cartDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
    }

    public void handlePlaceOrder(HttpSession session, 
            User currentUser, 
            OrderDTO orderDTO){

        // Tạo orderDetail bằng cách lấy cartDetails từ cart
        Cart cart = this.cartRepository.findByUser(currentUser);
        if(cart!=null){    

            List<CartDetail> cartDetails = cart.getCartDetails();

            if(!cartDetails.isEmpty()){

                Order order = new Order();
                order.setUser(currentUser);
                order.setReceiverName(orderDTO.getName());
                order.setReceiverPhone(orderDTO.getPhone());
                order.setReceiverAddress(orderDTO.getAddress());
                order.setStatus(SystemConstant.PENDING);
                BigDecimal totalPrice = BigDecimal.ZERO;
                for(CartDetail cartDetail : cartDetails){
                    totalPrice = totalPrice.add(cartDetail.getPrice());
                }
                order.setTotalPrice(totalPrice);
                // Lưu order xuống Db đồng thời nhận thêm id của order
                order = this.orderRepository.save(order);

                for(CartDetail cartDetail : cartDetails){
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setPrice(cartDetail.getPrice());
                    orderDetail.setProduct(cartDetail.getProduct());
                    orderDetail.setQuantity(cartDetail.getQuantity());
                    this.orderDetailRepository.save(orderDetail);

                    // Có thể xóa cartDetail luôn tại đây!
                    this.cartDetailRepository.delete(cartDetail);
                }
                // Xóa cartDetail và cart
                // for(CartDetail cartDetail : cartDetails){
                //     this.cartDetailRepository.delete(cartDetail);
                // }
                this.cartRepository.delete(cart);

                // Cập nhật sumCart tại session
                session.setAttribute("sumCart", 0);
            }
        }
    }

    public List<Order> getAllOrder(){
        return this.orderRepository.findAll();
    }

    public Page<Order> getAllOrderByPage(Pageable pageable){
        return this.orderRepository.findAll(pageable);
    }

    public Order getOneOrder(long id){
        return this.orderRepository.findById(id).get();
    }

    public List<Order> getAllByUser(User user){
        return this.orderRepository.findAllByUser(user);
    }

    public Order handleSaveOrder(Order order){
        return this.orderRepository.save(order);
    }

    public void remove(Order order){
        this.orderRepository.delete(order);
    }
}
