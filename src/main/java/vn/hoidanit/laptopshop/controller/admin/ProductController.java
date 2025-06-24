package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

@Controller
public class ProductController {

    private final ProductService productService;
    private final UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model) {
        List<Product> products= this.productService.getAllProducts();
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(@PathVariable long id, Model model){
        Product product = this.productService.getOneProductById(id);
        model.addAttribute("product",product);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProducBindingResult,
            @RequestParam("productFileTest") MultipartFile file
    ) {
        if (newProducBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String productImage = this.uploadService.handleSaveUploadFile(file, "product");
        product.setImage(productImage);
        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(@PathVariable long id, Model model){
        Product product = this.productService.getOneProductById(id);
        model.addAttribute("product",product);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String updateProduct(
        @ModelAttribute("product") @Valid Product product,
        BindingResult productBindingResult,
        @RequestParam("productFileTest") MultipartFile file){

        Product oldProduct = this.productService.getOneProductById(product.getId());

        if(productBindingResult.hasErrors()){
            product.setImage(oldProduct.getImage());
            return "admin/product/update";
        }
        
        if(oldProduct!= null){
            if(!file.isEmpty()){
                String imageProduct = this.uploadService.handleSaveUploadFile(file, "product");
                oldProduct.setImage(imageProduct);
            }
            oldProduct.setName(product.getName());
            oldProduct.setPrice(product.getPrice());
            oldProduct.setDetailDesc(product.getDetailDesc());
            oldProduct.setShortDesc(product.getShortDesc());
            oldProduct.setQuantity(product.getQuantity());
            oldProduct.setFactory(product.getFactory());
            oldProduct.setTarget(product.getTarget());
            this.productService.handleSaveProduct(oldProduct);
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(@PathVariable long id, Model model){
        model.addAttribute("id",id);
        model.addAttribute("product",new Product());
        return "admin/product/delete"; 
    }

    @PostMapping("/admin/product/delete")
    public String deleteProduct(@ModelAttribute("product") Product product){
        this.productService.deleteOneProductById(product.getId());
        return "redirect:/admin/product";
    }

}
