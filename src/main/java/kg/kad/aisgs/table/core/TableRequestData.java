package kg.kad.aisgs.table.core;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.ArrayList;
import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class TableRequestData {

    private Integer draw;

    private Integer start;

    private Integer length;

    private List<Column> columns;

    private List<Order> order;

    public Integer getDraw() {
        return draw;
    }

    public TableRequestData setDraw(Integer draw) {
        this.draw = draw;
        return this;
    }

    public Integer getStart() {
        return start;
    }

    public TableRequestData setStart(Integer start) {
        this.start = start;
        return this;
    }

    public Integer getLength() {
        return length;
    }

    public TableRequestData setLength(Integer length) {
        this.length = length;
        return this;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public TableRequestData setColumns(List<Column> columns) {
        this.columns = columns;
        return this;
    }

    public List<Order> getOrder() {
        return order;
    }

    public TableRequestData setOrder(List<Order> order) {
        this.order = order;
        return this;
    }

    public Pageable getPageable() {
        Integer page = start / length;

        Sort sort = null;
        if (null != order && !order.isEmpty()) {

            List<Sort.Order> list = new ArrayList<>();
            for (Order o : order) {

                String property = columns.get(o.getColumn()).getName();
                list.add(new Sort.Order(Sort.Direction.fromString(o.getDir()), property, Sort.NullHandling.NULLS_LAST));
            }
            sort = Sort.by(list);
        }

        assert sort != null;
        return PageRequest.of(page, length, sort);
    }
}
