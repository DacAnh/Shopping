package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.hoidanit.laptopshop.domain.dto.DashboardDTO;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class DashboardController {
    private final UserService userService;

    public DashboardController(UserService userService) {
        this.userService = userService;
    }


    @GetMapping("/admin")
    public String getDashboard(Model model){
        DashboardDTO dashboardDTO = this.userService.getCountInDashboard();
        model.addAttribute("dashboardDTO", dashboardDTO);
        return "admin/dashboard/show";
    }
}
