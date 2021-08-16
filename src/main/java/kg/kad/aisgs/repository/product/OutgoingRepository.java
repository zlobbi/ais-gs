package kg.kad.aisgs.repository.product;

import kg.kad.aisgs.entity.product.Outgoing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public interface OutgoingRepository extends JpaRepository<Outgoing, Long>,
        QuerydslPredicateExecutor<Outgoing> {
}
