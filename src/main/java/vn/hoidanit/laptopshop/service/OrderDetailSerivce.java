package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;

@Service
public class OrderDetailSerivce {
    private final OrderDetailRepository orderDetailRepository;

    public OrderDetailSerivce(OrderDetailRepository orderDetailRepository) {
        this.orderDetailRepository = orderDetailRepository;
    }
    

    public List<OrderDetail> getAllByOrder(Order order){
        return this.orderDetailRepository.findByOrder(order);
    }

    public void remove(OrderDetail orderDetail){
        this.orderDetailRepository.delete(orderDetail);
    }
}
