package kg.kad.aisgs.repository.product;

import kg.kad.aisgs.entity.product.Incoming;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public interface IncomingRepository extends JpaRepository<Incoming, Long>,
        QuerydslPredicateExecutor<Incoming> {
}
