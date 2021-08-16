package kg.kad.aisgs.controller.web.product;

import kg.kad.aisgs.controller.web.crud.AbstractCrudController;
import kg.kad.aisgs.entity.product.Product;
import kg.kad.aisgs.form.product.ProductForm;
import kg.kad.aisgs.service.product.ProductService;
import kg.kad.aisgs.table.product.ProductTableBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Controller
@RequestMapping("/product")
public class ProductController extends AbstractCrudController<ProductForm, Product> {

    private final ProductService service;
    private final ProductTableBuilder productTableBuilder;

    public ProductController(
            ProductService service,
            ProductTableBuilder productTableBuilder
    ) {
        super(service);
        this.service = service;
        this.productTableBuilder = productTableBuilder;
    }

    @GetMapping
    public ModelAndView productPage() {
        return new ModelAndView(String.format("%s/products", templates()))
                .addObject("domain", new ProductForm())
                .addObject("products", productTableBuilder.getTableAll());
    }

    @Override
    public String templates() {
        return "/product";
    }

    @Override
    public String url() {
        return "/product";
    }
}
