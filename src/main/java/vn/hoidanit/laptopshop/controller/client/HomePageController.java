package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(ProductService productService,
        UserService userService,
        PasswordEncoder passwordEncoder) {
            this.productService = productService;
            this.userService = userService;
            this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/")
    public String getHomePage(Model model){
        Pageable pageable= PageRequest.of(0, 10);
        Page<Product> products= this.productService.getAllProductsByPage(pageable);
        List<Product> listProducts = products.getContent();
        model.addAttribute("products",listProducts);
        return "client/homepage/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model){
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String register(
    @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
    BindingResult registerDTOBindingResult){

        if(registerDTOBindingResult.hasErrors()){
            return "client/auth/register";
        }
        User user = this.userService.registerDTOtoUser(registerDTO);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model){
        model.addAttribute("loginUser", new RegisterDTO());
        return "client/auth/login";
    }

    @PostMapping("/login")
    public String login(
        @ModelAttribute("loginUser") @Valid RegisterDTO userDTO,
        BindingResult loginUserBindingResult){
            if(loginUserBindingResult.hasErrors()){
                return "client/auth/login";
            }
            return "redirect:/";
    }

    

    @GetMapping("/access-deny")
    public String getDenyPage(){
        return "client/auth/access_deny";
    }

}
