package vn.hoidanit.laptopshop.service;

import java.util.Collections;

import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.service.brute_force.LoginAttemptService;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;
    private final LoginAttemptService loginAttemptService;

    public CustomUserDetailsService(UserService userService, LoginAttemptService loginAttemptService) {
        this.userService = userService;
        this.loginAttemptService = loginAttemptService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        if (loginAttemptService.isBlocked(username)) {
            throw new LockedException("Locked");
        }
        // Logic
        vn.hoidanit.laptopshop.domain.User user = this.userService.getUserByEmail(username);
        if(user==null){
            loginAttemptService.loginFailed(username);
            throw new UsernameNotFoundException("User not found");
            // Hiện log trên server thay vì hiển thị ra trình duyệt bằng cách cấu hình Spring Security
        }

        
        return new org.springframework.security.core.userdetails.User(
            user.getEmail(),
            user.getPassword(),
            Collections.singletonList(new SimpleGrantedAuthority("ROLE_"+user.getRole().getName())));
            // Spring sẽ tự động thêm tiền tố ROLE_ cho vai trò nhưng vì tự custom nên cần phải
            //tự thêm tiền tố để cơ chế xác thực hoạt động (hàm hasRole sẽ tự bỏ ROLE để lấy
            //phần vai trò)
    }
    
}
