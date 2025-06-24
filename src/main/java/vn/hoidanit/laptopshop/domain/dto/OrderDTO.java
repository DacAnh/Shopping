package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class OrderDTO {
    @Size(min = 2,message = "Tên không được để trống")
    private String name;
    @Size(min = 2,message = "Địa chỉ không được để trống")
    private String address;
    @Pattern(regexp="[\\d]{10}",message = "Cần nhập đúng số điện thoại")
    private String phone;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    
}
