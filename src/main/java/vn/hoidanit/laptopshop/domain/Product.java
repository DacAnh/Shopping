package vn.hoidanit.laptopshop.domain;


import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotNull
    @Size(min = 5, message = "Tên sản phẩm không được để trống")
    private String name;

    @NotNull
    @DecimalMin(value = "5", inclusive = false, message = "Giá sản phẩm phải lớn hơn 10.000 VNĐ")
    private BigDecimal price;

    private String image;

    @NotNull
    @Size(min = 10, message = "Mô tả chi tiết tối thiểu 10 ký tự")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;
    @NotNull
    @Size(min = 5, message = "Mô tả ngắn tối thiểu 5 ký tự")
    private String shortDesc;

    @NotNull
    @Min(value = 1, message = "Số lượng phải lớn hơn hoặc bằng 1")
    private long quantity;
    private long sold;
    private String factory;
    private String target;

    // @OneToMany(mappedBy = "product")
    // private List<OrderDetail> orderDetails;

    public Product() {
    }
    public Product(long id, String name, BigDecimal price, String image, String detailDesc, String shortDesc, long quantity,
            long sold, String factory, String target) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.detailDesc = detailDesc;
        this.shortDesc = shortDesc;
        this.quantity = quantity;
        this.sold = sold;
        this.factory = factory;
        this.target = target;
    }

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public BigDecimal getPrice() {
        return price;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getDetailDesc() {
        return detailDesc;
    }
    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }
    public String getShortDesc() {
        return shortDesc;
    }
    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }
    public long getQuantity() {
        return quantity;
    }
    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }
    public long getSold() {
        return sold;
    }
    public void setSold(long sold) {
        this.sold = sold;
    }
    public String getFactory() {
        return factory;
    }
    public void setFactory(String factory) {
        this.factory = factory;
    }
    public String getTarget() {
        return target;
    }
    public void setTarget(String target) {
        this.target = target;
    }
    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + ", image=" + image + ", detailDesc="
                + detailDesc + ", shortDesc=" + shortDesc + ", quantity=" + quantity + ", sold=" + sold + ", factory="
                + factory + ", target=" + target + "]";
    }

    
}
