package kg.kad.aisgs.entity.product;

import kg.kad.aisgs.entity.base.TimedEntity;
import lombok.*;
import org.hibernate.envers.Audited;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Audited
@Entity
public class InStock extends TimedEntity {

    @OneToOne(optional = false)
    @JoinColumn(name = "product_id")
    private Product product;

    private Double quantity;

    private Double receivedQty;

    private Double remainingQty;

    @NotNull
    private Double purchasePrice;

    private Double sellingPrice;

    private String notice;

    @OneToOne(mappedBy = "inStock")
    private Incoming incoming;

    @OneToOne(mappedBy = "inStock")
    private Outgoing outgoing;
}
