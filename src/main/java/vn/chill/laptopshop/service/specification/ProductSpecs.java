package vn.chill.laptopshop.service.specification;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import vn.chill.laptopshop.domain.Product;
import vn.chill.laptopshop.domain.Product_;

public class ProductSpecs {
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) 
            -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }



    //case 1
    public static Specification<Product> minPrice(BigDecimal price){
        return (root, query, criteriaBuilder)
            -> criteriaBuilder.ge(root.get(Product_.PRICE), price);
    }

    //case 2
    public static Specification<Product> maxPrice(BigDecimal price){
        return (root, query, criteriaBuilder)
            -> criteriaBuilder.le(root.get(Product_.PRICE), price);
    }

    //case 3
    public static Specification<Product> matchListFactory(List<String> factory) {
        return (root, query, criteriaBuilder) 
            -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    public static Specification<Product> matchListTarget(List<String> target) {
        return (root, query, criteriaBuilder) 
            -> criteriaBuilder.in(root.get(Product_.TARGET)).value(target);
    }

    //case 4
    public static Specification<Product> matchPrice(BigDecimal min, BigDecimal max) {
        return (root, query, criteriaBuilder) 
            -> criteriaBuilder.and(
                    criteriaBuilder.ge(root.get(Product_.PRICE),min),
                    criteriaBuilder.le(root.get(Product_.PRICE),max)
            );
    }

    //case 5
    public static Specification<Product> matchMultiPrice(BigDecimal min, BigDecimal max) {
        return (root, query, criteriaBuilder) 
            -> criteriaBuilder.between(root.get(Product_.PRICE),min,max);
    }
    
}
