package kg.kad.aisgs.service.crud;

import kg.kad.aisgs.entity.base.BaseEntity;

import javax.validation.constraints.NotNull;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
public interface FormCrudService<F, E extends BaseEntity> extends CrudService<E> {

    E create(
            @NotNull F f
    );

    E update(
            @NotNull F f,
            @NotNull E e
    );

}
