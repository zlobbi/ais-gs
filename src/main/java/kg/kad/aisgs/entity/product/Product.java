package kg.kad.aisgs.entity.product;

import kg.kad.aisgs.entity.base.TimedEntity;
import kg.kad.aisgs.util.UnitEnum;
import lombok.*;
import org.hibernate.envers.Audited;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Audited
@Entity
public class Product extends TimedEntity {

    private static final long serialVersionUID = 2431613158820531769L;

    @NotBlank
    private String name;

    @NotNull
    @Enumerated(value = EnumType.STRING)
    private UnitEnum unit;

    private String description;

    @OneToOne(mappedBy = "product")
    private InStock inStock;
}