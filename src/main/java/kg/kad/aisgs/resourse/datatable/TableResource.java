package kg.kad.aisgs.resourse.datatable;

import com.fasterxml.jackson.annotation.JsonInclude;
import org.springframework.hateoas.ResourceSupport;

import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 11/8/21
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TableResource<T> extends ResourceSupport {

    private Integer draw;
    private Long recordsTotal;
    private Long recordsFiltered;

    private List<T> data;

    public List<T> getData() {
        return data;
    }

    public TableResource setData(List<T> data) {
        this.data = data;
        return this;
    }

    public Integer getDraw() {
        return draw;
    }

    public TableResource setDraw(Integer draw) {
        this.draw = draw;
        return this;
    }

    public Long getRecordsTotal() {
        return recordsTotal;
    }

    public TableResource setRecordsTotal(Long recordsTotal) {
        this.recordsTotal = recordsTotal;
        return this;
    }

    public Long getRecordsFiltered() {
        return recordsFiltered;
    }

    public TableResource setRecordsFiltered(Long recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
        return this;
    }
}