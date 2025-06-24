package vn.hoidanit.laptopshop.domain.dto;

public class DashboardDTO {
    private long countUser;
    private long countProduct;
    private long countOrder;
    
    public long getCountUser() {
        return countUser;
    }
    public void setCountUser(long countUser) {
        this.countUser = countUser;
    }
    public long getCountProduct() {
        return countProduct;
    }
    public void setCountProduct(long countProduct) {
        this.countProduct = countProduct;
    }
    public long getCountOrder() {
        return countOrder;
    }
    public void setCountOrder(long countOrder) {
        this.countOrder = countOrder;
    }
    
}
