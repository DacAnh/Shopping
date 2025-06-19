package vn.hoidanit.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts(){
        return this.productRepository.findAll();
    }

    public Product getOneProductById( long id){
        return this.productRepository.findById(id).get();
    }

    public Product handleSaveProduct(Product newProduct){
        return this.productRepository.save(newProduct);
    }

    public void deleteOneProductById(long id){
        this.productRepository.deleteById(id);
    }
    
}
