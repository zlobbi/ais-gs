package kg.kad.aisgs.entity;

import kg.kad.aisgs.entity.base.BaseEntity;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
public class Supplier extends BaseEntity {

    private static final long serialVersionUID = -3515218750171200286L;

    @NotBlank
    private String name;

    @NotBlank
    @Column(length = 14, unique = true)
    private String pin;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;
}
