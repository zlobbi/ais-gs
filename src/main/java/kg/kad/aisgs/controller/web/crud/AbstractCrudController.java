package kg.kad.aisgs.controller.web.crud;

import kg.kad.aisgs.entity.base.BaseEntity;
import kg.kad.aisgs.service.crud.FormCrudService;
import org.jetbrains.annotations.NotNull;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
public abstract class AbstractCrudController<F, E extends BaseEntity> implements CrudController {

    protected final FormCrudService<F, E> service;

    public AbstractCrudController(
            @NotNull FormCrudService<F, E> service
    ) {
        this.service = service;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setAutoGrowCollectionLimit(1000);
    }

}
