package vn.chill.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.chill.laptopshop.domain.User;
import vn.chill.laptopshop.service.UploadService;
import vn.chill.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;

    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, 
    UploadService uploadService, 
    PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    // @RequestMapping("/")
    // public String getHomePage(Model model) {
    //     List<User> arrUsers = this.userService.getAllUsersByEmail("huyen@gmail.com");
    //     System.out.println("Tat ca du lieu: " + arrUsers);
    //     model.addAttribute("newUser", new User());
    //     return "hello";
    // }

    @RequestMapping("/admin/user")
    public String getUserInfo(Model model,
            @RequestParam("page") Optional<String> pageOptional) {
        int page=1;
        try {
            if(pageOptional.isPresent()){
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Pageable pageable = PageRequest.of(page-1, 2);
        Page<User> users = userService.getAllUsersByPage(pageable);
        List<User> listUsers = users.getContent();
        model.addAttribute("users", listUsers);
        model.addAttribute("totalPages", users.getTotalPages());
        model.addAttribute("currentPage", page);
        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getOneUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserInfo(
            @ModelAttribute("newUser") @Valid User user,
            BindingResult newUserBindingResult,
            // Phải đặt bindingResult ngay sau biến cần validation.
            //  Nếu không thì sẽ không chạy valid được
            @RequestParam("avatarFileTest") MultipartFile file) {

        // List<FieldError> errors = newUserBindingResult.getFieldErrors();
        // for( FieldError error : errors){
        //     System.out.println();
        // }

        if(newUserBindingResult.hasErrors()){
            return "admin/user/create";
        }
        
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setAvatar(avatar);
        user.setPassword(hashPassword);
        user.setRole(
            this.userService.getRoleByName(user.getRole().getName())
        );
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getOneUserById(id);
        model.addAttribute("user", user);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String updateUserInfo(Model model, 
    @ModelAttribute("user") User currentUser,
    @RequestParam("avatarFileTest") MultipartFile file) {
        User oldUser = this.userService.getOneUserById(currentUser.getId());
        if (oldUser != null) {
            String nameFile= file.getOriginalFilename();
            if(!nameFile.equals("")){
                String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
                oldUser.setAvatar(avatar);
            }
            oldUser.setRole(this.userService.getRoleByName(currentUser.getRole().getName()));
            oldUser.setFullName(currentUser.getFullName());
            oldUser.setAddress(currentUser.getAddress());
            oldUser.setPhone(currentUser.getPhone());
            this.userService.handleSaveUser(oldUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("user", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String deleteUserInfo(@ModelAttribute("user") User user) {
        System.out.println("Data voi id= " + user.getId());
        this.userService.deleteOneUserById(user.getId());
        return "redirect:/admin/user";
    }
}
