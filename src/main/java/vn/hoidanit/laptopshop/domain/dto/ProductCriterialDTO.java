package vn.hoidanit.laptopshop.domain.dto;

import java.util.List;
import java.util.Optional;

public class ProductCriterialDTO {
    private Optional<String> page = Optional.empty();
    private Optional<String> name = Optional.empty();
    private Optional<String> sort = Optional.empty();
    private Optional<List<String>> target = Optional.empty();
    private Optional<List<String>> factory = Optional.empty();
    private Optional<List<String>> price = Optional.empty();
    // Phải đặt tên đúng theo tên định nghĩa trên query string (request param) thì spring boot mới tự động ghi dữ
    //liệu vào các trường này
    // Cần gán mặc định Optional.empty(); khi DTO khởi tạo để có thể getOptional().isPresent() mà không cần phải
    //check getOptional!=null

    public Optional<String> getPage() {
        return page;
    }
    public void setPage(Optional<String> page) {
        this.page = page;
    }
    public Optional<String> getName() {
        return name;
    }
    public void setName(Optional<String> name) {
        this.name = name;
    }
    public Optional<String> getSort() {
        return sort;
    }
    public void setSort(Optional<String> sort) {
        this.sort = sort;
    }
    public Optional<List<String>> getTarget() {
        return target;
    }
    public void setTarget(Optional<List<String>> target) {
        this.target = target;
    }
    public Optional<List<String>> getFactory() {
        return factory;
    }
    public void setFactory(Optional<List<String>> factory) {
        this.factory = factory;
    }
    public Optional<List<String>> getPrice() {
        return price;
    }
    public void setPrice(Optional<List<String>> price) {
        this.price = price;
    }

    
}
