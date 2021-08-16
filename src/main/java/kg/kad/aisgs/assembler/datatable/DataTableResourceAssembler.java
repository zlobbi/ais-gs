package kg.kad.aisgs.assembler.datatable;

import kg.kad.aisgs.entity.base.BaseEntity;
import kg.kad.aisgs.resourse.datatable.TableResource;
import kg.kad.aisgs.resourse.datatable.base.BaseResource;
import kg.kad.aisgs.table.core.TableRequestData;
import org.springframework.data.domain.Page;
import org.springframework.hateoas.mvc.ResourceAssemblerSupport;

import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 16.08.2021
 */
abstract public class DataTableResourceAssembler<T extends BaseEntity, D extends BaseResource> extends ResourceAssemblerSupport<T, D> {

    public DataTableResourceAssembler(Class<?> controllerClass, Class<D> resourceType) {
        super(controllerClass, resourceType);
    }

    public TableResource<D> toTableResource(Page<T> page, TableRequestData requestData) {
        TableResource<D> tableResource = new TableResource<>();

        List<D> data = toResources(page.getContent());

        tableResource.setDraw(requestData.getDraw() + 1);
        tableResource.setRecordsTotal(page.getTotalElements());
        tableResource.setRecordsFiltered(page.getTotalElements());
        tableResource.setData(data);

        return tableResource;
    }

    @Override
    protected D createResourceWithId(Object id, T entity) {
        D d = super.createResourceWithId(id, entity);
        return d;
    }
}