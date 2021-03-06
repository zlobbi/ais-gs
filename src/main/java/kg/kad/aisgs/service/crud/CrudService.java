package kg.kad.aisgs.service.crud;

import com.querydsl.core.types.Predicate;
import kg.kad.aisgs.entity.base.BaseEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.validation.constraints.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public interface CrudService<E extends BaseEntity> {

    @NotNull
    Page<E> findAll(
            Predicate predicate,
            @NotNull Pageable pageable
    );

    @NotNull
    E save(
            @NotNull E e
    );

    void delete(
            @NotNull E e
    );
}
