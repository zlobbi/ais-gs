package kg.kad.aisgs.table.product;

import kg.kad.aisgs.table.core.Column;
import kg.kad.aisgs.table.core.Filter;
import kg.kad.aisgs.table.core.filter.DateRangeFilter;
import kg.kad.aisgs.table.core.filter.TextFilter;
import kg.kad.aisgs.util.MessageHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * created by kadyrbek.mavlyanov@gamil.com
 * 14/8/21
 */
@Service
public class ProductTableBuilder {

    private final static Logger LOGGER = LoggerFactory.getLogger(ProductTableBuilder.class);

    private final ObjectFactory<ProductTable> productTableFactory;

    public ProductTableBuilder(
            ObjectFactory<ProductTable> productTableFactory
    ) {
        this.productTableFactory = productTableFactory;
    }

    public ProductTable getTableAll() {
        return getTable()
                .setTitle(MessageHelper.translate("products.list"));
    }

    private ProductTable getTable() {
        return productTableFactory
                .getObject()
                .setButtons(Collections.emptyList())
                .setDropDownButtons(Collections.emptyList())
                .setColumns(getColumns())
                .setPageLength(20)
                .setFilters(getCommonFilters());
    }

    private List<Column> getColumns() {
        return new ArrayList<>(List.of(
                Column.of("name", true),
                Column.of("unit", false),
                Column.of("description", false),
                Column.of("createdAt", true))
        );
    }

    private List<Filter> getCommonFilters() {
        return new ArrayList<>(List.of(
                TextFilter.of("name", "product.name"),
                DateRangeFilter.of("createdAt", "product.createdAt"))
        );
    }
}
