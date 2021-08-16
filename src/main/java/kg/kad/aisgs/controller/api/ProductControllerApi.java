package kg.kad.aisgs.controller.api;

import com.querydsl.core.types.Predicate;
import kg.kad.aisgs.assembler.datatable.product.ProductResourceAssembler;
import kg.kad.aisgs.entity.product.Product;
import kg.kad.aisgs.resourse.datatable.ProductResource;
import kg.kad.aisgs.resourse.datatable.TableResource;
import kg.kad.aisgs.service.product.ProductService;
import kg.kad.aisgs.table.core.TableRequestData;
import org.springframework.data.querydsl.binding.QuerydslPredicate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 15.08.2021
 */
@RestController
@RequestMapping("/api/product")
public class ProductControllerApi {

    private final ProductResourceAssembler productResourceAssembler;
    private final ProductService service;

    public ProductControllerApi(
            ProductResourceAssembler productResourceAssembler,
            ProductService service
    ) {
        this.productResourceAssembler = productResourceAssembler;
        this.service = service;
    }

    @PostMapping("/table")
    public TableResource<ProductResource> table(
            @QuerydslPredicate(root = Product.class) Predicate predicate,
            @RequestBody TableRequestData requestData
    ) {
        return productResourceAssembler.toTableResource(
                service.findAll(predicate, requestData.getPageable()),
                requestData
        );
    }
}
