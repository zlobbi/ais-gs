package kg.kad.aisgs.repository;

import kg.kad.aisgs.entity.QSupplier;
import kg.kad.aisgs.entity.Supplier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;

import javax.validation.constraints.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public interface SupplierRepository extends JpaRepository<Supplier, Long>,
        QuerydslPredicateExecutor<Supplier>, QuerydslBinderCustomizer<QSupplier> {

    @Override
    default void customize(@NotNull QuerydslBindings bindings, @NotNull QSupplier root) {
    }
}
