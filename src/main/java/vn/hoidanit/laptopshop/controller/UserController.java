package vn.hoidanit.laptopshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUsers= this.userService.getAllUsersByEmail("huyen@gmail.com");
        System.out.println("Tat ca du lieu: "+ arrUsers);
        model.addAttribute("newUser", new User());
        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUserInfo(Model model){
        List<User> users = userService.getAllUsers();
        model.addAttribute("users",users);
        return "/admin/user/table-user";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id){
        User user = this.userService.getOneUserById(id);
        model.addAttribute("user",user);
        return "/admin/user/show";
    }

    @RequestMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "/admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUserInfo(Model model, @ModelAttribute("newUser") User user) {
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getOneUserById(id);
        model.addAttribute("user", user);
        return "/admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String updateUserInfo(Model model, @ModelAttribute("user") User currentUser) {
        User oldUser = this.userService.getOneUserById(currentUser.getId());
        if(oldUser!=null){
            oldUser.setFullName(currentUser.getFullName());
            oldUser.setAddress(currentUser.getAddress());
            oldUser.setPhone(currentUser.getPhone());
            this.userService.handleSaveUser(oldUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id){
        model.addAttribute("id", id);
        model.addAttribute("user", new User());
        return "/admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String deleteUserInfo(@ModelAttribute("user") User user){
        System.out.println("Data voi id= "+ user.getId());
        this.userService.deleteOneUserById(user.getId());
        return "redirect:/admin/user";
    }
}
