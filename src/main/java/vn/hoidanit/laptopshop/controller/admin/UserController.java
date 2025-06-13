package vn.hoidanit.laptopshop.controller.admin;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;

    public UserController(UserService userService, UploadService uploadService) {
        this.userService = userService;
        this.uploadService = uploadService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUsers = this.userService.getAllUsersByEmail("huyen@gmail.com");
        System.out.println("Tat ca du lieu: " + arrUsers);
        model.addAttribute("newUser", new User());
        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUserInfo(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "/admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getOneUserById(id);
        model.addAttribute("user", user);
        return "/admin/user/detail";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "/admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserInfo(
            Model model,
            @ModelAttribute("newUser") User user,
            @RequestParam("avatarFileTest") MultipartFile file) {
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getOneUserById(id);
        model.addAttribute("user", user);
        return "/admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String updateUserInfo(Model model, @ModelAttribute("user") User currentUser) {
        User oldUser = this.userService.getOneUserById(currentUser.getId());
        if (oldUser != null) {
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
        return "/admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String deleteUserInfo(@ModelAttribute("user") User user) {
        System.out.println("Data voi id= " + user.getId());
        this.userService.deleteOneUserById(user.getId());
        return "redirect:/admin/user";
    }
}
