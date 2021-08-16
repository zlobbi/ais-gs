package kg.kad.aisgs.service.product;

import kg.kad.aisgs.entity.product.Product;
import kg.kad.aisgs.form.product.ProductForm;
import kg.kad.aisgs.repository.product.ProductRepository;
import kg.kad.aisgs.service.crud.AbstractCrudService;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
@Service
public class ProductService extends AbstractCrudService<ProductForm, Product> {

    public ProductService(
            ProductRepository repository,
            QuerydslPredicateExecutor<Product> predicateExecutor
    ) {
        super(repository, predicateExecutor);
    }

    @Override
    public Product create(ProductForm productForm) {
        return save(
                Product.builder()
                        .name(productForm.getName())
                        .unit(productForm.getUnit())
                        .description(productForm.getDescription())
                        .build()
        );
    }

    @Override
    public Product update(ProductForm productForm, Product product) {
        product.setName(productForm.getName());
        product.setUnit(productForm.getUnit());
        product.setDescription(productForm.getDescription());
        return save(product);
    }

    public List<Product> findAll() {
        return repository.findAll();
    }
}
