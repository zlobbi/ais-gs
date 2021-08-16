package kg.kad.aisgs.form.product;

import kg.kad.aisgs.entity.product.Product;
import kg.kad.aisgs.util.UnitEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductForm {

    @NotBlank
    private String name;

    @NotNull
    private UnitEnum unit;

    private String description;

    public ProductForm(Product product) {
        this.name = product.getName();
        this.unit = product.getUnit();
        this.description = product.getDescription();
    }
}