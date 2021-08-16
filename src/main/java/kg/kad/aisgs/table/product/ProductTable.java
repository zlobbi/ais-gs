package kg.kad.aisgs.table.product;

import kg.kad.aisgs.entity.product.Product;
import kg.kad.aisgs.table.core.*;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Component
@Scope("prototype")
public class ProductTable extends AbstractTable {

    private static final long serialVersionUID = -3349641768241689989L;

    private static String BASE_URL = "/api/product/table";
    private String url = "/api/product/table";
    private String title = "product";

    @Override
    protected Class<?> getBaseClass() {
        return Product.class;
    }

    @Override
    protected String getUrl() {
        return url;
    }

    @Override
    protected String getTitle() {
        return title;
    }

    @Override
    protected void initColumns() {
        addColumn("name", true);
        addColumn("unit", false);
        addColumn("description", false);
        addColumn("createdAt", true);
    }

    @Override
    public ProductTable setDropDownButtons(List<DropDownButton> dropDownButtons) {
        this.dropDownButtons = dropDownButtons;
        return this;
    }

    public ProductTable setUrl(String urlSection) {
        this.url = String.format("%s/%s", BASE_URL, urlSection);
        return this;
    }

    @Override
    public ProductTable setButtons(List<Button> buttons) {
        super.setButtons(buttons);
        return this;
    }

    @Override
    public ProductTable setColumns(List<Column> columns) {
        super.setColumns(columns);
        return this;
    }

    @Override
    public ProductTable setFilters(List<Filter> filters) {
        this.filters = filters;
        return this;
    }

    public ProductTable setTitle(String title) {
        this.title = title;
        return this;
    }

    public ProductTable setPageLength(int count) {
        super.setRowsPerPage(count);
        return this;
    }
}
