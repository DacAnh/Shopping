package vn.chill.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.chill.laptopshop.domain.Order;
import vn.chill.laptopshop.domain.OrderDetail;
import vn.chill.laptopshop.service.OrderDetailSerivce;
import vn.chill.laptopshop.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;
    private final OrderDetailSerivce orderDetailSerivce;
    
    public OrderController(OrderService orderService, OrderDetailSerivce orderDetailSerivce) {
        this.orderService = orderService;
        this.orderDetailSerivce = orderDetailSerivce;
    }

    @GetMapping("/admin/order")
    public String getOrderPage(Model model,
            @RequestParam("page") Optional<String> pageOptional){
        int page=1;
        try {
            if(pageOptional.isPresent()){
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Pageable pageable = PageRequest.of(page-1, 2);
        Page<Order> orders= this.orderService.getAllOrderByPage(pageable);
        List<Order> listOrders = orders.getContent();
        model.addAttribute("orders", listOrders);
        model.addAttribute("totalPages", orders.getTotalPages());
        model.addAttribute("currentPage", page);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(@PathVariable long id, Model model){
        Order order = new Order();
        order.setId(id);
        List<OrderDetail> orderDetails = this.orderDetailSerivce.getAllByOrder(order);
        
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("orderId", id);
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderDetailPage(@PathVariable long id, Model model){
        Order order = this.orderService.getOneOrder(id);
        model.addAttribute("order", order);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String updateOrder(@ModelAttribute("order") Order order){
        Order oldOrder = this.orderService.getOneOrder(order.getId());
        if(oldOrder!=null){
            oldOrder.setStatus(order.getStatus());
            this.orderService.handleSaveOrder(oldOrder);
        }
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(@PathVariable long id, Model model){
        Order order= new Order();
        model.addAttribute("id",id);
        model.addAttribute("order",order);
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String deleteOrder(@ModelAttribute("order") Order order){
        order = this.orderService.getOneOrder(order.getId());
        List<OrderDetail> orderDetails = order.getOrderDetails();
        for(OrderDetail orderDetail : orderDetails){
            this.orderDetailSerivce.remove(orderDetail);
        }
        this.orderService.remove(order);
        return "redirect:/admin/order";
    }
}
