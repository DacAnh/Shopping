package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.constant.SystemConstant;
import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.DashboardDTO;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public UserService(
                UserRepository userRepository, 
                RoleRepository roleRepository,
                ProductRepository productRepository,
                OrderRepository orderRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
    }

    public String handleUser(){
        return "Hello service";
    }

    public User getOneUserById(long id){
        return this.userRepository.findById(id).get();
    }

    public List<User> getAllUsers(){
        return this.userRepository.findAll();
    }
    public Page<User> getAllUsersByPage(Pageable pageable){
        return this.userRepository.findAll(pageable);
    }

    public List<User> getAllUsersByEmail(String email){
        return this.userRepository.findByEmail(email);
    }

    public User getUserByEmail(String email){
        return this.userRepository.findByEmail(email).get(0);
    }

    public User handleSaveUser(User user){
        return this.userRepository.save(user);
    }

    public void deleteOneUserById(long id){
        this.userRepository.deleteById(id);
    }

    public Role getRoleByName(String name){
        return this.roleRepository.findByName(name);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO){
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        user.setAvatar(SystemConstant.DEFAULT_AVATAR);
        return user;
    }

    public boolean checkEmailExist(String email){
        return this.userRepository.existsByEmail(email);
    }

    public DashboardDTO getCountInDashboard(){
        DashboardDTO dashboardDTO = new DashboardDTO();
        
        dashboardDTO.setCountUser(this.userRepository.count());
        dashboardDTO.setCountProduct(this.productRepository.count());
        dashboardDTO.setCountOrder(this.orderRepository.count());

        return dashboardDTO;
    }
}
