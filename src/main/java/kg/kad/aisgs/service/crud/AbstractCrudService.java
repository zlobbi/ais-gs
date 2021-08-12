package kg.kad.aisgs.service.crud;

import com.querydsl.core.types.Predicate;
import kg.kad.aisgs.entity.base.BaseEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import javax.validation.constraints.NotNull;

/**
 * @author kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public abstract class AbstractCrudService<F, E extends BaseEntity> implements FormCrudService<F, E> {

    protected final JpaRepository<E, Long> repository;
    protected final QuerydslPredicateExecutor<E> predicateExecutor;

    public AbstractCrudService(
            JpaRepository<E, Long> repository,
            QuerydslPredicateExecutor<E> predicateExecutor
    ) {
        this.repository = repository;
        this.predicateExecutor = predicateExecutor;
    }

    @NotNull
    @Override
    public Page<E> findAll(Predicate predicate, @NotNull Pageable pageable) {
        return predicateExecutor.findAll(predicate, pageable);
    }

    @NotNull
    @Override
    public E save(@NotNull E e) {
        return repository.save(e);
    }

    @Override
    public void delete(@NotNull E e) {
        repository.delete(e);
    }

}
