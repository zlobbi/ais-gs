package kg.kad.aisgs.entity.product;

import kg.kad.aisgs.entity.base.TimedEntity;
import lombok.*;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Incoming extends TimedEntity {

    @OneToOne(optional = false)
    @JoinColumn(name = "in_stock_id")
    private InStock inStock;

    private Double quantity;

    private Double purchaseSum;
}
