package kg.kad.aisgs.resourse.datatable;

import kg.kad.aisgs.resourse.datatable.base.BaseResource;
import lombok.Getter;
import lombok.Setter;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 15.08.2021
 */
@Getter
@Setter
public class ProductResource extends BaseResource {

    private static final long serialVersionUID = 9112109697958328992L;

    private String name;

    private String unit;

    private String description;

    private String createdAt;
}