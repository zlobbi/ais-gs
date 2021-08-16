package kg.kad.aisgs.assembler.datatable.product;

import kg.kad.aisgs.assembler.datatable.DataTableResourceAssembler;
import kg.kad.aisgs.controller.api.ProductControllerApi;
import kg.kad.aisgs.entity.product.Product;
import kg.kad.aisgs.resourse.datatable.ProductResource;
import kg.kad.aisgs.util.TimeHelper;
import org.springframework.stereotype.Component;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 16.08.2021
 */
@Component
public class ProductResourceAssembler extends DataTableResourceAssembler<Product, ProductResource> {

    public ProductResourceAssembler() {
        super(ProductControllerApi.class, ProductResource.class);
    }

    @Override
    public ProductResource toResource(Product entity) {
        ProductResource resource = createResourceWithId(entity.getId(), entity);
        resource.setName(entity.getName());
        resource.setUnit(entity.getUnit().toString());
        resource.setDescription(entity.getDescription());
        resource.setCreatedAt(entity.getCreatedAt().format(TimeHelper.DATE_TIME_FORMATTER));

        return resource;
    }
}
