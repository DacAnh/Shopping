package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import vn.hoidanit.laptopshop.service.validator.RegisterChecked;

@RegisterChecked
public class RegisterDTO {
    @Email(message = "Email không phù hợp", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;
    @Size(min = 2,message = "Tên không được để trống")
    private String firstName;
    private String lastName;
    @Size(min = 5, message = "Mật khẩu phải có 5 ký tự trở lên")
    private String password;
    private String confirmPassword;
    
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getConfirmPassword() {
        return confirmPassword;
    }
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
    
}
