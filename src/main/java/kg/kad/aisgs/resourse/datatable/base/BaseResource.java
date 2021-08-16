package kg.kad.aisgs.resourse.datatable.base;

import com.fasterxml.jackson.annotation.JsonProperty;
import kg.kad.aisgs.resourse.datatable.RowData;
import kg.kad.aisgs.resourse.datatable.TableRowResource;
import org.springframework.hateoas.ResourceSupport;

import java.io.Serializable;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 15.08.2021
 */
public class BaseResource extends ResourceSupport implements TableRowResource, Serializable {

    @JsonProperty
    public String id;

    public String rowClass;

    public void setRowClass(String rowClass) {
        this.rowClass = rowClass;
    }

    public String getRowClass() {
        return rowClass;
    }

    @Override
    public String getDT_RowId() {
        return String.format("row_%s", id);
    }

    @Override
    public String getDT_RowClass() {
        return rowClass;
    }

    @Override
    public RowData getDT_RowData() {
        return null;
    }
}
