package kg.kad.aisgs.entity;

import kg.kad.aisgs.entity.base.BaseEntity;
import kg.kad.aisgs.util.UnitEnum;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Product extends BaseEntity {

    private static final long serialVersionUID = 2431613158820531769L;

    @NotBlank
    private String name;

    @NotNull
    @Enumerated(value = EnumType.STRING)
    private UnitEnum unit;

    private Double amount;
}
